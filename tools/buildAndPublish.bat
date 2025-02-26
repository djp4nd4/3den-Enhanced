:: Turn of messages from commands
:: @ECHO off

:: Ask user for version
SET /P VERSION=Version (MAJOR.MINOR, X.X)?

:: Display version
ECHO v%VERSION%

:: Define paths
SET "PROJECT_FOLDER=C:\Users\rober\OneDrive\Games\Arma 3\Arma 3 Mods\3den-Enhanced"
SET "TARGET_FOLDER=C:\Users\rober\Desktop\@3den Enhanced v%Version%"

:: Create directories
ECHO Creating directories in %TARGET_FOLDER%.
MD "%TARGET_FOLDER%"
MD "%TARGET_FOLDER%\keys"
MD "%TARGET_FOLDER%\addons"
MD "%TARGET_FOLDER%\userconfig"

:: Copy important files
ECHO Copying files from %PROJECT_FOLDER% to %TARGET_FOLDER%.
COPY "%PROJECT_FOLDER%\mod.cpp" "%TARGET_FOLDER%\mod.cpp"
COPY "%PROJECT_FOLDER%\keys\3denEnhanced.bikey" "%TARGET_FOLDER%\keys\3denEnhanced.bikey"
COPY "%PROJECT_FOLDER%\userconfig\ENH_Config.hpp" "%TARGET_FOLDER%\userconfig\ENH_Config.hpp"

:: Change dir
CD "C:\Program Files (x86)\Steam\steamapps\common\Arma 3 Tools\AddonBuilder\"
::Start AddonBuilder and pack mod and wait until it's done
START /WAIT AddonBuilder.exe "%PROJECT_FOLDER%\3denEnhanced" "%TARGET_FOLDER%\addons" -packonly -sign="%PROJECT_FOLDER%\3denEnhanced.biprivatekey"

:: Pack everything into .zip file
ECHO .zip created and moved to OneDrive.
POWERSHELL compress-archive -Path """%TARGET_FOLDER%""" -DestinationPath """%PROJECT_FOLDER%\versions\@3den Enhanced v%VERSION_MAJOR%.%VERSION_MINOR%.zip""" -force

:: Update Steam Version via Publisher
:: Change dir
CD "C:\Program Files (x86)\Steam\steamapps\common\Arma 3 Tools\Publisher"
::Start AddonBuilder and pack mod
PublisherCmd update /id:623475643 /changeNote:"Auto Update: Changelog will follow!" /path:"%TARGET_FOLDER%"

:: Clear AddonBuilder log folder
ECHO Clearing log files of AddonBuilder.
DEL "C:\Program Files (x86)\Steam\steamapps\common\Arma 3 Tools\Logs" /Q

PAUSE