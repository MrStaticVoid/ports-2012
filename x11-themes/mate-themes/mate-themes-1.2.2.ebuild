# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"
GCONF_DEBUG="no"

inherit mate

DESCRIPTION="A set of MATE themes, with sets for users with limited or low vision"
HOMEPAGE="http://mate-desktop.org"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~arm ~x86"
IUSE=""

RDEPEND=">=x11-libs/gtk+-2:2
	>=x11-themes/gtk-engines-2.15.3:2"

DEPEND="${RDEPEND}
	>=app-text/mate-doc-utils-1.2.1
	>=x11-misc/icon-naming-utils-0.8.7
	virtual/pkgconfig
	>=dev-util/intltool-0.35
	sys-devel/gettext"
# For problems related with dev-perl/XML-LibXML please see bug 266136

# This ebuild does not install any binaries
RESTRICT="binchecks strip"

pkg_setup() {
	G2CONF="${G2CONF}
		--disable-test-themes
		--enable-icon-mapping"
	DOCS="AUTHORS ChangeLog NEWS README"
}

src_prepare() {
	mate_src_prepare

	# Remove themes now provided by x11-themes/gnome-themes-standard
	sed 's:HighContrast.*\\:\\:g' -i $(find . -name Makefile.am -o -name Makefile.in) || die
	sed 's:LowContrast.*\\:\\:g' -i $(find . -name Makefile.am -o -name Makefile.in) || die
	# File collision with x11-themes/matacity-themes package
	sed 's:Shiny.*\\:\\:g' -i $(find . -name Makefile.am -o -name Makefile.in) || die
	# Compillation issue with all that disabled stuff
	sed 's:Aldabra.*\\:\\:g' -i $(find . -name Makefile.am -o -name Makefile.in) || die

	# Are we need it?
	# Fix intltoolize broken file, see upstream #577133
	# sed "s:'\^\$\$lang\$\$':\^\$\$lang\$\$:g" -i po/Makefile.in.in \
	#	|| die "intltool rules fix failed"
}
