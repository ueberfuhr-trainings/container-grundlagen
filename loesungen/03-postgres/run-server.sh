#!/bin/bash

# on Windows Git Bash, use $(pwd -W)!
docker run \
  --rm \
  -v "$(pwd)/server.py:/server.py" \
  -e DB_NAME=helloworld \
  -e DB_USER=user \
  -e DB_PASSWORD=password \
  -e DB_HOST=host.docker.internal \
  -e DB_PORT=5432 \
  -p8080:5000 \
  python:3-slim \
  sh -c "pip install --no-cache-dir flask psycopg2-binary && python /server.py"
