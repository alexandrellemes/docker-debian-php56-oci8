# docker-debian-php56-oci8

Docker Image built on Debian, with Apache2, PHP5.6, OCI8 extension and the Oracle Instant Client.

## Build the Docker image from github

    git clone https://github.com/alexandrellemes/docker-debian-php56-oci8.git
    cd docker-debian-php56-oci8
    docker build -t alexandrellemes/docker-debian-php56-oci8 .

## Or pull the Docker image from Docker Hub

    docker pull alexandrellemes/docker-debian-php56-oci8

## Default Usage

Start a new container with the Apache2 Debian Default Page


    docker run -p 80:80 -d alexandrellemes/docker-debian-php56-oci8

## Run the local sample page

Start a new container with the sample page containing a phpinfo(), and bind the port 80 of your localhost.


    docker run -p 80:80 -d -v $(pwd)/sample:/var/www/html alexandrellemes/docker-debian-php56-oci8

## Run your custom project

Start a new container with your application and bind the port 80 of the container to port 80 of your localhost.


    docker run -p 80:80 -d -v </local/path/www>:/var/www/html alexandrellemes/docker-debian-php56-oci8

## Test your deployment :

* Open [http://127.0.0.1:80](http://127.0.0.1:80) in your browser
