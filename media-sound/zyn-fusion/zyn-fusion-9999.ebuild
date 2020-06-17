# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit git-r3

UV_PV="1.9.1"

DESCRIPTION="Zyn-Fusion User Interface"
HOMEPAGE="https://github.com/mruby-zest/mruby-zest-build"
EGIT_REPO_URI="https://github.com/mruby-zest/mruby-zest-build"
SRC_URI="https://dist.libuv.org/dist/v${UV_PV}/libuv-v${UV_PV}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND=""

# TODO use system libuv and as much libs as possible
# TODO Change /opt/ default (need to check whole source repository)

src_unpack() {
	git-r3_src_unpack
	default_src_unpack
}

src_prepare() {
	ln -s "${WORKDIR}"/libuv-v${UV_PV} deps/
	eapply_user
}

src_compile() {
	emake builddep
	default_src_compile
	emake pack
}

src_install() {
	cd package
	touch qml/MainWindow.qml

	exeinto /opt/${PN}
	doexe zest
	dodir /usr/bin/
	dosym ../../opt/${PN}/zest /usr/bin/${PN}

	insinto /opt/${PN}
	doins -r font qml schema libzest.so
}
