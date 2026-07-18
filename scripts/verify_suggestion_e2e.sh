#!/bin/bash
# verify_suggestion_e2e.sh — End-to-end API-level verification of Phase 13.3
#                            activity-suggestions pipeline.
#
# Tests two cases:
#   FIRE case   — sends 3 messages with "Mình đang cảm thấy buồn." prefix
#                 (satisfies the 3-of-5 mood streak rule); asserts that
#                 action_recommendation.name is non-null in the response that
#                 triggers the streak.
#   NO-FIRE case — sends ONE neutral message in a fresh conversation; asserts
#                 action_recommendation is null.
#
# Also prints the `provider` field from each response as provider-agnostic
# evidence that the recommendation path is shared regardless of AI_PROVIDER.
#
# Prerequisites:
#   - Backend running at $BASE (default: http://localhost:8081/api/v1)
#   - Seed applied: bash scripts/apply_seed.sh
#   - jq installed (brew install jq / apt install jq)
#   - An existing user account; supply credentials via env:
#       EMAIL=<username> PASSWORD=<password> bash scripts/verify_suggestion_e2e.sh
#     (EMAIL maps to the `user_name` field used by /auth/login)
#
# Exit code: 0 if all assertions pass; non-zero if any assertion fails.

set -u

# ---------------------------------------------------------------------------
# Configuration — override via env
# ---------------------------------------------------------------------------
BASE="${BASE:-http://localhost:8081/api/v1}"
EMAIL="${EMAIL:?ERROR: EMAIL env var is required (the account user_name)}"
PASSWORD="${PASSWORD:?ERROR: PASSWORD env var is required}"

PASS_COUNT=0
FAIL_COUNT=0

# ---------------------------------------------------------------------------
# Helpers
# ---------------------------------------------------------------------------
_check_jq() {
    if ! command -v jq >/dev/null 2>&1; then
        echo "ERROR: jq is required but not installed."
        echo "       Install: brew install jq  OR  apt install jq"
        exit 1
    fi
}

_pass() {
    echo "[PASS] $1"
    PASS_COUNT=$((PASS_COUNT + 1))
}

_fail() {
    echo "[FAIL] $1"
    FAIL_COUNT=$((FAIL_COUNT + 1))
}

# POST helper: send JSON body, return response body
_post() {
    local url="$1"
    local body="$2"
    local auth_header="${3:-}"
    if [ -n "$auth_header" ]; then
        curl -s -X POST "$url" \
            -H "Content-Type: application/json" \
            -H "Authorization: Bearer $auth_header" \
            -d "$body"
    else
        curl -s -X POST "$url" \
            -H "Content-Type: application/json" \
            -d "$body"
    fi
}

_get() {
    local url="$1"
    local auth_header="$2"
    curl -s -X GET "$url" \
        -H "Authorization: Bearer $auth_header"
}

_send_chat() {
    local convo_id="$1"
    local content="$2"
    local token="$3"
    _post "$BASE/messages/chat" \
        "{\"conversation_id\":\"$convo_id\",\"content\":\"$content\",\"message_type\":\"text\"}" \
        "$token"
}

# ---------------------------------------------------------------------------
# Step 0: Pre-flight
# ---------------------------------------------------------------------------
_check_jq

echo "========================================"
echo "  verify_suggestion_e2e.sh"
echo "========================================"
echo "Base URL : $BASE"
echo "User     : $EMAIL"
echo ""

# ---------------------------------------------------------------------------
# Step 1: Login
# ---------------------------------------------------------------------------
echo "[Step 1] Logging in as $EMAIL ..."
LOGIN_RESP=$(_post "$BASE/auth/login" \
    "{\"user_name\":\"$EMAIL\",\"password\":\"$PASSWORD\"}")

TOKEN=$(echo "$LOGIN_RESP" | jq -r '.access_token // empty')
if [ -z "$TOKEN" ]; then
    echo "ERROR: Login failed — could not extract access_token."
    echo "       Response: $LOGIN_RESP"
    exit 1
fi
echo "         access_token obtained (${#TOKEN} chars)."
echo ""

# ---------------------------------------------------------------------------
# Step 2: FIRE CASE — create conversation, send 3 same-mood messages
# ---------------------------------------------------------------------------
echo "[Step 2] FIRE CASE — 3-of-5 mood streak (buồn) ..."

echo "         Creating conversation for FIRE case ..."
CREATE_RESP=$(_post "$BASE/conversations/" \
    "{\"persona\":\"Komo\",\"user_id\":\"\"}" \
    "$TOKEN")

# Backend returns {"message":..., "success":true} — no ID in body.
# Recover the newest conversation via GET /conversations/.
echo "         Fetching conversation list to get newest ID ..."
CONVO_LIST=$(_get "$BASE/conversations/" "$TOKEN")
CONVO_ID=$(echo "$CONVO_LIST" | jq -r '.data | sort_by(.created_at) | last | .id // empty')

