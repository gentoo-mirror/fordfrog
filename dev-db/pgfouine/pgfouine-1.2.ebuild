# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-benchmarks/phoronix-test-suite/phoronix-test-suite-2.8.1-r1.ebuild,v 1.1 2011/02/01 21:50:49 cardoe Exp $

EAPI=4

inherit eutils

DESCRIPTION="pgFouine is a PostgreSQL log analyzer used to generate detailed reports from a PostgreSQL log file"
HOMEPAGE="http://pgfouine.projects.postgresql.org/"
SRC_URI="http://pgfoundry.org/frs/download.php/2575/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""

# php 5.3 doesn't have pcre useflag anymore
RDEPEND=">=dev-lang/php-4"

src_prepare() {
	find -name CVS -type d | xargs rm -fr
}

src_configure() {
	:
}

src_compile() {
	:
}

src_install() {
	dodir /usr/share/${PN}
	insinto /usr/share/${PN}
	doins *.php
	doins -r include

	dodoc AUTHORS ChangeLog INSTALL README RELEASE THANKS pgfouine.spec

	dosym /usr/share/${PN}/${PN}.php /usr/bin/${PN}
	dosym /usr/share/${PN}/${PN}_vacuum.php /usr/bin/${PN}_vacuum

	fperms 555 /usr/share/${PN}/${PN}.php
	fperms 555 /usr/share/${PN}/${PN}_vacuum.php
}
