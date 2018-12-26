# Krey's Template for Gentoo's ebuild EAPI 6
# Copyright 1999-2018 Gentoo Authors, Kreyren (github.com/kreyren)
# Distributed under the terms of the GNU General Public License v2
# Based on master index https://devmanual.gentoo.org/

# Related https://stackoverflow.com/questions/600079/how-do-i-clone-a-subdirectory-only-of-a-git-repository/52269934#52269934
## Meh wasting time requesting it on gentoo, using workaround.

# NOTE:  "Double quote" every literal that contains spaces/metacharacters and _every_ expansion: "$var", "$(command "$var")", "${array[@]}", "a & b". Use 'single quotes' for code or literal $'s: 'Costs $5 US', ssh host 'echo "$HOSTNAME"'. See http://mywiki.wooledge.org/Quotes , http://mywiki.wooledge.org/Arguments and http://wiki.bash-hackers.org/syntax/words .
# TODO: Desktop shortcut for WINEDEBUG="-all" WINEPREFIX="/opt/games/leagueoflegends" wine /opt/games/leagueoflegends/drive_c/Riot\ Games/League\ of\ Legends/LeagueClient.exe 

EAPI=6

## OVERRIDES
DEPEND=$DEPENDENCIES 
RDEPEND=$RUNTIME_DEPENDENDIES
PDEPEND=$POST_DEPENDENDANCIES

DESCRIPTION="League Of Legends ebuild for gentoo." # A short (not more than 80 characters) description of the package's purpose. Mandatory.

HOMEPAGE="https://www.leagueoflegends.com/" # Package's homepage. Mandatory (except for virtuals).

# SRC_URI="https://riotgamespatcher-a.akamaihd.net/releases/live/installer/deploy/League%20of%20Legends%20installer%20EUNE.exe" # A list of source URIs for the package. Can contain USE-conditional parts - https://devmanual.gentoo.org/ebuild-writing/variables/index.html#src_uri
## Doesn't work dunno why..
## TODO: Fetch installer for selected region

# EGIT_REPO_URI="" # Fetch from git

LICENSE="GPL-2.0" # The package's license, corresponding exactly (including case) to a file in licenses/. Mandatory (except for virtuals) - https://devmanual.gentoo.org/ebuild-writing/variables/index.html#license
# Licensing the ebuild and the implementation of it, game is All Rights Reserved to Riot Games, inc. which is respected and conformed

SLOT="0" # The package's SLOT. Mandatory - https://devmanual.gentoo.org/ebuild-writing/variables/index.html#slot

KEYWORDS="amd64 x86" # https://devmanual.gentoo.org/ebuild-writing/variables/index.html#keywords
# PBE will have testing

#IUSE= # A list of all USE flags (excluding arch flags, but including USE_EXPAND flags) used within the ebuild - https://devmanual.gentoo.org/ebuild-writing/variables/index.html#iuse.

#REQUIRED_USE="" # A list of assertions that must be met by the configuration of USE flags to be valid for this ebuild - https://devmanual.gentoo.org/ebuild-writing/variables/index.html#required_use

RESTRICT="strip" # A space-delimited list of portage features to restrict. Valid values are fetch, mirror, strip, test and userpriv. See man 5 ebuild for details.

DEPENDENCIES="|| (
>=app-emulation/wine-staging-3.14
>=app-emulation/wine-any-3.14
)
=app-emulation/winetricks-99999999" # A list of the package's build dependencies - https://devmanual.gentoo.org/general-concepts/dependencies/index.html

RUNTIME_DEPENDENDIES=$DEPENDENCIES # https://devmanual.gentoo.org/general-concepts/dependencies/index.html

# POST_DEPENDENDANCIES= # Use this only when RDEPEND would cause cyclic dependencies.

PROPERTIES="interactive"

JAZZHANDS () {
# JAZZHANDS, Krey's version of gentoo's shorthand that MAKES SENCE
## https://devmanual.gentoo.org/ebuild-writing/variables/

# NOTE: By convention, environment variables (PATH, EDITOR, SHELL, ...) and internal shell variables (BASH_VERSION, RANDOM, ...) are fully capitalized. All other variable names should be lowercase. Since variable names are case-sensitive, this convention avoids accidentally overriding environmental and internal variables.
## ex. foo=${FOO:-bla}

PNAV=${P}
## Package Name And Version
## TODO: Needs fix

PC=${CATEGORY}
## Package Category
## TODO: Needs fix

PN=$PN
## Package Name

PV=$PV
## Package Version

PR=$PR
## Package Revision

PVR=$PVAR
## Package Version And Revision

PF=$FPN
## Full Package Name


PORTDIR=/var/tmp/portage
## PORTage DIRectory

PACKDIR=${PORTDIR}/${PC}/${PNAV}
## PACKage DIRectory

BUILDDIR=${PACKDIR}/build

#FILESDIR=${PACKDIR}/files

#WORKDIR=${PACKDIR}/work

HOMEDIR=${PACKDIR}/homedir

DISTDIR=${PACKDIR}/distdir

IMAGEDIR=${PACKDIR}/image

SOURCEDIR=${PACKDIR}/${PNAV}

ROOT=/



BUILDDIR=$PBD
## Package Build Directory

PFD=${PACKDIR}/files
## Package Files Directory

PWD=${PACKDIR}/work
## Package Work Directory

PHD=${PACKDIR}/homedir
## Package Home Directory

DISTDIR=$PDD
## Package Distribution Directory

IMAGEDIR=$PID
## Package Image Directory

SOURCEDIR=$PSD
## Package Source Directory

ROOT=/ # I AM ROOT

LOLDIR=/opt/games/leagueoflegends

}

