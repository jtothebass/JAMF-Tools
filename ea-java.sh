#!/bin/bash

echo "<result>`/usr/bin/java -version 2>&1 > /dev/null | awk '/version/ {gsub(/[\"\"]/,""); print $NF}'`</result>"

exit 0