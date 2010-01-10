#!/bin/bash
set -o errexit
PACKAGE='cmake'
VERSION='2.8.0'
PACKAGER='TDW'
PREFIX='/usr'
STOW_DIR='/stow'
SUDO='sudo'

export CFLAGS='-march=native -Os'

do_configure () {
    ./bootstrap --prefix=${PREFIX} --docdir=/share/doc/CMake --mandir=/share/man 2>&1 | tee log.stow.configure
}

do_build () {
    make 2>&1 | tee log.stow.make
}

do_install () {
    ${SUDO} make DESTDIR=${STOW_DIR}/${PACKAGE}-${VERSION} install 2>&1 | tee log.stow.install
}

do_stow () {
    ${SUDO} stow -v ${PACKAGE}-${VERSION} 2>&1 | tee log.stow.stow
    ${SUDO} stow -v ${PACKAGE}-${VERSION}
    ${SUDO} stow -c ${PACKAGE}-${VERSION}
}

do_package () {
    ${SUDO} tar -cjf /tmp/${PACKAGE}-${VERSION}.stow.tar.bz2 ${STOW_DIR}/${PACKAGE}-${VERSION}
}

do_configure
do_build
do_install
do_stow
do_package

exit

Usage: /home/troy/rcs/Stowball/cmake-2.8.0/bootstrap [options]
Options: [defaults in brackets after descriptions]
Configuration:
  --help                  print this message
  --version               only print version information
  --verbose               display more information
  --parallel=n            bootstrap cmake in parallel, where n is
                          number of nodes [1]
  --init=FILE             use FILE for cmake initialization
  --system-libs           use system-installed third-party libraries
                          (for use only by package maintainers)
  --no-system-libs        use cmake-provided third-party libraries
                          (default)
  --qt-gui                build the Qt-based GUI (requires Qt >= 4.2)
  --no-qt-gui             do not build the Qt-based GUI (default)
  --qt-qmake=<qmake>      use <qmake> as the qmake executable to find Qt

Directory and file names:
  --prefix=PREFIX         install files in tree rooted at PREFIX
                          [${cmake_default_prefix}]
  --datadir=DIR           install data files in PREFIX/DIR [/share/CMake]
  --docdir=DIR            install documentation files in PREFIX/DIR [/doc/CMake]
  --mandir=DIR            install man pages files in PREFIX/DIR/manN
                          [/man]

