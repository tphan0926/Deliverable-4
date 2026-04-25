-- =========================================================
-- UMBC Lost & Found System Database Script
-- IS 436 Deliverable 4 - Data Modeling and Starting Design
-- This single SQL file creates all database tables and inserts sample data.
-- Database: PostgreSQL
-- =========================================================

-- =========================================================
-- Optional cleanup section
-- Drops tables in reverse dependency order so the script can be rerun.
-- =========================================================
DROP TABLE IF EXISTS claims;
DROP TABLE IF EXISTS matches;
DROP TABLE IF EXISTS found_items;
DROP TABLE IF EXISTS lost_reports;
DROP TABLE IF EXISTS users;
DROP TABLE IF EXISTS locations;
DROP TABLE IF EXISTS departments;

-- =========================================================
-- TABLE CREATION SECTION
-- =========================================================

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

-- Users: students, staff, police, and administrators
CREATE TABLE users (
    user_id SERIAL PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    role VARCHAR(30) NOT NULL,
    duo_authenticated BOOLEAN DEFAULT FALSE,
    department_id INT REFERENCES departments(department_id),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Lost item reports submitted by students/users
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

-- Found items logged by staff members
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

-- Matches between lost item reports and found items
CREATE TABLE matches (
    match_id SERIAL PRIMARY KEY,
    lost_report_id INT REFERENCES lost_reports(lost_report_id),
    found_item_id INT REFERENCES found_items(found_item_id),
    match_score DECIMAL(5,2),
    reviewed_by_user_id INT REFERENCES users(user_id),
    match_status VARCHAR(30) DEFAULT 'pending',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Claims for verified item returns
CREATE TABLE claims (
    claim_id SERIAL PRIMARY KEY,
    match_id INT REFERENCES matches(match_id),
    claimed_by_user_id INT REFERENCES users(user_id),
    verified_by_user_id INT REFERENCES users(user_id),
    proof_notes TEXT,
    claim_datetime TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- =========================================================
-- INSERT DATA SECTION
-- =========================================================

-- Insert departments
INSERT INTO departments (department_name) VALUES
('Campus Center'),
('UMBC Police'),
('Residential Life'),
('Facilities Management');

-- Insert locations
INSERT INTO locations (location_name, department_id) VALUES
('Commons Front Desk', 1),
('Police Office', 2),
('Patapsco Hall Desk', 3),
('Retriever Learning Center', 4);

-- Insert users
INSERT INTO users (full_name, email, role, duo_authenticated, department_id) VALUES
('Wilson Zhang', 'wzhang4@umbc.edu', 'student', TRUE, 1),
('Campus Center Staff', 'staff1@umbc.edu', 'staff', TRUE, 1),
('Police Officer', 'officer1@umbc.edu', 'police', TRUE, 2),
('Dorm Staff', 'dormstaff1@umbc.edu', 'staff', TRUE, 3);

-- Insert lost reports
INSERT INTO lost_reports
(user_id, item_name, description, category, color, date_lost, location_id, contact_info, status)
VALUES
(1, 'Water Bottle', 'Black Hydro Flask lost in the Game Room', 'Bottle', 'Black', '2026-03-10', 1, 'wzhang4@umbc.edu', 'lost'),
(1, 'Student ID Card', 'UMBC student ID lost near library entrance', 'ID Card', 'White', '2026-03-11', 4, 'wzhang4@umbc.edu', 'lost');

-- Insert found items
INSERT INTO found_items
(logged_by_user_id, item_name, description, category, color, date_found, location_id, status, high_value_flag, retention_days)
VALUES
(2, 'Water Bottle', 'Black metal bottle/hydro flask found at Commons desk', 'Bottle', 'Black', '2026-03-11', 1, 'found', FALSE, 30),
(3, 'Student ID Card', 'UMBC ID card turned in to campus police', 'ID Card', 'White', '2026-03-12', 2, 'found', TRUE, 395);

-- Insert matches
INSERT INTO matches
(lost_report_id, found_item_id, match_score, reviewed_by_user_id, match_status)
VALUES
(1, 1, 92.50, 2, 'confirmed'),
(2, 2, 97.00, 3, 'confirmed');

-- Insert claims
INSERT INTO claims
(match_id, claimed_by_user_id, verified_by_user_id, proof_notes)
VALUES
(1, 1, 2, 'Student showed campus ID and described the bottle correctly');

-- =========================================================
-- Verification Queries
-- These can be run after the script to verify the database tables.
-- =========================================================
SELECT * FROM departments;
SELECT * FROM locations;
SELECT * FROM users;
SELECT * FROM lost_reports;
SELECT * FROM found_items;
SELECT * FROM matches;
SELECT * FROM claims;
