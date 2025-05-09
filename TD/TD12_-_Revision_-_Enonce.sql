-- ---------------------------------------------------------
-- Collège Marie Victorin
-- Introduction aux bases de données
-- Révision
-- ---------------------------------------------------------

-- Série I :  les conditions (Clause WHERE)
-- Base de données : xtremefr

---- Créez une requête qui affiche les employés nés les dix derneirs jours du mois
-- Les colonnes à afficher sont : 
-- •	Nom
-- •	Prénom
-- •	Poste occupé
-- •	Date de naissance
-- •	Téléphone personnel



---- Créez une requête qui affiche les employés embauché le premier mois de l'année.
-- Les colonnes à afficher sont : 
-- •	Nom
-- •	Prénom
-- •	Poste occupé
-- •	Date d'embauche
-- •	Téléphone personnel



---- Créez une requête qui affiche les employés qui sont des directeurs
-- Les colonnes à afficher sont : 
-- •	Nom
-- •	Prénom
-- •	Poste occupé
-- •	Téléphone personnel


---- Créez une requête qui affiche la liste des représentants ainsi que leur age et leur ancienneté
-- Les colonnes à afficher sont : 
-- •	Nom
-- •	Prénom
-- •	Poste occupé
-- •	Téléphone personnel
-- •	Age
-- •	Ancienneté


---- Créez une requête qui affiche la liste des employés qui ont pour contact en cas d'urgence le père ou la mère
-- Les colonnes à afficher sont : 
-- •	Nom
-- •	Prénom
-- •	Poste occupé
-- •	Téléphone personnel
-- •	Lien de parenté


---- Créez une requête qui affiche la liste des employés qui relèvent de l'employé qui n'a pas de supérieur hiérarchique.
-- Les colonnes à afficher sont : 
-- •	Nom
-- •	Prénom
-- •	Poste occupé
-- •	Supérieur hiérarchique


---- On veut avoir la liste des employés candidats à une augmentation
---- Créez une requête qui affiche la liste des employés qui relèvent de l'employé qui n'a pas de supérieur hiérarchique.
-- Les colonnes à afficher sont : 
-- •	Nom
-- •	Prénom
-- •	Poste occupé
-- •	Supérieur hiérarchique
-- ------------------------------------------------------------------------------------------------------------------------
-- Sderie II

-- Afficher la liste des clients ayant acheté des produits valant plus de 500$
-- On affichera :
-- Le nom du client
-- La catégorie
-- Le nom du produit
-- Le prix unitaire
-- La quantité
-- La date de la commande
-- La liste sera triée par le nom du client et le nom du produit.

-- Votre code ici

SELECT 
	[Nom du client]
	,[Nom du type de produit]
	,[Nom du produit]
	,[Prix unitaire]
	,[Quantité]
	,[Date de commande]
FROM 
	[dbo].[Commandes] C,
	[dbo].[Clients] CL,
	[dbo].[Produits] P,
	[dbo].[Détails des commandes] DC,
	[dbo].[Types de produit] T
WHERE
	C.[ID commande] = DC.[ID commande] AND
	P.[ID produit] = DC.[ID produit] AND
	CL.[ID client] = C.[ID client] AND
	T.[ID type de produit] = P.[ID type de produit] AND
	[Prix unitaire] > 500
ORDER BY
	[Nom du client]
	,[Nom du produit]


-- -----------------------------------------------------------------
-- Créer une vue qui contient les données de la requête précédente
-- -----------------------------------------------------------------
-- Votre code ici

DROP VIEW IF EXISTS vCommandeSup500;
GO
CREATE VIEW vCommandeSup500
AS
SELECT 
	[Nom du client]
	,[Nom du type de produit]
	,[Nom du produit]
	,[Prix unitaire]
	,[Quantité]
	,[Date de commande]
FROM 
	[dbo].[Commandes] C,
	[dbo].[Clients] CL,
	[dbo].[Produits] P,
	[dbo].[Détails des commandes] DC,
	[dbo].[Types de produit] T
WHERE
	C.[ID commande] = DC.[ID commande] AND
	P.[ID produit] = DC.[ID produit] AND
	CL.[ID client] = C.[ID client] AND
	T.[ID type de produit] = P.[ID type de produit] AND
	[Prix unitaire] > 500
GO

-- -------------------------------------------------------------------------------------------------------------------------------
-- Maintenant, on veut savoir combien de fois chaque client a acheté le même produit ainsi que la quantité totale et coût total de ce produit
-- On affichera :
-- Le nom du client
-- Le nom du produit
-- Le nombre de fois que le produit a été acheté
-- La quantité totale achetée
-- Le montant total acheté

-- Votre code ici

SELECT 
	[Nom du client]
	,[Nom du produit]
	,COUNT([Nom du produit]) AS 'Nombre de fois acheté'
	,SUM([Quantité]) AS 'Quantité total'
	,SUM([Prix unitaire]) AS 'Montant total'
FROM 
	[dbo].[vCommandeSup500]
GROUP BY
	[Nom du client]
	,[Nom du produit]

-- --------------------------------------------------------------------------
-- Créer la table tblStatsClients contenant les données calculées plus haut

-- Votre code ici

DROP TABLE IF EXISTS tblStatsClients
GO
SELECT 
	[Nom du client]
	,[Nom du produit]
	,COUNT([Nom du produit]) AS 'Nombre de fois acheté'
	,SUM([Quantité]) AS 'Quantité total'
	,SUM([Prix unitaire]) AS 'Montant total'
INTO tblStatsClients
FROM 
	[dbo].[vCommandeSup500]
GROUP BY
	[Nom du client]
	,[Nom du produit]

-- ---------------------------------------------------
-- Afficher la liste des 10 meilleurs clients

-- Votre code ici
SELECT TOP 10
	[Nom du client]
	,SUM([Montant total]) AS 'Total depensé'
FROM
	[dbo].[tblStatsClients]
GROUP BY
	[Nom du client]
ORDER BY
	[Total depensé] DESC

-- --------------------------------------------------------
-- Afficher la liste des 10 produits les plus profitables

-- Votre code ici


--Tentative 1
SELECT TOP 10
	SC.[Nom du produit]
	,SUM([Nombre de fois acheté]) AS 'Total acheté'
FROM
	[dbo].[tblStatsClients] SC
GROUP BY
	SC.[Nom du produit]
ORDER BY
	[Total acheté] desc


--Tentative 2
SELECT TOP 10
	[Nom du produit]
	,SUM([Prix unitaire]) AS 'Total'
FROM
	[dbo].[vCommandeSup500]
GROUP BY
	[Nom du produit]
ORDER BY
	Total desc



--Tentative 3
SELECT TOP 10
	[Nom du produit]
	,SUM([Prix unitaire]) AS TotalGénéré
	,SUM([Quantité]) AS TotalQuantité
FROM 
	[dbo].[Produits] P,
	[dbo].[Détails des commandes] DC
WHERE
	P.[ID produit] = DC.[ID produit]
GROUP BY
	[Nom du produit]
ORDER BY
	TotalGénéré desc