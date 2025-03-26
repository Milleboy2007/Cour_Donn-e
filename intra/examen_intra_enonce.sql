/*************************************************************************************
## Examen intra 
## ************
**************************************************************************************

## Infos cours
**************
## Cours : Introduction aux bases de données
## Session : Hiver 2025
## Enseignant : Kola Couthon

## Infos étudiant
*****************
## Nom :
## Prénom :


## Note : /50
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
# Structurez et indentez votre code SQL comme ceci :
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
# Écrivez votre code vis à vis de la question. Par exemple : Le code de la requête 1 DOIT se trouver en dessous de requête 1 et non requête 2. La question obtiendra la note 0 si le faites.
# Si la requête ne produit pas le résultat attendu, la question obtiendra la note 0 (critère)
# Si la requête produit le résultat attendu et qu'il manque une spécification, vous obtiendrez une partie des points. Exemple : Vous oubliez un tri...
# Dans TOUTES les requêtes, utilisez des noms d'alias de votre choix mais SIGNIFICATIFS pour désigner les colonnes lors de l'affichage.

## Base de données à utiliser : BikeStores
# ****************************************
# Vous devez installer la base de données afin de pouvoir réaliser l'examen.
**************************************************************************************/


/*************************************************************************************
# Requête 1 : /3pts
Commentaire :


**************************************************************************************/
-- Votre code ici
SELECT
	 [last_name] AS 'Nom de Famille'
	,[first_name] AS Prénom
	,[phone] AS 'Numéro de téléphone'
	,[city] AS Ville
	,[state] AS État
FROM 
	[sales].[customers]
WHERE
	[phone] IS NOT NULL AND
	[state] IN('CA', 'TX') OR
	[city] LIKE('Long Beach')
ORDER BY
	[state],
	[city],
	[last_name]
	



/*************************************************************************************
# Requête 2 : /5pts
Commentaire :


**************************************************************************************/
-- # Votre code ici
SELECT
	 CONCAT([first_name],' ',[last_name]) AS 'Nom Complet'
	,SUBSTRING([phone],2,3) AS 'Code Régional'
	,[phone] AS 'Numéro de Téléphone'
	,[email] AS Courriel
	,LEFT([street],CHARINDEX(' ', [street])) AS 'numéro Civique'
	,SUBSTRING([street],CHARINDEX(' ', [street])+1,LEN([street])) AS 'Nom de la rue'
	,[street] AS 'Adresse Complète'
	,[city] AS Ville
	,[state] AS État
	,[zip_code] AS 'Code Postal'
	,SUBSTRING([email],CHARINDEX('@', [email])+1,LEN([email])-CHARINDEX('@', [email])-4) AS Fournisseur
FROM 
	[sales].[customers]
WHERE
	[state] LIKE('NY') AND
	[zip_code] LIKE('11%') AND
	[phone] IS NOT NULL

/*************************************************************************************
# Requête 3 : /3pts
Commentaire :


**************************************************************************************/
-- # Votre code ici

SELECT
	 A.[order_id] AS 'Numéro Commande'
	,B.[last_name] AS 'Nom Famille'
	,B.[first_name] AS Prénom
	,A.[order_date] AS 'Date de commande'
	,DATENAME(MONTH,[order_date]) AS 'Mois de commande'
	,[order_status] AS 'Statut de commande'
FROM 
	[sales].[orders] A,
	[sales].[customers] B
WHERE
	A.customer_id = B.customer_id AND
	[shipped_date] IS NULL
ORDER BY
	DATEPART(YEAR,[order_date]),
	[last_name]

/*************************************************************************************
# Requête 4 : /3pts
Commentaire :


**************************************************************************************/
-- # Votre code ici

SELECT
	 DATEPART(YEAR,[order_date]) AS 'Année de commande'
	,COUNT([order_id]) AS 'Nombre de commande'
FROM
	[sales].[orders]
WHERE
	[shipped_date] IS NULL AND
	[order_status] LIKE('3') AND
	[store_id] IN('1','3')
