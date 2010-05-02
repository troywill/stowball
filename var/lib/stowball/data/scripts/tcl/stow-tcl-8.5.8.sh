#!/bin/bash
set -o errexit
PACKAGE='tcl'
VERSION='8.5.8'
PACKAGER='TDW'
DATE='2009-11-25'
PREFIX='/usr'
STOW_DIR='/stow'
SUDO='sudo'

# export CFLAGS='-march=native -Os'

do_configure () {
    cd unix
    ./configure --prefix=${PREFIX} --enable-threads --mandir=${PREFIX}/share/man
    cd -
}

do_build () {
    cd unix
    make
    # sed --in-place \
    # 	--expression= "s@^\(TCL_SRC_DIR='\).*@\1/usr/include'@" \
    # 	--expression= "/TCL_B/s@='\(-L\)\?.*unix@='\1/usr/lib@" \
    # 	--expression= "/SEARCH/s/=.*/=''/" \
    # 	tclConfig.sh
    cd -
}

do_install () {
    cd unix
    ${SUDO} make DESTDIR=${STOW_DIR}/${PACKAGE}-${VERSION} install
    ${SUDO} make install-private-headers
    ${SUDO} ln --verbose --force --symbolic tclsh8.5 /usr/bin/tclsh
    cd -
}

do_stow () {
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
