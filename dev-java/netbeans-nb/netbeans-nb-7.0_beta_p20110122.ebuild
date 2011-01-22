# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="3"
WANT_ANT_TASKS="ant-nodeps"
inherit eutils java-pkg-2 java-ant-2

DESCRIPTION="Netbeans IDE Branding"
HOMEPAGE="http://netbeans.org/"
SLOT="7.0"
SOURCE_URL="http://bits.netbeans.org/download/trunk/nightly/latest/zip/netbeans-trunk-nightly-201101220001-src.zip"
SRC_URI="${SOURCE_URL}
	http://dev.gentoo.org/~fordfrog/distfiles/netbeans-${SLOT}-build.xml.patch.bz2
	http://download.fordfrog.name/gentoo/netbeans-${SLOT}.png"
LICENSE="|| ( CDDL GPL-2-with-linking-exception )"
KEYWORDS="~amd64 ~x86"
IUSE="keychain"
S="${WORKDIR}"

CDEPEND="~dev-java/netbeans-platform-${PV}
	~dev-java/netbeans-harness-${PV}
	~dev-java/netbeans-ide-${PV}"
DEPEND=">=virtual/jdk-1.6
	app-arch/unzip
	${CDEPEND}
	dev-java/javahelp:0"
RDEPEND=">=virtual/jdk-1.6
	${CDEPEND}
	keychain? (
		net-misc/keychain:0
		net-misc/x11-ssh-askpass:0
	)"

INSTALL_DIR="/usr/share/${PN}-${SLOT}"

EANT_BUILD_XML="nbbuild/build.xml"
EANT_BUILD_TARGET="rebuild-cluster create-netbeans-import finish-build"
EANT_EXTRA_ARGS="-Drebuild.cluster.name=nb.cluster.nb -Dext.binaries.downloaded=true"
JAVA_PKG_BSFIX="off"

src_unpack() {
	unpack $(basename ${SOURCE_URL})

	einfo "Deleting bundled jars..."
	find -name "*.jar" -type f -delete

	unpack netbeans-7.0-build.xml.patch.bz2
}

src_prepare() {
	einfo "Deleting bundled class files..."
	find -name "*.class" -type f | xargs rm -vf

	epatch netbeans-7.0-build.xml.patch
	use keychain && epatch "${FILESDIR}"/${SLOT}/keychain-support.patch

	einfo "Symlinking external libraries..."
	java-pkg_jar-from --build-only --into javahelp/external javahelp jhall.jar jhall-2.0_05.jar

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
	popd >/dev/null || die

	java-pkg-2_src_prepare
}

src_install() {
	pushd nbbuild/netbeans >/dev/null || die

	insinto ${INSTALL_DIR}/nb || die

	grep -E "/nb$" moduleCluster.properties > "${D}"/${INSTALL_DIR}/nb/moduleCluster.properties || die

	insinto ${INSTALL_DIR} || die
	doins -r nb || die
	dodoc *.txt || die
	dohtml *.html *.css || die

	insinto ${INSTALL_DIR}/bin || die
	doins bin/netbeans || die
	dosym ${INSTALL_DIR}/bin/netbeans /usr/bin/netbeans-${SLOT} || die
	fperms 755 ${INSTALL_DIR}/bin/netbeans || die

	insinto /etc/netbeans-${SLOT} || die
	doins etc/* || die
	dosym /etc/netbeans-${SLOT} ${INSTALL_DIR}/etc
	sed -i "s%#netbeans_jdkhome=\"/path/to/jdk\"%netbeans_jdkhome=\"\$(java-config -O)\"%" "${D}"/etc/netbeans-${SLOT}/netbeans.conf || die

	dodir /usr/share/icons/hicolor/32x32/apps
	dosym ${INSTALL_DIR}/nb/netbeans.png /usr/share/icons/hicolor/32x32/apps/netbeans-${SLOT}.png
	dodir /usr/share/icons/hicolor/128x128/apps
	cp "${DISTDIR}"/netbeans-${SLOT}.png "${D}"/usr/share/icons/hicolor/128x128/apps/netbeans-${SLOT}.png
	dosym /usr/share/icons/hicolor/128x128/apps/netbeans-${SLOT}.png /usr/share/pixmaps/netbeans-${SLOT}.png

	popd >/dev/null || die

	pushd "${D}"/etc/netbeans-${SLOT} >/dev/null || die
	rm netbeans.clusters || die
	echo "/usr/share/netbeans-platform-${SLOT}" >> netbeans.clusters
	echo "/usr/share/netbeans-nb-${SLOT}/nb" >> netbeans.clusters
	echo "/usr/share/netbeans-ergonomics-${SLOT}" >> netbeans.clusters
	echo "/usr/share/netbeans-apisupport-${SLOT}" >> netbeans.clusters
	echo "/usr/share/netbeans-cnd-${SLOT}" >> netbeans.clusters
	echo "/usr/share/netbeans-dlight-${SLOT}" >> netbeans.clusters
	echo "/usr/share/netbeans-enterprise-${SLOT}" >> netbeans.clusters
	echo "/usr/share/netbeans-groovy-${SLOT}" >> netbeans.clusters
	echo "/usr/share/netbeans-harness-${SLOT}" >> netbeans.clusters
	echo "/usr/share/netbeans-ide-${SLOT}" >> netbeans.clusters
	echo "/usr/share/netbeans-identity-${SLOT}" >> netbeans.clusters
	echo "/usr/share/netbeans-java-${SLOT}" >> netbeans.clusters
	echo "/usr/share/netbeans-javacard-${SLOT}" >> netbeans.clusters
	echo "/usr/share/netbeans-mobility-${SLOT}" >> netbeans.clusters
	echo "/usr/share/netbeans-php-${SLOT}" >> netbeans.clusters
	echo "/usr/share/netbeans-profiler-${SLOT}" >> netbeans.clusters
	echo "/usr/share/netbeans-visualweb-${SLOT}" >> netbeans.clusters
	echo "/usr/share/netbeans-websvccommon-${SLOT}" >> netbeans.clusters
	echo "/usr/share/netbeans-xml-${SLOT}" >> netbeans.clusters
	popd >/dev/null || die

	make_desktop_entry netbeans-${SLOT} "Netbeans ${PV}" netbeans-${SLOT} Development

	echo "NBGNT" > ${D}/${INSTALL_DIR}/nb/config/productid || die "Could not set Gentoo Netbeans ID"
}

pkg_postinst() {
	if use keychain ; then
		einfo "You enabled keychain support, that means NetBeans will use keychain for managing"
		einfo "your keys while connecting to ssh protected repositories. If you want to load some"
		einfo "keys on NetBeans startup, create file keychain-keys.txt in your userdir"
		einfo "(~/.netbeans/${SLOT}/keychain-keys.txt) and put names of your keys in the file,"
		einfo "each key on single line, for example:"
		einfo "id_dsa"
		einfo "id_dsa_gentoo"
		einfo "If on NetBeans startup key will not be handled by keychain yet, you will be asked"
		einfo "for key password (only this time and never again). You can find more information"
		einfo "about keychain at http://www.gentoo.org/doc/en/keychain-guide.xml"
        fi
}
