#!/bin/bash
read -p "enter time interval in minutes: " interval
read -p "enter file name: " filename
echo
if [ -f $filename ]
then
        echo "file exist, checking for modfication.."
        find . -name $filename -mmin -$interval
        if [ $? = 0 ]
        then
                echo file has been modified in $interval minutes
        fi
else
        echo " file $filename not found"
