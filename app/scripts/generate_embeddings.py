import os
import sys
import psycopg2
from sentence_transformers import SentenceTransformer
import numpy as np

# Add project root to path if needed, but we'll use env vars for DB connection
# assumed running from root
# DATABASE_URL=postgresql://hkchi-p:abc123456@localhost:5432/hkchi-p
# Adjust default credentials to match docker-compose/env

DB_HOST = os.getenv("DB_HOST", "localhost")
DB_PORT = os.getenv("DB_PORT", "5432") # If running from host, likely 5332 mapped port?
# Wait, user runs `python scripts/generate_embeddings.py`.
# If running OUTSIDE docker, needs mapped port 5332.
# If running INSIDE docker, needs 5432.
# Let's try to detect or use param.
# The user might run this script from their terminal (host).
# Host port mapping in docker-compose is "5332:5432".
# So host port is 5332.

DB_NAME = os.getenv("POSTGRES_DB", "hkchi-p")
DB_USER = os.getenv("POSTGRES_USER", "hkchi-p")
DB_PASSWORD = os.getenv("POSTGRES_PASSWORD", "abc123")

# Connection string
# Use host 5332 by default for local run
if os.getenv("RUNNING_IN_DOCKER"):
    DB_HOST_REAL = "db"
    DB_PORT_REAL = 5432
else:
    DB_HOST_REAL = "localhost"
    try:
        # Check if port 5332 is open? Or just assume it.
        # Let's default to 5332 for host run.
        DB_PORT_REAL = 5332
    except:
        DB_PORT_REAL = 5432

print(f"Connecting to DB {DB_HOST_REAL}:{DB_PORT_REAL}...")

try:
    conn = psycopg2.connect(
        host=DB_HOST_REAL,
        port=DB_PORT_REAL,
        database=DB_NAME,
        user=DB_USER,
        password=DB_PASSWORD
    )
    conn.autocommit = True
    cur = conn.cursor()
except Exception as e:
    print(f"Error connecting to DB: {e}")
    sys.exit(1)

print("Loading embedding model...")
model = SentenceTransformer('bkai-foundation-models/vietnamese-bi-encoder')

try:
    # Fetch actions needing embeddings (or all to update)
    print("Fetching actions...")
    cur.execute("SELECT slug, search_text FROM actions WHERE active = true")
    rows = cur.fetchall()
    
    total = len(rows)
    print(f"Found {total} actions.")
    
    updated = 0
    for slug, text in rows:
        if not text:
            print(f"Skipping {slug}: No search_text")
            continue
            
        print(f"Processing {slug}...", end="\r")
        embedding = model.encode(text).tolist()
        
        # Update DB
        # Use simple string formatting for vector literal
        cur.execute(
            "UPDATE actions SET embedding = %s WHERE slug = %s",
            (str(embedding), slug)
        )
        updated += 1
        
    print(f"\nDone! Updated {updated} actions.")

except Exception as e:
    print(f"Error: {e}")
finally:
    cur.close()
    conn.close()
