#!/bin/bash
set -o errexit
PACKAGE='Sub-Exporter'
VERSION='0.982'
PACKAGER='TDW'
DATE='2009-11-25'
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
