-- ==============================================================================
-- Description du cours : Introduction au bases de donn�es
-- Code du cours : 420-212-MV
-- Laboratoire 5
-- Les commandes DDL

-- Objectif : 
-- Ce Laboratoire vise � acqu�rir les comp�tences suivantes
-- ========================================================
-- Les commandes DDL
-- Les commandes DML

-- Cr�ation d'une base de donn�es
-- la commande CREATE DATABASE nomBase
-- S�lection de la base nouvellement cr��e.
-- La commande USE nomBase

-- Suppression de la base de donn�es
-- La commande DROP DATATBASE nomBase

-- Requ�te 1
-- �crire un script qui cr�e la base de donn�es Lab5
-- Le nom de la base de donn�es est : Lab5

-- Votre code ici
--Contexte master
USE master;

-- V�rification de l'existence de la base de donn�es
DROP DATABASE IF EXISTS Lab5;

-- Cr�ation de la base de donn�es
CREATE DATABASE Lab5;

-- Commit en cas d'ex�cution multiple (GO)


-- V�rification du contexte par d�faut
SELECT DB_NAME();

-- Utilisation du contexte NomBaseDonnee
USE Lab5;
-- V�rification du contexte par d�faut
SELECT DB_NAME();

-- Cr�ation de table par code
-- La commade CREATE nomObjet
-- Cr�ation de la table collection
-- 
-- Cr�er la table collection avec les specs suivantes : 
-- No de la cllection, cl� primaire, valeur unique auto
-- Type de la collection : chaine de caract�re de longueur 15
-- Nom de la collection : chaine de longueur 20, non null
-- Quantit� : entier non nul
-- Date de cr�ation : date du jour

DROP TABLE IF EXISTS tblCollection;
CREATE TABLE tblCollection(
	NoCollection uniqueidentifier PRIMARY KEY NOT NULL DEFAULT NEWID(),
	CollectionType nvarchar(15),
	CollectionName nvarchar(20) NOT NULL,
	CollectionQte int NOT NULL,
	CollectionPrix decimal(15,2)
);

EXEC sp_help tblCollection;

-- V�rification de l'existence de la table collection
-- Suppression de la table si elle existe
-- La commande DROP nomObjet


-- V�rification de la cr�ation de la table


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
 -- V�rification de la structure de la table apr�s modification
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
 --- Creation de table � partir des donn�es
 --- d'une autre table provenant d'une autre base de donn�es
 -- Installer la base de donn�es xtreme
 --------------------------------------------------------------------
 --- Copier les donn�es d'une table vers une autre

 IF OBJECT_ID('tblClient') IS NOT NULL
	BEGIN
		DROP TABLE tblClient
		PRINT 'Table supprimer avec succ�s'
	END
ELSE PRINT 'La table n''existe pas'
-------------------------------------------------------------------
-- V�rification de l'existence d'un objet dans la 
-- base de donn�es syst�me
-------------------------------------------------------------------
 --Si l'objet table n'existe pas, on le cr��e
 --IF OBJECT_ID('ObjectName') IS NULL

 -- Si l'objet tblClient existe (IS NOT NULL), on le supprime
 -- pour le cr�er de nouveau
 
 -- Cr�ation de la table tblClients
 -- --------------------------------------------------------------------
 
 SELECT *
 INTO tblClient
 FROM [xtremefr].[dbo].[Clients]

-- V�rification de tblClient
SELECT *
FROM [dbo].[tblClient]

-- V�rifier la cr�ation de la table avec les donn�es


-----------------------------------------------------------------------
-- Cr�er la table tblClientCanada avec les donn�es
-- de la table Client de la base de donn�es xtreme


-- V�rifier la cr�ation de la table avec les donn�es
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

