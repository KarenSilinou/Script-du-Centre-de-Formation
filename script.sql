/* Exercice 2: Centre de formation */

/* 1. Creation de la base de donnees */
CREATE DATABASE "Centre de formation";
USE "Centre de formation";

/* 2. Creation des tables */
CREATE TABLE Etudiant (
  numCINEtu INT PRIMARY KEY,
  nomEtu VARCHAR(50) NOT NULL,
  prenomEtu VARCHAR(50) NOT NULL,
  dateNaissance DATE NOT NULL,
  adresseEtu VARCHAR(100) NOT NULL,
  villeEtu VARCHAR(50) NOT NULL,
  niveauEtu VARCHAR(50) NOT NULL,
);

CREATE TABLE Session (
  codeSess INT PRIMARY KEY,
  nomSess VARCHAR(50) NOT NULL,
  dateDebut DATE NOT NULL,
  dateFin DATE NOT NULL,
  codeFormation INT NOT NULL,
  CONSTRAINT CHECK_DateFin CHECK (dateFin > dateDebut),
  FOREIGN KEY (codeFormation) REFERENCES Formation(codeForm)
);

CREATE TABLE Formation (
  codeForm INT PRIMARY KEY,
  titreForm VARCHAR(100) NOT NULL,
  dureeForm INT NOT NULL,
  prixForm INT NOT NULL,
  codeSess INT NOT NULL
);

CREATE TABLE Specialite (
  codeSpec INT PRIMARY KEY,
  nomSpec VARCHAR(100) NOT NULL,
  descSpec VARCHAR(100) NOT NULL,
  /* 5. Ajout de la colonne "Active" */
  active TINYINT(1) NOT NULL DEFAULT 1
);

CREATE TABLE Inscription (
  numEtu INT,
  codeSess INT,
  typeInscription VARCHAR(50) NOT NULL,
  codeConcerne INT,
  PRIMARY KEY (numEtu, codeSession),
  FOREIGN KEY (numEtu) REFERENCES Etudiant(numEtu),
  FOREIGN KEY (codeSession) REFERENCES Session(codeSession)
);

CREATE TABLE Concerne (
  codeSpec INT,
  codeForm INT,
  PRIMARY KEY (codeSpec, codeForm),
  FOREIGN KEY (codeSpec) REFERENCES Specialite(codeSpec),
  FOREIGN KEY (codeForm) REFERENCES Formation(codeForm)
);

/* 3. Ajout de la contrainte NOT NULL sur la colonne typeCours de la table Inscription */
ALTER TABLE Inscription
ADD CONSTRAINT NOT_NULL_TypeCours
CHECK (typeInscription IS NOT NULL);

/* 4. Ajout de la contrainte CHECK dans la table SESSION */
ALTER TABLE Session
ADD CONSTRAINT CHECK_DateFin
CHECK (dateFin > dateDebut);