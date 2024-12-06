#!/bin/bash


while true; do
service="nginx.service"
monlog="/www/monitoring.log"
status=$(systemctl is-failed $service)
    if [ "$status" == "inactive" ]; then
    echo "1"
    else
	if [ "$status" == "active" ]; then
	    echo "0"
#	    curl "https://test.com/monitoring/test/api"
	fi
	
	IFS=$'\n'
    fi


sleep 60;
done