#! /bin/sh
clear

if [ -e ~/Library/Preferences/com.tomtecsolutions.USB-Catalyst.updatePermitted ]
then
echo TomTec Solutions has verified the update. Proceeding.
rm ~/Library/Preferences/com.tomtecsolutions.USB-Catalyst.updatePermitted
sleep 1
clear
else
echo ================================================================================
echo USB Catalyst Update Script is not intended to run in this manner. Exiting...
echo ================================================================================
exit -1
fi
pathToCatalyst=`defaults read com.tomtecsolutions.USB-Catalyst pathToCatalyst`
echo ================================================================================
echo USB Catalyst Updater Script
echo Copyright © 2014, Thomas Jones, TomTec Solutions. All rights reserved.
echo ================================================================================
echo Quitting current instance of USB Catalyst...
killall "USB Catalyst"
echo Quit! Copying updated version of USB Catalyst to current location of old version
rm -r "$pathToCatalyst/USB Catalyst.app"
cp -rf "/tmp/USB Catalyst.app" "$pathToCatalyst"
echo Copied! Removing old version...
rm -r "/tmp/USB Catalyst.app"
echo Removed! Setting \'application is update\' parameters...
defaults write com.tomtecsolutions.USB-Catalyst ApplicationIsUpdate 1
echo Set! Opening new version...
sleep 1
open "$pathToCatalyst/USB Catalyst.app"
echo Opened!
echo ================================================================================
echo The update has finished.
echo USB Catalyst will quit Terminal automatically. Please wait.
echo ================================================================================