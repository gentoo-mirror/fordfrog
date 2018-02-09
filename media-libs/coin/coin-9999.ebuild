# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit cmake-utils mercurial

MY_P=${P/c/C}

DESCRIPTION="A high-level 3D graphics toolkit, fully compatible with SGI Open Inventor 2.1"
HOMEPAGE="https://bitbucket.org/Coin3D/coin/wiki/Home"

COIN_REPO_URI="https://bitbucket.org/Coin3D/coin"
GENERALMSVCGENERATION_REPO_URI="https://bitbucket.org/Coin3D/generalmsvcgeneration"
BOOSTHEADERLIBSFULL_REPO_URI="https://bitbucket.org/Coin3D/boost-header-libs-full"

LICENSE="|| ( GPL-2 PEL )"
KEYWORDS=""
SLOT="0"
IUSE="+3ds-import doc +dragger +javascript +manipulator +nodekit +openal +simage static-libs threads +vrml97"

# NOTE: expat is not really needed as --enable-system-expat is broken
# avi, guile, jpeg2000, pic, rgb, tga, xwd not added (did not find where the support is)
RDEPEND="
	app-arch/bzip2
	dev-libs/expat
	media-libs/fontconfig
	media-libs/freetype:2
	sys-libs/zlib
	virtual/opengl
	virtual/glu
	x11-libs/libICE
	x11-libs/libSM
	x11-libs/libX11
	x11-libs/libXext
	javascript? ( dev-lang/spidermonkey:0 )
	openal? ( media-libs/openal )
	simage? ( media-libs/simage )
"
DEPEND="${RDEPEND}
	virtual/pkgconfig
	x11-proto/xextproto
	doc? ( app-doc/doxygen )
"
S="${WORKDIR}/${MY_P}"

PATCHES=(
	"${FILESDIR}"/${PN}-3.1.3-pkgconfig-partial.patch
	"${FILESDIR}"/${PN}-3.1.3-gcc-4.7.patch
	"${FILESDIR}"/${PN}-3.1.3-freetype251.patch
)

DOCS=(
	AUTHORS FAQ FAQ.legal NEWS README RELNOTES THANKS
	docs/{HACKING,oiki-launch.txt}
)

src_unpack() {
	EHG_REPO_URI=${GENERALMSVCGENERATION_REPO_URI}
	EHG_CHECKOUT_DIR="${WORKDIR}/generalmsvcgeneration"
	mercurial_fetch

	EHG_REPO_URI=${BOOSTHEADERLIBSFULL_REPO_URI}
	EHG_CHECKOUT_DIR="${WORKDIR}/boost-header-libs-full"
	mercurial_fetch

	EHG_REPO_URI=${COIN_REPO_URI}
	EHG_CHECKOUT_DIR="${S}"
	EHG_REVISION="CMake"
	mercurial_fetch
}

src_configure() {
	local mycmakeargs=(
		-DHAVE_3DS_IMPORT_CAPABILITIES=$(usex 3ds-import YES NO)
		-DHAVE_MAN=$(usex doc YES NO)
		-DHAVE_DRAGGERS=$(usex dragger YES NO)
		-DCOIN_HAVE_JAVASCRIPT=$(usex javascript YES NO)
		-DHAVE_MANIPULATORS=$(usex manipulator YES NO)
		-DHAVE_NODEKITS=$(usex nodekit YES NO)
		-DHAVE_SOUND=$(usex openal YES NO)
		-DSIMAGE_RUNTIME_LINKING=$(usex simage YES NO)
		-DCOIN_THREADSAFE=$(usex threads YES NO)
		-DHAVE_VRML97=$(usex vrml97 YES NO)
	)

	cmake-utils_src_configure
}
