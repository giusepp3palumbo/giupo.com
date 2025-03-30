#!/usr/bin/env bash

image_version=`date +%Y%m%d%H%M`;
container_name="giupo.com"

# Stop the container
docker stop $container_name || true;

# Remove the container
docker rm $container_name || true;

# Remove the image
docker rmi --force $(docker images | grep $container_name | awk '{print $3}')

# Build the $image_version image
docker build . -t $container_name:$image_version;

# List the images
docker images;

# Create a container named from the image
docker run -p 9001:80 -d --name $container_name $container_name:$image_version;

# View logs
docker logs $container_name;

# Remove images generated during the build process
docker rmi $(docker images -f "dangling=true" -q)

# Automatically clean up space
docker system prune -a -f
