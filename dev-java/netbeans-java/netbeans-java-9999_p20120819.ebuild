# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"
WANT_ANT_TASKS="ant-nodeps"
inherit eutils java-pkg-2 java-ant-2

# Maven cannot be unbundled because it depends on exact maven version and exact content of maven directory

DESCRIPTION="Netbeans Java Cluster"
HOMEPAGE="http://netbeans.org/projects/java"
SLOT="9999"
SOURCE_URL="http://bits.netbeans.org/download/trunk/nightly/2012-08-19_00-01-28/zip/netbeans-trunk-nightly-201208190001-src.zip"
SRC_URI="${SOURCE_URL}
	http://dev.gentoo.org/~fordfrog/distfiles/netbeans-9999-r7-build.xml.patch.bz2
	http://hg.netbeans.org/binaries/8D36897DA80FE60AB5263534A3CF522F466E8200-ant-libs-1.8.4.zip
	http://hg.netbeans.org/binaries/29CFD351206016B67DD0D556098513D2B259C69B-apache-maven-3.0.4-bin.zip
	http://hg.netbeans.org/binaries/F7BD95641780C2AAE8CB9BED1686441A1CE5E749-beansbinding-1.2.1-doc.zip
	http://hg.netbeans.org/binaries/90F1E67F38F1D8EC25C082F8EB08CFEC9A3B75E2-eclipselink-2.3.2.jar
	http://hg.netbeans.org/binaries/C8A5E0D558EA7E7349F9D32B838553D5E7DD214F-hibernate-3.2.5-lib.zip
	http://hg.netbeans.org/binaries/FA2498EE1BBCB1F5647280F71E31CDB440CA1326-indexer-artifact-4.1.3.jar
	http://hg.netbeans.org/binaries/A30278ABFF1C3C9D79ACB86096142364B17ED475-indexer-core-4.1.3.jar
	http://hg.netbeans.org/binaries/3BCA561B1B7B284B3D3C097F92A9CD47FF485058-javax.persistence-2.0.3.jar
	http://hg.netbeans.org/binaries/84E2020E5499015E9F40D1212C86918264B89EB1-jaxws-2.2.6.zip
	http://hg.netbeans.org/binaries/D64C40E770C95C2A6994081C00CCD489C0AA20C9-jaxws-2.2.6-api.zip
	http://hg.netbeans.org/binaries/8ECD169E9E308C258287E4F28B03B6D6F1E55F47-jaxws-api-doc.zip
	http://hg.netbeans.org/binaries/6AE2C83C77A1FFA5840B9151A271AB3F451F6E0C-lucene-core-3.6.1.jar
	http://hg.netbeans.org/binaries/2BD49695E9891697C5F290AA94C3412DFB95B096-lucene-highlighter-3.6.1.jar
	http://hg.netbeans.org/binaries/BF206C4AA93C74A739FBAF1F1C78E3AD5F167245-maven-dependency-tree-2.0.jar
	http://hg.netbeans.org/binaries/0F7FC8D69950B86D5F67529B5C551DB84C5BCF87-nb-javac-api.jar
	http://hg.netbeans.org/binaries/B3A1E970101BDD0834B360479FCB67A874B5A4AE-nb-javac-impl.jar
	http://hg.netbeans.org/binaries/663FA7BA7FD8538E44DE9FDC5315C4F733C13E96-org.eclipse.persistence.jpa.jpql_1.0.1.jar
	http://hg.netbeans.org/binaries/481935A7F53B55502187BD3C28C2BC0D957BB643-org.eclipse.persistence.jpa.modelgen.processor-2.3.2.jar
	http://hg.netbeans.org/binaries/CB686A65B6C4516A32173CB60385D02027440620-spring-2.5.6.SEC03.jar
	http://hg.netbeans.org/binaries/08717AD8947FCADA5C55DA89EB474BF053C30E57-spring-asm-3.1.1.RELEASE.jar
	http://hg.netbeans.org/binaries/83D0E5ADC98714783F0FB7D8A5E97EF4CF08DA49-spring-beans-3.1.1.RELEASE.jar
	http://hg.netbeans.org/binaries/ECB0784A0712C1BFBC1C2018EEEF6776861300E4-spring-context-3.1.1.RELEASE.jar
	http://hg.netbeans.org/binaries/FC5DE9FEAD1E54054298D37B196F9CD64CED19BF-spring-context-support-3.1.1.RELEASE.jar
	http://hg.netbeans.org/binaries/419E9233C8D55F64A0C524BB94C3BA87E51E7D95-spring-core-3.1.1.RELEASE.jar
	http://hg.netbeans.org/binaries/1486D7787EC4FF8DA8CBF8752D30E4C808412B3F-spring-expression-3.1.1.RELEASE.jar
	http://hg.netbeans.org/binaries/7CF9A377A1D5F6C4D310D505261B33FBE39F6B85-spring-framework-3.1.1.RELEASE.zip
	http://hg.netbeans.org/binaries/7B18BBAB94119E8AE322E8599C067C4F4B3701F6-spring-web-3.1.1.RELEASE.jar"
