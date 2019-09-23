#!/bin/bash
##this script creates a new user on the local system
##you will be prompted to use the username(login), the person and a password
## the username, password and host for the account will be displayed
#make sure the script is being executed with superuser privileges

if [ $UID -ne 0 ]
then
	echo "please use root or sudo user to add user" >&2
	exit 1
fi

if [ $# -lt 1 ]
then
	echo "Usage:$0 user_name [comment]..." >&2
	echo "create an account on the local system with the name of user_name and comments fields of comment" >&2
	exit 1
fi

user_name="$1"

shift
comment="$@"

password="$(date +%s%N | sha256sum | head -c48)"

useradd -c $comment -m $user_name &> /dev/null

## check to see if useradd command succeeded
## we don't want to tell the user that an account was created when it hasn't been
if [ $? -ne 0 ]
then
	echo "the account could not be created" >&2
	exit 1
fi

## set the password
echo "$user_name:$password" | chpasswd &> /dev/null

#check to see if PASSWD command succeeded
if [ $? -ne 0 ]
then
	echo "password for the account could not be set" >&2
	exit 1
fi

## force password change on first login
passwd -e $user_name &> /dev/null

## DISPLAY the username, password and host where the user is created
echo "username: $user_name"
echo "password: $password"
echo "hostname: $HOSTNAME"
exit 0



