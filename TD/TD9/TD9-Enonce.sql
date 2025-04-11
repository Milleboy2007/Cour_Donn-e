/*****************************************************************************************
## =======================================
## Travaux dirigés : Création de tables 
## En utilisant les commandes DML de SQL
## INSERT. UPDATE, DELETE 
## =======================================
******************************************************************************************/

-- Ce TD doit être réalisé dans une nouvelle base de données.
-- Créer une nouvellle base de données
-- Nom de la base : TD9
-- Se positionner dans cette nouvelle base pour réaliser le travail

-- *************** A T T E N T I O N ***************
-- ****** REGLES D'INTÉGRITÉ RÉFÉRENCIELLES ********

-- CRÉATION DE TABLE
-- La table contenant la clé primaire doit être créée avant la table contenant la clé étrangère
-- La clé primaire doit exister avant la création de la clé étrangère

-- INSERTION DE DONNÉES
-- Les données de la tables 'maitre' doivent être insérées avant celles de la table "détail"

-- SUPPRESSION DE DONNÉES
-- Les données de la table "détail" celle qui contient la clé étrangère doivent être supprimées 
-- AVANT celles de la table contenant la clé primaire sauf si l'option CASCADE est utilisée

-- SUPPRESSION DE LA TABLE
-- La table "détail" doit être supprimée AVANT la table 'MAITRE'


/* ## Énoncé

## Partie I : Création d'une base de données
--===========================================
-- Vérifer l'existence de la base de données avant sa création*/

DROP DATABASE IF EXISTS TD9;
CREATE DATABASE TD9;

-- Se positionner dans la base de données

USE TD9;


/*## Partie II : Création de tables
## ==============================

## Écrire une requête qui crée la table tblEmployes en respectant les spécifications ci-dessous*/
/***********************************************************************************************
Table "tblEmployes" :

EmpID (Entier - Clé primaire)
Nom (Chaîne de caractères)
Prenom (Chaîne de caractères)
DateNaissance (Date)
Salaire (monétaire)
************************************************************************************************/
-- Votre code ici 

DROP TABLE IF EXISTS tblEmployes;
CREATE TABLE tblEmployes(
	EmpID int IDENTITY(1, 1) PRIMARY KEY NOT NULL,
	Nom nvarchar(15) NOT NULL,
	Prenom nvarchar(15) NOT NULL,
	DateNaissance date,
	Salaire money
);

EXEC sp_help tblEmployes;

/***********************************************************************************************
## Écrire une requête qui crée la table tblProjets en respectant les spécifications ci-dessous

Table "tblProjets" :

ProjetID (Entier - Clé primaire)
NomProjet (Chaîne de caractères)
DateDebut (Date)
DateFin (Date)
ChefProjetID (Entier - Clé étrangère faisant référence à l'ID de l'employe)
************************************************************************************************/
-- Votre code ici 

DROP TABLE IF EXISTS tblProjets;
CREATE TABLE tblProjets(
	ProjetID INT IDENTITY(101, 1) PRIMARY KEY NOT NULL,
	NomProjet nvarchar(25) NOT NULL,
	DateDebut date,
	DateFin date,
	ChefProjetID INT FOREIGN KEY REFERENCES tblEmployes(EmpID) NOT NULL
);

EXEC sp_help tblProjets;
/***********************************************************************************************
## Écrire une requête qui crée la table tblClients en respectant les spécifications ci-dessous

Table "tblClients" :

ClientID (Entier - Clé primaire)
NomClient (Chaîne de caractères)
Adresse (Chaîne de caractères)
Email (Chaîne de caractères)
Telephone (Chaîne de caractères)
************************************************************************************************/
-- Votre code ici 

DROP TABLE IF EXISTS tblClients;
CREATE TABLE tblClients(
	ClientID INT IDENTITY(201, 1) PRIMARY KEY NOT NULL,
	NomClient nvarchar(15) NOT NULL,
	Adresse nvarchar(50),
	Email nvarchar(20),
	Telephone nvarchar(10)
);

