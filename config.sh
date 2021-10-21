#!/bin/sh

sudo timedatectl set-timezone Pacific/Auckland

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

## Log the health status and resource usage of the NGINX container every 10 seconds into a log file
#update server & docker time zone to Auckland

#CONTAINER_ID="$(sudo docker ps --no-trunc -aqf "name=nginx-server")"
sudo chmod u+x /tmp/log.sh
sudo apt update
sudo apt install cron
sudo systemctl enable cron
#sudo /bin/bash -c 'echo "*/10 * * * * * /bin/sh /tmp/log.sh" >> /etc/crontab'
#echo "* * * * * bash /tmp/log.sh 2>&1 >> /var/log/somelog.log" >> /var/spool/cron/root 
#*/10 * * * * * sudo /tmp/log.sh >/dev/null 2>&1


#sudo sh -c "while true; do docker stats --no-stream && $(echo date) | tee --append stats.txt; sleep 10; done"
#sudo echo '1' && "0/10 * * * * * /tmp/log.sh" | sudo crontab -e
#* * * * * for i in {1..6}; do /tmp/log.sh & sleep 10; done
#10 seconds job for cron, supposely chuck this on the crontab but not working
#       * * * * * for i in {1..6}; do sudo  /bin/sh /tmp/log.sh & sleep 10; done
# cron generator 0/10 0 0 ? * * *


#A lot of formula to trigger 10secs on cron has fail like for example */10 * * * * *, cron generator 0/10 0 0 ? * * *
# or '* * * * * for i in {1..6}; do sudo  /bin/sh /tmp/log.sh & sleep 10; done'
#However this is only one that work, by however will have a delay for 1 min before prducing data.
#In additional to this, noted that this is not the docker stats but it does producing date.
#Found out that it is not possible to query docker stats through cron on ubuntu
(crontab -l 2>/dev/null; echo "* * * * * ( /bin/sh /tmp/log.sh )") | crontab
(crontab -l 2>/dev/null; echo "* * * * * ( sleep 10 ; /bin/sh /tmp/log.sh )") | crontab
(crontab -l 2>/dev/null; echo "* * * * * ( sleep 20 ; /bin/sh /tmp/log.sh )") | crontab
(crontab -l 2>/dev/null; echo "* * * * * ( sleep 30 ; /bin/sh /tmp/log.sh )") | crontab
(crontab -l 2>/dev/null; echo "* * * * * ( sleep 40 ; /bin/sh /tmp/log.sh )") | crontab
(crontab -l 2>/dev/null; echo "* * * * * ( sleep 50 ; /bin/sh /tmp/log.sh )") | crontab

## REST API....





