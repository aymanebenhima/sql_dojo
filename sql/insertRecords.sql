-- ===========================================================================
-- JEU DE DONNÉES DE TEST COMPATIBLE MARIADB / PHPMYADMIN / HEIDISQL
-- ===========================================================================

-- Désactivation des clés étrangères le temps de l'insertion pour éviter les blocages d'ordre
SET FOREIGN_KEY_CHECKS = 0;

-- Vidage préalable des tables pour éviter les doublons en cas de ré-exécution
TRUNCATE TABLE student_answers;
TRUNCATE TABLE student_quiz_results;
TRUNCATE TABLE answers;
TRUNCATE TABLE questions;
TRUNCATE TABLE quizzes;
TRUNCATE TABLE courses;
TRUNCATE TABLE student_profiles;
TRUNCATE TABLE mentor_profiles;
TRUNCATE TABLE campus_assignments;
TRUNCATE TABLE school_assignments;
TRUNCATE TABLE user_roles;
TRUNCATE TABLE users;
TRUNCATE TABLE grade_levels;
TRUNCATE TABLE academic_years;
TRUNCATE TABLE campuses;
TRUNCATE TABLE schools;

SET FOREIGN_KEY_CHECKS = 1;

-- ---------------------------------------------------------------------------
-- 1. CONFIGURATIONS DE BASE & STRUCTURES (Schools, Campuses, Years, Grades)
-- ---------------------------------------------------------------------------

INSERT INTO schools (id_school, name, creation_date) VALUES
(1, 'Nexus Institute of Technology', '2020-09-01'),
(2, 'Apex Business School', '2022-01-15');

INSERT INTO campuses (id_campus, id_school, name, address, city) VALUES
(1, 1, 'Nexus Paris Center', '12 Rue de l Innovation', 'Paris'),
(2, 1, 'Nexus Lyon Tech', '45 Avenue du Digital', 'Lyon'),
(3, 2, 'Apex Casablanca Finance', 'Anfa Place, Bd de la Corniche', 'Casablanca'),
(4, 2, 'Apex Marrakech Management', 'Avenue Mohammed VI', 'Marrakech');

INSERT INTO academic_years (id_year, label, start_date, end_date, is_current) VALUES
(1, '2025-2026', '2025-09-01', '2026-06-30', 1),
(2, '2026-2027', '2026-09-01', '2027-06-30', 0);

INSERT INTO grade_levels (id_grade, label, description) VALUES
(1, 'Bachelor 1', 'Première année de cycle Bachelor'),
(2, 'Bachelor 3', 'Troisième année et diplomation Bachelor'),
(3, 'Master 1', 'Première année de cycle Master'),
(4, 'Master 2', 'Année finale et diplomation Master');

-- ---------------------------------------------------------------------------
-- 2. INSERTION DE 44 UTILISATEURS (Générique 'users' table)
-- ---------------------------------------------------------------------------
-- Note : Le mot de passe haché fourni en exemple correspond visuellement à un hash bcrypt standard.

