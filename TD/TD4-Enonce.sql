-- ---------------------------------------------------------
-- Collège Marie Victorin
-- Introduction aux bases de données
-- Travaux dirigés 4
-- ---------------------------------------------------------

-- Série I
-- Base de données : xtremefr

-- Toute la série d’exercices utilisera la base de données xtremefr.

-- Requête 1
-- Table : Employés
-- Créez une requête qui affiche la liste des employés pour lesquels le « Poste occupé » est « représentant »
-- Les colonnes à afficher sont :
-- •	Nom
-- •	Prénom
-- •	Poste occupé
-- •	Date d’embauche
-- •	Téléphone personnel
-- •	Poste

-- Votre code ici
SELECT 
	[Nom],
	[Prénom],
	[Poste occupé],
	[Date d'embauche],
	[Téléphone personnel],
	[Poste]
FROM [dbo].[Employés]
WHERE [Poste occupé] = 'représentant'


-- Requête 2
-- Table : Employés
-- Créez une requête qui affiche les employés dont la « date d’embauche » est comprise entre le 01-01-1998 et le 31-12-1998
-- Les colonnes à afficher sont : 
-- •	Nom
-- •	Prénom
-- •	Poste occupé
-- •	Date d’embauche
-- •	Téléphone personnel

-- Votre code ici
SELECT 
	[Nom],
	[Prénom],
	[Poste occupé],
	[Date d'embauche],
	[Téléphone personnel]
FROM [dbo].[Employés]
WHERE [Date d'embauche] between '1998-01-01' and '1998-12-31'

 
-- Requête 3
-- Table : Employés
-- Créez une requête qui affiche les employés dont le « Téléphone personnel » commence par 206555.
-- Les colonnes à afficher sont : 
-- •	Nom
-- •	Prénom
-- •	Poste occupé
-- •	Téléphone personnel

-- Votre code ici
SELECT 
	[Nom],
	[Prénom],
	[Poste occupé],
	[Téléphone personnel]
FROM [dbo].[Employés]
WHERE [Téléphone personnel] like '206555%'


-- Requête 4
-- Table : Employés
-- Créez une requête qui affiche la liste des employés dont la « Date de naissance » est  supérieure au 01-01-1979 et dont la « Date d’embauche » est supérieure à 01-01-1997.
-- Les colonnes à afficher sont : 
-- •	Nom
-- •	Prénom
-- •	Poste occupé
-- •	Date d’embauche
-- •	Date naissance

-- Votre code ici
SELECT 
	[Nom],
	[Prénom],
	[Poste occupé],
	[Date d'embauche],
	[Date de naissance]
FROM [dbo].[Employés]
WHERE [Date de naissance] > '01-01-1979' AND [Date d'embauche] > '01-01-1997'


-- Requête 5
-- Table : Employés
-- Créez une requête qui affiche la liste des employés dont le « Poste occupé » est « directeur commercial » et dont la « date d’embauche » est comprise entre 01-01-1998 et 31-12-1998.
-- Les colonnes à afficher sont : 
-- •	Nom
-- •	Prénom
-- •	Poste occupé
-- •	Date d’embauche

-- Votre code ici
SELECT 
	[Nom],
	[Prénom],
	[Poste occupé],
	[Date d'embauche]
FROM [dbo].[Employés]
WHERE [Poste occupé] = 'directeur commercial' AND [Date d'embauche] BETWEEN '01-01-1998' AND '12-31-1998'

 
-- Requête 6
-- Table : Employés
-- Créez une requête qui affiche la liste des employés dont la personne à contacter en cas d’urgence est l’épouse. 
-- Les colonnes à afficher sont : 
-- •	Nom
-- •	Prénom
-- •	Poste occupé
-- •	En cas d'urgence - Lien de parenté

-- Votre code ici
SELECT 
	[Nom],
	[Prénom],
	[Poste occupé],
	[En cas d'urgence - Lien de parenté]
FROM [dbo].[Employés]
WHERE [En cas d'urgence - Lien de parenté] = 'epouse'


-- Requête 7
-- Table : Clients
-- Créer une requête qui affiche la liste des clients dont le « Poste occupé » du contact est dans les ventes.
-- Les colonnes à afficher sont :
-- •	Nom du client
-- •	Nom du contact
-- •	Prénom du contact
-- •	Poste occupé

-- Votre code ici
SELECT
	[Nom du client],
	[Nom du contact],
	[Prénom du contact],
	[Poste occupé]
FROM [dbo].[Clients]
WHERE [Poste occupé] like '%vente%'


-- Requête 8
-- Table : Clients
-- Créez une requête qui affiche la liste des clients dont le « Pays » est « France », « Italie » et « Canada »
-- Les colonnes à afficher sont :
-- •	Nom du client
-- •	Nom du contact
-- •	Prénom du contact
-- •	Pays

-- Votre code ici
SELECT
	[Nom du client],
	[Nom du contact],
	[Prénom du contact],
	[Pays]
FROM [dbo].[Clients]
WHERE [Pays] IN('France', 'Italie', 'Canada')


-- Requête 9
-- Table : Clients
-- Créez une requête qui affiche la liste des clients dont le « Pays » est « France » et la « Région » est « Nord Pas de Calais » ou « Pays » est « Etats-Unis » et « Ville » est « Kingston »
-- Les colonnes à afficher sont :
-- •	Nom du client
-- •	Nom du contact
-- •	Prénom du contact
-- •	Pays
-- •	Région
-- •	Ville

-- Votre code ici
SELECT
	[Nom du client],
	[Nom du contact],
	[Prénom du contact],
	[Pays],
	[Région],
	[Ville]
FROM [dbo].[Clients]
WHERE ([Pays] = 'France' AND [Région] = 'Nord Pas-de-Calais') OR ([Pays] Like 'Etats-Unis%' AND [Ville] = 'Kingston')


-- Requête 10
-- Table : Clients
-- Créez une requête qui affiche la liste des clients dont on ne connaît pas le « Code postal ». 
-- Les colonnes à afficher sont :
-- •	Nom du client
-- •	Nom du contact
-- •	Prénom du contact
-- •	Pays
-- •	Code postal

-- Votre code ici
SELECT
	[Nom du client],
	[Nom du contact],
	[Prénom du contact],
	[Pays],
	[Code postal]
FROM [dbo].[Clients]
WHERE [Code postal] is NULL


-- Requête 11
-- Table : Clients
-- Créez une requête qui affiche la liste des clients de France, Allemagne, du Italie et dont les « ventes de l’année dernière » sont comprises entre 10 000 et 60 000
-- Les colonnes à afficher sont :
-- •	Nom du client
-- •	Nom du contact
-- •	Prénom du contact
-- •	Pays
-- •	Code postal

-- Votre code ici
SELECT
	[Nom du client],
	[Nom du contact],
	[Prénom du contact],
	[Pays],
	[Code postal],
	[Ventes de l'année dernière]
FROM [dbo].[Clients]
WHERE [Pays] IN('France', 'Allemagne', 'Italie') AND [Ventes de l'année dernière] BETWEEN 10000 AND 60000
ORDER BY [Ventes de l'année dernière]

 
-- Requête 12
-- Table : Détails des commandes
-- Créez une requête qui affiche la liste des commandes des clients 1002, 1012 et 1831.
-- Trier la liste par numéro de commande.
-- Les colonnes à afficher sont :
-- •	ID Commande
-- •	ID produit
-- •	Prix unitaire
-- •	Quantité

-- Votre code ici
SELECT 
	[ID commande],
	[ID produit],
	[Prix unitaire],
	[Quantité]
FROM [dbo].[Détails des commandes]
WHERE [ID commande] in('1002', '1012', '1832')
ORDER BY [ID commande]


-- Requête 13
-- Table : Détails des commandes
-- Créez une requête qui affiche le Prix total de chaque ligne de commande de chaque commande. Le Prix total est un champ virtuel qui n’existe pas dans la table.
-- Les colonnes à afficher sont :
-- •	ID Commande
-- •	Prix unitaire
-- •	Quantité
-- •	Prix Total

-- Votre code ici
SELECT
	[ID commande],
	[Prix unitaire],
	[Quantité],
	[Quantité] * [Prix unitaire] AS "Prix Total"
FROM [dbo].[Détails des commandes]
