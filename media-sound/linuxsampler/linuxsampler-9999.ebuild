# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit eutils subversion

DESCRIPTION="LinuxSampler is a software audio sampler engine with professional grade features"
HOMEPAGE="http://www.linuxsampler.org/"
ESVN_REPO_URI="https://svn.linuxsampler.org/svn/linuxsampler/trunk"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
# it also supports vst but it's masked in the tree at this moment
IUSE="alsa doc jack sf2 sqlite static-libs"
REQUIRED_USE="|| ( alsa jack )"

RDEPEND=">media-libs/libgig-4
	media-libs/libsndfile
	alsa? ( media-libs/alsa-lib )
	jack? ( virtual/jack )
	sqlite? ( >=dev-db/sqlite-3.3 )"
DEPEND="${RDEPEND}
	virtual/pkgconfig
	doc? ( app-doc/doxygen )"

DOCS=( AUTHORS ChangeLog NEWS README )

src_configure() {
	emake -f Makefile.svn

	econf \
		$(use_enable alsa alsa-driver) \
		--disable-arts-driver \
		$(use_enable jack jack-driver) \
		$(use_enable sqlite instruments-db) \
		$(use_enable sf2 sf2-engine) \
		$(! has static-libs && echo --enable-static=no)
}

src_compile() {
	default

	use doc && emake docs
}

src_install() {
	default

	# For liblinuxsampler.so to be found at runtime
	printf "LDPATH=\"${EPREFIX}/usr/$(get_libdir)/linuxsampler/\"" > 99${PN}
	doenvd "99${PN}"

	! use static-libs && prune_libtool_files --modules
}
