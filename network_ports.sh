#!/bin/bash
#this script shows the open network ports on a system
#use -4 as an argument to limit to tcpv4 ports

netstat -tunl $1 | grep ':' | awk '{print $4}' | awk -F ':' '{print $NF}'

#or to remove header from ouput result
#netstat -tunl $1 | grep -Ev 'Active|Proto' | awk '{print $4}' | awk -F ':' '{print $NF}'
