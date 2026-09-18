/*
    CareerPath Database Setup
    Database: CareerPathDB
    Schema: CareerPath

    Run this script in SQL Server Management Studio (SSMS).
    It creates the database and all required tables, constraints,
    relationships, and validation rules.
*/

USE master;
GO

-- =========================================================
-- 1. CREATE DATABASE
-- =========================================================

USE master;
GO

IF DB_ID('CareerPathDB') IS NOT NULL
BEGIN
    ALTER DATABASE CareerPathDB
    SET SINGLE_USER
    WITH ROLLBACK IMMEDIATE;

    DROP DATABASE CareerPathDB;
END
GO

CREATE DATABASE CareerPathDB;
GO

-- =========================================================
-- 2. USE DATABASE
-- =========================================================

USE CareerPathDB;
GO

-- =========================================================
-- 3. CREATE SCHEMA
-- =========================================================

IF NOT EXISTS (
    SELECT 1
    FROM sys.schemas
    WHERE name = 'CareerPath'
)
BEGIN
    EXEC('CREATE SCHEMA CareerPath');
END
GO

-- =========================================================
-- 4. USERS
-- =========================================================

CREATE TABLE CareerPath.Users
(
    UserId INT IDENTITY(1,1) NOT NULL,
    FirstName NVARCHAR(50) NOT NULL,
    LastName NVARCHAR(50) NOT NULL,
    Email NVARCHAR(100) NOT NULL,
    PasswordHash NVARCHAR(255) NOT NULL,
    UserType NVARCHAR(30) NOT NULL,
    CreatedAt DATETIME NOT NULL
        CONSTRAINT DF_Users_CreatedAt DEFAULT (GETDATE()),

    CONSTRAINT PK_Users
        PRIMARY KEY (UserId),

    CONSTRAINT UQ_Users_Email
        UNIQUE (Email),

    CONSTRAINT CK_Users_UserType
        CHECK (
            UserType = 'Graduate'
            OR UserType = 'Student'
            OR UserType = 'Learner'
        )
);
GO

-- =========================================================
-- 5. SUBJECTS
-- =========================================================

CREATE TABLE CareerPath.Subjects
(
    SubjectId INT IDENTITY(1,1) NOT NULL,
    SubjectName NVARCHAR(100) NOT NULL,

    CONSTRAINT PK_Subjects
        PRIMARY KEY (SubjectId),

    CONSTRAINT UQ_Subjects_SubjectName
        UNIQUE (SubjectName)
);
GO

-- =========================================================
-- 6. COURSES
-- =========================================================

CREATE TABLE CareerPath.Courses
(
    CourseId INT IDENTITY(1,1) NOT NULL,
    CourseName NVARCHAR(150) NOT NULL,
    Faculty NVARCHAR(100) NOT NULL,
    QualificationType NVARCHAR(100) NOT NULL,
    MinimumAPS INT NOT NULL,
    DurationYears INT NOT NULL,
    Description NVARCHAR(500) NOT NULL,

    CONSTRAINT PK_Courses
        PRIMARY KEY (CourseId),

    CONSTRAINT CK_Courses_MinimumAPS
        CHECK (MinimumAPS >= 0),

    CONSTRAINT CK_Courses_DurationYears
        CHECK (DurationYears > 0)
);
GO

-- =========================================================
-- 7. CAREERS
-- =========================================================

CREATE TABLE CareerPath.Careers
(
    CareerId INT IDENTITY(1,1) NOT NULL,
    CareerName NVARCHAR(100) NOT NULL,
    CareerField NVARCHAR(100) NOT NULL,
    Description NVARCHAR(500) NOT NULL,

    CONSTRAINT PK_Careers
        PRIMARY KEY (CareerId)
);
GO

-- =========================================================
-- 8. BURSARIES
-- =========================================================

