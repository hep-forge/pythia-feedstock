#! /usr/bin/bash
set -ex

mkdir -p "$PREFIX/lib" "$PREFIX/include/pythia6"

# PYTHIA 6 has no build system of its own -- compile the single monolithic
# Fortran source straight into a shared library. Default gfortran symbol
# mangling (lowercase + trailing underscore) matches what ROOT's TPythia6
# interface and other downstream consumers expect.
if [ "$(uname)" = "Darwin" ]; then
  SHARED_FLAG="-dynamiclib"
else
  SHARED_FLAG="-shared"
fi

"$FC" $SHARED_FLAG -fPIC -O2 -fno-second-underscore -o "$PREFIX/lib/libpythia6${SHLIB_EXT}" pythia*.f

cp pythia*.f "$PREFIX/include/pythia6/"
