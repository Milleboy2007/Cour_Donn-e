-- ==============================================================================
-- Description du cours : Introduction au bases de données
-- Code du cours : 420-212-MV
-- Laboratoire 6
-- Les commandes DDL : UPDATE
-- Les vues : CREATE / DROP  VIEW


-- Objectif : 
-- Ce Laboratoire vise à acquérir les compétences suivantes
-- ========================================================
-- La commandes DML : UPDATE
-- Les sous requêtes
-- Les vues

-- Base de données à utiliser : xtremefr
-- Effectuer la copie de toutes les tables de base de données xtremefr
-- Les nouvelles tables seront préfixées de tbl. 
-- Exemple : Achats deviendra tblAchats et ainsi de suite.

-- Utilisation de la base de données xtremefr
USE xtremefr;
GO

-- Création de la table tblAchats
DROP TABLE IF EXISTS tblAchats;
SELECT * 
INTO tblAchats
FROM [dbo].[Achats];


-- Création de la table tblAdresseEmployes
DROP TABLE IF EXISTS tblAdresseEmployes;
SELECT * 
INTO tblAdresseEmployes
FROM [dbo].[Adresses des employés];


-- Création de la table tblClients
DROP TABLE IF EXISTS tblClients;
SELECT * 
INTO tblClients
FROM [dbo].[Clients];


-- Création de la table tblCommandes
DROP TABLE IF EXISTS tblCommandes;
SELECT * 
INTO tblCommandes
FROM [dbo].[Commandes];


-- Création de la table tblCredits
DROP TABLE IF EXISTS tblCredits;
SELECT * 
INTO tblCredits
FROM [dbo].[Crédits];


-- Création de la table tblDetailCommandes
DROP TABLE IF EXISTS tblDetailCommandes;
SELECT * 
INTO tblDetailCommandes
FROM [dbo].[Détails des commandes];


-- Création de la table tblEmployes
DROP TABLE IF EXISTS tblEmployes;
SELECT * 
INTO tblEmployes
FROM [dbo].[Employés];


-- Création de la table tblFournisseurs
DROP TABLE IF EXISTS tblFournisseurs;
SELECT * 
INTO tblFournisseurs
FROM [dbo].[Fournisseurs];


-- Création de la table tblRegions
DROP TABLE IF EXISTS tblRegions;
SELECT * 
INTO tblRegions
FROM [dbo].[Régions];


-- Création de la table tblProduits
DROP TABLE IF EXISTS tblProduits;
SELECT * 
INTO tblProduits
FROM [dbo].[Produits];


-- Création de la table tblTypeProduit
DROP TABLE IF EXISTS tblTypeProduit;
SELECT * 
INTO tblTypeProduit
FROM [dbo].[Types de produit];

-- *****************************************************************************************************************************************
-- Les requêtes MISE à JOUR
-- *****************************************************************************************************************************************

-- Mise à jour de données. 
-- Utilisation de la commande UPDATE
-- Mise à jour globale
-- Syntaxe de base de la commande UPDATE
-- UPDATE <nomtable>
-- SET <colonne> = <valeur>

-- Mise à jour conditionnelle
-- Syntaxe avec la claude WHERE de la commande UPDATE
-- UPDATE <nomtable>
-- SET <colonne> = <valeur>
-- WHERE <condition>

-- ****************************************************************************************************************************************
-- A T T E N T I O N - La commande UPDATE EST DANGEREUSE - Elle ne peut être annulée. (UNDO)
-- Toutes les requêtes de mise à jour doivent suivre la démarche à trois étapes :
-- 1- Identification des enregistrements à mettre à jour (une instruction SELECT avec ou sans condition)
-- 2- Mise à jour à proprement parler (Une instruction UPDATE avec ou sans condition)
-- 3- Vérification de la mise à jour (une instruction SELECT avec la condition appropriée pour vérifier que la mise à jour UPDATE a produit le résultat attendu)
-- ****************************************************************************************************************************************
-- ****************************************************************************************************************************************
-- Requête 1
-- *********
-- Écrire une requête qui effectue la mise à jour de la copie de la table clients en remplaçant les codes postaux qu'on ne connaît pas par 'NA'
-- Démarche : 
-- Étape 1 : Sélectionner les clients dont on ne connaît pas le code postal et Vérifier que le résultat obtenu est conforme à l'énoncé

