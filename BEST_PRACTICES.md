# Docker Best Practices

## 1. Kleine Base Images verwenden
- Minimal-Images bevorzugen (`alpine`, `distroless`, `*-slim`)
- Reduziert Image-Größe, Pull-Zeit und Angriffsfläche

Beispiel:

```dockerfile
FROM node:20-alpine
```

---

## 2. Multi-Stage Builds nutzen
Build-Abhängigkeiten gehören nicht ins Runtime-Image.

```dockerfile
FROM golang:1.22 AS builder
WORKDIR /build
COPY . .
RUN go build -o app

FROM alpine:3.19
COPY --from=builder /build/app /app
CMD ["/app"]
```

Vorteile:
- kleinere Images
- weniger Security-Risiken

---

## 3. `.dockerignore` verwenden
Reduziert den Build-Kontext.

Typische Einträge:

```
.git
.gitignore
node_modules
tests
docs
README.md
```

---

## 4. Docker Layer-Caching nutzen
Stabile Schritte zuerst, häufige Änderungen später.

Schlecht:

```dockerfile
COPY . .
RUN npm install
```

Besser:

```dockerfile
COPY package.json package-lock.json ./
RUN npm install
COPY . .
```

---

## 5. Exec-Form für CMD und ENTRYPOINT verwenden

Gut:

```dockerfile
CMD ["node", "server.js"]
```

Schlecht:

```dockerfile
CMD node server.js
```

Vorteile:
- korrektes Signal-Handling
- kein zusätzlicher Shell-Prozess

---

## 6. Container nicht als Root ausführen

```dockerfile
RUN useradd -m appuser
USER appuser
```

Vorteile:
- bessere Sicherheit
- kompatibel mit Plattformen wie OpenShift

---

## 7. Einen Prozess pro Container
Container sollten eine klar definierte Aufgabe haben.

Beispiele:

- Webserver
- Worker
- API
- Datenbank

Nicht mehrere Services im selben Container starten.

---

## 8. Logs nach STDOUT/STDERR schreiben

Nicht:

```
/var/log/app.log
```

Sondern Logging direkt auf:

```
stdout
stderr
```

Docker übernimmt dann die Log-Verwaltung.

---

## 9. Konfiguration über Environment-Variablen

Keine Hardcodierung im Image.

```dockerfile
ENV APP_PORT=8080
```

Beim Start:

```bash
docker run -e APP_PORT=8080 myimage
```

---

## 10. HEALTHCHECK definieren

```dockerfile
HEALTHCHECK CMD curl -f http://localhost:8080/health || exit 1
```

Erlaubt Docker, Containerzustand zu überwachen.

---

## 11. Nur notwendige Ports exponieren

```dockerfile
EXPOSE 8080
```

Keine unnötigen Ports öffnen.

---

## 12. Image-Versionen pinnen

Nicht:

```dockerfile
FROM node:latest
```

Besser:

```dockerfile
FROM node:20.11-alpine
```

Vorteil:
- reproduzierbare Builds

---

## 13. RUN-Kommandos kombinieren

Reduziert Image-Layer.

```dockerfile
RUN apt-get update \
 && apt-get install -y curl \
 && rm -rf /var/lib/apt/lists/*
```

---

## 14. Container stateless halten

Container sollten keinen persistenten Zustand enthalten.

Persistente Daten gehören in:

- Docker Volumes
- Datenbanken
- Object Storage

---

## 15. Security Scans durchführen

Container regelmäßig prüfen.

Beispiele für Tools:

- trivy
- grype
- docker scan
