#!/bin/bash
set -o errexit
VERSION='1.24.5'
STOW_DIR='/stow'
PREFIX='/usr'
SUDO='sudo'

do_configure () {
    ./configure --prefix=${PREFIX}
}

do_build () {
    make
}

do_install () {
    ${SUDO} make DESTDIR=/${STOW_DIR}/pango-${VERSION} install
}

do_package () {
    cd /${STOW_DIR}
    ${SUDO} tar -cjvf /tmp/pango-${VERSION}.stow.tar.bz2 pango-${VERSION}
}

do_configure
do_build
do_install
do_package
