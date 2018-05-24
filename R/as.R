#
# ntime: nanosecond datetimes
#
# Copyright (C) 2018 Joshua M. Ulrich
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 2 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.
#

# as.*.datetime() and as.datetime.*() functions

# as.datetime generic and methods
as.datetime <-
function(x, ...)
{
  UseMethod("as.datetime")
}

as.datetime.POSIXt <-
function(x, ...)
{
  if (inherits(x, "POSIXlt")) {
    x <- as.POSIXct(x, ...)
  }
  sec <- as.double(x)
  ms <- sec * 1e3 - trunc(sec) * 1e3

  dtm <- datetime(sec, ms * 1e6)
  structure(dtm, tzone = attr(x, "tzone"), class = "datetime")
}

# POSIXt
as.POSIXct.datetime <-
function(x, ...)
{
  p <- seconds(x) + nanos(x) / 1e9
  .POSIXct(p, tz = attr(x, "tzone"))
}

as.character.datetime <-
function(x, ...)
{
  pct <- format(.POSIXct(seconds(x)), "%Y-%m-%d %H:%M:%SNS %Z")
  subsec <- sprintf(".%d", as.integer(nanos(x)))
  dtm <- sub("NS", subsec, pct)
  dtm
}
