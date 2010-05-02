#!/bin/bash
set -o errexit
VERSION='1.75.2'
STOW_DIR='/stow'
PREFIX='/usr'
SUDO='sudo'

do_install () {
    ${SUDO} install -v -m755 -d ${STOW_DIR}/dockbook-xsl-1.75.2/usr/share/xml/docbook/xsl-stylesheets-1.75.2 &&
    ${SUDO} cp -v -R VERSION common eclipse extensions fo highlighting html \
        htmlhelp images javahelp lib manpages params profiling \
        slides template tools website xhtml                    \
	${STOW_DIR}/dockbook-xsl-1.75.2/usr/share/xml/docbook/xsl-stylesheets-1.75.2 &&
    ${SUDO} install -v -m644 -D README \
        ${STOW_DIR}/dockbook-xsl-1.75.2/usr/share/doc/docbook-xsl-1.75.2/README.XSL &&
    ${SUDO} install -v -m755    RELEASE-NOTES* NEWS* \
        ${STOW_DIR}/dockbook-xsl-1.75.2/usr/share/doc/docbook-xsl-1.75.2

}

do_package () {
    cd /${STOW_DIR}
#    ${SUDO} tar -cjvf /tmp/docbook-xsl-1.75.2.stow.tar.bz2 docbook-xsl-1.75.2
}

do_configure () {
    if [ ! -d /etc/xml ]; then ${SUDO} install -v -m755 -d /etc/xml; fi &&
    if [ ! -f /etc/xml/catalog ]; then
	${SUDO} xmlcatalog --noout --create /etc/xml/catalog
    fi &&
    
    ${SUDO} xmlcatalog --noout --add "rewriteSystem" \
        "http://docbook.sourceforge.net/release/xsl/1.75.2" \
        "/usr/share/xml/docbook/xsl-stylesheets-1.75.2" \
	/etc/xml/catalog &&
    
    ${SUDO} xmlcatalog --noout --add "rewriteURI" \
        "http://docbook.sourceforge.net/release/xsl/1.75.2" \
        "/usr/share/xml/docbook/xsl-stylesheets-1.75.2" \
	/etc/xml/catalog &&
    
    ${SUDO} xmlcatalog --noout --add "rewriteSystem" \
        "http://docbook.sourceforge.net/release/xsl/current" \
        "/usr/share/xml/docbook/xsl-stylesheets-1.75.2" \
	/etc/xml/catalog &&
    
    ${SUDO} xmlcatalog --noout --add "rewriteURI" \
        "http://docbook.sourceforge.net/release/xsl/current" \
        "/usr/share/xml/docbook/xsl-stylesheets-1.75.2" \
	/etc/xml/catalog
}

do_install
do_package
do_configure
