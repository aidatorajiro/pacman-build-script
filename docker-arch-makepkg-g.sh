#!/bin/bash

set -eu -o pipefail

pushd build-scripts

docker build -t arch-amd64-builds .

docker run \
  -t \
  --rm \
  -v "$(pwd)/../$1:/sourcedata" \
  -v "$(pwd):/build-scripts" \
  arch-amd64-builds \
  /bin/bash -c "cd /build-scripts && ./console.sh \"bash -c 'makepkg -g >> PKGBUILD'\""

popd

