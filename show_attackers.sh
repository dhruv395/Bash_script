#!/bin/bash
#count the number of failed logins by ip address
#if there any ips with over limit failures, display the count, ip and location

limit='10'
log_file='$1'

#make sure a file was supplied as an argument
if [ ! -e "$log_file" ]
then
	echo "can't open logfile: $log_file" >&2
	exit 1
fi

#loop through the list of failed attempts and corresponding ip address 
grep "Failed" syslog_sample | awk '{print $(NF - 3)}' | sort | uniq -c | sort -nr | while read count IP
do
	#if the number of failed login attempts  is greater than the limit, display count, IP, and location
	if [ "$count" -gt "$limit" ]
	then
		location=$(geoiplookup $IP)
		echo "$count $IP $location"
	fi
done
exit 0

