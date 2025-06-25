#!/bin/bash

# on Windows Git Bash, use $(pwd -W)!
docker volume create pgdata
docker run \
  --rm \
  -v "$(pwd)/schema.sql:/docker-entrypoint-initdb.d/1-schema.sql" \
  -v "pgdata:/var/lib/postgresql/data" \
  -p5432:5432 \
  -e POSTGRES_DB=helloworld \
  -e POSTGRES_USER=user \
  -e POSTGRES_PASSWORD=password \
  postgres:17.5
