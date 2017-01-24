#!/bin/bash
SIZE=$1
docker-machine status ci-local 2> /dev/null || docker-machine create --driver digitalocean --digitalocean-access-token 1abb45fa73e481eeb2810c09645d4aa24887ae56ea8097f314445131f84ae34e --digitalocean-region fra1 --digitalocean-size $SIZE ci-local
eval $(docker-machine env ci-local)
DOCKER_IP="$(docker-machine ip ci-local)"
sed -i "s/DOCKER_IP/$DOCKER_IP/g" docker-compose.yml
sudo docker-compose rm -f
sudo docker-compse pull
sudo docker-compose up -d --force-recreate --build
foldername=${PWD##*/}
sudo docker-compose exec -T workspace bash $foldername/jenkins.sh $foldername 