INSERT INTO users (id_user, first_name, last_name, email, password_hash, is_active) VALUES
-- Admins (2)
(1, 'Guillaume', 'Mercier', 'admin.mercier@nexus.edu', '$2y$10$e0myL.HO10bF323Jb2fH3O', 1),
(2, 'Sofia', 'Alami', 'admin.alami@apex.edu', '$2y$10$e0myL.HO10bF323Jb2fH3O', 1),
-- School Managers (2)
(3, 'Charles', 'Dubois', 'c.dubois@nexus.edu', '$2y$10$e0myL.HO10bF323Jb2fH3O', 1),
(4, 'Youssef', 'Naciri', 'y.naciri@apex.edu', '$2y$10$e0myL.HO10bF323Jb2fH3O', 1),
-- Campus Managers (4)
(5, 'Alice', 'Vautrin', 'a.vautrin@paris.nexus.edu', '$2y$10$e0myL.HO10bF323Jb2fH3O', 1),
(6, 'Marc', 'Morel', 'm.morel@lyon.nexus.edu', '$2y$10$e0myL.HO10bF323Jb2fH3O', 1),
(7, 'Amine', 'Benjelloun', 'a.benjelloun@casa.apex.edu', '$2y$10$e0myL.HO10bF323Jb2fH3O', 1),
(8, 'Layla', 'Tazi', 'l.tazi@kech.apex.edu', '$2y$10$e0myL.HO10bF323Jb2fH3O', 1),
-- Staff Administratif (4)
(9, 'Julien', 'Rousseau', 'j.rousseau@staff.nexus.edu', '$2y$10$e0myL.HO10bF323Jb2fH3O', 1),
(10, 'Emma', 'Petit', 'emma.p@staff.nexus.edu', '$2y$10$e0myL.HO10bF323Jb2fH3O', 1),
(11, 'Khadija', 'Idrissi', 'k.idrissi@staff.apex.edu', '$2y$10$e0myL.HO10bF323Jb2fH3O', 1),
(12, 'Omar', 'S组织', 'o.sadik@staff.apex.edu', '$2y$10$e0myL.HO10bF323Jb2fH3O', 1),
-- Mentors / Enseignants (6)
(13, 'Thomas', 'Pesquet', 't.pesquet@professor.edu', '$2y$10$e0myL.HO10bF323Jb2fH3O', 1),
(14, 'Sarah', 'Connor', 's.connor@professor.edu', '$2y$10$e0myL.HO10bF323Jb2fH3O', 1),
(15, 'Alan', 'Turing', 'a.turing@professor.edu', '$2y$10$e0myL.HO10bF323Jb2fH3O', 1),
(16, 'Nadia', 'Mansouri', 'n.mansouri@professor.edu', '$2y$10$e0myL.HO10bF323Jb2fH3O', 1),
(17, 'Tariq', 'Ramdan', 't.ramdan@professor.edu', '$2y$10$e0myL.HO10bF323Jb2fH3O', 1),
(18, 'Grace', 'Hopper', 'g.hopper@professor.edu', '$2y$10$e0myL.HO10bF323Jb2fH3O', 1),
-- Étudiants (26) -> ID 19 à 44
(19, 'Lucas', 'Bernard', 'lucas.b@student.edu', '$2y$10$e0myL.HO10bF323Jb2fH3O', 1),
(20, 'Chloé', 'Richard', 'chloe.r@student.edu', '$2y$10$e0myL.HO10bF323Jb2fH3O', 1),
(21, 'Hugo', 'Durand', 'hugo.d@student.edu', '$2y$10$e0myL.HO10bF323Jb2fH3O', 1),
(22, 'Inès', 'Lefebvre', 'ines.l@student.edu', '$2y$10$e0myL.HO10bF323Jb2fH3O', 1),
(23, 'Maxime', 'Moreau', 'max.m@student.edu', '$2y$10$e0myL.HO10bF323Jb2fH3O', 1),
(24, 'Camille', 'Fournier', 'cam.f@student.edu', '$2y$10$e0myL.HO10bF323Jb2fH3O', 1),
(25, 'Zineb', 'Chraibi', 'z.chraibi@student.edu', '$2y$10$e0myL.HO10bF323Jb2fH3O', 1),
(26, 'Anas', 'ElAmrani', 'a.elamrani@student.edu', '$2y$10$e0myL.HO10bF323Jb2fH3O', 1),
(27, 'Mehdi', 'Toumi', 'm.toumi@student.edu', '$2y$10$e0myL.HO10bF323Jb2fH3O', 1),
(28, 'Yasmine', 'Berrada', 'y.berrada@student.edu', '$2y$10$e0myL.HO10bF323Jb2fH3O', 1),
(29, 'Arthur', 'Simon', 'a.simon@student.edu', '$2y$10$e0myL.HO10bF323Jb2fH3O', 1),
(30, 'Léa', 'Laurent', 'lea.l@student.edu', '$2y$10$e0myL.HO10bF323Jb2fH3O', 1),
(31, 'Antoine', 'Michel', 'a.michel@student.edu', '$2y$10$e0myL.HO10bF323Jb2fH3O', 1),
(32, 'Manon', 'Garcia', 'manon.g@student.edu', '$2y$10$e0myL.HO10bF323Jb2fH3O', 1),
(33, 'Sami', 'Jaouhari', 's.jaouhari@student.edu', '$2y$10$e0myL.HO10bF323Jb2fH3O', 1),
(34, 'Walid', 'Filali', 'w.filali@student.edu', '$2y$10$e0myL.HO10bF323Jb2fH3O', 1),
(35, 'Sara', 'Moutawakil', 's.mou@student.edu', '$2y$10$e0myL.HO10bF323Jb2fH3O', 1),
(36, 'Gabin', 'Roux', 'g.roux@student.edu', '$2y$10$e0myL.HO10bF323Jb2fH3O', 1),
(37, 'Jade', 'Vincent', 'j.vincent@student.edu', '$2y$10$e0myL.HO10bF323Jb2fH3O', 1),
(38, 'Paul', 'Fontaine', 'p.fontaine@student.edu', '$2y$10$e0myL.HO10bF323Jb2fH3O', 1),
(39, 'Lina', 'Bennis', 'l.bennis@student.edu', '$2y$10$e0myL.HO10bF323Jb2fH3O', 1),
(40, 'Adnane', 'Kabbaj', 'a.kabbaj@student.edu', '$2y$10$e0myL.HO10bF323Jb2fH3O', 1),
(41, 'Zoe', 'Boye', 'z.boye@student.edu', '$2y$10$e0myL.HO10bF323Jb2fH3O', 1),
(42, 'Louis', 'Masson', 'l.masson@student.edu', '$2y$10$e0myL.HO10bF323Jb2fH3O', 1),
(43, 'Clara', 'Francois', 'c.francois@student.edu', '$2y$10$e0myL.HO10bF323Jb2fH3O', 1),
(44, 'Amine', 'Saber', 'a.saber@student.edu', '$2y$10$e0myL.HO10bF323Jb2fH3O', 1);

