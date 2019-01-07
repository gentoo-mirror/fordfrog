# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit flag-o-matic qmake-utils autotools git-r3 gnome2-utils

DESCRIPTION="Qt GUI to control the JACK Audio Connection Kit and ALSA sequencer connections"
HOMEPAGE="http://qjackctl.sourceforge.net/"
EGIT_REPO_URI="https://git.code.sf.net/p/qjackctl/code"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""

IUSE="alsa dbus debug portaudio"

RDEPEND="
	virtual/jack
	app-arch/gzip
	dev-qt/qtcore:5
	dev-qt/qtgui:5
	dev-qt/qtwidgets:5
	dev-qt/qtx11extras:5
	dev-qt/qtxml:5
	alsa? ( media-libs/alsa-lib )
	dbus? ( dev-qt/qtdbus:5 )
	portaudio? ( media-libs/portaudio )"
DEPEND="${RDEPEND}
	dev-qt/linguist-tools:5"

src_prepare() {
	eautoreconf

	default
}

src_configure() {
	append-cxxflags -std=c++11
	econf \
		$(use_enable alsa alsa-seq) \
		$(use_enable dbus) \
		$(use_enable debug) \
		$(use_enable portaudio)

	# Emulate what the Makefile does, so that we can get the correct
	# compiler used.
	eqmake5 ${PN}.pro -o ${PN}.mak
}

src_compile() {
	emake -f ${PN}.mak
}

src_install() {
	default

	gunzip "${D}/usr/share/man/man1/qjackctl.fr.1.gz"
	gunzip "${D}/usr/share/man/man1/qjackctl.1.gz"
}

pkg_postinst() {
	gnome2_icon_cache_update
}

pkg_postrm() {
	gnome2_icon_cache_update
}
