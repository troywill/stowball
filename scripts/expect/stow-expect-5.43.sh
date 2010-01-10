#!/bin/bash
set -o errexit
PACKAGE='expect'
VERSION='5.43'
PACKAGER='TDW'
DATE='2009-11-25'
PREFIX='/usr'
STOW_DIR='/stow'
SUDO='sudo'

do_configure () {
    patch --forward --strip=1 \
	--input=../scripts/expect/expect-5.43.0-tcl_8.5.5_fix-1.patch

    ./configure --prefix=${PREFIX} \
	--with-tcl=/usr/lib \
        --with-tclinclude=/usr/include \
        --enable-shared
}

do_build () {
    make
}

do_install () {
    ${SUDO} make INSTALL_ROOT=${STOW_DIR}/${PACKAGE}-${VERSION} install
#    ${SUDO} ln --symbolic --force ../libexpect5.43.a /usr/lib/expect5.43
}

do_stow () {
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
