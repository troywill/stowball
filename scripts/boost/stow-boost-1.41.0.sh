#!/bin/bash
set -o errexit
PACKAGE='boost'
VERSION='1.41.0'
PACKAGER='TDW'
DATE='2009-11-22'
STOW_DIR='/stow'
PREFIX='/usr'
SUDO='sudo'
PREFIX=${STOW_DIR}/${PACKAGE}-${VERSION}/${PREFIX}

export CFLAGS='-march=native -Os'

do_configure () {
    ./bootstrap.sh --prefix=${PREFIX}
}

do_build () {
    echo 'No operation'
}

do_install () {
    ${SUDO} ./bjam install
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

See http://www.boost.org/doc/libs/1_41_0/more/getting_started/unix-variants.html <TDW 2009-11-23>
./bootstrap.sh --help
`./bootstrap.sh' prepares Boost for building on a few kinds of systems.

Usage: ./bootstrap.sh [OPTION]... 

Defaults for the options are specified in brackets.

Configuration:
  -h, --help                display this help and exit
  --with-bjam=BJAM          use existing Boost.Jam executable (bjam)
                            [automatically built]
  --with-toolset=TOOLSET    use specific Boost.Build toolset
                            [automatically detected]
  --show-libraries          show the set of libraries that require build
                            and installation steps (i.e., those libraries
                            that can be used with --with-libraries or
                            --without-libraries), then exit
  --with-libraries=list     build only a particular set of libraries,
                            describing using either a comma-separated list of
                            library names or "all"
                            [all]
  --without-libraries=list  build all libraries except the ones listed []
  --with-icu                enable Unicode/ICU support in Regex 
                            [automatically detected]
  --without-icu             disable Unicode/ICU support in Regex
  --with-icu=DIR            specify the root of the ICU library installation
                            and enable Unicode/ICU support in Regex
                            [automatically detected]
  --with-python=PYTHON      specify the Python executable [python]
  --with-python-root=DIR    specify the root of the Python installation
                            [automatically detected]
  --with-python-version=X.Y specify the Python version as X.Y
                            [automatically detected]

Installation directories:
  --prefix=PREFIX           install Boost into the given PREFIX
                            [/usr/local]
  --exec-prefix=EPREFIX     install Boost binaries into the given EPREFIX
                            [PREFIX]

More precise control over installation directories:
  --libdir=DIR              install libraries here [EPREFIX/lib]
  --includedir=DIR          install headers here [PREFIX/include]

