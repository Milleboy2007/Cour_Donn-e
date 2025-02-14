-- ==============================================================================
-- Description du cours : Introduction au bases de données
-- Code du cours : 420-212-MV
-- Travaux dirigés 2
-- Les requêtes SELECTION

-- Objectif : 
-- Ce travail dirigé est une introduction à la commande SELECT du langage SQL
-- ==============================================================================
-- ---------
-- Requête 1
-- Ecrire une requête affiche la liste des employé de la base de données HRDB
-- On affichera toutes les colonnes et toutes lignes de la table
-- Base de données : HRDB
-- Table : employees
-- Vérifier la structure de la table "employees"

-- Votre code ici
SELECT *
FROM [dbo].[employees]

-- ---------
-- Requête 2
-- Ecrire une requête affiche la liste des employé de la base de données HRDB
-- Formatage du code SQL
-- Les commentaires
-- Base de données : HRDB
-- Table : employees
-- Vérifier la structure de la table "employees"
-- On affichera les colonnes suivantes : 
-- employee_id
-- last_name
-- fisrt_name
-- email
-- salary

-- Votre code ici
SELECT 
	[employee_id],
	[last_name],
	[first_name],
	[email],
	[salary]
FROM [dbo].[employees]


-- ---------
-- Requête 3
-- Modifier la requête précédente afin d'utiliser des noms de colonnes plus conviviaux
-- Utilisation des ALIAS
-- nLes alias avec les [] 
-- Les alias avec le mot réservé AS
--
-- Votre code ici
SELECT 
	[employee_id] No_Employe,
	[last_name] Nom_De_Famille,
	[first_name] Prénom,
	[email] Courriel,
	[salary] AS Salaire
FROM [dbo].[employees]

-- ---------
-- Requête 4
-- Écrire une requête présente les résultats dans un certain ordre.
-- Tri des résultats
-- Écrire une requête qui affiche la liste des employés triée
-- par ordre alphabétique croissant du nom de famille.
-- On affichera les mêmes colonnes que la requête précédente.

-- Votre code ici
SELECT 
	[employee_id] No_Employe,
	[last_name] Nom_De_Famille,
	[first_name] Prénom,
	[email] Courriel,
	[salary] AS Salaire
FROM [dbo].[employees]
ORDER BY [last_name] ASC --DESC (Décroissant)

-- ----------
-- Requête 5
-- Écrire une requete qui affiche la liste des emplois.
-- Table  : jobs
-- On affichera toutes les colonnes de la table

-- Votre code ici
SELECT *
FROM [dbo].[jobs]

-- ----------
-- Requête 6
-- Modifier la requete précédente pour afficher les jobs en 
-- changeant le libéllé des entete de colonne.
-- Afficher : 
-- NoPoste au lieu de job_id
-- TitrePoste au lieu de job_title
-- Salaire minimum au lieu de min_salary
-- Salaire maximum au lieu de max_salary

-- Votre code ici
SELECT 
[job_id] NoPoste,
[job_title] TitrePoste,
[min_salary] "Salaire minimum",
[max_salary] "Salaire maximum"
FROM [dbo].[jobs]

-- ----------
-- Requête 7
-- Écrire une requete qui affiche la liste des postes triée
-- en ordre croissant du titre du poste.

-- Votre code ici
SELECT 
[job_id] NoPoste,
[job_title] TitrePoste,
[min_salary] "Salaire minimum",
[max_salary] "Salaire maximum"
FROM [dbo].[jobs]
ORDER BY [job_title]

-- ----------
-- Requête 8
-- Écrire une requete qui affiche la liste des postes triée
-- en ordre décroissant du salaire minimum.

-- Votre code ici
SELECT 
[job_id] NoPoste,
[job_title] TitrePoste,
[min_salary] "Salaire minimum",
[max_salary] "Salaire maximum"
FROM [dbo].[jobs]
ORDER BY [job_title] DESC

-- Requête 9
-- ecrire une requête qui affiche la liste des employer
-- dont le salaire est inferieur a 10k

SELECT 
	[employee_id] No_Employe,
	[last_name] Nom_De_Famille,
	[first_name] Prénom,
	[email] Courriel,
	[salary] AS Salaire
FROM [dbo].[employees]
WHERE [salary] > 10000 and [salary] < 50000 --BETWEEN 10000 AND 50000
ORDER BY [salary] ASC --DESC (Décroissant)

-- Requête 10
-- Écrire une requête qui affiche les employer qui on pas de num

SELECT 
	[employee_id] No_Employe,
	[last_name] Nom_De_Famille,
	[first_name] Prénom,
	[email] Courriel,
	[salary] AS Salaire,
	[phone_number]
FROM [dbo].[employees]
WHERE [phone_number] IS NULL --NOT NULL