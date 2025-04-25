
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
)

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

)

DROP TABLE IF EXISTS tblPoste
DROP TABLE IF EXISTS tblEmployeurs
GO

CREATE TABLE tblEmployeurs (
	NoEmployeur	tinyInt Primary Key not null,
	Société	nvarchar(30),
	RueEmp nvarchar(50),
	CPEmp nvarChar(10),
	VilleEmp nvarchar(10),
	ProvEmp	nvarchar(2),
	TélEmp nvarchar(12),
)

CREATE TABLE tblPoste (
	Intitulé nvarchar(50),
	Domaine	nvarchar(10),
	SalaireAnnuel money,
	Préférence tinyInt,
	NoPoste	tinyInt primary key not null,
	NoEmployeur	tinyInt foreign key references tblEmployeurs(NoEmployeur)
)


DROP TABLE IF EXISTS tblTypeDeLogement
DROP TABLE IF EXISTS tblPropriete
DROP TABLE IF EXISTS tblAgent
DROP TABLE IF EXISTS tblAgence
GO