EXEC sp_help tblClients;
/***********************************************************************************************
## Écrire une requête qui crée la table tblProduits en respectant les spécifications ci-dessous

Table "tblProduits" :

ProduitID (Entier - Clé primaire)
NomProduit (Chaîne de caractères)
Description (Texte)
PrixUnitaire (Nombre décimal)
StockDisponible (Entier)
************************************************************************************************/
-- Votre code ici 
DROP TABLE IF EXISTS tblProduits;
CREATE TABLE tblProduits(
	ProduitID INT identity(301, 1) PRIMARY KEY NOT NULL,
	NomProduit nvarchar(15) NOT NULL,
	Description text,
	PrixUnitaire float,
	StockDisponible INT
);

EXEC sp_help tblProduits
/***********************************************************************************************
## Écrire une requête qui crée la table tblCommandes en respectant les spécifications ci-dessous

Table "tblCommandes" :

CommandeID (Entier - Clé primaire)
DateCommande (Date)
ClientID (Entier - Clé étrangère faisant référence à l'ID du client)
TotalCommande (Nombre décimal)
************************************************************************************************/
-- Votre code ici 

DROP TABLE IF EXISTS tblCommandes;
CREATE TABLE tblCommandes(
	CommandeID INT identity(401, 1) PRIMARY KEY NOT NULL,
	DateCommande date,
	ClientID INT FOREIGN KEY REFERENCES tblClients(ClientID) NOT NULL,
	TotalCommande float
);

EXEC sp_help tblCommandes;

/***********************************************************************************************
## Écrire une requête qui crée la table tblArticlesCommandes en respectant les spécifications ci-dessous

Table "tblArticlesCommandes" :

ArticleCommandeID (Entier - Clé primaire)
CommandeID (Entier - Clé étrangère faisant référence à l'ID de la commande)
ProduitID (Entier - Clé étrangère faisant référence à l'ID du produit)
Quantite (Entier)
PrixUnitaire (Nombre décimal)
************************************************************************************************/
-- Votre code ici 

DROP TABLE IF EXISTS tblArticlesCommandes;
CREATE TABLE tblArticlesCommandes(
	ArticleCommandeID INT identity(501, 1) PRIMARY KEY NOT NULL,
	CommandeID INT FOREIGN KEY REFERENCES tblCommandes(CommandeID) NOT NULL,
	ProduitID INT FOREIGN KEY REFERENCES tblProduits(ProduitID) NOT NULL,
	Quantite int,
	PrixUnitaire float
);

EXEC sp_help tblArticlesCommandes;

/***********************************************************************************************
## Écrire une requête qui crée la table tblCours en respectant les spécifications ci-dessous

Table "tblCours" :

CoursID (Entier - Clé primaire)
NomCours (Chaîne de caractères)
ProfesseurID (Entier - Clé étrangère faisant référence à l'ID de l'employé)
HeureDebut (Heure)
HeureFin (Heure)
************************************************************************************************/
-- Votre code ici 

DROP TABLE IF EXISTS tblCours;
CREATE TABLE tblCours(
	CoursID INT identity(601, 1) PRIMARY KEY NOT NULL,
	NomCours nvarchar(15),
	ProfesseurID INT FOREIGN KEY REFERENCES tblEmployes(EmpID) NOT NULL,
	HeureDebut time(0),
	HeureFin time(0)
);

EXEC sp_help tblCours;

/***********************************************************************************************
## Écrire une requête qui crée la table tblEtudiants en respectant les spécifications ci-dessous

Table "tblEtudiants" :

EtudiantID (Entier - Clé primaire)
NomEtudiant (Chaîne de caractères)
PrenomEtudiant (Chaîne de caractères)
DateNaissance (Date)
Adresse (Chaîne de caractères)
************************************************************************************************/
-- Votre code ici 

DROP TABLE IF EXISTS tblEtudiants;
CREATE TABLE tblEtudiants(
	EtudiantID INT identity(701, 1) PRIMARY KEY NOT NULL,
	NomEtudiant nvarchar(15) NOT NULL,
	PrenomEtudiant nvarchar(15) NOT NULL,
	DateNaissance date,
	Adresse nvarchar(25)
);

EXEC sp_help tblEtudiants;

