# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5
PYTHON_COMPAT=( python2_7 )

inherit distutils-r1

DESCRIPTION="Sphinx extension googleanalytics"
HOMEPAGE="https://bitbucket.org/birkenfeld/sphinx-contrib"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="BSD-2"
KEYWORDS="amd64 x86"
SLOT="0"
IUSE=""

DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]"
RDEPEND=">=dev-python/sphinx-0.6[${PYTHON_USEDEP}]"

PATCHES=( "${FILESDIR}/setup.py.utf-8.patch" )
