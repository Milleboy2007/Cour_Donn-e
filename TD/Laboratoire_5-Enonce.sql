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

EXEC sp_help tblFournisseurProduits;

SELECT *
FROM tblFournisseurProduits

-- ==============================================================================
-- Description du cours : Introduction au bases de données
-- Code du cours : 420-212-MV
-- Laboratoire 5
-- Les commandes DDL

 ALTER DATABASE Lab5 SET SINGLE_USER WITH ROLLBACK IMMEDIATE --;

-- SHUTDOWN WITH NOWAIT; -- Redémarrage de l'instance

-- Objectif : 
-- Ce Laboratoire vise à acquérir les compétences suivantes
-- ========================================================
-- Les commandes DDL
-- Les commandes DML

-- Création d'une base de données
-- la commande CREATE DATABASE nomBase
-- Sélection de la base nouvellement créée.
-- La commande USE nomBase


-----------------------------------------------------------------------
-- Suite Lab5
-- Table FournisseurProduits
 
 -- Vérifier la création de la table avec les données
 
  -- ********************************************************************
 -- Copie entière de la structure d'une table. La table sans les données
 -- Créer la table tblEmployes qui contient la structure de la table 
 -- Employees de la base de données xtremefr

 -- Verifier l'existence de la table tblEmployes
  
 -- version 1 avec TOP 0
 DROP TABLE IF EXISTS tblEmployes
 SELECT TOP 0 *
 INTO tblEmployes
 FROM [xtremefr].[dbo].[Employés]

 -- Verifier l'existence de la table tblEmployes
 EXEC sp_help tblEmployes

 SELECT *
 FROM tblEmployes


 -- version 2 avec une condition fausse

 DROP TABLE IF EXISTS tblEmployes
 SELECT *
 INTO tblEmployes
 FROM [xtremefr].[dbo].[Employés]
 WHERE 0 > 1

 -- Verifier l'existence de la table tblEmployes
 EXEC sp_help tblEmployes

 SELECT *
 FROM tblEmployes

 -- Vérification de la création de la table tblEmployes


 -- Copie paritelle de la structure d'une table. La table sans les données
 -- Créer la table tblEmployes qui contient la structure de la table 
 -- Employees de la base de données xtremefr

 DROP TABLE IF EXISTS tblEmployes

 SELECT TOP 0 *
 INTO tblEmployes
 FROM (
	SELECT
		A.[ID employé] AS IDEmployer
		,A.[ID supérieur] AS IDSuperieur
		,A.Nom AS Nom
		,A.Prénom AS Prenom
		,A.[Date de naissance] AS DateNaissance
		,A.[Date d'embauche] AS DateEmbauche
		,A.Salaire AS Salaire
		,YEAR(A.[Date de naissance]) AS 'Annee de naissance'
		,YEAR(A.[Date d'embauche]) AS 'Annee d''embauche'
	FROM [xtremefr].[dbo].[Employés] A
 ) temp

 -- Verifier l'existence de la table tblEmployes
 
 EXEC sp_help tblEmployes

 SELECT *
 FROM tblEmployes
 
-- Creation de la table tblDepartement
-- Vérification de l'existence de la table tblDepartement avant création


-- Création de la table tblDepartement ayant la structure suivante :
-- ID Dept , entier, clé primaire, non nul, auto incrementé
-- ID departement, identificateur unique, non nul, nouvel identifiant
-- Nom du département, chaine longueur 30, not nul, unique

DROP TABLE IF EXISTS tblDepartement;

CREATE TABLE tblDepartement
(
	IDDept INT PRIMARY KEY NOT NULL IDENTITY(1,1),
	IDDepartement uniqueidentifier NOT NULL DEFAULT NEWID(),
	NomDepartement nvarchar(30) NOT NULL UNIQUE
)

EXEC sp_help tblDepartement;

-- Modification de la structure de la table tblEmployes
-- Ajout d'une clé primaire à la table
ALTER TABLE tblEmployes
	ADD CONSTRAINT PK_IDEmployee PRIMARY KEY (IDEmployer);

-- Ajout de la colonne IDDept à la table employes (tblEmployes)
-- Specs : entier, non nul

ALTER TABLE tblEmployes
	ADD IDDept INT NOT NULL

-- Ajout d'une clé étrangère à la table employés

ALTER TABLE tblEmployes
	ADD CONSTRAINT FK_IDDept FOREIGN KEY (IDDept) REFERENCES tblDepartement(IDDept);

-- Vérifier la création des clés

EXEC sp_help tblEmployes;

-- Suppression d'une clé primaire de la table tblEmployes

ALTER TABLE tblEmployes
	DROP CONSTRAINT PK_IDEmployee;

EXEC sp_help tblEmployes;

-- Ajout d'une clé (primaire) composée Nom, prenom
-- Un clé composée est une clé primaire composée de plusieurs colonnes

ALTER TABLE tblEmployes
	ADD CONSTRAINT PK_NomPrenom PRIMARY KEY (Nom, Prenom)

-- Vérifier la création des clés

EXEC sp_help tblEmployes;

-- Supprimer la clé composée

ALTER TABLE tblEmployes
	DROP CONSTRAINT PK_NomPrenom

-- Recréer la clé primaire
-- Supprimer la clé primaire si elle existe



-- Vérifier la création des clés


-- Modifier la structure d'une table par code
-- Changer le type d'une colonne
-- ATTENTION, ce n'est pas toujours possible après qu'on ait entré des données.
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

-- Vérifier le changement de type

EXEC sp_help tblEmployes;

-- Changer la longueur d'une colonne
-- ATTENTION, il y a un risque de troncature à diminuer la longueur d'une colonne

-- PosteOccupe : nvarchar(30) --> nvarchar(50)

ALTER TABLE tblEmployes
	ALTER COLUMN Nom nvarchar(50);

-- Changer le nom d'une colonne
-- Exemple : faute de frappe ou nom non significatif
-- Renommer Salaire en SalaireAnnuel

EXEC sp_rename 'tblEmployes.Salaire', 'SalaireAnnuel', 'COLUMN';
EXEC sp_help tblEmployes;

-- Ajout de données dans la table Departement
-- On ajoute 4 départements : Informatique, Ressources humaines, Finances, Marketing


-- Ajout de données dans la table employés
-- Règle d'insertion de données dans la colonne IDDept
-- L'employé appartient au département 1 quand son salaire est inférieur ou égal à 30.000 $
-- L'employé appartient au département 2 quand son salaire est compris entre à 30.001 $ et 49.999 $
-- L'employé appartient au département 3 quand son salaire est compris entre à 50.000 $ et 69.999 $
-- L'employé appartient au département 4 quand son salaire est compris entre à 70.000 $ et 99.999 $


-- Vérifier le contenu de la table tblEmployes


-- Écrire une requete qui affiche les employés ainsi que le nom de leurs départements


GO