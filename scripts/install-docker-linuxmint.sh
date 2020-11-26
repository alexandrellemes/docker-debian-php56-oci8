#!/bin/bash
while true; do
read -p "This script will install latest Docker on your system. Continue? (Y/N)" answer
case $answer in
[Yy]* )
sudo apt-get install apt-transport-https ca-certificates -y
sudo apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D
sudo echo deb https://apt.dockerproject.org/repo ubuntu-xenial main | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
sudo apt-get purge lxc-docker
sudo apt-get install linux-image-extra-$(uname -r) -y
sudo apt-get install docker-engine cgroup-lite apparmor -y
sudo usermod -a -G docker $USER
sudo service docker start
break;;

[Nn]* ) 
echo "Bye"
exit;;
esac
done
