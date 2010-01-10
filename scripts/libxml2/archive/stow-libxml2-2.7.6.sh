#!/bin/bash
set -o errexit
VERSION='2.7.6'
STOW_DIR='/stow'
PREFIX='/usr'
SUDO='sudo'
# Verified by TDW <troydwill@gmail.com> on 2009-10-27
# See http://www.linuxfromscratch.org/blfs/view/svn/general/libxml2.html

do_configure () {
    ./configure --prefix=${PREFIX}
}

do_build () {
    make
}

do_install () {
    ${SUDO} make DESTDIR=/${STOW_DIR}/libxml2-${VERSION} install
}

do_package () {
    cd /${STOW_DIR}
#    ${SUDO} find ${STOW_DIR}/libxml2-${VERSION} -name 'perllocal.pod' -okdir mv -v '{}' perllocal.pod.stow.libxml2-${VERSION} ';'
    ${SUDO} tar -cjvf /tmp/libxml2-${VERSION}.stow.tar.bz2 libxml2-${VERSION}
#     echo "Remember to stow and if installing to /usr/local you may need to run /sbin/ldconfig"
}

do_configure
do_build
do_install
do_package

