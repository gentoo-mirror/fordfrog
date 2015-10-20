# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5
JAVA_PKG_IUSE="doc source"
WANT_ANT_TASKS="ant-ivy:2"

inherit eutils java-pkg-2 java-ant-2
DESCRIPTION="Apache Lucene Core"
HOMEPAGE="http://lucene.apache.org/core/"
SRC_URI="mirror://apache/lucene/java/${PV}/lucene-${PV}-src.tgz
	http://dev.gentoo.org/~fordfrog/distfiles/lucene-5-build.patch.bz2
	doc? ( http://dev.gentoo.org/~fordfrog/distfiles/lucene-java7-package-list.bz2 )"
LICENSE="Apache-2.0"
SLOT="5"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=virtual/jdk-1.7
	doc? ( app-arch/unzip )"
RDEPEND=">=virtual/jre-1.7"

S=${WORKDIR}/lucene-${PV}

EANT_BUILD_XML="core/build.xml"
EANT_BUILD_TARGET="jar-core"
EANT_DOC_TARGET="javadocs"

java_prepare() {
	epatch "${WORKDIR}/lucene-5-build.patch"

	if use doc ; then
		mkdir tools/javadoc/java7 || die "failed to create dir"
		mv "${WORKDIR}/lucene-java7-package-list" tools/javadoc/java7/package-list || die "failed to move file"
	fi
}

src_install() {
	java-pkg_newjar build/core/lucene-core-${PV}-SNAPSHOT.jar ${PN}.jar

	if use doc ; then
		mkdir build/core/api || die "failed to create dir"
		unzip -qq build/core/lucene-core-${PV}-SNAPSHOT-javadoc.jar -d build/core/api
		java-pkg_dojavadoc build/core/api
	fi

	use source && java-pkg_dosrc core/src/java/org
}
