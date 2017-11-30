# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6
inherit subversion gnome2-utils xdg-utils

DESCRIPTION="A graphical frontend to the LinuxSampler engine"
HOMEPAGE="https://qsampler.sourceforge.io http://www.linuxsampler.org/"
ESVN_REPO_URI="https://svn.linuxsampler.org/svn/qsampler/trunk"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE="doc +gig +xunique"

RDEPEND="
	app-arch/bzip2
	dev-libs/double-conversion
	dev-libs/expat
	dev-libs/glib
	dev-libs/libpcre
	dev-libs/libpcre2
	dev-qt/qtcore:5
	dev-qt/qtgui:5
	dev-qt/qtwidgets:5
	dev-qt/qtx11extras:5
	media-gfx/graphite2
	media-libs/freetype
	media-libs/harfbuzz
	media-libs/liblscp
	media-libs/libpng:=
	sys-apps/util-linux
	dev-libs/icu:=
	sys-libs/zlib
	virtual/opengl
	gig? ( media-libs/libgig )"
DEPEND="${RDEPEND}
	virtual/pkgconfig
	doc? ( app-doc/doxygen )"

DOCS=( AUTHORS ChangeLog README )

src_configure() {
	emake -f Makefile.svn

	# upstream does not support --disable-static during configuration,
	# just --enable-static=no
	econf \
		--enable-qt4=no \
		--with-qt5=/usr/$(get_libdir)/qt5 \
		$(use_enable gig libgig) \
		$(use_enable xunique xunique)
}

src_compile() {
	emake
	use doc && emake docs
}

pkg_postinst() {
	gnome2_icon_cache_update
	xdg_mimeinfo_database_update
}

pkg_postrm() {
	gnome2_icon_cache_update
	xdg_mimeinfo_database_update
}
