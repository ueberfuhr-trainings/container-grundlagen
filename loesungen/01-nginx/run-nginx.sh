#!/bin/bash

# on Windows Git Bash, put MSYS_NO_PATHCONV=1 before ("MSYS_NO_PATHCONV=1 docker run ...")
docker run \
  --rm \
  -v "$(pwd)/index.html:/usr/share/nginx/html/index.html" \
  -p8080:80 \
  nginx:1.27.5
