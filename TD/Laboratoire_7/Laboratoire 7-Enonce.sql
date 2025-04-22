-- ==============================================================================
-- Description du cours : Introduction au bases de données
-- Code du cours : 420-212-MV
-- Laboratoire 7
-- Calcul de boni des employés de la compagnie Pages bleues
-- ==============================================================================


-- Objectif : 
-- **********
-- Ce Laboratoire vise à résoudre un problème d'entreprise
-- en utilisant les notions de base de données vues en cours
-- ========================================================

-- Base de données à utiliser : Bonis

USE Bonis;
GO

-- ******************************************************************************************
-- Écrire une requête affiche les données des employés suivantes
-- ******************************************************************************************
-- No employé
-- Le nom de l'employé
-- Le prénom de l'employé
-- Le numéro du poste de l'employé
-- La description du poste de l'employé
-- Le département de l'employé
-- Le taux horaire
-- Le nombre de semaine travaillées
-- Le salaire annuel

SELECT
	E.[No],
	E.Nom,
	E.Prénom,
	P.No_Poste,
	P.Fonction,
	E.Département,
	P.Taux_horaire,
	E.Nb_sem,
	P.Salaire_annuel,
	EP.Catégorie
FROM 
	[dbo].[tblEmployes] E,
	[dbo].[tblPostes] P,
	[dbo].[tblEmployesPostes] EP
WHERE
	EP.[No] = E.[No] AND
	EP.No_Poste = P.No_Poste
	
-- Créer une table temporaire qui contient les employeés syndiqués

DROP TABLE IF EXISTS tempEmpSyndiques;
SELECT
	E.[No],
	E.Nom,
	E.Prénom,
	P.No_Poste,
	EP.Catégorie,
	P.Fonction,
	E.Département,
	P.Taux_horaire,
	E.Nb_sem,
	P.Salaire_annuel,
	EV.Ventes
INTO
	tempEmpSyndiques
FROM 
	[dbo].[tblEmployes] E,
	[dbo].[tblPostes] P,
	[dbo].[tblEmployesPostes] EP,
	[dbo].[tblEmployeVentes] EV
WHERE
	EP.[No] = E.[No] AND
	EP.No_Poste = P.No_Poste AND
	E.[No] = EV.[No] AND
	EP.[Catégorie] LIKE('S')

-- Vérifier la création de la nouvelle table

SELECT *
FROM tempEmpSyndiques

-- Modifier la structure de la table tempEmpSyndiques en ajoutant les colonnes suivantes :
-- Le montant des gains 
-- Le pourcentage de la commission
-- Le montant de la commission

ALTER TABLE tempEmpSyndiques
	DROP COLUMN IF EXISTS MontantGains;
ALTER TABLE tempEmpSyndiques
	DROP COLUMN IF EXISTS PourcCommission;
ALTER TABLE tempEmpSyndiques
	DROP COLUMN IF EXISTS MontantCommission;

ALTER TABLE tempEmpSyndiques
	ADD MontantGains money,
		PourcCommission int,
		MontantCommission money
GO

-- Vérifier et afficher la nouvelle structure

exec sp_help tempEmpSyndiques;

-- **************************************
-- Traitement des employés syndiqués
-- *************************************
-- Calculer la commission que les employés syndiqués recevront
-- On affichera :
-- Toutes les colonnes de la table tempEmpSyndiques
-- Le montant des ventes réalisées
-- Le pourcentage de la commission
-- Le montant des gains
-- Le montant de la commission
 
 -- Effectuer la mise à jour du montant des gains
 -- Quelle est l'expression qui permet de calculer le montant des gains ?
 -- Taux horaire * Nb Heures par sem * Nb de sem

 UPDATE tempEmpSyndiques
	SET MontantGains = [Nb_sem] * CAST([Taux_horaire] AS money) * 37.5

 -- Vérifier la mise à jour

 SELECT * 
 FROM tempEmpSyndiques;

 -- Effectuer la mise à jour du pourcentrage de la commission

 UPDATE tempEmpSyndiques
	SET PourcCommission = (
		CASE
				WHEN ventes = 0 THEN 0
				WHEN ventes <= 2500 THEN 1
				WHEN ventes <= 5000 THEN 2
				WHEN ventes <= 10000 THEN 5
				WHEN ventes <= 15000 THEN 8
				WHEN ventes <= 25000 THEN 10
				WHEN ventes <= 50000 THEN 12
				WHEN ventes <= 100000 THEN 15
				WHEN ventes <= 200000 THEN 18
				WHEN ventes <= 300000 THEN 20
			ELSE 25
		END
	)

