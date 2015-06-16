# Distributed under the terms of the GNU General Public License v2

EAPI=5

ETYPE=sources
K_DEFCONFIG="beaglebone_defconfig"
K_SECURITY_UNSUPPORTED=1
UNIPATCH_LIST="${DISTDIR}/${PF}.xz"
CKV="3.12.9"
inherit kernel-2
detect_version
detect_arch

DESCRIPTION="BeagleBone kernel sources"
HOMEPAGE="https://github.com/beagleboard/kernel"

# See https://thestaticvoid.com/dist/beagleboard-sources/README
SRC_URI="${KERNEL_URI}
	https://thestaticvoid.com/dist/${PN}/${PF}.xz
	https://thestaticvoid.com/dist/${PN}/am335x-pm-firmware.bin"

KEYWORDS="~arm"

src_prepare() {
	einfo "Installing binary firmware..."
	cp "${DISTDIR}/am335x-pm-firmware.bin" firmware/am335x-pm-firmware.bin
}