SELECT *
FROM [dbo].[Clients]
WHERE [Code postal] IS NULL;

-- Etape 2 : Effectuer la mise à jour

UPDATE [dbo].[Clients]
SET [Code postal] = 'N/A'
WHERE [Code postal] IS NULL;

-- Étape 3 : Vériifier l'exactitude de la mise à jour

SELECT *
FROM [dbo].[Clients]
WHERE [Code postal] LIKE('N/A');

-- ****************************************************************************************************************************************
-- Requête 2
-- *********
-- Ecrire une requête qui met à jour le prix du produit dont le type est  7. Le prix sera majoré de 3%.
-- Votre code ici

-- Étape 1 - Identification des enregistrements à mettre à jour (une instruction SELECT)

SELECT *
FROM [dbo].[tblProduits]
WHERE [ID type de produit] = 7;

-- Étape 2 - Mise à jour

UPDATE [dbo].[tblProduits]
SET [Prix conseillé] = [Prix conseillé] * 1.03
WHERE [ID type de produit] = 7;

-- Étape 3 - Vérification

SELECT *
FROM [dbo].[tblProduits]
WHERE [ID type de produit] = 7;

-- ****************************************************************************************************************************************
-- Requête 3
-- *********
-- Ecrire une requête qui met à jour la couleur des produits dont le type est 8 du fournisseur 5. La nouvelle couleur est noire .
-- Votre code ici

-- Étape 1- Identification des enregistrements à mettre à jour (une instruction SELECT)

SELECT *
FROM [dbo].[tblProduits]
WHERE
	[ID type de produit] = 8 AND
	[ID fournisseur] = 5

-- Étape 2 - Mise à jour

UPDATE [dbo].[tblProduits]
SET [Couleur] = 'Noir'
WHERE
	[ID type de produit] = 8 AND
	[ID fournisseur] = 5;

-- Étape 3 - Vérification

SELECT *
FROM [dbo].[tblProduits]
WHERE
	[ID type de produit] = 8 AND
	[ID fournisseur] = 5

-- ****************************************************************************************************************************************
-- Requête 4
-- *********
-- Écrire une requête qui met à jour la copie de la table clients en remplacant la colonne 'adresse 2' qu'on ne connaît pas par 'inconnu'
-- Démarche
-- Étape 1 : Sélectionner les clients dont on ne connaît pas le code postal et Vérifier que le résultat obtenu est conforme à l'énoncé
SELECT *
FROM [dbo].[Clients]
WHERE [Adresse 2] IS NULL;

-- Etape 2 : Effectuer la mise à jour

UPDATE [dbo].[Clients]
SET [Adresse 2] = 'inconnu'
WHERE [Adresse 2]  IS NULL;

-- Étape 3 : Vériifier l'exactitude de la mise à jour

SELECT *
FROM [dbo].[Clients]
WHERE [Adresse 2] = 'inconnu';

-- ****************************************************************************************************************************************
-- Requête 5
-- *********
-- Mise à jour multiple
-- Écrire une requête qui met à jour la copie de la table Achats.
-- Lorsque les unités en commande sont nulles, le numéro de commamde est 0 et les dates de commande et réception sont la valeur minimum par défaut pour une date : '0001-01-01 00:00:00'.

-- Démarche
-- Étape 1 : Sélectionner les achats dont les unités en commande sont nulles 

SELECT *
FROM [dbo].[tblAchats]
WHERE [Unités en commande] = 0

-- Etape 2 : Effectuer la mise à jour

UPDATE [dbo].[tblAchats]
SET [Numéro de commande] = 0,
	[Date de commande] = '0001-01-01',
	[Date de réception prévue] = '0001-01-01'
WHERE [Unités en commande] = 0

-- Étape 3 : Vériifier l'exactitude de la mise à jour

SELECT *
FROM [dbo].[tblAchats]
WHERE [Unités en commande] = 0

-- ****************************************************************************************************************************************
-- Requête 6
-- *********
-- Écrire une requête qui crée une table tblPreprietaires qui contient les propriétaires.
-- La table contrient les colonnes suivantes :
-- L'IdClient
-- Le nom du client
-- Le prénom du contact
-- Le nom du contact
-- Le poste occupé
-- Le titre
-- Le sexe
-- Les ventes de l'année derniere
-- Le courriel
-- Le téléphone
-- Le pays