if [ -z "$CONVO_ID" ]; then
    echo "ERROR: Could not retrieve a conversation ID."
    echo "       GET /conversations/ response: $CONVO_LIST"
    exit 1
fi
echo "         Using conversation ID: $CONVO_ID"
echo ""

# Send messages 1 and 2 (same sad mood — build streak, no fire yet)
SAD_PREFIX="Mình đang cảm thấy buồn. "

echo "         Sending message 1 (buồn prefix + text) ..."
RESP1=$(_send_chat "$CONVO_ID" "${SAD_PREFIX}Hôm nay mọi thứ thật tệ." "$TOKEN")
PROVIDER1=$(echo "$RESP1" | jq -r '.provider // "unknown"')
AR1=$(echo "$RESP1" | jq -c '.action_recommendation')
echo "         msg1 provider=$PROVIDER1 action_recommendation=$AR1"
echo ""

echo "         Sending message 2 (buồn prefix + text) ..."
RESP2=$(_send_chat "$CONVO_ID" "${SAD_PREFIX}Tôi cảm thấy rất buồn và không biết làm gì." "$TOKEN")
PROVIDER2=$(echo "$RESP2" | jq -r '.provider // "unknown"')
AR2=$(echo "$RESP2" | jq -c '.action_recommendation')
echo "         msg2 provider=$PROVIDER2 action_recommendation=$AR2"
echo ""

echo "         Sending message 3 (buồn prefix + text — should trigger streak) ..."
RESP3=$(_send_chat "$CONVO_ID" "${SAD_PREFIX}Mọi người xung quanh đều vui vẻ còn tôi thì không." "$TOKEN")
PROVIDER3=$(echo "$RESP3" | jq -r '.provider // "unknown"')
AR3=$(echo "$RESP3" | jq -c '.action_recommendation')
AR3_NAME=$(echo "$RESP3" | jq -r '.action_recommendation.name // empty')
echo "         msg3 provider=$PROVIDER3 action_recommendation=$AR3"
echo ""

echo "[Provider evidence - FIRE case] Providers: msg1=$PROVIDER1 msg2=$PROVIDER2 msg3=$PROVIDER3"
echo ""

# Assert: message 3 should have fired a suggestion (non-null action_recommendation.name)
if [ -n "$AR3_NAME" ]; then
    _pass "FIRE case: action_recommendation.name present ('$AR3_NAME') after 3-of-5 buồn streak"
else
    _fail "FIRE case: expected action_recommendation.name to be set on message 3 but got: $AR3"
fi
echo ""

# ---------------------------------------------------------------------------
# Step 3: NO-FIRE CASE — fresh conversation, one neutral message
# ---------------------------------------------------------------------------
echo "[Step 3] NO-FIRE CASE — single neutral message ..."

echo "         Creating fresh conversation for NO-FIRE case ..."
_post "$BASE/conversations/" \
    "{\"persona\":\"Komo\",\"user_id\":\"\"}" \
    "$TOKEN" > /dev/null

CONVO_LIST2=$(_get "$BASE/conversations/" "$TOKEN")
CONVO_ID2=$(echo "$CONVO_LIST2" | jq -r '.data | sort_by(.created_at) | last | .id // empty')

if [ -z "$CONVO_ID2" ]; then
    echo "ERROR: Could not retrieve a second conversation ID."
    exit 1
fi
echo "         Using conversation ID: $CONVO_ID2"

echo "         Sending one neutral message ..."
NEUTRAL_RESP=$(_send_chat "$CONVO_ID2" \
    "Hôm nay trời đẹp. Tôi chỉ muốn hỏi bạn một điều thôi." \
    "$TOKEN")
NEUTRAL_PROVIDER=$(echo "$NEUTRAL_RESP" | jq -r '.provider // "unknown"')
NEUTRAL_AR=$(echo "$NEUTRAL_RESP" | jq -c '.action_recommendation')
echo "         neutral provider=$NEUTRAL_PROVIDER action_recommendation=$NEUTRAL_AR"
echo ""

echo "[Provider evidence - NO-FIRE case] Provider: $NEUTRAL_PROVIDER"
echo ""

# Assert: neutral one-off should have null action_recommendation
NEUTRAL_AR_NULL=$(echo "$NEUTRAL_RESP" | jq '.action_recommendation == null')
if [ "$NEUTRAL_AR_NULL" = "true" ]; then
    _pass "NO-FIRE case: action_recommendation is null for a single neutral message"
else
    _fail "NO-FIRE case: expected action_recommendation to be null but got: $NEUTRAL_AR"
fi
echo ""

# ---------------------------------------------------------------------------
# Summary
# ---------------------------------------------------------------------------
echo "========================================"
echo "  Results: $PASS_COUNT PASS  |  $FAIL_COUNT FAIL"
echo "========================================"

if [ "$FAIL_COUNT" -gt 0 ]; then
    exit 1
fi
exit 0
