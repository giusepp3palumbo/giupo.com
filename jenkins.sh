#!/usr/bin/env bash

image_version=`date +%Y%m%d%H%M`;
registry="rasp03.fritz.box:5000/"
container_name="giupo.com"

# Stop the container
echo "[+] docker stop $container_name || true;"
docker stop $container_name || true;

# Remove the container
echo "[+] docker rm $container_name || true;"
docker rm $container_name || true;

# Remove the image
echo "[+] docker rmi --force $(docker images | grep $container_name | awk '{print $3}')"
docker rmi --force $(docker images | grep $container_name | awk '{print $3}')

# Build the $image_version image
docker build . -t $registry$container_name:$image_version;

# List the images
docker images;

# Create a container named from the image
docker run -p 9001:80 -d --restart always --name $container_name $registry$container_name:$image_version;

# View logs
docker logs $container_name;

# Remove images generated during the build process
#docker rmi $(docker images -f "dangling=true" -q)

# Automatically clean up space
#docker system prune -a -f
