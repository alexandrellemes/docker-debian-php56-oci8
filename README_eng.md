# docker-debian-php56-oci8

Image built from Debian / Jessie, with Apache2, PHP5.6, OCI8 extension and Oracle Instant Client.

This project uses "docker-compose" as an orchestrator.

See the "/ scripts" folder for your installation.
 
It also uses the "Portainer".

An excellent tool for daily assistance with DOCKER.
 
If you want, enable "SonarQube", just uncomment your configuration in the "docker-compose.yml" file.


## How to build the image from github

    git clone https://github.com/alexandrellemes/docker-debian-php56-oci8.git
    cd docker-debian-php56-oci8
    ./run.sh
    
    #docker build -t alexandrellemes / docker-debian-php56-oci8.

## Or download the image from the Docker Hub

    alexandrellemes docker pull / docker-debian-php56-oci8

## Usage

Start a new container


    docker run -p 80:80 -d alexandrellemes / docker-debian-php56-oci8

## Rotate a local example page

Start a new container with the phpinfo () sample page, on the default port (80) of your local machine.


    docker run -p 80:80 -d -v $ (pwd) / sample: / var / www / html alexandrellemes / docker-debian-php56-oci8

## Run your project

Start a new container with your application, indicating your project folder.


    docker run -p 80:80 -d -v </ local / path / www>: / var / www / html alexandrellemes / docker-debian-php56-oci8

## Test your environment:

* Type in your browser: [http://127.0.0.1:80/201(http://127.0.0.1:80)

## Resources used

- Debian Jessie
- PHP 5.6
- Oracle OCI8
- MySQL
- Memcached
- Apache2
- Portainer
- OracleXE
- PostGreSQL
- SonarQube
- MailHog