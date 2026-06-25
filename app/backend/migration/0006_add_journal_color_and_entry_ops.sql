-- 0006: add per-notebook cover color to journals.
-- Idempotent: app startup create_all is scoped to garden tables, so journals
-- already exists; this only adds the color column if it is not present yet.
-- Entry edit/delete needs no schema change — entries live in the existing
-- `page` JSON column, now carrying a per-entry `id`.
ALTER TABLE journals ADD COLUMN IF NOT EXISTS color VARCHAR(32) DEFAULT 'green';
