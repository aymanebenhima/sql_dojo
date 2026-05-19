-- ===========================================================================
-- SYSTEME DE GESTION EDUCATIVE MULTI-CAMPUS (Version MariaDB / MySQL)
-- Optimisé pour phpMyAdmin & HeidiSQL
-- ===========================================================================

CREATE DATABASE IF NOT EXISTS multi_campus_db
    DEFAULT CHARACTER SET utf8mb4
    COLLATE utf8mb4_unicode_ci;
USE multi_campus_db;

-- Désactivation des vérifications des clés étrangères pour éviter les conflits au DROP
SET FOREIGN_KEY_CHECKS = 0;

-- ---------------------------------------------------------------------------
-- 1. SUPPRESSION DES TABLES EXISTANTES (Pour réinitialisation propre)
-- ---------------------------------------------------------------------------
DROP TABLE IF EXISTS student_quiz_results;
DROP TABLE IF EXISTS student_answers;
DROP TABLE IF EXISTS answers;
DROP TABLE IF EXISTS questions;
DROP TABLE IF EXISTS quizzes;
DROP TABLE IF EXISTS courses;
DROP TABLE IF EXISTS student_profiles;
DROP TABLE IF EXISTS mentor_profiles;
DROP TABLE IF EXISTS campus_assignments;
DROP TABLE IF EXISTS school_assignments;
DROP TABLE IF EXISTS user_roles;
DROP TABLE IF EXISTS roles;
DROP TABLE IF EXISTS users;
DROP TABLE IF EXISTS grade_levels;
DROP TABLE IF EXISTS academic_years;
DROP TABLE IF EXISTS campuses;
DROP TABLE IF EXISTS schools;

-- Réactivation temporaire pour la création des tables
SET FOREIGN_KEY_CHECKS = 1;

-- ---------------------------------------------------------------------------
-- 2. STRUCTURE ORGANISATIONNELLE & ACADEMIQUE
-- ---------------------------------------------------------------------------

