#!/bin/bash
set -o errexit
VERSION='20071007'
STOW_DIR='/stow'
PREFIX='/usr'
SUDO='sudo'

do_configure () {
    echo "No configuring necessary"
}

do_build () {
    echo "Nothing to build"
}

do_install () {
    ${SUDO} install -v -d -m755 ${STOW_DIR}/essential-codecs-${VERSION}/usr/lib/mplayer/codecs &&
    ${SUDO} tar -xvf ../essential-20071007.tar.bz2 \
	-C ${STOW_DIR}/essential-codecs-${VERSION}/usr/lib/mplayer/codecs --strip-components=1 &&
    ${SUDO} chown -v -R root:root ${STOW_DIR}/essential-codecs-${VERSION}/usr/lib/mplayer/codecs
}

do_package () {
    cd /${STOW_DIR}
    ${SUDO} tar -cjvf /tmp/essential-codecs-${VERSION}.stow.tar.bz2 essential-codecs-${VERSION}
}

do_configure
do_build
do_install
# do_package
