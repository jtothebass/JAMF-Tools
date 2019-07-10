#!/bin/bash
#
#
# PROOF InstallGoogleFileStream.sh
# James Tommey
# first created March 2018
# Installs Latest Google Drive File Stream App
# 
#
########################################################################################
########################################################################################

scriptname=InstallGoogleFileStream
scriptversion=1.0

#changes
#1.0 - Migrated from InstallGoogleFileStream.sh by  Brian Monroe
#
#
########################################################################################
## standard variables
########################################################################################

scripttitle="PROOF $scriptname script"
logpath=/Library/PROOF/secure/logs
logfile=/Library/PROOF/secure/logs/$scriptname.log
oldlogfile=/Library/PROOF/logs/$scriptname.log
logsymlink=/Library/Logs/PROOF

########################################################################################
## standard functions
########################################################################################

writelog()
{
        # writes to $logfile
        local logdata=$1
        local echologdata=$2
        logdate=`date "+%Y.%m.%d"`
        logtime=`date "+%H:%M"`
        echo $logdate" "$logtime" $logdata"
}

writelogspace()
{
        # writes a blank line in the log
        echo ""
}

setuplogsecure()
{
        # check log directory is in place, create if not
        if [ ! -d $logpath ]; then
        mkdir -p $logpath
        chown root:admin $logpath
        chmod -R 770 $logpath
        fi

        if [ ! -h $logsymlink ]; then
        ln -s $logpath $logsymlink
        fi

        # check old log is there, move to secure if present
        if [ -f $oldlogfile ]; then
        mv $oldlogfile $logpath
        fi

        # check log is there, create new if not
        if [ ! -f $logfile ]; then
        printf "$scriptname"'\n' > $logfile
        printf "0 means success, 1 means there was an issue"'\n''\n' >> $logfile
        fi
}

setuplogsecure
########################################################################################



########################################################################################
## script variables
########################################################################################

SupportContactInfo="helpdesk@proof-advertising.com"
dmgfile="GoogleDriveFileStream.dmg"
logfile="/Library/Logs/GoogleFileStreamInstallScript.log"
url="https://dl.google.com/drive-file-stream/GoogleDriveFileStream.dmg"
user=`ls -l /dev/console | cut -d " " -f 4`

########################################################################################
## script functions
########################################################################################

killjamfhelper()
{
	# kill jamf helper
	if [[ $jamfhelperrunning != "" ]]
	then
	killall jamfHelper
	fi
}


########################################################################################
## script start
########################################################################################

# echoing output to log file from here
{

writelog "**Starting $scripttitle**"
writelog "PROOF Script Version = "$scriptversion""

writelog "Installing latest version of File Stream for $user..."

#Downloading Google File Stream

writelog "Downloading the latest version of File Stream from Google's servers"
/usr/bin/curl -k -o /tmp/$dmgfile $url
writelog "mounting DMG"
/usr/bin/hdiutil attach /tmp/$dmgfile -nobrowse -quiet

#Installing Google File Stream
writelog "Installing Google File Stream..."
/usr/sbin/installer -pkg /Volumes/Install\ Google\ Drive\ File\ Stream/GoogleDriveFileStream.pkg -target /

#Cleaning up

writelog "Cleaning up..."

#Unmount DMG
writelog "Unmounting DMG"
/usr/bin/hdiutil detach $(/bin/df | /usr/bin/grep "Install Google File Stream" | awk '{print $1}') -quiet

#Deleting tmp files
writelog "Removing tmp files"
rm -fv /tmp/$dmgfile
/bin/sleep 3

# Launching Google File Stream
writelog "Launching Google File Stream"
open -a /Applications/Google\ Drive\ File\ Stream.app/


########################################################################################
## script finish
########################################################################################

writelog "**Finished $scripttitle**"
writelogspace

# stop echoing output to log file
} 2>&1 | tee -a $logfile

exit 0