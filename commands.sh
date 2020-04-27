#!/bin/bash

# ---------------------DEMO 1: outside/inside-----------------------------------
#https://gist.github.com/BretFisher/5e1a0c7bcca4c735e716abf62afad389
screen ~/Library/Containers/com.docker.docker/Data/vms/0/tty
screen -r
docker run -it --rm --privileged --pid=host justincormack/nsenter1

docker run -d --name=rabbit rabbitmq
docker exec -it rabbit sh -c "apt-get update && apt-get install iproute2 -y && bash"

# show ps aux from outside and inside a container
# hostname -i, hostname
# show root file systems

#----------------------------- DEMO 2: run apps --------------------------------
./cleanup.sh
docker run -d -p 15672:15672 rabbitmq:management
docker run -d -p 8080:80 nginx

#--------------------------- DEMO 3: docker basic commands --------------------- 
./cleanup.sh
docker version

docker pull rabbitmq
docker pull rabbitmq:3.7
docker images 

# container lifecycle
docker run rabbitmq
docker ps

docker stop $container_id
docker start $container_id
docker logs $container_id
docker rm $container_id

# more than 1 container with same image
docker run -d rabbitmq
docker run -d rabbitmq
docker run -d redis
docker run -d redis
docker run -d nginx
docker run -d nginx

# ---------------------- DEMO 4: Layers --------------------------------------------
./cleanup.sh
docker pull rabbitmq:3.8
docker pull ubuntu:18.04   

docker image inspect rabbitmq:3.8
docker history rabbitmq
docker image inspect ubuntu:18.04
docker history ubuntu

# ---------------------- DEMO 5: Docker build--------------------------------------
# writable layer curl
docker run -it ubuntu:18.04
apt-get update && apt-get install curl -y && rm -rf /var/lib/apt/lists/*
docker ps -s

docker commit $container_id paulopez/kurl:0.1
docker image inspect paulopez/kurl:0.1 | jq -r '.[0].RootFS'
docker image inspect ubuntu:18.04 | jq -r '.[0].RootFS'
docker run -it paulopez/kurl:0.1

docker build -f kurl/Dockerfile -t paulopez/kurl:0.1 .
docker run paulopez/kurl:0.1 curl abax.cloud
docker push paulopez/kurl:0.1

#--------------------- DEMO 6: dockerize your app ---------------------------------
docker pull mcr.microsoft.com/dotnet/core/aspnet:3.1
docker pull mcr.microsoft.com/dotnet/core/runtime:3.1
docker pull mcr.microsoft.com/dotnet/core/runtime-deps:3.1
docker pull debian:buster-slim

docker image inspect mcr.microsoft.com/dotnet/core/aspnet:3.1 | jq -r '.[0].RootFS'
docker image inspect mcr.microsoft.com/dotnet/core/runtime:3.1 | jq -r '.[0].RootFS'
docker image inspect mcr.microsoft.com/dotnet/core/runtime-deps:3.1 | jq -r '.[0].RootFS'
docker image inspect debian:buster-slim | jq -r '.[0].RootFS'

dotnet publish votingapp -o ./build
docker build -f votingapp/Dockerfile -t paulopez/votingapp:0.1 .
docker image inspect paulopez/votingapp:0.1 | jq -r '.[0].RootFS'
docker push paulopez/votingapp:0.1

# change html
./build.sh 0.2

#--------------------- DEMO 7: docker networking ---------------------------------
docker run --name votingapp paulopez/votingapp:0.1
docker inspect votingapp | jq -r '.[0].NetworkSettings.Networks.bridge.IPAddress'

docker run paulopez/kurl:0.1 172.17.0.2:5000/api/voting

docker run -it --entrypoint=bash paulopez/kurl:0.1
curl 172.17.0.2:5000/api/voting