-- ---------------------------------------------------------------------------
-- 3. ATTRIBUTION DES RÔLES (Table user_roles)
-- ---------------------------------------------------------------------------
INSERT INTO user_roles (id_user, id_role) VALUES
(1, 1), (2, 1),   -- Admins
(3, 2), (4, 2),   -- School Managers
(5, 3), (6, 3), (7, 3), (8, 3), -- Campus Managers
(9, 4), (10, 4), (11, 4), (12, 4), -- Staff
(13, 5), (14, 5), (15, 5), (16, 5), (17, 5), (18, 5); -- Mentors

-- Assignation auto des rôles étudiants (ID 19 à 44 en rôle '6')
INSERT INTO user_roles (id_user, id_role)
SELECT id_user, 6 FROM users WHERE id_user >= 19;

-- ---------------------------------------------------------------------------
-- 4. PERIMETRES ET AFFECTATIONS (School & Campus Assignments)
-- ---------------------------------------------------------------------------
-- School Managers
INSERT INTO school_assignments (id_user, id_school) VALUES (3, 1), (4, 2);

-- Campus Managers et Staff affectés à leur campus respectif
INSERT INTO campus_assignments (id_user, id_campus) VALUES
(5, 1), (9, 1),   -- Campus 1 (Paris)
(6, 2), (10, 2),  -- Campus 2 (Lyon)
(7, 3), (11, 3),  -- Campus 3 (Casa)
(8, 4), (12, 4);  -- Campus 4 (Kech)

-- ---------------------------------------------------------------------------
-- 5. PROFILS SPECIALISES (Mentors & Students Profiles)
-- ---------------------------------------------------------------------------
-- Profils Mentors
INSERT INTO mentor_profiles (id_user, specialty, bio, skills) VALUES
(13, 'Astrophysique & Python', 'Ancien ingénieur spatial passionné de code.', 'Python, Algorithmique, Data Science'),
(14, 'Cybersécurité', 'Experte en tests d intrusion et défense système.', 'Linux, Wireshark, Ethical Hacking'),
(15, 'Intelligence Artificielle', 'Chercheur en algorithmie avancée.', 'Machine Learning, Deep Learning, SQL'),
(16, 'Finance de Marché', 'Analyste senior pour les marchés internationaux.', 'Gestion des risques, Trading, Excel'),
(17, 'Management & Stratégie', 'Consultant auprès des grandes entreprises.', 'RH, Négociation, Agilité'),
(18, 'Génie Logiciel', 'Pionnière de la compilation moderne.', 'Java, C++, Architecture Logicielle');

