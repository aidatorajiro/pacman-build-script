# Simple Pacman Build Script

A simple build script for Arch Linux (currently only AMD64) packages. Thanks to Docker, this script can run in any linux distributions.

I'm planning to add the ARM32/64 building feature, which may be more wanted.

## `docker-arch.bash`

Usage: firstly, create `artifacts/` directory in the top level of this repository. Then, git-clone or download or create a directory that contains PKGBUILD in the same level. Then, just run this script with name of the directory. The built packages are saved in `artifacts/` directory.

Example: `git clone https://aur.archlinux.org/mozc-ut.git && ./docker-arch.bash mozc-ut`

## `docker-arch-with-req.bash`

Usage: same as `docker-arch.bash`, but you can specify prerequisite packages after the second arguments (as the file names in `artifacts/` directory). The first argument is the directory name of the package to be built.

Example: `git clone https://aur.archlinux.org/mozc-ut.git && git clone https://aur.archlinux.org/fcitx5-mozc-ut.git && ./docker-arch.bash mozc-ut && ./docker-arch-with-req.bash fcitx5-mozc-ut 'mozc-ut-<the version name you found in the artifacts directory>-x86_64.pkg.tar.zst'`

## `docker-arch-makepkg-g.bash`

Usage: Run `makepkg -g` (which is the command to calculate hashes for all the downloaded files), rewriting the current `PKGBUILD`. Please provide directory name of the package. The first argument is the directory name of the package to be built.

Example: `./docker-arch-makepkg-g.bash mypackagename`

