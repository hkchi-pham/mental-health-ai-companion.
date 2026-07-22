import os

from fastapi import FastAPI, Depends, HTTPException, status
from fastapi.security import HTTPBearer, HTTPAuthorizationCredentials
from fastapi.middleware.cors import CORSMiddleware
from backend.router import ConversationRouter, MessageRouter, UserRouter, MoodLogRouter, JournalRouter, ContactAlertLogRouter, ContactAlertRouter, AuthRouter, TreeRouter, ActionRouter
from backend.router import ConfigRouter
from backend.router import GardenItemRouter, GardenDecorationRouter, GardenBadgeRouter, UserMeRouter
from config.bootstrap import init_garden_tables


app = FastAPI(
    title="Chatbot Ai Mental Health",
    description="Assistatn chatbot and social platform for teenager with emotional and/or mental struggles",
    version="1.0.0"
)

# CORS middleware.
# Browsers enforce CORS; native mobile clients (Flutter Android/iOS) don't send
# an Origin header, so this restriction does not affect the mobile app — it only
# closes the open-origins hole for web. Set ALLOWED_ORIGINS in .env as a
# comma-separated list (e.g. "https://app.example.com,http://localhost:3000").
_origins_env = os.getenv("ALLOWED_ORIGINS", "")
allowed_origins = [o.strip() for o in _origins_env.split(",") if o.strip()] or [
    "http://localhost",
    "http://localhost:3000",
    "http://localhost:8080",
    "http://127.0.0.1:3000",
]

# Dev convenience: Flutter web (`flutter run -d chrome`) picks a RANDOM localhost
# port each run (e.g. :9100), which would otherwise fail CORS. Allow any
# localhost / 127.0.0.1 port via regex so local web dev always works. Explicit
# allowed_origins above still cover non-localhost (prod) origins.
_LOCALHOST_ORIGIN_REGEX = r"https?://(localhost|127\.0\.0\.1)(:\d+)?"

app.add_middleware(
    CORSMiddleware,
    allow_origins=allowed_origins,
    allow_origin_regex=_LOCALHOST_ORIGIN_REGEX,
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)


@app.on_event("startup")
def _bootstrap_garden_tables():
    init_garden_tables()


app.include_router(ConversationRouter.router, prefix="/api/v1")
app.include_router(UserMeRouter.router, prefix="/api/v1")
app.include_router(UserRouter.router, prefix="/api/v1")
app.include_router(MessageRouter.router, prefix="/api/v1")
app.include_router(MoodLogRouter.router, prefix="/api/v1")
app.include_router(JournalRouter.router, prefix="/api/v1")
app.include_router(ContactAlertLogRouter.router, prefix="/api/v1")
app.include_router(ContactAlertRouter.router, prefix="/api/v1")
app.include_router(AuthRouter.router, prefix="/api/v1")
app.include_router(TreeRouter.router, prefix="/api/v1")
app.include_router(ConfigRouter.router, prefix="/api/v1")
app.include_router(ActionRouter.router, prefix="/api/v1")
app.include_router(GardenItemRouter.router, prefix="/api/v1")
app.include_router(GardenDecorationRouter.router, prefix="/api/v1")
app.include_router(GardenBadgeRouter.router, prefix="/api/v1")
