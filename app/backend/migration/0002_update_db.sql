CREATE TABLE authentication(
    access_token VARCHAR(512) NOT NULL,
    expires_in TIMESTAMP NOT NULL,
    user_name VARCHAR(64) NOT NULL,
    user_id VARCHAR(36) NOT NULL

);
