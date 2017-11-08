#!/bin/bash

file="/00-initial_config-ready.txt"

if [[ -e "$file" ]]; then
	echo "<result>Ready for Config</result>"
elif [[ ! -e $file ]]; then
	echo	 "<result>Already Configured</result>"
fi

exit