#!/bin/bash

set -eo pipefail

PKGNAME="$(basename "$1")"

rm -rf "$(pwd)/$PKGNAME-build"
mkdir "$(pwd)/$PKGNAME-build"

if [ "$CLEAN" == "1" ]; then
pushd "$PKGNAME"
git pull
git clean -dfx
popd
fi

pushd build-scripts

docker build -t arch-amd64-builds .

docker run \
  -t \
  --rm \
  -v "$(pwd)/../$PKGNAME:/sourcedata" \
  -v "$(pwd):/build-scripts" \
  -v "$(pwd)/../$PKGNAME-build:/build" \
  arch-amd64-builds \
  /build-scripts/build.bash

mv ../"$PKGNAME"/*.pkg.tar.* ../artifacts

popd

rm -rf "$(pwd)/$PKGNAME-build"

if [ "$CLEAN" == "1" ]; then
pushd "$PKGNAME"
git pull
git clean -dfx
popd
fi
