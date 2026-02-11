#!/bin/bash

# Configuration
CONTAINER_NAME="mental-health-db"
DB_USER="hkchi-p"
DB_NAME="hkchi-p"

# Check if backup file is provided
if [ -z "$1" ]; then
    echo "❌ Usage: $0 <path_to_backup_file.sql>"
    exit 1
fi

BACKUP_FILE="$1"

# Check if backup file exists
if [ ! -f "$BACKUP_FILE" ]; then
    echo "❌ Error: Backup file '$BACKUP_FILE' not found!"
    exit 1
fi

echo "⚠️  WARNING: This will OVERWRITE the database '$DB_NAME' in container '$CONTAINER_NAME'."
read -p "Are you sure you want to continue? (y/N): " confirm

if [[ "$confirm" != "y" && "$confirm" != "Y" ]]; then
    echo "❌ Restore cancelled."
    exit 0
fi

echo "Starting restore from '$BACKUP_FILE'..."

# Terminate existing connections to the database (optional but recommended)
echo "disconnecting other users..."
docker exec "$CONTAINER_NAME" psql -U "$DB_USER" -d postgres -c "SELECT pg_terminate_backend(pid) FROM pg_stat_activity WHERE datname = '$DB_NAME' AND pid <> pg_backend_pid();"

# Drop and recreate database (clean slate) - OPTIONAL, sometimes just restoring over is fine but cleaner to drop
# Uncomment if you want a full clean restore:
# echo "Recreating database..."
# docker exec "$CONTAINER_NAME" psql -U "$DB_USER" -d postgres -c "DROP DATABASE IF EXISTS \"$DB_NAME\";"
# docker exec "$CONTAINER_NAME" psql -U "$DB_USER" -d postgres -c "CREATE DATABASE \"$DB_NAME\";"

# Run psql inside the container to restore
cat "$BACKUP_FILE" | docker exec -i "$CONTAINER_NAME" psql -U "$DB_USER" -d "$DB_NAME"

# Check if the command was successful
if [ $? -eq 0 ]; then
    echo "✅ Database successfully restored!"
else
    echo "❌ Restore failed!"
    exit 1
fi
