#!/bin/bash
#log() {
#	local message="$@"
#	if [ "$verbose" = 'true' ]
#	then
#		echo "$message"
#	fi

#}
#verbose='true'
#log 'hello'
#verbose='true'
#log 'how are u'


#log() {
#	local verbose="$1"
#	shift
#        local message="$@"
#        if [ "$verbose" = 'true' ]
#        then
#                echo "$message"
#        fi

#}

#log  'hello'
#log 'true' 'how are u'


log() {
	#this function sends a message to syslog and to standard output if verbose is true
        local message="$@"
        if [ "$verbose" = 'true' ]
        then
                echo "$message"
        fi
	logger -t function.sh $message
}

backup_file() {
	#this function creates a backup file. Returns a non zero status on error
	local file="$1"

	#make sure the file exist
	if [ -f $file ]
	then
		local backup_file="/var/tmp/$(basename $file).$(date +%F-%N)"
		log "backing up $file to $backup_file"

		#the exit status of the function will be the exit status of cp command
		cp -p $file $backup_file
	else
		#the file doesn't exist, so return a non zero exit status
		return 1
	fi
}


readonly verbose='true'
log 'hello'
log 'how are you'

backup_file '/etc/passwd'

#make a decision based on the exit status of the function
if [ $? -eq 0 ]
then
	log "file backup succeeded"
else
	log "file backup failed"
fi

