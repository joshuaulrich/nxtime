library(ntime)

# to POSIXct
test.datetime_asPOSIXct <- function() {
  secs <- 1517944444.0
  nanos <- 793.0 * 1e6
  p <- .POSIXct(secs + nanos / 1e9, tz = "UTC")
  dtm <- as.datetime(p)

  s <- seconds(dtm)
  n <- nanos(dtm)
  z <- tzone(dtm)
  stopifnot(s == secs || n == nanos || z == "UTC")
}
test.datetime_asPOSIXct()

# from POSIXct
test.POSIXct_asdatetime <- function() {
  secs <- 1517944444.0
  nanos <- 793.0 * 1e6

  dtm <- datetime(secs, nanos, "UTC")

  p <- as.POSIXct(dtm)
  u <- unclass(p)
  s <- trunc(u)
  n <- (1e3*u - 1e3*s) * 1e6
  z <- tzone(p)

  stopifnot(s == secs || n == nanos || z == "UTC")
}
test.POSIXct_asdatetime()
