#!/bin/bash

#get current user
user=`sudo last | grep console | head -1 | awk '{print $1}'`

#Check MAU Update Status
MAUStatus=""
if [ -f /Users/$user/Library/Preferences/com.microsoft.autoupdate2.plist ]
	then
		MAUStatus=$(defaults read /Users/$user/Library/Preferences/com.microsoft.autoupdate2.plist HowToCheck)
fi

echo "<result>$MAUStatus</result>"

exit 0
