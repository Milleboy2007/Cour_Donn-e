-- ==============================================================================
-- Description du cours : Introduction au bases de donn�es
-- Code du cours : 420-212-MV
-- Laboratoire 7
-- Calcul de boni des employ�s de la compagnie Pages bleues
-- ==============================================================================


-- Objectif : 
-- **********
-- Ce Laboratoire vise � r�soudre un probl�me d'entreprise
-- en utilisant les notions de base de donn�es vues en cours
-- ========================================================

-- Base de donn�es � utiliser : Bonis

USE Bonis;
GO

-- ******************************************************************************************
-- �crire une requ�te affiche les donn�es des employ�s suivantes
-- ******************************************************************************************
-- No employ�
-- Le nom de l'employ�
-- Le pr�nom de l'employ�
-- Le num�ro du poste de l'employ�
-- La description du poste de l'employ�
-- Le d�partement de l'employ�
-- Le taux horaire
-- Le nombre de semaine travaill�es
-- Le salaire annuel

SELECT
	E.[No],
	E.Nom,
	E.Pr�nom,
	P.No_Poste,
	P.Fonction,
	E.D�partement,
	P.Taux_horaire,
	E.Nb_sem,
	P.Salaire_annuel,
	EP.Cat�gorie
FROM 
	[dbo].[tblEmployes] E,
	[dbo].[tblPostes] P,
	[dbo].[tblEmployesPostes] EP
WHERE
	EP.[No] = E.[No] AND
	EP.No_Poste = P.No_Poste
	
-- Cr�er une table temporaire qui contient les employe�s syndiqu�s

DROP TABLE IF EXISTS tempEmpSyndiques;
SELECT
	E.[No],
	E.Nom,
	E.Pr�nom,
	P.No_Poste,
	EP.Cat�gorie,
	P.Fonction,
	E.D�partement,
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
	EP.[Cat�gorie] LIKE('S')

-- V�rifier la cr�ation de la nouvelle table

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

-- V�rifier et afficher la nouvelle structure

exec sp_help tempEmpSyndiques;

-- **************************************
-- Traitement des employ�s syndiqu�s
-- *************************************
-- Calculer la commission que les employ�s syndiqu�s recevront
-- On affichera :
-- Toutes les colonnes de la table tempEmpSyndiques
-- Le montant des ventes r�alis�es
-- Le pourcentage de la commission
-- Le montant des gains
-- Le montant de la commission
 
 -- Effectuer la mise � jour du montant des gains
 -- Quelle est l'expression qui permet de calculer le montant des gains ?
 -- Taux horaire * Nb Heures par sem * Nb de sem

 UPDATE tempEmpSyndiques
	SET MontantGains = [Nb_sem] * CAST([Taux_horaire] AS money) * 37.5

 -- V�rifier la mise � jour

 SELECT * 
 FROM tempEmpSyndiques;

 -- Effectuer la mise � jour du pourcentrage de la commission

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

-- V�rifier la mise � jour du pourcentage de la commission

 SELECT * 
 FROM tempEmpSyndiques;

 -- Efectuer la mise � jour du montant de la commission

 UPDATE tempEmpSyndiques
	SET MontantCommission = MontantGains * PourcCommission / 100;

-- V�rifier la mise � jour du montant de la commission

-- *********************************************
-- *** Traitement des employ�s non syndiqu�s ***
-- *********************************************
-- Calculer le boni que les employ�s non syndiqu�s recevront
-- On affichera :
-- Toutes les colonnes de la table tempEmpNonSyndiques
-- Le montant des gains
-- Le pourcentage du boni
-- Le montant du boni
 
 -- Effectuer la mise � jour du montant des gains
 -- Quelle est l'expression qui permet de calculer le montant des gains ?
 -- Taux horaire * Nb Heures par sem * Nb de sem


 -- V�rifier la mise � jour

-- Effectuer la mise � jour du pourcentage du boni


-- V�rifier la mise � jour

 -- Efectuer la mise � jour du montant du boni


-- V�rifier la mise � jour du montant du boni
 SELECT * 
 FROM tempEmpSyndiques;

DROP TABLE IF EXISTS tempEmpNonSyndiques;
SELECT
	E.[No],
	E.Nom,
	E.Pr�nom,
	P.No_Poste,
	EP.Cat�gorie,
	P.Grade,
	P.Fonction,
	E.D�partement,
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
	EP.[Cat�gorie] LIKE('N')



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


-- ***************  Cr�ation de la table des paiements (tblEmpPaiement)

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

--Ajout des montant des employ�s syndiqu�s

INSERT INTO tblEmpPaiement
SELECT
	[No],
	[Nom],
	[Pr�nom],
	Null,
	[MontantGains],
	[PourcCommission],
	[MontantCommission]
FROM 
	[dbo].[tempEmpSyndiques]

--Ajout des montants des employ�s non syndiqu�s

INSERT INTO tblEmpPaiement
SELECT
	[No],
	[Nom],
	[Pr�nom],
	[Grade],
	[MontantGains],
	[PourcBoni],
	[MontantBoni]
FROM 
	[dbo].[tempEmpNonSyndiques]

-- V�rification de la table des paiements

SELECT *
FROM
	tblEmpPaiement

-- Nettoyage de l'environnement
-- Suppression des tables temporaires

DROP TABLE IF EXISTS [dbo].[tempEmpSyndiques];
DROP TABLE IF EXISTS [dbo].[tempEmpNonSyndiques];

-- ************************  FIN de PROGRAMME *************************

