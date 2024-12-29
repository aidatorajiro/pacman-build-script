#!/bin/bash

set -eu -o pipefail

PKGNAME="${1//\//}"

rm -rf "$(pwd)/$PKGNAME-build"
mkdir "$(pwd)/$PKGNAME-build"

pushd "$PKGNAME"
git pull
git clean -dfx
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

cp ../"$PKGNAME"/*.pkg.tar.* ../artifacts

popd

rm -rf "$(pwd)/$PKGNAME-build"

pushd "$PKGNAME"
git pull
git clean -dfx
popd
