#!/bin/bash

#display the username and uid of the user executing this script
#display if the user is ubuntu user or not

#display the uid
echo "ur uid is $UID"

#only display if UID doesn't match 1000
uid_test='1000'

if [ $UID -ne $uid_test ]
then
        echo "ur uid doesn't match $uid_test"
        exit 1

fi

##display username
username=$(id -un)

#test if the command succeeded
if [ $? -ne 0 ]
then
        echo "id command didn't execute"
        exit 1
fi

echo "ur username is $username"


##you can use string test conditional
username_to_test='ubuntu'
if [ $username = $username_to_test ]
then
        echo "username macthes $username_to_test"
fi

if [ $username != $username_to_test ]
then
        echo "username doesn't match $username_to_test"
        exit 1
fi
exit 0
