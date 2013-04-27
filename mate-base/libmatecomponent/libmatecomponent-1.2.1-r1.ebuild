# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"
GCONF_DEBUG="yes"
MATE_LA_PUNT="yes"

inherit mate

DESCRIPTION="MATE CORBA framework"
HOMEPAGE="http://mate-desktop.org"

LICENSE="LGPL-2.1 GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~arm ~x86"
IUSE="debug doc examples test"

RDEPEND=">=dev-libs/glib-2.25.7:2
	>=mate-base/mate-corba-1.2.2
	>=mate-base/mate-common-1.2.2
	>=dev-libs/libxml2-2.4.20
	>=dev-libs/popt-1.5
	!gnome-base/bonobo-activation"
DEPEND="${RDEPEND}
	virtual/yacc
	>=dev-lang/perl-5
	sys-devel/flex
	x11-apps/xrdb
	virtual/pkgconfig
	>=dev-util/intltool-0.35
	doc? ( >=dev-util/gtk-doc-1 )"

# Tests are broken in several ways as reported in bug #288689
RESTRICT="test"

pkg_setup() {
	G2CONF="${G2CONF} $(use_enable debug matecomponent-activation-debug)"
	DOCS="AUTHORS ChangeLog NEWS README TODO"
}

src_prepare() {
	mate_src_prepare

	if ! use test; then
		# don't waste time building tests, bug #226223
		sed 's/tests//' -i Makefile.am Makefile.in || die "sed 1 failed"
	fi

	if ! use examples; then
		sed 's/samples//' -i Makefile.am Makefile.in || die "sed 2 failed"
	fi
}

src_test() {
	# Pass tests with FEATURES userpriv, see bug #288689
	unset MATECORBA_SOCKETDIR
	emake check || die "emake check failed"
}
