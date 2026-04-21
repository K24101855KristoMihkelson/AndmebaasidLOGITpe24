# AndmebaasidLOGITpe24
Andmebaasidega seotud sql kood ja konspektid

- SQL - structured Query Language - struktureeritud päringukeel
- DDL - Data definition Language -andmebaasistruktuuri loomiseks - CREATE, ALTER
- DML -  Data Manipulation Language -andmete lisamine ja uuendamine tabelis - INSERT, UPDATE, DELETE
## Sisukord
- [andmebaasihaldusüsteemid](#-andmebaasihaldusüsteemid)
- [Põhimõisted](#-põhimõisted)
- [Andmetüübid](#-Andmetüübid)
- [Piirangud](#-Piirangud)
- [Tabelivahelised Seosed](#tabelivahelised-seosed)
### Tunnis me kasutame andmebaasihaldussüsteemid:
<img width="482" height="514" alt="{84003173-1B56-4DA7-B142-7CE2E7B7597B}" src="https://github.com/user-attachments/assets/6783e0d9-ddc5-4075-87bd-fc23701f2781" />


1. SQL Server Management Stuudio (SQL Serveri haldamiseks)
2.  XAMPP -phpmyAdmin (mariadb andmebaas) -vabavara

      ## Põhimõisted
      
 - andmebaas - struktureeritud andmete kogum
 -  tabel - olem (entity) 
 - veerg - väli (field) 
 - rida - kirje (record)
 - primaarne võti -PK-Primary Key - veerg (tavaliselt nimega id) unikaalse identifikaatoriga, mis eristab iga kirjet
 - välisvõti (võõrvõti) -FK Foreign Key - veerg, mis loob seose teise tabeli primaarvõtmega.

     ## Andmetüübid
   - INT, float, decimal(6,2) - numbrilised
   - varchar(50), char(6) -tekst/sümbolid
   - boolean, bool, bit -loogiline tüüp
   - date, time, datetime - kuupäeva
  

  ## Piirangud
  
```
  1. Primary Key - Määrab tabeli primaarvõtme veeru või veergude kogumina
  2. Foreign Key - Määrab välisvõtme, millega seotakse omavahel kaks tabelit
  3. Unique - Tagab, et veerus või veergude kogumis ei lubataks väärtuse dubleerimist
  4. Not Null - Keelab (takistab) null-väärtuste lisamise
  5. Check - Kasutatakse määratud väärtustega veeru lubatud väärtuste hulga piiramiseks
```

 ## Tabelivahelised Seosed
- üks - ühele (nt mees --naine)
- üks - mitmele (õpilane käib erinevates õppeainetes)
<img width="602" height="539" alt="{0AC09704-51C6-4D3C-A9BF-87F7EFB1F7BF}" src="https://github.com/user-attachments/assets/d691bfe2-e694-491f-8878-aecb15e7a16a" />


- mitu-mitmele (nt õpilane - õpetaja)

## Stored procedure
  Salvestatud protseduurid - sama mis on funktsioonid programmeerimises - mingi tegevus(ed), mida saab automaatselt teha (INSERT, SELECT, UPDATE, DELETE) 
```sql
select * from categories;
--protseduur, mis täidab tabeli
CREATE PROCEDURE lisaKategooria
@nimi varchar(15)
AS
BEGIN
    INSERT INTO categories
	VALUES (@nimi);
	SELECT * FROM categories;
END
--kutse
EXEC lisaKategooria 'test';
--proceduur, mis kustutab tabelist id järgi
Create procedure kustutaIdJargi
@id int
AS
BEGIN
	select * from categories;
	DELETE FROM categories where category_id=@id;
	select * from categories;
END
--kutse 
EXEC kustutaIdJargi 3;
```




