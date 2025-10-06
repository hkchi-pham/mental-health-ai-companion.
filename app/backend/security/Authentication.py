# app/security/token.py
from datetime import datetime, timedelta
from jose import JWTError, jwt

SECRET_KEY = "yoursecretkey"
ALGORITHM = "HS256"
ACCESS_TOKEN_EXPIRE_MINUTES =  timedelta(minutes=30)

def create_access_token(data: dict, expires_delta: timedelta = None):
    print("start create token")
    to_encode = data.copy()
    print(to_encode)
    if expires_delta is None:
        expires_delta = timedelta(minutes=ACCESS_TOKEN_EXPIRE_MINUTES)
    expire = datetime.utcnow() + expires_delta
    print(expire)
    to_encode.update({"exp": expire})
    print("update expire")
    return jwt.encode(to_encode, SECRET_KEY, algorithm=ALGORITHM)

def auth123(token: str):
    print(123)