# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python2_7 )
PYTHON_REQ_USE="threads(+)"

[[ "${PV}" = "9999" ]] && inherit git-r3
inherit waf-utils python-any-r1

DESCRIPTION="A simple Linux Guitar Amplifier for jack with one input and two outputs"
HOMEPAGE="http://guitarix.org/"

RESTRICT="mirror"
if [ "${PV}" = "9999" ]; then
	EGIT_REPO_URI="https://git.code.sf.net/p/guitarix/git/"
	S="${S}/trunk"
	KEYWORDS=""
else
	SRC_URI="mirror://sourceforge/guitarix/guitarix/${P}.tar.bz2"
	S="${WORKDIR}/guitarix-${PV}"
	KEYWORDS="~amd64 ~x86"
fi

SLOT="0"
LICENSE="GPL-2"

IUSE="avahi debug faust ladspa lv2 nls"

CDEPEND="
	dev-cpp/eigen:3
	dev-cpp/glibmm:2
	dev-cpp/gtkmm:2.4
	dev-libs/boost
	dev-libs/glib
	dev-libs/libsigc++:2
	media-libs/liblrdf
	media-libs/libsndfile
	media-libs/lilv:0
	media-libs/zita-convolver
	media-libs/zita-resampler
	net-libs/webkit-gtk:=
	sci-libs/fftw:3.0
	virtual/jack
	x11-libs/gtk+:2
	avahi? ( net-dns/avahi )
	faust? ( dev-lang/faust )
	ladspa? ( media-libs/ladspa-sdk )
	lv2? ( media-libs/lv2 )"
DEPEND="${CDEPEND}
	virtual/pkgconfig
	nls? ( dev-util/intltool )"
RDEPEND="${CDEPEND}"

DOCS=( changelog README )

src_configure() {
	local mywafconfargs=(
		--cxxflags-debug=""
		--cxxflags-release="-DNDEBUG"
		--nocache
		--shared-lib
		--lib-dev
		--no-ldconfig
		--no-desktop-update
		$(use_enable nls)
		$(usex avahi "" --no-avahi)
		$(usex debug --debug "")
		$(usex faust --faust --no-faust)
		$(usex ladspa --ladspadir="${EPREFIX}"/usr/share/ladspa "--no-ladspa --no-new-ladspa")
		$(usex lv2 --lv2dir="${EPREFIX}"/usr/$(get_libdir)/lv2 --no-lv2)
	)

	waf-utils_src_configure ${mywafconfargs[@]}
}