-- Profils Étudiants (Répartition équilibrée sur les campus, grades et années)
INSERT INTO student_profiles (id_user, id_campus, id_grade, id_year, student_number, enrollment_date) VALUES
(19, 1, 1, 1, 'STU-2025-001', '2025-09-02'),
(20, 1, 1, 1, 'STU-2025-002', '2025-09-02'),
(21, 1, 2, 1, 'STU-2025-003', '2025-09-03'),
(22, 1, 3, 1, 'STU-2025-004', '2025-09-05'),
(23, 1, 4, 1, 'STU-2025-005', '2025-09-05'),
-- Campus 2 (Lyon)
(24, 2, 1, 1, 'STU-2025-006', '2025-09-02'),
(25, 2, 2, 1, 'STU-2025-007', '2025-09-02'),
(26, 2, 2, 1, 'STU-2025-008', '2025-09-02'),
(27, 2, 3, 1, 'STU-2025-009', '2025-09-04'),
(28, 2, 4, 1, 'STU-2025-010', '2025-09-04'),
-- Campus 3 (Casa)
(29, 3, 1, 1, 'STU-2025-011', '2025-09-01'),
(30, 3, 1, 1, 'STU-2025-012', '2025-09-01'),
(31, 3, 2, 1, 'STU-2025-013', '2025-09-02'),
(32, 3, 3, 1, 'STU-2025-014', '2025-09-03'),
(33, 3, 4, 1, 'STU-2025-015', '2025-09-03'),
(34, 3, 4, 1, 'STU-2025-016', '2025-09-03'),
-- Campus 4 (Marrakech)
(35, 4, 1, 1, 'STU-2025-017', '2025-09-02'),
(36, 4, 2, 1, 'STU-2025-018', '2025-09-02'),
(37, 4, 2, 1, 'STU-2025-019', '2025-09-02'),
(38, 4, 3, 1, 'STU-2025-020', '2025-09-05'),
(39, 4, 3, 1, 'STU-2025-021', '2025-09-05'),
(40, 4, 4, 1, 'STU-2025-022', '2025-09-06'),
-- Reste des étudiants
(41, 1, 2, 1, 'STU-2025-023', '2025-09-02'),
(42, 2, 3, 1, 'STU-2025-024', '2025-09-02'),
(43, 3, 1, 1, 'STU-2025-025', '2025-09-02'),
(44, 4, 4, 1, 'STU-2025-026', '2025-09-02');

-- ---------------------------------------------------------------------------
-- 6. CONTENU PEDAGOGIQUE (Courses, Quizzes, Questions, Answers)
-- ---------------------------------------------------------------------------
-- Cours reliés à un Grade et à un Mentor
INSERT INTO courses (id_course, id_grade, id_mentor, title, description) VALUES
(1, 1, 15, 'Introduction aux Bases de Données', 'Apprentissage du modèle relationnel et de SQL.'),
(2, 3, 13, 'Programmation Python Avancée', 'Structures de données complexes et automatisation.'),
(3, 4, 14, 'Sécurité des Architectures Web', 'Principes OWASP, cryptographie et protection applicative.'),
(4, 2, 16, 'Analyse Financière et Budgétaire', 'Lecture des bilans de santé financière de l entreprise.');

-- Quiz associés aux cours
INSERT INTO quizzes (id_quiz, id_course, title, duration_minutes, passing_score) VALUES
(1, 1, 'Quiz 1 : Les requêtes SELECT & Jointures', 20, 60.00),
(2, 3, 'Quiz Final : Sécurité Applicative', 40, 70.00);

-- Questions pour le Quiz 1 (SQL)
INSERT INTO questions (id_question, id_quiz, question_text, points) VALUES
(1, 1, 'Que signifie l acronyme SQL ?', 2),
(2, 1, 'Quelle clause permet de filtrer les résultats d un groupe ?', 3);

-- Réponses pour la Question 1
INSERT INTO answers (id_answer, id_question, answer_text, is_correct) VALUES
(1, 1, 'Structured Query Language', 1),
(2, 1, 'Simple Query List', 0),
(3, 1, 'Sequential Query Language', 0);

-- Réponses pour la Question 2
INSERT INTO answers (id_answer, id_question, answer_text, is_correct) VALUES
(4, 2, 'WHERE', 0),
(5, 2, 'HAVING', 1),
(6, 2, 'GROUP BY', 0);

-- ---------------------------------------------------------------------------
-- 7. SIMULATION DE RÉSULTATS (Student Quiz Results & Answers)
-- ---------------------------------------------------------------------------
-- On simule que quelques étudiants de Bachelor 1 (Grade 1) ont passé le Quiz SQL (Quiz 1)
INSERT INTO student_quiz_results (id_user, id_quiz, score_obtained, total_possible_score, attempt_date) VALUES
(19, 1, 5.00, 5, '2025-10-12 14:22:00'), -- Score max (A réussi !)
(20, 1, 2.00, 5, '2025-10-12 14:35:12'), -- Échec
(24, 1, 5.00, 5, '2025-10-13 09:11:04'), -- Score max
(29, 1, 3.00, 5, '2025-10-14 16:45:00'), -- Juste à la limite
(30, 1, 0.00, 5, '2025-10-14 17:00:22'); -- Zéro pointé

-- Simulation de l audit détaillé pour l étudiant ID 19 (Lucas) qui a eu tout bon
INSERT INTO student_answers (id_user, id_quiz, id_question, id_answer, submitted_at) VALUES
(19, 1, 1, 1, '2025-10-12 14:20:00'), -- Réponse exacte à la Q1
(19, 1, 2, 5, '2025-10-12 14:22:00'); -- Réponse exacte à la Q2