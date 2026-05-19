# SQL Dojo

## Configuration du dépôt

Ce dépôt contient un ensemble de scripts SQL pour créer une base de données éducative multi-campus et ses tables associées.

### Prérequis

- MariaDB ou MySQL installé
- Un client SQL comme phpMyAdmin, HeidiSQL, MySQL Workbench, ou la ligne de commande MySQL

### Installation et configuration

1. Cloner le dépôt

   ```bash
   git clone <url-du-repo>
   cd sql_dojo
   ```

2. Ouvrir le fichier SQL principal

   - Le script principal se trouve dans `sql/createDbAndTables.sql`

3. Exécuter le script de création

   - Depuis un client SQL, exécuter `sql/createDbAndTables.sql`
   - Le script crée la base de données `multi_campus_db` si elle n’existe pas, puis crée les tables nécessaires

4. (Optionnel) Insérer des données

   - Si vous souhaitez remplir des valeurs d’exemple, exécuter `sql/insertRecords.sql`

5. Vérifier la base de données

   - Connectez-vous à MySQL/MariaDB et assurez-vous que la base `multi_campus_db` existe
   - Vérifiez les tables créées : `schools`, `campuses`, `users`, `courses`, `quizzes`, etc.

## Utilisation

- Lancer le script depuis votre client SQL favori
- Assurez-vous d’avoir les droits nécessaires pour créer une base de données et des tables
- Si vous utilisez phpMyAdmin ou HeidiSQL, sélectionnez l’option pour importer le fichier SQL

---

## Niveau : Débutant (Beginner)

### Exercice 1 : Liste de base

* **Description :** Récupérer les noms, prénoms et emails de tous les utilisateurs de la base, triés par nom de famille par ordre alphabétique.
* **Hint :** Utilisez une requête `SELECT` simple avec la clause `ORDER BY`.
* **Expected Output :**

| first_name | last_name | email |
| :--- | :--- | :--- |
| Sofia | Alami | admin.alami@apex.edu |
| Lucas | Bernard | lucas.b@student.edu |
| Amine | Benjelloun | a.benjelloun@casa.apex.edu |

### Exercice 2 : Filtrer les rôles

* **Description :** Afficher tous les rôles uniques disponibles dans le système.
* **Hint :** Regardez du côté de la table `roles` et sélectionnez simplement les lignes.
* **Expected Output :**

| role_name |
| :--- |
| ADMIN |
| SCHOOL_MANAGER |
| CAMPUS_MANAGER |
| STAFF |
| MENTOR |
| STUDENT |

### Exercice 3 : Étudiants actifs uniquement

* **Description :** Sélectionner l'identifiant et l'adresse email de tous les utilisateurs qui sont marqués comme actifs (`is_active = TRUE`).
* **Hint :** Utilisez la clause `WHERE` pour tester l'état du booléen.
* **Expected Output :**

| id_user | email |
| :--- | :--- |
| 1 | admin.mercier@nexus.edu |
| 2 | admin.alami@apex.edu |
| 3 | c.dubois@nexus.edu |

### Exercice 4 : Détails des campus

* **Description :** Lister tous les campus enregistrés avec leur adresse et leur ville.
* **Hint :** Interrogez directement la table `campuses`.
* **Expected Output :**

| name | address | city |
| :--- | :--- | :--- |
| Nexus Paris Center | 12 Rue de l Innovation | Paris |
| Nexus Lyon Tech | 45 Avenue du Digital | Lyon |
| Apex Casablanca Finance | Anfa Place, Bd de la Corniche | Casablanca |
| Apex Marrakech Management | Avenue Mohammed VI | Marrakech |

### Exercice 5 : Recherche ciblée

* **Description :** Trouver tous les utilisateurs dont le nom de famille commence par la lettre 'M'.
* **Hint :** Utilisez l'opérateur `LIKE` avec le joker `%`.
* **Expected Output :**