LICENSE="|| ( CDDL GPL-2-with-linking-exception )"
KEYWORDS="~amd64 ~x86"
IUSE=""
S="${WORKDIR}"

CDEPEND="~dev-java/netbeans-platform-${PV}
	~dev-java/netbeans-harness-${PV}
	~dev-java/netbeans-ide-${PV}
	~dev-java/netbeans-websvccommon-${PV}
	dev-java/beansbinding:0
	dev-java/cglib:2.2
	dev-java/jdom:1.0
	dev-java/tomcat-servlet-api:2.5"
DEPEND="virtual/jdk:1.6
	app-arch/unzip
	${CDEPEND}
	dev-java/javahelp:0
	dev-java/junit:4"
RDEPEND=">=virtual/jdk-1.6
	${CDEPEND}
	dev-java/absolutelayout:0
	dev-java/antlr:0[java]
	dev-java/asm:2.2
	dev-java/cglib:2.1
	dev-java/commons-collections:0
	dev-java/dom4j:1
	dev-java/ehcache:1.2
	dev-java/fastinfoset:0
	dev-java/javassist:3
	dev-java/jsr67:0
	dev-java/jsr181:0
	dev-java/glassfish-transaction-api:0
	dev-java/jtidy:0
	dev-java/mimepull:0
	dev-java/saaj:0
	dev-java/stax-ex:0
	dev-java/xmlstreambuffer:0"

INSTALL_DIR="/usr/share/${PN}-${SLOT}"

EANT_BUILD_XML="nbbuild/build.xml"
EANT_BUILD_TARGET="rebuild-cluster"
EANT_EXTRA_ARGS="-Drebuild.cluster.name=nb.cluster.java -Dext.binaries.downloaded=true"
EANT_FILTER_COMPILER="ecj-3.3 ecj-3.4 ecj-3.5 ecj-3.6 ecj-3.7"
JAVA_PKG_BSFIX="off"

pkg_pretend() {
	local die_now=""

	if [ -n "$(find /usr/share/netbeans-java-${SLOT}/ant -type l)" ]; then
		eerror "Please remove following symlinks and run emerge again:"
		find /usr/share/netbeans-java-${SLOT}/ant -type l
		die_now="1"
	fi

	if [ -L /usr/share/netbeans-java-${SLOT}/maven ]; then
		if [ -z "${die_now}" ]; then
			eerror "Please remove following symlinks and run emerge again:"
		fi

		echo "/usr/share/netbeans-java-${SLOT}/maven"
		die_now="1"
	fi

	if [ -n "${die_now}" ]; then
		die "Symlinks exist"
	fi
}

