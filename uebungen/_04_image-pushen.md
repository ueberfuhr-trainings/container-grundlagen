# Docker-Image pushen

## Arbeitsschritte

1. Im [DockerHub](https://hub.docker.com/repositories) Repository anlegen. (z.B. "my-website")
2. Image taggen und pushen

```bash
# Nicht notwendig mit Docker Desktop
# docker login ...
docker tag my-website:1.0.0 <account>/my-website:1.0.0
docker push <account>/my-website:1.0.0
```

## Reflexionsfragen

1. Wie weisen wir dem gepushten Image das `latest`-Tag zu?
2. Welche Schritte werden ausgeführt, wenn wir Änderungen im Dockerfile (z.B. ein Label) als Version `1.0.1` pushen wollen? Wie setzen wir das `latest`-Tag?
3. Was passiert, wenn wir ein Image nur mit `latest`-Tag pushen, und dieses `latest`-Tag dann bei weiteren Änderungen wieder verschieben?
