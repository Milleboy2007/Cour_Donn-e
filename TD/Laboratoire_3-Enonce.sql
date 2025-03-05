-- ==============================================================================
-- Description du cours : Introduction au bases de donn�es
-- Code du cours : 420-212-MV
-- Laboratoire 3
-- Les requ�tes Multitables

-- Objectif : 
-- Ce Laboratoire vise � acqu�rir les comp�tences suivantes
-- ========================================================
-- La jointure entre plusieurs tables
-- Dans une base de donn�es relationnelles, les requ�tes portent sur 
-- plusieurs tables.
-- D�marche pour r�aliser une requ�te multitables
-- Identifier la table principale (ma�tre)
-- Identifier la table secondaire (d�tail)
-- Identifier la cl� primaire dans la table ma�tre
-- Identifier la cl� �trang�re dans la table d�tail
-- �tablir la jointure entre la table maitre --> d�tail
-- La relation de 1 --> plusieurs
-- Base de donn�es � utiliser : HRDB
-- ----------------------------------

-- Requ�te 1
-- Ecrire une requ�te qui affiche les pays et les r�gions.
-- On afficera les colonnes :
-- Le nom de la r�gion
-- Le nom du pays

-- D�marche syst�matique
-- Identifier les tables requises : regions, countries
-- Identifier la table maitre (1) : regions
-- Identifier la table d�tail (plusieurs) : countries
-- Identifier la cl� primaire PK dans la table maitre (regions) : region_id
-- Identifier la cl� �trang�re FK dans la table d�tail (countries) : region_id  
-- Jointure entre regions --> countries
-- Jointure : maitre.PK = detail.FK
-- Jointure : regions.region_id = countries.region_id

-- Votre code ici
-- Ce code ci-dessous ne produit pas le r�sultat attendu
-- Car il n'y a pas de jointure

SELECT 
	[region_name],
	[country_name]
FROM [dbo].[countries] B, [dbo].[regions] A
WHERE A.region_id = B.region_id
ORDER BY 1,2


-- Corrigeons la situation et �crivant une jointure


-- ---------
-- Requ�te 2
-- �crire une requ�te qui affiche les employ�s ainsi que leurs proches et leur lien de parent�
-- On affichera :
-- Le nom de l'employ�
-- Le pr�nom de l'employ�
-- La date d'embauche
-- Le salaire
-- Le nom du proche
-- Le pr�nom du proche
-- Le lien de parent�

-- D�marche syst�matique
-- Identifier les tables requises : employees, dependents
-- Identifier la table maitre : employees
-- Identifier la table d�tail : dependents
-- Identifier la cl� primaire (PK) dans la table maitre : employee_id
-- Identifier la cl� �trang�re (FK)  dans la table d�tail : employee_id
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
-- Requ�te 3 
-- �crire une requ�te qui affiche les d�partements et les employ�s qui y travaillent
-- On affichera :
-- Le nom du d�partement
-- Le nom de l'employ�
-- Le pr�nom de l'employ�
-- la date d'embauche
-- Le salaire

-- D�marche syst�matique
-- Identifier les tables requises : departments, employees
-- Identifier la table maitre : departments
-- Identifier la table d�tail : employees
-- Identifier la PK dans la table maitre : department_id
-- Identifier la FK dans la table d�tail : department_id
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
-- Requ�te 4
-- �crire une requete qui affiche ou sont situ�s les bureaux de la compagnie
-- On affichera :
-- Le nom du d�partememnt
-- L'Adresse
-- La province
-- La ville

-- D�marche syst�matique
-- Identifier les tables requises : locations,  departments
-- Identifier la table maitre : locations 
-- Identifier la table d�tail : departments
-- Identifier la PK dans la table maitre : location_id
-- Identifier la FK dans la table d�tail : location_id
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
-- Requ�te 5
-- Modifier la requ�te pr�c�dente en rajoutant le poste occup� par l'employ�
-- On affichera en plus des colonnes pr�c�dentes :
-- Le nom du poste occup�

-- D�marche syst�matique
-- Identifier les tables requises : departments, employees, jobs
-- Identifier la table maitre : departments
-- Identifier la table d�tail : employees
-- Identifier la table maitre : jobs
-- Identifier la PK dans la table maitre : department_id
-- Identifier la FK dans la table d�tail : department_id
-- Identifier la FK dans la table d�tail : job_id
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