src_unpack() {
	unpack $(basename ${SOURCE_URL})

	einfo "Deleting bundled jars..."
	find -name "*.jar" -type f -delete

	unpack netbeans-9999-r7-build.xml.patch.bz2

	pushd "${S}" >/dev/null || die
	ln -s "${DISTDIR}"/8D36897DA80FE60AB5263534A3CF522F466E8200-ant-libs-1.8.4.zip o.apache.tools.ant.module/external/ant-libs-1.8.4.zip || die
	ln -s "${DISTDIR}"/29CFD351206016B67DD0D556098513D2B259C69B-apache-maven-3.0.4-bin.zip maven.embedder/external/apache-maven-3.0.4-bin.zip || die
	ln -s "${DISTDIR}"/F7BD95641780C2AAE8CB9BED1686441A1CE5E749-beansbinding-1.2.1-doc.zip o.jdesktop.beansbinding/external/beansbinding-1.2.1-doc.zip || die
	ln -s "${DISTDIR}"/90F1E67F38F1D8EC25C082F8EB08CFEC9A3B75E2-eclipselink-2.3.2.jar j2ee.eclipselink/external/eclipselink-2.3.2.jar || die
	ln -s "${DISTDIR}"/C8A5E0D558EA7E7349F9D32B838553D5E7DD214F-hibernate-3.2.5-lib.zip hibernatelib/external/hibernate-3.2.5-lib.zip || die
	ln -s "${DISTDIR}"/FA2498EE1BBCB1F5647280F71E31CDB440CA1326-indexer-artifact-4.1.3.jar maven.indexer/external/indexer-artifact-4.1.3.jar || die
	ln -s "${DISTDIR}"/A30278ABFF1C3C9D79ACB86096142364B17ED475-indexer-core-4.1.3.jar maven.indexer/external/indexer-core-4.1.3.jar || die
	ln -s "${DISTDIR}"/3BCA561B1B7B284B3D3C097F92A9CD47FF485058-javax.persistence-2.0.3.jar j2ee.eclipselink/external/javax.persistence-2.0.3.jar || die
	ln -s "${DISTDIR}"/84E2020E5499015E9F40D1212C86918264B89EB1-jaxws-2.2.6.zip websvc.jaxws21/external/jaxws-2.2.6.zip || die
	ln -s "${DISTDIR}"/D64C40E770C95C2A6994081C00CCD489C0AA20C9-jaxws-2.2.6-api.zip websvc.jaxws21api/external/jaxws-2.2.6-api.zip || die
	ln -s "${DISTDIR}"/8ECD169E9E308C258287E4F28B03B6D6F1E55F47-jaxws-api-doc.zip websvc.jaxws21/external/jaxws-api-doc.zip || die
	ln -s "${DISTDIR}"/6AE2C83C77A1FFA5840B9151A271AB3F451F6E0C-lucene-core-3.6.1.jar maven.indexer/external/lucene-core-3.6.1.jar || die
	ln -s "${DISTDIR}"/2BD49695E9891697C5F290AA94C3412DFB95B096-lucene-highlighter-3.6.1.jar maven.indexer/external/lucene-highlighter-3.6.1.jar || die
	ln -s "${DISTDIR}"/BF206C4AA93C74A739FBAF1F1C78E3AD5F167245-maven-dependency-tree-2.0.jar maven.embedder/external/maven-dependency-tree-2.0.jar || die
	ln -s "${DISTDIR}"/0F7FC8D69950B86D5F67529B5C551DB84C5BCF87-nb-javac-api.jar libs.javacapi/external/nb-javac-api.jar || die
	ln -s "${DISTDIR}"/B3A1E970101BDD0834B360479FCB67A874B5A4AE-nb-javac-impl.jar libs.javacimpl/external/nb-javac-impl.jar || die
	ln -s "${DISTDIR}"/663FA7BA7FD8538E44DE9FDC5315C4F733C13E96-org.eclipse.persistence.jpa.jpql_1.0.1.jar j2ee.eclipselink/external/org.eclipse.persistence.jpa.jpql_1.0.1.jar || die
	ln -s "${DISTDIR}"/481935A7F53B55502187BD3C28C2BC0D957BB643-org.eclipse.persistence.jpa.modelgen.processor-2.3.2.jar j2ee.eclipselinkmodelgen/external/org.eclipse.persistence.jpa.modelgen.processor-2.3.2.jar || die
	ln -s "${DISTDIR}"/CB686A65B6C4516A32173CB60385D02027440620-spring-2.5.6.SEC03.jar libs.springframework/external/spring-2.5.6.SEC03.jar || die
	ln -s "${DISTDIR}"/08717AD8947FCADA5C55DA89EB474BF053C30E57-spring-asm-3.1.1.RELEASE.jar o.springframework.asm/external/spring-asm-3.1.1.RELEASE.jar || die
	ln -s "${DISTDIR}"/83D0E5ADC98714783F0FB7D8A5E97EF4CF08DA49-spring-beans-3.1.1.RELEASE.jar o.springframework.beans/external/spring-beans-3.1.1.RELEASE.jar || die
	ln -s "${DISTDIR}"/ECB0784A0712C1BFBC1C2018EEEF6776861300E4-spring-context-3.1.1.RELEASE.jar o.springframework.context/external/spring-context-3.1.1.RELEASE.jar || die
	ln -s "${DISTDIR}"/FC5DE9FEAD1E54054298D37B196F9CD64CED19BF-spring-context-support-3.1.1.RELEASE.jar o.springframework.context.support/external/spring-context-support-3.1.1.RELEASE.jar || die
	ln -s "${DISTDIR}"/419E9233C8D55F64A0C524BB94C3BA87E51E7D95-spring-core-3.1.1.RELEASE.jar o.springframework.core/external/spring-core-3.1.1.RELEASE.jar || die
	ln -s "${DISTDIR}"/1486D7787EC4FF8DA8CBF8752D30E4C808412B3F-spring-expression-3.1.1.RELEASE.jar o.springframework.expression/external/spring-expression-3.1.1.RELEASE.jar || die
	ln -s "${DISTDIR}"/7CF9A377A1D5F6C4D310D505261B33FBE39F6B85-spring-framework-3.1.1.RELEASE.zip libs.springframework/external/spring-framework-3.1.1.RELEASE.zip || die
	ln -s "${DISTDIR}"/7B18BBAB94119E8AE322E8599C067C4F4B3701F6-spring-web-3.1.1.RELEASE.jar o.springframework.web/external/spring-web-3.1.1.RELEASE.jar || die
	popd >/dev/null || die
}

