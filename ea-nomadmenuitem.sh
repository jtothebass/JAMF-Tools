#!/bin/bash

#get current user
user=`sudo last | grep console | head -1 | awk '{print $1}'`

#Find NoMAD Login Item
defaults read /Users/$user/Library/Preferences/com.apple.loginitems.plist | grep "NoMAD" |awk '{ print "<result>" $3 "</result>" }'

exit 0