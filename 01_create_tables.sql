-- Departments
CREATE TABLE departments (
    department_id SERIAL PRIMARY KEY,
    department_name VARCHAR(100) NOT NULL UNIQUE
);

-- Locations
CREATE TABLE locations (
    location_id SERIAL PRIMARY KEY,
    location_name VARCHAR(100) NOT NULL,
    department_id INT REFERENCES departments(department_id)
);

-- Users (students + staff)
CREATE TABLE users (
    user_id SERIAL PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    role VARCHAR(30) NOT NULL,
    duo_authenticated BOOLEAN DEFAULT FALSE,
    department_id INT REFERENCES departments(department_id),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Lost item reports
CREATE TABLE lost_reports (
    lost_report_id SERIAL PRIMARY KEY,
    user_id INT REFERENCES users(user_id),
    item_name VARCHAR(100) NOT NULL,
    description TEXT NOT NULL,
    category VARCHAR(50),
    color VARCHAR(50),
    date_lost DATE,
    location_id INT REFERENCES locations(location_id),
    contact_info VARCHAR(100),
    status VARCHAR(30) DEFAULT 'lost',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Found items logged by staff
CREATE TABLE found_items (
    found_item_id SERIAL PRIMARY KEY,
    logged_by_user_id INT REFERENCES users(user_id),
    item_name VARCHAR(100) NOT NULL,
    description TEXT NOT NULL,
    category VARCHAR(50),
    color VARCHAR(50),
    date_found DATE,
    location_id INT REFERENCES locations(location_id),
    status VARCHAR(30) DEFAULT 'found',
    high_value_flag BOOLEAN DEFAULT FALSE,
    retention_days INT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Matches between lost and found
CREATE TABLE matches (
    match_id SERIAL PRIMARY KEY,
    lost_report_id INT REFERENCES lost_reports(lost_report_id),
    found_item_id INT REFERENCES found_items(found_item_id),
    match_score DECIMAL(5,2),
    reviewed_by_user_id INT REFERENCES users(user_id),
    match_status VARCHAR(30) DEFAULT 'pending',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Claims (when item is returned)
CREATE TABLE claims (
    claim_id SERIAL PRIMARY KEY,
    match_id INT REFERENCES matches(match_id),
    claimed_by_user_id INT REFERENCES users(user_id),
    verified_by_user_id INT REFERENCES users(user_id),
    proof_notes TEXT,
    claim_datetime TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);