CREATE TABLE CareerPath.Bursaries
(
    BursaryId INT IDENTITY(1,1) NOT NULL,
    BursaryName NVARCHAR(150) NOT NULL,
    Provider NVARCHAR(150) NOT NULL,
    Description NVARCHAR(500) NOT NULL,
    MinimumAPS INT NULL,
    FieldOfStudy NVARCHAR(100) NOT NULL,
    ClosingDate DATE NOT NULL,
    Eligibility NVARCHAR(500) NOT NULL,
    ApplicationURL NVARCHAR(500) NOT NULL,

    CONSTRAINT PK_Bursaries
        PRIMARY KEY (BursaryId),

    CONSTRAINT CK_Bursaries_MinimumAPS
        CHECK (
            MinimumAPS IS NULL
            OR MinimumAPS >= 0
        )
);
GO

-- =========================================================
-- 9. JOBS
-- =========================================================

CREATE TABLE CareerPath.Jobs
(
    JobId INT IDENTITY(1,1) NOT NULL,
    JobTitle NVARCHAR(150) NOT NULL,
    Company NVARCHAR(150) NOT NULL,
    Description NVARCHAR(500) NOT NULL,
    Location NVARCHAR(100) NOT NULL,
    JobType NVARCHAR(50) NOT NULL,
    Field NVARCHAR(100) NOT NULL,
    ClosingDate DATE NOT NULL,
    ApplicationURL NVARCHAR(500) NOT NULL,

    CONSTRAINT PK_Jobs
        PRIMARY KEY (JobId),

    CONSTRAINT CK_Jobs_JobType
        CHECK (
            JobType = 'Part-Time'
            OR JobType = 'Full-Time'
            OR JobType = 'Internship'
            OR JobType = 'Graduate Programme'
        )
);
GO

-- =========================================================
-- 10. APPLICATIONS
-- =========================================================

CREATE TABLE CareerPath.Applications
(
    ApplicationId INT IDENTITY(1,1) NOT NULL,
    UserId INT NOT NULL,
    CourseId INT NOT NULL,
    ApplicationDate DATE NOT NULL,
    Status NVARCHAR(30) NOT NULL,
    Notes NVARCHAR(500) NULL,

    CONSTRAINT PK_Applications
        PRIMARY KEY (ApplicationId),

    CONSTRAINT UQ_Applications_UserCourse
        UNIQUE (UserId, CourseId),

    CONSTRAINT CK_Applications_Status
        CHECK (
            Status = 'Rejected'
            OR Status = 'Accepted'
            OR Status = 'Under Review'
            OR Status = 'Submitted'
        )
);
GO

-- =========================================================
-- 11. COURSE SUBJECTS
-- =========================================================

CREATE TABLE CareerPath.CourseSubjects
(
    CourseId INT NOT NULL,
    SubjectId INT NOT NULL,
    MinimumMark DECIMAL(5,2) NOT NULL,

    CONSTRAINT PK_CourseSubjects
        PRIMARY KEY (CourseId, SubjectId),

    CONSTRAINT CK_CourseSubjects_MinimumMark
        CHECK (
            MinimumMark >= 0
            AND MinimumMark <= 100
        )
);
GO

-- =========================================================
-- 12. USER SUBJECTS
-- =========================================================

CREATE TABLE CareerPath.UserSubjects
(
    UserId INT NOT NULL,
    SubjectId INT NOT NULL,
    Mark DECIMAL(5,2) NOT NULL,
    APSPoints INT NOT NULL,

    CONSTRAINT PK_UserSubjects
        PRIMARY KEY (UserId, SubjectId),

    CONSTRAINT CK_UserSubjects_Mark
        CHECK (
            Mark >= 0
            AND Mark <= 100
        ),

    CONSTRAINT CK_UserSubjects_APSPoints
        CHECK (
            APSPoints >= 0
            AND APSPoints <= 8
        )
);
GO

-- =========================================================
-- 13. APPLICATION DOCUMENTS
-- =========================================================

