#!/bin/bash
set -o errexit
VERSION='3.1.4'
PREFIX='/usr'
SUDO='sudo'

do_build () {
    make PREFIX=/usr ZLIB=no
    ${SUDO} make PREFIX=/usr DESTDIR=/stow/pciutils-${VERSION} install
    ${SUDO} make PREFIX=/usr DESTDIR=/stow/pciutils-${VERSION} install-lib
}

do_package () {
    cd /stow
    ${SUDO} tar -cjvf pciutils-${VERSION}.stow.tar.bz2 pciutils-${VERSION}
    ${SUDO} mkdir --parent STOWBALLS
    ${SUDO} mv --verbose pciutils-${VERSION}.stow.tar.bz2 STOWBALLS
    echo "Remember to stow and if installing to /usr/local you may need to run /sbin/ldconfig"
}

do_build
do_package
