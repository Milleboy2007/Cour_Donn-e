-- ---------------------------------------------------------
-- Coll�ge Marie Victorin
-- Introduction aux bases de donn�es
-- Travaux dirig�s 8
-- Les requ�tes multitables, GROUP BY, HAVING
-- ---------------------------------------------------------

-- Base de donn�es : School

-- En utilisant la base de donn�es "School" cr�er les requ�tes qui correspondent aux �nonc�s suivants.

-- Requ�te 1
-- �crire une requ�te qui affiche tous les �tudiants (Person) ayant une date d'inscription (EnrollmentDate) non nulle..
-- On affichera le nom, le pr�nom et la date d'inscription
-- La liste sera tri�e par la date d'inscription
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
-- Requ�te 2
�crire une requ�te qui affiche tous les enseignants (Person) embauch�s avant l'an 2000 et dont le nom commence par "S".
On affichera les colonnes :
- Le nom
- Le pr�nom
- L'ann�e d'embauche
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
-- Requ�te 3
�crire une requ�te qui affiche les �tudiants inscrits avant 2010, ayant un pr�nom contenant "e", et un nom de famille contenant "o".
On affichera les colonnes :
- Le nom
- Le pr�nom
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
** cr��e une table nomm�e tblEnseignants qui contien uniquement les enseignants � partir de la table Person **
-- Requ�te 4
�crire une requ�te qui affiche les enseignants embauch�s entre 1997 et 2002
On affichera les colonnes :
- Le nom
- Le pr�nom
- La date d'embauche
- Le titre
- L'anciennet�

La liste sera tri�e par l'enseignant du plus ancien au moins ancien.
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
	,DATEDIFF(YEAR,[HireDate],GETDATE()) AS 'Anciennet� (ans)'
FROM 
	[dbo].[tblEnseignants]
WHERE
	YEAR([HireDate]) BETWEEN 1997 AND 2002
ORDER BY
	DATEDIFF(YEAR,[HireDate],GETDATE()) DESC

/**************************************************************************************************************************************
-- Requ�te 5
�crire une requ�te qui affiche les �tudiants inscrits entre 2001 et 2004, inclus.
On affichera las colonnes: 
- Le nom
- Le pr�nom
- La date d'inscription

La liste sera tri�e par le nom de l'�tudiant

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
-- Requ�te 6
�crire une requ�te qui affiche tous les cours (Course) avec leurs d�partements associ�s (Department)
On affichera les colonnes :
- Le d�partement
- Le titre du cours

La liste sera tri�e par D�partement

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
-- Requ�te 7
�crire une requ�te qui affiche les noms des �tudiants inscrits aux cours de Micro, Macro �conomie et Physique
On affichera les colonnes : 
- Le titre du cours
- Le nom complet de l'�tudiant

La liste sera tri�e par cours et par nom de l'�tudiant

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
-- Requ�te 8
---
-- �crire une requ�te qui affiche les listes de classe par d�partement des �tudiant ayant obtenu une note.
-- On affichera les colonnes :
-- Le d�partement
-- Le nom de l'enseignant
-- Le pr�nom de l'enseignant
-- Le titre du cours
-- Le nom de l'�tudiant
-- Le pr�nom de l'�tudiant
-- La note de l'�tudiant

-- La liste sera tri�e par d�partement et par enseignant

**************************************************************************************************************************************/
-- Votre code ici
SELECT
	[Name]
	,CONCAT(A.[LastName],' ', A.[FirstName]) AS NomEnseignant
	,[Title]
	,CONCAT(A.[LastName],' ', A.[FirstName]) AS 'Nom �l�ve'
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
-- Requ�te 8-1
--------------
-- �crire une requ�te qui cr�e une table tblListeClasse avec le r�sultat de la requ�te 8.
-- Ajouter la cl� primaire ClasseID qui contient un identificateur unique.
-- La structure de la table tblListeClasse est :

-- ClasseID identificateur unique, cl� primaire
-- Le d�partement
-- Le nom et le pr�nom de l'enseignant
-- Le titre du cours
-- Le nom et le pr�nom de l'�tudiant
-- La note de l'�tudiant

**************************************************************************************************************************************/
-- Votre code ici

-- V�rification de la cr�ation de la table


-- Ajouter la cl� primaire


-- V�rifier la cr�ation de structure de la table



/**************************************************************************************************************************************
-- Requ�te 9
�crire une requ�te qui affiche les noms des enseignanta dans des d�partements sp�cifique (par exemple, d�partement Math�matiques, Anglais)
qui ont �t� embauch � partir de de l'ann�e 1999.

On affichera les colonnes :
- Le d�partement
- Le nom complet de l'enseignant
- Le titre (en guise de v�rification)
**************************************************************************************************************************************/
-- Votre code ici



/**************************************************************************************************************************************
-- Requ�te 10
�crire une requ�te qui calcule le nombre total de cours pour chaque d�partement o� les cr�dits sont sup�rieurs � 3.

On affichera les colonnes :
- Le nom du d�partement
- Le nombre de cours dans le d�partement
**************************************************************************************************************************************/
-- Votre code ici



/**************************************************************************************************************************************
-- Requ�te 11
�crire une requ�te qui affiche les emplacements des cours en pr�sentiel ainsi que les enseignants des ces cours.

On affichera les colonnes :
- Le nom et le pr�nom de l'enseignant
- Le titre du cours enseign�
- L'emplacement ou le cours est donn�

**************************************************************************************************************************************/
-- Votre code ici



/**************************************************************************************************************************************
-- Requ�te 12
�crire une requ�te qui affiche les d�partements ayant au moins 2 cours de 3 cr�dits minimum chacun.

On affichera les colonnes :
- Le nom du d�partement
- Le nombre de cours dans le d�partement

**************************************************************************************************************************************/
-- Votre code ici



/**************************************************************************************************************************************
-- Requ�te 13
�crire une requ�te qui affiche les �tudiants ayant obtenu une moyenne sup�rieure � 3.5 dans au moins 2 cours.

On affichera les colonnes :
- Le le nom et le prenom de l'�tudiant
- LA moyenne des notes de l'�tudiant
-- Le nombre de cours pour lesquels il a obtenu plus de 3.5 de moyenne
**************************************************************************************************************************************/
-- Votre code ici



/*************************************************************************************************************************************
-- Requ�te 14
�crire une requ�te qui calcule le nombre total de cr�dits obtenus par chaque �tudiant qui a r�ussi le cours. La note de passage �tant 2.0
On s'int�resse aux �tudiants ayant pris plus d'un cours.

On afichera les colonnes :
- Le nom complet de l'�tudiant
- Le nombre total de cr�dit
- Le nombre de cours
- La moyenne des cours
*************************************************************************************************************************************/
-- Votre code ici



/**********************************************************************************************************************************
-- Requ�te 15
�crire une requete qui cr�e une table tblBulletinNotes qui affiche les notes des �tudiants issues de la requ�te 14
La structure de la table  tblBulletinNotes :
- BulletinID Cl� primaire, identificateur unique
- Le nom et le pr�nom de l'�tudiant
- Le nombre de cours de l'�tudiant
- Le nombre de total de cr�dits
- La moyenne g�n�rale de l'�tudiant

***********************************************************************************************************************************/
-- Votre code ici
-- V�rification de l'existence de la table


-- Creation de la table


-- V�rification de la cr�ation de la table


-- Rendre la colonne ClasseID non nulle


-- Modification de la table et ajout de la cl� primaire


-- V�rification de la cl� primaire
