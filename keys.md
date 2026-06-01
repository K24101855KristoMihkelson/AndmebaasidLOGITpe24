
[Select laused](select.md) | [Kasutaja loomine SQL Server](Kasutaja.md) | [Triggerid](trigerid.md) | [Kodutöö - Keys](keys.md) | [Küsimused](kysimused.md) |  [Protseduuride tegemine](charindex_proceduur.md) | [vaate tegemine](vaade.md)


# Andmebaasi võtmed (Keys)



Failis on ära selgitatud relatsiooniliste andmebaaside peamised võtmetüübid koos logistikasüsteemidel põhinevate SQL-näidetega.

---

## 1. Primary Key (Primaarvõti)
* **Definitsioon:** Tabeli veerg või veergude kogum, mis identifitseerib iga kirje (rea) tabelis üheselt.
* **Kasutuseesmärk:** Andmete üheseks tuvastamiseks. Tagab, et iga rida on kordumatu ja andmebaasist täpselt leitav.
* **Erinevus teistest:** Tabelis saab olla maksimaalselt üks Primary Key ja see ei tohi kunagi sisaldada tüüpväärtust (NULL).
* **Praktiline näide (SQL):**
```
CREATE TABLE Kullerid (
    KullerID INT PRIMARY KEY,
    Eesnimi VARCHAR(50),
    Perenimi VARCHAR(50)
);
```
<img width="490" height="342" alt="image" src="https://github.com/user-attachments/assets/b6093f36-6df6-4624-9fe8-4bf529536cc8" />

## 2. Foreign Key (Võõrvõti)
* **Definitsioon:** Veerg (või veerud) ühes tabelis, mis viitab teise tabeli primaarvõtmele.
* **Kasutuseesmärk:** Tabelite vaheliste seoste (relatsioonide) loomiseks ja andmete terviklikkuse tagamiseks. Välistab olukorra, kus viidatakse olematule kirjele.
* **Erinevus teistest:** Ei pea olema oma algses tabelis unikaalne ja lubab NULL väärtusi.
* **Praktiline näide (SQL):**
```
CREATE TABLE Veokid (
    VeokID INT PRIMARY KEY,
    RegNumber VARCHAR(10)
);

CREATE TABLE Soidupaevik (
    SoiduID INT PRIMARY KEY,
    VeokID INT,
    Kuupaev DATE,
    FOREIGN KEY (VeokID) REFERENCES Veokid(VeokID)
);
```
<img width="713" height="939" alt="image" src="https://github.com/user-attachments/assets/41351dc9-39cc-4a76-9c0a-4f4bd2842a3f" />

## 3. Unique Key (Unikaalvõti)
* **Definitsioon:** Piirang, mis tagab, et veerus või veergude kombinatsioonis poleks korduvaid väärtusi.
* **Kasutuseesmärk:** Unikaalsuse nõudmiseks andmetele, mis ei ole primaarvõtmed (näiteks isikukood või numbrimärk).
* **Erinevus teistest:** Erinevalt primaarvõtmest võib ühes tabelis olla mitu unikaalvõtit ning see lubab ühte NULL väärtust.
* **Praktiline näide (SQL):**
```
ALTER TABLE Kullerid 
ADD Isikukood CHAR(11) UNIQUE;
```
<img width="464" height="314" alt="image" src="https://github.com/user-attachments/assets/3b921d42-66d3-417d-a3a6-7317fd851773" />

## 4. Simple Key (Lihtvõti)
* **Definitsioon:** Võti (enamasti primaarvõti), mis koosneb täpselt ühest ainsast veerust.
* **Kasutuseesmärk:** Kirjete lihtsaks ja kiireks identifitseerimiseks arvulise ID abil.
* **Erinevus teistest:** Koosneb alati vaid ühest atribuudist, olles vastandiks liitvõtmetele.
* **Praktiline näide (SQL):**
```
CREATE TABLE Laod (
    LaduID INT PRIMARY KEY,
    LaoNimi VARCHAR(100)
);
```
<img width="464" height="314" alt="image" src="https://github.com/user-attachments/assets/7363043d-2b65-4b49-ae33-621440b3605a" />

## 5. Composite Key (Liitvõti)
* **Definitsioon:** Primaarvõti, mis koosneb kahest või enamast veerust. Üksik veerg eraldiseisvalt ei pruugi olla unikaalne.
* **Kasutuseesmärk:** Olukordades, kus ühest veerust ei piisa rea unikaalseks muutmiseks (näiteks tellimuse detailide read).
* **Erinevus teistest:** Sisaldab mitut veergu, millest ükski ei pruugi eraldiseisvalt viidata teisele tabelile (võõrvõti).
* **Praktiline näide (SQL):**
```
CREATE TABLE TellimuseRead (
    TellimusID INT,
    ReaNumber INT,
    TooteNimetus VARCHAR(100),
    PRIMARY KEY (TellimusID, ReaNumber) 
);
```
<img width="561" height="323" alt="image" src="https://github.com/user-attachments/assets/f2279248-8c4a-4703-a1e3-20669bad6835" />

