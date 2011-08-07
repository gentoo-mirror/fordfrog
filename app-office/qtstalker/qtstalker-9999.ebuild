# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/qtstalker/qtstalker-0.36.ebuild,v 1.1 2009/04/26 12:10:33 patrick Exp $

EAPI="4"

ECVS_SERVER="qtstalker.cvs.sourceforge.net:/cvsroot/qtstalker"
ECVS_MODULE="qtstalker"
inherit eutils multilib cvs

DESCRIPTION="Commodity and stock market charting and technical analysis"
HOMEPAGE="http://qtstalker.sourceforge.net"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND=">=sci-libs/ta-lib-0.4.0
	x11-libs/qt-assistant
	x11-libs/qt-core
	x11-libs/qt-gui
	x11-libs/qt-sql
	x11-libs/qwt:5"
IUSE=""

S=${WORKDIR}/${ECVS_MODULE}

src_prepare() {
	ebegin 'Fixing install paths'
	grep -rl '/usr/local' * \
		| xargs sed -i -e "s:/usr/local:/usr:g"
	eend

	ebegin 'Fixing multilib paths'
	grep -rl '/usr/lib' * \
		| xargs sed -i -e "s:/usr/lib:/usr/$(get_libdir):g"
	eend

	ebegin 'Fixing manual paths'
	grep -rl '/usr/share/doc/qtstalker/' * \
		| xargs sed -i -e "s:/usr/share/doc/qtstalker/:/usr/share/doc/${PF}/:g"
	eend

	ebegin 'Fixing qwt paths'
	grep -rl 'qwt-qt4' * \
		| xargs sed -i -e "s:qwt-qt4:qwt5:g"
	eend
}

src_compile() {
	QTDIR=${get_libdir}
	emake -j1 || die "emake failed."
}

src_install() {
	export INSTALL_ROOT="${D}"
	sed -i -e 's:-strip ::g' "${S}"/plugins/quote/*/Makefile
	emake install || die "emake install failed."

	ebegin "Installing docs"
	cd "${S}"/docs
	dohtml *{html,png}
	dodoc AUTHORS BUGS CHANGELOG-* TODO "${S}"/README
	eend

	# menu and icon
	domenu "${FILESDIR}"/${PN}.desktop
	doicon "${FILESDIR}"/${PN}.png
}
