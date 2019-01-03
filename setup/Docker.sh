#!/bin/sh
sudo apt-get update
sudo apt-get install apt-transport-https -y
sudo apt-get install ca-certificates -y
sudo apt-get install curl -y
sudo apt-get install software-properties-common -y
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo apt-key fingerprint 0EBFCD88
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
sudo apt-get update
sudo apt-get install docker-ce -y
sudo apt install docker-compose -y
docker -v
sudo usermod -a -G docker $USER
exit