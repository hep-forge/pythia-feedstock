#! /usr/bin/bash
set -e

# Bundled config.sub/config.guess predate aarch64 triplets -- replace with
# the current ones from the gnuconfig package before configuring.
for f in config.sub config.guess; do
  find . -name "$f" -exec cp "$BUILD_PREFIX/share/gnuconfig/$f" {} \;
done

# configure takes the OS from $ARCH when it is set, and conda-build sets it to
# the CPU (64, arm64): name the OS, or macOS gets Linux link flags.
./configure --prefix=$PREFIX --arch=$(uname)

NPROC=$(nproc 2>/dev/null || sysctl -n hw.ncpu)
make -j$NPROC
make install