DROP TABLE iF EXISTS tblProprietaires;
SELECT 
	[ID client],
	[Nom du client],
	[Prénom du contact],
	[Nom du contact],
	[Poste occupé],
	[Titre],
	CASE
				WHEN [Titre] IN('M.','Mr','Mrs') THEN 'Garcon'
				WHEN [Titre] IN('Melle', 'Mme') THEN 'Fille'
			ELSE 'Autre'
		END Sexe,
	[Ventes de l'année dernière],
	[Adresse électronique],
	[Téléphone],
	[Pays]
INTO tblProprietaires
FROM [dbo].[tblClients]
WHERE [Poste occupé] LIKE('Propriétaire')

-- Vérifier la table des propriétaires nouvellement créée.

SELECT *
FROM tblProprietaires

-- ****************************
-- **** Création d'une Vue ****
-- ****************************
-- Une vue est un objet de base de données qui est une requête persistante, une table virtuelle.
-- Elle est comparable à une table et s'utilise comme tel.


-- Syntaxe de la création d'une vue
-- CREATE VIEW <nomVue>
-- AS
-- SELECT <liste_colonnes> FROM <table>

-- ATTENTION
-- Une instruction CREATE/DROP VIEW doit se terminer par GO qui veut dire : "EXECUTION" explicite.

-- La requête peut être simple ou complexe.

-- ****************************************************************************************************************************************
-- Requête 7
-- *********
-- Créer une vue vEmployeeSalaire qui affiche la liste des salaires des employés
-- Elle contient les informations suivantes concernant les employés:
-- FullName, Position, Salary
-- Note : FullName est la concaténation du Nom et du Prénom

DROP VIEW IF EXISTS vEmployeSalaire;
Go

CREATE VIEW vEmployeSalaire
AS
SELECT 
	Concat([Nom],' ', [Prénom]) AS NomComplet
	,[Poste occupé]
	,[Salaire]
FROM [dbo].[tblEmployes]
GO
-- Vérifer la création de la vue

Select *
FROM vEmployeSalaire

-- ****************************************************************************************************************************************
-- Requête 8
-- *********
-- Créer une vue vAdresseCompleteEmployes qui contient l'adresse complète des employés.
-- Le nom complet de l'employé
-- Le poste occupé
-- L'age de l'employé
-- L'ancienneté de l'employé
-- Le salaire
-- Le téléphone personnel
-- L'adresse
-- La ville
-- La région
-- Le code postal
-- Le pays



-- Vérification de la vue vAdresseCompleteEmployes

-- ****************************************************************************************************************************************
-- Requête 9
-- *********
-- Créer une vue qui affiche le total crédit accordé à chaque client.
-- Nom de la vue : vCreditClients

DROP VIEW IF EXISTS vCreditClients
GO

CREATE VIEW vCreditClients
AS
SELECT
	[Nom du client]
	,[Montant]
FROM
	[dbo].[tblClients] CL,
	[dbo].[tblCredits] CR
WHERE
	CL.[ID client] = CR.[ID crédit client]
GO
-- Vérification de la vue

SELECT *
FROM vCreditClients

-- Créer une table tblCreditClients qui contient le total du crédit accordé à chaque client à partir de la vue précédente.

DROP TABLE IF EXISTS tblCreditClients
SELECT 
	[Nom du client]
	,SUM([Montant]) AS TotalCredit
INTO tblCreditClients
FROM vCreditClients
GROUP BY
	[Nom du client]

-- Affichage du contenu de la table tblCreditClients
SELECT *
FROM tblCreditClients



SELECT *
FROM [dbo].[tblAchats]
WHERE [Unités en stock] < 75

UPDATE [dbo].[tblProduits]
	SET [Prix conseillé] = [Prix conseillé] * 0.95
FROM 
	[dbo].[tblProduits] P,
	[dbo].[tblAchats] A
WHERE 
	P.[ID produit] = A.[ID produit] AND
	[Unités en stock] < 75
/*     ou juste
WHERE [ID produit] IN
	(
	SELECT [ID produit]
	FROM tblAchats
	WHERE [Unitées en stock] < 75
	)
*/

SELECT P.* 
FROM 
	[dbo].[tblProduits] P,
	[dbo].[tblAchats] A
WHERE 
P.[ID produit] = A.[ID produit] AND
A.[Unités en stock] < 75
