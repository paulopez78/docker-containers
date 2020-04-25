docker rm -f $(docker ps -qa)
docker system prune -f --all
docker images
docker ps -a