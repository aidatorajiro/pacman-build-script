#!/bin/bash

set -eo pipefail

PKGNAME="$(basename "$1")"

rm -rf "$(pwd)/$PKGNAME-build"
mkdir "$(pwd)/$PKGNAME-build"

pushd "$PKGNAME"
git pull
if [ "$CLEAN" == "1" ]; then
git clean -dfx
fi
popd

pushd build-scripts

docker build -t arch-amd64-builds .

docker run \
  -t \
  --rm \
  -v "$(pwd)/../$PKGNAME:/sourcedata" \
  -v "$(pwd):/build-scripts" \
  -v "$(pwd)/../$PKGNAME-build:/build" \
  -v "$(pwd)/../artifacts:/artifacts" \
  arch-amd64-builds \
  /build-scripts/build-with-req.bash "${@:2}"

mv ../"$PKGNAME"/*.pkg.tar.* ../artifacts

popd

rm -rf "$(pwd)/$PKGNAME-build"

pushd "$PKGNAME"
git pull
if [ "$CLEAN" == "1" ]; then
git clean -dfx
fi
popd
