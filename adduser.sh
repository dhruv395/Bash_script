#!/bin/bash
##this script creates a new user on the local system
##you will be prompted to use the username(login), the person and a password
## the username, password and host for the account will be displayed

#make sure the script is being executed with superuser privileges
if [ $UID -ne 0 ]
then
        echo "please run with sudo or as root"
        exit 1
fi

## get the username/login
read -p 'Enter the username to create: ' USER_NAME

#get the real name
#read -p 'Enter the name of the person or application that will be using this account: ' COMMENT

# get the password
#read -p 'Enter the password to use for the account: ' PASSWORD

##create the account for rhel
#useradd -c "$COMMENT" -p $PASSWORD -m $USER_NAME

#create the account for ubuntu
adduser $USER_NAME


## check to see if useradd command succeeded
## we don't want to tell the user that an account was created when it hasn't been
if [ "$?" -ne 0 ]
then
        echo "the account could not be created"
        exit 1
fi

## set the password
#echo $PASSWORD | passwd --stdin $USER_NAME

#check to see if PASSWD command succeeded
#if [ "$?" -ne 0 ]
#then
#       echo "password couldn't be set"
#       exit 1
#fi

## force password change on first login
passwd -e $USER_NAME

## DISPLAY the username, password and host where the user is created
-- INSERT --               
