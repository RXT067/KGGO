# STATUS: **ABADONWARE/DANGEROUS**
*replaced by games-moba/leagueoflegends-next which uses makefile to invoke bash script (WIP-concept).*
- Ebuild is unable to invoke wine/winetricks as non-root - FATAL: SECURITY HAZARD
  - Used `chown -R $USER $LOLDIR` to fix permission after the game is installed, but this way the wine can invoke something like wannacry that works on WINE and is able to ruin linux (https://appdb.winehq.org/objectManager.php?sClass=application&iId=18249).
- Ebuild is unable to fetch SCR_URI with a variables
  - Used wget as a workaround in pkg_setup
- Ebuild is unable to fetch USER variable
  - Asking for user-input as workaround in pkg_setup

Conclusion: Allow userpriv for pkg_setup, filled %BUG%

# EBUILD: LEAGUE OF LEGENDS
League of Legends is a multiplayer online battle arena video game developed by Riot Games for M$ Windows, shitOS and GENTOOOOOOOOOOOOOOOOOOOO.
The game follows a freemium model and is supported by microtransactions, and was inspired by the Warcraft III: The Frozen Throne mod, Defense of the Ancients. - Wikipedia

Last tested: https://youtu.be/aM6Tn45vTSo

## Abstract
Install League Of Legends on Gentoo that works on platinum with no issues that would prevent playing the game OOTB.

## Expected
- Install Wine with patches from Andrew Wesie AND/OR Wine Staging for league of legends only.
- Install dependencies from `winetricks` - `corefonts adobeair vcrun2008 vcrun2017 winxp glsl=disabled`
- Install League Of Legends using `wine` 
   - Installing extracted installer breaks the licence 

## Warning
Wine and Winetricks are invoked as root since ebuild doesn't support invoking them as non-root to my knowledge. Permissions are fixed within the ebuild unless you open a launcher after the installation and once the deps and game is installed.
