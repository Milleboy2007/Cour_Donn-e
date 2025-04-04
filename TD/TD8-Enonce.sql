-- ---------------------------------------------------------
-- Collège Marie Victorin
-- Introduction aux bases de données
-- Travaux dirigés 8
-- Les requêtes multitables, GROUP BY, HAVING
-- ---------------------------------------------------------

-- Base de données : School

-- En utilisant la base de données "School" créer les requêtes qui correspondent aux énoncés suivants.

-- Requête 1
-- Écrire une requête qui affiche tous les étudiants (Person) ayant une date d'inscription (EnrollmentDate) non nulle..
-- On affichera le nom, le prénom et la date d'inscription
-- La liste sera triée par la date d'inscription
-- La colonne "Date d'inscription" sera du type Date et non du type DateTime

-- Votre code ici
ALTER TABLE [dbo].[Person]
	ALTER COLUMN [EnrollmentDate] DATE;

SELECT
	[FirstName]
	,[LastName]
	,[EnrollmentDate]
FROM [dbo].[Person]
WHERE
	[EnrollmentDate] IS NOT NULL AND
	[Discriminator] LIKE('Student')
ORDER BY
	[EnrollmentDate]


/**************************************************************************************************************************************
-- Requête 2
Écrire une requête qui affiche tous les enseignants (Person) embauchés avant l'an 2000 et dont le nom commence par "S".
On affichera les colonnes :
- Le nom
- Le prénom
- L'année d'embauche
**************************************************************************************************************************************/
-- Votre code ici
SELECT
	[LastName]
	,[FirstName]
	,YEAR([HireDate]) AS 'Annee d''embauche'
FROM [dbo].[Person]
WHERE
	[HireDate] IS NOT NULL AND
	[Discriminator] LIKE('Instructor') AND
	YEAR([HireDate]) < 2000 AND
	[LastName] LIKE('S%')


/**************************************************************************************************************************************
-- Requête 3
Écrire une requête qui affiche les étudiants inscrits avant 2010, ayant un prénom contenant "e", et un nom de famille contenant "o".
On affichera les colonnes :
- Le nom
- Le prénom
- La date d'inscription

**************************************************************************************************************************************/
-- Votre code ici
SELECT
	[LastName]
	,[FirstName]
	,[EnrollmentDate]
FROM [dbo].[Person]
WHERE
	[EnrollmentDate] IS NOT NULL AND
	[Discriminator] LIKE('Student') AND
	YEAR([EnrollmentDate]) < 2010 AND
	[FirstName] LIKE('%e%') AND
	[LastName] LIKE('%o%')
ORDER BY
	[EnrollmentDate]


/**************************************************************************************************************************************
** créée une table nommée tblEnseignants qui contien uniquement les enseignants à partir de la table Person **
-- Requête 4
Écrire une requête qui affiche les enseignants embauchés entre 1997 et 2002
On affichera les colonnes :
- Le nom
- Le prénom
- La date d'embauche
- Le titre
- L'ancienneté

La liste sera triée par l'enseignant du plus ancien au moins ancien.
**************************************************************************************************************************************/
-- Votre code ici
SELECT *
INTO tblEnseignants
FROM [dbo].[Person]
WHERE 
	[HireDate] IS NOT NULL AND
	[Discriminator] LIKE('Instructor')


SELECT
	[LastName]
	,[FirstName]
	,[HireDate]
	,[Discriminator]
	,DATEDIFF(YEAR,[HireDate],GETDATE()) AS 'Ancienneté (ans)'
FROM 
	[dbo].[tblEnseignants]
WHERE
	YEAR([HireDate]) BETWEEN 1997 AND 2002
ORDER BY
	DATEDIFF(YEAR,[HireDate],GETDATE()) DESC

/**************************************************************************************************************************************
-- Requête 5
Écrire une requête qui affiche les étudiants inscrits entre 2001 et 2004, inclus.
On affichera las colonnes: 
- Le nom
- Le prénom
- La date d'inscription

La liste sera triée par le nom de l'étudiant

**************************************************************************************************************************************/
-- Votre code ici

SELECT
	[LastName]
	,[FirstName]
	,[EnrollmentDate]
FROM 
	[dbo].[Person]
WHERE
	YEAR([EnrollmentDate]) BETWEEN 2001 AND 2004

/**************************************************************************************************************************************
-- Requête 6
Écrire une requête qui affiche tous les cours (Course) avec leurs départements associés (Department)
On affichera les colonnes :
- Le département
- Le titre du cours

La liste sera triée par Département

**************************************************************************************************************************************/
-- Votre code ici
SELECT
	[Name]
	,[Title]
FROM
	[dbo].[Department] A,
	[dbo].[Course] B
ORDER BY
	A.[Name]

	


/**************************************************************************************************************************************
-- Requête 7
Écrire une requête qui affiche les noms des étudiants inscrits aux cours de Micro, Macro économie et Physique
On affichera les colonnes : 
- Le titre du cours
- Le nom complet de l'étudiant

La liste sera triée par cours et par nom de l'étudiant

**************************************************************************************************************************************/
-- Votre code ici
SELECT
	[Title]
	,CONCAT([FirstName],[LastName]) AS 'Nom Complet'
