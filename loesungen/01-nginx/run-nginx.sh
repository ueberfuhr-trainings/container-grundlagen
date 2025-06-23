#!/bin/bash

# Name of the container
CONTAINER_NAME=temp_nginx

# Create a container in the background from the image
docker container create --name $CONTAINER_NAME -p8080:80 nginx:1.27.5

# Copy the file into the container
docker container cp index.html $CONTAINER_NAME:/usr/share/nginx/html/index.html

# Start the container, execute the script, and remove the container afterward
docker container start -a $CONTAINER_NAME

# Clean up: remove the container
docker container remove $CONTAINER_NAME
