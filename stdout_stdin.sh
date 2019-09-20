#/bin/bash
#redirect stdout to a file
file="/tmp/data"
head -n1 /etc/passwd > $file

## redirect stdin to a programe
read line < $file
echo "line contains: $line"

## redirect stdout to a file overwriting the file
head -n3 /etc/passwd > $file
echo
echo "contents of $file"
cat $file

##redirect stdout to a file appending to the file
echo "$RANDOM $RANDOM" >> $file
echo "$RANDOM $RANDOM" >> $file
echo
echo "contents of $file"
cat $file


## redirect stdin to a prgram, using FD 0
read line 0< $file
echo
echo "line containes: $line"

## redirect stdout to a file using FD 1, overwritting the file
head -n3 /etc/passwd /etc/hosts /fakefile 1> $file
echo
echo "contents of $file"
cat $file

##redirect stderr to a file using FD(file descriptor) 2.
err_file="/tmp/data.err"
head -n3 /etc/passwd /etc/hosts /fakefile 2> $err_file
echo "contents of $err_file"
cat $err_file

### redirect stdout & stderr to a file
head -n3 /etc/passwd /etc/hosts /fakefile &> $file
echo
echo "contents of $file"
cat $file


### redirect stdout & stderr through a pipe
echo
head -n3 /etc/passwd /etc/hosts /fakefile |& cat -n


## send output to stderr
echo "this is stderr" >&2

##discard output 
echo "discarding output"
head -n3 /etc/passwd /etc/hosts /fakefile > /dev/null

##discard stderr
echo "discarding stderr"
head -n3 /etc/passwd /etc/hosts /fakefile 2> /dev/null


### discarding stdout & stderr
echo "discarding stdout & stderr"
echo
head -n3 /etc/passwd /etc/hosts /fakefile &> /dev/null


## cleanup
echo "cleaning up..."
rm $file $err_file &> /dev/null

