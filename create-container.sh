#!/bin/bash
docker rm -f rabbit
docker run -d --name=rabbit rabbitmq
docker exec -it rabbit sh -c "apt-get update && apt-get install iproute2 -y && bash"