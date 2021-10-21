#!/bin/sh
sudo docker stats --no-stream && $(echo date) | tee --append stats.txt
