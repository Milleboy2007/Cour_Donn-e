-- ==============================================================================
-- Description du cours : Introduction au bases de données
-- Code du cours : 420-212-MV
-- Laboratoire 5
-- Les commandes DDL

-- Objectif : 
-- Ce Laboratoire vise à acquérir les compétences suivantes
-- ========================================================
-- Les commandes DDL
-- Les commandes DML

-- Création d'une base de données
-- la commande CREATE DATABASE nomBase
-- Sélection de la base nouvellement créée.
-- La commande USE nomBase

-- Suppression de la base de données
-- La commande DROP DATATBASE nomBase

-- Requête 1
-- Écrire un script qui crée la base de données Lab5
-- Le nom de la base de données est : Lab5

-- Votre code ici
--Contexte master
USE master;

-- Vérification de l'existence de la base de données
DROP DATABASE IF EXISTS Lab5;

-- Création de la base de données
CREATE DATABASE Lab5;

-- Commit en cas d'exécution multiple (GO)


-- Vérification du contexte par défaut
SELECT DB_NAME();

-- Utilisation du contexte NomBaseDonnee
USE Lab5;
-- Vérification du contexte par défaut
SELECT DB_NAME();

-- Création de table par code
-- La commade CREATE nomObjet
-- Création de la table collection
-- 
-- Créer la table collection avec les specs suivantes : 
-- No de la cllection, clé primaire, valeur unique auto
-- Type de la collection : chaine de caractère de longueur 15
-- Nom de la collection : chaine de longueur 20, non null
-- Quantité : entier non nul
-- Date de création : date du jour

DROP TABLE IF EXISTS tblCollection;
CREATE TABLE tblCollection(
	NoCollection uniqueidentifier PRIMARY KEY NOT NULL DEFAULT NEWID(),
	CollectionType nvarchar(15),
	CollectionName nvarchar(20) NOT NULL,
	CollectionQte int NOT NULL,
	CollectionPrix decimal(15,2)
);

EXEC sp_help tblCollection;

-- Vérification de l'existence de la table collection
-- Suppression de la table si elle existe
-- La commande DROP nomObjet


-- Vérification de la création de la table


-- Modification de la structure de la table collection
-- La commande ALTER


 -------------------------------------------
 -- Modification de la structure d'une table
 -- en supprimant une colonne
 -- ALTER Table
 -- La commande DROP NomColonne
 --------------------------------------------
 ALTER TABLE tblCollection
	ADD CollectionNotes nvarchar(255);
 -- Vérification de la structure de la table après modification
 EXEC sp_help tblCollection;

 ALTER TABLE tblCollection
	DROP COLUMN IF EXISTS CollectionNotes;

EXEC sp_help tblCollection;


 ALTER TABLE tblCollection
	ADD CollectionNotes nvarchar(255),
		CollectionAssurance bit;

EXEC sp_help tblCollection;
 -------------------------------------------
 -- Supprimer une table
 -- DROP TABLE nomTable
 -------------------------------------------
 DROP TABLE IF EXISTS tblCollection;

  --------------------------------------------------
 --- Creation de table à partir des données
 --- d'une autre table provenant d'une autre base de données
 -- Installer la base de données xtreme
 --------------------------------------------------------------------
 --- Copier les données d'une table vers une autre

 IF OBJECT_ID('tblClient') IS NOT NULL
	BEGIN
		DROP TABLE tblClient
		PRINT 'Table supprimer avec succès'
	END
ELSE PRINT 'La table n''existe pas'
-------------------------------------------------------------------
-- Vérification de l'existence d'un objet dans la 
-- base de données système
-------------------------------------------------------------------
 --Si l'objet table n'existe pas, on le créée
 --IF OBJECT_ID('ObjectName') IS NULL

 -- Si l'objet tblClient existe (IS NOT NULL), on le supprime
 -- pour le créer de nouveau
 
 -- Création de la table tblClients
 -- --------------------------------------------------------------------
 
 SELECT *
 INTO tblClient
 FROM [xtremefr].[dbo].[Clients]

-- Vérification de tblClient
SELECT *
FROM [dbo].[tblClient]

-- Vérifier la création de la table avec les données


-----------------------------------------------------------------------
-- Créer la table tblClientCanada avec les données
-- de la table Client de la base de données xtreme


-- Vérifier la création de la table avec les données
-----------------------------------------------------------------------
 
 

 ----------------------------------------------------------------------
 SELECT *
 INTO 
	tblClientCA
 FROM 
	[xtremefr].[dbo].[Clients]
 WHERE
	 [Pays] LIKE('Canada')

SELECT *
FROM [dbo].[tblClientCA]

 ----------------------------------------------------------------------
 DROP TABLE IF EXISTS tblFournisseurProduits

 SELECT *
	/*[Nom du fournisseur],
	[ID fournisseur],
	[Nom du produit]*/
 INTO tblFournisseurProduits
 FROM (
	SELECT 
		B.[Nom du fournisseur],
		B.[ID fournisseur],
		A.[Nom du produit],
		B.Pays
	FROM 
		[xtremefr].[dbo].[Produits] A,
		[xtremefr].[dbo].[Fournisseurs] B
	WHERE 
		A.[ID fournisseur] = B.[ID fournisseur]
) temp

SELECT *
FROM tblFournisseurProduits

