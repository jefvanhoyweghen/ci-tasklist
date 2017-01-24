#!/bin/bash
docker-machine status ci-vm 2> /dev/null || docker-machine create --driver virtualbox ci-vm
eval $(docker-machine env ci-vm)
DOCKER_IP="$(docker-machine ip ci-vm)"
sed -i "s/DOCKER_IP/$DOCKER_IP/g" docker-compose.yml
sudo docker-compose up -d
foldername=${PWD##*/}
sudo docker-compose exec -T workspace bash $foldername/jenkins.sh $foldername
