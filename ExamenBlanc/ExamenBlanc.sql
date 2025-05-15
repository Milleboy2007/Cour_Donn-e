/***
Examen blanc


-- Question 1 : Création de requête
-- ********************************

Écrire une requête affiche les employés qui travaillent en ingérierie, c'est-à-dire que le titre de leur poste (JobTitle) contient "Engineer" et qui sont des femmes.
On affichera : 
	- La civilité (Title), 
	- le nom (LastName), 
	- le prénom (FirstName), 
	- le titre du poste (JobTitle), 
	- Genre (Gender)

-- Votre code ici */

SELECT
	P.[Title] AS Civilité
	,P.LastName AS Nom
	,P.[FirstName] AS Prénom
	,E.JobTitle
	,E.Gender
FROM
	[dbo].[Employee] E
	,[dbo].[Person] P
WHERE
	E.BusinessEntityID = P.BusinessEntityID AND
	E.[JobTitle] LIKE('%Engineer%') AND
	E.[Gender] IN('F')

/* ---------------------------------------------------------------------------------------------------------
-- Question 2 : Création de vue
-- ****************************

Créer une vue vAdresseCompleteEmploye qui contient l'adresse complète des employés
La vue contient :

	- Le numéro d'entité (BusinessEntityID)
	- La civilité (Title),
	- Le nom de L'employé (LastName),
	- Le prénom de l'employé (FirstName),
	- L'adresse (AddressLine1),
	- La ville (City) ,
	- Le code postal (PostalCode) ,
	- Le type d'adresse (Name) TypeAdresse,
	- La province, région (Name)	ProvinceRegion,
	- L'Adresse email,
	- Le téléphone,
	- Le type de téléphone (Name) TypeTelephone

-- Votre code ici -- */

DROP VIEW IF EXISTS vAdresseCompleteEmploye;
GO

CREATE VIEW vAdresseCompleteEmploye
AS
SELECT
	P.[BusinessEntityID] AS ID
	,P.Title AS Civilité
	,P.LastName AS Nom
	,P.FirstName AS Prénom
	,A.AddressLine1 AS Adresse
	,A.City AS Ville
	,A.PostalCode AS 'Code Postal'
	,AT.Name AS 'Type D''adresse'
	,SP.Name AS Province
	,E.EmailAddress AS 'Adresse Mail'
	,PP.PhoneNumber AS 'Numéro Téléphone'
	,PNT.Name AS 'Type de Téléphone'
FROM
	[dbo].[Person] P
	,[dbo].[Address] A
	,[dbo].[AddressType] AT
	,[dbo].[StateProvince] SP
	,[dbo].[EmailAddress] E
	,[dbo].[PersonPhone] PP
	,[dbo].[PhoneNumberType] PNT
WHERE
	P.BusinessEntityID = E.BusinessEntityID AND
	E.BusinessEntityID = PP.BusinessEntityID AND
	PP.PhoneNumberTypeID = PNT.PhoneNumberTypeID AND
	A.AddressID = AT.AddressTypeID AND
	SP.StateProvinceID = A.StateProvinceID
GO
/*
Afficher le contenu de la vue. La liste sera triée par le nom de l'employé.

-- Votre code ici -- */

SELECT *
FROM vAdresseCompleteEmploye


/* -----------------------------------------------------------------------------------------------
-- Question 3 : Création de table
-- ******************************
A-
Créer dans cette nouvelle table nommée tblEmployeInfo.
Cette table contiendra les informations suivantes :
	- Le numéro d'entité (BusinessEntityID)
	- Le numéro d'identité national (NationalIDNumber)
	- La civilité (Title),
	- Le nom de L'employé (LastName),
	- le poste de l'employé (JobTitle)
	- Le genre (Gender)
	- Le statut marital (MaritalStatus)
	- La date d'embauche (HireDate)
	- Les heures de vacances (VcacationHours)
	- Les heures de maladie (SickLeaveHours)

-- Votre code ici -- */

