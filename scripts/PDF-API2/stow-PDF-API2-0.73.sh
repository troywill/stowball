#!/bin/bash
set -o errexit
PACKAGE='PDF-API2'
VERSION='0.73'
PACKAGER='TDW'
DATE='2009-12-08'
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
    ${SUDO} find ${STOW_DIR}/${PACKAGE}-${VERSION} -name 'perllocal.pod' -okdir mv -v '{}' perllocal.pod.stow.${PACKAGE}-${VERSION} ';'
    ${SUDO} stow -v ${PACKAGE}-${VERSION}
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
