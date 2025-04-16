-- ==============================================================================
-- Description du cours : Introduction au bases de donn�es
-- Code du cours : 420-212-MV
-- Laboratoire 6
-- Les commandes DDL : UPDATE
-- Les vues : CREATE / DROP  VIEW


-- Objectif : 
-- Ce Laboratoire vise � acqu�rir les comp�tences suivantes
-- ========================================================
-- La commandes DML : UPDATE
-- Les sous requ�tes
-- Les vues

-- Base de donn�es � utiliser : xtremefr
-- Effectuer la copie de toutes les tables de base de donn�es xtremefr
-- Les nouvelles tables seront pr�fix�es de tbl. 
-- Exemple : Achats deviendra tblAchats et ainsi de suite.

-- Utilisation de la base de donn�es xtremefr
USE xtremefr;
GO

-- Cr�ation de la table tblAchats
DROP TABLE IF EXISTS tblAchats;
SELECT * 
INTO tblAchats
FROM [dbo].[Achats];


-- Cr�ation de la table tblAdresseEmployes
DROP TABLE IF EXISTS tblAdresseEmployes;
SELECT * 
INTO tblAdresseEmployes
FROM [dbo].[Adresses des employ�s];


-- Cr�ation de la table tblClients
DROP TABLE IF EXISTS tblClients;
SELECT * 
INTO tblClients
FROM [dbo].[Clients];


-- Cr�ation de la table tblCommandes
DROP TABLE IF EXISTS tblCommandes;
SELECT * 
INTO tblCommandes
FROM [dbo].[Commandes];


-- Cr�ation de la table tblCredits
DROP TABLE IF EXISTS tblCredits;
SELECT * 
INTO tblCredits
FROM [dbo].[Cr�dits];


-- Cr�ation de la table tblDetailCommandes
DROP TABLE IF EXISTS tblDetailCommandes;
SELECT * 
INTO tblDetailCommandes
FROM [dbo].[D�tails des commandes];


-- Cr�ation de la table tblEmployes
DROP TABLE IF EXISTS tblEmployes;
SELECT * 
INTO tblEmployes
FROM [dbo].[Employ�s];


-- Cr�ation de la table tblFournisseurs
DROP TABLE IF EXISTS tblFournisseurs;
SELECT * 
INTO tblFournisseurs
FROM [dbo].[Fournisseurs];


-- Cr�ation de la table tblRegions
DROP TABLE IF EXISTS tblRegions;
SELECT * 
INTO tblRegions
FROM [dbo].[R�gions];


-- Cr�ation de la table tblProduits
DROP TABLE IF EXISTS tblProduits;
SELECT * 
INTO tblProduits
FROM [dbo].[Produits];


-- Cr�ation de la table tblTypeProduit
DROP TABLE IF EXISTS tblTypeProduit;
SELECT * 
INTO tblTypeProduit
FROM [dbo].[Types de produit];

-- *****************************************************************************************************************************************
-- Les requ�tes MISE � JOUR
-- *****************************************************************************************************************************************

-- Mise � jour de donn�es. 
-- Utilisation de la commande UPDATE
-- Mise � jour globale
-- Syntaxe de base de la commande UPDATE
-- UPDATE <nomtable>
-- SET <colonne> = <valeur>

-- Mise � jour conditionnelle
-- Syntaxe avec la claude WHERE de la commande UPDATE
-- UPDATE <nomtable>
-- SET <colonne> = <valeur>
-- WHERE <condition>

-- ****************************************************************************************************************************************
-- A T T E N T I O N - La commande UPDATE EST DANGEREUSE - Elle ne peut �tre annul�e. (UNDO)
-- Toutes les requ�tes de mise � jour doivent suivre la d�marche � trois �tapes :
-- 1- Identification des enregistrements � mettre � jour (une instruction SELECT avec ou sans condition)
-- 2- Mise � jour � proprement parler (Une instruction UPDATE avec ou sans condition)
-- 3- V�rification de la mise � jour (une instruction SELECT avec la condition appropri�e pour v�rifier que la mise � jour UPDATE a produit le r�sultat attendu)
-- ****************************************************************************************************************************************
-- ****************************************************************************************************************************************
-- Requ�te 1
-- *********
-- �crire une requ�te qui effectue la mise � jour de la copie de la table clients en rempla�ant les codes postaux qu'on ne conna�t pas par 'NA'
-- D�marche : 
-- �tape 1 : S�lectionner les clients dont on ne conna�t pas le code postal et V�rifier que le r�sultat obtenu est conforme � l'�nonc�

SELECT *
FROM [dbo].[Clients]
WHERE [Code postal] IS NULL;

-- Etape 2 : Effectuer la mise � jour

UPDATE [dbo].[Clients]
SET [Code postal] = 'N/A'
WHERE [Code postal] IS NULL;

-- �tape 3 : V�riifier l'exactitude de la mise � jour

SELECT *
FROM [dbo].[Clients]
WHERE [Code postal] LIKE('N/A');

-- ****************************************************************************************************************************************
-- Requ�te 2
-- *********
-- Ecrire une requ�te qui met � jour le prix du produit dont le type est  7. Le prix sera major� de 3%.
-- Votre code ici

-- �tape 1 - Identification des enregistrements � mettre � jour (une instruction SELECT)

SELECT *
FROM [dbo].[tblProduits]
WHERE [ID type de produit] = 7;

-- �tape 2 - Mise � jour

UPDATE [dbo].[tblProduits]
SET [Prix conseill�] = [Prix conseill�] * 1.03
WHERE [ID type de produit] = 7;

-- �tape 3 - V�rification

SELECT *
FROM [dbo].[tblProduits]
WHERE [ID type de produit] = 7;

-- ****************************************************************************************************************************************
-- Requ�te 3
-- *********
-- Ecrire une requ�te qui met � jour la couleur des produits dont le type est 8 du fournisseur 5. La nouvelle couleur est noire .
-- Votre code ici

-- �tape 1- Identification des enregistrements � mettre � jour (une instruction SELECT)

SELECT *
FROM [dbo].[tblProduits]
WHERE
	[ID type de produit] = 8 AND
	[ID fournisseur] = 5

-- �tape 2 - Mise � jour

UPDATE [dbo].[tblProduits]
SET [Couleur] = 'Noir'
WHERE
	[ID type de produit] = 8 AND
	[ID fournisseur] = 5;

-- �tape 3 - V�rification

SELECT *
FROM [dbo].[tblProduits]
WHERE
	[ID type de produit] = 8 AND
	[ID fournisseur] = 5

-- ****************************************************************************************************************************************
-- Requ�te 4
-- *********
-- �crire une requ�te qui met � jour la copie de la table clients en remplacant la colonne 'adresse 2' qu'on ne conna�t pas par 'inconnu'
-- D�marche
-- �tape 1 : S�lectionner les clients dont on ne conna�t pas le code postal et V�rifier que le r�sultat obtenu est conforme � l'�nonc�
SELECT *
FROM [dbo].[Clients]
WHERE [Adresse 2] IS NULL;

-- Etape 2 : Effectuer la mise � jour

UPDATE [dbo].[Clients]
SET [Adresse 2] = 'inconnu'
WHERE [Adresse 2]  IS NULL;

-- �tape 3 : V�riifier l'exactitude de la mise � jour

SELECT *
FROM [dbo].[Clients]
WHERE [Adresse 2] = 'inconnu';

-- ****************************************************************************************************************************************
-- Requ�te 5
-- *********
-- Mise � jour multiple
-- �crire une requ�te qui met � jour la copie de la table Achats.
-- Lorsque les unit�s en commande sont nulles, le num�ro de commamde est 0 et les dates de commande et r�ception sont la valeur minimum par d�faut pour une date : '0001-01-01 00:00:00'.

-- D�marche
-- �tape 1 : S�lectionner les achats dont les unit�s en commande sont nulles 

SELECT *
FROM [dbo].[tblAchats]
WHERE [Unit�s en commande] = 0

-- Etape 2 : Effectuer la mise � jour

UPDATE [dbo].[tblAchats]
SET [Num�ro de commande] = 0,
	[Date de commande] = '0001-01-01',
	[Date de r�ception pr�vue] = '0001-01-01'
WHERE [Unit�s en commande] = 0

-- �tape 3 : V�riifier l'exactitude de la mise � jour

SELECT *
FROM [dbo].[tblAchats]
WHERE [Unit�s en commande] = 0

