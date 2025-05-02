/*****************************************************************************************
## Travaux dirigés 10 : la commande UPDATE
## Cette série de requête vous permettra de vous exercer à la commande UPDATE
## Comme d'habitude, essayez d'en faire le plus possible afin de bien la maitriser
******************************************************************************************/

-- Créer une nouvelle base de données TD10


-- Utilisation de la base de données


-- -----------------------------------------------------------------------------------------------------------------------
-- Effectuer une copie des tables suivantes situées dans la base de données Xtreme vers la nouvelle base de données TD10. 
-- Le nom des copie sera précédé de "tbl". Toutes les requêtes seront effectuées sur les copies dans la base de données TD10
-- -----------------------------------------------------------------------------------------------------------------------
/* ***********************************************************************************************************************
achats --> tblAchats, 
clients --> tblClients, 
employés --> tblEmployes, 
adresse des employés --> tblAdresseEmployes, 
commandes --> tblCommandes,
détail des commandes --> tblDetailCommandes
fournisseurs --> tblFournisseurs, 
crédits --> tblCredits,
Régions --> tblRegions,
produits --> tblProduits
type de produits --> tblTypeProduits
**************************************************************************************************************************/

-- Création de la table tblAchats --
DROP TABLE IF EXISTS tblAchats;
SELECT * 
INTO tblAchats
FROM [xtremefr].[dbo].[Achats];


-- Création de la table tblAdresseEmployes
DROP TABLE IF EXISTS tblAdresseEmployes;
SELECT * 
INTO tblAdresseEmployes
FROM [xtremefr].[dbo].[Adresses des employés];


-- Création de la table tblClients
DROP TABLE IF EXISTS tblClients;
SELECT * 
INTO tblClients
FROM [xtremefr].[dbo].[Clients];


-- Création de la table tblCommandes
DROP TABLE IF EXISTS tblCommandes;
SELECT * 
INTO tblCommandes
FROM [xtremefr].[dbo].[Commandes];


-- Création de la table tblCredits
DROP TABLE IF EXISTS tblCredits;
SELECT * 
INTO tblCredits
FROM [xtremefr].[dbo].[Crédits];


-- Création de la table tblDetailCommandes
DROP TABLE IF EXISTS tblDetailCommandes;
SELECT * 
INTO tblDetailCommandes
FROM [xtremefr].[dbo].[Détails des commandes];


-- Création de la table tblEmployes
DROP TABLE IF EXISTS tblEmployes;
SELECT * 
INTO tblEmployes
FROM [xtremefr].[dbo].[Employés];


-- Création de la table tblFournisseurs
DROP TABLE IF EXISTS tblFournisseurs;
SELECT * 
INTO tblFournisseurs
FROM [xtremefr].[dbo].[Fournisseurs];


-- Création de la table tblRegions
DROP TABLE IF EXISTS tblRegions;
SELECT * 
INTO tblRegions
FROM [xtremefr].[dbo].[Régions];


-- Création de la table tblProduits
DROP TABLE IF EXISTS tblProduits;
SELECT * 
INTO tblProduits
FROM [xtremefr].[dbo].[Produits];


-- Création de la table tblTypeProduit
DROP TABLE IF EXISTS tblTypeProduit;
SELECT * 
INTO tblTypeProduit
FROM [xtremefr].[dbo].[Types de produit];

-- *****************************************************************************************************************************************
-- Toutes les requêtes de mise à jour doivent suivre les trois étapes :
-- 1- Identification des enregistrements à mettre à jour (une instruction SELECT)
-- 2- Mise à jour à proprement parler (Une instruction UPDATE)
-- 3- Vérification de la mise à jour.(une instruction SELECT avec la condition appropriée pour vérifier que le UPDATE a bien fonctionné)
-- *****************************************************************************************************************************************

-- Série I
-- =======

-- **Requête 1 :**
-- Ecrire une requête qui met à jour le prix du produit dont le type est  7 pour le modifier à 15.99.
-- Votre code ici

-- 1- Identification des enregistrements à mettre à jour (une instruction SELECT)
SELECT *
FROM
	[dbo].[tblProduits]
