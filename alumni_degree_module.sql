-- ========================================
-- Project: KSU Alumni Management Database
-- Author: [Your Name]
-- Date: [Insert date]
-- Description:
--   SQL scripts for Alumni CRUD operations
--   and Degree Management module.
-- ========================================

-- ==========================
-- DROP TABLES IF EXIST (for testing resets)
-- ==========================
IF OBJECT_ID('Degree', 'U') IS NOT NULL
    DROP TABLE Degree;
IF OBJECT_ID('Alumni', 'U') IS NOT NULL
    DROP TABLE Alumni;

-- ==========================
-- CREATE Alumni TABLE
-- ==========================
CREATE TABLE Alumni (
    alumni_id INT PRIMARY KEY IDENTITY(1,1),
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100),
    phone VARCHAR(20)
);

-- ==========================
-- CREATE Degree TABLE
-- ==========================
CREATE TABLE Degree (
    degree_id INT PRIMARY KEY IDENTITY(1,1),
    alumni_id INT NOT NULL,
    university_name VARCHAR(100) NOT NULL,
    graduation_date DATE,
    major VARCHAR(100),
    minor VARCHAR(100),
    degree_type VARCHAR(50),
    FOREIGN KEY (alumni_id) REFERENCES Alumni(alumni_id)
);

-- ==========================
-- INSERT SAMPLE Alumni DATA
-- ==========================
INSERT INTO Alumni (first_name, last_name, email, phone)
VALUES 
('John', 'Doe', 'john.doe@email.com', '555-1234'),
('Jane', 'Smith', 'jane.smith@email.com', '555-5678');

-- ==========================
-- INSERT SAMPLE Degree DATA
-- ==========================
INSERT INTO Degree (alumni_id, university_name, graduation_date, major, minor, degree_type)
VALUES
(1, 'Kennesaw State University', '2022-05-10', 'Information Systems', 'Business', 'Bachelor\'s'),
(2, 'Kennesaw State University', '2021-12-15', 'Computer Science', NULL, 'Bachelor\'s');

-- ==========================
-- SELECT ALL Alumni
-- ==========================
SELECT * FROM Alumni;

-- ==========================
-- SELECT Alumni WITH Degrees
-- ==========================
SELECT 
    a.alumni_id,
    a.first_name,
    a.last_name,
    d.degree_type,
    d.major,
    d.minor,
    d.university_name,
    d.graduation_date
FROM Alumni a
LEFT JOIN Degree d ON a.alumni_id = d.alumni_id;

-- ==========================
-- UPDATE Alumni RECORD
-- Example: Update Jane's phone number
-- ==========================
UPDATE Alumni
SET phone = '555-9999'
WHERE alumni_id = 2;

-- ==========================
-- DELETE Alumni RECORD
-- Example: Delete John Doe
-- (Ensure FK constraints allow or handle via cascading or manual delete of dependent records)
-- ==========================
DELETE FROM Degree
WHERE alumni_id = 1;

DELETE FROM Alumni
WHERE alumni_id = 1;

-- ==========================
-- ADD Degree RECORD
-- Example: Add Master’s degree for Jane Smith
-- ==========================
INSERT INTO Degree (alumni_id, university_name, graduation_date, major, minor, degree_type)
VALUES
(2, 'Georgia Tech', '2023-12-15', 'Data Analytics', NULL, 'Master\'s');

-- ==========================
-- UPDATE Degree RECORD
-- Example: Update Jane's Bachelor major to Software Engineering
-- ==========================
UPDATE Degree
SET major = 'Software Engineering'
WHERE degree_id = 2;

-- ==========================
-- DELETE Degree RECORD
-- Example: Delete a specific degree
-- ==========================
DELETE FROM Degree
WHERE degree_id = 3;

-- ========================================
-- END OF SCRIPT
-- ========================================
