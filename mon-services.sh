#!/bin/bash


while true; do
IFS=$'\n'
service="nginx.service" ###
monlog="/www/monitoring.log" ###
status=$(systemctl is-failed $service)
    if [ "$status" == "inactive" ]; then
    echo "1" ###
    else
	if [ "$status" == "active" ]; then
	    echo "0" ###
#	    curl "https://test.com/monitoring/test/api"
	fi
	for j in $(journalctl -o short-iso -u $service --since "100 min ago" | grep -e 'Started' -e 'Reloaded' | awk '{print $1,$4}' | awk '{sub("Started", "Started / Restarted", $0)}1'); do
	    resdat=$(echo "$j" | awk '{print $1}')
	    resstat=$(echo "$j" | awk '{print substr($0,26)}')
	    echo "$resdat $service was $resstat" >> $monlog
	done
    fi


sleep 60;
done