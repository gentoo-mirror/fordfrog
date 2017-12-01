# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6
inherit subversion

DESCRIPTION="C++ library for the Linux Sampler control protocol"
HOMEPAGE="http://www.linuxsampler.org"
ESVN_REPO_URI="https://svn.linuxsampler.org/svn/liblscp/trunk"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS=""
IUSE="doc static-libs"

RDEPEND=""
DEPEND="doc? ( app-doc/doxygen )"

DOCS=( AUTHORS ChangeLog TODO NEWS README )

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

	if use doc; then
		dohtml -r doc/html/*
	fi
}
