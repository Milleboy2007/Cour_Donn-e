<<<<<<< HEAD
=======

>>>>>>> eb62407bde782280afe50ac50b5bdadf5d4a68dc
USE lab8
GO

DROP TABLE IF EXISTS tblProjets;
DROP TABLE IF EXISTS tblVendeurs;
GO

CREATE TABLE tblVendeurs(
	IDVENDEUR tinyint primary key not null,
	NOMVENDEUR nvarchar(30),
	ADRESSE	nvarchar(50),
	VILLE nvarchar(20),
	SALAIRE	money,
	DateEmbauche date
<<<<<<< HEAD
);
=======
)
>>>>>>> eb62407bde782280afe50ac50b5bdadf5d4a68dc

CREATE TABLE tblProjets(
	IDPROJET tinyint primary key not null,
	IDVENDEUR tinyint FOREIGN KEY REFERENCES tblVendeurs(IDVENDEUR),
	MOIS nvarchar(6),
	ENDROIT	nvarchar(50),
	DEBUT date,
	FIN	date,
	BUDGET nvarchar(5),
	MONTANT	money,
	APPROUVE bit

<<<<<<< HEAD
);
=======
)
>>>>>>> eb62407bde782280afe50ac50b5bdadf5d4a68dc

DROP TABLE IF EXISTS tblPoste
DROP TABLE IF EXISTS tblEmployeurs
GO

CREATE TABLE tblEmployeurs (
	NoEmployeur	tinyInt Primary Key not null,
	Soci�t�	nvarchar(30),
	RueEmp nvarchar(50),
	CPEmp nvarChar(10),
	VilleEmp nvarchar(10),
	ProvEmp	nvarchar(2),
	T�lEmp nvarchar(12),
<<<<<<< HEAD
);
=======
)
>>>>>>> eb62407bde782280afe50ac50b5bdadf5d4a68dc

CREATE TABLE tblPoste (
	Intitul� nvarchar(50),
	Domaine	nvarchar(10),
	SalaireAnnuel money,
	Pr�f�rence tinyInt,
	NoPoste	tinyInt primary key not null,
	NoEmployeur	tinyInt foreign key references tblEmployeurs(NoEmployeur)
<<<<<<< HEAD
);
=======
)
>>>>>>> eb62407bde782280afe50ac50b5bdadf5d4a68dc


DROP TABLE IF EXISTS tblTypeDeLogement
DROP TABLE IF EXISTS tblPropriete
DROP TABLE IF EXISTS tblAgent
DROP TABLE IF EXISTS tblAgence
<<<<<<< HEAD
GO

CREATE TABLE tblAgence (
	NoAgence tinyInt primary key not null,
	NomAgence nvarchar(15),
	Rue	nvarchar(30),
	Ville nvarchar(30),
	Province nvarchar(2),
	CP nvarchar(7),
	T�lAgence nvarchar(14)
);

CREATE TABLE tblAgent (
	NoAgent	tinyInt primary key not null,
	Pr�nomAgent	nvarchar(15),
	NomAgent nvarchar(15),
	T�lAgent nvarchar(14),
	NoAgence tinyInt foreign key REFERENCES tblAgence(NoAgence)
);

CREATE TABLE tblPropriete (
	NoPropri�t�	tinyInt primary key not null,
	Type nvarchar(10),
	Prix money,
	NoAgent	tinyInt foreign key REFERENCES tblAgent(NoAgent),
	DateInscription	date,
	Localit� nvarchar(10),
	Garage tinyInt,
	Piscine	bit
);

CREATE TABLE tblTypeDeLogement(
	IDType tinyInt primary key not null,
	Type nvarchar(10)
);
=======
GO
>>>>>>> eb62407bde782280afe50ac50b5bdadf5d4a68dc
