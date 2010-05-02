#!/bin/bash
set -o errexit
PACKAGE='shared-mime-info'
VERSION='0.60'
PACKAGER='TDW'
DATE='2009-11-22'
PREFIX='/usr'
STOW_DIR='/stow'
SUDO='sudo'

export CFLAGS='-march=native -Os'

do_configure () {
    ./configure --prefix=${PREFIX}
}

do_build () {
    make
}

do_install () {
    ${SUDO} make DESTDIR=${STOW_DIR}/${PACKAGE}-${VERSION} install
}

do_stow () {
    ${SUDO} stow -v ${PACKAGE}-${VERSION}
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
do_package

exit

Configuration of shared-mime-info 0.60:

Optional Features:
  --disable-option-checking  ignore unrecognized --enable/--with options
  --disable-FEATURE       do not include FEATURE (same as --enable-FEATURE=no)
  --enable-FEATURE[=ARG]  include FEATURE [ARG=yes]
  --disable-dependency-tracking  speeds up one-time build
  --enable-dependency-tracking   do not reject slow dependency extractors
  --disable-nls           do not use Native Language Support
  --disable-update-mimedb disable the update-mime-database after install
                          default=no

Some influential environment variables:
  CC          C compiler command
  CFLAGS      C compiler flags
  LDFLAGS     linker flags, e.g. -L<lib dir> if you have libraries in a
              nonstandard directory <lib dir>
  LIBS        libraries to pass to the linker, e.g. -l<library>
  CPPFLAGS    C/C++/Objective C preprocessor flags, e.g. -I<include dir> if
              you have headers in a nonstandard directory <include dir>
  CPP         C preprocessor
  PKG_CONFIG  path to pkg-config utility
  ALL_CFLAGS  C compiler flags for ALL, overriding pkg-config
  ALL_LIBS    linker flags for ALL, overriding pkg-config
  GIO_CFLAGS  C compiler flags for GIO, overriding pkg-config
  GIO_LIBS    linker flags for GIO, overriding pkg-config

Use these variables to override the choices made by `configure' or to help
it to find libraries and programs with nonstandard names/locations.

Report bugs to <https://bugs.freedesktop.org/enter_bug.cgi?product=shared-mime-info>.
