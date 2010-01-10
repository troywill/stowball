#!/bin/bash
set -o errexit
VERSION='1.12'
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
    ${SUDO} make DESTDIR=/stow/wget-${VERSION} install
}

do_package () {
    cd /stow
    ${SUDO} tar -cjvf /tmp/wget-${VERSION}.stow.tar.bz2 wget-${VERSION}
#     echo "Remember to stow and if installing to /usr/local you may need to run /sbin/ldconfig"
}

do_configure
do_build
do_install
do_package

