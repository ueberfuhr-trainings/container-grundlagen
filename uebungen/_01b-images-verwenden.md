# Images verwenden (Zusatz)

## NGinX

Erstelle 2 Container von NGinX, die ihre HTML-Seiten von einem Verzeichnis des Host lesen und ausliefern.

## Python

Erstelle einen Container, der folgenden Python-Befehl ausführt:

```python
print("Hello, World!")
```

## PostgreSQL

Erstelle einen Container für eine PostgreSQL-Datenbank mit folgenden Daten:

```sql
-- Create the "helloworld" table
CREATE TABLE helloworld
(
    id      SERIAL PRIMARY KEY,
    message TEXT NOT NULL
);

-- Insert some sample "Hello, World!" messages
INSERT INTO helloworld (message)
VALUES ('Hello, World!'),
       ('Hola, Mundo!'),
       ('Bonjour, le monde!'),
       ('Hallo, Welt!'),
       ('こんにちは世界'),
       ('Привет, мир!'),
       ('Ciao, mondo!');
```

> [!NOTE]
> Besonderheiten des `postgres`-Images:
> - Umgebungsvariablen:
    >

- `POSTGRES_DB` (Name der Datenbank, z.B. `helloworld`)

> - `POSTGRES_USER` / `POSTGRES_PASSWORD` (Username+Passwort, mit dem die DB initialisiert wird, z.B. `user` /
    `password`)
> - Port: `5432`
> - Schema-Initialisierungs-Skripte: `/docker-entrypoint-initdb.d/*.sql`
> - Ablage der Daten in `/var/lib/postgresql/data`

Verbinde Dich nach Start des Containers mit der Datenbank und prüfe die Inhalte der Datenbank.

## Python-Webapp

Erstelle einen Container mit einer Python-Anwendung, die die Daten aus der Datenbank ausliest:

```python
from flask import Flask, jsonify
import psycopg2
import os

app = Flask(__name__)

# Configuration: environment variables (or hardcoded for testing)
DB_NAME = os.getenv("DB_NAME", "helloworld")
DB_USER = os.getenv("DB_USER", "postgres")
DB_PASSWORD = os.getenv("DB_PASSWORD", "postgres")
DB_HOST = os.getenv("DB_HOST", "localhost")
DB_PORT = os.getenv("DB_PORT", "5432")


@app.route("/hello", methods=["GET"])
def get_messages():
    try:
        # Connect to the PostgreSQL database
        conn = psycopg2.connect(
            dbname=DB_NAME,
            user=DB_USER,
            password=DB_PASSWORD,
            host=DB_HOST,
            port=DB_PORT
        )
        cur = conn.cursor()
        cur.execute("SELECT message FROM helloworld;")
        messages = [row[0] for row in cur.fetchall()]
        cur.close()
        conn.close()
        return jsonify(messages)
    except Exception as e:
        return jsonify({"error": str(e)}), 500


@app.route("/health")
def liveness():
    # Simple liveness check
    return jsonify(status="ok"), 200


@app.route("/ready")
def readiness():
    # Readiness check: test database connection
    try:
        conn = psycopg2.connect(
            dbname=DB_NAME,
            user=DB_USER,
            password=DB_PASSWORD,
            host=DB_HOST,
            port=DB_PORT
        )
        conn.close()
        return jsonify(status="ready"), 200
    except Exception as e:
        return jsonify(status="error", error=str(e)), 500


if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)
```

Die Anwendung soll dann unter `http://localhost:8080/hello` erreichbar sein.

> [!NOTE]
> Beim Starten der Anwendung müssen Abhängigkeiten installiert werden. Dies kann mit folgendem Befehl geschehen:
> `pip install --no-cache-dir flask psycopg2-binary && python <my-server>.py`

> [!NOTE]
> Um einen Container aus einem anderen Container aufzurufen, verwenden wir den Hostnamen `host.docker.internal`.
