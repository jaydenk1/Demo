#!/bin/sh
docker stats --no-stream && $(echo date) | tee --append stats.txt