## 6. Compound Key (Ühendvõti)
* **Definitsioon:** Liitvõtme (Composite Key) tüüp, kus kõik võtme koosseisu kuuluvad veerud on ühtlasi võõrvõtmed (Foreign Keys).
* **Kasutuseesmärk:** Mitu-mitmele (Many-to-Many) seoste lahendamiseks mõeldud vahetabelites.
* **Erinevus teistest:** Iga võtme komponent on range viide mõnele teisele tabelile.
* **Praktiline näide (SQL):**
```
CREATE TABLE KullerVeok (
    KullerID INT,
    VeokID INT,
    PRIMARY KEY (KullerID, VeokID), 
    FOREIGN KEY (KullerID) REFERENCES Kullerid(KullerID),
    FOREIGN KEY (VeokID) REFERENCES Veokid(VeokID)
);
```
<img width="756" height="407" alt="image" src="https://github.com/user-attachments/assets/3adea2e1-69c1-46f2-a343-9978b55a5407" />

**Composite Key** koosneb mitmest veerust, kuid need ei pea viitama teistele tabelitele.
**Compound Key** on sama, kuid kõik veerud on ühtlasi võõrvõtmed — see on Composite Key erijuhtum.

**Lihtne reegel:** kui liitvõtme veerud viitavad teistele tabelitele → Compound Key. Kui mitte → Composite Key.

## 7. Superkey (Supervõti)
* **Definitsioon:** Veerg või veergude kombinatsioon, mis tuvastab tabelis iga rea unikaalselt. See võib sisaldada ka üleliigseid veergusid.
* **Kasutuseesmärk:** Andmebaaside teoorias kasutatav kontseptsioon, mille baasilt selekteeritakse välja optimaalne primaarvõti.
* **Erinevus teistest:** Sisaldab sageli atribuute, mida ei ole rea unikaalseks tuvastamiseks tingimata vaja (nt ID + Nimi).
* **Praktiline näide (SQL):**
```
ALTER TABLE Laod 
ADD CONSTRAINT UQ_Superkey UNIQUE (LaduID, LaoNimi);
```
<img width="703" height="256" alt="image" src="https://github.com/user-attachments/assets/37b76b52-5bbf-4985-a72b-dd3c7c64d806" />

## 8. Candidate Key (Kandidaatvõti)
* **Definitsioon:** Minimaalne supervõti. See on unikaalne veerg või veergude kombinatsioon, millest ei saa ühtegi osa eemaldada, ilma et unikaalsus kaoks.
* **Kasutuseesmärk:** Kandidaadid, mille hulgast andmebaasi arhitekt valib välja ühe ametliku primaarvõtme.
* **Erinevus teistest:** See on minimaalne (erinevalt supervõtmest) ja ühes tabelis võib neid olla mitu. Neist ainult üks saab primaarvõtmeks.
* **Praktiline näide (SQL):**
```
CREATE TABLE Kliendid (
    KliendiID INT NOT NULL, 
    Registrikood VARCHAR(20) NOT NULL, 
    KliendiNimi VARCHAR(100),
    CONSTRAINT PK_Kliendid PRIMARY KEY (KliendiID),
    CONSTRAINT UQ_RegKood UNIQUE (Registrikood)
);
```
<img width="697" height="354" alt="image" src="https://github.com/user-attachments/assets/01f2c774-1138-4128-8141-22888656cb3d" />


## 9. Alternate Key (Alternatiivvõti)
* **Definitsioon:** See on kandidaatvõti, mida ei valitud tabeli lõplikuks primaarvõtmeks.
* **Kasutuseesmärk:** Tagada sekundaarse andmevälja (näiteks registrikoodi) unikaalsus, et vältida dubleerimist.
* **Erinevus teistest:** Omadustelt sama tugev kui primaarvõti, kuid süsteemi loogika ei kasuta seda põhilise viitena (Primary Key'na).
* **Praktiline näide (SQL):**
```
SELECT 
    CONSTRAINT_NAME, 
    CONSTRAINT_TYPE 
FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS 
WHERE TABLE_NAME = 'Kliendid';
```
<img width="595" height="331" alt="image" src="https://github.com/user-attachments/assets/245d6909-d2db-45d7-a6d4-7fba67441f67" />

## Kasutatud allikad

1. [Microsoft Learn — Primary and Foreign Key Constraints](https://learn.microsoft.com/en-us/sql/relational-databases/tables/primary-and-foreign-key-constraints)
2. [W3Schools — SQL Keys](https://www.w3schools.com/sql/sql_primarykey.asp)
3. [GeeksforGeeks — Types of Keys in Relational Model](https://www.geeksforgeeks.org/types-of-keys-in-relational-model/)
4. Praktilised SQL näited — enda loodud
