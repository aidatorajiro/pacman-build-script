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
  arch-amd64-builds \
  /bin/bash -c 'cd /build-scripts && ./build.sh'

cp ../"$1"/*.pkg.tar.* ../artifacts

popd

rm -rf "$(pwd)/$1-build"

pushd "$1"
git pull
git clean -dfx
popd
