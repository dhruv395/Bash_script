## this script check tomcat and elasticsearch thread every 30 seconds and save in csv format

#!/bin/bash
currentdate="$(date +'%d-%m-%Y_%H:%M:%S')"
for i in $(ps -eLf | grep tomcat | wc -l)
  do
     echo "Tomcat1 thread ,"" $currentdate ,  ""$i" >> /home/ubuntu/tom1_threads.csv
done
## elk thread

for j in $(ps -eLf | grep elk | wc -l)
 do
 echo "ELK thread ,"" $currentdate ,  ""$j" >> /home/ubuntu/tom1_threads.csv
done


sleep 30

currentdate="$(date +'%d-%m-%Y_%H:%M:%S')"
for i in $(ps -eLf | grep tomcat | wc -l)
  do
     echo "Tomcat1 thread ,"" $currentdate ,  ""$i" >> /home/ubuntu/tom1_threads.csv
done

##elk
for j in $(ps -eLf | grep elk | wc -l)
 do
 echo "ELK thread ,"" $currentdate ,  ""$j" >> /home/ubuntu/tom1_threads.csv
done


########## then we need another script to send email 

#!/bin/bash

currentdate="$(date +'%d-%m-%Y_%H-%M-%S')"
echo "sending email"
mail -A /home/ubuntu/tom1_threads.csv -s "Tom1 thread count for $currentdate: " abc@raytech.com,efg@raytech.com < /dev/null
echo > /home/ubuntu/tom1_threads.csv

