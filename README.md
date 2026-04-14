# AndmebaasidLOGITpe24
Andmebaasidega seotud sql kood ja konspektid

- SQL - structured Query Language - struktureeritud päringukeel
- DDL - Data definition Language -andmebaasistruktuuri loomiseks - CREATE, ALTER
- DML -  Data Manipulation Language -andmete lisamine ja uuendamine tabelis - INSERT, UPDATE, DELETE

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
  1. Primary Key - Määrab tabeli primaarvõtme veeru või veergude kogumina
  2. Foreign Key - Määrab välisvõtme, millega seotakse omavahel kaks tabelit
  3. Unique - Tagab, et veerus või veergude kogumis ei lubataks väärtuse dubleerimist
  4. Not Null - Keelab (takistab) null-väärtuste lisamise
  5. Check - Kasutatakse määratud väärtustega veeru lubatud väärtuste hulga piiramiseks
  ```
 ## Tabelivahelised Seosed
- üks - ühele (nt mees --naine)
- üks - mitmele (õpilane käib erinevates õppeainetes)
<img width="500" height="150" alt="{511D1187-6ACE-477B-9E85-50BA20EB2739}" src="https://github.com/user-attachments/assets/4f7c81bd-9c7c-4507-a4cc-cc8d8efca7d2" />

- mitu-mitmele (nt õpilane - õpetaja)

