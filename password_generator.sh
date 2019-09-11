#!/bin/bash
## 2 random number together
password=$RANDOM
echo $password$password

##current date and time as the basis for the password
password=$(date +%s)
echo $password
