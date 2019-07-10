#!/bin/bash
#
#
# PROOF uninstallGoogleDriveFS.sh
# James Tommey
# first created March 2018
# Removes the Google Drive File Stream App and all User Data
# 
#
########################################################################################
########################################################################################

scriptname=UninstallGoogleDriveFS
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

#Quitting Google Drive FileStream
writelog "Killing Google Drive FileStream"
killall "Google Drive File Stream"

#Removing Google Drive FileStream
writelog "Removing Google File Stream..."
rm -rf /Applications/Google\ Drive\ File\ Stream
rm -rf /Users/$user/Library/Application Support/Google/DriveFS
rm -rf /Users/$user/Google\ Drive

########################################################################################
## script finish
########################################################################################

writelog "**Finished $scripttitle**"
writelogspace

# stop echoing output to log file
} 2>&1 | tee -a $logfile

exit 0