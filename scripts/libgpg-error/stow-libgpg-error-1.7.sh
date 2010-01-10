#!/bin/bash
set -o errexit
VERSION='1.7'
PACKAGE='libgpg-error'
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
    ${SUDO} make DESTDIR=${STOW_DIR}/${PACKAGE}-${VERSION} install
}

do_stow () {
    cd /${STOW_DIR}
    ${SUDO} stow -v ${PACKAGE}-${VERSION}
    ${SUDO} stow -v ${PACKAGE}-${VERSION}
}

do_package () {
    ${SUDO} tar -cjvf /tmp/${PACKAGE}-${VERSION}.stow.tar.bz2 ${PACKAGE}-${VERSION}
}

do_configure
do_build
do_install
do_stow
do_package
