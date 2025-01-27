FROM archlinux:latest
RUN pacman-key --init
RUN pacman-key --populate
RUN pacman --noconfirm -Sy archlinux-keyring
RUN pacman --noconfirm -Syu
RUN useradd -m myuser
RUN pacman --noconfirm -Sy python-yaml base-devel bc cpio gettext git libelf pahole perl tar xz graphviz imagemagick python-sphinx texlive-latexextra xmlto pacman-contrib
RUN echo 'myuser ALL=(ALL:ALL) NOPASSWD: ALL' > /etc/sudoers
