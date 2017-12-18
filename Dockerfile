FROM debian:jessie

MAINTAINER Alexandre LLemes <alexandre.llemes@gmail.com>

#Variáveis de ambiente
ARG HOME
ARG USERPROXY
ARG PASSWD
ARG PROJETO

ENV PROXY_SERVER proxy.projetco.com.br:8080
ENV URL_PROXY ${USERPROXY}:${PASSWD}@${PROXY_SERVER}

#Configuração de proxy
ENV http_proxy http://${URL_PROXY}
ENV ftp_proxy http://${URL_PROXY}
ENV all_proxy http://${URL_PROXY}
ENV https_proxy http://${URL_PROXY}
ENV no_proxy localhost,127.0.0.1
ENV HTTP_PROXY http://${URL_PROXY}
ENV FTP_PROXY http://${URL_PROXY}
ENV ALL_PROXY http://${URL_PROXY}
ENV HTTPS_PROXY http://${URL_PROXY}

# Realiza a cópia do resolv para acessar a internet.
#COPY resolv.conf /etc/

# Atualiza o sistema
RUN apt-get update
RUN apt-get upgrade -y

RUN apt-get install apt-utils -y

# Install Apache2 / PHP 5.6 & Co.
RUN apt-get update
RUN apt-get install apache2 apache2-utils tree memcached htop -y
RUN apt-get install wget gcc gcc+ make libaio1 php5-dev build-essential php-pear unzip libaio1 ssh \
    vim lsof net-tools iputils-ping wget bash-completion libapache2-mod-php5 \
    php5 php5-cgi libgv-php5 php5-common php5-curl php5-fpm php5-gd php5-ldap php5-mcrypt php5-xmlrpc \
    php5-xsl php5-xdebug libphp-phpmailer pear-channels php5-apcu php-cas php-db php-fpdf php5-imagick \
    php-image-text php-mail php5-memcached php5-memcache php5-solr php-soap php5-mysql php5-pgsql \
    php5-odbc -y

# Install the Oracle Instant Client
ADD oracle/oracle-instantclient12.1-basic_12.1.0.2.0-2_amd64.deb /tmp
ADD oracle/oracle-instantclient12.1-devel_12.1.0.2.0-2_amd64.deb /tmp
ADD oracle/oracle-instantclient12.1-sqlplus_12.1.0.2.0-2_amd64.deb /tmp
RUN dpkg -i /tmp/oracle-instantclient12.1-basic_12.1.0.2.0-2_amd64.deb
RUN dpkg -i /tmp/oracle-instantclient12.1-devel_12.1.0.2.0-2_amd64.deb
RUN dpkg -i /tmp/oracle-instantclient12.1-sqlplus_12.1.0.2.0-2_amd64.deb
RUN rm -rf /tmp/oracle-instantclient12.1-*.deb

# Set up the Oracle environment variables
ENV LD_LIBRARY_PATH /usr/lib/oracle/12.1/client64/lib/
ENV ORACLE_HOME /usr/lib/oracle/12.1/client64/lib/

# Install the OCI8 PHP extension
#RUN pear config-set http_proxy http://${URL_PROXY}
RUN echo 'instantclient,/usr/lib/oracle/12.1/client64/lib' | pecl install -f oci8-2.0.12

# Configuracao XDEBUG e OCI8.
COPY xdebug.ini /etc/php5/mods-available/
COPY oci8.ini /etc/php5/mods-available/

#RUN echo "extension=oci8.so" > /etc/php5/apache2/conf.d/30-oci8.ini

# Desabilita a obrigatoriedade do uso da tag <?php. Pode-se usar: <?
RUN echo "short_open_tag = On" >> /etc/php5/apache2/php.ini
RUN echo "short_open_tag = On" >> /etc/php5/cli/php.ini

# Insere a pasta (infra_php) no path de pesquisa.
RUN echo 'include_path = ".:/var/www/html/sei_php/infra_php"' >> /etc/php5/apache2/php.ini
RUN echo 'include_path = ".:/var/www/html/sei_php/infra_php"' >> /etc/php5/cli/php.ini

# Configura o ServerName para o apache2
RUN echo "ServerName 127.0.0.1" >> /etc/apache2/apache2.conf

# Habilitando DEBUG remoto para qualquer computador da rede (desenv)
RUN echo 'xdebug.remote_host=172.17.0.1' >> /etc/php5/apache2/php.ini
RUN echo 'xdebug.remote_connect_back=1' >> /etc/php5/apache2/php.ini
RUN echo 'xdebug.extended_info=1' >> /etc/php5/apache2/php.ini
RUN echo 'xdebug.default_enable=1' >> /etc/php5/apache2/php.ini
RUN echo 'xdebug.remote_enable=1' >> /etc/php5/apache2/php.ini
RUN echo 'xdebug.remote_autostart=1' >> /etc/php5/apache2/php.ini
RUN echo 'xdebug.remote_handler=dbgp' >> /etc/php5/apache2/php.ini
RUN echo 'xdebug.remote_mode=req' >> /etc/php5/apache2/php.ini
RUN echo 'xdebug.remote_port=9000' >> /etc/php5/apache2/php.ini
RUN echo 'xdebug.remote_log=/var/log/apache2/xdebug.log' >> /etc/php5/apache2/php.ini

# Enable Apache2 modules
RUN a2enmod rewrite

# Habilita modulos PHP
RUN php5enmod oci8
RUN php5enmod xdebug

# Reinicializa os servicos
RUN service apache2 restart
RUN service memcached restart

# Set up the Apache2 environment variables
ENV APACHE_RUN_USER www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_LOG_DIR /var/log/apache2
ENV APACHE_LOCK_DIR /var/lock/apache2
ENV APACHE_PID_FILE /var/run/apache2.pid

EXPOSE 80 443 22

# Run Apache2 in Foreground
#CMD /usr/sbin/apache2 -D FOREGROUND

# docker build -t projeto-docker-debian --build-arg HOME=$HOME --build-arg USERPROXY=USUARIO.REDE --build-arg PASSWD=SENHA.REDE --build-arg PROJETO=projeto .
# docker run -it --name apache -p 80:80 --network=host --privileged -v $HOME/discoDocker/apache/projetos/:/var/www/html/ -v $HOME/discoDocker/apache/conf/:/etc/apache2/sites-available -v /tmp:/tmp -d projeto-docker-debian:latest
# docker exec -it apache a2ensite projeto.com.br
# docker exec -it apache /etc/init.d/apache2 restart
# docker exec -it apache /etc/init.d/memcached restart
# docker exec -it apache php -m | grep oci8