| first_name | last_name | email |
| :--- | :--- | :--- |
| Guillaume | Mercier | admin.mercier@nexus.edu |
| Marc | Morel | m.morel@lyon.nexus.edu |
| Nadia | Mansouri | n.mansouri@professor.edu |
| Antoine | Michel | a.michel@student.edu |

### Exercice 6 : Les niveaux d'études

* **Description :** Afficher les libellés de tous les niveaux d'études (`grade_levels`) triés du plus petit identifiant au plus grand.
* **Hint :** Sélectionnez `label` depuis la table concernée avec un tri par `id_grade`.
* **Expected Output :**

| label |
| :--- |
| Bachelor 1 |
| Bachelor 2 |
| Bachelor 3 |
| Master 1 |
| Master 2 |

### Exercice 7 : Compter les écoles

* **Description :** Trouver le nombre total d'écoles enregistrées dans le système.
* **Hint :** Utilisez la fonction d'agrégation `COUNT()`.
* **Expected Output :**

| total_schools |
| :--- |
| 2 |

### Exercice 8 : Année académique en cours

* **Description :** Récupérer l'année académique qui est définie comme l'année courante (`is_current = 1`).
* **Hint :** Filtrez la table `academic_years` avec une condition dans le `WHERE`.
* **Expected Output :**

| id_year | label | start_date | end_date | is_current |
| :--- | :--- | :--- | :--- | :--- |
| 1 | 2025-2026 | 2025-09-01 | 2026-06-30 | 1 |

### Exercice 9 : Quiz express

* **Description :** Lister les titres de tous les quiz qui durent strictement moins de 30 minutes.
* **Hint :** Utilisez l'opérateur de comparaison `<` sur le champ `duration_minutes`.
* **Expected Output :**

| title | duration_minutes |
| :--- | :--- |
| Quiz 1 : Les requêtes SELECT & Jointures | 20 |

### Exercice 10 : Coordonnées des écoles

* **Description :** Afficher les noms des écoles créées après le 1er janvier 2021.
* **Hint :** Comparez le champ `creation_date` avec l'opérateur `>`.
* **Expected Output :**

| name | creation_date |
| :--- | :--- |
| Apex Business School | 2022-01-15 |

### Exercice 11 : Pas de bio

* **Description :** Trouver les identifiants des mentors qui n'ont pas écrit de biographie (le champ `bio` est vide ou nul).
* **Hint :** Utilisez la condition `IS NULL`.
* **Expected Output :** *(Retourne un tableau vide car tous les mentors de test ont une bio)*
| id_user |
| :--- |

### Exercice 12 : Numéros étudiants

* **Description :** Extraire tous les numéros d'étudiants (`student_number`) présents dans le système.
* **Hint :** Ciblez la colonne de la table `student_profiles`.
* **Expected Output :**

| student_number |
| :--- |
| STU-2025-001 |
| STU-2025-002 |
| STU-2025-003 |

### Exercice 13 : Les cours sans fioritures

* **Description :** Afficher les titres des cours disponibles, mis en majuscules.
* **Hint :** Utilisez la fonction SQL `UPPER()`.
* **Expected Output :**

| UPPER(title) |
| :--- |
| INTRODUCTION AUX BASES DE DONNÉES |
| PROGRAMMATION PYTHON AVANCÉE |
| SÉCURITÉ DES ARCHITECTURES WEB |
| ANALYSE FINANCIÈRE ET BUDGÉTAIRE |

### Exercice 14 : Inscriptions au premier jour

* **Description :** Lister les étudiants inscrits exactement le '2025-09-01'.
* **Hint :** Filtrez la colonne `enrollment_date`.
* **Expected Output :**

| id_user | student_number | enrollment_date |
| :--- | :--- | :--- |
| 29 | STU-2025-011 | 2025-09-01 |
| 30 | STU-2025-012 | 2025-09-01 |

### Exercice 15 : Les questions de quiz

* **Description :** Afficher le texte de toutes les questions valant exactement 1 point.
* **Hint :** Utilisez la table `questions` avec un filtre sur `points = 1`.
* **Expected Output :**

