# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit mercurial qmake-utils

DESCRIPTION="Cloth patternmaking software"
HOMEPAGE="http://valentinaproject.bitbucket.org/"
SRC_URI=""
EHG_REPO_URI="https://bitbucket.org/dismine/valentina"
EHG_REVISION="develop"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"

# en_IN not supported in Gentoo so not added here
IUSE="linguas_cs_CZ
	linguas_de_DE
	linguas_en_CA
	linguas_en_US
	linguas_es_ES
	linguas_fi_FI
	linguas_fr_FR
	linguas_he_IL
	linguas_id_ID
	linguas_it_IT
	linguas_nl_NL
	linguas_ro_RO
	linguas_ru_RU
	linguas_uk_UA
	linguas_zh_CN"

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
