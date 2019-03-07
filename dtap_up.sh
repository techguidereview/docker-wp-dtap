#!/bin/sh

# run containers detached
docker-compose -f ~/docker/development/docker-compose.yaml up -d
docker-compose -f ~/docker/test/docker-compose.yaml up -d
docker-compose -f ~/docker/acceptance/docker-compose.yaml up -d
docker-compose -f ~/docker/production/docker-compose.yaml up -d
