#!/bin/bash
#this script demonstrate case statement 
#if [ $1 = start ]
#then
#	echo starting..
#elif [ $1 = stop ]
#then
#	echo stopping
#elif [ $1 = status ]
#then
#	echo status
#else
#	echo supply a valid option
#	exit 1
#fi

case $1 in
	start)
		echo "starting.."
		;;
	stop)
		echo "stopping.."
		;;
	status|state)
		echo "status:"
		;;

	*)
		echo "supply a valid option" >&2
		exit 1
		;;
	esac



