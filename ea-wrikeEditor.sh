#!/bin/bash

user=`ls -l /dev/console | awk '{print $3}'`
wrike=/Users/$user/Library/Wrike/WrikeDocumentEditorClient.app/Contents/MacOS/WrikeDocumentEditorClient

#is wrike editor present

if [ ! -e "$wrike" ]; then
	echo "<result>False</result>"
elif [ -e "$wrike" ]; then
	echo "<result>True</result>"
fi

exit 0