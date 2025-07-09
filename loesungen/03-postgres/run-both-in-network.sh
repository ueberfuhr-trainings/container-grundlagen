#!/bin/bash

docker volume create pgdata
docker network create my-sample-network
docker run \
  --rm \
  -v "$(pwd)/schema.sql:/docker-entrypoint-initdb.d/1-schema.sql" \
  -v "pgdata:/var/lib/postgresql/data" \
  -p5432:5432 \
  -e POSTGRES_DB=helloworld \
  -e POSTGRES_USER=user \
  -e POSTGRES_PASSWORD=password \
  --name my-database \
  --network my-sample-network \
  -d \
  postgres:17.5

docker run \
  --rm \
  -v "$(pwd)/server.py:/server.py" \
  -e DB_NAME=helloworld \
  -e DB_USER=user \
  -e DB_PASSWORD=password \
  --network my-sample-network \
  -e DB_HOST=my-database \
  -e DB_PORT=5432 \
  -p8080:5000 \
  python:3-slim \
  sh -c "pip install --no-cache-dir flask psycopg2-binary && python /server.py"
