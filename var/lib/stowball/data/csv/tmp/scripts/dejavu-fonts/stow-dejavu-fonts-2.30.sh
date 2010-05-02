#!/bin/bash
set -o errexit
PACKAGE='dejavu-fonts'
VERSION='2.30'
PACKAGER='TDW'
PREFIX='/usr'
STOW_DIR='/stow'
SUDO='sudo'
HINTS_DIR='/usr/etc/fonts/conf.d'

do_configure () {
    echo 'No operation'
}

do_build () {
    echo 'No operation'
}

do_install () {
    ${SUDO} mkdir -v --parent ${STOW_DIR}/${PACKAGE}-${VERSION}/usr/share/fonts
    ${SUDO} cp ttf/* ${STOW_DIR}/${PACKAGE}-${VERSION}/usr/share/fonts/
    ${SUDO} mkdir -v --parent ${STOW_DIR}/${PACKAGE}-${VERSION}/${HINTS_DIR}
    ${SUDO} cp fontconfig/* ${STOW_DIR}/${PACKAGE}-${VERSION}/${HINTS_DIR}
}

do_stow () {
    cd /${STOW_DIR}
    ${SUDO} stow -v ${PACKAGE}-${VERSION}
    ${SUDO} stow -v ${PACKAGE}-${VERSION}
    ${SUDO} stow -c ${PACKAGE}-${VERSION}
}

do_package () {
    ${SUDO} tar -cjf /tmp/${PACKAGE}-${VERSION}.stow.tar.bz2 ${PACKAGE}-${VERSION}
}

do_configure
do_build
do_install
do_stow
do_package
