#!/bin/bash
set -o errexit
VERSION='3.6.20'
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
    ${SUDO} make DESTDIR=/${STOW_DIR}/sqlite-${VERSION} install
}

do_package () {
    cd /${STOW_DIR}
    ${SUDO} tar -cjvf /tmp/sqlite-${VERSION}.stow.tar.bz2 sqlite-${VERSION}
}

do_configure
do_build
do_install
do_package
