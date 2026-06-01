create database Kristo;
use Kristo;

--tabeli kliendi ja tellimuse koostamine
CREATE TABLE Kliendid (
    id INT PRIMARY KEY,
    eesnimi VARCHAR(50),
    perenimi VARCHAR(50)
);

CREATE TABLE Tellimused (
    id INT PRIMARY KEY,
    kliendi_id INT,
    toote_nimi VARCHAR(50),
    summa DECIMAL(10, 2),
    FOREIGN KEY (kliendi_id) REFERENCES Kliendid(id)
);

--inserdi abil andmete juurde lisamine
INSERT INTO Kliendid VALUES (1, 'Jaan', 'Kask');
INSERT INTO Kliendid VALUES (2, 'Mari', 'Kuusk');

INSERT INTO Tellimused VALUES (101, 1, 'Sülearvuti', 850.00);
INSERT INTO Tellimused VALUES (102, 1, 'Hiir', 25.00);
INSERT INTO Tellimused VALUES (103, 2, 'Monitor', 150.00);

--vaate tegemine
CREATE VIEW Vaade_KliendiTellimused AS
SELECT K.eesnimi, K.perenimi, T.toote_nimi, T.summa
FROM Kliendid K
JOIN Tellimused T ON K.id = T.kliendi_id;


SELECT * FROM Vaade_KliendiTellimused;