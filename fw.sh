#!/bin/sh

sudo timedatectl set-timezone Pacific/Auckland

## first Configure install the firewall 
sudo apt-get update  && sudo apt-get -y upgrade

sudo apt install ufw gufw -y 
sudo ufw status
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

sudo apt install -y docker-ce
sudo systemctl start docker
sudo systemctl enable docker


## After the install, Pull the nginx Docker container image and run the nginx image

sudo docker pull nginx
sudo docker run -d --name nginx-server -p 80:80 nginx

## Log the health status and resource usage of the NGINX container every 10 seconds into a log file
#update server & docker time zone to Auckland

CONTAINER_ID="$(sudo docker ps --no-trunc -aqf "name=nginx-server")"

#sudo apt install cron
#sudo systemctl enable cron
#sudo apt install libwww-perl

sudo sh -c "while true; do docker stats --no-stream && $(echo date) | tee --append stats.txt; sleep 10; done" > /tmp/output.log 



#sudo docker run -d --nginx-server "curl --fail http://localhost:8091/pools || exit 1" --health-interval=5s --timeout=3s

## REST API..... || 

