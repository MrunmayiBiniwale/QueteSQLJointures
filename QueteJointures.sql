USE master

--Create database if not exists
IF NOT (EXISTS (SELECT name FROM sys.databases 
WHERE ('[' + name + ']' = 'SpaceDb' 
OR name = 'SpaceDb')))
BEGIN    
    CREATE DATABASE SpaceDb;
END

--Use the newly created database
USE SpaceDb

--Drop table Continent if already exists
IF OBJECT_ID('Continent', 'U') IS NOT NULL 
BEGIN
    DROP TABLE Continent;
END

--Create table Continent
CREATE TABLE Continent 
(
    ID INT PRIMARY KEY IDENTITY(1,1),
    ContinentName VARCHAR(128),  
)

--Drop table BaseMartien if already exists
IF OBJECT_ID('BaseMartien', 'U') IS NOT NULL 
BEGIN
    DROP TABLE BaseMartien;
END

--Create table BaseMartien
CREATE TABLE BaseMartien 
(
    ID INT PRIMARY KEY IDENTITY(1,1),
    BaseMartienName VARCHAR(128),  
)

--Drop table Terrien if already exists
IF OBJECT_ID('Terrien', 'U') IS NOT NULL 
BEGIN
    DROP TABLE Terrien;
END

--Create table Terrien
CREATE TABLE Terrien 
(
    ID INT PRIMARY KEY IDENTITY(1,1),
    Name VARCHAR(128),  
    ContinentId INT
    CONSTRAINT FK_Continent FOREIGN KEY (ContinentID)
    REFERENCES Continent(ID)

)

--Drop table Martien if already exists
IF OBJECT_ID('Martien', 'U') IS NOT NULL 
BEGIN
    DROP TABLE Martien;
END

--Create table Martien
CREATE TABLE Martien 
(
    ID INT PRIMARY KEY IDENTITY(1,1),
    Name VARCHAR(128),  
    BaseMartienID INT
    CONSTRAINT FK_BaseMartien FOREIGN KEY (BaseMartienID)
    REFERENCES BaseMartien(ID),
    TerrienId INT
    CONSTRAINT FK_Terrien FOREIGN KEY (TerrienId) 
    REFERENCES Terrien(ID),
    SuperiorId INT
    CONSTRAINT FK_Martien FOREIGN KEY (SuperiorId)
    REFERENCES Martien(ID)
)

INSERT INTO Continent (ContinentName) VALUES ('Continent1');
INSERT INTO Continent (ContinentName) VALUES ('Continent2');
INSERT INTO Continent (ContinentName) VALUES ('Continent3');

INSERT INTO BaseMartien (BaseMartienName) VALUES ('Base1');
INSERT INTO BaseMartien (BaseMartienName) VALUES ('Base2');
INSERT INTO BaseMartien (BaseMartienName) VALUES ('Base3');

INSERT INTO Terrien (name, ContinentID) VALUES('Terrien1', 1);
INSERT INTO Terrien (name, ContinentID) VALUES('Terrien2', 2);
INSERT INTO Terrien (name, ContinentID) VALUES('Terrien3', 3);

INSERT INTO Martien (name, BaseMartienID, TerrienId, SuperiorId) VALUES ('Martien1', 1, 1, 1)
INSERT INTO Martien (name, BaseMartienID, TerrienId, SuperiorId) VALUES ('Martien2', 2, 2, 1)
INSERT INTO Martien (name, BaseMartienID, TerrienId, SuperiorId) VALUES ('Martien3', 1, 2, 2)
INSERT INTO Martien (name, BaseMartienID, TerrienId, SuperiorId) VALUES ('Martien4', 1, 1, 2)
INSERT INTO Martien (name, BaseMartienID, TerrienId, SuperiorId) VALUES ('Martien5', 2, 1, 3)

SELECT 
M.Name AS 'Le nom du martien',
T.Name AS 'Le nom du référent terrien',
C.ContinentName AS 'Le continent de référence du terrien',
B.BaseMartienName AS 'La base du martien'
FROM
Martien M 
INNER JOIN Terrien T ON M.TerrienId = T.Id
INNER JOIN Continent C ON T.ContinentID = C.Id
INNER Join BaseMartien B ON M.BaseMartienId = B.Id



