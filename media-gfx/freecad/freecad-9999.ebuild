# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

# As of 2017-12-30 only python3_5 works (that is FreeCAD does not crash on startup)
PYTHON_COMPAT=( python3_6 )

inherit cmake-utils eutils xdg-utils gnome2-utils fortran-2 python-single-r1

DESCRIPTION="QT based Computer Aided Design application"
HOMEPAGE="http://www.freecadweb.org/"

if [[ ${PV} == *9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/FreeCAD/FreeCAD.git"
else
	SRC_URI="https://github.com/FreeCAD/FreeCAD/archive/${PV}.tar.gz -> ${P}.tar.gz
		doc? ( https://github.com/FreeCAD/FreeCAD/releases/download/0.18.1/FreeCAD.${MY_PV}.Quick.Reference.Guide.7z -> ${P}.Quick.Reference.Guide.7z )"
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="GPL-2"
SLOT="0"

# Takem from CMakeLists.txt
# TODO:
#   vr: needs a rift package
IUSE_FREECAD_MODULES="
	+freecad_modules_addonmgr
	+freecad_modules_arch
	freecad_modules_assembly
	freecad_modules_complete
	+freecad_modules_draft
	+freecad_modules_drawing
	+freecad_modules_fem
	freecad_modules_flat_mesh
	+freecad_modules_idf
	+freecad_modules_image
	+freecad_modules_import
	+freecad_modules_inspection
	freecad_modules_jtreader
	+freecad_modules_material
	+freecad_modules_mesh
	+freecad_modules_mesh_part
	+freecad_modules_openscad
	+freecad_modules_part
	+freecad_modules_part_design
	+freecad_modules_path
	freecad_modules_plot
	+freecad_modules_points
	+freecad_modules_raytracing
	+freecad_modules_reverseengineering
	+freecad_modules_robot
	freecad_modules_sandbox
	freecad_modules_ship
	+freecad_modules_show
	+freecad_modules_sketcher
	+freecad_modules_spreadsheet
	+freecad_modules_start
	+freecad_modules_surface
	+freecad_modules_techdraw
	freecad_modules_template
	+freecad_modules_test
	+freecad_modules_tux
	+freecad_modules_web"
IUSE="doc eigen3 +freetype +qt5 swig ${IUSE_FREECAD_MODULES}"

# TODO:
#   DEPEND and RDEPEND:
#		salomesmesh - science overlay
#		zipio++ - not in portage yet
COMMON_DEPEND="
	${PYTHON_DEPS}
	dev-java/xerces
	dev-libs/boost:=[python,${PYTHON_USEDEP}]
	dev-libs/xerces-c[icu]
	sci-libs/orocos_kdl
	sci-libs/opencascade[vtk(+)]
	sys-libs/zlib
	virtual/glu
	eigen3? ( dev-cpp/eigen:3 )
	freecad_modules_draft? ( dev-python/pyside:2[svg,${PYTHON_USEDEP}] )
	freecad_modules_fem? (
		sci-libs/hdf5
		sci-libs/libmed[fortran,${PYTHON_USEDEP}]
		virtual/mpi[cxx]
	)
	freecad_modules_plot? ( dev-python/matplotlib[${PYTHON_USEDEP}] )
	freetype? ( media-libs/freetype )
	qt5? (
		dev-libs/libspnav
		dev-python/pyside:2[${PYTHON_USEDEP}]
		dev-python/shiboken:2[${PYTHON_USEDEP}]
		dev-qt/qtconcurrent:5
		dev-qt/qtcore:5
		dev-qt/qtnetwork:5
		dev-qt/qtopengl:5
		dev-qt/qtprintsupport:5
		dev-qt/qtsvg:5
		dev-qt/qtxml:5
		dev-qt/qtwebkit:5
		media-libs/coin
	)
	!qt5? (
		dev-python/pyside:0[${PYTHON_USEDEP}]
		dev-python/shiboken:0[${PYTHON_USEDEP}]
	)"
RDEPEND="${COMMON_DEPEND}
	dev-python/numpy[${PYTHON_USEDEP}]
	dev-python/pivy[${PYTHON_USEDEP}]"
DEPEND="${COMMON_DEPEND}
	qt5? ( dev-python/pyside-tools:2[${PYTHON_USEDEP}] )
	!qt5? ( dev-python/pyside-tools:0[${PYTHON_USEDEP}] )
	swig? ( dev-lang/swig:= )"

REQUIRED_USE="${PYTHON_REQUIRED_USE}"

PATCHES=(
	"${FILESDIR}"/${P}-install-paths.patch
)

DOCS=( README.md ChangeLog.txt )

enable_module() {
	local module=${1}
	local value=${2}

	if [ -z "${value}" ]; then
		value=$(use freecad_modules_${module} && echo ON || echo OFF)
	fi

	echo "-DBUILD_${module^^}=${value}"
}

pkg_setup() {
	fortran-2_pkg_setup
	python-single-r1_pkg_setup

	[[ -z ${CASROOT} ]] && die "empty \$CASROOT, run eselect opencascade set or define otherwise"
}

src_configure() {
	local occ=$(basename ${CASROOT})
	local occ_type
	local occ_include
	local occ_lib

	occ=${occ%-*}

	case ${occ} in
	oce)
		occ_type="Community Edition"
		occ_include=/usr/include/oce
		occ_lib=/usr/$(get_libdir)/libTKernel.so
		;;
	opencascade)
		occ_type="Official Version"
		occ_include="${CASROOT}"/include/opencascade
		occ_lib="${CASROOT}"/lib/libTKernel.so
		;;
	*)
		die "Unsupported occ: ${occ}"
		;;
	esac

	einfo "OCC: ${occ_type}"
	einfo "  OCC_INCLUDE_DIR=${occ_include}"
	einfo "  OCC_LIBRARY_DIR=${occ_lib}"

	# TODO
	# FREECAD_USE_EXTERNAL_ZIPIOS="ON": needs zipois++ which is not in tree yet
	# FREECAD_USE_EXTERNAL_SMESH="ON": needs salome-smash which is not in tree yet
	#-DOCC_* defined with cMake/FindOpenCasCade.cmake
	# VR module not included here as we do not support it
	local mycmakeargs=(
		-DFREECAD_USE_OCC_VARIANT="\"${occ_type}\""
		-DOCC_INCLUDE_DIR=${occ_include}
		-DOCC_LIBRARY=${occ_lib}
		-DCMAKE_INSTALL_DATADIR=/usr/share/${P}
		-DCMAKE_INSTALL_DOCDIR=/usr/share/doc/${PF}
		-DCMAKE_INSTALL_INCLUDEDIR=/usr/include/${P}
		-DCMAKE_INSTALL_PREFIX=/usr/$(get_libdir)/${PN}
		-DCMAKE_INSTALL_DOCDIR=/usr/share/doc/${PF}
		-DFREECAD_USE_EXTERNAL_KDL="ON"
		-DBUILD_QT5="$(usex qt5)"
		-DBUILD_GUI="$(usex qt5)"
		-DBUILD_FREETYPE="$(usex freetype)"
		-DOPENMPI_INCLUDE_DIRS=/usr/include/
		$(use qt5 && echo "-DCOIN3D_DOC_TAGFILE=/usr/share/doc/Coin/html/Coin.tag.bz2")
		$(use qt5 && echo "-DCOIN3D_DOC_PATH=/usr/share/doc/Coin/html/")
		$(enable_module addonmgr)
		$(enable_module arch)
		$(enable_module assembly)
		$(enable_module complete)
		$(enable_module draft)
		$(enable_module drawing)
		$(enable_module fem)
		$(enable_module flat_mesh)
		$(enable_module idf)
		$(enable_module image)
		$(enable_module import)
		$(enable_module inspection)
		$(enable_module jtreader)
		$(enable_module material)
		$(enable_module mesh)
		$(enable_module mesh_part)
		$(enable_module openscad)
		$(enable_module part)
		$(enable_module part_design)
		$(enable_module path)
		$(enable_module plot)
		$(enable_module points)
		$(enable_module raytracing)
		$(enable_module reverseengineering)
		$(enable_module robot)
		$(enable_module sandbox)
		$(enable_module ship)
		$(enable_module show)
		$(enable_module sketcher)
		$(enable_module spreadsheet)
		$(enable_module start)
		$(enable_module surface)
		$(enable_module techdraw)
		$(enable_module template)
		$(enable_module test)
		$(enable_module tux)
		$(enable_module web)
	)

	cmake-utils_src_configure
	einfo "${P} will be built against opencascade version ${CASROOT}"
}