WHERE
	[ID type de produit] = 7
	
-- 2 - Mise à jour
UPDATE [dbo].[tblProduits]
	SET [Prix conseillé] = (
		CASE 
			WHEN [ID type de produit] = 7 THEN 15.99
			ELSE [Prix conseillé]
		END
	);

-- 3 - Vérification

SELECT *
FROM
	[dbo].[tblProduits]
WHERE
	[ID type de produit] = 7

-- **Requête 2 :**
-- Écrire une requête qui effectue la mise à jour de la quantité en stock du produit dont le seuil de réapprovisionnement est à 50 pour la changer à 50.
-- Votre code ici
-- 1- Identification des enregistrements à mettre à jour (une instruction SELECT)
-- 2- Mise à jour à proprement parler (une instruction UPDATE)
-- 3- Vérification de la mise à jour.(une instruction SELECT avec la condition appropriée pour vérifier que le UPDATE a bien fonctionné)
-- Votre code ici

-- 1- Identification des enregistrements à mettre à jour (une instruction SELECT)
SELECT *
FROM [dbo].[tblAchats]
WHERE
	[Seuil de réapprovisionnement] = 50
-- 2 - Mise à jour

UPDATE [dbo].[tblAchats] 
	SET [Unités en commande] = (
		CASE 
			WHEN [Unités en stock] <= [Seuil de réapprovisionnement] AND [Seuil de réapprovisionnement] = 50 THEN 150
			ELSE [Unités en commande]
		END
	)

-- 3 - Vérification

SELECT *
FROM [dbo].[tblAchats]
WHERE
	[Seuil de réapprovisionnement] = 50

-- **Requête 3 :**
-- Écrire une requête qui effectue la mise à jour de la couleur du produit du fournisseur 1 pour la changer en "Bleu marine"
-- Votre code ici
-- 1- Identification des enregistrements à mettre à jour (une instruction SELECT)
-- 2- Mise à jour à proprement parler (une instruction UPDATE)
-- 3- Vérification de la mise à jour.(une instruction SELECT avec la condition appropriée pour vérifier que le UPDATE a bien fonctionné)

SELECT *
FROM 
	[dbo].[tblProduits] P
WHERE
	[ID fournisseur] = 1

UPDATE [dbo].[tblProduits]
	SET [Couleur] = (
		CASE 
			WHEN [ID fournisseur] = 1 THEN 'Bleu marine'
			ELSE [Couleur]
		END
	)

SELECT *
FROM 
	[dbo].[tblProduits] P
WHERE
	[ID fournisseur] = 1

-- **Requête 4 :**
-- Écrire une requête qui effectue la mise à jour du type de produit de "VTT" à "Vélo Tout Terrain".
-- Votre code ici
-- 1- Identification des enregistrements à mettre à jour (une instruction SELECT)
-- 2- Mise à jour à proprement parler (une instruction UPDATE)
-- 3- Vérification de la mise à jour.(une instruction SELECT avec la condition appropriée pour vérifier que le UPDATE a bien fonctionné)

SELECT *
FROM [dbo].[tblTypeProduit]
WHERE
	[Nom du type de produit] = 'VTT'

UPDATE [dbo].[tblTypeProduit]
	SET [Nom du type de produit] = (
		CASE
			WHEN [Nom du type de produit] = 'VTT' THEN 'Vélo Tout Terrain'
			ELSE [Nom du type de produit]
		END
	)

SELECT *
FROM [dbo].[tblTypeProduit]
WHERE
	[Nom du type de produit] = 'Vélo Tout Terrain'

-- **Requête 5 :**
-- Écrire une requête qui augmente de 10% le prix de tous les produits de type 7 et 3 .
-- Votre code ici
-- 1- Identification des enregistrements à mettre à jour (une instruction SELECT)
-- 2- Mise à jour à proprement parler (une instruction UPDATE)
-- 3- Vérification de la mise à jour.(une instruction SELECT avec la condition appropriée pour vérifier que le UPDATE a bien fonctionné)

