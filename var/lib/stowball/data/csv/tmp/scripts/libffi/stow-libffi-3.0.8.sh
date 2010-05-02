#!/bin/bash
set -o errexit
VERSION='3.0.8'
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
    ${SUDO} make DESTDIR=/${STOW_DIR}/libffi-${VERSION} install
}

do_package () {
    cd /${STOW_DIR}
#    ${SUDO} find ${STOW_DIR}/libffi-${VERSION} -name 'perllocal.pod' -okdir mv -v '{}' perllocal.pod.stow.libffi-${VERSION} ';'
    ${SUDO} tar -cjvf /tmp/libffi-${VERSION}.stow.tar.bz2 libffi-${VERSION}
#     echo "Remember to stow and if installing to /usr/local you may need to run /sbin/ldconfig"
}

do_configure
do_build
do_install
do_package