| question_text | points |
| :--- | :--- |
| Quelle clause permet de filtrer les résultats d un groupe ? | 1 |

---

## Niveau : Intermédiaire (Intermediate)

### Exercice 16 : Jointure Étudiant & Utilisateur

* **Description :** Afficher le prénom, le nom et le numéro d'étudiant de chaque inscrit.
* **Hint :** Faites une jointure `INNER JOIN` entre `users` et `student_profiles`.
* **Expected Output :**

| first_name | last_name | student_number |
| :--- | :--- | :--- |
| Lucas | Bernard | STU-2025-001 |
| Chloé | Richard | STU-2025-002 |
| Hugo | Durand | STU-2025-003 |

### Exercice 17 : Répartition par Campus

* **Description :** Compter combien d'étudiants sont inscrits dans chaque campus.
* **Hint :** Joignez `campuses` et `student_profiles`, puis groupez par le nom du campus.
* **Expected Output :**

| campus_name | total_students |
| :--- | :--- |
| Nexus Paris Center | 6 |
| Nexus Lyon Tech | 6 |
| Apex Casablanca Finance | 7 |
| Apex Marrakech Management | 7 |

### Exercice 18 : Les Mentors et leurs cours

* **Description :** Afficher le titre de chaque cours ainsi que le nom et le prénom du mentor qui l'enseigne.
* **Hint :** Joignez la table `courses` à `users` en passant par `id_mentor`.
* **Expected Output :**

| title | mentor_first_name | mentor_last_name |
| :--- | :--- | :--- |
| Introduction aux Bases de Données | Alan | Turing |
| Programmation Python Avancée | Thomas | Pesquet |
| Sécurité des Architectures Web | Sarah | Connor |
| Analyse Financière et Budgétaire | Nadia | Mansouri |

### Exercice 19 : Localisation des Campus

* **Description :** Afficher le nom de chaque campus accompagné du nom de l'école à laquelle il appartient.
* **Hint :** Effectuez une jointure simple entre `schools` et `campuses`.
* **Expected Output :**

| campus_name | school_name |
| :--- | :--- |
| Nexus Paris Center | Nexus Institute of Technology |
| Nexus Lyon Tech | Nexus Institute of Technology |
| Apex Casablanca Finance | Apex Business School |
| Apex Marrakech Management | Apex Business School |

### Exercice 20 : Étudiants par niveau d'études (Filtre HAVING)

* **Description :** Compter le nombre d'étudiants par niveau d'études, mais n'afficher que les niveaux qui ont strictement plus de 5 étudiants.
* **Hint :** Utilisez `GROUP BY` combiné avec la clause `HAVING`.
* **Expected Output :**

| level_label | total_students |
| :--- | :--- |
| Bachelor 1 | 7 |
| Bachelor 2 | 6 |
| Master 2 | 7 |

### Exercice 21 : Liste des notes des quiz

* **Description :** Afficher le prénom de l'étudiant, le titre du quiz qu'il a passé, et la note qu'il a obtenue.
* **Hint :** Triple jointure requise : `users`, `student_quiz_results` et `quizzes`.
* **Expected Output :**

| first_name | title | score_obtained |
| :--- | :--- | :--- |
| Lucas | Quiz 1 : Les requêtes SELECT & Jointures | 5.00 |
| Chloé | Quiz 1 : Les requêtes SELECT & Jointures | 2.00 |
| Louis | Quiz 1 : Les requêtes SELECT & Jointures | 5.00 |

### Exercice 22 : Les Managers de Campus

* **Description :** Trouver les noms, prénoms et l'email de tous les utilisateurs qui possèdent spécifiquement le rôle de 'CAMPUS_MANAGER'.
* **Hint :** Joignez `users`, `user_roles`, et `roles` pour filtrer sur la chaîne 'CAMPUS_MANAGER'.
* **Expected Output :**

