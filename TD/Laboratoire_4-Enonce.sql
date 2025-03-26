-- ==============================================================================
-- Description du cours : Introduction au bases de données
-- Code du cours : 420-212-MV
-- Laboratoire 4
-- La clause HAVING et les fonctions

-- Objectif : 
-- Ce Laboratoire vise à acquérir les compétences suivantes
-- ========================================================
-- Les conditions sur les groupes : la clause HAVING
-- Les fonctions :
-- -- de chaines de caractères 
-- -- de date
-- -- Numériques
-- -- de conversion
-- -- de formatage

-- Base de données à utiliser : xtremefr
-- ----------------------------------

--  
-- Les fonctions de manipulation de chaines de caractères
-- La concaténation : CONCAT
-- L'extraction de sous chaine à gauche d'une chaine : LEFT
-- L'extraction de sous chaine à droite d'une chaine : RIGHT
-- Longueur d'une chaine : LEN
-- Posotion d'un caractère dans une chaine : CHARINDEX
-- L'extraction d'une sous chaine : SUBSTRING
--
-- Requête 1
-- Écrire une requete qui affiche la liste des employés en concaténant le nom et le prénom 
-- des employés séparés par une virgule et un espace. 
-- On affichera :
-- Le mom
-- Le prénom
-- Le nom complet

-- Votre code ici
SELECT
[Nom],
[Prénom],
CONCAT([Nom], ' , ',[Prénom]) AS NomComplet
FROM [dbo].[Employés]

