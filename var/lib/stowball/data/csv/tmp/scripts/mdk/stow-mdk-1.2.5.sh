#!/bin/bash
set -o errexit
# Untested <troydwill@gmail.com> Sunday, October 25 2009
PACKAGE='mdk'
VERSION='1.2.5'
PACKAGER='TDW'
DATE='2009-11-22'
PREFIX='/usr'
STOW_DIR='/stow'
SUDO='sudo'

# export CFLAGS='-march=native -Os'

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
    ${SUDO} find ${STOW_DIR}/${PACKAGE}-${VERSION} -name 'dir' -okdir mv -v '{}' dir.stow.${PACKAGE}-${VERSION} ';'
    ${SUDO} stow -v ${PACKAGE}-${VERSION}
    ${SUDO} stow -v ${PACKAGE}-${VERSION}
    ${SUDO} stow -c ${PACKAGE}-${VERSION}
}

do_package () {
    cd /tmp
    ${SUDO} tar -jcf ${PACKAGE}-${VERSION}.stow.tar.bz2 ${STOW_DIR}${PACKAGE}-${VERSION}
}

do_configure
do_build
do_install
do_stow
# do_package

exit
