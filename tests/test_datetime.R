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

test.datetime_print <- function() {
  dtm <- datetime(1517944444, 793013171)
  pdtm <- print(dtm)
  expected <- paste("2018-02-06 13:14:04.793013171", format(Sys.time(), "%Z"))
  stopifnot(pdtm == expected)
}
test.datetime_print()

test.datetime_print_scipen <- function() {
  dtm <- datetime(1517944444, 793000000)
  pdtm <- print(dtm)
  expected <- paste("2018-02-06 13:14:04.793000000", format(Sys.time(), "%Z"))
  stopifnot(pdtm == expected)
}
test.datetime_print_scipen()
