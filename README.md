# MediaWiki

MediaWiki is a free and open-source wiki software package written in PHP. It
serves as the platform for Wikipedia and the other Wikimedia projects, used
by hundreds of millions of people each month. MediaWiki is localised in over
350 languages and its reliability and robust feature set have earned it a large
and vibrant community of third-party users and developers.

MediaWiki is:

* feature-rich and extensible, both on-wiki and with hundreds of extensions;
* scalable and suitable for both small and large sites;
* simple to install, working on most hardware/software combinations; and
* available in your language.

For system requirements, installation, and upgrade details, see the files
RELEASE-NOTES, INSTALL, and UPGRADE.

* Ready to get started?
  * https://www.mediawiki.org/wiki/Special:MyLanguage/Download
* Setting up your local development environment?
  * https://www.mediawiki.org/wiki/Local_development_quickstart
* Looking for the technical manual?
  * https://www.mediawiki.org/wiki/Special:MyLanguage/Manual:Contents
* Seeking help from a person?
  * https://www.mediawiki.org/wiki/Special:MyLanguage/Communication
* Looking to file a bug report or a feature request?
  * https://bugs.mediawiki.org/
* Interested in helping out?
  * https://www.mediawiki.org/wiki/Special:MyLanguage/How_to_contribute

MediaWiki is the result of global collaboration and cooperation. The CREDITS
file lists technical contributors to the project. The COPYING file explains
MediaWiki's copyright and license (GNU General Public License, version 2 or
later). Many thanks to the Wikimedia community for testing and suggestions.



19 Oct 2025
The .vscode/settings.json Removes all superfluous folders and files from the VSCode explorer. If you ever can't find a file (or I suppose try to create a file but are told it already exists), this is the first place to look.

.cursorignore does not have the token file
.gitignore does not have LocalSettings or token file

be sure to have launch.json env set both MW_PATH_ROOT and LUA_LIB_PATH_ROOT that identify your local paths.

For using the API, you need to store your token in plain text in csrftoken.txt
You can find your token by: http://localhost:4000/api.php?action=query&meta=tokens&type=csrf&format=json

In your LocalSettings.php, make sure you add this so template saves in VSCode can be automatically pushed to the local database for testing:
# Disable requiring login since this is local, so the API can be used directly without a session
$wgGroupPermissions['*']['edit'] = true;
