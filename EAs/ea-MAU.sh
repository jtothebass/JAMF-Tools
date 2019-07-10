#!/bin/bash
#checks for MAU and retruns version number

if [ -f /Library/Application\ Support/Microsoft/MAU2.0/Microsoft\ AutoUpdate.app/Contents/Info.plist ]
then
	ExtensionVersion=$(defaults read /Library/Application\ Support/Microsoft/MAU2.0/Microsoft\ AutoUpdate.app/Contents/Info.plist CFBundleShortVersionString)
fi

if [ "$ExtensionVersion" == "" ]
then
	ExtensionVersion="Not Installed"
fi

echo "<result>$ExtensionVersion</result>"

exit 0