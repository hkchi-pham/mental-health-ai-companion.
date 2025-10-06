from datetime import datetime
import uuid


def get_current_time():
    """
    Returns the current timestamp as a string in ISO format.
    """
    return datetime.now().isoformat()


def generate_uuid():
    """Generate a new UUID string"""
    return str(uuid.uuid4())