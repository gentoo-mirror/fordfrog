# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="3"
inherit eutils

DESCRIPTION="Netbeans IDE"
HOMEPAGE="http://netbeans.org/"
LICENSE="|| ( CDDL GPL-2-with-linking-exception )"
SLOT="7.0"
KEYWORDS="~amd64 ~x86"

IUSE_NETBEANS_MODULES="
	+netbeans_modules_apisupport
	netbeans_modules_cnd
	netbeans_modules_dlight
	netbeans_modules_enterprise
	netbeans_modules_ergonomics
	netbeans_modules_groovy
	+netbeans_modules_java
	netbeans_modules_javacard
	netbeans_modules_mobility
	netbeans_modules_php
	netbeans_modules_profiler
	+netbeans_modules_websvccommon"
IUSE_LINGUAS="
        linguas_af
        linguas_ar
        linguas_ca
        linguas_cs
        linguas_de
        linguas_el
        linguas_es
        linguas_fr
        linguas_gl
        linguas_hi_IN
        linguas_id
        linguas_it
        linguas_ja
        linguas_ko
        linguas_lt
        linguas_nl
        linguas_pl
        linguas_pt_BR
        linguas_pt_PT
        linguas_ro
        linguas_ru
        linguas_sq
        linguas_sr
        linguas_sv
        linguas_tl
        linguas_tr
        linguas_vi
        linguas_zh_CN
        linguas_zh_TW"
IUSE="doc ${IUSE_NETBEANS_MODULES} ${IUSE_LINGUAS}"

DEPEND=""
RDEPEND="~dev-java/netbeans-harness-${PV}
	~dev-java/netbeans-ide-${PV}
	~dev-java/netbeans-nb-${PV}
	~dev-java/netbeans-platform-${PV}
	netbeans_modules_apisupport? ( ~dev-java/netbeans-apisupport-${PV} )
	netbeans_modules_cnd? ( ~dev-java/netbeans-cnd-${PV} )
	netbeans_modules_dlight? ( ~dev-java/netbeans-dlight-${PV} )
	netbeans_modules_enterprise? ( ~dev-java/netbeans-enterprise-${PV} )
	netbeans_modules_ergonomics? ( ~dev-java/netbeans-ergonomics-${PV} )
	netbeans_modules_groovy? ( ~dev-java/netbeans-groovy-${PV} )
	netbeans_modules_java? ( ~dev-java/netbeans-java-${PV} )
	netbeans_modules_javacard? ( ~dev-java/netbeans-javacard-${PV} )
	netbeans_modules_mobility? ( ~dev-java/netbeans-mobility-${PV} )
	netbeans_modules_php? ( ~dev-java/netbeans-php-${PV} )
	netbeans_modules_profiler? ( ~dev-java/netbeans-profiler-${PV} )
	netbeans_modules_websvccommon? ( ~dev-java/netbeans-websvccommon-${PV} )
	doc? ( ~dev-java/netbeans-javadoc-${PV} )"
