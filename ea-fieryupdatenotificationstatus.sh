#!/bin/bash

#get current user
user=`sudo last | grep console | head -1 | awk '{print $1}'`

#Fiery Preference Location
file="/Users/$user/Library/Preferences/com.efi.FieryPrinterDriverUpdater"

#get status
if [[ -e "$file" ]]; then
	cat /Users/$user/Library/Preferences/com.efi.FieryPrinterDriverUpdater | grep NotifyAll=0 | awk '{ print "<result>" $1 "</result>" }'
elif [[ ! -e "$file" ]]; then
	echo	"<result>not present</result>"
fi

exit 0