| first_name | last_name | email |
| :--- | :--- | :--- |
| Alice | Vautrin | a.vautrin@paris.nexus.edu |
| Marc | Morel | m.morel@lyon.nexus.edu |
| Amine | Benjelloun | a.benjelloun@casa.apex.edu |
| Layla | Tazi | l.tazi@kech.apex.edu |

### Exercice 23 : Quiz sans tentative

* **Description :** Trouver les quiz qui n'ont encore jamais été tentés par aucun étudiant.
* **Hint :** Utilisez un `LEFT JOIN` entre `quizzes` et `student_quiz_results` et cherchez les valeurs `IS NULL`.
* **Expected Output :**

| title |
| :--- |
| Quiz Final : Sécurité Applicative |

### Exercice 24 : Spécialités des mentors

* **Description :** Afficher l'identité des mentors (nom, prénom) qui ont la compétence 'SQL' listée dans leurs compétences (`skills`).
* **Hint :** Utilisez `INNER JOIN` avec la table `mentor_profiles` et un filtre `LIKE '%SQL%'`.
* **Expected Output :**

| first_name | last_name | skills |
| :--- | :--- | :--- |
| Alan | Turing | Machine Learning, Deep Learning, SQL |

### Exercice 25 : Moyenne d'un Quiz

* **Description :** Calculer la note moyenne obtenue par l'ensemble des étudiants pour le quiz ayant l'ID 1.
* **Hint :** Utilisez la fonction d'agrégation `AVG()`.
* **Expected Output :**

| average_score |
| :--- |
| 3.0000 |

### Exercice 26 : Les affectations administratives (Staff)

* **Description :** Afficher le nom du personnel de type 'STAFF' (nom, prénom) et le nom du campus qu'ils gèrent.
* **Hint :** Utilisez la table de liaison `campus_assignments` pour joindre les tables.
* **Expected Output :**

| first_name | last_name | campus_name |
| :--- | :--- | :--- |
| Julien | Rousseau | Nexus Paris Center |
| Emma | Petit | Nexus Lyon Tech |
| Khadija | Idrissi | Apex Casablanca Finance |
| Omar | S组织 | Apex Marrakech Management |

### Exercice 27 : Les réponses correctes

* **Description :** Pour chaque question du système, afficher le texte de la question et uniquement le texte de sa réponse correcte.
* **Hint :** Joignez `questions` et `answers` en ajoutant la condition `is_correct = 1`.
* **Expected Output :**

| question_text | correct_answer_text |
| :--- | :--- |
| Que signifie l acronyme SQL ? | Structured Query Language |
| Quelle clause permet de filtrer les résultats d un groupe ? | HAVING |

### Exercice 28 : Concaténation d'identité

* **Description :** Afficher une colonne unique nommée `full_name` combinant le prénom et le nom (séparés par un espace) de tous les étudiants.
* **Hint :** Utilisez la fonction `CONCAT()`.
* **Expected Output :**

| full_name |
| :--- |
| Lucas Bernard |
| Chloé Richard |
| Hugo Durand |

### Exercice 29 : Nombre de quiz par cours

* **Description :** Lister tous les cours et le nombre de quiz associés à chacun d'eux.
* **Hint :** Utilisez un `LEFT JOIN` avec la table `quizzes` associé à un `GROUP BY`.
* **Expected Output :**

| title | total_quizzes |
| :--- | :--- |
| Introduction aux Bases de Données | 1 |
| Programmation Python Avancée | 0 |
| Sécurité des Architectures Web | 1 |
| Analyse Financière et Budgétaire | 0 |

### Exercice 30 : Les étudiants de Paris

* **Description :** Trouver le nom et l'email de tous les étudiants rattachés au campus de 'Nexus Paris Center'.
* **Hint :** Joignez `users`, `student_profiles` et `campuses` pour filtrer sur le nom du campus.
* **Expected Output :**

| last_name | email |
| :--- | :--- |
| Bernard | lucas.b@student.edu |
| Richard | chloe.r@student.edu |
| Durand | hugo.d@student.edu |

