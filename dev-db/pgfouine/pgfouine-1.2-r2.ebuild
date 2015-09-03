# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

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

# no idea how to specify that php must have gd OR gd-external enabled
RDEPEND=">=dev-lang/php-4[gd,truetype]"

src_prepare() {
	find -name CVS -type d | xargs rm -fr
	# some logs may contain hints even for non-error log lines
	# this patch disables adding hints to log objects that do not have appendHint() method
	epatch "${FILESDIR}/disable-hints-for-non-errors.patch"
	# PostgreSQL version 9.0 added extra field to csvlog but pgFouine ignores such lines
	# as they have 23 columns and not 22
	# Patch by Matt Saunders: http://pgfoundry.org/forum/forum.php?thread_id=2948&forum_id=555
	epatch "${FILESDIR}/support-9.0-csvlog.patch"
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
