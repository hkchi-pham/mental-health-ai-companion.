from sqlmodel import Session, create_engine
from sqlalchemy.pool import StaticPool
import os
from dotenv import load_dotenv

# Load environment variables
load_dotenv()

# Database configuration
DATABASE_URL = os.getenv("DATABASE_URL", "postgresql://hkchi-p:abc123@db:5432/hkchi-p")

# Create engine
engine = create_engine(
    DATABASE_URL,
    echo=True,  # Set to False in production
    poolclass=StaticPool,
    connect_args={"check_same_thread": False} if "sqlite" in DATABASE_URL else {}
)

def get_db():
    """
    Database dependency for FastAPI routes.
    Provides a database session that automatically closes after use.
    """
    with Session(engine) as session:
        yield session