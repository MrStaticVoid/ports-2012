# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-terms/terminology/terminology-0.4.0_alpha1.ebuild,v 1.1 2013/11/13 08:32:36 sera Exp $

EAPI=5

inherit autotools git-r3

DESCRIPTION="Feature rich terminal emulator using the Enlightenment Foundation Libraries"
HOMEPAGE="http://www.enlightenment.org/p.php?p=about/terminology"
EGIT_REPO_URI="http://git.enlightenment.org/apps/terminology.git"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS=""
IUSE=""

RDEPEND="
	>=dev-libs/efl-1.8.1
	>=media-libs/elementary-1.8.0"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

src_prepare() {
	eautoreconf
}
