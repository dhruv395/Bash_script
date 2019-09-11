#!/bin/bash
##this script creates an account on the local system
## you will be prompted for username and password

##ask for the username
read -p 'Enter the username to create: ' USER_NAME

##ask for the real name
read -p 'Enter the name of the person who this account is for: ' COMMENT

##ask for the password
read -sp 'Enter the password to use for the account: ' PASSWORD

##create the user in rhel
useradd -c "$COMMENT" -m $USER_NAME


##set the password for the user
echo $PASSWORD | passwd --stdin $USER_NAME
#read -p "Enter the Password for $USER_NAME `passwd $USER_NAME` "

##FORCE password change on first login
passwd -e $USER_NAME
