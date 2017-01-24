#!/bin/bash
SIZE=$1
docker-machine status ci-local 2> /dev/null || docker-machine create --driver digitalocean --digitalocean-access-token ACCESS_TOKEN --digitalocean-region fra1 --digitalocean-size $SIZE ci-local
eval $(docker-machine env ci-local)
DOCKER_IP="$(docker-machine ip ci-local)"
sed -i "s/DOCKER_IP/$DOCKER_IP/g" docker-compose.yml
sudo docker-compose up -d
foldername=${PWD##*/}
sudo docker-compose exec -T workspace bash $foldername/jenkins.sh $foldername 
