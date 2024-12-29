#!/bin/bash

pacman --noconfirm -Syyu

cd /artifacts
pacman --noconfirm -U "$@"

cd /sourcedata
CORES=$(echo $(nproc --all)/2 | bc)
su myuser -c "MAKEFLAGS=-j$CORES BUILDDIR=/build makepkg --noconfirm -s"
