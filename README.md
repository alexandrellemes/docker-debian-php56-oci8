# docker-debian-php56-oci8

Imagem construida a partir do Debian/Jessie, com Apache2, PHP5.6, extensão OCI8 e Oracle Instant Client.

Esse projeto utiliza o "docker-compose", como orquestrador.

Veja na pasta "/scripts", a sua instalação.
 
Utiliza também o "Portainer".

Uma excelente ferramenta para o auxílio no dia-a-dia com o DOCKER.
 
Se quiser, habilite o "SonarQube", somente descomente no arquivo "docker-compose.yml" a sua configuração.


## Como construir a imagem a partir do github

    git clone https://github.com/alexandrellemes/docker-debian-php56-oci8.git
    cd docker-debian-php56-oci8
    ./run.sh
    
    #docker build -t alexandrellemes/docker-debian-php56-oci8 .

## Ou baixar a imagem do Docker Hub

    docker pull alexandrellemes/docker-debian-php56-oci8

## Uso

Inicie um novo container


    docker run -p 80:80 -d alexandrellemes/docker-debian-php56-oci8

## Rode uma página de exemplo local

Inicie um novo container com a página de exemplo  phpinfo(), na porta padrão (80) da sua máquina local.


    docker run -p 80:80 -d -v $(pwd)/sample:/var/www/html alexandrellemes/docker-debian-php56-oci8

## Rode seu projeto

Inicie um novo container com sua aplicação, indicando a pasta de seu projeto.


    docker run -p 80:80 -d -v </local/path/www>:/var/www/html alexandrellemes/docker-debian-php56-oci8

## Teste seu ambiente :

* Digite no seu browser: [http://127.0.0.1:80](http://127.0.0.1:80)

## Recursos utilizados

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
