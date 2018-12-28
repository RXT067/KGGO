# EBUILD: LEAGUE OF LEGENDS

![LOGO](http://hdwallpaper.live/wp-content/uploads/2018/11/league-of-legends-logo-wallpaper-hd.jpg)

League of Legends is a multiplayer online battle arena video game developed by Riot Games for M$ Windows, shitOS and GENTOOOOOOOOOOOOOOOOOOOO.
The game follows a freemium model and is supported by microtransactions, and was inspired by the Warcraft III: The Frozen Throne mod, Defense of the Ancients. - Wikipedia

Last tested: https://youtu.be/aM6Tn45vTSo

## Abstract
Install League Of Legends on Gentoo that works on platinum.

## Expected
- Install Wine with patches from Andrew Wesie AND/OR Wine Staging for league of legends only.
- Install dependencies from `winetricks` - `corefonts adobeair vcrun2008 vcrun2017 winxp glsl=disabled`
- Install League Of Legends using `wine` 
   - Installing extracted installer breaks the licence 

## Warning
Wine and Winetricks are invoked as root since ebuild doesn't support invoking them as non-root to my knowledge. Permissions are fixed within the ebuild unless you open a launcher after the installation and once the deps and game is installed.