SELECT *
FROM [dbo].[tblProduits]
WHERE
	[ID type de produit] IN(7, 3)

UPDATE [dbo].[tblProduits]
	SET [Prix conseillé] = (
		CASE 
			WHEN [ID type de produit] IN(7, 3) THEN [Prix conseillé] * 1.10
			ELSE [Prix conseillé]
		END
	)

SELECT *
FROM [dbo].[tblProduits]
WHERE
	[ID type de produit] IN(7, 3)

-- **Requête 6 :**
-- Écrire une requête qui effectue la mise à jour du poste des employés qui occupent le poste "Représentant" par "Commercial"
-- Votre code ici
-- 1- Identification des enregistrements à mettre à jour (une instruction SELECT)
-- 2- Mise à jour à proprement parler (une instruction UPDATE)
-- 3- Vérification de la mise à jour.(une instruction SELECT avec la condition appropriée pour vérifier que le UPDATE a bien fonctionné)

SELECT *
FROM [dbo].[tblEmployes]
WHERE
	[Poste occupé] = 'Représentant'

UPDATE [dbo].[tblEmployes]
	SET [Poste occupé] = (
		CASE
			WHEN [Poste occupé] = 'Représentant' THEN 'Commercial'
			ELSE [Poste occupé]
		END
	)

SELECT *
FROM [dbo].[tblEmployes]
WHERE
	[Poste occupé] = 'Commercial'

-- **Requête 7 :**
-- Écrire une requête qui remplace le poste téléphonique des employés qui occupent le poste de "Commercial" par "1111"
-- Votre code ici
-- 1- Identification des enregistrements à mettre à jour (une instruction SELECT)
-- 2- Mise à jour à proprement parler (une instruction UPDATE)
-- 3- Vérification de la mise à jour.(une instruction SELECT avec la condition appropriée pour vérifier que le UPDATE a bien fonctionné)



-- **Requête 8 :**
-- Écrire une requête qui met à jour la site web du transporteur "Pickup" par "#http://www.pickup.com#"
-- Votre code ici
-- 1- Identification des enregistrements à mettre à jour (une instruction SELECT)
-- 2- Mise à jour à proprement parler (une instruction UPDATE)
-- 3- Vérification de la mise à jour.(une instruction SELECT avec la condition appropriée pour vérifier que le UPDATE a bien fonctionné)



-- **Requête 9 :**
-- Écrire une requête qui augmente le salaire des employés ayant 25 ans d'ancienneté de 200$.
-- Votre code ici

-- Identification des employés ayant 25 ans d'ancienneté


-- Mise à jour


-- Vérification



-- **Requête 10 :**
-- Écrire une requête qui met à jour le prix de tous les produits ayant une quantité en stock inférieure à 75 en réduisant son prix de 5%.
-- Votre code ici

-- Identification des produits dont la quantité en stock est inférieure à 75.


-- Mise à jour


-- Vérification



-- Série II
-- ========

-- **Requête 11 :**
-- Augmentez de 20% le prix de tous les produits dont le type est 'gants' et dont la quantité en stock est supérieure à 100.
-- Votre code ici
-- Identification des enregistrements


-- Mise à jour


-- Vérification



-- **Requête 12 :**
-- Écrire une requête qui met à jour le salaire de tous les employés par un pourcentage de 5% si leur année d'embauche est inférieure ou égale à 1996.
-- Votre code ici
-- 1- Identification des enregistrements à mettre à jour (une instruction SELECT)


-- 2- Mise à jour à proprement parler (une instruction UPDATE)


-- 3- Vérification de la mise à jour.(une instruction SELECT avec la condition appropriée pour vérifier que le UPDATE a bien fonctionné)



-- **Requête 13 :**
-- Écrire une requête qui met à jour la quantité en stock de chaque produit en fonction du nombre de commandes passées.
-- Ajoutez à la quantité en stock actuelle de chaque produit la somme des quantités commandées dans la table "OrderDetails" pour ce produit.
-- Votre code ici

-- 1- Identification des enregistrements à mettre à jour (une instruction SELECT)

    
-- 2- Mise à jour à proprement parler (une instruction UPDATE)


