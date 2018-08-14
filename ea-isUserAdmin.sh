#!/bin/bash

#get logged in user
USER=`ls -l /dev/console | awk '{print $3}'`

#get groups and search for admin
if id -Gn $USER | grep -q -w admin;
then
	echo "<result>User is Admin</result>";
else
	echo "<result>User is not Admin</result>";
fi

exit 0