# Distributed under the terms of the GNU General Public License v2

EAPI="5"
GCONF_DEBUG="no"

inherit eutils gnome2 virtualx

DESCRIPTION="PackageKit client for the GNOME desktop"
HOMEPAGE="http://www.freedesktop.org/software/PackageKit/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
#Older ebuilds had some hackery to make tests pass. Disable them
RESTRICT="test"
IUSE="nls udev"

# gdk-pixbuf used in gpk-animated-icon
# pango used on gpk-common
RDEPEND="
	>=dev-libs/glib-2.32:2
	x11-libs/gdk-pixbuf:2
	>=x11-libs/gtk+-2.91.0:3
	>=x11-libs/libnotify-0.7.0:=
	x11-libs/pango
	>=dev-libs/dbus-glib-0.73
	>=app-admin/packagekit-gtk-0.8
	>=media-libs/libcanberra-0.10[gtk3]
	>=sys-apps/dbus-1.1.2
	media-libs/fontconfig
	x11-libs/libX11
	sys-auth/consolekit
	udev? ( virtual/libgudev )
"
DEPEND="${RDEPEND}
	>=dev-util/intltool-0.35
	dev-libs/libxslt
	sys-devel/gettext
	virtual/pkgconfig
"
# NOTES:
# app-text/docbook-sgml-utils required for man pages
# app-text/gnome-doc-utils and dev-libs/libxslt required for gnome help files
# gtk-doc is generating a useless file, don't need it

# UPSTREAM:
# misuse of CPPFLAGS/CXXFLAGS ?
# see if tests can forget about display (use eclass for that ?)
# intltool and gettext only with +nls

src_prepare() {
	# Disable bad flags
	# FIXME: touching configure.ac triggers maintainer-mode
	sed -e '/CPPFLAGS="$CPPFLAGS -g"/d' -i configure || die
	gnome2_src_prepare
}

src_configure() {
	gnome2_src_configure \
		--localstatedir=/var \
		--enable-iso-c \
		--disable-schemas-compile \
		--disable-gtk-doc \
		--disable-systemd \
		$(use_enable nls) \
		$(use_enable udev gudev) \
		ITSTOOL="$(type -P true)"
}