CREATE TABLE CareerPath.ApplicationDocuments
(
    DocumentId INT IDENTITY(1,1) NOT NULL,
    ApplicationId INT NOT NULL,
    FileName NVARCHAR(255) NOT NULL,
    FileType NVARCHAR(100) NOT NULL,
    FileSize BIGINT NOT NULL,
    FilePath NVARCHAR(500) NOT NULL,
    UploadedAt DATETIME NOT NULL
        CONSTRAINT DF_ApplicationDocuments_UploadedAt
        DEFAULT (GETDATE()),

    CONSTRAINT PK_ApplicationDocuments
        PRIMARY KEY (DocumentId),

    CONSTRAINT UQ_ApplicationDocuments_ApplicationId
        UNIQUE (ApplicationId),

    CONSTRAINT CK_ApplicationDocuments_FileSize
        CHECK (FileSize > 0)
);
GO

-- =========================================================
-- 14. FOREIGN KEYS
-- =========================================================

-- Applications -> Users
ALTER TABLE CareerPath.Applications
ADD CONSTRAINT FK_Applications_Users
    FOREIGN KEY (UserId)
    REFERENCES CareerPath.Users(UserId);
GO

-- Applications -> Courses
ALTER TABLE CareerPath.Applications
ADD CONSTRAINT FK_Applications_Courses
    FOREIGN KEY (CourseId)
    REFERENCES CareerPath.Courses(CourseId);
GO

-- ApplicationDocuments -> Applications
ALTER TABLE CareerPath.ApplicationDocuments
ADD CONSTRAINT FK_ApplicationDocuments_Applications
    FOREIGN KEY (ApplicationId)
    REFERENCES CareerPath.Applications(ApplicationId);
GO

-- CourseSubjects -> Courses
ALTER TABLE CareerPath.CourseSubjects
ADD CONSTRAINT FK_CourseSubjects_Courses
    FOREIGN KEY (CourseId)
    REFERENCES CareerPath.Courses(CourseId);
GO

-- CourseSubjects -> Subjects
ALTER TABLE CareerPath.CourseSubjects
ADD CONSTRAINT FK_CourseSubjects_Subjects
    FOREIGN KEY (SubjectId)
    REFERENCES CareerPath.Subjects(SubjectId);
GO

-- UserSubjects -> Users
ALTER TABLE CareerPath.UserSubjects
ADD CONSTRAINT FK_UserSubjects_Users
    FOREIGN KEY (UserId)
    REFERENCES CareerPath.Users(UserId);
GO

-- UserSubjects -> Subjects
ALTER TABLE CareerPath.UserSubjects
ADD CONSTRAINT FK_UserSubjects_Subjects
    FOREIGN KEY (SubjectId)
    REFERENCES CareerPath.Subjects(SubjectId);
GO

-- =========================================================
-- DATABASE SETUP COMPLETE
-- =========================================================

PRINT 'CareerPathDB database setup completed successfully.';
GO

-- =========================================================
-- 15. DUMMY DATA
-- =========================================================

USE CareerPathDB;
GO

-- =========================================================
-- SUBJECTS
-- =========================================================

INSERT INTO CareerPath.Subjects (SubjectName)
VALUES
('Mathematics'),
('Mathematical Literacy'),
('Physical Sciences'),
('Life Sciences'),
('Accounting'),
('Business Studies'),
('Computer Applications Technology'),
('English Home Language'),
('English First Additional Language'),
('Information Technology');
GO


-- =========================================================
-- USERS
-- =========================================================

INSERT INTO CareerPath.Users
    (FirstName, LastName, Email, PasswordHash, UserType)
VALUES
('Lerato', 'Mokoena', 'lerato@example.com', 'dummy_hash_123', 'Learner'),
('Sipho', 'Dlamini', 'sipho@example.com', 'dummy_hash_456', 'Learner'),
('Amahle', 'Ndlovu', 'amahle@example.com', 'dummy_hash_789', 'Student'),
('Thando', 'Mthembu', 'thando@example.com', 'dummy_hash_101', 'Student'),
('Zanele', 'Khumalo', 'zanele@example.com', 'dummy_hash_202', 'Graduate'),
('Lungelo', 'Mbeki', 'lungelo@example.com', 'dummy_hash_303', 'Graduate');
GO


