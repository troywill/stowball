#!/bin/bash
set -o errexit
VERSION='1.0.3'
STOW_DIR='/stow'
PREFIX='/usr'
SUDO='sudo'

do_configure () {
    ./configure --disable-mad --disable-avcodec --disable-avformat --disable-swscale --disable-postproc --disable-a52 --disable-qt4 --disable-skins2 --prefix=${PREFIX}
}

do_build () {
    make
}

do_install () {
    ${SUDO} make DESTDIR=/${STOW_DIR}/vlc-${VERSION} install
}

do_package () {
    cd /${STOW_DIR}
    ${SUDO} tar -cjvf /tmp/vlc-${VERSION}.stow.tar.bz2 vlc-${VERSION}
}

do_configure
do_build
do_install
do_package
