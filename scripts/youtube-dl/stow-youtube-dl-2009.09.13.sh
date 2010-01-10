#!/bin/bash
set -o errexit
VERSION='2009.09.13'
STOW_DIR='/stow'
PREFIX='/usr'
SUDO='sudo'

do_install () {
    
    ${SUDO} install -v -d ${STOW_DIR}/youtube-dl-${VERSION}/usr/bin/
    ${SUDO} install -v --mode=0755 youtube-dl ${STOW_DIR}/youtube-dl-${VERSION}/usr/bin/
}

do_package () {
    cd /${STOW_DIR}
    ${SUDO} tar -cjvf /tmp/youtube-dl-${VERSION}.stow.tar.bz2 youtube-dl-${VERSION}
}

do_install
do_package
