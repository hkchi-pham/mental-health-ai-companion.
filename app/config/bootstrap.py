from sqlmodel import SQLModel
from config.database import engine

# Import the three NEW table models so they register on SQLModel.metadata.
# (Currency reuses the existing users.points/water_units columns — no new user table/ALTER.)
from backend.models.GardenItemModel import GardenItemModel
from backend.models.GardenDecorationModel import GardenDecorationModel
from backend.models.GardenBadgeModel import GardenBadgeModel

# Per-conversation suggestion-state table (Phase 13.3-02).
# Idempotent — CREATE TABLE IF NOT EXISTS, no migration, no ALTER.
from backend.models.SuggestionStateModel import SuggestionStateModel


def init_garden_tables() -> None:
    """Create the garden_items / garden_decorations / garden_badges /
    conversation_suggestion_state tables if they do not already exist.
    Idempotent (CREATE TABLE IF NOT EXISTS): a no-op when the tables exist,
    never drops/alters existing tables or data. Safe to run every boot."""
    SQLModel.metadata.create_all(
        engine,
        tables=[
            GardenItemModel.__table__,
            GardenDecorationModel.__table__,
            GardenBadgeModel.__table__,
            SuggestionStateModel.__table__,
        ],
    )
