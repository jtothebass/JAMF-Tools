#!/bin/bash

#This script checks for a filevault securetoken for 
#the current logged in user.

#variables

loggedInUser=`ls -l /dev/console | awk '{print $3}'`
adminUser=prfadm
adminPass=TarkoRAi

# Get SecureToken Status

secreTokeStatus=`sysadminctl -adminUser $adminUser -adminPassword $adminPass -secureTokenStatus $loggedInUser | grep "ENABLED" |awk '{print $4}'`

# EA reporting intelligence

if [[ "$secureTokenStatus" == "ENABLED" ]]; then
	echo "<result>True</result>" }
else [[ "$secureTokenStatus" != "ENABLED"]]; then
	echo "<result>False</result>"
fi

exit 0