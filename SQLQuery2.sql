-- 1. Andmebaasi loomine
CREATE DATABASE KristoHinne2;
USE KristoHinne2;

-- 2. Tabelite loomine
CREATE TABLE Lennujaam (
    LennujaamID INT PRIMARY KEY IDENTITY(1,1),
    LennujaamaNimi VARCHAR(50),
    Linn VARCHAR(50)
);

CREATE TABLE Lend (
    LendID INT PRIMARY KEY IDENTITY(1,1),
    LennuNumber VARCHAR(20),
    Valjumisaeg DATETIME,
    LennujaamID INT,
    FOREIGN KEY (LennujaamID) REFERENCES Lennujaam(LennujaamID)
);

CREATE TABLE Reisija (
    ReisijaID INT PRIMARY KEY IDENTITY(1,1),
    Nimi VARCHAR(50),
    Piletinumber VARCHAR(20),
    LendID INT,
    FOREIGN KEY (LendID) REFERENCES Lend(LendID)
);

-- 3. Kasutaja loomine ning õiguste lisamine
CREATE USER reisijaKristo WITHOUT LOGIN;

GRANT CREATE TABLE TO reisijaKristo;
GRANT SELECT ON Lennujaam TO reisijaKristo;
GRANT SELECT ON Lend TO reisijaKristo;
GRANT SELECT ON Reisija TO reisijaKristo;
GRANT INSERT, DELETE ON Reisija TO reisijaKristo;
GRANT INSERT, DELETE ON Lend TO reisijaKristo;

-- 4. Logitabeli loomine
CREATE TABLE logi (
    id INT PRIMARY KEY IDENTITY(1,1),
    kasutaja VARCHAR(50),
    kuupaev DATETIME,
    sisestusAndmed VARCHAR(255)
);
-- 5. Triggereid
CREATE TRIGGER lennu_lisamine
ON Lend
AFTER INSERT
AS
BEGIN
    INSERT INTO logi (kasutaja, kuupaev, sisestusAndmed)
    SELECT SYSTEM_USER, GETDATE(), LennuNumber 
    FROM inserted;
END;


CREATE TRIGGER lennu_kustutamine
ON Lend
AFTER DELETE
AS
BEGIN
    INSERT INTO logi (kasutaja, kuupaev, sisestusAndmed)
    SELECT SYSTEM_USER, GETDATE(), LennuNumber 
    FROM deleted;
END;


-- 6. Testimiseks ettevalmistus
INSERT INTO Lennujaam (LennujaamaNimi, Linn) VALUES ('Tallinna Lennujaam', 'Tallinn');

-- 8. Protseduurid
CREATE PROCEDURE LisaLennujaam
    @nimi VARCHAR(50),
    @linn VARCHAR(50)
AS
    INSERT INTO Lennujaam (LennujaamaNimi, Linn) VALUES (@nimi, @linn);


CREATE PROCEDURE OtsiLendu
    @otsitavLinn VARCHAR(50)
AS
    SELECT Lend.LennuNumber, Lend.Valjumisaeg
    FROM Lend
    JOIN Lennujaam ON Lend.LennujaamID = Lennujaam.LennujaamID
    WHERE Lennujaam.Linn = @otsitavLinn;


CREATE PROCEDURE KustutaReisija
    @reisijaID INT
AS
    DELETE FROM Reisija WHERE ReisijaID = @reisijaID;

-- 9. Vaated
CREATE VIEW vw_TallinnaLennud AS
SELECT Lend.LennuNumber, Lennujaam.LennujaamaNimi, Lennujaam.Linn
FROM Lend
JOIN Lennujaam ON Lend.LennujaamID = Lennujaam.LennujaamID
WHERE Lennujaam.Linn = 'Tallinn';


CREATE VIEW vw_PeetriPilet AS
SELECT Reisija.Nimi, Reisija.Piletinumber, Lend.LennuNumber
FROM Reisija
JOIN Lend ON Reisija.LendID = Lend.LendID
WHERE Reisija.Nimi = 'Peeter Puu';


CREATE VIEW vw_TulevasedReisid AS
SELECT Reisija.Nimi, Lend.LennuNumber, Lend.Valjumisaeg
FROM Reisija
JOIN Lend ON Reisija.LendID = Lend.LendID
WHERE Lend.Valjumisaeg > GETDATE();

-- 10. Enda koostatud funktsioon
CREATE FUNCTION fnc_PaeviLennuni (@Valjumisaeg DATETIME)
RETURNS INT
AS
BEGIN
    RETURN DATEDIFF(DAY, GETDATE(), @Valjumisaeg);
END;


-- 11. Lõpptestid
EXEC LisaLennujaam @nimi = 'Tartu Lennujaam', @linn = 'Tartu';
EXEC OtsiLendu @otsitavLinn = 'Tallinn';

INSERT INTO Lend (LennuNumber, Valjumisaeg, LennujaamID) VALUES ('TK999', '2026-06-15 14:00:00', 1);
INSERT INTO Reisija (Nimi, Piletinumber, LendID) VALUES ('Peeter Puu', 'Pilet-999', 1);

SELECT * FROM vw_TallinnaLennud;
SELECT * FROM vw_PeetriPilet;
SELECT * FROM vw_TulevasedReisid;
SELECT LennuNumber, Valjumisaeg, dbo.fnc_PaeviLennuni(Valjumisaeg) AS Paevi_Jaanud FROM Lend;

EXEC KustutaReisija @reisijaID = 1;




select * from logi;
