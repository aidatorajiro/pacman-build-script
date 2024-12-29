FROM archlinux:latest
RUN pacman-key --init
RUN pacman --noconfirm -Syyu
RUN useradd -m myuser
RUN pacman --noconfirm -Sy python-yaml base-devel bc cpio gettext git libelf pahole perl tar xz graphviz imagemagick python-sphinx texlive-latexextra xmlto
RUN echo 'myuser ALL=(ALL:ALL) NOPASSWD: ALL' > /etc/sudoers
