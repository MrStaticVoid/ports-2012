# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5
USE_RUBY="ruby19 ruby20"

inherit ruby-ng-gnome2

DESCRIPTION="Ruby VTE bindings"
KEYWORDS="amd64 ~ppc x86"
IUSE=""

DEPEND+=" x11-libs/vte:2.90"
RDEPEND+=" x11-libs/vte:2.90"

ruby_add_bdepend ">=dev-ruby/ruby-glib2-${PV}"
ruby_add_rdepend ">=dev-ruby/ruby-gtk3-${PV}"
