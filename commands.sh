# DEMO 1: outside/inside
# show ps aux from outside and inside a container
#https://gist.github.com/BretFisher/5e1a0c7bcca4c735e716abf62afad389
screen ~/Library/Containers/com.docker.docker/Data/vms/0/tty
docker run -it --rm --privileged --pid=host justincormack/nsenter1

docker run -d --name webserver nginx
docker exec -it webserver sh -c "apt-get update && apt-get install -y procps && bash"

docker run -d --name=rabbit rabbitmq
docker exec -it rabbit bash

# DEMO 2: run apps
docker run -d -p 15672:15672 rabbitmq-management
docker run -d -p 8080:80 nginx

# DEMO 3: docker basic commands --> docker for desktop
docker version
docker system info
docker pull rabbitmq:3.7
docker pull ubuntu:18.04
docker run -it ubuntu
docker images 
docker rm
docker start
docker stop

# DEMO 4: Layers
docker image inspect rabbitmq | jq -r '.[0].RootFS'
docker image inspect ubuntu | jq -r '.[0].RootFS'

# DEMO curl
docker build -f kurl/Dockerfile -t paulopez/kurl:0.1 .


# DEMO dotnet
rm -rf ./build
dotnet publish votingapp -o ./build
docker build -f votingapp/Dockerfile -t paulopez/votingapp:0.1 .

docker run paulopez/votingapp:0.1
docker run -it paulopez/kurl:0.1