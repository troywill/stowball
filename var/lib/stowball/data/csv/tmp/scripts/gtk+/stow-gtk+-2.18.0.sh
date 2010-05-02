#!/bin/bash
set -o errexit
VERSION='2.18.0'
STOW_DIR='/stow'
PREFIX='/usr'
SUDO='sudo'

do_configure () {
    ./configure --prefix=${PREFIX}
#     perl Makefile.PL PREFIX=${PREFIX}
}

do_build () {
    make
}

do_install () {
    ${SUDO} make DESTDIR=/${STOW_DIR}/gtk+-${VERSION} install
}

do_package () {
    cd /${STOW_DIR}
#    ${SUDO} find ${STOW_DIR}/gtk+-${VERSION} -name 'perllocal.pod' -okdir mv -v '{}' perllocal.pod.stow.gtk+-${VERSION} ';'
    ${SUDO} tar -cjvf /tmp/gtk+-${VERSION}.stow.tar.bz2 gtk+-${VERSION}
#     echo "Remember to stow and if installing to /usr/local you may need to run /sbin/ldconfig"
}

do_configure
do_build
do_install
do_package