-- ---------
-- Requête 2
-- Écrire une requête qui affiche les trois premiers caractères du numéro de sécurité sociale
-- ainsi que les 4 derniers caractères du numéro de sécurité sociale
-- On affichera les mêmes colonnes que la requete précédente plus:
-- Le code sécu (qui représente les premiers caractères ,du numéro de sécurité sociale
-- le code secteur
-- Votre code ici
SELECT
[Nom],
[Prénom],
CONCAT([Nom], ' , ',[Prénom]) AS NomComplet,
[Numéro de sécurité sociale],
LEFT([Numéro de sécurité sociale], 3) AS CodeSecu,
RIGHT([Numéro de sécurité sociale], 4) AS CodeSecteur
FROM [dbo].[Employés]

-- ---------
-- Requête 3 
-- Écrire une requête qui affiche la longueur du numéro de téléphone de l'employé
-- On affichera les mêmes colonnes que la requête précédente plus:
-- Le telphone
-- la longueur du numéro de téléphone

-- Votre code ici
SELECT
[Nom],
[Prénom],
CONCAT([Nom], ' , ',[Prénom]) AS NomComplet,
[Numéro de sécurité sociale],
LEFT([Numéro de sécurité sociale], 3) AS CodeSecu,
RIGHT([Numéro de sécurité sociale], 4) AS CodeSecteur,
[Téléphone personnel],
LEN([Téléphone personnel]) AS LongeurTel
FROM [dbo].[Employés]

-- --------- 
-- Requête 4
-- Utilisation de la fonction CHARINDEX()
-- Écrire une requete qui affiche la position du caractère @ dans la colonne courriel du client
-- On affichera :
-- Le nom du client
-- Le nom complet du contact
-- Le téléphone
-- Le courriel
-- La position du caractère @

-- Votre code ici
SELECT 
[Nom du client],
CONCAT([Nom du contact],' , ',[Prénom du contact]) AS NomCompletContact,
[Téléphone],
[Adresse électronique],
LEFT([Adresse électronique],CHARINDEX('@',[Adresse électronique])-1) AS UserName,
FROM [dbo].[Clients]


-- ----------
-- Requête 5
-- Modifier la requête précédente en rajoutant le nom de domaine du client
-- c'est a dire la partie après @ dans le courriel.
-- On affichera en plus des colonnes précédentes :
-- Le nom de domaine

-- Votre code ici
SELECT 
[Nom du client],
CONCAT([Nom du contact],' , ',[Prénom du contact]) AS NomCompletContact,
[Téléphone],
[Adresse électronique],
LEFT([Adresse électronique],CHARINDEX('@',[Adresse électronique])-1) AS UserName,
RIGHT([Adresse électronique],LEN([Adresse électronique])-(CHARINDEX('@',[Adresse électronique])))
FROM [dbo].[Clients]

-- ----------
-- Requête 6
-- Modifier la requête précédente en rajoutant le nom de domaine du client
-- en utilisant la fonction SUBSTRING(chaine, position, longueur)
-- c'est a dire la partie après @ dans le courriel.
-- On affichera en plus des colonnes précédentes :
-- Le nom de domaine 2

-- Votre code ici
SELECT 
[Nom du client],
CONCAT([Nom du contact],' , ',[Prénom du contact]) AS NomCompletContact,
[Téléphone],
[Adresse électronique],
LEFT([Adresse électronique],CHARINDEX('@',[Adresse électronique])-1) AS UserName,
SUBSTRING([Adresse électronique],CHARINDEX('@',[Adresse électronique])+1,LEN([Adresse électronique]))
FROM [dbo].[Clients]


-- ----------
-- Requête 7
-- Conversion en majuscule UPPER et minuscule LOWER
-- Créer l'adresse courriel des employés de la compagnie xtreme
-- sous la forme initialPrenom.nom@xtreme.com
-- tout en minuscule

-- Votre code ici
SELECT
[Nom],
[Prénom],
LOWER(CONCAT(LEFT([Nom],1),LEFT([Prénom],1),'.'+[Nom],'@xtreme.com')) AS Mail
FROM [dbo].[Employés]

-- ----------
-- Requête 8
-- Manipulation de dates
-- Fonctions de type Date/Heure
-- Utilisation des parties d'une date dans les calculs sur les dates
-- La fonction GETDATE() retourne la date du système
-- La fonction DATEPART(intervalle, date) retourne une partie de la date passée en parametre
-- La fonction FORMAT() formate une date (pas seulement les dates) en fonction des paramètres fournis
-- La fiocntion DATEADD() effectue une opération sur les dates en ajoutant une valeur à une partie de date
-- La foinction DATEDIFF() effectue une opération sur les dates en soustrayant deux dates
------------------------------------------------------------------------------------------

-- Votre code ici
SELECT
	GETDATE(),
	YEAR(GETDATE()),
	MONTH(GETDATE()),
	DAY(GETDATE()),

	DATEPART(YEAR, GETDATE()),
	DATEPART(MONTH, GETDATE()),
	DATEPART(DAY, GETDATE()),
	DATEPART(HOUR, GETDATE()),

	DATENAME(MONTH,GETDATE()),
	DATENAME(QUARTER, GETDATE()) AS TRIMESTRE,
	DATENAME(WEEKDAY,GETDATE()),

	DATEDIFF(YEAR,'2000-01-01',GETDATE()) AS AGE,
	DATEDIFF(MONTH,'2000-01-01', GETDATE()),
	DATEDIFF(DAY,'2000-01-01', GETDATE()),

	DATEADD(DAY,10,GETDATE()) AS DATEADD, --CAN PUT IN NEGATIVE
	DATEADD(MONTH,10,GETDATE()),		  --CAN PUT IN NEGATIVE
	DATEADD(YEAR,10,GETDATE())			  --CAN PUT IN NEGATIVE
-- ----------
-- Requête 9
-- Fonctions de conversion
-- CAST et CONVERT
-- Ces fonctions convertissent un type de données en un autre
-- ATTENTION, l'utilisation des opérateurs arithmétiques ' - ' et ' + ' avec les
-- fonctions CAST et CONVERT

-- Votre code ici
SELECT 

    --Mois--
	/*GETDATE()
	,FORMAT(GETDATE(),'MMMM','en-US')
	,FORMAT(GETDATE(),'MMMM','fr-CA')
	,FORMAT(GETDATE(),'MMMM','es-es')*/

	--Numérique--
	/*FORMAT(1234.5678,'N','en-US')
	,FORMAT(1234.5678,'N','fr-CA')
	,FORMAT(1234.5678,'N','es-es')
	,FORMAT(1234.5678,'N','fr-FR')*/

	--Currenci (Money)--
	/*FORMAT(1234.5678,'C','en-US')
	,FORMAT(1234.5678,'C','fr-CA')
	,FORMAT(1234.5678,'C','es-es')
	,FORMAT(1234.5678,'C','fr-FR')*/

	--CAST--
	/*CAST(GETDATE() AS date)
	,CAST(12345.6789 AS int)
	,CAST(12345 AS decimal(7, 2))*/

	--CONVERT--
	CONVERT(date,GETDATE())
	,CONVERT(int, 12345.6789)
	,CONVERT(decimal(7,2),12345)





-- ----------
-- Requête 10
-- Créer une requête qui calcule et affiche les informations suivantes : 
-- Calculer l'age de l'employé
-- Calculer l'ancienneté de l'employé
-- Calculer le salaire hebdomadaire des employés
-- Calculer l'indicatif régional du téléphone sachant que ce sont les 3 premiers caractères du téléphone
-- On affichera :
-- -- Le nom complet sous la forme Prénom, Nom
-- -- Le poste occupé
-- -- La date de naissance
-- -- L'age
-- -- La date d'embauche
-- -- L'ancienneté
-- -- Le salaire
-- -- Le salaire hebdomandaire avec 2 décimales
-- -- Le téléphone
-- -- Le code régional
-- -- Le numéro de sécu
-- La liste sera triée du plus ancien au plus nouveau

-- Votre code ici


-- --------
-- Conditions sur les regroupements. La clause HAVING
-- Requête 11
-- 
-- Écrire une requête qui affiche les classes de produits avec un prix moyen de produit supérieur à 100$.
-- On affichera : 
-- -- La classe du produit
-- -- Le prix moyen conseillé
--
-- Démarche :
-- -- Écrire la requête avec aggrégat en premier
-- -- Écrire la condition sur l'aggrégat ensuite.

-- Votre code ici
SELECT
	[Classe du produit],
	AVG([Prix conseillé]) AS PrixMoyen
FROM [dbo].[Produits]
GROUP BY [Classe du produit]
HAVING AVG([Prix conseillé]) > 100

-- -----------
-- Requête 12
--
-- Afficher les classes  de produits avec plus de 45 produits dans chaque classe.
-- On affichera la classe du produit et le nombre de produits dans chaque classe
--
-- Démarche :
-- -- Écrire la requête avec aggrégat en premier
-- -- Écrire la condition sur l'aggrégat ensuite.

-- Votre code ici

SELECT
[Classe du produit],
COUNT([ID produit])
FROM [dbo].[Produits]
GROUP BY [Classe du produit]
HAVING COUNT([ID produit]) > 45

-- -------------
-- Requete 13 
--
-- Écrire une requête qui affiche les employés ayant traité plus de 350 commandes.
-- On affichera 
-- -- l'ID de l'employé, 
-- -- son nom ainsi que 
-- -- le nombre de commandes traitées
--
-- Démarche :
-- -- Écrire la requête avec aggrégat en premier
-- -- Écrire la condition sur l'aggrégat ensuite.

-- Ajouter une condition pour les employés qui relèvent du supérieur 2

-- Votre code ici
SELECT
	A.[ID employé],
	A.[Nom],
	COUNT([ID commande])
FROM 
	[dbo].[Employés] A,
	[dbo].[Commandes] B
WHERE A.[ID employé] = B.[ID employé]
GROUP BY 
	A.[ID employé], 
	A.[Nom]
HAVING COUNT([ID commande]) > 350

-- -------------------
-- Requête 14 
--
-- Écrire une requête qui affiche la liste des clients ayant passé plus de 3 commandes.
-- On affichera le nom du client et le total de ses commandes
--
-- Démarche :
-- -- Écrire la requête avec aggrégat en premier
-- -- Écrire la condition sur l'aggrégat ensuite.

-- Votre code ici
SELECT
	A.[ID client],
	A.[Nom du client],
	COUNT([Commande expédiée])
FROM 
	[dbo].[Clients] A,
	[dbo].[Commandes] B
WHERE A.[ID client] = B.[ID client]
GROUP BY 
	A.[ID client], 
	A.[Nom du client]
HAVING COUNT([Commande expédiée]) > 3


-- Requête 15
--
-- Afficher les clients ayant dépensé plus de 5000$ au total.
-- On affichera : 
-- -- le nom du client
-- -- le total de ses commandes
--
-- Démarche :
-- -- Écrire la requête avec aggrégat en premier
-- -- Écrire la condition sur l'aggrégat ensuite.

-- Votre code ici
SELECT
	A.[Nom du client],
	SUM([Montant commande])
FROM 
	[dbo].[Clients] A,
	[dbo].[Commandes] B
WHERE A.[ID client] = B.[ID client]
GROUP BY 
	A.[ID client], 
	A.[Nom du client]
HAVING SUM([Montant commande]) > 5000








--Requête 16--
SELECT
	[Nom du client]
	,[Titre]
	,CASE 
			WHEN [Titre] = 'M.' THEN 'M' 
			WHEN [Titre] IN ('Melle','Mme') THEN 'F' 
		ELSE 'Autre' 
		END Genre
	,[Poste occupé]
	,CASE 
			WHEN [Poste occupé] LIKE ('%vente%') OR [Poste occupé] LIKE('Représentant') THEN 'Département des ventes' 
			WHEN [Poste occupé] IN ('Associé','Propriétaire') THEN 'Direction générale' 
		ELSE 'Autre Département' 
		END Département
	,CASE 
			WHEN [Ventes de l'année dernière] <= 50000 THEN '5%' 
			WHEN [Ventes de l'année dernière] BETWEEN 100000 AND 30000 THEN '7%'
			WHEN [Ventes de l'année dernière] > 300000 THEN '15%'
		END Remise
	,[Ventes de l'année dernière]
	
	,[Pays]

FROM [dbo].[Clients]
ORDER BY Département