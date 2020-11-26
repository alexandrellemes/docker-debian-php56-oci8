#!/bin/bash

# Instalacao a partir do repositorio UBUNTU
# Nao esta disponivel no repositorio oficial Docker a versao para Ubuntu Bionic

sudo apt-get update

sudo apt install docker.io

sudo systemctl start docker
sudo systemctl enable docker

sudo docker --version

# Instalacao de aplicativos
sudo apt-get install -y vim htop curl wget iptraf

sudo apt-get install -y tzdata
sudo cp ./system/timezone /etc/timezone
sudo dpkg-reconfigure -f noninteractive tzdata

#ln -s ~/Área\ de\ Trabalho/ ~/Desktop
#cp desktop/savv_lancador.desktop ~/Desktop

set -e

VERSION="1.25.4"
IMAGE="docker/compose:$VERSION"

sudo curl -L https://github.com/docker/compose/releases/download/$VERSION/docker-compose-`uname -s`-`uname -m` -o /usr/bin/docker-compose

sudo chmod +x /usr/bin/docker-compose

sudo docker-compose --version

# Insere os containers nos servicos do ubuntu up/down
# Se estiver utilizando o Docker-compose verificar o service do mesmo.
#sudo cp system/savv-docker-* /lib/systemd/system

#sudo ln -s /lib/systemd/system/savv-docker-apache.service /etc/systemd/system/multi-user-target.wants/savv-docker-apache.service

#sudo ln -s /lib/systemd/system/savv-docker-postgres.service /etc/systemd/system/multi-user-target.wants/savv-docker-postgres.service

#
#sudo systemctl unmask docker.service
#sudo systemctl unmask docker.socket
#sudo systemctl start docker.service
#sudo systemctl status docker
#
