#!/bin/bash
set -o errexit
VERSION='1.6.6'
STOW_DIR='/stow'
PREFIX='/usr'
SUDO='sudo'

do_configure () {
    ./configure --prefix=${PREFIX} --with-ssl
}

do_build () {
    make
}

do_install () {
    ${SUDO} make DESTDIR=/${STOW_DIR}/subversion-${VERSION} install
}

do_package () {
    cd /${STOW_DIR}
    ${SUDO} tar -cjvf /tmp/subversion-${VERSION}.stow.tar.bz2 subversion-${VERSION}
}

do_configure
do_build
do_install
do_package