src_prepare() {
	einfo "Deleting bundled class files..."
	find -name "*.class" -type f | xargs rm -vf

	epatch netbeans-9999-r7-build.xml.patch

	# Support for custom patches
	if [ -n "${NETBEANS9999_PATCHES_DIR}" -a -d "${NETBEANS9999_PATCHES_DIR}" ] ; then
		local files=`find "${NETBEANS9999_PATCHES_DIR}" -type f`

		if [ -n "${files}" ] ; then
			einfo "Applying custom patches:"

			for file in ${files} ; do
				epatch "${file}"
			done
		fi
	fi

	einfo "Symlinking external libraries..."
	java-pkg_jar-from --build-only --into javahelp/external javahelp jhall.jar jhall-2.0_05.jar
	java-pkg_jar-from --into javax.servlet/external tomcat-servlet-api-2.5 servlet-api.jar javax.servlet-2.5.0.jar
	java-pkg_jar-from --into libs.cglib/external cglib-2.2 cglib.jar cglib-2.2.jar
	java-pkg_jar-from --build-only --into libs.junit4/external junit-4 junit.jar junit-4.10.jar
	java-pkg_jar-from --into maven.embedder/external jdom-1.0 jdom.jar jdom-1.0.jar
	java-pkg_jar-from --into o.jdesktop.beansbinding/external beansbinding beansbinding.jar beansbinding-1.2.1.jar

	einfo "Linking in other clusters..."
	mkdir "${S}"/nbbuild/netbeans || die
	pushd "${S}"/nbbuild/netbeans >/dev/null || die

	ln -s /usr/share/netbeans-platform-${SLOT} platform || die
	cat /usr/share/netbeans-platform-${SLOT}/moduleCluster.properties >> moduleCluster.properties || die
	touch nb.cluster.platform.built

	ln -s /usr/share/netbeans-harness-${SLOT} harness || die
	cat /usr/share/netbeans-harness-${SLOT}/moduleCluster.properties >> moduleCluster.properties || die
	touch nb.cluster.harness.built

	ln -s /usr/share/netbeans-ide-${SLOT} ide || die
	cat /usr/share/netbeans-ide-${SLOT}/moduleCluster.properties >> moduleCluster.properties || die
	touch nb.cluster.ide.built

	ln -s /usr/share/netbeans-websvccommon-${SLOT} websvccommon || die
	cat /usr/share/netbeans-websvccommon-${SLOT}/moduleCluster.properties >> moduleCluster.properties || die
	touch nb.cluster.websvccommon.built

	popd >/dev/null || die

	java-pkg-2_src_prepare
}

