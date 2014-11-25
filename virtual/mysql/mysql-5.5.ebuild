# Distributed under the terms of the GNU General Public License v2

EAPI="4"

DESCRIPTION="Virtual for MySQL client or database"
HOMEPAGE=""
SRC_URI=""

LICENSE=""
SLOT="0"
KEYWORDS="*"
IUSE="embedded minimal static static-libs"

DEPEND=""
# TODO: add Drizzle here
RDEPEND="|| (
	=dev-db/mariadb-${PV}*[embedded=,minimal=,static=,static-libs=]
	=dev-db/mysql-${PV}*[embedded=,minimal=,static=,static-libs=]
	=dev-db/percona-server-${PV}*[embedded=,minimal=,static=,static-libs=]
	=dev-db/mariadb-galera-${PV}*[embedded=,minimal=,static=,static-libs=]
)"
