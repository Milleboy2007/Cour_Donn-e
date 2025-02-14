-- ==============================================================================
-- Description du cours : Introduction au bases de donn�es
-- Code du cours : 420-212-MV
-- Travaux dirig�s 2
-- Les requ�tes SELECTION

-- Objectif : 
-- Ce travail dirig� est une introduction � la commande SELECT du langage SQL
-- ==============================================================================
-- ---------
-- Requ�te 1
-- Ecrire une requ�te affiche la liste des employ� de la base de donn�es HRDB
-- On affichera toutes les colonnes et toutes lignes de la table
-- Base de donn�es : HRDB
-- Table : employees
-- V�rifier la structure de la table "employees"

-- Votre code ici
SELECT *
FROM [dbo].[employees]

-- ---------
-- Requ�te 2
-- Ecrire une requ�te affiche la liste des employ� de la base de donn�es HRDB
-- Formatage du code SQL
-- Les commentaires
-- Base de donn�es : HRDB
-- Table : employees
-- V�rifier la structure de la table "employees"
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
-- Requ�te 3
-- Modifier la requ�te pr�c�dente afin d'utiliser des noms de colonnes plus conviviaux
-- Utilisation des ALIAS
-- nLes alias avec les [] 
-- Les alias avec le mot r�serv� AS
--
-- Votre code ici
SELECT 
	[employee_id] No_Employe,
	[last_name] Nom_De_Famille,
	[first_name] Pr�nom,
	[email] Courriel,
	[salary] AS Salaire
FROM [dbo].[employees]

-- ---------
-- Requ�te 4
-- �crire une requ�te pr�sente les r�sultats dans un certain ordre.
-- Tri des r�sultats
-- �crire une requ�te qui affiche la liste des employ�s tri�e
-- par ordre alphab�tique croissant du nom de famille.
-- On affichera les m�mes colonnes que la requ�te pr�c�dente.

-- Votre code ici
SELECT 
	[employee_id] No_Employe,
	[last_name] Nom_De_Famille,
	[first_name] Pr�nom,
	[email] Courriel,
	[salary] AS Salaire
FROM [dbo].[employees]
ORDER BY [last_name] ASC --DESC (D�croissant)

-- ----------
-- Requ�te 5
-- �crire une requete qui affiche la liste des emplois.
-- Table  : jobs
-- On affichera toutes les colonnes de la table

-- Votre code ici
SELECT *
FROM [dbo].[jobs]

-- ----------
-- Requ�te 6
-- Modifier la requete pr�c�dente pour afficher les jobs en 
-- changeant le lib�ll� des entete de colonne.
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
-- Requ�te 7
-- �crire une requete qui affiche la liste des postes tri�e
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
-- Requ�te 8
-- �crire une requete qui affiche la liste des postes tri�e
-- en ordre d�croissant du salaire minimum.

-- Votre code ici
SELECT 
[job_id] NoPoste,
[job_title] TitrePoste,
[min_salary] "Salaire minimum",
[max_salary] "Salaire maximum"
FROM [dbo].[jobs]
ORDER BY [job_title] DESC

-- Requ�te 9
-- ecrire une requ�te qui affiche la liste des employer
-- dont le salaire est inferieur a 10k

SELECT 
	[employee_id] No_Employe,
	[last_name] Nom_De_Famille,
	[first_name] Pr�nom,
	[email] Courriel,
	[salary] AS Salaire
FROM [dbo].[employees]
WHERE [salary] > 10000 and [salary] < 50000 --BETWEEN 10000 AND 50000
ORDER BY [salary] ASC --DESC (D�croissant)

-- Requ�te 10
-- �crire une requ�te qui affiche les employer qui on pas de num

SELECT 
	[employee_id] No_Employe,
	[last_name] Nom_De_Famille,
	[first_name] Pr�nom,
	[email] Courriel,
	[salary] AS Salaire,
	[phone_number]
FROM [dbo].[employees]
WHERE [phone_number] IS NULL --NOT NULL