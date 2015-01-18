# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/hugin/hugin-9999.ebuild,v 1.6 2014/12/20 16:36:16 maekke Exp $

EAPI=5

inherit base mercurial qmake-utils

DESCRIPTION="Cloth patternmaking software"
HOMEPAGE="http://valentinaproject.bitbucket.org/"
SRC_URI=""
EHG_REPO_URI="https://bitbucket.org/dismine/valentina"

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
        eqmake5
	mkdir -p ${S}/src/app/bin/translations
	use linguas_cs && lrelease ${S}/share/translations/valentina_cs_CZ.ts -qm ${S}/src/app/bin/translations/valentina_cs_CZ.qm
	use linguas_de && lrelease ${S}/share/translations/valentina_de_DE.ts -qm ${S}/src/app/bin/translations/valentina_de_DE.qm
	use linguas_fr && lrelease ${S}/share/translations/valentina_fr_FR.ts -qm ${S}/src/app/bin/translations/valentina_fr_FR.qm
	use linguas_he && lrelease ${S}/share/translations/valentina_he_IL.ts -qm ${S}/src/app/bin/translations/valentina_he_IL.qm
	use linguas_id && lrelease ${S}/share/translations/valentina_id_ID.ts -qm ${S}/src/app/bin/translations/valentina_id_ID.qm
	use linguas_it && lrelease ${S}/share/translations/valentina_it_IT.ts -qm ${S}/src/app/bin/translations/valentina_it_IT.qm
	use linguas_nl && lrelease ${S}/share/translations/valentina_nl_NL.ts -qm ${S}/src/app/bin/translations/valentina_nl_NL.qm
	use linguas_ru && lrelease ${S}/share/translations/valentina_ru_RU.ts -qm ${S}/src/app/bin/translations/valentina_ru_RU.qm
	use linguas_uk && lrelease ${S}/share/translations/valentina_uk_UA.ts -qm ${S}/src/app/bin/translations/valentina_uk_UA.qm
}

src_install() {
        emake install INSTALL_ROOT="${D}"
	cp -Rv ${S}/src/app/bin/translations ${D}/usr/share/
}
