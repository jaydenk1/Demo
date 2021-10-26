#!/bin/sh

timedatectl set-timezone Pacific/Auckland
mkdir /home && mkdir /home/logs
cp -r /tmp/scripts /home

# ## first Configure install the firewall 
apt-get update  && sudo apt-get -y upgrade
apt install ufw gufw -y 
ufw status > /tmp/ufw-status-old
ufw disable
echo "y" | sudo ufw reset

## inbound rules
ufw default deny incoming
ufw allow http
ufw allow https
ufw allow ssh
ufw allow proto tcp from any to any port 8080
echo 'Y' | ufw enable
echo 'Y' | apt-get install jq

## Install the Docker Container 
apt install -y apt-transport-https software-properties-common ca-certificates curl wget
wget https://download.docker.com/linux/ubuntu/gpg 
apt-key add gpg
apt-get -y update
apt install -y apt-transport-https ca-certificates curl software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu bionic stable"
apt-get -y update
apt-cache policy docker-ce
echo 'Y' | apt install docker-ce
systemctl start docker
systemctl enable docker
apt-get install -y docker-compose
cd /home/scripts
docker-compose up -d
 
## After the install, Pull the nginx Docker container image and run the nginx image
chmod u+x /home/scripts/log.sh
apt-get -y update
apt-get install -y cron
echo "Date,Container,CPU,Memory,State,Health" > /home/logs/containerlogs.csv
systemctl enable cron
mkdir /home/logs/logreset
touch /home/logs/logreset/containerlogsreset.csv
touch /home/logs/logreset/containerlogsreset.html
touch /home/logs/logreset/logsreset.json
touch /home/logs/containerlogs.bak.html

 (crontab -l 2>/dev/null; echo "5 1 * * 7 (sudo cp /home/logs/containerlogs.html /home/logs/containerlogs.bak.html)") | crontab
 (crontab -l 2>/dev/null; echo "5 1 * * 7 (sleep 5; cp /home/logs/logreset/containerlogsreset.csv /home/logs/containerlogs.csv)") | crontab

 (crontab -l 2>/dev/null; echo "5 1 * * 7 (sleep 6; echo "Date,Container,CPU,Memory,State,Health" > /home/logs/containerlogs.csv)") | crontab
 (crontab -l 2>/dev/null; echo "5 1 * * 7 (sleep 5; cp /home/logs/logreset/containerlogsreset.html /home/logs/containerlogs.html)") | crontab
 (crontab -l 2>/dev/null; echo "5 1 * * 7 (sleep 5; cp /home/logs/logreset/logsreset.json /home/logs/logs.json)") | crontab
 
 (crontab -l 2>/dev/null; echo "* * * * * ( /bin/sh /home/scripts/log.sh )") | crontab
 (crontab -l 2>/dev/null; echo "* * * * * ( sleep 10 ; /bin/sh /home/scripts/log.sh )") | crontab
 (crontab -l 2>/dev/null; echo "* * * * * ( sleep 20 ; /bin/sh /home/scripts/log.sh )") | crontab
 (crontab -l 2>/dev/null; echo "* * * * * ( sleep 30 ; /bin/sh /home/scripts/log.sh )") | crontab
 (crontab -l 2>/dev/null; echo "* * * * * ( sleep 40 ; /bin/sh /home/scripts/log.sh )") | crontab
 (crontab -l 2>/dev/null; echo "* * * * * ( sleep 50 ; /bin/sh /home/scripts/log.sh )") | crontab 
 
 
# ## REST API....
apt install -y python3-pip
pip3 install virtualenv
mkdir /home/pyrest
virtualenv /home/pyrest/
cd /home/pyrest
source bin/activate
pip3 install flask
sleep 5s
sudo nohup python3 /home/scripts/api.py &
sleep 10s 
sudo nohup python3 /home/scripts/api.py &