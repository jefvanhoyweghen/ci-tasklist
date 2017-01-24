#!/bin/bash
sudo rm ~/.docker/machine/cache/boot2docker.iso
if docker-machine ls -q | grep '^ci-vm$'
then docker-machine rm ci-vm -y
fi
docker-machine create --driver virtualbox ci-vm
eval $(docker-machine env ci-vm)
DOCKER_IP="$(docker-machine ip ci-vm)"
sed -i "s/DOCKER_IP/$DOCKER_IP/g" docker-compose.yml
sudo docker-compose rm -f
sudo docker-compse pull
sudo docker-compose up -d --force-recreate --build
foldername=${PWD##*/}
sudo docker-compose exec -T workspace bash $foldername/jenkins.sh $foldername 
