# Copyright 1999-2018 Gentoo Authors, Kreyren (github.com/kreyren)
# Distributed under the terms of the GNU General Public License v2
# Credit: https://github.com/Heather/gentoo-cynede/blob/master/app-misc/osu-wine/osu-wine-9999.ebuild
# Credit: https://github.com/Nefelim4ag/osu-wine

# Version: 0.0-concept

EAPI=6
inherit git-r3

DESCRIPTION="League Of Legends Wine wrapper For Gentoo"
EGIT_REPO_URI="https://github.com/RXT067/KGOFGUW/games-moba/leagueoflegends.git" # FIX
HOMEPAGE="https://github.com/Nefelim4ag/osu-wine" # FIX

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="virtual/wine"
RDEPEND="${DEPEND}"

src_install() {
	emake PREFIX="${D}" install || die "Install failed"
}
