#!/bin/bash

docker run \
  --rm \
  -v "$(pwd)/index.html:/usr/share/nginx/html/index.html" \
  -p8080:80 \
  nginx:1.27.5
