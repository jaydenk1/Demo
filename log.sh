#!/bin/sh



CPU=$(sudo docker stats --no-stream)
DATE=`date`
echo $DATE >> stats.txt
echo $CPU >> stats.txt

