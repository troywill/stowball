#!/bin/bash
set -o errexit
VERSION='0.6.5'
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
    ${SUDO} make DESTDIR=/${STOW_DIR}/gobject-introspection-${VERSION} install
}

do_package () {
    cd /${STOW_DIR}
    ${SUDO} tar -cjvf /tmp/gobject-introspection-${VERSION}.stow.tar.bz2 gobject-introspection-${VERSION}
}

do_configure
do_build
do_install
do_package
