#!/bin/bash
set -o errexit
PACKAGE='ntp'
VERSION='4.2.4p7'
PACKAGER='TDW'
DATE='2009-11-25'
PREFIX='/usr'
STOW_DIR='/stow'
SUDO='sudo'

do_patch () {
    patch --forward --strip=1 --input=../scripts/ntp/ntp-4.2.4p7-mod_nano-1.patch
}

do_configure () {
    ./configure --prefix=${PREFIX} --sysconfdir=/etc \
            --with-binsubdir=sbin
}

do_build () {
    make
}

do_install () {
    ${SUDO} make DESTDIR=${STOW_DIR}/${PACKAGE}-${VERSION} install
}

do_stow () {
    ${SUDO} find ${STOW_DIR}/${PACKAGE}-${VERSION} -name 'dir' -okdir mv -v '{}' dir.stow.${PACKAGE}-${VERSION} ';'
    ${SUDO} find ${STOW_DIR}/${PACKAGE}-${VERSION} -name 'perllocal.pod' -okdir mv -v '{}' perllocal.pod.stow.${PACKAGE}-${VERSION} ';'
    ${SUDO} stow -v ${PACKAGE}-${VERSION}
    ${SUDO} stow -c ${PACKAGE}-${VERSION}
}

do_package () {
    cd /tmp
    ${SUDO} tar -jcf ${PACKAGE}-${VERSION}.stow.tar.bz2 ${STOW_DIR}${PACKAGE}-${VERSION}
}

do_patch
do_configure
do_build
do_install
do_stow
# do_package
exit
