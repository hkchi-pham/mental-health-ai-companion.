#!/bin/bash

# Configuration
CONTAINER_NAME="mental-health-db"
DB_USER="hkchi-p"
DB_NAME="hkchi-p"
BACKUP_DIR="./backups"
TIMESTAMP=$(date +"%Y%m%d_%H%M%S")
BACKUP_FILE="$BACKUP_DIR/backup_$TIMESTAMP.sql"

# Create backup directory if it doesn't exist
mkdir -p "$BACKUP_DIR"

echo "Starting backup for database '$DB_NAME' from container '$CONTAINER_NAME'..."

# Run pg_dump inside the container
docker exec -t "$CONTAINER_NAME" pg_dump -U "$DB_USER" "$DB_NAME" > "$BACKUP_FILE"

# Check if the command was successful
if [ $? -eq 0 ]; then
    echo "✅ Backup successfully created!"
    echo "📁 File location: $BACKUP_FILE"
    
    # Optional: Display file size
    FILE_SIZE=$(du -h "$BACKUP_FILE" | cut -f1)
    echo "📦 Size: $FILE_SIZE"
else
    echo "❌ Backup failed!"
    # Check if backup file is empty and remove it if so
    if [ ! -s "$BACKUP_FILE" ]; then
        rm "$BACKUP_FILE"
        echo "⚠️  Empty backup file removed."
    fi
    exit 1
fi
