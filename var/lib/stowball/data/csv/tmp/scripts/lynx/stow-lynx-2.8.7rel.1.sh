#!/bin/bash
set -o errexit
PACKAGE='lynx'
VERSION='2.8.7rel.1'
PACKAGER='TDW'
DATE='2009-11-25'
PREFIX='/usr'
STOW_DIR='/stow'
SUDO='sudo'

# export CFLAGS='-march=native -Os'

do_configure () {
    ./configure --prefix=${PREFIX} \
        --sysconfdir=/etc/lynx \
        --datadir=/usr/share/doc/${PACKAGE}-${VERSION} \
        --with-zlib \
        --with-bzlib \
        --with-screen=ncursesw \
        --enable-locale-charset
}

do_build () {
    make
}

do_install () {
    ${SUDO} make DESTDIR=${STOW_DIR}/${PACKAGE}-${VERSION} install
}

do_stow () {
    ${SUDO} stow -v ${PACKAGE}-${VERSION}
    ${SUDO} stow -c ${PACKAGE}-${VERSION}
    # This command corrects the improper group ownership of installed documentation files.
    ${SUDO} chgrp -v -R root /usr/share/doc/${PACKAGE}-${VERSION}/lynx_doc
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
