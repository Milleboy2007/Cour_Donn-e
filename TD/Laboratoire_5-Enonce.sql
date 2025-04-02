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

EXEC sp_help tblFournisseurProduits;

SELECT *
FROM tblFournisseurProduits

-- ==============================================================================
-- Description du cours : Introduction au bases de donn�es
-- Code du cours : 420-212-MV
-- Laboratoire 5
-- Les commandes DDL

 ALTER DATABASE Lab5 SET SINGLE_USER WITH ROLLBACK IMMEDIATE --;

-- SHUTDOWN WITH NOWAIT; -- Red�marrage de l'instance

-- Objectif : 
-- Ce Laboratoire vise � acqu�rir les comp�tences suivantes
-- ========================================================
-- Les commandes DDL
-- Les commandes DML

-- Cr�ation d'une base de donn�es
-- la commande CREATE DATABASE nomBase
-- S�lection de la base nouvellement cr��e.
-- La commande USE nomBase


-----------------------------------------------------------------------
-- Suite Lab5
-- Table FournisseurProduits
 
 -- V�rifier la cr�ation de la table avec les donn�es
 
  -- ********************************************************************
 -- Copie enti�re de la structure d'une table. La table sans les donn�es
 -- Cr�er la table tblEmployes qui contient la structure de la table 
 -- Employees de la base de donn�es xtremefr

 -- Verifier l'existence de la table tblEmployes
  
 -- version 1 avec TOP 0
 DROP TABLE IF EXISTS tblEmployes
 SELECT TOP 0 *
 INTO tblEmployes
 FROM [xtremefr].[dbo].[Employ�s]

 -- Verifier l'existence de la table tblEmployes
 EXEC sp_help tblEmployes

 SELECT *
 FROM tblEmployes


 -- version 2 avec une condition fausse

 DROP TABLE IF EXISTS tblEmployes
 SELECT *
 INTO tblEmployes
 FROM [xtremefr].[dbo].[Employ�s]
 WHERE 0 > 1

 -- Verifier l'existence de la table tblEmployes
 EXEC sp_help tblEmployes

 SELECT *
 FROM tblEmployes

 -- V�rification de la cr�ation de la table tblEmployes


 -- Copie paritelle de la structure d'une table. La table sans les donn�es
 -- Cr�er la table tblEmployes qui contient la structure de la table 
 -- Employees de la base de donn�es xtremefr

 DROP TABLE IF EXISTS tblEmployes

 SELECT TOP 0 *
 INTO tblEmployes
 FROM (
	SELECT
		A.[ID employ�] AS IDEmployer
		,A.[ID sup�rieur] AS IDSuperieur
		,A.Nom AS Nom
		,A.Pr�nom AS Prenom
		,A.[Date de naissance] AS DateNaissance
		,A.[Date d'embauche] AS DateEmbauche
		,A.Salaire AS Salaire
		,YEAR(A.[Date de naissance]) AS 'Annee de naissance'
		,YEAR(A.[Date d'embauche]) AS 'Annee d''embauche'
	FROM [xtremefr].[dbo].[Employ�s] A
 ) temp

 -- Verifier l'existence de la table tblEmployes
 
 EXEC sp_help tblEmployes

 SELECT *
 FROM tblEmployes
 
-- Creation de la table tblDepartement
-- V�rification de l'existence de la table tblDepartement avant cr�ation


-- Cr�ation de la table tblDepartement ayant la structure suivante :
-- ID Dept , entier, cl� primaire, non nul, auto increment�
-- ID departement, identificateur unique, non nul, nouvel identifiant
-- Nom du d�partement, chaine longueur 30, not nul, unique

DROP TABLE IF EXISTS tblDepartement;

CREATE TABLE tblDepartement
(
	IDDept INT PRIMARY KEY NOT NULL IDENTITY(1,1),
	IDDepartement uniqueidentifier NOT NULL DEFAULT NEWID(),
	NomDepartement nvarchar(30) NOT NULL UNIQUE
)

EXEC sp_help tblDepartement;

-- Modification de la structure de la table tblEmployes
-- Ajout d'une cl� primaire � la table
ALTER TABLE tblEmployes
	ADD CONSTRAINT PK_IDEmployee PRIMARY KEY (IDEmployer);

-- Ajout de la colonne IDDept � la table employes (tblEmployes)
-- Specs : entier, non nul

ALTER TABLE tblEmployes
	ADD IDDept INT NOT NULL

-- Ajout d'une cl� �trang�re � la table employ�s

ALTER TABLE tblEmployes
	ADD CONSTRAINT FK_IDDept FOREIGN KEY (IDDept) REFERENCES tblDepartement(IDDept);

-- V�rifier la cr�ation des cl�s

EXEC sp_help tblEmployes;

-- Suppression d'une cl� primaire de la table tblEmployes

ALTER TABLE tblEmployes
	DROP CONSTRAINT PK_IDEmployee;

EXEC sp_help tblEmployes;

-- Ajout d'une cl� (primaire) compos�e Nom, prenom
-- Un cl� compos�e est une cl� primaire compos�e de plusieurs colonnes

ALTER TABLE tblEmployes
	ADD CONSTRAINT PK_NomPrenom PRIMARY KEY (Nom, Prenom)

-- V�rifier la cr�ation des cl�s

EXEC sp_help tblEmployes;

-- Supprimer la cl� compos�e

ALTER TABLE tblEmployes
	DROP CONSTRAINT PK_NomPrenom

-- Recr�er la cl� primaire
-- Supprimer la cl� primaire si elle existe



-- V�rifier la cr�ation des cl�s


-- Modifier la structure d'une table par code
-- Changer le type d'une colonne
-- ATTENTION, ce n'est pas toujours possible apr�s qu'on ait entr� des donn�es.
-- Changer le type des colonnes DateNaissance et DateEmbauche (DateTime) en Date
-- Changer le type de la colonne Salaire (money) en entier (int)

-- Colonne Salaire : Money vers int

ALTER TABLE tblEmployes
	ALTER COLUMN Salaire INT;

-- Colonne DateEmbauche : DateTime vers Date

ALTER TABLE tblEmployes
	ALTER COLUMN DateEmbauche Date;


-- Colonne DateNaissance : DateTime vers Date

ALTER TABLE tblEmployes
	ALTER COLUMN DateNaissance Date;

-- V�rifier le changement de type

EXEC sp_help tblEmployes;

-- Changer la longueur d'une colonne
-- ATTENTION, il y a un risque de troncature � diminuer la longueur d'une colonne

-- PosteOccupe : nvarchar(30) --> nvarchar(50)

ALTER TABLE tblEmployes
	ALTER COLUMN Nom nvarchar(50);

-- Changer le nom d'une colonne
-- Exemple : faute de frappe ou nom non significatif
-- Renommer Salaire en SalaireAnnuel

EXEC sp_rename 'tblEmployes.Salaire', 'SalaireAnnuel', 'COLUMN';
EXEC sp_help tblEmployes;

-- Ajout de donn�es dans la table Departement
-- On ajoute 4 d�partements : Informatique, Ressources humaines, Finances, Marketing


-- Ajout de donn�es dans la table employ�s
-- R�gle d'insertion de donn�es dans la colonne IDDept
-- L'employ� appartient au d�partement 1 quand son salaire est inf�rieur ou �gal � 30.000 $
-- L'employ� appartient au d�partement 2 quand son salaire est compris entre � 30.001 $ et 49.999 $
-- L'employ� appartient au d�partement 3 quand son salaire est compris entre � 50.000 $ et 69.999 $
-- L'employ� appartient au d�partement 4 quand son salaire est compris entre � 70.000 $ et 99.999 $


-- V�rifier le contenu de la table tblEmployes


-- �crire une requete qui affiche les employ�s ainsi que le nom de leurs d�partements


GO