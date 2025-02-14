-- ==================================================================================
-- Description du cours : Introduction au bases de données
-- Code du cours : 420-212-MV
-- Travaux dirigés 3
-- Les requêtes SELECTION avec la clause WHERE

-- Objectif : 
-- Ce travail dirigé portera sur la clause WHERE de la commande SELECT du langage SQL
-- ==================================================================================
-- ---------
-- Requête 1
-- Critère sur les colonnes de type numérique
-- Les opérateurs arithmétiques :  =, <, <=, >, >=, <> , BETWEEN, OR, AND
-- Ecrire une requête affiche la liste des employés dont le salaire est égal à 7000
-- On affichera toutes les colonnes:
-- Le nom de l'employé
-- Le prénom de l'employé
-- Le salaire
-- Le courriel
-- Base de données : HRDB
-- Table : employees
-- Vérifier la structure de la table "employees"

-- Votre code ici
select 
	[last_name],
	[first_name],
	[salary],
	[email]
FROM [dbo].[employees]

-- ---------
-- Requête 2
-- Modifier la requête précédente pour afficher la liste des employés dont le salaire est supérieur ou égal à 4500
-- On affichera les mêmes données
-- La liste sera triée par le salaire

-- Votre code ici
select 
	[last_name],
	[first_name],
	[salary],
	[email]
FROM [dbo].[employees]
where [salary] >= 4500 
order by [salary]


-- ---------
-- Requête 3
-- Modifier la requête précédente pour afficher la liste des employés dont le salaire est compris entre 8000 and 13000
-- On affichera les mêmes données
-- La liste sera triée par le salaire
--
-- Votre code ici
select 
	[last_name],
	[first_name],
	[salary],
	[email]
FROM [dbo].[employees]
where [salary] between 8000 and 13000
order by [salary]


-- ---------
-- Requête 4
-- Modifier la requête précédente pour afficher la liste des employés dont le salaire est inférieur à 8000 et supérieur 10000
-- On affichera les mêmes données
-- La liste sera triée par le salaire

-- Votre code ici
select 
	[last_name],
	[first_name],
	[salary],
	[email]
FROM [dbo].[employees]
where [salary] < 8000 or [salary] > 10000
order by [salary]



-- ----------
-- Requête 5
-- Modifier la requête précédente pour afficher la liste des employés dont le salaire est différent de 4500
-- On affichera les mêmes données
-- La liste sera triée par le salaire

-- Votre code ici
select 
	[last_name],
	[first_name],
	[salary],
	[email]
FROM [dbo].[employees]
where [salary] != 4500
order by [salary]


-- ----------
-- Requête 6
-- Critère sur les colonnes chaine de caractères
-- Écrire une requête qui affiche l'employé Taylor
-- On affichera les colonnes suivantes. Changer le nom des colonnes par leur traduction en francais
--- Le nom de l'employé
--- Le prénom de l'employé
--- téléphone
--- Le courriel

-- Votre code ici
select
	[last_name] "Nom de famille",
	[first_name] Prénom,
	[phone_number] "Numéro de téléphone",
	[email] Courriel
FROM [dbo].[employees]
where  [last_name] = 'Taylor'


-- ----------
-- Requête 7
-- Modifier la requête précédente en affichant la liste des employés dont le nom commence par H
-- Opérateur LIKE and caractère générique %

-- Votre code ici
select
	[last_name] "Nom de famille",
	[first_name] Prénom,
	[phone_number] "Numéro de téléphone",
	[email] Courriel
FROM [dbo].[employees]
where  [last_name] like 'H%'


-- ----------
-- Requête 8
-- Modifier la requête précédente en affichant la liste des employés dont le téléphone commence par '555'
-- Opérateur LIKE and caractère générique %
-- La liste sera triée par le numéro de téléphone

-- Votre code ici
select
	[last_name] "Nom de famille",
	[first_name] Prénom,
	[phone_number] "Numéro de téléphone",
	[email] Courriel
FROM [dbo].[employees]
where  [phone_number] like '515%'



-- ----------
-- Requête 9
-- Modifier la requête 7 en affichant la liste des employés dont le nom sont compris entre la lettre C et P
-- Opérateur LIKE and caractère générique %
-- 

-- Votre code ici
select
	[last_name] "Nom de famille",
	[first_name] Prénom,
	[phone_number] "Numéro de téléphone",
	[email] Courriel
FROM [dbo].[employees]
where  [last_name] between 'C' and 'P' 
order by [last_name]



-- ----------
-- Requête 10
-- Modifier la requête précédente en affichant la liste des employés dont le nom sont compris entre la lettre C et P
-- Opérateur LIKE and caractère générique %
-- 

-- Votre code ici
select
	[last_name] "Nom de famille",
	[first_name] Prénom,
	[phone_number] "Numéro de téléphone",
	[email] Courriel
FROM [dbo].[employees]
where [first_name]  between 'C' and 'P' 
order by [first_name]



-- ----------
-- Requête 11
-- Modifier la requête précédente en affichant la liste des employés dont le nom est fay, higgins, khoo, himuro 
-- Opérateur IN 
-- 

-- Votre code ici
select
	[last_name] "Nom de famille",
	[first_name] Prénom,
	[phone_number] "Numéro de téléphone",
	[email] Courriel
FROM [dbo].[employees]
where [last_name]  in('fay','higgins','himuro')
order by [last_name]



-- ----------
-- Requête 12
-- Écrire une requête qui affiche la liste des employés embauchés après le 1er janvier 1990
-- La liste sera triée par la date d'embauche
-- On affichera 
--- Le nom
--- Le prenom
--- Le email
--- La date de d'embauche
-- 

-- Votre code ici
SELECT
	[last_name] Nom,
	[first_name] Prénom,
	[email] Mail,
	[hire_date] "Date d'embauche"
FROM [dbo].[employees]
WHERE [hire_date] > '1990-01-01'
ORDER BY [hire_date]



-- ----------
-- Requête 13
-- Écrire une requête qui affiche la liste des employés embauchés entre le 10 septembre 1995 et le 1 janvier 1998
-- La liste sera triée par la date d'embauche
-- On affichera 
--- Le nom
--- Le prenom
--- Le email
--- La date de d'embauche
-- 

-- Votre code ici
SELECT
	[last_name] Nom,
	[first_name] Prénom,
	[email] Mail,
	[hire_date] "Date d'embauche"
FROM [dbo].[employees]
WHERE [hire_date] BETWEEN '1995-09-10' AND '1998-01-01'
ORDER BY [hire_date]

