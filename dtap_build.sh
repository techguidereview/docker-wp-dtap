#!/bin/sh

# change working dir
cd ~

# create directories
mkdir docker && cd docker && mkdir development test acceptance production

# write docker-compose file
cat > docker-compose.yaml <<EOF

version: '3.3'

services:
   db:
     image: mysql:5.7
     volumes:
       - db_data:/var/lib/mysql
     restart: always
     environment:
       MYSQL_ROOT_PASSWORD: somewordpress
       MYSQL_DATABASE: wordpress
       MYSQL_USER: wordpress
       MYSQL_PASSWORD: wordpress

   wordpress:
     depends_on:
       - db
     image: wordpress:latest
     ports:
       - "8000:80"
     restart: always
     environment:
       WORDPRESS_DB_HOST: db:3306
       WORDPRESS_DB_USER: wordpress
       WORDPRESS_DB_PASSWORD: wordpress
       WORDPRESS_DB_NAME: wordpress
volumes:
    db_data: {}
EOF

# read standard input from file and write docker-compose file to subdirectories
cat docker-compose.yaml | tee -a development/docker-compose.yaml test/docker-compose.yaml acceptance/docker-compose.yaml production/docker-compose.yaml

# assign different port numbers to specific containers
sed -i 's/8000/8001/g' ~/docker/development/docker-compose.yaml
sed -i 's/8000/8002/g' ~/docker/test/docker-compose.yaml
sed -i 's/8000/8003/g' ~/docker/acceptance/docker-compose.yaml
sed -i 's/8000/8004/g' ~/docker/production/docker-compose.yaml

# run containers detached
docker-compose -f ~/docker/development/docker-compose.yaml up -d
docker-compose -f ~/docker/test/docker-compose.yaml up -d
docker-compose -f ~/docker/acceptance/docker-compose.yaml up -d
docker-compose -f ~/docker/production/docker-compose.yaml up -d

# cleanup compose file in home dir
rm -f ~/docker/docker-compose.yaml