GROUP BY
	DATEPART(YEAR,[order_date])

/*************************************************************************************
# Requête 5 : /3pts
Commentaire :


**************************************************************************************/
-- # Votre code ici

SELECT
	 B.[store_name] AS 'Nom de Boutique'
	,SUM(A.[quantity]) AS 'Quantité En Stock'
FROM
	[production].[stocks] A,
	[sales].[stores] B
WHERE 
	A.store_id = B.store_id
GROUP BY
	B.[store_name]
ORDER BY
	SUM(A.[quantity])

/**************************************************************************************
# Requête 6 :  /4pts
Commentaire :


**************************************************************************************/
-- # Votre code ici
/*SELECT
	 B.[brand_name] AS 'Nom de Boutique'
	,C.[product_name] AS 'Nom du Produit'
	,SUM(C.[product_id]) AS 'Quantité total du Produit'
FROM
	[production].[stocks] A,
	[production].[brands] B,
	[production].[products] C
WHERE 
	A.store_id = B.brand_id AND
	A.product_id = C.product_id AND
	[quantity] LIKE('0')
GROUP BY
	B.[brand_name]*/


/*************************************************************************************
# Requête 7 : /4pts
Commentaire :


**************************************************************************************/
-- # Votre code ici
SELECT
	[store_name] AS 'Nom Boutique'
	,SUM([list_price]*[quantity]-[list_price]*[quantity]*[discount]) AS Chiffre
FROM 
	[sales].[stores] A,
	[sales].[order_items] B
GROUP BY 
	[store_name]
ORDER BY
	SUM([list_price]*[quantity]-[list_price]*[quantity]*[discount]) DESC

/*************************************************************************************
# Requête 8 : /4pts
Commentaire :


**************************************************************************************/
-- # Votre code ici

SELECT
	 CONCAT([last_name],' ',[first_name]) AS 'Nom Complet'
	,SUM([list_price]) AS 'TotalVente'
FROM
	[sales].[staffs] A,
	[production].[products] B
--WHERE

GROUP BY
	CONCAT([last_name],' ',[first_name])
ORDER BY
	SUM([list_price]) DESC

/*************************************************************************************
# Requête 9 : /4pts
Commentaire :


**************************************************************************************/
-- # Votre code ici
SELECT
[product_name],COUNT(A.[list_price])
FROM
	[sales].[order_items]A,
	[production].[products]B
GROUP BY [product_name]


/*************************************************************************************
# Requête 10 : /6pts
Commentaire :


**************************************************************************************/
-- # Votre code ici
SELECT
	[product_name] AS 'Nom Produit',
	COUNT([shipped_date]) AS 'Total Vendu'
FROM 
	[sales].[orders],
	[production].[products]
GROUP BY 
	[product_name]

/*************************************************************************************
# Requête 11 : /6pts
Commentaire :


**************************************************************************************/
-- # Votre code ici
SELECT
	[last_name] AS 'Nom Famille'
	,[first_name] AS Prénom
	,[email] AS Mail
	,[state] AS État
	,[city] AS Ville
	,SUM([quantity]) AS 'Montant Total'
FROM
	[sales].[customers],
	[sales].[order_items]
GROUP BY 
	[last_name],
	[first_name],
	[email],
	[state],
	[city]
ORDER BY
	SUM([quantity])


/*************************************************************************************
# Requête 12 : /5pts
Commentaire :


**************************************************************************************/
-- # Votre code ici
SELECT
	[store_name] AS 'Nom boutique'
	,[brand_name] AS 'Nom Marque'
	,[category_name] AS 'Nom Category'
	,[model_year] AS'Anné du model'
	,[product_name] AS 'Nom Produit'
	,[list_price] AS 'prix produit'
	,[quantity] AS 'Quantité'
FROM
	[production].[brands] A,
	[sales].[stores] B,
	[production].[categories] C,
	[production].[products] D,
	[production].[stocks] E


/* ************************* Fin de l'examen *****************************************/