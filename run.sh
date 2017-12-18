#!/bin/bash

# Compila a imagem
docker build -t sei-docker-debian --build-arg HOME=$HOME --build-arg USERPROXY=USUARIO.REDE --build-arg PASSWD=SENHA.REDE --build-arg PROJETO=sei .

# Fecha o container
docker stop apache

# Apaga o container
docker rm apache

# Cria o container
docker run -it --name apache -p 80:80 --network=host --privileged -v $HOME/discoDocker/apache/projetos/:/var/www/html/ -v $HOME/discoDocker/apache/conf/:/etc/apache2/sites-available -v /tmp:/tmp -d sei-docker-debian:latest

# Habilita o ambiente seides.intra.goias.gov.br
docker exec -it apache a2ensite seides.intra.goias.gov.br

# Reinicia os servicos
docker exec -it apache /etc/init.d/apache2 restart
docker exec -it apache /etc/init.d/memcached restart
