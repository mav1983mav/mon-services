#!/bin/bash

#get status service: active - sent GET to https, inactive - nothing
#if service reload and restart - writing log
#if host not available - writing log

while true; do
service="nginx.service"
monlog="/www/monitoring.log"
status=$(systemctl is-failed $service)
    if [ "$status" == "inactive" ]; then
    echo "nothing"
    else
	if [ "$status" == "active" ]; then
	    echo ""
#	    curl "https://test.com/monitoring/test/api"
	fi

	IFS=$'\n'
	for j in $(journalctl -o short-iso -u $service --since "1 min ago" | grep -e 'Started' -e 'Reloaded' | awk '{print $1,$4}' | awk '{sub("Started", "Started / Restarted", $0)}1'); do
	resdat=$(echo "$j" | awk '{print $1}')
	resstat=$(echo "$j" | awk '{print substr($0,26)}')
	echo "$resdat $service was $resstat" >> $monlog
	done
    fi
    
    datecur=$(date '+%Y-%m-%dT%H:%M:%S%z')
    testmail=$(curl -Is https://mail.ru | head -n 1 | awk '{print $2}')
    testping=$(ping -c 1 8.8.8.8 | grep loss | awk '{print $6}' | cut -b -1)
    if [ "$testmail" == "200" ] && [ "$testping" == "0" ]; then
	echo ""
    else
	echo "$datecur host $HOSTNAME not available" >> $monlog
    fi
    sleep 60
done
