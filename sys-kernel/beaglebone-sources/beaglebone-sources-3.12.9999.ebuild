# Distributed under the terms of the GNU General Public License v2

EAPI=5

ETYPE=sources
K_DEFCONFIG="beaglebone_defconfig"
K_SECURITY_UNSUPPORTED=1
EXTRAVERSION="-${PN}/-*"
inherit kernel-2
detect_version
detect_arch

inherit git-2 versionator
EGIT_REPO_URI=https://github.com/beagleboard/kernel.git
EGIT_PROJECT="beagleboard-kernel.git"
EGIT_BRANCH="$(get_version_component_range 1-2)"

DESCRIPTION="BeagleBone kernel sources"
HOMEPAGE="https://github.com/beagleboard/kernel"

KEYWORDS=""

src_unpack() {
	OLD_S="${S}"
	S="${S}/tmp"
	git-2_src_unpack
}

src_prepare() {
	# patch.sh does git commands that require a user/email to be set
	git config --global user.email "none@none"
	git config --global user.name "Portage"

	# Downloads and applies BeagleBone patches
	einfo "Downloading and applying BeagleBone patches..."
	./patch.sh || die "Failed to download and apply BeagleBone patches."
	cp configs/beaglebone kernel/arch/arm/configs/beaglebone_defconfig

	# Move patched kernel sources to proper directory
	mv kernel/* "${OLD_S}"
	rm -rf "${S}"
	S="${OLD_S}"

	unpack_set_extraversion
}