-- 3- Vérification de la mise à jour.(une instruction SELECT avec la condition appropriée pour vérifier que le UPDATE a bien fonctionné)



-- **Requête 14 :**
-- Écrire une requête qui insére la valeur 'Quantité limitée' dans la colonne catégorie pour tous les produits ayant une quantité en stock inférieure à 100.
-- Avant d'effectuer cette mise à jour, modifier la structure de la table en rajoutant la colonne "Categorie" de type texte le longueur 20. 
-- Votre code ici

-- Modification de la table et ajout de "Categorie"
-- Vérification de l'existence de colonne avant suppression


-- Ajout de la colonne

	
-- 1- Identification des enregistrements à mettre à jour (une instruction SELECT)


-- 2- Mise à jour à proprement parler (une instruction UPDATE)


-- 3- Vérification de la mise à jour.(une instruction SELECT avec la condition appropriée pour vérifier que le UPDATE a bien fonctionné)


-- **Requête 15 :**
-- Modifiez la table produit (tblProduits) en rajoutant la colonne  "Remarques" de type texte et de longueur 50
-- Écrire une requête qui met à jour la colonne "Remarques" du produit ayant le prix le plus élevé avec le message "le plus cher".
-- Votre code ici

-- Vérification de l'existence de colonne avant suppression


-- Ajout de la colonne "Remarques"


-- Vérification de l'ajout


-- 1- Identification des enregistrements à mettre à jour (une instruction SELECT)


-- 2- Mise à jour à proprement parler (une instruction UPDATE)


-- 3- Vérification de la mise à jour.(une instruction SELECT avec la condition appropriée pour vérifier que le UPDATE a bien fonctionné)



-- **Requête 16 :**
-- Modifiez la table tblEmployés en rajoutant la colonne StatutEmploi de type texte de longueur 15.
-- Écrire une requête qui met à jour la colonne StatutEmploi avec "Cadre' pour les employés ayant un salaire supérieur à 60 000.
-- Votre code ici

-- Vérification de l'existence de colonne avant suppression


-- Ajout de la colonne "StatutEmploi"


-- Vérification de l'ajout


-- 1- Identification des enregistrements à mettre à jour (une instruction SELECT)


-- 2- Mise à jour à proprement parler (une instruction UPDATE)

	
-- 3- Vérification de la mise à jour.(une instruction SELECT avec la condition appropriée pour vérifier que le UPDATE a bien fonctionné)


-- **Requête 17 :**
-- Écrire une requête qui met à jour la colonne "Couleur" des produits de type 5 en respectant les spécifications suivantes :
-- Lorsque la taille du produit est XSS, XS, S la couleur est "Noir".
-- Lorsque la taille du produit est M, alors la couleur est "Rouge"
-- Lorsque la taille du produit est L, XL, alors la coouleur est "Gris"
-- Votre code ici

-- 1- Identification des enregistrements à mettre à jour (une instruction SELECT)


-- 2- Mise à jour à proprement parler (une instruction UPDATE)


-- 3- Vérification de la mise à jour.(une instruction SELECT avec la condition appropriée pour vérifier que le UPDATE a bien fonctionné)


-- **Requête 18 :**
-- Nous allons affecter une commission aux représentants ayant réalisé un certain montant de ventes.
-- Modifier la table employes (tblEmployes) en rajoutant la colonne "Commission"
-- Mettre à jour la colonne "Commission" avec le montant de la commission réalisée qui représente 2% des vantes réalisées.
-- Je donne volontairement peu de précision pour vous laisser réfléchir à la facon de procéder et ou aller chercher l'information
-- Votre code ici

-- Vérification de l'existence de colonne avant suppression


-- Ajout de la colonne "Commission"


-- Vérification de l'ajout

-- 1- Identification des enregistrements à mettre à jour (une instruction SELECT)


-- 2- Mise à jour à proprement parler (une instruction UPDATE)


-- 3- Vérification de la mise à jour.(une instruction SELECT avec la condition appropriée pour vérifier que le UPDATE a bien fonctionné)




-- ***************************** FIN de TD *****************************