#!/bin/bash

file="/Library/PROOF/logo/PROOF_helperlogo.png"

if [[ -e "$file" ]]; then
	echo "<result>true</result>"
elif [[ ! -e $file ]]; then
	echo	 "<result>false</result>"
fi

exit