CREATE TABLE schools (
    id_school INT NOT NULL AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    creation_date DATE DEFAULT (CURRENT_DATE),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id_school)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE campuses (
    id_campus INT NOT NULL AUTO_INCREMENT,
    id_school INT NOT NULL,
    name VARCHAR(100) NOT NULL,
    address VARCHAR(255),
    city VARCHAR(100),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id_campus),
    CONSTRAINT fk_campus_school FOREIGN KEY (id_school) REFERENCES schools(id_school) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE academic_years (
    id_year INT NOT NULL AUTO_INCREMENT,
    label VARCHAR(20) NOT NULL UNIQUE, -- Ex: "2025-2026"
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    is_current BOOLEAN DEFAULT FALSE,
    PRIMARY KEY (id_year)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE grade_levels (
    id_grade INT NOT NULL AUTO_INCREMENT,
    label VARCHAR(50) NOT NULL UNIQUE, -- Ex: "Bachelor 1"
    description TEXT,
    PRIMARY KEY (id_grade)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ---------------------------------------------------------------------------
-- 3. GESTION DES UTILISATEURS ET DU CONTROLE D'ACCES (RBAC)
-- ---------------------------------------------------------------------------

CREATE TABLE users (
    id_user INT NOT NULL AUTO_INCREMENT,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    password_hash VARCHAR(255) NOT NULL,
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (id_user)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE roles (
    id_role INT NOT NULL AUTO_INCREMENT,
    role_name VARCHAR(50) NOT NULL UNIQUE, -- ADMIN, STAFF, MENTOR, STUDENT...
    PRIMARY KEY (id_role)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE user_roles (
    id_user INT NOT NULL,
    id_role INT NOT NULL,
    assigned_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id_user, id_role),
    CONSTRAINT fk_user_roles_user FOREIGN KEY (id_user) REFERENCES users(id_user) ON DELETE CASCADE,
    CONSTRAINT fk_user_roles_role FOREIGN KEY (id_role) REFERENCES roles(id_role) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ---------------------------------------------------------------------------
-- 4. PERIMETRES DE GESTION (ASSIGNATIONS DES MANAGERS & STAFF)
-- ---------------------------------------------------------------------------

CREATE TABLE school_assignments (
    id_user INT NOT NULL,
    id_school INT NOT NULL,
    assigned_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id_user, id_school),
    CONSTRAINT fk_school_assign_user FOREIGN KEY (id_user) REFERENCES users(id_user) ON DELETE CASCADE,
    CONSTRAINT fk_school_assign_school FOREIGN KEY (id_school) REFERENCES schools(id_school) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE campus_assignments (
    id_user INT NOT NULL,
    id_campus INT NOT NULL,
    assigned_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id_user, id_campus),
    CONSTRAINT fk_campus_assign_user FOREIGN KEY (id_user) REFERENCES users(id_user) ON DELETE CASCADE,
    CONSTRAINT fk_campus_assign_campus FOREIGN KEY (id_campus) REFERENCES campuses(id_campus) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ---------------------------------------------------------------------------
-- 5. PROFILS SPECIFIQUES (HERITAGE / EXTENSION DE LA TABLE USERS)
-- ---------------------------------------------------------------------------

CREATE TABLE mentor_profiles (
    id_user INT NOT NULL,
    specialty VARCHAR(100) NOT NULL, 
    bio TEXT,
    skills TEXT,
    PRIMARY KEY (id_user),
    CONSTRAINT fk_mentor_profile_user FOREIGN KEY (id_user) REFERENCES users(id_user) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE student_profiles (
    id_user INT NOT NULL,
    id_campus INT NOT NULL,
    id_grade INT NOT NULL,
    id_year INT NOT NULL,
    student_number VARCHAR(50) NOT NULL UNIQUE,
    enrollment_date DATE DEFAULT (CURRENT_DATE),
    PRIMARY KEY (id_user),
    CONSTRAINT fk_student_profile_user FOREIGN KEY (id_user) REFERENCES users(id_user) ON DELETE CASCADE,
    CONSTRAINT fk_student_profile_campus FOREIGN KEY (id_campus) REFERENCES campuses(id_campus) ON DELETE RESTRICT,
    CONSTRAINT fk_student_profile_grade FOREIGN KEY (id_grade) REFERENCES grade_levels(id_grade) ON DELETE RESTRICT,
    CONSTRAINT fk_student_profile_year FOREIGN KEY (id_year) REFERENCES academic_years(id_year) ON DELETE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ---------------------------------------------------------------------------
-- 6. CONTENU PEDAGOGIQUE
-- ---------------------------------------------------------------------------

CREATE TABLE courses (
    id_course INT NOT NULL AUTO_INCREMENT,
    id_grade INT NOT NULL,               
    id_mentor INT,                       
    title VARCHAR(150) NOT NULL,
    description TEXT,
    syllabus TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id_course),
    CONSTRAINT fk_course_grade FOREIGN KEY (id_grade) REFERENCES grade_levels(id_grade) ON DELETE RESTRICT,
    CONSTRAINT fk_course_mentor FOREIGN KEY (id_mentor) REFERENCES mentor_profiles(id_user) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ---------------------------------------------------------------------------
-- 7. SYSTEME D'EVALUATION (QUIZ, QUESTIONS, REPONSES)
-- ---------------------------------------------------------------------------

CREATE TABLE quizzes (
    id_quiz INT NOT NULL AUTO_INCREMENT,
    id_course INT NOT NULL,
    title VARCHAR(150) NOT NULL,
    description TEXT,
    duration_minutes INT,                
    passing_score NUMERIC(5,2) DEFAULT 50.00, 
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id_quiz),
    CONSTRAINT fk_quiz_course FOREIGN KEY (id_course) REFERENCES courses(id_course) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE questions (
    id_question INT NOT NULL AUTO_INCREMENT,
    id_quiz INT NOT NULL,
    question_text TEXT NOT NULL,
    points INT DEFAULT 1,                
    PRIMARY KEY (id_question),
    CONSTRAINT fk_question_quiz FOREIGN KEY (id_quiz) REFERENCES quizzes(id_quiz) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE answers (
    id_answer INT NOT NULL AUTO_INCREMENT,
    id_question INT NOT NULL,
    answer_text TEXT NOT NULL,
    is_correct BOOLEAN DEFAULT FALSE,    
    PRIMARY KEY (id_answer),
    CONSTRAINT fk_answer_question FOREIGN KEY (id_question) REFERENCES questions(id_question) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ---------------------------------------------------------------------------
-- 8. TRACABILITE, RESULTATS ET EVALUATIONS DES ETUDIANTS
-- ---------------------------------------------------------------------------

CREATE TABLE student_quiz_results (
    id_result INT NOT NULL AUTO_INCREMENT,
    id_user INT NOT NULL,                
    id_quiz INT NOT NULL,
    score_obtained NUMERIC(5,2) NOT NULL, 
    total_possible_score INT NOT NULL,   
    attempt_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id_result),
    CONSTRAINT fk_result_student FOREIGN KEY (id_user) REFERENCES student_profiles(id_user) ON DELETE CASCADE,
    CONSTRAINT fk_result_quiz FOREIGN KEY (id_quiz) REFERENCES quizzes(id_quiz) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE student_answers (
    id_user INT NOT NULL,
    id_quiz INT NOT NULL,
    id_question INT NOT NULL,
    id_answer INT NOT NULL,
    submitted_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id_user, id_quiz, id_question, id_answer),
    CONSTRAINT fk_sa_student FOREIGN KEY (id_user) REFERENCES student_profiles(id_user) ON DELETE CASCADE,
    CONSTRAINT fk_sa_quiz FOREIGN KEY (id_quiz) REFERENCES quizzes(id_quiz) ON DELETE CASCADE,
    CONSTRAINT fk_sa_question FOREIGN KEY (id_question) REFERENCES questions(id_question) ON DELETE CASCADE,
    CONSTRAINT fk_sa_answer FOREIGN KEY (id_answer) REFERENCES answers(id_answer) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ---------------------------------------------------------------------------
-- 9. CRÉATION D'INDEX POUR LES PERFORMANCES (Jointures rapides dans HeidiSQL/phpMyAdmin)
-- ---------------------------------------------------------------------------
CREATE INDEX idx_users_email ON users(email);
CREATE INDEX idx_student_profiles_campus ON student_profiles(id_campus);
CREATE INDEX idx_student_profiles_grade ON student_profiles(id_grade);
CREATE INDEX idx_courses_grade ON courses(id_grade);
CREATE INDEX idx_quizzes_course ON quizzes(id_course);
CREATE INDEX idx_questions_quiz ON questions(id_quiz);
CREATE INDEX idx_answers_question ON answers(id_question);