#!/bin/bash

tag=${1-:0.1}
rm -rf ./build
dotnet publish votingapp -o ./build
docker build -f votingapp/Dockerfile -t paulopez/votingapp:$tag .
docker push paulopez/votingapp:$tag