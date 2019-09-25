#!/bin/bash

##what's getopts?
#getopts commands must be used inside a while loop so all options are parsed. Then immediately after the getopts keyword, we defined the possible options our script will accept. They are l, h and finally a.

#What does the colon after this last option means? It is the way we tell getopts that the option requires an argument. Each parsed option will be stored inside the $OPTION variable, while an argument, when present, will become the value of the$OPTARG one. 

#Each option is managed inside a case statement, with a final '?' case that will be matched whenever an option that doesn't exist will be provided. In that case we will just echo the user the correct script usage and exit with an error code.

###
#In this e.g; the user can set the password length with -l and add a special character with -s. Verbose mode can be enabled with -v



usage() {
	echo "usage: $0 [-vs] [-l lenght]" >&2
	echo "generate a random password"
	echo "  -l lenght specify the password lenght"
	echo "  -s append a special character to the password"
	echo "  -v increase verbosity"
	exit 1
}

log() {
	local message="$@"
	if [ "$verbose" = 'true' ]
	then
		echo $message
	fi
}


#set a default password length
length=48

while getopts vl:s option
do
	case $option in
		v)
			verbose='true'
			echo "verbose mode on"
			;;
		l)
			length="$optarg"
			;;
		s)
			use_special_character='true'
			;;
		?)
			usage
			;;
	esac
done

echo "number of arguments: $#"
echo "all args: $@"
echo "first arg: $1"
echo second arg: $2
echo "third arg: $3"

#inspect OPTIND
echo "optind: $OPTIND"

#remove the options while leaving the remaining arguments
shift "$(( OPTIND - 1 ))"

echo after the shift:
echo "all args: $@"
echo "first arg: $1"
echo second arg: $2
echo "third arg: $3"

if [ $# -gt 0 ]
then 
	usage
fi

log 'generating a password'

password=$(date +%s%N$RANDOM$RANDOM)

#append a special character if requested to do so
if [ "$use_special_character" = 'true' ]
then
	log 'selecting a random special character..'
	special_character=$(echo '!@#&()-+=' | fold -w1 | shuf | head -c1)
	password="$password$special_character"
fi

log 'done'
log 'here is the password:'

#display the password
echo "$password"
exit 0

