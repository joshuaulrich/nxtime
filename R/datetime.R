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
datetime <-
function(secs, nanos = 0, tzone = NULL)
{
  # ensure secs and nanos are the same length
  slen <- length(secs)
  nlen <- length(nanos)
  if (slen != nlen) {
    mlen <- max(slen, nlen)
    if (slen != mlen) secs <- rep(secs, length.out = mlen)
    if (nlen != mlen) nanos <- rep(nanos, length.out = mlen)
  }

  tm <- .Call("ntime_datetime", secs, nanos, package = "ntime")
  if (is.null(tzone)) {
    tzone <- Sys.getenv("TZ")
  }
  structure(tm, tzone = tzone, class = "datetime")
}

nanos <-
function(datetime)
{
  .Call("ntime_get_nanos", datetime, PACKAGE = "ntime")
}

seconds <-
function(datetime)
{
  .Call("ntime_get_seconds", datetime, PACKAGE = "ntime")
}

tzone <-
function(datetime)
{
  # FIXME: Should this be generic?
  attr(datetime, "tzone")
}
