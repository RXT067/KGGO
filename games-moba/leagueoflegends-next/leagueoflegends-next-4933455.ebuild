# Copyright 1999-2018 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6
inherit git-r3

DESCRIPTION="osu! wine wrapper"
EGIT_REPO_URI="https://github.com/Nefelim4ag/osu-wine.git"
HOMEPAGE="https://github.com/Nefelim4ag/osu-wine"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="virtual/wine"
RDEPEND="${DEPEND}"

src_install() {
	emake PREFIX="${D}" install || die "Install failed"
}
