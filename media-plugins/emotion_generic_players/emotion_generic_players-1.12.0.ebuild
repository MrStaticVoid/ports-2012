# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

DESCRIPTION="Provides external applications as generic loaders for Evas"
HOMEPAGE="http://www.enlightenment.org/"
SRC_URI="http://download.enlightenment.org/rel/libs/${PN}/${PN}-${PV/_/-}.tar.xz"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug +vlc"

RDEPEND="
	>=dev-libs/efl-1.12.0
	vlc? ( >=media-video/vlc-2.0 )"
DEPEND="${RDEPEND}
	app-arch/xz-utils"

S="${WORKDIR}/${PN}-${PV/_/-}"

src_configure() {
	local config=(
		--with-profile=$(usex debug debug release)
		$(use_with vlc)
	)

	econf "${config[@]}"
}
