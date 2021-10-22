#!/bin/sh

sudo timedatectl set-timezone Pacific/Auckland
sudo mkdir /home/script
sudo cp -r /tmp/log.sh /home/script/log.sh
sudo mkdir /home/Qriousadmin/log

## first Configure install the firewall 
sudo apt-get update  && sudo apt-get -y upgrade

sudo apt install ufw gufw -y 
sudo ufw status > /tmp/ufw-status-old
sudo ufw disable
echo "y" | sudo ufw reset

## inbound rules
sudo ufw default deny incoming
sudo ufw allow http
sudo ufw allow https
sudo ufw allow ssh

echo 'Y' | sudo ufw enable


## Install the Docker Container 


sudo apt-get update
sudo apt install -y apt-transport-https software-properties-common ca-certificates curl wget
wget https://download.docker.com/linux/ubuntu/gpg 
sudo apt-key add gpg

sudo apt update

sudo apt install apt-transport-https ca-certificates curl software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu bionic stable"
sudo apt update
apt-cache policy docker-ce
echo 'Y' | sudo apt install docker-ce
sudo systemctl start docker
sudo systemctl enable docker


## After the install, Pull the nginx Docker container image and run the nginx image

sudo docker pull nginx
sudo docker run -d --name nginx-server -p 80:80 nginx

## Log the health status and resource usage of the NGINX container every 10 seconds into a log file.
#It also remove and backup log @12.05 am every Sunday


sudo chmod u+x /home/script/log.sh
sudo apt update
sudo apt install cron
sudo systemctl enable cron

(crontab -l 2>/dev/null; echo "5 1 * * 7 (sudo cp /home/Qriousadmin/log/stats.txt /home/Qriousadmin/log/statsbackup.txt)") | crontab
(crontab -l 2>/dev/null; echo "5 1 * * 7 (sudo rm /home/Qriousadmin/log/stats.txt)") | crontab

(crontab -l 2>/dev/null; echo "* * * * * ( /bin/sh /home/script/log.sh )") | crontab
(crontab -l 2>/dev/null; echo "* * * * * ( sleep 10 ; /bin/sh /home/script/log.sh )") | crontab
(crontab -l 2>/dev/null; echo "* * * * * ( sleep 20 ; /bin/sh /home/script/log.sh )") | crontab
(crontab -l 2>/dev/null; echo "* * * * * ( sleep 30 ; /bin/sh /home/script/log.sh )") | crontab
(crontab -l 2>/dev/null; echo "* * * * * ( sleep 40 ; /bin/sh /home/script/log.sh )") | crontab
(crontab -l 2>/dev/null; echo "* * * * * ( sleep 50 ; /bin/sh /home/script/log.sh )") | crontab



## REST API....

sudo docker rm nginx-server --force
sudo docker run -v /home/Qriousadmin:/usr/share/nginx/html/ -d --name nginx-server -p 80:80 nginx

CONTAINER_ID="$(sudo docker ps --no-trunc -aqf "name=nginx-server")"
sudo docker exec -it $CONTAINER_ID bash -c 'apt-get -y update && apt -y install nano'



#sudo docker exec -it $CONTAINER_ID /bin/bash

#curl "file:///mnt/restapi/stats.txt"
#H_STATS="/usr/share/nginx/html"






