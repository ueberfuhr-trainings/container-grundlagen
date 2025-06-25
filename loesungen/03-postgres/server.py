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

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)
