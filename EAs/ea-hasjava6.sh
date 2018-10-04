#!/bin/bash

java=/usr/bin/java

#is java 6 present

if [ ! -e "$java" ]; then
	echo "<result>False</result>"
elif [ -e "$java" ]; then
	echo "<result>True</result>"
fi

exit 0