# Distributed under the terms of the GNU General Public License v2

EAPI=5

ETYPE=sources
K_DEFCONFIG="bb.org_defconfig"
K_SECURITY_UNSUPPORTED=1
UNIPATCH_LIST="${DISTDIR}/${PF}.patch.xz"
UNIPATCH_STRICTORDER=1
CKV="3.14.43"
inherit kernel-2
detect_version
detect_arch

DESCRIPTION="BeagleBoard kernel sources"
HOMEPAGE="https://github.com/beagleboard/linux"

# See https://thestaticvoid.com/dist/beagleboard-sources/README
SRC_URI="${KERNEL_URI}
	https://thestaticvoid.com/dist/${PN}/${PF}.patch.xz
	https://thestaticvoid.com/dist/${PN}/${PF}-firmware.tar.xz"

KEYWORDS="~arm"

src_prepare() {
	einfo "Installing binary firmware..."
	unpack "${PF}-firmware.tar.xz"
}
