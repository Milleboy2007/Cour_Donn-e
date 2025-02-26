/***
Devoir 1 
********

## Cours : Introduction aux bases de données
## Session : Hiver 2025

**************************************************************
*** LIRE ATTENTIVEMENT LES CONSIGNES ET L'ÉNONCÉ DU DEVOIR ***
**************************************************************

# Consignes
# =========

# INSCRIVEZ VOS NOM ET PRENOM. Je ne pourrai pas savoir à qui appartient la copie sinon.

# Pour bien écrire des requêtes, suivez les étapes ci-dessous :
# - Consultez la base de données active.
# - Consultez la structure des tables (le nom des colonnes, le type des colonnes).
# - Consultez les valeurs des colonnes.
# - Identifier visuellement les enregistrements qui satisfont aux conditions de l'énoncé.
# - Interprétez bien la question posée et traduisez la en une expression conditionnelle compréhensible par SQL.

# Les notions apprises en programmation sont transférables en SQL notamment les expressions conditionnelles.
# - Séparez les colonnes par des virgules (,) sauf la dernière.
# - Séparez chaque requête par un point-virgule (;)
# - Incluez toujours la ou les colonnes des conditions pour vous assurer que le réultat obtenu est le résultat attendu
# - Mettez-vous à la place de celui qui pose la question afin de comprendre ce qu'il veut.
# - Apprenez à trouver vos erreurs tout seul au lieu de dire "ca marche pas" car pendant les évaluations, je ne donnerai pas les réponses.
# - Les questions sont indépendantes les unes des autres sauf indication contraire.
# - Répondez aux questions pour lesquelles vous avez la réponse. Revenez sur les questions qui vous paraissent diffciles plus tard.
# - Écrivez votre réquête en dessous de la ligne "Votre code ici"
# - Ne changez pas l'ordre des requêtes

## Important
## *********

# RESPECTEZ LES SPÉCIFICATIONS DE l'ÉNONCÉ

# Si la requête ne produit pas le résultat attendu, la question obtiendra la note 0.

# Étudiant
# ========

## Nom : Lussier
## Prénom : Nathan

## Note : /30
## **********
 
## Base de données à utiliser pour cette évaluation : Northwind

1- Téléchargez le script Northwind_DB.sql à partir d'Omnivox
2- Exécutez le script pour installer la base de données

Ce devoir comprend dix (10) questions. Les questions sont 

/***************************************************************************
# Requête 1 : /2pts
====================

Écrire une requête qui affiche la liste des clients.
On affichera les colonnes Country, City, CustomerName, ContactName, Address
La liste sera triée par Country, CustomerName
Table : Customers
****************************************************************************/
-- Votre code ici */

SELECT [Country],
[City],
[CustomerName],
[ContactName],
[Address]
FROM [dbo].[Customers]
ORDER BY [Country], [CustomerName]





/****************************************************************************************
# Requête 2 : /2pts
====================

Écrire une requête qui affiche la liste des différents pays d'ou proviennent les clients.
On affichera la colonne Country
La liste sera triée par Country
Table : Customers
*****************************************************************************************/
-- # Votre code ici
SELECT DISTINCT [Country]
FROM [dbo].[Customers]
ORDER BY [Country]



/****************************************************************************************
# Requête 3 : /2pts
====================

Écrire une requête qui affiche la liste des clients dont le pays (country) est : 
Brazil, Italy, Spain et Austria
On affichera les colonnes CustomerName, ContactName, Address, Country, City
La liste sera triée par CustomerName
Table : Customers
*****************************************************************************************/
-- # Votre code ici
SELECT [CustomerName],
[ContactName],
[Address],
[Country],
[City]
FROM [dbo].[Customers]
WHERE [Country] IN('Brazil','Italy','Spain','Austria')
ORDER BY [CustomerName]


/***************************************************************************************
# Requête 4 : /2pts
====================

Écrire une requête qui affiche la liste des clients n'ayant pas de code postal (PostalCode)
On affichera les colonnes CustomerName, ContactName, PostalCode, Country, City
La liste sera triée par Country
Table : Customers
****************************************************************************************/
-- # Votre code ici
SELECT [CustomerName],
[ContactName],
[PostalCode],
[Country],
[City]
FROM [dbo].[Customers]
WHERE [PostalCode] IS NULL OR [PostalCode] = ''
ORDER BY [Country]


