# Distributed under the terms of the GNU General Public License v2

EAPI="2"

DESCRIPTION="Virtual for MySQL client or database"
HOMEPAGE=""
SRC_URI=""

LICENSE=""
SLOT="0"
KEYWORDS="*"
IUSE="embedded minimal static"

DEPEND=""
RDEPEND="|| (
	=dev-db/mysql-${PV}*[embedded=,minimal=,static=]
	=dev-db/mariadb-${PV}*[embedded=,minimal=,static=]
	=dev-db/mysql-cluster-7.2*[embedded=,minimal=,static=]
)"
