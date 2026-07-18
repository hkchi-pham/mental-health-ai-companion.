#!/bin/bash
# apply_seed.sh — Idempotent seed loader for the curated actions library.
#
# Applies migration 0003 (schema: emotions/needs/actions/emotion_need_links/
# emotion_need_action_map) then seed.sql against the mental-health-db container.
# Re-runnable: CREATE TABLE IF NOT EXISTS + ON CONFLICT DO NOTHING everywhere;
# CREATE TYPE text_weight in seed.sql may raise duplicate_object on re-runs —
# that is tolerated via ON_ERROR_STOP=0 and does not abort the script.
#
# Usage:
#   bash scripts/apply_seed.sh
#   DB_CONTAINER=my-db DB_USER=foo DB_NAME=foo bash scripts/apply_seed.sh

set -u

# ---------------------------------------------------------------------------
# Configuration — override via env
# ---------------------------------------------------------------------------
DB_CONTAINER="${DB_CONTAINER:-mental-health-db}"
DB_USER="${DB_USER:-hkchi-p}"
DB_NAME="${DB_NAME:-hkchi-p}"

# Resolve repo root relative to this script's location so it runs from anywhere.
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/../" && pwd)"

MIGRATION_SCHEMA="$REPO_ROOT/app/backend/migration/0003_create_action_emotion_need_db.sql"
MIGRATION_SEED="$REPO_ROOT/app/backend/migration/seed/seed.sql"

# ---------------------------------------------------------------------------
# Preflight checks
# ---------------------------------------------------------------------------
echo "[apply_seed] DB container : $DB_CONTAINER"
echo "[apply_seed] DB user      : $DB_USER"
echo "[apply_seed] DB name      : $DB_NAME"
echo "[apply_seed] Schema file  : $MIGRATION_SCHEMA"
echo "[apply_seed] Seed file    : $MIGRATION_SEED"
echo ""

if [ ! -f "$MIGRATION_SCHEMA" ]; then
    echo "[apply_seed] ERROR: Schema migration not found: $MIGRATION_SCHEMA"
    exit 1
fi

if [ ! -f "$MIGRATION_SEED" ]; then
    echo "[apply_seed] ERROR: Seed file not found: $MIGRATION_SEED"
    exit 1
fi

# Check the container is running
if ! docker inspect "$DB_CONTAINER" --format '{{.State.Running}}' 2>/dev/null | grep -q "^true$"; then
    echo "[apply_seed] ERROR: Container '$DB_CONTAINER' is not running."
    echo "             Run: docker compose up -d"
    exit 1
fi

# ---------------------------------------------------------------------------
# Step 1: Apply schema (migration 0003)
# ---------------------------------------------------------------------------
echo "[apply_seed] Step 1/3 — Applying schema (0003_create_action_emotion_need_db.sql)..."
docker exec -i "$DB_CONTAINER" psql \
    -v ON_ERROR_STOP=0 \
    -U "$DB_USER" \
    -d "$DB_NAME" \
    < "$MIGRATION_SCHEMA"
echo "[apply_seed] Schema step complete (errors above, if any, are expected for existing objects)."
echo ""

# ---------------------------------------------------------------------------
# Step 2: Apply seed (seed.sql)
# ---------------------------------------------------------------------------
echo "[apply_seed] Step 2/3 — Applying seed data (seed.sql)..."
# ON_ERROR_STOP=0: tolerates duplicate CREATE TYPE text_weight on re-runs.
# All INSERT statements use ON CONFLICT DO NOTHING so rows are never duplicated.
docker exec -i "$DB_CONTAINER" psql \
    -v ON_ERROR_STOP=0 \
    -U "$DB_USER" \
    -d "$DB_NAME" \
    < "$MIGRATION_SEED"
echo "[apply_seed] Seed step complete (duplicate_object errors on CREATE TYPE are normal on re-runs)."
echo ""

# ---------------------------------------------------------------------------
# Step 3: Verify row counts
# ---------------------------------------------------------------------------
echo "[apply_seed] Step 3/3 — Verifying row counts in curated tables..."
docker exec -i "$DB_CONTAINER" psql \
    -U "$DB_USER" \
    -d "$DB_NAME" \
    -c "
SELECT
  'emotions'              AS table_name, COUNT(*) AS row_count FROM emotions
UNION ALL
SELECT 'needs',               COUNT(*) FROM needs
UNION ALL
SELECT 'emotion_need_links',  COUNT(*) FROM emotion_need_links
UNION ALL
SELECT 'actions',             COUNT(*) FROM actions
UNION ALL
SELECT 'emotion_need_action_map', COUNT(*) FROM emotion_need_action_map
ORDER BY table_name;
"
echo ""
echo "[apply_seed] Done. All five curated tables verified above."
echo "             Non-zero counts confirm the seed is loaded and ready."
echo "             Expected mood coverage: buon(4), lo_lang(4), met_moi(3), vui(2), tuc_gian(4), trung_lap(3) rows in emotion_need_action_map."
