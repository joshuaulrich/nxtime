/*
 * ntime: nanosecond datetimes
 *
 * Copyright (C) 2018 Joshua M. Ulrich
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */
#include <stdint.h>
#include <R.h>
#include <Rinternals.h>

static const int64_t ns_per_s = 1000000000LL;

SEXP
ntime_datetime(SEXP _ss, SEXP _ns)
{
  if (TYPEOF(_ss) != REALSXP || TYPEOF(_ns) != REALSXP) {
    error("both arguments to ntime_datetime must be double");
  }

  int i, n = LENGTH(_ss);

  if (n != LENGTH(_ns)) {
    error("both arguments to ntime_datetime must be the same length");
  }

  SEXP _y = PROTECT(allocVector(REALSXP, n));
  int64_t *y = (int64_t *)REAL(_y);

  double *ss = REAL(_ss);
  double *ns = REAL(_ns);
  for (i = 0; i < n; i++) {
    y[i] = ((int64_t)ss[i]) * ns_per_s + (int64_t)ns[i];
  }

  UNPROTECT(1);
  return _y;
}

SEXP
ntime_get_nanos(SEXP _x)
{
  int i, n = LENGTH(_x);

  SEXP _y = PROTECT(allocVector(REALSXP, n));
  double *y = REAL(_y);

  int64_t *x = (int64_t *)REAL(_x);
  for (i = 0; i < n; i++) {
    /* FIXME: this does not account for negative x */
    y[i] = (double)(x[i] % ns_per_s);
//Rprintf("ns: %lli\n", x[i] % 1000000000LL);
  }

  UNPROTECT(1);
  return _y;
}

SEXP
ntime_get_seconds(SEXP _x)
{
  int i, n = LENGTH(_x);

  SEXP _y = PROTECT(allocVector(INTSXP, n));
  int *y = INTEGER(_y);

  int64_t *x = (int64_t *)REAL(_x);
  for (i = 0; i < n; i++) {
    y[i] = (int)(x[i] / ns_per_s);
//Rprintf("sec: %lli\n", x[i] / 1000000000LL);
  }

  UNPROTECT(1);
  return _y;
}
