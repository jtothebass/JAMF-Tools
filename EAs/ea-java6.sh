#!/bin/bash

#Check if java_home is defined
javaHome=/usr/libexec/java_home 2> /dev/null;

if [ ! -z $javaHome ]
then vers=java -version 2>&1  | grep "java version" | awk '{print substr($3,2,length($3)-2);}'\ echo "<result>$vers</result>"
else echo "<result>Not Installed</result>"
fi