# Docker-Image verwenden

## Ressourcen

- [Folien (PDF)](Containertechnologien.pdf)
- Docker CLI Reference: [docker | Docker Docs](https://docs.docker.com/reference/cli/docker/)
- NGINX Image Dokumentation: [Docker Hub](https://hub.docker.com/_/nginx)

## Arbeitsschritte

1. Vorbereitung: [Docker installieren](https://docs.docker.com/get-started/get-docker/) und DockerHUB-Account einrichten
2. Docker Desktop starten
3. In der Git Bash folgende Befehle ausführen:

```bash
# pull latest
docker pull nginx
# pull version 1.27.0
docker pull nginx:1.27.5
# show
docker images
# tag image (shortcut)
docker image tag nginx:1.27.5 my-http:1.0.0
# create container
docker container create --name nginx-container -p 8080:80 my-http:1.0.0
# show containers
docker container ls -a
# start container
docker container start nginx-container
# open http://localhost:8080
# create file in container
docker container exec nginx-container bash -c "echo 'Hello World' >> /usr/share/nginx/html/hw.html"
# open http://localhost:8080/hw.html
# stop container
docker container stop nginx-container
```

## Reflexionsfragen:

1. Was sind Tags und wofür werden sie verwendet?
2. Was passiert, wenn ich beim Erzeugen des Containers nur folgenden Befehl verwende?
   `docker container create nginx:1.27.5`
3. Was bedeuten beim Erzeugen des Containers die Parameter `-e`, `-v` und `-p`?
4. Was passiert mit der Datei `hw.html`, wenn der Container gestoppt wird? Was passiert, wenn der Container gelöscht und neu angelegt wird?
5. Was macht der folgende Befehl?
   `docker run --rm -it thegeeklab/nginx /bin/sh`