DROP TABLE IF EXISTS tblEmployeInfo
GO

SELECT
	E.BusinessEntityID AS ID
	,E.NationalIDNumber AS 'Numéro D''identité National'
	,P.Title AS Civilité
	,P.LastName AS 'Nom'
	,E.JobTitle AS Poste
	,E.Gender AS Genre
	,E.MaritalStatus AS 'Statut Martial'
	,E.HireDate AS 'Date D''embauche'
	,E.VacationHours AS 'Heure de Vacances'
	,E.SickLeaveHours AS 'Heure de Maladie'
INTO 
	tblEmployeInfo
FROM
	[dbo].[Employee] E
	,[dbo].[Person] P
WHERE
	E.BusinessEntityID = P.BusinessEntityID

/*
B- Vérifier la création de cette nouvelle table dans le nouvelle base de données.

-- Votre code ici --*/

SELECT *
FROM tblEmployeInfo

/*
-- -----------------------------------------------------------------------------------------------------------
C- Modifier la table tblEmployeInfo pour rajouter une clé primaire sur la colonne :
	- Le numéro d'entité (BusinessEntityID)

-- Votre code ici --*/

ALTER TABLE tblEmployeInfo
	ADD PRIMARY KEY (ID)
GO

/*
D - Modifier la table tblEmployeInfo pour rajouter les colonnes suivantes :
	- GenreComplet de type texte de longueur 20
	- StatutMaritalComplet de type texte, de longueur 20
	- JoursMaladie de type nombre décimal
	- JoursVacances de type nombre décimal

-- Votre code ici -- */

ALTER TABLE tblEmployeInfo
	DROP COLUMN IF EXISTS GenreComplet
ALTER TABLE tblEmployeInfo
	DROP COLUMN IF EXISTS StatutMaritalComplet
ALTER TABLE tblEmployeInfo
	DROP COLUMN IF EXISTS JoursMaladie
ALTER TABLE tblEmployeInfo
	DROP COLUMN IF EXISTS JoursVacances
GO

ALTER TABLE tblEmployeInfo
	ADD GenreComplet nvarChar(20),
		StatutMaritalComplet nvarChar(20),
		JoursMaladie float,
		JoursVacances float
GO

/* --------------------------------------------------------------------------------------------------------------
E- Mise à jour de données

Effectuez les mises à jour suivantes sur la table tblEmployeInfo :
	- Mettre à jour la colonne StatutMaritalComplet avec 'Single' lorsque MaritalStatus est 'S' et 'Married' lorsque le MaritalStatus est 'M'
	- Mettre à jour la colonne GenreComplet avec 'Male' lorsque Gender est 'M' et 'Female' lorsque Gender est 'F'
	- Mettre à jour la colonne JoursMaladie à partir de la colonne SickLeaveHours
	- Mettre à jour la colonne JoursVacances à partir de la colonne VacationHours

Note : Pour les deux dernières mises à jour, il s’agit de convertir les heures de maladie (SickLeaveHours) et de vacances (VacationHours) en jours de maladie et de vacances. 
Une journée de travail comporte 7.5h.

-- Votre code ici --*/

UPDATE tblEmployeInfo
	SET StatutMaritalComplet = (
		CASE
			WHEN [Statut Martial] = 'S' THEN 'Single'
			WHEN [Statut Martial] = 'M' THEN 'Married'
		ELSE [Statut Martial]
		END
	)
GO

UPDATE tblEmployeInfo
	SET GenreComplet = (
		CASE 
			WHEN [Genre] = 'M' THEN 'Male'
			WHEN [Genre] = 'F' THEN 'Female'
		ELSE [Genre]
		END
		)
GO

UPDATE tblEmployeInfo
	SET [JoursMaladie] = DAY([Heure de Maladie])
GO

UPDATE tblEmployeInfo
	SET [JoursVacances] = DAY([Heure de Vacances])
GO

SELECT *
FROM tblEmployeInfo