### Exercice 31 : Les cours par niveau

* **Description :** Lister les titres de cours destinés aux étudiants en "Master 1" ou "Master 2".
* **Hint :** Joignez `courses` et `grade_levels` et utilisez l'opérateur `IN`.
* **Expected Output :**

| title | grade_label |
| :--- | :--- |
| Programmation Python Avancée | Master 1 |
| Sécurité des Architectures Web | Master 2 |

### Exercice 32 : Les tentatives infructueuses

* **Description :** Trouver les étudiants qui ont passé un quiz mais ont obtenu une note strictement inférieure au score de validation minimum (`passing_score`) requis pour ce quiz.
* **Hint :** Multipliez ou divisez pour ramener la note sur 100, ou comparez les ratios. (Ici : Score obtenu / Total Possible Score * 100 < passing_score).
* **Expected Output :**

| first_name | last_name | score_obtained | passing_score |
| :--- | :--- | :--- | :--- |
| Chloé | Richard | 2.00 | 60.00 |
| Adnane | Kabbaj | 0.00 | 60.00 |

### Exercice 33 : Compter les profils par rôle

* **Description :** Afficher la liste de tous les rôles et le nombre d'utilisateurs affectés à chacun d'eux.
* **Hint :** Fait à l'aide d'un `GROUP BY` sur la table pivot `user_roles`.
* **Expected Output :**

| role_name | number_of_users |
| :--- | :--- |
| ADMIN | 2 |
| SCHOOL_MANAGER | 2 |
| CAMPUS_MANAGER | 4 |
| STAFF | 4 |
| MENTOR | 6 |
| STUDENT | 26 |

### Exercice 34 : Date au format personnalisé

* **Description :** Afficher la liste des utilisateurs avec leur date de création affichée au format européen 'JJ/MM/AAAA'.
* **Hint :** Utilisez la fonction `DATE_FORMAT(created_at, '%d/%m/%Y')`.
* **Expected Output :**

| first_name | last_name | date_formatted |
| :--- | :--- | :--- |
| Guillaume | Mercier | 19/05/2026 |
| Sofia | Alami | 19/05/2026 |

### Exercice 35 : Les écoles de chaque manager

* **Description :** Afficher le prénom et le nom de chaque "School Manager" et le nom de l'école qu'il supervise.
* **Hint :** Joignez `users`, `school_assignments`, et `schools`.
* **Expected Output :**

| first_name | last_name | school_name |
| :--- | :--- | :--- |
| Charles | Dubois | Nexus Institute of Technology |
| Youssef | Naciri | Apex Business School |

---

## Niveau : Avancé (Advanced)

### Exercice 36 : Requête d'audit complète des Quiz

* **Description :** Afficher l'historique complet des réponses soumises par l'étudiant "Lucas Bernard" : le titre du quiz, la question posée, la réponse qu'il a cochée, et si cette réponse était juste ou fausse.
* **Hint :** Multiples jointures requises entre `student_answers`, `quizzes`, `questions`, `answers` et `users`.
* **Expected Output :**

| title | question_text | answer_text | is_correct |
| :--- | :--- | :--- | :--- |
| Quiz 1 : Les requêtes SELECT & Jointures | Que signifie l acronyme SQL ? | Structured Query Language | 1 |
| Quiz 1 : Les requêtes SELECT & Jointures | Quelle clause permet de filtrer les résultats d un groupe ? | HAVING | 1 |

### Exercice 37 : Le Major de Promotion (Sous-requête)

* **Description :** Trouver l'étudiant (nom, prénom) qui a obtenu la meilleure note absolue au "Quiz 1".
* **Hint :** Utilisez une sous-requête avec `MAX()` ou triez par ordre décroissant avec un `LIMIT 1`.
* **Expected Output :**

| first_name | last_name | score_obtained |
| :--- | :--- | :--- |
| Lucas | Bernard | 5.00 |

