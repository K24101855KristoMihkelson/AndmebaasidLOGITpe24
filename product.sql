create database Bossibaas;
use Bossibaas;

--loome uue kategooria
CREATE TABLE Category(
idCategory int Primary Key identity(1,1),
Category_Name varchar(25) UNIQUE)

INSERT INTO Category
VALUES ('Auto'),('Jook'),('Toit')
SELECT * FROM Category;

--Loome uue producti
CREATE TABLE Product(
idProduct int Primary Key identity(1,1),
Name varchar(25),
idCategory int,
Foreign Key (idCategory) References Category(idCategory),
Price money)

INSERT INTO Product
VALUES ('BMW', 1, 1000.0),
('Beekoniburger', 3, 3.0)
SELECT * FROM Product;
SELECT * FROM Category;

--Loome uue Sale tabeli
CREATE TABLE Sale(
idSale int Primary Key identity(1,1),
Name varchar(25),
idProduct int,
Foreign Key (idProduct) References Product(idProduct),
idCostumer int,
count_pr int,
date_of_sale date)

--Koostan uue tabeli Costumer

CREATE TABLE Custumer(
idCustumer int Primary Key identity(1,1),
Name varchar(25) UNIQUE,
Contact varchar(100))



ALTER TABLE SALE ADD Foreign Key (idCustumer) References Custumer
INSERT INTO Custumer idCustomer
VALUES ('Kristo','+596854'),('Robin', '+345678')
SELECT * FROM Custumer;

INSERT INTO Sale
VALUES (1, 1, 5, '2026-15-04')
SELECT * FROM Product;
