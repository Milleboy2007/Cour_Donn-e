-- ==============================================================================
-- Description du cours : Introduction au bases de donn�es
-- Code du cours : 420-212-MV
-- Laboratoire 4
-- La clause HAVING et les fonctions

-- Objectif : 
-- Ce Laboratoire vise � acqu�rir les comp�tences suivantes
-- ========================================================
-- Les conditions sur les groupes : la clause HAVING
-- Les fonctions :
-- -- de chaines de caract�res 
-- -- de date
-- -- Num�riques
-- -- de conversion
-- -- de formatage

-- Base de donn�es � utiliser : xtremefr
-- ----------------------------------

--  
-- Les fonctions de manipulation de chaines de caract�res
-- La concat�nation : CONCAT
-- L'extraction de sous chaine � gauche d'une chaine : LEFT
-- L'extraction de sous chaine � droite d'une chaine : RIGHT
-- Longueur d'une chaine : LEN
-- Posotion d'un caract�re dans une chaine : CHARINDEX
-- L'extraction d'une sous chaine : SUBSTRING
--
-- Requ�te 1
-- �crire une requete qui affiche la liste des employ�s en concat�nant le nom et le pr�nom 
-- des employ�s s�par�s par une virgule et un espace. 
-- On affichera :
-- Le mom
-- Le pr�nom
-- Le nom complet

-- Votre code ici
SELECT
[Nom],
[Pr�nom],
CONCAT([Nom], ' , ',[Pr�nom]) AS NomComplet
FROM [dbo].[Employ�s]

