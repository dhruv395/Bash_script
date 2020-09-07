#!/bin/bash

echo "check nrpe service"
#if sudo systemctl status nrpe.service | grep -o "inactive (dead)"; then sudo systemctl start nrpe.service; fi
if (( $(ps aux | grep nagios | grep -v grep | grep  nagios | wc -l) > 0 )); then echo "service running"; else sudo systemctl start nrpe.service; fi


#echo "check ds_agent service"
#if /etc/init.d/service status | grep -w "Active: inactive (dead)"; then sudo /etc/init.d/service start; fi
#if (( $(ps aux | grep service | grep -v grep | grep ds_agent | wc -l) > 0 )); then echo "ds_agent is running"; else sudo /etc/init.d/service start; fi
if /etc/init.d/service status | grep -E 'failed|inactive'; then sudo /etc/init.d/service start; fi

## logstash
if (( $(ps aux | grep logstash.Logstash | grep -v grep | wc -l) > 0 )); then echo "logstash is running"; else /etc/init.d/logstash start; fi
