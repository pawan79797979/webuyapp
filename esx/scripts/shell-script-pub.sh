#!/bin/bash

sudo yum -y install  firewalld 

# Install Docker
curl -fsSL get.docker.com -o get-docker.sh
sh get-docker.sh
yum update -y
yum install docker -y
systemctl daemon-reload
service docker start


sudo systemctl start firewalld
sudo firewall-cmd --permanent --add-port=8080/tcp
sudo firewall-cmd --permanent --add-port=80/tcp
sudo firewall-cmd --reload


docker container run --name registry.webuy.com/mywebserver  --publish 80:80 -d registry.webuy.com/mywebserver
