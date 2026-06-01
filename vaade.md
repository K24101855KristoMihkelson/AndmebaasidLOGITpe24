# Andmebaasi ülevaade ja kontseptsioonid

Käesolev dokument koondab andmebaaside põhimõisteid, struktuuri ja seoseid, mida kasutatakse projektis `AndmebaasidLOGITpe24`.

## 1. Andmebaasi põhimõisted
Andmebaas on struktureeritud andmete kogum, mis koosneb järgmistest elementidest:
- **Tabel:** Olem (*entity*), mis hoiab andmeid.
- **Veerg:** Väli (*field*), mis määratleb andmetüübi.
- **Rida:** Kirje (*record*), mis sisaldab konkreetset andmeüksust.

### Võtmed ja piirangud
- **Primaarvõti (PK):** Unikaalne identifikaator, mis eristab iga tabeli kirjet.
- **Välisvõti (FK):** Veerg, mis loob seose teise tabeli primaarvõtmega.
- **Muud piirangud:**
    - `UNIQUE`: välistab duplikaadid.
    - `NOT NULL`: kohustuslik väli.
    - `CHECK`: piirab lubatud väärtuste hulka.

---

## 2. Tabelivahelised seosed
Andmemudelis eristatakse peamiselt kolme tüüpi seoseid:
1. **Üks-ühele:** Üks kirje ühes tabelis vastab ühele kirjele teises.
2. **Üks-mitmele:** Üks kirje ühes tabelis on seotud mitme kirjega teises (nt õpilane ja tema ained).
3. **Mitu-mitmele:** Keerulisem seos, mis vajab sageli vahetabelit (nt õpilased ja õpetajad).

---

## 3. Andmebaasihaldussüsteemid (DBMS)
Projektis kasutatakse järgmisi keskkondi:
- **SQL Server Management Studio (SSMS):** Professionaalseks SQL Serveri halduseks.
- **XAMPP (phpMyAdmin):** MariaDB andmebaaside haldamiseks.

---

## 4. SQL-i kategooriad
- **DDL (Data Definition Language):** Struktureerimine (`CREATE`, `ALTER`).
- **DML (Data Manipulation Language):** Andmetega opereerimine (`INSERT`, `UPDATE`, `DELETE`).
- **Stored Procedures:** Salvestatud protseduurid ja funktsioonid korduvate toimingute automatiseerimiseks.

---
*Dokumentatsioon loodud projekti [AndmebaasidLOGITpe24](https://github.com/K24101855KristoMihkelson/AndmebaasidLOGITpe24) raames.*