FROM
	[dbo].[Course] A,
	[dbo].[Person] B
WHERE
	[Title] in('Microeconomics','Physics','Macroeconomics')
ORDER BY
	[Title],
	CONCAT([FirstName],[LastName])

/**************************************************************************************************************************************
-- Requête 8
---
-- Écrire une requête qui affiche les listes de classe par département des étudiant ayant obtenu une note.
-- On affichera les colonnes :
-- Le département
-- Le nom de l'enseignant
-- Le prénom de l'enseignant
-- Le titre du cours
-- Le nom de l'étudiant
-- Le prénom de l'étudiant
-- La note de l'étudiant

-- La liste sera triée par département et par enseignant

**************************************************************************************************************************************/
-- Votre code ici
SELECT
	[Name]
	,CONCAT(A.[LastName],' ', A.[FirstName]) AS NomEnseignant
	,[Title]
	,CONCAT(A.[LastName],' ', A.[FirstName]) AS 'Nom Élève'
	,[Grade]
FROM
	[dbo].[Person] A,
	[dbo].[Department] B,
	[dbo].[StudentGrade] C,
	[dbo].[Course] D
	--,[dbo].[CourseInstructor] E
WHERE
	C.StudentID = A.PersonID AND
	B.DepartmentID = D.DepartmentID AND
	D.CourseID = C.CourseID AND
	--C.StudentID = E.PersonID AND
	[Grade] IS NOT NULL
--HAVING
	--NomEnseignant NOT LIKE([StudentID])
ORDER BY
	[Name]



/**************************************************************************************************************************************
-- Requête 8-1
--------------
-- Écrire une requête qui crée une table tblListeClasse avec le résultat de la requête 8.
-- Ajouter la clé primaire ClasseID qui contient un identificateur unique.
-- La structure de la table tblListeClasse est :

-- ClasseID identificateur unique, clé primaire
-- Le département
-- Le nom et le prénom de l'enseignant
-- Le titre du cours
-- Le nom et le prénom de l'étudiant
-- La note de l'étudiant

**************************************************************************************************************************************/
-- Votre code ici

-- Vérification de la création de la table


-- Ajouter la clé primaire


-- Vérifier la création de structure de la table



/**************************************************************************************************************************************
-- Requête 9
Écrire une requête qui affiche les noms des enseignanta dans des départements spécifique (par exemple, département Mathématiques, Anglais)
qui ont été embauch à partir de de l'année 1999.

On affichera les colonnes :
- Le département
- Le nom complet de l'enseignant
- Le titre (en guise de vérification)
**************************************************************************************************************************************/
-- Votre code ici



/**************************************************************************************************************************************
-- Requête 10
Écrire une requête qui calcule le nombre total de cours pour chaque département où les crédits sont supérieurs à 3.

On affichera les colonnes :
- Le nom du département
- Le nombre de cours dans le département
**************************************************************************************************************************************/
-- Votre code ici



/**************************************************************************************************************************************
-- Requête 11
Écrire une requête qui affiche les emplacements des cours en présentiel ainsi que les enseignants des ces cours.

On affichera les colonnes :
- Le nom et le prénom de l'enseignant
- Le titre du cours enseigné
- L'emplacement ou le cours est donné

**************************************************************************************************************************************/
-- Votre code ici



/**************************************************************************************************************************************
-- Requête 12
Écrire une requête qui affiche les départements ayant au moins 2 cours de 3 crédits minimum chacun.

On affichera les colonnes :
- Le nom du département
- Le nombre de cours dans le département

**************************************************************************************************************************************/
-- Votre code ici



/**************************************************************************************************************************************
-- Requête 13
Écrire une requête qui affiche les étudiants ayant obtenu une moyenne supérieure à 3.5 dans au moins 2 cours.

On affichera les colonnes :
- Le le nom et le prenom de l'étudiant
- LA moyenne des notes de l'étudiant
-- Le nombre de cours pour lesquels il a obtenu plus de 3.5 de moyenne
**************************************************************************************************************************************/
-- Votre code ici



/*************************************************************************************************************************************
-- Requête 14
Écrire une requête qui calcule le nombre total de crédits obtenus par chaque étudiant qui a réussi le cours. La note de passage étant 2.0
On s'intéresse aux étudiants ayant pris plus d'un cours.

On afichera les colonnes :
- Le nom complet de l'étudiant
- Le nombre total de crédit
- Le nombre de cours
- La moyenne des cours
*************************************************************************************************************************************/
-- Votre code ici



/**********************************************************************************************************************************
-- Requête 15
Écrire une requete qui crée une table tblBulletinNotes qui affiche les notes des étudiants issues de la requête 14
La structure de la table  tblBulletinNotes :
- BulletinID Clé primaire, identificateur unique
- Le nom et le prénom de l'étudiant
- Le nombre de cours de l'étudiant
- Le nombre de total de crédits
- La moyenne générale de l'étudiant

***********************************************************************************************************************************/
-- Votre code ici
-- Vérification de l'existence de la table


-- Creation de la table


-- Vérification de la création de la table


-- Rendre la colonne ClasseID non nulle


-- Modification de la table et ajout de la clé primaire


-- Vérification de la clé primaire