-- ---------
-- Requ�te 2
-- �crire une requ�te qui affiche les trois premiers caract�res du num�ro de s�curit� sociale
-- ainsi que les 4 derniers caract�res du num�ro de s�curit� sociale
-- On affichera les m�mes colonnes que la requete pr�c�dente plus:
-- Le code s�cu (qui repr�sente les premiers caract�res ,du num�ro de s�curit� sociale
-- le code secteur
-- Votre code ici
SELECT
[Nom],
[Pr�nom],
CONCAT([Nom], ' , ',[Pr�nom]) AS NomComplet,
[Num�ro de s�curit� sociale],
LEFT([Num�ro de s�curit� sociale], 3) AS CodeSecu,
RIGHT([Num�ro de s�curit� sociale], 4) AS CodeSecteur
FROM [dbo].[Employ�s]

-- ---------
-- Requ�te 3 
-- �crire une requ�te qui affiche la longueur du num�ro de t�l�phone de l'employ�
-- On affichera les m�mes colonnes que la requ�te pr�c�dente plus:
-- Le telphone
-- la longueur du num�ro de t�l�phone

-- Votre code ici
SELECT
[Nom],
[Pr�nom],
CONCAT([Nom], ' , ',[Pr�nom]) AS NomComplet,
[Num�ro de s�curit� sociale],
LEFT([Num�ro de s�curit� sociale], 3) AS CodeSecu,
RIGHT([Num�ro de s�curit� sociale], 4) AS CodeSecteur,
[T�l�phone personnel],
LEN([T�l�phone personnel]) AS LongeurTel
FROM [dbo].[Employ�s]

-- --------- 
-- Requ�te 4
-- Utilisation de la fonction CHARINDEX()
-- �crire une requete qui affiche la position du caract�re @ dans la colonne courriel du client
-- On affichera :
-- Le nom du client
-- Le nom complet du contact
-- Le t�l�phone
-- Le courriel
-- La position du caract�re @

-- Votre code ici
SELECT 
[Nom du client],
CONCAT([Nom du contact],' , ',[Pr�nom du contact]) AS NomCompletContact,
[T�l�phone],
[Adresse �lectronique],
LEFT([Adresse �lectronique],CHARINDEX('@',[Adresse �lectronique])-1) AS UserName,
FROM [dbo].[Clients]


-- ----------
-- Requ�te 5
-- Modifier la requ�te pr�c�dente en rajoutant le nom de domaine du client
-- c'est a dire la partie apr�s @ dans le courriel.
-- On affichera en plus des colonnes pr�c�dentes :
-- Le nom de domaine

-- Votre code ici
SELECT 
[Nom du client],
CONCAT([Nom du contact],' , ',[Pr�nom du contact]) AS NomCompletContact,
[T�l�phone],
[Adresse �lectronique],
LEFT([Adresse �lectronique],CHARINDEX('@',[Adresse �lectronique])-1) AS UserName,
RIGHT([Adresse �lectronique],LEN([Adresse �lectronique])-(CHARINDEX('@',[Adresse �lectronique])))
FROM [dbo].[Clients]

-- ----------
-- Requ�te 6
-- Modifier la requ�te pr�c�dente en rajoutant le nom de domaine du client
-- en utilisant la fonction SUBSTRING(chaine, position, longueur)
-- c'est a dire la partie apr�s @ dans le courriel.
-- On affichera en plus des colonnes pr�c�dentes :
-- Le nom de domaine 2

-- Votre code ici
SELECT 
[Nom du client],
CONCAT([Nom du contact],' , ',[Pr�nom du contact]) AS NomCompletContact,
[T�l�phone],
[Adresse �lectronique],
LEFT([Adresse �lectronique],CHARINDEX('@',[Adresse �lectronique])-1) AS UserName,
SUBSTRING([Adresse �lectronique],CHARINDEX('@',[Adresse �lectronique])+1,LEN([Adresse �lectronique]))
FROM [dbo].[Clients]


-- ----------
-- Requ�te 7
-- Conversion en majuscule UPPER et minuscule LOWER
-- Cr�er l'adresse courriel des employ�s de la compagnie xtreme
-- sous la forme initialPrenom.nom@xtreme.com
-- tout en minuscule

-- Votre code ici
SELECT
[Nom],
[Pr�nom],
LOWER(CONCAT(LEFT([Nom],1),LEFT([Pr�nom],1),'.'+[Nom],'@xtreme.com')) AS Mail
FROM [dbo].[Employ�s]

-- ----------
-- Requ�te 8
-- Manipulation de dates
-- Fonctions de type Date/Heure
-- Utilisation des parties d'une date dans les calculs sur les dates
-- La fonction GETDATE() retourne la date du syst�me
-- La fonction DATEPART(intervalle, date) retourne une partie de la date pass�e en parametre
-- La fonction FORMAT() formate une date (pas seulement les dates) en fonction des param�tres fournis
-- La fiocntion DATEADD() effectue une op�ration sur les dates en ajoutant une valeur � une partie de date
-- La foinction DATEDIFF() effectue une op�ration sur les dates en soustrayant deux dates
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
-- Requ�te 9
-- Fonctions de conversion
-- CAST et CONVERT
-- Ces fonctions convertissent un type de donn�es en un autre
-- ATTENTION, l'utilisation des op�rateurs arithm�tiques ' - ' et ' + ' avec les
-- fonctions CAST et CONVERT

-- Votre code ici
SELECT 

    --Mois--
	/*GETDATE()
	,FORMAT(GETDATE(),'MMMM','en-US')
	,FORMAT(GETDATE(),'MMMM','fr-CA')
	,FORMAT(GETDATE(),'MMMM','es-es')*/

	--Num�rique--
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
-- Requ�te 10
-- Cr�er une requ�te qui calcule et affiche les informations suivantes : 
-- Calculer l'age de l'employ�
-- Calculer l'anciennet� de l'employ�
-- Calculer le salaire hebdomadaire des employ�s
-- Calculer l'indicatif r�gional du t�l�phone sachant que ce sont les 3 premiers caract�res du t�l�phone
-- On affichera :
-- -- Le nom complet sous la forme Pr�nom, Nom
-- -- Le poste occup�
-- -- La date de naissance
-- -- L'age
-- -- La date d'embauche
-- -- L'anciennet�
-- -- Le salaire
-- -- Le salaire hebdomandaire avec 2 d�cimales
-- -- Le t�l�phone
-- -- Le code r�gional
-- -- Le num�ro de s�cu
-- La liste sera tri�e du plus ancien au plus nouveau

-- Votre code ici


-- --------
-- Conditions sur les regroupements. La clause HAVING
-- Requ�te 11
-- 
-- �crire une requ�te qui affiche les classes de produits avec un prix moyen de produit sup�rieur � 100$.
-- On affichera : 
-- -- La classe du produit
-- -- Le prix moyen conseill�
--
-- D�marche :
-- -- �crire la requ�te avec aggr�gat en premier
-- -- �crire la condition sur l'aggr�gat ensuite.

-- Votre code ici
SELECT
	[Classe du produit],
	AVG([Prix conseill�]) AS PrixMoyen
FROM [dbo].[Produits]
GROUP BY [Classe du produit]
HAVING AVG([Prix conseill�]) > 100

-- -----------
-- Requ�te 12
--
-- Afficher les classes  de produits avec plus de 45 produits dans chaque classe.
-- On affichera la classe du produit et le nombre de produits dans chaque classe
--
-- D�marche :
-- -- �crire la requ�te avec aggr�gat en premier
-- -- �crire la condition sur l'aggr�gat ensuite.

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
-- �crire une requ�te qui affiche les employ�s ayant trait� plus de 350 commandes.
-- On affichera 
-- -- l'ID de l'employ�, 
-- -- son nom ainsi que 
-- -- le nombre de commandes trait�es
--
-- D�marche :
-- -- �crire la requ�te avec aggr�gat en premier
-- -- �crire la condition sur l'aggr�gat ensuite.

-- Ajouter une condition pour les employ�s qui rel�vent du sup�rieur 2

-- Votre code ici
SELECT
	A.[ID employ�],
	A.[Nom],
	COUNT([ID commande])
FROM 
	[dbo].[Employ�s] A,
	[dbo].[Commandes] B
WHERE A.[ID employ�] = B.[ID employ�]
GROUP BY 
	A.[ID employ�], 
	A.[Nom]
HAVING COUNT([ID commande]) > 350

-- -------------------
-- Requ�te 14 
--
-- �crire une requ�te qui affiche la liste des clients ayant pass� plus de 3 commandes.
-- On affichera le nom du client et le total de ses commandes
--
-- D�marche :
-- -- �crire la requ�te avec aggr�gat en premier
-- -- �crire la condition sur l'aggr�gat ensuite.

-- Votre code ici
SELECT
	A.[ID client],
	A.[Nom du client],
	COUNT([Commande exp�di�e])
FROM 
	[dbo].[Clients] A,
	[dbo].[Commandes] B
WHERE A.[ID client] = B.[ID client]
GROUP BY 
	A.[ID client], 
	A.[Nom du client]
HAVING COUNT([Commande exp�di�e]) > 3


-- Requ�te 15
--
-- Afficher les clients ayant d�pens� plus de 5000$ au total.
-- On affichera : 
-- -- le nom du client
-- -- le total de ses commandes
--
-- D�marche :
-- -- �crire la requ�te avec aggr�gat en premier
-- -- �crire la condition sur l'aggr�gat ensuite.

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








--Requ�te 16--
SELECT
	[Nom du client]
	,[Titre]
	,CASE 
			WHEN [Titre] = 'M.' THEN 'M' 
			WHEN [Titre] IN ('Melle','Mme') THEN 'F' 
		ELSE 'Autre' 
		END Genre
	,[Poste occup�]
	,CASE 
			WHEN [Poste occup�] LIKE ('%vente%') OR [Poste occup�] LIKE('Repr�sentant') THEN 'D�partement des ventes' 
			WHEN [Poste occup�] IN ('Associ�','Propri�taire') THEN 'Direction g�n�rale' 
		ELSE 'Autre D�partement' 
		END D�partement
	,CASE 
			WHEN [Ventes de l'ann�e derni�re] <= 50000 THEN '5%' 
			WHEN [Ventes de l'ann�e derni�re] BETWEEN 100000 AND 30000 THEN '7%'
			WHEN [Ventes de l'ann�e derni�re] > 300000 THEN '15%'
		END Remise
	,[Ventes de l'ann�e derni�re]
	
	,[Pays]

FROM [dbo].[Clients]
ORDER BY D�partement