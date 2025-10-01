from fastapi import FastAPI, Depends, HTTPException, status
from fastapi.security import HTTPBearer, HTTPAuthorizationCredentials
from fastapi.middleware.cors import CORSMiddleware
from router import ConversationRouter, MessageRouter,UserRouter,MoodLogRouter, JournalRouter, ContactAlertLogRouter, ContactAlertRouter, AuthRouter

app = FastAPI(
    title="Chatbot Ai Mental Health",
    description="Assistatn chatbot and social platform for teenager with emotional and/or mental struggles",
    version="1.0.0"
)

# CORS middleware
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)


app.include_router(ConversationRouter.router, prefix="/api/v1")
app.include_router(UserRouter.router, prefix="/api/v1")
app.include_router(MessageRouter.router, prefix="/api/v1")
app.include_router(MoodLogRouter.router, prefix="/api/v1")
app.include_router(JournalRouter.router, prefix="/api/v1")
app.include_router(ContactAlertLogRouter.router, prefix="/api/v1")
app.include_router(ContactAlertRouter.router, prefix="/api/v1")
app.include_router(AuthRouter.router, prefix="/api/v1")