-- Vérifier la mise à jour du pourcentage de la commission

 SELECT * 
 FROM tempEmpSyndiques;

 -- Efectuer la mise à jour du montant de la commission

 UPDATE tempEmpSyndiques
	SET MontantCommission = MontantGains * PourcCommission / 100;

-- Vérifier la mise à jour du montant de la commission

-- *********************************************
-- *** Traitement des employés non syndiqués ***
-- *********************************************
-- Calculer le boni que les employés non syndiqués recevront
-- On affichera :
-- Toutes les colonnes de la table tempEmpNonSyndiques
-- Le montant des gains
-- Le pourcentage du boni
-- Le montant du boni
 
 -- Effectuer la mise à jour du montant des gains
 -- Quelle est l'expression qui permet de calculer le montant des gains ?
 -- Taux horaire * Nb Heures par sem * Nb de sem


 -- Vérifier la mise à jour

-- Effectuer la mise à jour du pourcentage du boni


-- Vérifier la mise à jour

 -- Efectuer la mise à jour du montant du boni


-- Vérifier la mise à jour du montant du boni
 SELECT * 
 FROM tempEmpSyndiques;

DROP TABLE IF EXISTS tempEmpNonSyndiques;
SELECT
	E.[No],
	E.Nom,
	E.Prénom,
	P.No_Poste,
	EP.Catégorie,
	P.Grade,
	P.Fonction,
	E.Département,
	P.Taux_horaire,
	E.Nb_sem,
	P.Salaire_annuel,
	B.Pourcentage
INTO
	tempEmpNonSyndiques
FROM 
	[dbo].[tblEmployes] E,
	[dbo].[tblPostes] P,
	[dbo].[tblEmployesPostes] EP,
	[dbo].[tblBonis] B
WHERE
	E.[No] = EP.[No] AND
	EP.No_Poste = P.No_Poste AND
	P.Grade = B.Grade AND
	EP.[Catégorie] LIKE('N')



SELECT *
FROM tempEmpNonSyndiques



ALTER TABLE tempEmpNonSyndiques
	DROP COLUMN IF EXISTS MontantGain;
ALTER TABLE tempEmpNonSyndiques
	DROP COLUMN IF EXISTS PourcBoni;
ALTER TABLE tempEmpNonSyndiques
	DROP COLUMN IF EXISTS MontantBoni;

ALTER TABLE tempEmpNonSyndiques
	ADD MontantGains money,
		PourcBoni int,
		MontantBoni money
GO

 UPDATE tempEmpNonSyndiques
	SET MontantGains = [Nb_sem] * CAST([Taux_horaire] AS money) * 37.5



 SELECT * 
 FROM tempEmpNonSyndiques;



 UPDATE tempEmpNonSyndiques
	SET PourcBoni = (
		CASE
			WHEN [Grade] = 'MP1' THEN 5
			WHEN [Grade] = 'MP2' THEN 10
			WHEN [Grade] = 'MP3' THEN 15
			WHEN [Grade] = 'MP4' THEN 30
			WHEN [Grade] = 'MP5' THEN 40
			WHEN [Grade] = 'MP6' THEN 100
		END
	)



 SELECT * 
 FROM tempEmpNonSyndiques;



 UPDATE tempEmpNonSyndiques
	SET MontantBoni = MontantGains * PourcBoni / 100;



SELECT *
FROM tempEmpNonSyndiques;


-- ***************  Création de la table des paiements (tblEmpPaiement)

DROP TABLE IF EXISTS tblEmpPaiement;
CREATE TABLE tblEmpPaiement(
	NoEmploye int primary Key not null,
	NomEmploye nvarchar(30),
	PrenomEmploye nvarchar(30),
	GradeEmploye nvarchar(3),
	Gains money,
	PourcentageBoni decimal(5,2),
	MontantBoni money
)

--Ajout des montant des employés syndiqués

INSERT INTO tblEmpPaiement
SELECT
	[No],
	[Nom],
	[Prénom],
	Null,
	[MontantGains],
	[PourcCommission],
	[MontantCommission]
FROM 
	[dbo].[tempEmpSyndiques]

--Ajout des montants des employés non syndiqués

INSERT INTO tblEmpPaiement
SELECT
	[No],
	[Nom],
	[Prénom],
	[Grade],
	[MontantGains],
	[PourcBoni],
	[MontantBoni]
FROM 
	[dbo].[tempEmpNonSyndiques]

-- Vérification de la table des paiements

SELECT *
FROM
	tblEmpPaiement

-- Nettoyage de l'environnement
-- Suppression des tables temporaires

DROP TABLE IF EXISTS [dbo].[tempEmpSyndiques];
DROP TABLE IF EXISTS [dbo].[tempEmpNonSyndiques];

-- ************************  FIN de PROGRAMME *************************

