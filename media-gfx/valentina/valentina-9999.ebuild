# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit base mercurial qmake-utils

DESCRIPTION="Cloth patternmaking software"
HOMEPAGE="http://valentinaproject.bitbucket.org/"
SRC_URI=""
EHG_REPO_URI="https://bitbucket.org/dismine/valentina"
EHG_REVISION="develop"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS=""

IUSE="linguas_cs linguas_de linguas_fr linguas_he linguas_id linguas_it linguas_nl linguas_ru linguas_uk"

CDEPEND="
	app-text/poppler
	dev-qt/qtcore:5
	dev-qt/qtprintsupport:5
	dev-qt/qtsvg:5
	dev-qt/qtwidgets:5
	dev-qt/qtxml:5
	dev-qt/qtxmlpatterns:5"
RDEPEND="${CDEPEND}"
DEPEND="${CDEPEND}
	dev-util/ccache"

src_configure() {
	eqmake5 -r
}

src_install() {
	emake install INSTALL_ROOT="${D}"
}