src_install() {
	pushd nbbuild/netbeans/java >/dev/null || die

	insinto ${INSTALL_DIR}
	grep -E "/java$" ../moduleCluster.properties > "${D}"/${INSTALL_DIR}/moduleCluster.properties || die

	doins -r *
	chmod 755 "${D}"/${INSTALL_DIR}/maven/bin/mvn* || die
	rm -fr "${D}"/${INSTALL_DIR}/maven/bin/*.bat || die

	popd >/dev/null || die

	local instdir=/${INSTALL_DIR}/modules/ext
	pushd "${D}"/${instdir} >/dev/null || die
	rm AbsoluteLayout.jar  && dosym /usr/share/absolutelayout/lib/absolutelayout.jar ${instdir}/AbsoluteLayout.jar || die
	rm beansbinding-1.2.1.jar && dosym /usr/share/beansbinding/lib/beansbinding.jar ${instdir}/beansbinding-1.2.1.jar || die
	rm cglib-2.2.jar && dosym /usr/share/cglib-2.2/lib/cglib.jar ${instdir}/cglib-2.2.jar || die
	popd >/dev/null || die

	local instdir=${INSTALL_DIR}/modules/ext/hibernate
	pushd "${D}"/${instdir} >/dev/null || die
	rm antlr-2.7.6.jar && dosym /usr/share/antlr/lib/antlr.jar ${instdir}/antlr-2.7.6.jar || die
	rm asm-attrs.jar && dosym /usr/share/asm-2.2/lib/asm-attrs.jar ${instdir}/asm-attrs.jar || die
	rm asm.jar && dosym /usr/share/asm-2.2/lib/asm.jar ${instdir}/asm.jar || die
	rm cglib-2.1.3.jar && dosym /usr/share/cglib-2.1/lib/cglib.jar ${instdir}/cglib-2.1.3.jar || die
	rm commons-collections-2.1.1.jar && dosym /usr/share/commons-collections/lib/commons-collections.jar ${instdir}/commons-collections-2.1.1.jar || die
	rm dom4j-1.6.1.jar && dosym /usr/share/dom4j-1/lib/dom4j.jar ${instdir}/dom4j-1.6.1.jar || die
	rm ehcache-1.2.3.jar && dosym /usr/share/ehcache-1.2/lib/ehcache.jar ${instdir}/ehcache-1.2.3.jar || die
	rm javassist.jar && dosym /usr/share/javassist-3/lib/javassist.jar ${instdir}/javassist.jar || die
	rm jta.jar && dosym /usr/share/glassfish-transaction-api/lib/jta.jar ${instdir}/jta.jar || die
	rm jtidy-r8-20060801.jar && dosym /usr/share/jtidy/lib/Tidy.jar ${instdir}/jtidy-r8-20060801.jar || die
	popd >/dev/null || die

	local instdir=/${INSTALL_DIR}/modules/ext/jaxws22
	pushd "${D}"/${instdir} >/dev/null || die
	rm FastInfoset.jar && dosym /usr/share/fastinfoset/lib/fastinfoset.jar ${instdir}/FastInfoset.jar || die
	rm mimepull.jar && dosym /usr/share/mimepull/lib/mimepull.jar ${instdir}/mimepull.jar || die
	rm saaj-impl.jar && dosym /usr/share/saaj/lib/saaj.jar ${instdir}/saaj-impl.jar || die
	rm stax-ex.jar && dosym /usr/share/stax-ex/lib/stax-ex.jar ${instdir}/stax-ex.jar || die
	rm streambuffer.jar && dosym /usr/share/xmlstreambuffer/lib/streambuffer.jar ${instdir}/streambuffer.jar || die
	popd >/dev/null || die

	local instdir=${INSTALL_DIR}/modules/ext/jaxws22/api
	pushd "${D}"/${instdir} >/dev/null || die
	rm jsr181-api.jar && dosym /usr/share/jsr181/lib/jsr181.jar ${instdir}/jsr181-api.jar || die
	rm saaj-api.jar && dosym /usr/share/jsr67/lib/jsr67.jar ${instdir}/saaj-api.jar || die
	popd >/dev/null || die

	local instdir=${INSTALL_DIR}/modules/ext/maven
	pushd "${D}"/${instdir} >/dev/null || die
	rm jdom-1.0.jar && dosym /usr/share/jdom-1.0/lib/jdom.jar ${instdir}/jdom-1.0.jar || die
	popd >/dev/null || die

	dosym ${INSTALL_DIR} /usr/share/netbeans-nb-${SLOT}/java
}
