create database LOGITpe24baas;
use LOGITpe24baas;
--tabeli loomine
CREATE TABLE opilane(
opilaneId int Primary Key identity(1,1),
eesnimi varchar(25),
perekonnanimi varchar(30) not null,
synniaeg date,
pohitoetus bit,
address TEXT,
keskmineHinne decimal(2, 1))

SELECT * FROM opilane;

--andmete lisamine tabelisse
INSERT INTO  opilane(perekonnanimi, eesnimi, synniaeg)
VALUES ('Roheline', 'Pall', '2001-10-1'),
('Valge', 'Sall', '2003-10-23')


--uuendame tabeliandmeid
UPDATE opilane SET address='Tallinn, Eesti'
UPDATE opilane SET pohitoetus=1 --1 on true
UPDATE opilane SET keskmineHinne=4.5;

INSERT INTO  opilane
VALUES ('Nimi', 'perenimi', '2003-10-23' , 0, 'Tartu, Eesti' , 3.5)

--teine tabel
CREATE TABLE opilaneTunnis(
opilaneTunnisId int Primary Key identity(1,1),
kuupaev date not null,
opilaneId int,
Foreign Key (opilaneId) References opilane(opilaneId), --tabel(PK veerg)
oppeaine varchar(25),
hinne int);
Select * from opilane;
select * from opilaneTunnis;

--lisame andmeid opilaneTunnis tabelisse
INSERT INTO opilaneTunnis
VALUES ('2025-04-14', 2, 'keemia', 4);
--testTabel
Create table testTabel(
id int primary key);
--tabeli kustutamine
DROP TABLE testTabel;
DROP Database praktikabaasPuhtejev;

--tabelirida kustutamine
select * from opilane;
DELETE FROM opilane WHERE opilaneId=4;

--esimene tabel
CREATE TABLE opetaja(
opetajaId int Primary Key identity(1,1),
eesnimi varchar(25),
perekonnanimi varchar(30) not null,
Ruum char(3))

SELECT * FROM opetaja;

--andmete lisamine tabelisse
INSERT INTO  opetaja(perekonnanimi, eesnimi, Ruum)
VALUES ('Sinine', 'Põõsas', 'E10'),
('Lilla', 'Lavanda', 'F10')


--uuendame tabeliandmeid
UPDATE opetaja SET Ruum='E10'
UPDATE opetaja SET Ruum='F10'

INSERT INTO  opetaja
VALUES ('Nimi', 'perenimi', 'E10' , 0, 'Tallinn, Eesti'),
('Nimi', 'perenimi', 'F10' , 1, 'Tartu, Eesti')


--teine tabel
CREATE TABLE opetamine(
opetamineId int Primary Key identity(1,1),
opetajaId int,
Foreign Key (opetajaId) References opetaja(opetajaId), --tabel(PK veerg)
oppeaine varchar(25),
maht int);

SELECT * from opetaja;
SELECT * from opetamine;

INSERT INTO opetamine
VALUES ( 1, 'matemaatika', 60);
--testTabel
Create table testTabel(
id int primary key);

--tabelirida kustutamine
select * from opetaja;
DELETE FROM opetaja WHERE opetajaId=4;
