#!/bin/bash
UNAME=$(uname | tr '[:upper:]' '[:lower:]')
ARCH="$(uname -m)"


rm -rf scetool_build
mkdir scetool_build

cd scetool
make
mv scetool "../scetool_build/scetool_$UNAME_$ARCH"
rm *.o

if [ "$ARCH" == "arm64" ] && [ "$UNAME" == "darwin" ] # TODO: Check if rosetta is installed
then
  echo "==========="
  echo "Building for x64"
  arch -x86_64 make
  mv scetool "../scetool_build/scetool_$UNAME_amd64"
fi
