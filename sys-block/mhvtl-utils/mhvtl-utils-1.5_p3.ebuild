# Copyright 1999-2010 Gentoo Foundation
# Copyright 2012 Adrien Dessemond <adrien.dessemond@funtoo.org>
# Distributed under the terms of the GNU General Public License v2
# $Header:

EAPI="5"

inherit eutils user

DESCRIPTION="SCSI Virtual Tape Library (VTL)"
HOMEPAGE="http://sites.google.com/site/linuxvtl2"
SRC_URI="http://sites.google.com/site/linuxvtl2/mhvtl-2015-04-14.tgz -> mhvtl-1.5-3.tgz"
S=${WORKDIR}/mhvtl-1.5

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~sparc"

DEPEND="	sys-fs/lsscsi
		sys-libs/zlib
		dev-libs/lzo
		sys-apps/sg3_utils
		>=sys-block/mhvtl-modules-1.5
"
RDEPEND=""
IUSE="doc"

BUILD_TARGETS="clean default"
MHVTL_HOME_PATH=/var/spool/media/vtl
LUSER='vtl'
LGROUP='vtl'

pkg_setup() {

	enewgroup ${LGROUP}
	enewuser ${LUSER} -1 -1 ${MHVTL_HOME_PATH} "${LGROUP},tape"
}

src_prepare() {
	epatch "${FILESDIR}/0001_make-gentoo-friendly-Makefiles-1.5_p3.patch"
	epatch "${FILESDIR}/0002_make-vtl-media-not-failling-with-nologin.patch"
}

src_compile() {
	emake clean || die
	emake -j1 USR=${LUSER} GROUP=${LGROUP} MHVTL_HOME_PATH=${MHVTL_HOME_PATH} || die "emake failed"
}

src_install() {

	emake USR=${LUSER} GROUP=${LGROUP} MHVTL_HOME_PATH=${MHVTL_HOME_PATH} DESTDIR=${D} install || die "emake failed"

	einfo "Generating udev rules ..."
	dodir /lib/udev/rules.d/
	cat > "${D}"/lib/udev/rules.d/70-mhvtl.rules <<-EOF || die
	# do not edit this file, it will be overwritten on update
	#
	KERNEL=="mhvtl[0-9]*", MODE="0660", OWNER="vtl", GROUP="vtl"
	EOF

	newinitd "${FILESDIR}"/mhvtl.init.d mhvtl || die

	if use doc; then
		dohtml -r doc/* || die
	fi

	doman man/*.1 || die
	dodoc README INSTALL
}