/* --------------------------------------------------------------------------------------------------------------
-- Question 4 : Création de tables
-- *******************************

Créer les tables suivantes :
	- Une table qui contient des marques de voitures (tblMarques)
	- Une table qui contient les voitures (tblVoitures)
	- Une table qui contient les propriétaires des voitures (tblProprietaires)

Structure des tables
La table tblMarques
	- NoMarque entier clé primaire auto incrémenté
	- NomMarque chaine de caractères longueur 20 doit contenir une valeur
	- PaysMarque chaine de caractères longueur 20

La table tblVoitures
	- NoSerie entier cle primaire auto incrementé
	- ModeleVoiture Chaine de caracteres long 20 doit contenir une valeur
	- CouleurVoiture Chaine de long 20 
	- Motorisation
	- TypeVoiture
	- NoMarque Cle étrangere

La table tblProprietairesVoiture
	- NoProprietaire entier cle primaire auto inc
	- NomProprietaire Chaine de caractere 25
	- PrenomProprietaire Chaine de caractere 25
	- NoSerie entier cle étrangere

-- Votre code ici -- */

DROP TABLE IF EXISTS tblProprietairesVoiture
GO
DROP TABLE IF EXISTS tblVoitures
GO
DROP TABLE IF EXISTS tblMarques
GO

CREATE TABLE tblMarques (
	NoMarque int PRIMARY KEY IDENTITY(1,1),
	NomMarque nvarChar(20) NOT NULL,
	PaysMarque nvarChar(20)
);
GO

CREATE TABLE tblVoitures (
	NoSerie int PRIMARY KEY IDENTITY(1,1),
	ModeleVoiture nvarChar(20) NOT NULL,
	CouleurVoiture nvarChar(20),
	Motorisation nvarChar(20),
	TypeVoiture nvarChar(20),
	NoMarque int FOREIGN KEY REFERENCES tblMarques(NoMarque)
);
GO

CREATE TABLE tblProprietairesVoiture (
	NoProprietaire int PRIMARY KEY IDENTITY(1,1),
	NomProprietaire nvarChar(25),
	PrenomProprietaire nvarChar(25),
	NoSerie int FOREIGN KEY REFERENCES tblVoitures(NoSerie)
);
GO

/* --------------------------------------------------------------------------------------------------------------
-- Question 5 : Insertion de données
-- *********************************

Écrire le code pour insérer les données suivantes dans les tables créées à la Question 4

tblMarques
NoMarque	NomMarque		Pays
1			BMW				Allemagne
2			Mercedes0Benz	Allemagne
3			Lexus			Japon

tblVoitures
NoSerie		ModeleVoiture	ColuleurVoiture		Motorisation	TypeVoiture	NoMarque
1			750 iL			Gris				V8				Berline		1
2			Maybach			Bleu/blanc			V12				Limousine	2
3			S500			Noir				V8				Berline		2


tblProprietaires
NoProprietaire	NomProprietaire	PrenomProprietaire	NoSerie
1				Doe				John				1
2				Doe				Jane				3
3				Blow			Joe					1

-- Votre code ici -- */

INSERT INTO tblMarques
VALUES
	('BMW','Allemagne'),
	('MercedesBenz', 'Allemagne'),
	('Lexus','Japon')
GO
SELECT * FROM tblMarques

INSERT INTO tblVoitures
VALUES
	('750 iL', 'Gris', 'V8', 'Berline', 1),
	('Maybach', 'Bleu/Blanc', 'V12', 'Limousine', 2),
	('S500', 'Noir', 'V8', 'Berline', 2)
GO
SELECT * FROM tblVoitures

INSERT INTO tblProprietairesVoiture
VALUES
	('Doe', 'John', 1),
	('Doe', 'Jane', 3),
	('Blow', 'Joe', 1)
GO
SELECT * FROM tblProprietairesVoiture

/******************************************** FIN DE L'EXAMEN ********************************************/
