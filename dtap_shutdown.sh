#!/bin/sh

# removes containers, but preserves WP db. 
docker-compose -f ~/docker/development/docker-compose.yaml down
docker-compose -f ~/docker/test/docker-compose.yaml down
docker-compose -f ~/docker/acceptance/docker-compose.yaml down
docker-compose -f ~/docker/production/docker-compose.yaml down
