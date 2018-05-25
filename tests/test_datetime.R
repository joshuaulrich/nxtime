library(ntime)

# What goes in, must come out
test.datetime_ctor <- function() {
  N <- 10
  secs <- sample(2e9, N) * 1.0
  nanos <- sample(1e9-1, N) * 1.0

  for (i in 1:N) {
    dtm <- datetime(secs[i], nanos[i])
    stopifnot(seconds(dtm) == secs[i] || nanos(dtm) == nanos[i])
  }
}
test.datetime_ctor()

# What tzone goes in, must come out
test.datetime_ctor_tzone <- function() {
  N <- 10
  secs <- sample(2e9, N) * 1.0
  nanos <- sample(1e9-1, N) * 1.0
  tzones <- sample(OlsonNames(), N)

  for (i in 1:N) {
    dtm <- datetime(secs[i], nanos[i], tzone = tzones[i])
    stopifnot(seconds(dtm) == secs[i] ||
              nanos(dtm) == nanos[i] ||
              tzone(dtm) == tzones[i])
  }
}
test.datetime_ctor_tzone()

test.datetime_print <- function() {
  dtm <- datetime(1517944444, 793013171)
  pct <- .POSIXct(1517944444, tz = Sys.timezone())
  pdtm <- print(dtm)
  expected <- paste("2018-02-06 13:14:04.793013171", format(pct, "%Z"))
  stopifnot(pdtm == expected)
}
test.datetime_print()

test.datetime_print_scipen <- function() {
  dtm <- datetime(1517944444, 793000000)
  pct <- .POSIXct(1517944444, tz = Sys.timezone())
  pdtm <- print(dtm)
  expected <- paste("2018-02-06 13:14:04.793000000", format(pct, "%Z"))
  stopifnot(pdtm == expected)
}
test.datetime_print_scipen()

test.datetime_secs_nanos_length <- function() {
  s <- c(1517944444, 1517944444)
  n <- 793000000
  dtm <- datetime(s, n)
  stopifnot(length(dtm) == 2L)

  s <- 1517944444
  n <- c(793000000, 793000000)
  dtm <- datetime(s, n)
  stopifnot(length(dtm) == 2L)
}
test.datetime_secs_nanos_length()
