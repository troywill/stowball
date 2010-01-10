#!/bin/bash
set -o errexit
PACKAGE='giflib'
VERSION='4.1.6'
PACKAGER='TDW'
PREFIX='/usr'
STOW_DIR='/stow'
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
    ${SUDO} stow -c ${PACKAGE}-${VERSION}
}

do_package () {
    ${SUDO} tar -cjf /tmp/${PACKAGE}-${VERSION}.stow.tar.bz2 ${PACKAGE}-${VERSION}
}

do_configure
do_build
do_install
do_stow
do_package
