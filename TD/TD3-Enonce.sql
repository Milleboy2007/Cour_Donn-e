-- ==================================================================================
-- Description du cours : Introduction au bases de donn�es
-- Code du cours : 420-212-MV
-- Travaux dirig�s 3
-- Les requ�tes SELECTION avec la clause WHERE

-- Objectif : 
-- Ce travail dirig� portera sur la clause WHERE de la commande SELECT du langage SQL
-- ==================================================================================
-- ---------
-- Requ�te 1
-- Crit�re sur les colonnes de type num�rique
-- Les op�rateurs arithm�tiques :  =, <, <=, >, >=, <> , BETWEEN, OR, AND
-- Ecrire une requ�te affiche la liste des employ�s dont le salaire est �gal � 7000
-- On affichera toutes les colonnes:
-- Le nom de l'employ�
-- Le pr�nom de l'employ�
-- Le salaire
-- Le courriel
-- Base de donn�es : HRDB
-- Table : employees
-- V�rifier la structure de la table "employees"

-- Votre code ici
select 
	[last_name],
	[first_name],
	[salary],
	[email]
FROM [dbo].[employees]

-- ---------
-- Requ�te 2
-- Modifier la requ�te pr�c�dente pour afficher la liste des employ�s dont le salaire est sup�rieur ou �gal � 4500
-- On affichera les m�mes donn�es
-- La liste sera tri�e par le salaire

-- Votre code ici


-- ---------
-- Requ�te 3
-- Modifier la requ�te pr�c�dente pour afficher la liste des employ�s dont le salaire est compris entre 8000 and 13000
-- On affichera les m�mes donn�es
-- La liste sera tri�e par le salaire
--
-- Votre code ici


-- ---------
-- Requ�te 4
-- Modifier la requ�te pr�c�dente pour afficher la liste des employ�s dont le salaire est inf�rieur � 8000 et sup�rieur 10000
-- On affichera les m�mes donn�es
-- La liste sera tri�e par le salaire

-- Votre code ici


-- ----------
-- Requ�te 5
-- Modifier la requ�te pr�c�dente pour afficher la liste des employ�s dont le salaire est diff�rent de 4500
-- On affichera les m�mes donn�es
-- La liste sera tri�e par le salaire

-- Votre code ici


-- ----------
-- Requ�te 6
-- Crit�re sur les colonnes chaine de caract�res
-- �crire une requ�te qui affiche l'employ� Taylor
-- On affichera les colonnes suivantes. Changer le nom des colonnes par leur traduction en francais
--- Le nom de l'employ�
--- Le pr�nom de l'employ�
--- t�l�phone
--- Le courriel

-- Votre code ici



-- ----------
-- Requ�te 7
-- Modifier la requ�te pr�c�dente en affichant la liste des employ�s dont le nom commence par H
-- Op�rateur LIKE and caract�re g�n�rique %

-- Votre code ici



-- ----------
-- Requ�te 8
-- Modifier la requ�te pr�c�dente en affichant la liste des employ�s dont le t�l�phone commence par '555'
-- Op�rateur LIKE and caract�re g�n�rique %
-- La liste sera tri�e par le num�ro de t�l�phone

-- Votre code ici



-- ----------
-- Requ�te 9
-- Modifier la requ�te 7 en affichant la liste des employ�s dont le nom sont compris entre la lettre C et P
-- Op�rateur LIKE and caract�re g�n�rique %
-- 

-- Votre code ici



-- ----------
-- Requ�te 10
-- Modifier la requ�te pr�c�dente en affichant la liste des employ�s dont le nom sont compris entre la lettre C et P
-- Op�rateur LIKE and caract�re g�n�rique %
-- 

-- Votre code ici



-- ----------
-- Requ�te 11
-- Modifier la requ�te pr�c�dente en affichant la liste des employ�s dont le nom est fay, higgins, khoo, himuro 
-- Op�rateur IN 
-- 

-- Votre code ici



-- ----------
-- Requ�te 12
-- �crire une requ�te qui affiche la liste des employ�s embauch�s apr�s le 1er janvier 1990
-- La liste sera tri�e par la date d'embauche
-- On affichera 
--- Le nom
--- Le prenom
--- Le email
--- La date de d'embauche
-- 

-- Votre code ici



-- ----------
-- Requ�te 13
-- �crire une requ�te qui affiche la liste des employ�s embauch�s entre le 10 septembre 1995 et le 1 janvier 1998
-- La liste sera tri�e par la date d'embauche
-- On affichera 
--- Le nom
--- Le prenom
--- Le email
--- La date de d'embauche
-- 

-- Votre code ici

