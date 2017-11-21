#!/bin/sh

jamf removeMDMProfile
rm -rf /var/db/ConfigurationProfiles
sleep 20
jamf mdm
sleep 20
jamf manage
sleep 20
jamf mdm -userLevelMdm