/************************************************************************************
# Requête 5 : /2pts
====================

Écrire une requête qui affiche la liste des employés.
On affichera les colonnes suivantes : 
- Le NomComplet qui contient le nom et le prénom sous la forme Nom, Prenom
- le Courriel sous la forme : Prenom.Nom@northwind.com
- La date de naissance
La liste sera triée du plus agé au plus jeune.
Table : Employees
**************************************************************************************/
-- # Votre code ici
SELECT [LastName] + ', ' + [FirstName] AS NomComplet,
[LastName] + '.' + [FirstName] + '@northwind.com' AS Courriel,
[BirthDate] AS 'Date de naissance'
FROM [dbo].[Employees]


/******************************************************************************************************
# Requête 6 :  /2pts
====================

Écrire une requête qui affiche la liste des employés ayant les diplômes suivants :
Un MBA, Ph.D et BA
On affichera les colonnes LastName, FirstName, BirthDate
Table : Employees
*******************************************************************************************************/
-- # Votre code ici
SELECT [LastName],
[FirstName],
[BirthDate]
FROM [dbo].[Employees]
WHERE [Notes] LIKE('%BA%') OR [Notes] LIKE('%Ph.D%') OR [Notes] LIKE('%BA%')


/***********************************************************************************
# Requête 7 : /2pts
====================

Écrire une requête qui affiche la liste des produits de catégorie 1, 2, 6 des fournisseurs (suppliers) 2, 20, 25 et 
dont le prix est supérieur à 20$.
On affichera les colonnes le nom du produit, sa catégorie, le fournisseur et le prix
La liste sera triée par categorie et du plus cher au moins cher dans la catégorie
***********************************************************************************/
-- # Votre code ici
SELECT [ProductName],
[CategoryName],
[ShipperName],
[Price]
FROM [dbo].[Products], [dbo].[Categories], [dbo].[Shippers]
SELECT [CategoryID] FROM [dbo].[Products] WHERE [CategoryID] IN('1','2','6') AND [SupplierID] IN('2','20','25') AND [Price] > 20
ORDER BY [Price] DESC



/**********************************************************************************************
# Requête 8 : /2pts
====================

A cause de l'inflation, l'entreprise décide d'augmenter le prix de ses produits
Elle décide donc d'appliquer une hausse de 9% aux produits dont le prix est supérieur ou égal à 40$
Écrire une requête qui affiche la liste des produits affectés par cette augmentation.
On affichera les colonnes ProductName, QuantityPerUnit, UnitPrice, NouveauPrix
La liste sera triée par l'ancien prix
*********************************************************************************************/
-- # Votre code ici
SELECT [ProductName],
[Price],
[Price] + (0.09 * [Price]) AS 'NouveauPrix'
FROM [dbo].[Products]
WHERE [Price] >= 40
ORDER BY [Price]


/*******************************************************************************************
# Requête 9 : /2pts
====================

Écrire une requête qui calcule le prix moyen des produits vendus par l'entreprise Northwind 
selon leur catégorie.
On affichera les colonnes suivantes : 
- Le numero de la catégorie, 
- le nombre de produits, 
- le prix moyen des produits, 
- le produit le plus cher, 
- le produit le moins cher pour chaque
- 
********************************************************************************************/
-- # Votre code ici
SELECT [CategoryID],
COUNT([Unit]) 'Nombre de prouit',
AVG([Price]) 'Prix moyen',
MAX([Price]) 'Prix maximum',
MIN([Price]) 'Prix minimum'
FROM [dbo].[Products]
GROUP BY [CategoryID]


/******************************************************************************************
# Requête 10 : /2pts
====================

Écrire une requête qui calule le nombre de commandes livrées
par chaque compagnie de livraison
On affichera les colonnes 
Le numero du livreur,
Le nombre de commandes livrées

******************************************************************************************/
-- # Votre code ici
SELECT [ShipperID],
COUNT([OrderDate]) 'Nombre de commandes livrées'
FROM [dbo].[Orders]
GROUP BY [ShipperID]

