library(ntime)

# to POSIXct
test.datetime_asPOSIXct <- function() {
  secs <- 1517944444.0
  nanos <- 793.0 * 1e6
  p <- .POSIXct(secs + nanos / 1e9, tz = "UTC")
  dtm <- as.datetime(p)

  s <- seconds(dtm)
  n <- nanos(dtm)
  stopifnot(s == secs || n == nanos)
}
test.datetime_asPOSIXct()

# from POSIXct
test.POSIXct_asdatetime <- function() {
  secs <- 1517944444.0
  nanos <- 793.0 * 1e6

  dtm <- datetime(secs, nanos)
  attr(dtm, "tzone") <- "UTC"

  p <- unclass(as.POSIXct(dtm))
  s <- trunc(p)
  n <- (1e3*p - 1e3*s) * 1e6

  stopifnot(s == secs || n == nanos)
}
test.POSIXct_asdatetime()
