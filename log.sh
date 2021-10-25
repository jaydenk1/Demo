#!/bin/sh
logs=$(docker inspect --format='{{json .State.Health.Log}}' webserver)
echo $logs  | tr '\r\n' ' ' | jq add >> /home/logs/logs.json

date=`date`
containername=$(docker stats webserver --no-stream --format '{{json .Name}}')
cpu=$(docker stats webserver --no-stream --format '{{json .CPUPerc}}')
mem=$(docker stats webserver --no-stream --format '{{json .MemPerc}}')
state=$(docker inspect --format='{{json .State.Status}}' webserver)
health=$(docker inspect --format='{{json .State.Health.Status}}' webserver)
echo "$date,$containername,$cpu,$mem,$state,$health" >> /home/logs/containerlogs.csv
/bin/sh /home/scripts/csv_to_html.sh /home/logs/containerlogs.csv > /home/logs/containerlogs.html


#column -t -s$'\t' /home/logs/records.tsv 
# echo $health >> /home/logs/resource.json
# echo $logs >> /home/logs/containerlogs.txt