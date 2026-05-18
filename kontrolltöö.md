1. Tabelite struktuuri haldamine (DDL - Data Definition Language)
Tabeli loomine (CREATE TABLE) Tabeli loomisel määratakse veergude nimed, andmetüübid ja piirangud (näiteks PRIMARY KEY või NOT NULL)
.
CREATE TABLE City (
    ID counter NOT NULL PRIMARY KEY,
    Name varchar(50) NOT NULL,
    CountryCode char(3) NOT NULL,
    Population long
);
``` [3]

**Tabeli struktuuri muutmine (`ALTER TABLE`)**
Kasutatakse uute veergude lisamiseks või olemasolevatele piirangute lisamiseks [4]. 
Näide uue veeru lisamisest:
```sql
ALTER TABLE City ADD cityName varchar(30);
``` [5]
Näide välisvõtme (`FOREIGN KEY`) lisamisest:
```sql
ALTER TABLE Country ADD CONSTRAINT fk_city FOREIGN KEY(Capital) REFERENCES City(ID);
``` [6]

**Tabeli kustutamine (`DROP TABLE`)**
Kustutab tabeli ja kõik selle andmed jäädavalt [7].
```sql
DROP TABLE City;
``` [7]

---

### 2. Andmete manipuleerimine (DML - Data Manipulation Language)

**Uute andmete lisamine (`INSERT INTO`)**
Lisab tabelisse uue rea. Veergude nimed ja väärtused peavad olema vastavuses [8, 9].
```sql
INSERT INTO City(cityName, continent, countryName, population)
VALUES ('Narva', 'Europe', 'Estonia', 66151);
``` [9, 10]

**Andmete uuendamine (`UPDATE`)**
Uuendab olemasolevaid andmeid. Alati tasub kasutada `WHERE` tingimust, muidu uuendatakse kogu tabeli read [11, 12].
```sql
UPDATE City 
SET district = "undefined" 
WHERE district IS NULL;
``` [12]

**Andmete kustutamine (`DELETE`)**
Kustutab read vastavalt tingimusele. Kui `WHERE` tingimus puudub, tehakse tabel tühjaks, aga tabeli struktuur ise jääb alles [13].
```sql
DELETE FROM City 
WHERE CityName like "Narva";
``` [13]

---

### 3. Andmete pärimine ja filtreerimine (SELECT)

**Lihtne päring ja tulemuste piiramine (`TOP` / `LIMIT`)**
Andmete välja võtmine ja kuvatavate ridade arvu piiramine [14, 15].
```sql
SELECT TOP 5 Name, Continent, SurfaceArea 
FROM Country 
ORDER BY SurfaceArea;
``` [15]

**Filtreerimine (`WHERE`) ja sorteerimine (`ORDER BY`)**
Andmete välja filtreerimine operaatoritega (näiteks `>=`, `<` ja loogiline `AND`) ja kahanevalt (`DESC`) sorteerimine [16, 17].
```sql
SELECT Name, Continent, Population 
FROM Country 
WHERE IndepYear >= 1900 AND IndepYear < 2000 
ORDER BY Continent, Population DESC;
``` [16, 18]

**Unikaalsete väärtuste leidmine (`DISTINCT`)**
Välistab korduvad read väljundist (näiteks ainult unikaalsete klientide numbrite kuvamiseks) [19, 20].
```sql
SELECT distinct customerNumber 
FROM payments 
WHERE paymentDate < '2004-10-28';
``` [20]

---

### 4. Grupeerimine ja agregaatfunktsioonid

**Funktsioonide kasutamine ja grupeerimine (`GROUP BY`)**
Agregaatfunktsioone (nagu `COUNT`, `SUM`, `AVG`) kasutatakse gruppide kohta summeeriva info saamiseks [21, 22]. 
```sql
SELECT countryName, COUNT(*) AS [Linnade arv] 
FROM City 
GROUP BY countryName;
``` [23]

**Grupeeritud andmete filtreerimine (`HAVING`)**
Tingimuste seadmine peale andmete grupeerimist [23, 24]. Agregaatfunktsiooniga tingimusi ei saa `WHERE` lauses kasutada [22].
```sql
SELECT countryName, COUNT(*) AS [Linnade arv] 
FROM City 
GROUP BY countryName, continent 
HAVING continent like "Asia";
``` [24]

---

### 5. Tabelite ühendamine (JOIN)

Selleks et kahest omavahel seotud tabelist (võtmete abil) andmeid pärida, kasutatakse ühendamist, lühendades tabelite nimetusi *alias*tega (näiteks `Country AS C`) [25, 26].

**Sisemine ühend (INNER JOIN)**
Tagastab ainult need read, millel on mõlemas tabelis vaste olemas [27, 28].
```sql
SELECT C.Name AS Riik, Ci.CityName AS Pealinn 
FROM Country AS C INNER JOIN City AS Ci 
ON C.Capital = Ci.ID;
``` [29]

**Vasakpoolne välisühend (LEFT JOIN)**
Tagastab kõik read esimesest tabelist (`Country`), isegi kui teises tabelis (`City`) neile vastet ei leidu [30].
```sql
SELECT C.Name AS Riik, Ci.CityName AS Pealinn 
FROM Country AS C LEFT JOIN City AS Ci 
ON C.Capital = Ci.ID;
``` [31]

1. Päring autode otsimiseks aasta järgi

Selle protseduuri eesmärk on kuvada autod kindla aasta järgi. Kasutaja sisestab aasta parameetrina ja protseduur näitab ainult neid autosid, mille väljalaskeaasta vastab sisestatud väärtusele.

-- Kuvab autod kindla aasta järgi
CREATE PROCEDURE AutodAastaJargi
@aasta varchar(10)
AS
BEGIN
    SELECT autonumber, mark, varv, hind, v_aasta
    FROM auto
    WHERE v_aasta = @aasta;
END;

EXEC AutodAastaJargi '2007';
2. Päring autode otsimiseks hinna järgi

Selle protseduuri eesmärk on kuvada autod, mille hind ei ületa kasutaja sisestatud summat. Parameetriks on maksimaalne hind ning tulemuses näidatakse ainult sobiva hinnaga autod.

-- Kuvab autod, mille hind on väiksem või võrdne sisestatud hinnaga
CREATE PROCEDURE AutodMaxHinnaga
@maxhind decimal(10,2)
AS
BEGIN
    SELECT autonumber, mark, varv, hind
    FROM auto
    WHERE hind <= @maxhind;
END;

EXEC AutodMaxHinnaga 6000;
3. Päring autode otsimiseks margi ja värvi järgi

Selle protseduuri eesmärk on kuvada autod kindla margi ja värvi järgi. Kasutaja sisestab kaks parameetrit: auto margi ja värvi. Tulemuseks kuvatakse ainult need autod, mis vastavad mõlemale tingimusele.

-- Kuvab autod kindla margi ja värvi järgi
CREATE PROCEDURE AutodMarkVarv
@mark varchar(20),
@varv varchar(20)
AS
BEGIN
    SELECT autonumber, mark, varv, hind, v_aasta
    FROM auto
    WHERE mark = @mark AND varv = @varv;
END;

EXEC AutodMarkVarv 'Nissan', 'Orange';