### Exercice 38 : Taux de réussite global par Quiz

* **Description :** Pour chaque quiz, afficher son titre et le pourcentage d'étudiants ayant réussi l'examen (note obtenue $\ge$ score de validation) par rapport au nombre total de personnes ayant tenté le quiz.
* **Hint :** Utilisez un `CASE WHEN` imbriqué dans un `AVG()` pour calculer le ratio de réussite.
* **Expected Output :**

| title | success_rate_percentage |
| :--- | :--- |
| Quiz 1 : Les requêtes SELECT & Jointures | 60.00 % |
| Quiz Final : Sécurité Applicative | 0.00 % |

### Exercice 39 : Utilisateurs multi-rôles

* **Description :** Écrire une requête qui détecte si un utilisateur s'est vu attribuer plusieurs rôles différents dans le système, et afficher son identifiant et son nombre de rôles.
* **Hint :** Groupez par `id_user` dans `user_roles` et appliquez un `HAVING COUNT(*) > 1`.
* **Expected Output :** *(Tableau vide car chaque utilisateur n'a qu'un rôle dans le seed)*

| id_user | total_roles |
| :--- | :--- |

### Exercice 40 : Les cours "Orphelins" de Mentors

* **Description :** Sélectionner tous les cours qui n'ont actuellement aucun Mentor assigné, ou dont le mentor assigné est désactivé (`is_active = 0`).
* **Hint :** Utilisez un `LEFT JOIN` vers `mentor_profiles` et vérifiez l'état du compte dans la table `users`.
* **Expected Output :** *(Tableau vide car tous les cours ont un mentor actif dans le seed)*

| title | id_mentor |
| :--- | :--- |

### Exercice 41 : Classement par fonction de fenêtrage (`DENSE_RANK`)

* **Description :** Pour le "Quiz 1", afficher le nom de l'étudiant, sa note, et son rang de classement parmi tous les participants, sans sauter de rang en cas d'égalité.
* **Hint :** Utilisez la fonction de fenêtrage `DENSE_RANK() OVER (ORDER BY score_obtained DESC)`.
* **Expected Output :**

| last_name | score_obtained | rank_position |
| :--- | :--- | :--- |
| Bernard | 5.00 | 1 |
| Roux | 5.00 | 1 |
| Simon | 3.00 | 2 |
| Richard | 2.00 | 3 |
| Kabbaj | 0.00 | 4 |

### Exercice 42 : Campus sans aucun personnel de Staff

* **Description :** Trouver tous les campus (nom et ville) pour lesquels aucun membre du personnel ('STAFF') n'a été assigné.
* **Hint :** Combinez un `NOT IN` ou un `NOT EXISTS` basé sur la table `campus_assignments` lié aux rôles de type Staff.
* **Expected Output :** *(Tableau vide car tous les campus de test ont un staff assigné)*

| name | city |
| :--- | :--- |

### Exercice 43 : Étudiants n'ayant jamais passé de quiz

* **Description :** Afficher l'identité de tous les étudiants officiellement inscrits dans un parcours mais qui n'ont effectué *aucune* tentative à aucun quiz.
* **Hint :** Utilisez `NOT EXISTS` ou `LEFT JOIN ... WHERE id_result IS NULL` à partir de la table `student_profiles`.
* **Expected Output :**

| student_number | first_name | last_name |
| :--- | :--- | :--- |
| STU-2025-003 | Hugo | Durand |
| STU-2025-004 | Inès | Lefebvre |
| STU-2025-005 | Maxime | Moreau |

### Exercice 44 : Le total des points par Quiz

* **Description :** Calculer dynamiquement la valeur totale en points de chaque quiz en additionnant les points de toutes ses questions.
* **Hint :** Joignez `quizzes` et `questions`, groupez par quiz.
* **Expected Output :**

| title | total_calculated_points |
| :--- | :--- |
| Quiz 1 : Les requêtes SELECT & Jointures | 5 |

