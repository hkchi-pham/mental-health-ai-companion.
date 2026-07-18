# Seed: Curated Actions Library

The curated `actions` library (emotions / needs / emotion_need_links / actions / emotion_need_action_map) is **not auto-loaded** by the FastAPI bootstrap. `config/bootstrap.py` only calls `create_all` for the garden tables. This seed must be applied once — or after a fresh DB wipe — before Phase 13.3 activity suggestions will return any data.

---

## Prerequisites

The `mental-health-db` Postgres container must be running:

```bash
docker compose up -d
```

Confirm it is up:

```bash
docker ps | grep mental-health-db
```

---

## One-command apply

```bash
bash scripts/apply_seed.sh
```

Run from the repo root (`soul-garden/fastapi_application_nhat_ky/`). The script resolves all paths relative to itself, so any working directory works.

### What it does

1. **Schema** — applies `app/backend/migration/0003_create_action_emotion_need_db.sql` using `CREATE TABLE IF NOT EXISTS`, so existing tables are untouched on re-runs.
2. **Seed** — applies `app/backend/migration/seed/seed.sql` with `ON CONFLICT DO NOTHING`, so rows are never duplicated on re-runs. The seed also contains a `CREATE TYPE text_weight` statement which raises a benign `duplicate_object` error on re-runs; the script tolerates this via `ON_ERROR_STOP=0`.
3. **Verification** — prints row counts for the five curated tables so you can confirm rows are present.

The script is fully **idempotent**: running it multiple times is safe.

---

## Expected row counts after seeding

| Table | Expected rows |
|---|---|
| emotions | 10 |
| needs | 10+ |
| emotion_need_links | 10+ |
| actions | 10+ |
| emotion_need_action_map | 20 (across 6 target moods) |

### Mood coverage in `emotion_need_action_map`

| Mood slug | Rows |
|---|---|
| buon | 4 |
| lo_lang | 4 |
| met_moi | 3 |
| vui | 2 |
| tuc_gian | 4 |
| trung_lap | 3 |

> Moods `tức_giận` / `bình_thường` that the Flutter client sends are mapped to slugs `tuc_gian` / `trung_lap` inside the backend lookup. If a mood has no matching slug, the lookup degrades gracefully (returns `None`; no suggestion card is shown).

---

## Verify after seeding

Run this psql query against the container:

```bash
docker exec -i mental-health-db psql -U hkchi-p -d hkchi-p -c "
SELECT
  'emotions'                  AS table_name, COUNT(*) AS row_count FROM emotions
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
```

All five tables must show non-zero counts.

To inspect per-mood action coverage:

```bash
docker exec -i mental-health-db psql -U hkchi-p -d hkchi-p -c "
SELECT e.slug AS emotion_slug, COUNT(*) AS action_count
FROM emotion_need_action_map m
JOIN emotions e ON e.id = m.emotion_id
GROUP BY e.slug
ORDER BY e.slug;
"
```

---

## Manual fallback

If the script cannot run (e.g., no Bash available), apply the files manually:

```bash
# Step 1: Schema
docker exec -i mental-health-db psql -v ON_ERROR_STOP=0 -U hkchi-p -d hkchi-p \
    < app/backend/migration/0003_create_action_emotion_need_db.sql

# Step 2: Seed
docker exec -i mental-health-db psql -v ON_ERROR_STOP=0 -U hkchi-p -d hkchi-p \
    < app/backend/migration/seed/seed.sql
```

---

## Why this is required for Phase 13.3

Empty tables cause the `action_lookup` step in `MessageRouter` / `base.process_message` to return `None` for every mood. When `action_recommendation` is `None`, the Flutter client renders no activity suggestion card. Populating the seed is **the prerequisite for any suggestion to appear**.

After applying the seed you do not need to restart the API container — the lookup queries the DB live on each request.