-- =========================================================
-- COURSES
-- =========================================================

INSERT INTO CareerPath.Courses
    (CourseName, Faculty, QualificationType, MinimumAPS, DurationYears, Description)
VALUES
(
    'Diploma in Information Technology',
    'Faculty of Science',
    'Diploma',
    30,
    3,
    'A diploma programme covering software development, databases, networking and information systems.'
),
(
    'Bachelor of Computer Science',
    'Faculty of Science',
    'Degree',
    38,
    3,
    'A degree focusing on computer science, programming, algorithms, databases and software engineering.'
),
(
    'Bachelor of Accounting',
    'Faculty of Business',
    'Degree',
    35,
    3,
    'A degree covering financial accounting, management accounting, taxation and auditing.'
),
(
    'Bachelor of Business Administration',
    'Faculty of Business',
    'Degree',
    32,
    3,
    'A business qualification covering management, marketing, finance and entrepreneurship.'
),
(
    'Diploma in Software Development',
    'Faculty of Computing',
    'Diploma',
    28,
    3,
    'A practical programme focused on software development, web applications and databases.'
);
GO


-- =========================================================
-- CAREERS
-- =========================================================

INSERT INTO CareerPath.Careers
    (CareerName, CareerField, Description)
VALUES
(
    'Software Developer',
    'Information Technology',
    'Develops, tests and maintains software applications.'
),
(
    'Database Administrator',
    'Information Technology',
    'Manages databases, data security, backups and database performance.'
),
(
    'Web Developer',
    'Information Technology',
    'Creates and maintains websites and web applications.'
),
(
    'Accountant',
    'Finance',
    'Prepares financial records, reports and statements for organisations.'
),
(
    'Business Analyst',
    'Business',
    'Analyses business requirements and helps organisations improve their processes and systems.'
),
(
    'Cybersecurity Analyst',
    'Information Technology',
    'Monitors systems and helps protect organisations against cybersecurity threats.'
);
GO


-- =========================================================
-- BURSARIES
-- =========================================================

INSERT INTO CareerPath.Bursaries
    (BursaryName, Provider, Description, MinimumAPS, FieldOfStudy,
     ClosingDate, Eligibility, ApplicationURL)
VALUES
(
    'Future Tech Bursary',
    'Future Tech Foundation',
    'Financial support for students studying technology-related qualifications.',
    30,
    'Information Technology',
    '2027-01-31',
    'South African students studying an approved technology qualification.',
    'https://example.com/future-tech'
),
(
    'Science and Engineering Bursary',
    'STEM Education Trust',
    'Funding opportunity for students pursuing science, engineering and technology studies.',
    32,
    'Science and Technology',
    '2027-02-15',
    'Students with strong academic performance in STEM subjects.',
    'https://example.com/stem-bursary'
),
(
    'Business Leaders Bursary',
    'Business Leaders Foundation',
    'Bursary programme supporting students studying business-related qualifications.',
    30,
    'Business',
    '2027-02-28',
    'Students registered for an approved business qualification.',
    'https://example.com/business-bursary'
),
(
    'Accounting Excellence Bursary',
    'Finance Education Trust',
    'Financial assistance for students pursuing accounting qualifications.',
    35,
    'Accounting',
    '2027-01-20',
    'Students interested in accounting and finance careers.',
    'https://example.com/accounting-bursary'
);
GO


-- =========================================================
-- JOBS
-- =========================================================

INSERT INTO CareerPath.Jobs
    (JobTitle, Company, Description, Location, JobType,
     Field, ClosingDate, ApplicationURL)
