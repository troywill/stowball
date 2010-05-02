#!/bin/bash
set -o errexit
PACKAGE="kdelibs"
VERSION="4.3.4"
PACKAGER="TDW <troydwill@gmail.com>"
DATE="2009-12-12"
PREFIX="/usr"
TARGET="/"
STOW_DIR="/stow"
SUDO="sudo"

PACKAGE_DIR=${PACKAGE}-${VERSION}

do_configure () {
    mkdir --parent --verbose ../kdelibs-build
    cd ../kdelibs-build
    pwd
    ls ../${PACKAGE}-${VERSION}
    cmake -DCMAKE_INSTALL_PREFIX:PATH=${PREFIX} ../${PACKAGE}-${VERSION} 2>&1 | tee log.stow.configure
    cd -
}

do_build () {
    cd ../kdelibs-build
    make 2>&1 | tee log.stow.make
    cd -
}

do_install () {
    cd ../kdelibs-build
    ${SUDO} make DESTDIR=${STOW_DIR}/${PACKAGE_DIR} install 2>&1 | tee log.stow.install
    cd -
}

do_stow () {
    ${SUDO} stow --verbose --target=${TARGET} --dir=${STOW_DIR} ${PACKAGE_DIR}
}

do_poststow () {
    echo "run makeinfo"
}

do_package () {
    cd /tmp
    ${SUDO} tar -jcf ${PACKAGE_DIR}.stow.tar.bz2 ${STOW_DIR}${PACKAGE_DIR}
}

do_configure
do_build
do_install
do_stow
do_poststow
# do_package
exit

KDE4 uses the CMake (http://www.cmake.org) buildsystem instead of configure.
CMake uses different options than configure, but some have direct equivalents:
   <srcdir>           : the source directory
   --prefix=<dir>     : -DCMAKE_INSTALL_PREFIX:PATH=<dir>
   --bindir=<dir>     : -DBIN_INSTALL_DIR:PATH=<dir>
   --includedir=<dir> : -DINCLUDE_INSTALL_DIR:PATH=<dir>
   --libdir=<dir>     : -DLIB_INSTALL_DIR:PATH=<dir>
Once CMake has run successfully, you can use "make edit_cache" to view and modify all settings.
For more information visit "http://techbase.kde.org/Development/Tutorials/CMake#Run_CMake"

Your current configure options translate more or less to:
   cmake . ; make ; make install
