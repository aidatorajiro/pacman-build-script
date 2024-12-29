#!/bin/bash

set -eu -o pipefail

rm -rf "$(pwd)/$1-build"
mkdir "$(pwd)/$1-build"

pushd "$1"
git pull
git clean -dfx
popd

pushd build-scripts

docker build -t arch-amd64-builds .

docker run \
  -t \
  --rm \
  -v "$(pwd)/../$1:/sourcedata" \
  -v "$(pwd):/build-scripts" \
  -v "$(pwd)/../$1-build:/build" \
  -v "$(pwd)/../artifacts:/artifacts" \
  arch-amd64-builds \
  /build-scripts/build-with-req.sh "${@:2}"

cp ../"$1"/*.pkg.tar.* ../artifacts

popd

rm -rf "$(pwd)/$1-build"

pushd "$1"
git pull
git clean -dfx
popd
