/*************************************************************************************
## Devoir 2 
## ********
**************************************************************************************

## Infos cours
**************
## Cours : Introduction aux bases de données
## Session : Hiver 2025
## Enseignant : Kola Couthon

## Infos étudiant
*****************
## Nom : Lussier
## Prénom : Nathan


## Note : /30
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

## Base de données : School
# *************************

Ce devoir comprend cinq (5) questions. 
Les questions sont indépendantes sauf spécification contraire
******************************************************************************************************/

/******************************************************************************************************
# Requête 1 :  /6pts
====================
Écrire une requête qui affiche les étudiants inscrits entre 2001 et 2004, ayant un nom de famille commençant de A à G inclus.

On affichera les colonnes: 
- Le nom
- Le prénom
- La date d'inscription

La liste sera triée par le nom de l'étudiant

*******************************************************************************************************/
-- # Votre code ici

SELECT
	[LastName]
	,[FirstName]
	,[EnrollmentDate],[Discriminator]
FROM
	[dbo].[Person]
WHERE
	YEAR([EnrollmentDate]) BETWEEN 2001 AND 2004
	AND LEFT([LastName],1) BETWEEN 'A' AND 'G'
	AND [Discriminator] LIKE('Student')
ORDER BY
	[LastName]

/******************************************************************************************************
# Requête 2 : /6pts
====================
Écrire une requête qui affiche les noms des étudiants inscrits à tous les cours d'économie et de mathématiques.

On affichera les colonnes : 
- Le titre du cours
- Le nom complet de l'étudiant

La liste sera triée par cours et par nom de l'étudiant

******************************************************************************************************/
-- # Votre code ici

SELECT
	[Title] AS 'Titre du Cours'
	,CONCAT([FirstName],' ',[LastName]) AS 'Nom Complet Etudiant'
FROM
	[dbo].[Course] C,
	[dbo].[Department] D,
	[dbo].[Person] P
WHERE
	D.DepartmentID = C.DepartmentID AND
	[Discriminator] LIKE('Student')
	AND [Name] IN('Economics', 'Mathematics')
ORDER BY
	[Title]
	,CONCAT([FirstName],' ',[LastName])

/*****************************************************************************************************
# Requête 3 : /6pts
====================
Écrire une requête qui calcule le nombre total de cours dont le nombre de crédits est supérieur à 3
dans chaque département.

On affichera les colonnes :
- Le nom du département
- Le nombre de cours offert dans le département

*****************************************************************************************************/
-- # Votre code ici

SELECT
	[Name] AS 'Nom du Département'
	,COUNT([CourseID]) AS 'Nombre de Cours'
FROM
	[dbo].[Department] D,
	[dbo].[Course] C
WHERE
	C.DepartmentID = D.DepartmentID
	AND [Credits] > 3
GROUP BY
	[Name]

/****************************************************************************************************
# Requête 4 : /6pts
====================
Écrire une requête qui affiche le nombre de cours donnés par chaque enseignant.

On affichera les colonnes:
-- Le nom complet de l'enseignant
-- Le nombre de cours qu'il enseigne
 
La liste sera triée par le nom de l'enseignant
****************************************************************************************************/
-- # Votre code ici

SELECT
	CONCAT([FirstName],' ', [LastName]) AS 'Nom Complet Enseignant'
	,COUNT([CourseID]) AS 'Nombre de Cour'
FROM
	[dbo].[Person] P,
	[dbo].[CourseInstructor] CI
WHERE
	P.PersonID = CI.PersonID AND
	[Discriminator] LIKE('Instructor')
GROUP BY
	CONCAT([FirstName],' ', [LastName])
ORDER BY
	[Nom Complet Enseignant]

/***************************************************************************************************
# Requête 5 : /6pts
====================

Écrire une requête qui affiche la liste des départements dans lesquels il y a au moins deux enseignants.

Démarche suggérée: 
Écrire d'abord la requête qui affiche le département ainsi que les enseignants qui y travaillent.
Ensuite, faire l'agrégat et la condition sur l'agrégat.

On affichera les colonnes :
- Le nom du département
- Le nombre d'enseignants dans chaque département
****************************************************************************************************/
-- # Votre code ici
SELECT
	[Name]
	,COUNT(CI.[PersonID]) AS 'Nombre d''ensaignants'
FROM
	[dbo].[Department] D,
	[dbo].[Person] P,
	[dbo].[CourseInstructor] CI,[dbo].[Course] C
WHERE
	P.PersonID = CI.PersonID AND
	CI.CourseID = C.CourseID AND
	C.DepartmentID = D.DepartmentID AND
	[Discriminator] LIKE('Instructor')
GROUP BY
	[Name]
HAVING
	COUNT(CI.[PersonID]) >= 2


/***************************************************************************************************
***************************************  Fin du devoir *********************************************
***************************************************************************************************/




