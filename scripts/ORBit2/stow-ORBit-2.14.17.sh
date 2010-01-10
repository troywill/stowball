#!/bin/bash
set -o errexit
VERSION='2.14.17'
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
    ${SUDO} make DESTDIR=/${STOW_DIR}/ORBit-${VERSION} install
}

do_package () {
    cd /${STOW_DIR}
    ${SUDO} tar -cjvf /tmp/ORBit-${VERSION}.stow.tar.bz2 ORBit-${VERSION}
}

do_configure
do_build
do_install
do_package
