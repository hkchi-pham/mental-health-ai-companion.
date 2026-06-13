# Backend Fixes for Flutter Integration

Punch-list of issues found while mapping this API against the Flutter client
(`soul-garden/flutter_application_nhat_ky`). Ordered by how badly each one
breaks a real client. Fix the **P0/P1** items before wiring the app.

> **Status (2026-06-13):** Items **#3** (HTTPException-as-success across all live
> routers + `except HTTPException: raise` guards added so 4xx no longer become
> 500s), **#5** (added `POST /api/v1/auth/register`), and **#15** (CORS locked to
> `ALLOWED_ORIGINS` env with localhost dev fallback) are **DONE**. Item **#2**
> (the malformed `/{tree_id}/type?new_type=...` path) was also fixed to
> `/{tree_id}/type`. Remaining items below are still open.

---

## P0 — Will break the client immediately

### 1. `TreeResponse` types `level` and `health` as `str`
- **File:** `app/backend/response/TreeResponse.py`
- **Problem:** `TreeModel` stores `level`/`health` as `int`, but the response schema declares them as `str`. Clients parsing ints will fail (or must defensively coerce, as the Flutter `TreeDto._asInt` currently does).
- **Fix:** Type them as `int` in `TreeResponse` (and `TreeRead`/`TreeCreate`) to match the model.

### 2. Three `PUT /api/v1/tree/{tree_id}` handlers collide
- **File:** `app/backend/router/TreeRouter.py`
- **Problem:** `water_tree`, `change_tree`, and `grow_new_tree` are all registered on `PUT /{tree_id}`. FastAPI routes to the first only — `change_tree` and `grow_new_tree` are unreachable.
- **Fix:** Give them distinct paths/verbs, e.g.
  `PUT /{tree_id}/water`, `PUT /{tree_id}/type?new_type=...`, `POST /{tree_id}/grow`.

### 3. Mutation endpoints return `HTTPException` objects as success
- **Files:** all routers (e.g. `TreeRouter.py`, `JournalRouter.py`, `UserRouter.py`)
- **Problem:** Handlers `return HTTPException(status_code=200, detail="...")` on success, so the body is `{"detail": "CREATE_TREE_SUCCESSFULLY"}` — error-shaped, not `SuccessResponse`. Clients can't tell success from failure by shape.
- **Fix:** Return a proper model: `SuccessResponse(message=..., data=...)` with `status_code=200`. Reserve `raise HTTPException(...)` for actual errors.

---

## P1 — Auth / contract correctness

### 4. JWT secret is hardcoded; `JWT_SECRET_KEY` env var ignored
- **File:** `app/backend/security/Authentication.py`
- **Problem:** Secret is the literal `"yoursecretkey"`; the `.env` value has no effect. Anyone can forge tokens.
- **Fix:** `SECRET_KEY = os.environ["JWT_SECRET_KEY"]` (and read `JWT_ALGORITHM` too). Rotate the secret.

### 5. No `/auth/register`; registration is `POST /users/` with no auth
- **Files:** `app/backend/router/AuthRouter.py`, `UserRouter.py`
- **Problem:** Registration via an open `POST /users/` is non-obvious and unprotected. Acceptable short-term (the Flutter `AuthRepository.register` already targets it), but document it or add `POST /auth/register`.
- **Fix (optional):** Add an explicit `/auth/register` that wraps user creation.

### 6. `AuthToken.expires_in` typed `datetime.time` but value is `30`
- **File:** `app/backend/response/AuthResponse.py`
- **Fix:** Type `expires_in: int` (seconds or minutes — pick one and document it; the Flutter client treats it defensively).

### 7. `AuthRouter` registered twice
- **File:** `app/main.py`
- **Fix:** Remove the duplicate `include_router(AuthRouter, ...)`.

---

## P2 — Schema/data correctness

### 8. `TreeCreate` has a spurious `tree_types` field
- **File:** `app/backend/response/TreeResponse.py`
- **Fix:** Remove `tree_types`; keep only `tree_type`.

### 9. Tree table name mismatch: model `tree` vs migration `trees`
- **Files:** `app/backend/models/TreeModel.py` (`__tablename__ = "tree"`) vs `migration/0004_update_app_api.sql` (`trees`)
- **Fix:** Pick one name and make both agree (recommend `trees`).

### 10. `ended_at` on `TreeResponse` doesn't exist on `TreeModel`
- **File:** `app/backend/response/TreeResponse.py`
- **Fix:** Remove `ended_at` from the tree response (always serializes `null`), or add the column if intended.

### 11. `JournalResponse` omits `emoji`
- **File:** `app/backend/response/JournalResponse.py`
- **Problem:** `emoji` is stored and accepted on create, but never returned — the journal UI can't render it.
- **Fix:** Add `emoji` to `JournalResponse`/`JournalRead`.

### 12. `ContactAlertLogResponse` omits `alert_id`
- **File:** `app/backend/response/ContactAlertLogResponse.py`
- **Fix:** Add `alert_id` (it's NOT NULL on the model).

### 13. `JournalBase.page` is `List[Any]` in the model but `Dict` in schemas
- **Files:** `app/backend/models/JournalModel.py` vs `response/JournalResponse.py`
- **Fix:** Decide the real shape (array of page blocks vs a dict) and make model + schema agree so the client knows what to parse.

### 14. `MoodLogResponse.created_at` typed `str` (others use `datetime`)
- **File:** `app/backend/response/MoodLogResponse.py`
- **Fix:** Use `datetime` for consistency across all responses.

---

## P3 — Hardening (before production)

### 15. CORS is fully open with credentials
- **File:** `app/main.py` — `allow_origins=["*"], allow_credentials=True`
- **Fix:** Restrict `allow_origins` to your app's origins. `*` + credentials is rejected by browsers anyway and is unsafe.

### 16. Duplicate/competing `ActionModel` definitions
- **Files:** `app/backend/models/ActionModel.py` (authoritative) and `ChatbotBaseModel.py`
- **Fix:** Remove the stale duplicate in `ChatbotBaseModel.py`.

### 17. `ContactAlertLogRouter` GET-by-id returns an `HTTPException`, not data
- **File:** `app/backend/router/ContactAlertLogRouter.py`
- **Fix:** Return the log record (same pattern as #3).

---

## Currency model note (no code bug — design to confirm)

`points` / `water_units` / `tree_grown` live on **`UserModel`** and have **no fields in `UserUpdate`**, so the client cannot push currency. That's correct *if* currency is server-authoritative (changed only by `water_tree` etc.). The Flutter `ApiGardenRepository` is built on that assumption: it **reads** currency from `GET /users/{user_name}` and never pushes it. Confirm that's the intended design; if the client should ever adjust currency directly, expose a dedicated endpoint (not `UserUpdate`).
