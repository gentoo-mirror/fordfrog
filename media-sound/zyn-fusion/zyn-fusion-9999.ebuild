# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit git-r3

DESCRIPTION="Zyn-Fusion User Interface"
HOMEPAGE="https://github.com/mruby-zest/mruby-zest-build"
EGIT_REPO_URI="https://github.com/mruby-zest/mruby-zest-build"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND="dev-libs/libuv
	x11-libs/libX11
	x11-libs/libxcb"
RDEPEND="${DEPEND}"
BDEPEND=""

# TODO Use gentoo custom "FLAGS" (makefile and rake file)
# TODO allow binary, library and data installation in standard path

src_prepare() {
	# Unbundle libuv: makefile and rake file
	sed -i -e "s%./deps/\$(UV_DIR)/.libs/libuv.a%`pkg-config --libs libuv`%" \
		-e 's%-I ../../deps/\$(UV_DIR)/include%-I /usr/include/uv/%' Makefile
	sed -i -e "/deps\/libuv.a/s/<< .*/<< \"`pkg-config --libs libuv`\"/" \
		-e 's%../deps/libuv-v1.9.1/include/%usr/include/uv/%' build_config.rb
	eapply_user
}

src_compile() {
	default_src_compile
	emake pack
}

src_install() {
	cd package

	exeinto /opt/${PN}
	doexe zest
	dodir /usr/bin/
	dosym ../../opt/${PN}/zest /usr/bin/${PN}

	insinto /opt/${PN}
	doins -r font qml schema libzest.so
}