src_install() {
	cmake-utils_src_install

	dosym ../$(get_libdir)/${PN}/bin/FreeCAD /usr/bin/FreeCAD
	dosym ../$(get_libdir)/${PN}/bin/FreeCADCmd /usr/bin/FreeCADCmd

	make_desktop_entry FreeCAD "FreeCAD" "" "" "MimeType=application/x-extension-fcstd;"

	# install mimetype for FreeCAD files
	insinto /usr/share/mime/packages
	newins "${FILESDIR}"/${PN}.sharedmimeinfo "${PN}.xml"
	insinto /usr/share/pixmaps
	newins "${S}"/src/Gui/Icons/${PN}.xpm "${PN}.xpm"

	# install icons to correct place rather than /usr/share/freecad
	pushd "${ED%/}"/usr/share/${P} || die
	local size
	for size in 16 32 48 64; do
		newicon -s ${size} freecad-icon-${size}.png freecad.png
	done
	doicon -s scalable freecad.svg
	newicon -s 64 -c mimetypes freecad-doc.png application-x-extension-fcstd.png
	popd || die

	if use doc; then
		cp -r "${WORKDIR}/FreeCAD 0_18 Quick Reference Guide" "${ED}/usr/share/doc/${PF}" || die
	fi

	python_optimize "${ED%/}"/usr/{$(get_libdir)/${PN},share/${P}}/Mod/
}

pkg_postinst() {
	gnome2_icon_cache_update
	xdg_desktop_database_update
	xdg_mimeinfo_database_update
}

pkg_postrm() {
	xdg_mimeinfo_database_update
	xdg_desktop_database_update
	gnome2_icon_cache_update
}