### Exercice 45 : Requête d'agrégation conditionnelle croisée (Pivot)

* **Description :** Générer un tableau affichant pour chaque campus le nombre d'étudiants en 'Bachelor 1', 'Bachelor 3' et 'Master 2' sous forme de colonnes distinctes.
* **Hint :** Utilisez l'expression `SUM(CASE WHEN gl.label = 'Bachelor 1' THEN 1 ELSE 0 END) AS B1`.
* **Expected Output :**

| campus_name | Bachelor_1 | Bachelor_3 | Master_2 |
| :--- | :--- | :--- | :--- |
| Nexus Paris Center | 2 | 1 | 1 |
| Nexus Lyon Tech | 1 | 2 | 1 |
| Apex Casablanca Finance | 2 | 1 | 2 |
| Apex Marrakech Management | 1 | 2 | 2 |

### Exercice 46 : Les mentors les plus actifs

* **Description :** Trouver le ou les mentors qui dispensent le plus grand nombre de cours dans l'ensemble de l'établissement.
* **Hint :** Comptez les cours par `id_mentor` et utilisez une condition `HAVING` égale à la valeur maximale calculée.
* **Expected Output :**

| first_name | last_name | total_courses |
| :--- | :--- | :--- |
| Alan | Turing | 1 |
| Thomas | Pesquet | 1 |
| Sarah | Connor | 1 |
| Nadia | Mansouri | 1 |

### Exercice 47 : Ancienneté des étudiants (Calcul de dates)

* **Description :** Calculer l'écart entre la date d'inscription d'un étudiant et la date du jour actuel (en jours) pour voir son ancienneté dans l'école.
* **Hint :** Utilisez la fonction de calcul de différence de date `DATEDIFF(NOW(), enrollment_date)`.
* **Expected Output :** *(Note : Le nombre de jours dépendra de la date actuelle de votre serveur lors de l'exécution, calculé ici par rapport à la date système courante de mai 2026)*

| student_number | days_of_seniority |
| :--- | :--- |
| STU-2025-011 | 260 |
| STU-2025-001 | 259 |

### Exercice 48 : Suppression sécurisée et simulation de dépendances

* **Description :** Tenter d'écrire la requête qui supprimerait le niveau d'études 'Bachelor 1'. Expliquer pourquoi la base va refuser ou ce qu'il adviendra.
* **Hint :** Regardez la contrainte `ON DELETE RESTRICT` définie dans l'architecture de la table `student_profiles`.
* **Expected Output :**

| Error_Message |
| :--- |
| `ERROR 1451 (23000): Cannot delete or update a parent row: a foreign key constraint fails...` |

### Exercice 49 : Trouver les doublons d'adresses email erronées

* **Description :** Écrire une requête de nettoyage permettant de lister s'il y a des utilisateurs partageant exactement la même adresse email (insensible à la casse).
* **Hint :** Utilisez `LOWER(email)`, `GROUP BY` et `HAVING COUNT(*) > 1`.
* **Expected Output :** *(Tableau vide car la contrainte UNIQUE bloque nativement la création de doublons)*
  
| duplicated_email | total_occurrences |
| :--- | :--- |

### Exercice 50 : Rapport de performance global des Écoles

* **Description :** Créer un rapport de synthèse final qui donne : le nom de l'école, le nom du campus, le nombre total d'étudiants, et la note maximale absolue décrochée à un quiz sur ce campus.
* **Hint :** Une méga-jointure globale utilisant les tables `schools`, `campuses`, `student_profiles` et `student_quiz_results`.
* **Expected Output :**

| school_name | campus_name | total_students | max_score_obtained |
| :--- | :--- | :--- | :--- |
| Nexus Institute of Technology | Nexus Paris Center | 6 | 5.00 |
| Nexus Institute of Technology | Nexus Lyon Tech | 6 | 5.00 |
| Apex Business School | Apex Casablanca Finance | 7 | 3.00 |
| Apex Business School | Apex Marrakech Management | 7 | 0.00 |