VALUES
(
    'Junior Software Developer',
    'Tech Solutions SA',
    'Entry-level software development position working on web and desktop applications.',
    'Gqeberha',
    'Graduate Programme',
    'Software Development',
    '2027-02-15',
    'https://example.com/jobs/software-developer'
),
(
    'IT Intern',
    'Digital Systems',
    'Internship opportunity supporting software, hardware and IT operations.',
    'East London',
    'Internship',
    'Information Technology',
    '2027-01-30',
    'https://example.com/jobs/it-intern'
),
(
    'Junior Web Developer',
    'WebWorks',
    'Develop and maintain responsive websites and web applications.',
    'Cape Town',
    'Full-Time',
    'Web Development',
    '2027-02-20',
    'https://example.com/jobs/web-developer'
),
(
    'Junior Accountant',
    'Finance Group SA',
    'Entry-level accounting role assisting with financial records and reporting.',
    'Johannesburg',
    'Full-Time',
    'Accounting',
    '2027-02-10',
    'https://example.com/jobs/accountant'
),
(
    'Business Analyst Intern',
    'Business Solutions',
    'Assist business analysts with requirements gathering and process analysis.',
    'Durban',
    'Internship',
    'Business Analysis',
    '2027-03-01',
    'https://example.com/jobs/business-analyst'
),
(
    'Cybersecurity Graduate',
    'SecureNet SA',
    'Graduate position assisting with security monitoring and incident analysis.',
    'Pretoria',
    'Graduate Programme',
    'Cybersecurity',
    '2027-02-25',
    'https://example.com/jobs/cybersecurity'
);
GO


-- =========================================================
-- COURSE SUBJECT REQUIREMENTS
-- =========================================================

-- Diploma in IT
INSERT INTO CareerPath.CourseSubjects
    (CourseId, SubjectId, MinimumMark)
VALUES
(1, 1, 50), -- Mathematics
(1, 2, 60), -- Mathematical Literacy
(1, 8, 50), -- English
(1, 10, 50); -- IT
GO

-- Bachelor of Computer Science
INSERT INTO CareerPath.CourseSubjects
    (CourseId, SubjectId, MinimumMark)
VALUES
(2, 1, 60), -- Mathematics
(2, 3, 50), -- Physical Sciences
(2, 8, 50);
GO

-- Bachelor of Accounting
INSERT INTO CareerPath.CourseSubjects
    (CourseId, SubjectId, MinimumMark)
VALUES
(3, 1, 60), -- Mathematics
(3, 5, 60), -- Accounting
(3, 8, 50);
GO

-- Bachelor of Business Administration
INSERT INTO CareerPath.CourseSubjects
    (CourseId, SubjectId, MinimumMark)
VALUES
(4, 1, 50), -- Mathematics
(4, 2, 60), -- Mathematical Literacy
(4, 6, 60), -- Business Studies
(4, 8, 50);
GO

-- Diploma in Software Development
INSERT INTO CareerPath.CourseSubjects
    (CourseId, SubjectId, MinimumMark)
VALUES
(5, 1, 50), -- Mathematics
(5, 2, 60), -- Mathematical Literacy
(5, 8, 50);
GO


-- =========================================================
-- USER SUBJECTS / MARKS
-- =========================================================

-- Lerato
INSERT INTO CareerPath.UserSubjects
    (UserId, SubjectId, Mark, APSPoints)
VALUES
(1, 1, 72, 7),
(1, 2, 75, 7),
(1, 6, 68, 6),
(1, 8, 78, 7),
(1, 10, 80, 7);

-- Sipho
INSERT INTO CareerPath.UserSubjects
    (UserId, SubjectId, Mark, APSPoints)
VALUES
(2, 1, 65, 6),
(2, 3, 61, 6),
(2, 8, 70, 6),
(2, 10, 74, 6);

-- Amahle
INSERT INTO CareerPath.UserSubjects
    (UserId, SubjectId, Mark, APSPoints)
VALUES
(3, 1, 58, 5),
(3, 5, 75, 7),
(3, 6, 72, 7),
(3, 8, 68, 6);

