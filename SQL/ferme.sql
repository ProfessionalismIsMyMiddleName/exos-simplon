DROP DATABASE IF EXISTS ferme;
CREATE DATABASE IF NOT EXISTS ferme;
USE ferme;

CREATE TABLE produit (
	idproduit INTEGER(10) PRIMARY KEY,
	nom VARCHAR(45) NOT NULL
);

CREATE TABLE type_plante (
	idtype_plante INTEGER(10) PRIMARY KEY,
	nom VARCHAR(45) NOT NULL
);

CREATE TABLE plante (
	idplante INTEGER(10) PRIMARY KEY,
	nom VARCHAR(45) NOT NULL,
	fktype INTEGER(10),
	CONSTRAINT fktypeplante  FOREIGN KEY (fktype) REFERENCES type_plante (idtype_plante)
);

CREATE TABLE poste (
	idposte SMALLINT(5) PRIMARY KEY,
	nom VARCHAR(45) NOT NULL
);

CREATE TABLE employe (
	idemploye INTEGER(10) PRIMARY KEY,
	nom VARCHAR(45) NOT NULL,
    fkposte SMALLINT(5),
    CONSTRAINT fkposteemploye  FOREIGN KEY (fkposte) REFERENCES poste (idposte)
);

CREATE TABLE animal (
	idanimal INTEGER(10) PRIMARY KEY,
	nom VARCHAR(45) NOT NULL
);

CREATE TABLE type_terre(
	idtype_terre INTEGER(10) PRIMARY KEY,
	nom VARCHAR(45) NOT NULL
);

CREATE TABLE terrain (
	idterrain INTEGER(10) PRIMARY KEY,
	surface FLOAT NOT NULL,
	longitude FLOAT NOT NULL,
	latitude FLOAT NOT NULL,
    fktype_terre INTEGER(10),
	CONSTRAINT fktypeterrain  FOREIGN KEY (fktype_terre) REFERENCES type_terre (idtype_terre)
);

CREATE TABLE elevage (
	idelevage INTEGER(10) PRIMARY KEY,
   	capacite INTEGER(10),
    fkanimal INTEGER(10),
    fkterrain INTEGER(10),
	CONSTRAINT fkanimalelevage  FOREIGN KEY (fkanimal) REFERENCES animal (idanimal),
	CONSTRAINT fkterrainelevage  FOREIGN KEY (fkterrain) REFERENCES terrain (idterrain)
);

CREATE TABLE production (
	annee TINYINT(4) PRIMARY KEY, #l'annee en PK?? Chaque annee se refere a un seul elevage qui a une seule quantite?
	quantite INTEGER(11), #pourquoi 11??
	fkelevage INTEGER(10),
	CONSTRAINT fkelevageproduction  FOREIGN KEY (fkelevage) REFERENCES elevage (idelevage)
);

CREATE TABLE alimentation (
	annee TINYINT(4),
	qtx SMALLINT(6),
	fkelevage INTEGER(10),
	fkplante INTEGER(10),
	CONSTRAINT fkelevagealimentation  FOREIGN KEY (fkelevage) REFERENCES elevage (idelevage),
	CONSTRAINT fkplantealimentation  FOREIGN KEY (fkplante) REFERENCES plante (idplante)
);

CREATE TABLE culture (
	idculture INTEGER(10) PRIMARY KEY,
   	annee TINYINT(3), #pourquoi 3 et pas 4??
	rendement INTEGER(10),
    fkplante INTEGER(10),
    fkterrain INTEGER(10),
    fkresponsable INTEGER(10),
	CONSTRAINT fkplanteculture  FOREIGN KEY (fkplante) REFERENCES plante (idplante),
	CONSTRAINT fkterrainculture  FOREIGN KEY (fkterrain) REFERENCES terrain (idterrain),
	CONSTRAINT fkresponsableculture  FOREIGN KEY (fkresponsable) REFERENCES employe (idemploye)
);

CREATE TABLE traitement (
	qtx SMALLINT(6),
    fkproduit INTEGER(10),
    fkculture INTEGER(10),
	CONSTRAINT fkproduittraitement FOREIGN KEY (fkproduit) REFERENCES produit (idproduit),
	CONSTRAINT fkculturetraitement FOREIGN KEY (fkculture) REFERENCES culture (idculture)
);