-- Démarche systématique
-- Identifier les tables requises : departments, employees, jobs
-- Identifier la table maitre : departments
-- Identifier la table détail : employees
-- Identifier la table maitre : jobs
-- Identifier la PK dans la table maitre : department_id
-- Identifier la FK dans la table détail : department_id
-- Identifier la FK dans la table détail : job_id
-- Identifier la PK dans la table maitre : Job_id
-- Jointure departments --> employees 
-- Jointure jobs --> employees
-- Jointure entre maitre.PK = detail.FK
-- Jointure entre maitre.PK2 = detail.FK2
-- Jointure : departments.departement_id = employees.departement_id
-- Jointure : jobs.job_id = employees.job.id

-- ---------------------------------------------------------
-- Collège Marie Victorin
-- Introduction aux bases de données
-- Travaux dirigés 6
-- Les requêtes multitables
-- ---------------------------------------------------------

-- Base de données : Xtreme

-- En utilisant la base de données Xtreme créer les requêtes qui correspondent aux énoncés suivants.

-- Requête 1
-- Écrire une requête qui affiche la liste des clients non nord-américains, propriétaires et qui ont acheté l’année dernière pour moins de 50 000 eur. 
-- La liste sera triée en ordre croissant par pays et en ordre décroissant du montant d’achat.
-- On affichera : 
-- le nom du client
-- le poste occupé par le contact chez le client
-- les ventes de l’année dernière
-- l’adresse courriel
-- le téléphone
-- Pays

-- Votre code ici
SELECT 
	[Nom du client],
	[Poste occupé],
	[Ventes de l'année dernière],
	[Adresse électronique],
	[Téléphone],
	[Pays]
FROM [dbo].[Clients]
WHERE 
	[Pays] NOT IN('Canada', 'Etats-Unis %Amérique%') AND [Poste occupé] = 'Propriétaire' AND [Ventes de l'année dernière] < 50000
ORDER BY 6

-- ---------
-- Requête 2
-- Écrire une requête qui afficher la liste des employés qui habitent en France ainsi que ceux qui habitent à London au Royaume uni.
-- On affichera : 
-- le nom, 
-- Le prénom
-- le poste occupé 
-- la ville et le pays de résidence

-- Votre code ici
SELECT
	[Nom],
	[Prénom],
	[Poste occupé],
	[Ville],
	[Pays]
FROM 
	[dbo].[Employés] A,
	[dbo].[Adresses des employés] B
WHERE 
	A.[ID employé] = B.[ID employé] AND
	[Pays] = 'France' OR [Ville] = 'London'
ORDER BY [Nom]

-- ---------
-- Requête 3
-- Écrire une requête qui affiche les produits dont les seuils d’approvisionnement sont de 50 et 100.
-- On affichera 
-- le nom du produit
-- le fournisseur 
-- le seuil d’approvisionnement.

-- Votre code ici
SELECT 
	[Nom du produit],
	[Nom du fournisseur],
	[Seuil de réapprovisionnement]
FROM 
	[dbo].[Produits] A,
	[dbo].[Achats] B,
	[dbo].[Fournisseurs] C
WHERE 
	A.[ID produit] = B.[ID produit] AND A.[ID fournisseur] = C.[ID fournisseur] AND
	[Seuil de réapprovisionnement] = 50 OR [Seuil de réapprovisionnement] = 100

-- ---------
-- Requête 4
-- Écrire une requête qui affiche les commandes dont le montant est supérieur à 2500. 
-- La liste affichera le montant des commandes les élevés en premier
-- On affichera : 
-- le nom des produits commandés
-- le client qui les a commandés 
-- le représentant qui l’a servi.

-- Votre code ici
SELECT
	DISTINCT [Nom du produit],
	[Nom du client],
	[Nom] +', '+ [Prénom] AS 'servi par',
	[Montant commande]
FROM 
	[dbo].[Commandes] A,
	[dbo].[Produits] B,
	[dbo].[Clients] C,
	[dbo].[Employés] D
WHERE 
	[Montant commande] > 2500 AND
	A.[ID client] = C.[ID client] AND
	A.[ID employé] = D.[ID employé]
ORDER BY [Montant commande] DESC


-- ---------
-- Requête 5
-- Écrire une requête qui affiche le total des ventes par types de produits 
-- La liste sera triée par le type le plus vendu en terme de revenus
-- On affichera : 
-- le nom du type du produit
-- les ventes réalisées.

-- Votre code ici
SELECT
	[Nom du produit],
	SUM([Prix unitaire]) AS 'Ventes réalisées en $'
FROM
	[dbo].[Détails des commandes] A,
	[dbo].[Produits] B
GROUP BY [Nom du produit]
ORDER BY 2 DESC

-- ---------
-- Requête 6
-- Écrire une requête qui affiche les 10 produits ayant été le moins vendus en terme de quantité.
-- On affichera : 
-- le nom du produit
-- le nombre total d’unités vendues.

-- Votre code ici
SELECT 
	[Nom du produit],
	SUM([Quantité]) AS 'Total vendu'
FROM 
	[dbo].[Produits] A,
	[dbo].[Détails des commandes] B
GROUP BY [Nom du produit]
ORDER BY 2
