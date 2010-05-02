#!/bin/bash
set -o errexit
PACKAGE='perltidy'
VERSION='20090616'
PACKAGER='TDW'
PREFIX='/usr'
STOW_DIR='/stow'
SUDO='sudo'

do_configure () {
    perl Makefile.PL PREFIX=${PREFIX}
}

do_build () {
    make
}

do_install () {
    ${SUDO} make DESTDIR=${STOW_DIR}/${PACKAGE}-${VERSION} install
}

do_stow () {
    cd /${STOW_DIR}
    ${SUDO} find ${STOW_DIR}/${PACKAGE}-${VERSION} -name 'perllocal.pod' -okdir mv -v '{}' perllocal.pod.stow.${PACKAGE}-${VERSION} ';'
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
