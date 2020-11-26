# Debian 9
FROM debian:jessie
#FROM debian:Wheezy
#FROM ubuntu:latest

MAINTAINER Alexandre LLemes <alexandre.llemes@gmail.com>

#Variáveis de ambiente
ARG HOME
ARG USERPROXY
ARG PASSWD
ARG PROJETO
ARG PHP_VERSION

#ENV PROXY_SERVER proxy.projetco.com.br:8080
#ENV URL_PROXY ${USERPROXY}:${PASSWD}@${PROXY_SERVER}


#Configuração de proxy
#ENV http_proxy http://${URL_PROXY}
#ENV ftp_proxy http://${URL_PROXY}
#ENV all_proxy http://${URL_PROXY}
#ENV https_proxy http://${URL_PROXY}
#ENV no_proxy localhost,127.0.0.1
#ENV HTTP_PROXY http://${URL_PROXY}
#ENV FTP_PROXY http://${URL_PROXY}
#ENV ALL_PROXY http://${URL_PROXY}
#ENV HTTPS_PROXY http://${URL_PROXY}

# Realiza a cópia do resolv para acessar a internet.
#COPY resolv.conf /etc/

# Atualiza o sistema
RUN apt-get update
RUN apt-get upgrade -y

# Instala o composer
COPY files/php-apache/composer.phar /usr/bin/composer

# Define o timezone.
ENV TZ 'America/Sao_Paulo'
RUN echo $TZ > /etc/timezone && \
    ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && \
    apt-get update && apt-get install -y tzdata && \
    dpkg-reconfigure -f noninteractive tzdata

RUN apt-get install -y apt-utils apache2 php5 libapache2-mod-php5

RUN /etc/init.d/apache2 restart

#RUN apt-cache search php5
#
#RUN apt-get install php5-mysql php5-curl php5-gd php5-intl php-pear php5-imagick php5-imap php5-mcrypt php5-memcache php5-ming php5-ps php5-pspell php5-recode php5-snmp php5-sqlite php5-tidy php5-xmlrpc php5-xsl

RUN /etc/init.d/apache2 restart

# Enable Apache2 modules
RUN a2enmod rewrite
RUN a2enmod expires

# Habilita modulos PHP

RUN php -v
RUN php -m | grep -E 'memcache|oci8|uploadprogress|mcrypt'

# Set up the Apache2 environment variables
ENV APACHE_RUN_USER www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_LOG_DIR /var/log/apache2
ENV APACHE_LOCK_DIR /var/lock/apache2
ENV APACHE_PID_FILE /var/run/apache2.pid

WORKDIR /var/www/

EXPOSE 80 443

# Run Apache2 in Foreground
#CMD /usr/sbin/apache2 -D FOREGROUND
