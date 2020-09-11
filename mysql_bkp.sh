#!/bin/bash
date=$(date +\%d-\%m-\%y_\%H-\%M-\%S)
bkp_dir="/home/ubuntu/backup/mysql"

echo "taking mysql bkp"
cd  $bkp_dir
sudo mysqldump  -u root -p<password> --lock-tables=false <dbname> | gzip > db1_$date.sql.gz
sudo mysqldump -u root -p<password> --lock-tables=false  <dbname> | gzip >  db2_$date.sql.gz

echo "removing old backup"
find . -type f -iname \*.gz -mtime +14 -exec rm -rf {} \;