-- ****************************************************************************************************************************************
-- Requ�te 6
-- *********
-- �crire une requ�te qui cr�e une table tblPreprietaires qui contient les propri�taires.
-- La table contrient les colonnes suivantes :
-- L'IdClient
-- Le nom du client
-- Le pr�nom du contact
-- Le nom du contact
-- Le poste occup�
-- Le titre
-- Le sexe
-- Les ventes de l'ann�e derniere
-- Le courriel
-- Le t�l�phone
-- Le pays

DROP TABLE iF EXISTS tblProprietaires;
SELECT 
	[ID client],
	[Nom du client],
	[Pr�nom du contact],
	[Nom du contact],
	[Poste occup�],
	[Titre],
	CASE
				WHEN [Titre] IN('M.','Mr','Mrs') THEN 'Garcon'
				WHEN [Titre] IN('Melle', 'Mme') THEN 'Fille'
			ELSE 'Autre'
		END Sexe,
	[Ventes de l'ann�e derni�re],
	[Adresse �lectronique],
	[T�l�phone],
	[Pays]
INTO tblProprietaires
FROM [dbo].[tblClients]
WHERE [Poste occup�] LIKE('Propri�taire')

-- V�rifier la table des propri�taires nouvellement cr��e.

SELECT *
FROM tblProprietaires

-- ****************************
-- **** Cr�ation d'une Vue ****
-- ****************************
-- Une vue est un objet de base de donn�es qui est une requ�te persistante, une table virtuelle.
-- Elle est comparable � une table et s'utilise comme tel.


-- Syntaxe de la cr�ation d'une vue
-- CREATE VIEW <nomVue>
-- AS
-- SELECT <liste_colonnes> FROM <table>

-- ATTENTION
-- Une instruction CREATE/DROP VIEW doit se terminer par GO qui veut dire : "EXECUTION" explicite.

-- La requ�te peut �tre simple ou complexe.

-- ****************************************************************************************************************************************
-- Requ�te 7
-- *********
-- Cr�er une vue vEmployeeSalaire qui affiche la liste des salaires des employ�s
-- Elle contient les informations suivantes concernant les employ�s:
-- FullName, Position, Salary
-- Note : FullName est la concat�nation du Nom et du Pr�nom

DROP VIEW IF EXISTS vEmployeSalaire;
Go

CREATE VIEW vEmployeSalaire
AS
SELECT 
	Concat([Nom],' ', [Pr�nom]) AS NomComplet
	,[Poste occup�]
	,[Salaire]
FROM [dbo].[tblEmployes]
GO
-- V�rifer la cr�ation de la vue

Select *
FROM vEmployeSalaire

-- ****************************************************************************************************************************************
-- Requ�te 8
-- *********
-- Cr�er une vue vAdresseCompleteEmployes qui contient l'adresse compl�te des employ�s.
-- Le nom complet de l'employ�
-- Le poste occup�
-- L'age de l'employ�
-- L'anciennet� de l'employ�
-- Le salaire
-- Le t�l�phone personnel
-- L'adresse
-- La ville
-- La r�gion
-- Le code postal
-- Le pays



-- V�rification de la vue vAdresseCompleteEmployes

-- ****************************************************************************************************************************************
-- Requ�te 9
-- *********
-- Cr�er une vue qui affiche le total cr�dit accord� � chaque client.
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
	CL.[ID client] = CR.[ID cr�dit client]
GO
-- V�rification de la vue

SELECT *
FROM vCreditClients

-- Cr�er une table tblCreditClients qui contient le total du cr�dit accord� � chaque client � partir de la vue pr�c�dente.

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
WHERE [Unit�s en stock] < 75

UPDATE [dbo].[tblProduits]
	SET [Prix conseill�] = [Prix conseill�] * 0.95
FROM 
	[dbo].[tblProduits] P,
	[dbo].[tblAchats] A
WHERE 
	P.[ID produit] = A.[ID produit] AND
	[Unit�s en stock] < 75
/*     ou juste
WHERE [ID produit] IN
	(
	SELECT [ID produit]
	FROM tblAchats
	WHERE [Unit�es en stock] < 75
	)
*/

SELECT P.* 
FROM 
	[dbo].[tblProduits] P,
	[dbo].[tblAchats] A
WHERE 
P.[ID produit] = A.[ID produit] AND
A.[Unit�s en stock] < 75
