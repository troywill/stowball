#!/bin/bash
# 2009-11-18 TDW <troydwill@gmail.com>
set -o errexit
VERSION='0.9.8l'
STOW_DIR='/stow'
PREFIX='/usr'
SUDO='sudo'

do_configure () {
    ./config --prefix=${PREFIX} --openssldir=/etc/ssl shared zlib-dynamic
}

do_build () {
    make
}

do_install () {
    ${SUDO} make INSTALL_PREFIX=/${STOW_DIR}/openssl-${VERSION} install
}

do_package () {
    cd /${STOW_DIR}
    ${SUDO} tar -cjvf /tmp/openssl-${VERSION}.stow.tar.bz2 openssl-${VERSION}
}

do_configure
do_build
do_install
do_package

