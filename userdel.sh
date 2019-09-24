#!/bin/bash
#this script deletes a user
#run as root
if [ $UID -ne 0 ]
then
	echo "please run with sudo or as root" >&2
	exit 1
fi

#assume the first argument is the user to delete
user="$1"

#delete the user
userdel $user

#make sure the user got deleted
if [ $? -ne 0 ]
then
	echo "the user wasn't deleted" >&2
	exit 1
fi

#tell the user got deleted
echo "the account $user got deleted"
exit 0



