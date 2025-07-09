# Python+Database sample

## Local Development

To run the database and the python application in local containers during development, run

```bash
docker volume create pgdata
docker run \
  --rm \
  -v "$(pwd)/schema.sql:/docker-entrypoint-initdb.d/1-schema.sql" \
  -v "pgdata:/var/lib/postgresql/data" \
  -p5432:5432 \
  -e POSTGRES_DB=helloworld \
  -e POSTGRES_USER=user \
  -e POSTGRES_PASSWORD=password \
  -d \
  postgres:17.5
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
```


## Build & Deployment

### Database

To build the image and run the container:

```bash
docker build \
  -f Dockerfile-database \
  -t my-database:1.0.0 \
  .
docker volume create pgdata
docker run \
  --rm \
  -v "pgdata:/var/lib/postgresql/data" \
  -e DB_USER=user \
  -e DB_PASSWORD=password \
  -p5432:5432 \
  -d \
  my-database:1.0.0
```

### Application

To build the image and run the container:

```bash
docker build \
  -f Dockerfile-application \
  -t my-database-app:1.0.0 \
  .
docker run \
  --rm \
  -e DB_USER=user \
  -e DB_PASSWORD=password \
  -p8080:5000 \
  my-database-app:1.0.0
```
