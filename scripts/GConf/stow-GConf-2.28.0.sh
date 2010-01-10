#!/bin/bash
set -o errexit
VERSION='2.28.0'
STOW_DIR='/stow'
PREFIX='/usr'
SUDO='sudo'

do_configure () {
    ./configure --prefix=${PREFIX}
}

do_build () {
    make > stow.log 2>&1
}

do_install () {
    ${SUDO} make DESTDIR=/${STOW_DIR}/GConf-${VERSION} install
}

do_package () {
    cd /${STOW_DIR}
    ${SUDO} tar -cjvf /tmp/GConf-${VERSION}.stow.tar.bz2 GConf-${VERSION}
}

do_configure
do_build
do_install
do_package
