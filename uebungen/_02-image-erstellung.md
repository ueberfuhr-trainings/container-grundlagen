# Docker-Image erstellen

## Ressourcen
- Dockerfile Reference: [Dockerfile reference | Docker Docs](https://docs.docker.com/reference/dockerfile/)
- Dockerfile von NGINX: [GitHub](https://github.com/nginx/docker-nginx/blob/1.27.5/mainline/debian/Dockerfile)

## Arbeitsschritte

1. Erstelle ein Docker Image auf Basis von NGINX mit eigenen HTML-Seiten.
    - Eine Seite wird per Kommandozeile (`echo xyz > file.html`) erzeugt.
    - Eine Seite wird neben dem Dockerfile abgelegt und beim Bauen ins Image kopiert.
2. Baue das Image. Erzeuge einen Container von diesem Image und prüfe die eingebauten Seiten.

```bash
docker image build .
# Prüfen
docker images
# Ooopsie!
docker image build -t "my-website:1.0.0" .
# Container erzeugen, startemn, testen
```

## Reflexionsfragen

1. Was passiert, wenn wir beim Bauen des Images den `-t`-Parameter weglassen?
2. Wofür verwenden wir `EXPOSE` im Dockerfile?
3. Wie kann man Umgebungsvariablen im Image setzen?
4. Was ist der Unterschied zwischen `ENTRYPOINT`, `CMD` und `RUN`?
5. Wofür kann man `HEALTHCHECK` verwenden?