/***********************************************************************************************
## Écrire une requête qui crée la table tblResultatsExamens en respectant les spécifications ci-dessous

Table "tblResultatsExamens" :

ResultatID (Entier - Clé primaire)
EtudiantID (Entier - Clé étrangère faisant référence à l'ID de l'étudiant)
CoursID (Entier - Clé étrangère faisant référence à l'ID du cours)
Note (Nombre décimal)
DateExamen (Date)
************************************************************************************************/
-- Votre code ici 



/***********************************************************************************************
## Écrire une requête qui crée la table tblMessages en respectant les spécifications ci-dessous

Table "tblMessages" :

MessageID (Entier - Clé primaire)
ExpediteurID (Entier - Clé étrangère faisant référence à l'ID de l'employé)
DestinataireID (Entier - Clé étrangère faisant référence à l'ID de client)
ContenuMessage (Texte)
DateEnvoi (Date et Heure)
************************************************************************************************/
-- Votre code ici 




/*****************************************************************************************
## Partie II : Insertion de données
## =================================

## Ecrire des requêtes SQL qui insèrent des données dans la tables créées précédemment

Code d'insertion de données
===========================
*****************************************************************************************/
-- Insertion dans la table tblEmployes
-- Votre code ici




-- Insertion dans la table tblProjets
-- Votre code ici




-- Insertion dans la table tblClients
-- Votre code ici




-- Insertion dans la table tblProduits
-- Votre code ici




-- Insertion dans la table tblCommandes
-- Votre code ici




-- Insertion dans la table tblArticlesCommandes
-- Votre code ici




-- Insertion dans la table tblCours
-- Votre code ici




-- Insertion dans la table tblEtudiants
-- Votre code ici




-- Insertion dans la table tblResultatsExamens
-- Votre code ici




-- Insertion dans la table tblMessages
-- Votre code ici






/*****************************************************************************************************************
## Partie III : Modification de la structure des tables
======================================================

## Écrire une requête qui modifie la structure de la table tblEmployes en respectant les spécification ci-dessous : 
Ajouter la colonne Departement de type Chaine de caractères et de longueur 50
Ajouter la colonne DateEmbauche de type Date
*****************************************************************************************************************/
-- Votre code ici


/****************************************************************************************************************
## Écrire une requête qui modifie la structure de la table tblProjets en respectant les spécification ci-dessous : 
Ajouter la colonne Budget de type Réel avec 2 décimales
Ajouter la colonne DescriptionProjet de type Texte long 
*****************************************************************************************************************/
-- Votre code ici



/****************************************************************************************************************
## Écrire une requête qui modifie la structure de la table tblClients en respectant les spécification ci-dessous : 
Ajouter la colonne DateCreationClient de type Date
Ajouter la colonne Commentaire de type Texte long 
*****************************************************************************************************************/
-- Votre code ici



/****************************************************************************************************************
## Écrire une requête qui modifie la structure de la table tblProduits en respectant les spécification ci-dessous : 
Ajouter la colonne DateAjoutProduit de type Date
Ajouter la colonne Fournisseur de type Texte de longueur 55
*****************************************************************************************************************/
-- Votre code ici



/****************************************************************************************************************
## Écrire une requête qui modifie la structure de la table tblCommandes en respectant les spécification ci-dessous : 
Ajouter la colonne DateCommande de type Date
Ajouter la colonne StatutCommande de type Texte de longueur 50
*****************************************************************************************************************/
-- Votre code ici



/****************************************************************************************************************
## Écrire une requête qui modifie la structure de la table tblArticlesCommandes en respectant les spécification ci-dessous : 
Ajouter la colonne Remise de type Réel avec 2 décimales
Ajouter la colonne MontantTotal de type monétaire
*****************************************************************************************************************/
-- Votre code ici



/****************************************************************************************************************
## Écrire une requête qui modifie la structure de la table tblCours en respectant les spécification ci-dessous : 
Ajouter la colonne DescriptionCours de type Texte long
Ajouter la colonne SalleCours de type Texte de longueur 50
*****************************************************************************************************************/
-- Votre code ici


