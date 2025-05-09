-- ---------------------------------------------------------
-- Coll�ge Marie Victorin
-- Introduction aux bases de donn�es
-- R�vision
-- ---------------------------------------------------------

-- S�rie I :  les conditions (Clause WHERE)
-- Base de donn�es : xtremefr

---- Cr�ez une requ�te qui affiche les employ�s n�s les dix derneirs jours du mois
-- Les colonnes � afficher sont : 
-- �	Nom
-- �	Pr�nom
-- �	Poste occup�
-- �	Date de naissance
-- �	T�l�phone personnel



---- Cr�ez une requ�te qui affiche les employ�s embauch� le premier mois de l'ann�e.
-- Les colonnes � afficher sont : 
-- �	Nom
-- �	Pr�nom
-- �	Poste occup�
-- �	Date d'embauche
-- �	T�l�phone personnel



---- Cr�ez une requ�te qui affiche les employ�s qui sont des directeurs
-- Les colonnes � afficher sont : 
-- �	Nom
-- �	Pr�nom
-- �	Poste occup�
-- �	T�l�phone personnel


---- Cr�ez une requ�te qui affiche la liste des repr�sentants ainsi que leur age et leur anciennet�
-- Les colonnes � afficher sont : 
-- �	Nom
-- �	Pr�nom
-- �	Poste occup�
-- �	T�l�phone personnel
-- �	Age
-- �	Anciennet�


---- Cr�ez une requ�te qui affiche la liste des employ�s qui ont pour contact en cas d'urgence le p�re ou la m�re
-- Les colonnes � afficher sont : 
-- �	Nom
-- �	Pr�nom
-- �	Poste occup�
-- �	T�l�phone personnel
-- �	Lien de parent�


---- Cr�ez une requ�te qui affiche la liste des employ�s qui rel�vent de l'employ� qui n'a pas de sup�rieur hi�rarchique.
-- Les colonnes � afficher sont : 
-- �	Nom
-- �	Pr�nom
-- �	Poste occup�
-- �	Sup�rieur hi�rarchique


---- On veut avoir la liste des employ�s candidats � une augmentation
---- Cr�ez une requ�te qui affiche la liste des employ�s qui rel�vent de l'employ� qui n'a pas de sup�rieur hi�rarchique.
-- Les colonnes � afficher sont : 
-- �	Nom
-- �	Pr�nom
-- �	Poste occup�
-- �	Sup�rieur hi�rarchique
-- ------------------------------------------------------------------------------------------------------------------------
-- Sderie II

-- Afficher la liste des clients ayant achet� des produits valant plus de 500$
-- On affichera :
-- Le nom du client
-- La cat�gorie
-- Le nom du produit
-- Le prix unitaire
-- La quantit�
-- La date de la commande
-- La liste sera tri�e par le nom du client et le nom du produit.

-- Votre code ici

SELECT 
	[Nom du client]
	,[Nom du type de produit]
	,[Nom du produit]
	,[Prix unitaire]
	,[Quantit�]
	,[Date de commande]
FROM 
	[dbo].[Commandes] C,
	[dbo].[Clients] CL,
	[dbo].[Produits] P,
	[dbo].[D�tails des commandes] DC,
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
-- Cr�er une vue qui contient les donn�es de la requ�te pr�c�dente
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
	,[Quantit�]
	,[Date de commande]
FROM 
	[dbo].[Commandes] C,
	[dbo].[Clients] CL,
	[dbo].[Produits] P,
	[dbo].[D�tails des commandes] DC,
	[dbo].[Types de produit] T
WHERE
	C.[ID commande] = DC.[ID commande] AND
	P.[ID produit] = DC.[ID produit] AND
	CL.[ID client] = C.[ID client] AND
	T.[ID type de produit] = P.[ID type de produit] AND
	[Prix unitaire] > 500
GO

-- -------------------------------------------------------------------------------------------------------------------------------
-- Maintenant, on veut savoir combien de fois chaque client a achet� le m�me produit ainsi que la quantit� totale et co�t total de ce produit
-- On affichera :
-- Le nom du client
-- Le nom du produit
-- Le nombre de fois que le produit a �t� achet�
-- La quantit� totale achet�e
-- Le montant total achet�

-- Votre code ici

SELECT 
	[Nom du client]
	,[Nom du produit]
	,COUNT([Nom du produit]) AS 'Nombre de fois achet�'
	,SUM([Quantit�]) AS 'Quantit� total'
	,SUM([Prix unitaire]) AS 'Montant total'
FROM 
	[dbo].[vCommandeSup500]
GROUP BY
	[Nom du client]
	,[Nom du produit]

-- --------------------------------------------------------------------------
-- Cr�er la table tblStatsClients contenant les donn�es calcul�es plus haut

-- Votre code ici

DROP TABLE IF EXISTS tblStatsClients
GO
SELECT 
	[Nom du client]
	,[Nom du produit]
	,COUNT([Nom du produit]) AS 'Nombre de fois achet�'
	,SUM([Quantit�]) AS 'Quantit� total'
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
	,SUM([Montant total]) AS 'Total depens�'
FROM
	[dbo].[tblStatsClients]
GROUP BY
	[Nom du client]
ORDER BY
	[Total depens�] DESC

-- --------------------------------------------------------
-- Afficher la liste des 10 produits les plus profitables

-- Votre code ici


--Tentative 1
SELECT TOP 10
	SC.[Nom du produit]
	,SUM([Nombre de fois achet�]) AS 'Total achet�'
FROM
	[dbo].[tblStatsClients] SC
GROUP BY
	SC.[Nom du produit]
ORDER BY
	[Total achet�] desc


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
	,SUM([Prix unitaire]) AS TotalG�n�r�
	,SUM([Quantit�]) AS TotalQuantit�
FROM 
	[dbo].[Produits] P,
	[dbo].[D�tails des commandes] DC
WHERE
	P.[ID produit] = DC.[ID produit]
GROUP BY
	[Nom du produit]
ORDER BY
	TotalG�n�r� desc