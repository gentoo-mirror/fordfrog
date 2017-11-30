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

	# upstream does not support --disable-static during configuration,
	# just --enable-static=no
	econf \
	$(! has static-libs && echo --enable-static=no)
}

src_compile() {
	emake
	use doc && emake docs
}

src_install() {
	emake DESTDIR="${D}" install

	# for some reason static libs are installed even when disabled in configuration
	# so we have to remove them manually
	! use static-libs && find "${D}" -name "*.la" -delete

	if use doc; then
		dohtml -r doc/html/*
	fi
}
