# UMBC Lost & Found System – Deliverable 4

## Project Overview
This project designs a centralized Lost & Found system for UMBC, focusing on data modeling, database design, and system architecture. The system replaces manual tracking processes with a structured digital solution that supports lost item reporting, found item logging, automated matching, and claim verification.

---

## Technologies Used
- PostgreSQL  
- SQL  
- Docker (from previous deliverable)  
- Node.js (planned backend)  
- React.js (planned frontend)  
- ERD Design Tools (draw.io / Lucidchart)  

---

## Data Model (Deliverable 4)
The system uses a normalized relational database (Third Normal Form – 3NF) to ensure data consistency and reduce redundancy.

Key entities include:
- Users  
- Departments  
- Locations  
- Lost Reports  
- Found Items  
- Matches  
- Claims  

The database supports:
- Automated matching between lost and found items  
- Role-based access control  
- Multi-department data sharing  
- Claim verification and tracking  

---

## Entity-Relationship Diagram (ERD)
The ERD illustrates all entities, relationships, primary keys, and foreign keys used in the system. It ensures the database structure follows Third Normal Form (3NF) and accurately represents how data flows between system components.

---

## Database Setup
A single SQL script (`lost_found_database.sql`) is included, which:
- Creates all database tables  
- Defines primary and foreign key relationships  
- Inserts sample data for testing  

This script can be executed within a Docker container to initialize the database environment.

---

## System Architecture
The system follows a **cloud-based thin-client architecture**:

- Users access the system through web or mobile browsers  
- Requests pass through a secure network layer (DNS, firewall, load balancer)  
- Application servers handle business logic and API requests  
- A centralized database stores all system data  
- Monitoring and logging ensure system reliability and performance  

This architecture supports scalability, security, and ease of maintenance.

---

## Contents
- ERD Diagram  
- SQL Script (database creation + sample data)  
- Architecture Diagram  
- Design documentation (submitted separately)
