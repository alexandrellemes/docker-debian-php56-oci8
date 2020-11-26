#!/bin/bash

echo 'Excluir maquinas ... fase 1'
sudo docker ps -a | awk '{ print $14 }' | xargs sudo docker rm $0
echo 'Excluir maquinas ... fase 2'
sudo docker ps -a | awk '{ print $15 }' | xargs sudo docker rm $0

echo 'Monta os containers...'
sudo docker-compose up -d --build

echo 'Modulos habilitados...'
sudo docker-compose exec php-apache php -m | grep -E 'memcache|oci8|uploadprogress|mcrypt|xdebug'

echo 'Habilita o site sample.local'
sudo docker-compose exec php-apache sh -c "a2ensite sample.local"

echo 'Reinicia o apache2'
sudo docker-compose exec php-apache sh -c "service apache2 reload"

#sudo docker system prune -a