-- Thando
INSERT INTO CareerPath.UserSubjects
    (UserId, SubjectId, Mark, APSPoints)
VALUES
(4, 2, 82, 8),
(4, 6, 77, 7),
(4, 8, 73, 6),
(4, 10, 65, 6);

-- Zanele
INSERT INTO CareerPath.UserSubjects
    (UserId, SubjectId, Mark, APSPoints)
VALUES
(5, 1, 68, 6),
(5, 3, 70, 7),
(5, 8, 75, 7),
(5, 10, 82, 7);

-- Lungelo
INSERT INTO CareerPath.UserSubjects
    (UserId, SubjectId, Mark, APSPoints)
VALUES
(6, 1, 76, 7),
(6, 5, 69, 6),
(6, 8, 81, 7),
(6, 10, 78, 7);
GO


-- =========================================================
-- APPLICATIONS
-- =========================================================

INSERT INTO CareerPath.Applications
    (UserId, CourseId, ApplicationDate, Status, Notes)
VALUES
(1, 1, '2026-09-10', 'Submitted',
    'Interested in software development and databases.'),

(2, 2, '2026-09-11', 'Under Review',
    'Application currently being reviewed.'),

(3, 3, '2026-09-12', 'Accepted',
    'Applicant meets the course requirements.'),

(4, 4, '2026-09-13', 'Submitted',
    'Interested in business management.'),

(5, 5, '2026-09-14', 'Under Review',
    'Application documents are being reviewed.'),

(6, 1, '2026-09-15', 'Rejected',
    'Minimum course requirements were not met.');
GO


-- =========================================================
-- APPLICATION DOCUMENTS
-- =========================================================

INSERT INTO CareerPath.ApplicationDocuments
    (ApplicationId, FileName, FileType, FileSize, FilePath)
VALUES
(1, 'Lerato_ID.pdf', 'PDF', 245760, 'uploads/Lerato_ID.pdf'),
(2, 'Sipho_Matric.pdf', 'PDF', 314572, 'uploads/Sipho_Matric.pdf'),
(3, 'Amahle_Results.pdf', 'PDF', 198456, 'uploads/Amahle_Results.pdf'),
(4, 'Thando_ID.pdf', 'PDF', 256789, 'uploads/Thando_ID.pdf'),
(5, 'Zanele_CV.pdf', 'PDF', 287654, 'uploads/Zanele_CV.pdf'),
(6, 'Lungelo_Results.pdf', 'PDF', 301245, 'uploads/Lungelo_Results.pdf');
GO


-- =========================================================
-- 16. VERIFY DATA
-- =========================================================

SELECT * FROM CareerPath.Users;
SELECT * FROM CareerPath.Subjects;
SELECT * FROM CareerPath.Courses;
SELECT * FROM CareerPath.Careers;
SELECT * FROM CareerPath.Bursaries;
SELECT * FROM CareerPath.Jobs;
SELECT * FROM CareerPath.CourseSubjects;
SELECT * FROM CareerPath.UserSubjects;
SELECT * FROM CareerPath.Applications;
SELECT * FROM CareerPath.ApplicationDocuments;
GO

PRINT 'CareerPath dummy data inserted successfully.';
GO

-- CHANGING USER TYPES
USE CareerPathDB;
GO

UPDATE CareerPath.Users
SET UserType = 'Learner (High School)'
WHERE UserType = 'Learner';

UPDATE CareerPath.Users
SET UserType = 'Student (Tertiary)'
WHERE UserType = 'Student';
GO

ALTER TABLE CareerPath.Users
DROP CONSTRAINT CK_Users_UserType;
GO

ALTER TABLE CareerPath.Users
ADD CONSTRAINT CK_Users_UserType
CHECK (
    UserType = 'Learner (High School)'
    OR UserType = 'Student (Tertiary)'
    OR UserType = 'Graduate'
);
GO
