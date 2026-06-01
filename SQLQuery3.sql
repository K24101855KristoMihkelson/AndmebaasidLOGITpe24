-- 7. Õiguste ja andmete kontrollimine kasutajana
EXECUTE AS USER = 'reisijaKristo';


SELECT * FROM Lennujaam;

INSERT INTO Lend (LennuNumber, Valjumisaeg, LennujaamID) VALUES ('BT123', '2026-06-10 12:00:00', 1);
DELETE FROM Lend WHERE LennuNumber = 'BT123';

-- Alterile pole õigusi kasutajal

ALTER TABLE Reisija ADD test_veerg VARCHAR(10); 
REVERT; -- annab õigusi adminina


-- Siin ilmub error, kuna siin pole õigust
SELECT * FROM logi;


 