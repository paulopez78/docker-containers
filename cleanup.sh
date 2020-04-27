docker rm -f $(docker ps -qa)
docker system prune -f --all
docker volume prune -f 
docker images
docker ps -a