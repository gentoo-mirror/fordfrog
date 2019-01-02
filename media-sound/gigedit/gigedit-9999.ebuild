# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6
inherit eutils subversion

DESCRIPTION="GigaSampler instrument file editor"
HOMEPAGE="http://www.linuxsampler.org/"
ESVN_REPO_URI="https://svn.linuxsampler.org/svn/gigedit/trunk"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE="doc static-libs"

RDEPEND="dev-cpp/gtkmm:3.0
	media-libs/libgig
	media-libs/libsndfile"
DEPEND="${RDEPEND}
	>=dev-util/intltool-0.35.0
	sys-devel/gettext
	virtual/pkgconfig
	doc? ( app-doc/doxygen )"

DOCS=( AUTHORS ChangeLog NEWS README )
PATCHES=( "${FILESDIR}/${P}-gtkmm-3.24.patch")

src_configure() {
	emake -f Makefile.svn

	econf \
		$(! has static-libs && echo --enable-static=no)
}

src_compile() {
	default

	use doc && emake docs
}

src_install() {
	default

	! use static-libs && prune_libtool_files --modules
}