/****************************************************************************************************************
## Écrire une requête qui modifie la structure de la table tblEtudiants en respectant les spécification ci-dessous : 
Ajouter la colonne AnneeEtudes de type entier
Ajouter la colonne MoyenneGenerale de Type Réel à 2 décimales 
*****************************************************************************************************************/
-- Votre code ici


/****************************************************************************************************************
## Écrire une requête qui modifie la structure de la table tblResultatsExamens en respectant les spécification ci-dessous :
Ajouter la colonne Appreciation de type texte de longueur 50
Ajouter la colonne MentionHonneur de type booléen
 *****************************************************************************************************************/
-- Votre code ici


/****************************************************************************************************************
## Écrire une requête qui modifie la structure de la table tblMessages en respectant les spécification ci-dessous : 
Ajouter la colonne Lu de type Booléen
Ajouter la colonne Priorite de type entier
*****************************************************************************************************************/
-- Votre code ici



/***************************************************************************************************************
## Partie IV : Suppression de données
====================================

## Écrire une requête qui supprime le contenu de la table tblEmployes
*****************************************************************************************************************/
-- Votre code ici


/***************************************************************************************************************
## Écrire une requête qui supprime le contenu de la table tblProjets
*****************************************************************************************************************/
-- Votre code ici


/***************************************************************************************************************
## Écrire une requête qui supprime le contenu de la table tblClients
*****************************************************************************************************************/
-- Votre code ici


/***************************************************************************************************************
## Écrire une requête qui supprime le contenu de la table tblProduits
*****************************************************************************************************************/
-- Votre code ici


/***************************************************************************************************************
## Écrire une requête qui supprime le contenu de la table tblCommandes
*****************************************************************************************************************/
-- Votre code ici


/***************************************************************************************************************
## Écrire une requête qui supprime le contenu de la table tblArticlesCommandes
*****************************************************************************************************************/
-- Votre code ici


/***************************************************************************************************************
## Écrire une requête qui supprime le contenu de la table tblCours
*****************************************************************************************************************/
-- Votre code ici


/***************************************************************************************************************
## Écrire une requête qui supprime le contenu de la table tblEtudiants
*****************************************************************************************************************/
-- Votre code ici


/***************************************************************************************************************
## Écrire une requête qui supprime le contenu de la table tblResultatsExamens
*****************************************************************************************************************/
-- Votre code ici


/***************************************************************************************************************
## Écrire une requête qui supprime le contenu de la table tblMessages
*****************************************************************************************************************/
-- Votre code ici


-- ## Solution Partie IV
-- ====================

-- Code SQL de suppression des données
-- ===================================
-- Supprimer le contenu de la table tblEmployes
-- Votre code ici



-- Supprimer le contenu de la table tblProjets
-- Votre code ici



-- Supprimer le contenu de la table tblClients
-- Votre code ici



-- Supprimer le contenu de la table tblProduits
-- Votre code ici



-- Supprimer le contenu de la table tblCommandes
-- Votre code ici



-- Supprimer le contenu de la table tblArticlesCommandes
-- Votre code ici



-- Supprimer le contenu de la table tblCours
-- Votre code ici



-- Supprimer le contenu de la table tblEtudiants
-- Votre code ici



-- Supprimer le contenu de la table tblResultatsExamens
-- Votre code ici



-- Supprimer le contenu de la table tblMessages
-- Votre code ici



/*************************************************************************
## Partie V : Suppression des tables
=====================================

## Attention, ne pas confondre avec les requêtes précédentes
## Écrire une requête qui supprime la table tblEmployes
-- Votre code ici



## Écrire une requête qui supprime la table tblProjets
-- Votre code ici




## Écrire une requête qui supprime la table tblClients
-- Votre code ici




## Écrire une requête qui supprime la table tblProduits
-- Votre code ici




## Écrire une requête qui supprime la table tblCommandes
-- Votre code ici




## Écrire une requête qui supprime la table tblArticlesCommandes
-- Votre code ici




## Écrire une requête qui supprime la table tblCours
-- Votre code ici




## Écrire une requête qui supprime la table tblEtudiants
-- Votre code ici




## Écrire une requête qui supprime la table tblResultatsExamens
-- Votre code ici




## Écrire une requête qui supprime la table tblMessages
-- Votre code ici





