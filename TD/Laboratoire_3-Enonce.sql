-- ==============================================================================
-- Description du cours : Introduction au bases de données
-- Code du cours : 420-212-MV
-- Laboratoire 3
-- Les requêtes Multitables

-- Objectif : 
-- Ce Laboratoire vise à acquérir les compétences suivantes
-- ========================================================
-- La jointure entre plusieurs tables
-- Dans une base de données relationnelles, les requêtes portent sur 
-- plusieurs tables.
-- Démarche pour réaliser une requête multitables
-- Identifier la table principale (maître)
-- Identifier la table secondaire (détail)
-- Identifier la clé primaire dans la table maître
-- Identifier la clé étrangère dans la table détail
-- Établir la jointure entre la table maitre --> détail
-- La relation de 1 --> plusieurs
-- Base de données à utiliser : HRDB
-- ----------------------------------

-- Requête 1
-- Ecrire une requête qui affiche les pays et les régions.
-- On afficera les colonnes :
-- Le nom de la région
-- Le nom du pays

-- Démarche systématique
-- Identifier les tables requises : regions, countries
-- Identifier la table maitre (1) : regions
-- Identifier la table détail (plusieurs) : countries
-- Identifier la clé primaire PK dans la table maitre (regions) : region_id
-- Identifier la clé étrangère FK dans la table détail (countries) : region_id  
-- Jointure entre regions --> countries
-- Jointure : maitre.PK = detail.FK
-- Jointure : regions.region_id = countries.region_id

-- Votre code ici
-- Ce code ci-dessous ne produit pas le résultat attendu
-- Car il n'y a pas de jointure

SELECT 
	[region_name],
	[country_name]
FROM [dbo].[countries] B, [dbo].[regions] A
WHERE A.region_id = B.region_id
ORDER BY 1,2


-- Corrigeons la situation et écrivant une jointure


-- ---------
-- Requête 2
-- Écrire une requête qui affiche les employés ainsi que leurs proches et leur lien de parenté
-- On affichera :
-- Le nom de l'employé
-- Le prénom de l'employé
-- La date d'embauche
-- Le salaire
-- Le nom du proche
-- Le prénom du proche
-- Le lien de parenté

-- Démarche systématique
-- Identifier les tables requises : employees, dependents
-- Identifier la table maitre : employees
-- Identifier la table détail : dependents
-- Identifier la clé primaire (PK) dans la table maitre : employee_id
-- Identifier la clé étrangère (FK)  dans la table détail : employee_id
-- Jointure entre employees --> dependents
-- Jointure : maitre.PK = detail.FK
-- Jointure : employee.employee_id = dependents.employee_id
-- Quel est de ce type de relation ? 1 --> 1 ou 1 --> plusieurs ?

-- Votre code ici
SELECT 
	A.[last_name],
	A.[first_name],
	A.[hire_date],
	A.[salary],
	B.[last_name] NomParent,
	B.[first_name] PrenomPrent
FROM [dbo].[employees] A, [dbo].[dependents] B
WHERE A.employee_id = B.employee_id

-- ---------
-- Requête 3 
-- Écrire une requête qui affiche les départements et les employés qui y travaillent
-- On affichera :
-- Le nom du département
-- Le nom de l'employé
-- Le prénom de l'employé
-- la date d'embauche
-- Le salaire

-- Démarche systématique
-- Identifier les tables requises : departments, employees
-- Identifier la table maitre : departments
-- Identifier la table détail : employees
-- Identifier la PK dans la table maitre : department_id
-- Identifier la FK dans la table détail : department_id
-- Jointure departments --> employees 
-- Jointure entre maitre.PK = detail.FK
-- Jointure : departments.departement_id = employees.departement_id

-- Votre code ici
SELECT 
	[department_name],
	[last_name],
	[first_name],
	[hire_date],
	[salary]
FROM 
	[dbo].[departments] A,
	[dbo].[employees] B
WHERE 
	A.department_id = B.department_id
ORDER BY 1, 2

-- ---------
-- Requête 4
-- Écrire une requete qui affiche ou sont situés les bureaux de la compagnie
-- On affichera :
-- Le nom du départememnt
-- L'Adresse
-- La province
-- La ville

-- Démarche systématique
-- Identifier les tables requises : locations,  departments
-- Identifier la table maitre : locations 
-- Identifier la table détail : departments
-- Identifier la PK dans la table maitre : location_id
-- Identifier la FK dans la table détail : location_id
-- Jointure locations  --> departments 
-- Jointure entre maitre.PK = detail.FK
-- Jointure : locations.location_id = departments.location_id

-- Votre code ici
SELECT 
	[department_name],
	[street_address],
	[state_province],
	[city]
FROM 
	[dbo].[departments] B,
	[dbo].[locations] A
WHERE 
	A.location_id = B.location_id
ORDER BY 1
-- ----------
-- Requête 5
-- Modifier la requête précédente en rajoutant le poste occupé par l'employé
-- On affichera en plus des colonnes précédentes :
-- Le nom du poste occupé

-- Démarche systématique
-- Identifier les tables requises : departments, employees, jobs
-- Identifier la table maitre : departments
-- Identifier la table détail : employees
-- Identifier la table maitre : jobs
-- Identifier la PK dans la table maitre : department_id
-- Identifier la FK dans la table détail : department_id
-- Identifier la FK dans la table détail : job_id
-- Identifier la PK dans la table maitre : Job_id
-- Jointure departments --> employees 
-- Jointure jobs --> employees
-- Jointure entre maitre.PK = detail.FK
-- Jointure entre maitre.PK2 = detail.FK2
-- Jointure : departments.departement_id = employees.departement_id
-- Jointure : jobs.job_id = employees.job.id

-- Votre code ici
SELECT
	[department_name],
	[last_name],
	[first_name],
	[hire_date],
	[salary],
	[job_title]
FROM 
	[dbo].[departments] A,
	[dbo].[employees] B,
	[dbo].[jobs] C
WHERE A.department_id = B.department_id AND C.job_id = B.job_id
ORDER BY 1,2