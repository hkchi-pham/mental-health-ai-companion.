from typing import Generic, TypeVar, List, Optional
from sqlmodel import SQLModel

T = TypeVar("T")

# endpoints that return a list of item
class PaginatedResponse(SQLModel, Generic[T]):
    message: str # status message or code
    data: List[T] #list of actual results (users, satellites, etc.).
    total: int # total number of records in DB
    page: int # current page number
    page_size: int # how many items per page
    total_pages: int # total number of page

# endpoints that return a single item or a succcess message
class SuccessResponse(SQLModel, Generic[T]):
    message: str # status message or code
    data: Optional[T] = None # the acutal resources

# error message
class ErrorResponse(SQLModel):
    detail: str # description of what went wrong

# Centralized list of message codes (success & error)
from enum import Enum
class MessageCode(str, Enum):
    # MESSAGE CODE BASE #
    PAYLOAD_NOT_FOUND = "PAYLOAD_NOT_FOUND"
    ERROR_BAD_REQUEST = "ERROR_BAD_REQUEST"

    # USER MESSAGE #
    CREATE_USER_SUCCESSFULLY = "CREATE_USER_SUCCESSFULLY"
    CREATE_USER_FAILED = "CREATE_USER_FAILED"
    UPDATE_USER_SUCCESSFULLY = "UPDATE_USER_SUCCESSFULLY"
    UPDATE_USER_FAILED = "UPDATE_USER_FAILED"
    DELETE_USER_SUCCESSFULLY = "DELETE_USER_SUCCESSFULLY"
    DELETE_USER_FAILED = "DELETE_USER_FAILED"
    USER_ID_REQUIRED = "USER_ID_REQUIRED"
    USER_NOT_FOUND = "USER_NOT_FOUND"
    USER_ALREADY_EXISTS = "USER_ALREADY_EXISTS"
    INVALID_USER_ID = "INVALID_USER_ID"
    USER_ID_IS_MISMATCH = "USER_ID_IS_MISMATCH"

    # AUDIT MESSAGE #
    LOGIN_SUCCESSFULLY = "LOGIN_SUCCESSFULLY"
    LOGIN_FAILED = "LOGIN_FAILED"
    LOGOUT_SUCCESSFULLY = "LOGOUT_SUCCESSFULLY"
    UNAUTHORIZED = "UNAUTHORIZED"
    FORBIDDEN = "FORBIDDEN"

    # SYSTEM MESSAGE #
    SERVER_ERROR = "SERVER_ERROR"
    VALIDATION_ERROR = "VALIDATION_ERROR"
    
    
    CREATE_PAYLOAD_SUCCESSFULLY = "CREATE_PAYLOAD_SUCCESSFULLY"
    SAT_NOT_FOUND = "SAT_NOT_FOUND"
    SAT_DELETE_FAILED = "SAT_DELETE_FAILED"
    SAT_DELETE_SUCCESS = "SAT_DELETE_SUCCESS"
    FILTER_PAYLOAD_SUCCESSFULLY = "FILTER_PAYLOAD_SUCCESSFULLY"
    PAYLOAD_ID_REQUIRED = "PAYLOAD_ID_REQUIRED"
    PAYLOAD_DELETE_FAILED = "PAYLOAD_DELETE_FAILED"
    PAYLOAD_DELETE_SUCCESS = "PAYLOAD_DELETE_SUCCESS"
    UPDATE_PAYLOAD_SUCCESSFULLY = "UPDATE_PAYLOAD_SUCCESSFULLY"
    PAYLOAD_IN_USE = "PAYLOAD_IN_USE"
    SAT_PAYLOAD_INSERT_SUCCESSFULLY = "SAT_PAYLOAD_INSERT_SUCCESSFULLY"
    SATELLITE_ID_IS_MISMATCH = "SATELLITE_ID_IS_MISMATCH"
    UPDATE_SAT_PAYLOAD_SUCCESSFULLY = "UPDATE_SAT_PAYLOAD_SUCCESSFULLY"
    DELETE_SAT_PAYLOAD_SUCCESSFULLY = "DELETE_SAT_PAYLOAD_SUCCESSFULLY"
