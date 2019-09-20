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