# FUNCTIONS - https://devmanual.gentoo.org/ebuild-writing/functions/index.html

S=${WORKDIR}

pkg_pretend () { 
# run sanity checks for a package during dependency calculation time

	if [[ ! -x $(command -v wine) ]]; then
		die "Wine is not executable."
	fi

	if [[ ! -x $(command -v winetricks) ]]; then
		die "Winetricks is not executable."
	fi

	return
}

pkg_setup () {
# https://devmanual.gentoo.org/ebuild-writing/functions/pkg_setup/index.html

	JAZZHANDS

	USER=kreyren # TODO: Needs fix

	wget -O "LOL_INSTALLER.exe" https://riotgamespatcher-a.akamaihd.net/releases/live/installer/deploy/League%20of%20Legends%20installer%20EUNE.exe

	# Exist check - fail with request to download if not present
	while [[ LOL_INSTALLER_LOOP != done ]]; do

		if [[ ! -e "$PHD/LOL_INSTALLER.exe" ]]; then
				echo "ERROR $PHD/LOL_INSTALLER.exe is not present"
				echo "Please download the league of legends installer from official source and place it in mensioned path and name."
				read nothing

			else 
				LOL_INSTALLER=$PHD/LOL_INSTALLER.exe
				mkdir -p /home/$USER/games/leagueoflegends
				chown -Rf $USER /home/$USER/games/leagueoflegends*
				LOL_INSTALLER_LOOP=done
				break
		fi

	done
	
	echo Winetricks: $(winetricks --version)

	WINEDEBUG="-all" WINEPREFIX="${LOLDIR}" winetricks corefonts adobeair vcrun2008 vcrun2017 winxp glsl=disabled

	echo "
!!! DO NOT LAUNCH THE GAME ONCE THE INSTALLER IS FINISHED !!!
!!! DO NOT LAUNCH THE GAME ONCE THE INSTALLER IS FINISHED !!!
!!! DO NOT LAUNCH THE GAME ONCE THE INSTALLER IS FINISHED !!!
!!! DO NOT LAUNCH THE GAME ONCE THE INSTALLER IS FINISHED !!!
!!! DO NOT LAUNCH THE GAME ONCE THE INSTALLER IS FINISHED !!!
!!! DO NOT LAUNCH THE GAME ONCE THE INSTALLER IS FINISHED !!!
!!! DO NOT LAUNCH THE GAME ONCE THE INSTALLER IS FINISHED !!!
!!! DO NOT LAUNCH THE GAME ONCE THE INSTALLER IS FINISHED !!!
!!! DO NOT LAUNCH THE GAME ONCE THE INSTALLER IS FINISHED !!!
!!! DO NOT LAUNCH THE GAME ONCE THE INSTALLER IS FINISHED !!!
!!! DO NOT LAUNCH THE GAME ONCE THE INSTALLER IS FINISHED !!!
!!! DO NOT LAUNCH THE GAME ONCE THE INSTALLER IS FINISHED !!!
!!! DO NOT LAUNCH THE GAME ONCE THE INSTALLER IS FINISHED !!!
!!! DO NOT LAUNCH THE GAME ONCE THE INSTALLER IS FINISHED !!!
!!! DO NOT LAUNCH THE GAME ONCE THE INSTALLER IS FINISHED !!!
!!! DO NOT LAUNCH THE GAME ONCE THE INSTALLER IS FINISHED !!!
!!! DO NOT LAUNCH THE GAME ONCE THE INSTALLER IS FINISHED !!!
!!! DO NOT LAUNCH THE GAME ONCE THE INSTALLER IS FINISHED !!!
!!! DO NOT LAUNCH THE GAME ONCE THE INSTALLER IS FINISHED !!!
!!! DO NOT LAUNCH THE GAME ONCE THE INSTALLER IS FINISHED !!!
"

	echo "Press any key to continue.."

	echo "Otherwise League Of Legends would execute as root.."

	read anything

	WINEDEBUG="-all" WINEPREFIX="${LOLDIR}" wine "${LOL_INSTALLER}"

	chown -R $USER $LOLDIR
}

disabled-src_unpack () {
# Extract source packages and do any necessary patching or fixes.

	return
}

DISABLED_src_prepare () {
# Prepare source packages and do any necessary patching or fixes.

	return
}

disabled-src_configure () {
# Configure the package.

	return
}

disabled-src_compile () {
# Configure and build the package.

	return
}

disabled-src_test () {
# Run pre-install test scripts

	return
}

disabled-src_install () {
# Install a package to ${IMAGEDIR}

	return
}

disabled-pkg_preinstall () {
# Called before image is installed to ${ROOT}

	return
}

disabled-pkg_postinst () {
# Called after image is installed to ${ROOT}

	return
}

disabled-pkg_prerm () {
# Called before a package is unmerged

	return
}

disabled-pkg_postrm () {
# Called after image is installed to ${ROOT}

	return
}

disabled-pkg_config () {
# Run any special post-install configuration

	return
}

disabled-pkg_info () {
# display information about a package

	return
}
