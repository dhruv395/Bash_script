#!/bin/bash
  2 ##this script disables, deletes and archives users on the local system
  3 #
  4
  5 archive_dir="/archive"
  6 usage() {
  7         #display the usage and exit
  8         echo "usage: $0 [-dra] user [usern].." >&2
  9         echo "disable a local linux account." >&2
 10         echo "  -d deletes accounts instead of disabling them." >&2
 11         echo "  -r removes the home directory associated with the account." >&2
 12         echo "  -a creates an archive of the home directory associated with the account." >&2
 13 }
 14
 15
 16 #make sure the script is being executed with root or sudo privileges
 17 if [ $UID -ne 0 ]
 18 then
 19         echo "please run with sudo or root privilege" >&2
 20         exit 1
 21 fi
 22
 23 #parse the option
 24 while getopts dra option
 25 do
 26         case $option in
 27                 d) delete_user='true' ;;
 28                 r) remove_option='-r' ;;
 29                 a) archive='true' ;;
 30                 ?) usage ;;
 31         esac
 32 done
 33
 34 #remove the options while leaving the remaining arguments
 35 shift "$(( OPTIND - 1 ))"
 36
 37 #if the user doesn't supply at least one argument, give them help
 38 if [ $# -lt 1 ]
 39 then
 40         usage
 41 fi
 42
 43 #loop through all the usernames supplied as arguments
 44 for username in $@
 45 do
 46         echo "processing user: $username"
 47
 48         #make sure the UID of the account is at least 1000
 49         userid=$(id -u $username)
 50         if [ $userid -lt 1000 ]
 51         then
 52                 echo "refusing to remove the $username account with userid $userid." >&2
 53                 exit 1
 54         fi
 55
 56         #create an archive if requested to do so
 57         if [ "$archive" = 'true' ]
 58         then
 59                 #make sure the archive directory exist
 60                 if [ ! -d  $archive_dir ]
 61                 then
 62                         echo "creating $archive_dir" directory
 63                         mkdir -p $archive_dir
 64                         if [ $? -ne 0 ]
 65                         then
 66                                 echo "the archive directory couldn't be created." >&2
 67                                 exit 1
 68                         fi
 69                 fi
 70
 71                 #archive the user's home directory and move it into the archive directory
 72                 home_dir="/home/$username"
 73                 archive_file="$archive_dir/$username.tar.gz"
 74                 if [ -d $home_dir ]
 75                 then
 76                         echo "archiving $home_dir to $archive_file"
 77                         tar -czf $archive_file $home_dir $> /dev/null
 78                         if [ $? -ne 0 ]
 79                         then
 80                                 echo "couldn't create $archive_file." >&2
 81                                 exit 1
 82                         fi
 83                 else
 84                         echo "$home_dir doesn't exist or is not a directory" >&2
 85                         exit 1
 86                 fi
 87
 88         fi
 89
 90         #delete the user if requested
 91         if [ "$delete_user" = 'true' ]
 92         then
 93                 userdel $remove_option $username
 94
 95                 #check to see if the userdel command succeeded
 96                 #we don't want to tell the user that an account was deleted when it hasn't been
 97                 if [ $? -ne 0 ]
 98                 then
 99                         echo "the account $username was not deleted." >&2
100                         exit 1
101                 fi
102                 echo "the account $username was deleted"
103         else
104                 chage -E 0 $username
105                 if [ $? -ne 0 ]
106                 then
107                         echo "the account $username was not disabled." >&2
108                         exit 1
109                 fi
110                 echo "the account $username was disabled"
111         fi
112 done
113 exit 0

                                           
