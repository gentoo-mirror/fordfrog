# Copyright 1999-2018 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit cmake-utils git-r3 multilib
RESTRICT="mirror"

DESCRIPTION="ZynAddSubFX is an opensource software synthesizer."
HOMEPAGE="http://zynaddsubfx.sourceforge.net/"
SRC_URI="http://download.tuxfamily.org/proaudio/distfiles/zynaddsubfx-presets-0.1.tar.bz2"

EGIT_REPO_URI="git://git.code.sf.net/p/zynaddsubfx/code"
EGIT_SUBMODULES=( '*' )

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE="oss alsa dssi fltk jack jackmidi lash +ntk portaudio"
# upstream the following preference ntk -> fltk; we waant to choose the GUI:
REQUIRED_USE="?? ( fltk ntk )"

RDEPEND="
	sci-libs/fftw:3.0
	alsa? ( media-libs/alsa-lib )
	dssi? ( media-libs/dssi )
	fltk? ( >=x11-libs/fltk-1.3:1 )
	jack? ( virtual/jack )
	jackmidi? ( virtual/jack )
	lash? ( virtual/liblash )
	ntk? ( x11-libs/ntk )
	portaudio? ( media-libs/portaudio )"
DEPEND="!media-libs/zynaddsubfx-banks
	!media-sound/zynaddsubfx-cvs
	virtual/pkgconfig"

PATCHES=(
	"${FILESDIR}/gnustd.diff"
	"${FILESDIR}/${P}-docs.patch"
	"${FILESDIR}/${P}-bashcomp.patch"
)

src_unpack() {
	git-r3_src_unpack
	unpack "zynaddsubfx-presets-0.1.tar.bz2"
}

src_configure() {
	# overide upstream GUI preference
	MYGUI="off"
	use fltk && MYGUI="fltk"
	use ntk && MYGUI="ntk"

	mycmakeargs=(
		-DGuiModule="${MYGUI}"
		`use alsa && echo "-DAlsaEnable=TRUE" || echo "-DAlsaEnable=FALSE"`
		`use jack && echo "-DJackEnable=TRUE" || echo "-DJackEnable=FALSE"`
		`use oss && echo "-DOssEnable=TRUE" || echo "-DOssEnable=FALSE"`
		`use portaudio && echo "-DPaEnable=TRUE" || echo "-DPaEnable=FALSE"`
		`use lash && echo "-DLashEnable=TRUE" || echo "-DLashEnable=FALSE"`
		`use dssi && echo "-DDssiEnable=TRUE" || echo "-DDssiEnable=FALSE"`
		`use lash && echo "-DLashEnable=TRUE" || echo "-DLashEnable=FALSE"`
		-DPluginLibDir=$(get_libdir)
	)
	cmake-utils_src_configure
}

src_compile() {
	cmake-utils_src_compile
	cd "${S}"/ExternalPrograms/Spliter
	emake
	cd "${S}"/ExternalPrograms/Controller
	emake
}

src_install() {
	cmake-utils_src_install

	# -------- install examples presets
##	[ "${#MY_PN}" == "0" ] && MY_PN="${PN}"
	insinto /usr/share/${PN}/presets
	doins "${WORKDIR}/presets/"*
	insinto /usr/share/${PN}/examples
	doins "${WORKDIR}/examples/"*
	doins "${S}/instruments/examples/"*
	# --------
}

pkg_postinst() {
	einfo "Banks are now provided with this package"
	einfo "To get some nice sounding parameters emerge zynaddsubfx-extras"
}
