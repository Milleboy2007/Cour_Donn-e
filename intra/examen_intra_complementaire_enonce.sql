/******************************************************************************************
## Examen intra 
## ************

## Infos cours
**************
## Cours : Introduction aux bases de données
## Session : Hiver 2025

## Infos étudiant
*****************
## Nom : Lussier
## Prénom : Nathan


## Note : /25
## **********

## Bonus : 
## Pénalité : 

Commentaire
***********



# Consignes
# =========
# Pour bien écrire des requêtes, suivez les étapes ci-dessous :
# Consultez la base de données active
# Consultez la structure des tables (le nom des colonnes, le type des colonnes)
# Consultez les valeurs des colonnes
# Identifiez visuellement les enregistrements qui satisfont aux conditions de l'énoncé
# Interprétez bien la question posée et traduisez la en une expression conditionnelle compréhensible par SQL
# Les notions apprises en programmation sont transférables en SQL notamment les expressions conditionnelles
# Séparez les colonnes par des virgules (,) sauf la dernière
# Séparez chaque requête par un point-virgule (;)
# Incluez toujours la ou les colonnes des conditions pour vous assurer que le résultat obtenu est le résultat attendu. Vous pourrez les supprimer par la suite si l'énoncé ne demande pas de les afficher
# Mettez-vous à la place de votre client (celui qui pose la question) afin de comprendre ce qu'il veut
# Apprenez à trouver vos erreurs tout seul. Verifiez que la syntaxe est correcte.
# Pour les requêtes multitables, utilisez la démarche systématique vue en classe, puis procédez graduellement, deux tables à la fois.
# Pour les requêtes multi-critères, évaluez toutes les conditions / critères de l'énoncé
# N'oubliez pas les tris lorsque c'est demandé.


## Important
## *********

# RESPECTEZ LES SPÉCIFICATIONS DE l'ÉNONCÉ
# Indentez votre code SQL comme ci-dessous. 1 pt de pénalité pour code non indenté et propprement formaté.
SELECT
	 Col1
	,Col2
	,Col3
FROM
	table1,
	table2
WHERE
	Cond1 AND
	Cond2 AND 
	Cond3
GROUP BY
	Col
HAVING 
	Condition_groupe
ORDER BY
	Col1,
	Col2

# Écrivez votre code vis à vis de la question. Par exemple : Le code de la requête 1 DOIT se trouver en dessous de requête 1 et non requête 2. La question obtiendra la note 0 si vous le faites.
# Si la requête ne produit pas le résultat attendu, la question obtiendra la note 0 (critère)
# Si la requête produit le résultat attendu et qu'il manque une spécification, vous obtiendrez une partie des points. Exemple : Vous oubliez un tri...
# Dans TOUTES les requêtes, utilisez des noms d'alias de votre choix mais SIGNIFICATIFS pour désigner les colonnes lors de l'affichage.

## Base de données à utiliser : BikeStores
# ****************************************
# Vous devez installer la base de données afin de pouvoir réaliser l'examen.
***********************************************************************************************/

/**********************************************************************************************
# Requête 1 : /3pts
Commentaire :


*********************************************************************************************/
-- # Votre code ici
SELECT
	CONCAT([first_name],' ',[last_name]) AS 'Nom Complet'
	,A.[email] AS 'Courriel'
	,A.[phone] AS 'Téléphone'
	,B.[store_name] AS 'Nom de Boutique'
	,B.[city] AS 'Ville de Boutique'
	,[manager_id]
FROM
	[sales].[staffs] A,
	[sales].[stores] B
WHERE
	B.store_id = A.store_id AND
	[manager_id] IN (1,5)
	                         --Pour trouver ID Manager--
	--CONCAT([first_name],' ',[last_name]) IN ('Venita Daniel', 'Mireya Copeland')--
ORDER BY
	[manager_id]
	


/*******************************************************************************************
# Requête 2 : /5pts
Commentaire :


********************************************************************************************/
-- # Votre code ici
SELECT
	B.[store_name] AS 'Nom Boutique'
	,CONCAT(C.[first_name],' ', C.[last_name]) AS 'Nom Complet Client'
	,A.[order_id] AS 'Numéro Commande'
	,A.[order_date] AS 'Date de Commande'
	,A.[required_date] AS 'Date Requise'
	,A.[shipped_date] AS 'Date de Livraison'
	,DATEDIFF(WEEKDAY,[order_date],[shipped_date]) AS 'Jour de retard'
FROM
	[sales].[orders] A,
	[sales].[stores] B,
	[sales].[customers] C
WHERE
	B.store_id = A.store_id AND
	C.customer_id = A.customer_id AND
	DATEPART(YEAR,[shipped_date]) LIKE(2018) AND
	DATEDIFF(WEEKDAY,[order_date],[shipped_date]) > 1
ORDER BY
	B.[store_name]
	,[order_date]


/******************************************************************************************
# Requête 3 : /5pts
Commentaire :


******************************************************************************************/
-- # Votre code ici
SELECT
	[state]
	,[city]
	,SUM(([list_price]*[quantity]) - ([list_price]*[quantity]*[discount])) AS 'Montant Total'
FROM
	[sales].[customers] A,
	[sales].[order_items] B,
	[sales].[orders] C
WHERE
	DATEPART(YEAR,[shipped_date]) LIKE(2018)
GROUP BY
	[state]
	,[city]
HAVING
	SUM(([list_price]*[quantity]) - ([list_price]*[quantity]*[discount])) > 20000
ORDER BY
	[Montant Total] DESC


/******************************************************************************************
# Requête 4 : /7pts
Commentaire :


******************************************************************************************/
-- # Votre code ici
SELECT
	A.[product_name]
	,SUM(B.[quantity])
	,SUM((B.[list_price]*B.[quantity]) - (B.[list_price]*B.[quantity]*B.[discount])) AS 'Montant Total'
	,AVG((B.[list_price]*B.[quantity]) - (B.[list_price]*B.[quantity]*B.[discount])) AS 'Moyen des Vente'
FROM
	[production].[products] A,
	[sales].[order_items] B
WHERE
	A.product_id = B.product_id
GROUP BY
	A.[product_name]
ORDER BY
	[Montant Total] DESC


/******************************************************************************************
# Requête 5 : /5pts
Commentaire :


******************************************************************************************/
-- # Votre code ici
SELECT
	A.[store_name] AS 'Nom Boutique'
	,B.[brand_name] AS 'Nom de Marque'
	,C.[category_name] AS 'Nom de Catégorie'
	,D.[model_year] AS 'Année de Modèle'
	,D.[product_name] AS 'Nom de Produit'
	,F.[list_price] AS 'Prix de Produit'
	,E.[quantity] AS 'Stock'
FROM
	[sales].[stores] A,
	[production].[brands] B,
	[production].[categories] C,
	[production].[products]D,
	[production].[stocks] E,
	[sales].[order_items] F
WHERE
	[model_year] IN (2017,2018) AND
	B.brand_id = D.brand_id AND
	C.category_id = D.category_id 
--Un Coup lier le prix est le même pour chaque produit et non a sa valeur de vente--
	--AND D.product_id = F.product_id--
ORDER BY
	A.[store_name],
	B.[brand_name],
	C.[category_name],
	D.[model_year],
	D.[product_name]


	

/***************************** Fin de l'examen ******************************************/