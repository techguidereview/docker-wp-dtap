#!/bin/sh

# removes the containers, default network, and the WordPress database
docker-compose -f ~/docker/development/docker-compose.yaml down --volumes
docker-compose -f ~/docker/test/docker-compose.yaml down --volumes
docker-compose -f ~/docker/acceptance/docker-compose.yaml down --volumes
docker-compose -f ~/docker/production/docker-compose.yaml down --volumes

# cleanup dir folder
rm -Rf ~/docker*
rm -Rf ~/dtap*
