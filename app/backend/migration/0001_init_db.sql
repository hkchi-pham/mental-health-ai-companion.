
CREATE TABLE users (
    id VARCHAR(36) PRIMARY KEY,
    fullname VARCHAR(128) NOT NULL,
    user_name VARCHAR(128) NOT NULL UNIQUE,
    dob DATE,
    gender BOOLEAN,
    email VARCHAR(128) NOT NULL,
    hashed_password VARCHAR(128) NOT NULL,
    phone VARCHAR(128) NOT NULL,
    address VARCHAR(256),
    avatar VARCHAR(256) NOT NULL,
    created_at TIMESTAMP NOT NULL,
    updated_at TIMESTAMP,
    deleted_at TIMESTAMP,
    created_by VARCHAR(128) NULL,
    updated_by VARCHAR(128) NULL
);

/* tach du lieu ra, foreign key 
*/
CREATE TABLE conversations (
    id VARCHAR(36) PRIMARY KEY,
    user_id VARCHAR(36) NOT NULL,
    persona VARCHAR(128) NOT NULL,
    ended_at TIMESTAMP,
    created_at TIMESTAMP NOT NULL,
    updated_at TIMESTAMP,
    deleted_at TIMESTAMP,
    created_by VARCHAR(128) NULL,
    updated_by VARCHAR(128) NULL,

    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
    
);


CREATE TABLE messages (
    id VARCHAR(36) PRIMARY KEY,
    conversation_id VARCHAR(36) NOT NULL,
    sender_id VARCHAR(36) NOT NULL,
    content TEXT NOT NULL,
    message_type VARCHAR(50) DEFAULT 'TEXT', 
    created_at TIMESTAMP NOT NULL,
    updated_at TIMESTAMP,
    deleted_at TIMESTAMP,
    created_by VARCHAR(128) NULL,
    updated_by VARCHAR(128) NULL,

    FOREIGN KEY (sender_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (conversation_id) REFERENCES conversations(id) ON DELETE CASCADE
);


CREATE TABLE mood_logs (
    id VARCHAR(36) PRIMARY KEY,
    user_id VARCHAR(36) NOT NULL,
    conversation_id VARCHAR(36) NOT NULL,
    mood VARCHAR(64) NOT NULL, 
    note TEXT,
    created_at TIMESTAMP NOT NULL,
    updated_at TIMESTAMP,
    deleted_at TIMESTAMP,
    created_by VARCHAR(128) NULL,
    updated_by VARCHAR(128) NULL,

    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (conversation_id) REFERENCES conversations(id) ON DELETE CASCADE
);

CREATE TABLE journals (
  id VARCHAR(36) PRIMARY KEY,
  user_id VARCHAR(36) REFERENCES users(id),
  content TEXT,
  visibility TEXT CHECK (visibility IN ('private','public')),
  created_at TIMESTAMP NOT NULL,
  updated_at TIMESTAMP,
  deleted_at TIMESTAMP,
  created_by VARCHAR(128) NULL,
  updated_by VARCHAR(128) NULL,

  FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
    
);

CREATE TABLE contact_alerts (
    id VARCHAR(36) PRIMARY KEY,
    user_id VARCHAR(36) NOT NULL,
    alert_type VARCHAR(50) NOT NULL, -- e.g. EMERGENCY, LOW_MOOD
    contact_name VARCHAR(128) NOT NULL,
    contact_relation VARCHAR(64),
    contact_phone VARCHAR(20),
    contact_email VARCHAR(128),
    is_active BOOLEAN NOT NULL DEFAULT TRUE,
    created_at TIMESTAMP NOT NULL,
    updated_at TIMESTAMP,
    deleted_at TIMESTAMP,
    created_by VARCHAR(128) NULL,
    updated_by VARCHAR(128) NULL,

    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

CREATE TABLE contact_alert_logs (
    id VARCHAR(36) PRIMARY KEY,
    alert_id VARCHAR(36) NOT NULL,
    user_id VARCHAR(36) NOT NULL,
    trigger_reason TEXT,
    trigger_data JSONB,
    status VARCHAR(50) NOT NULL DEFAULT 'PENDING', -- PENDING, SENT, FAILED, ACKNOWLEDGED
    sent_at TIMESTAMP,
    response_at TIMESTAMP,
    response_detail TEXT,
    created_at TIMESTAMP NOT NULL,
    updated_at TIMESTAMP,
    deleted_at TIMESTAMP,
    created_by VARCHAR(128) NULL,
    updated_by VARCHAR(128) NULL,

    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (alert_id) REFERENCES contact_alerts(id) ON DELETE CASCADE
    
);
