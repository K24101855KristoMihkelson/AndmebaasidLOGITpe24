
[Select laused](select.md) | [Kasutaja loomine SQL Server](Kasutaja.md) | [Triggerid](trigerid.md) | [Kodutöö - Keys](keys.md) | [Küsimused](kysimused.md) |  [Protseduuride tegemine](charindex_proceduur.md) | [vaate tegemine](vaade.md)


# Andmebaasi vaated (Views)


### Vaade (ingl. view) on virtuaalne tabel, mis ei salvesta andmeid füüsiliselt, vaid on salvestatud SELECT-päring. 
### See võimaldab lihtsustada keerulisi päringuid ja parandada andmete turvalisust.

## Miks me vaateid kasutame?
### Lihtsustamine: Ühendab mitu tabelit üheks loogiliseks tervikuks.
### Abstraktsioon: Kasutaja ei pea teadma andmebaasi keerulist struktuuri.
### Turvalisus: Võimaldab piirata ligipääsu ainult teatud veergudele.

## Praktiline näide
### Kui soovime näha kliendi nime ja tema tehtud tellimusi, ei pea me iga kord JOIN operatsiooni kirjutama.

### Vaate loomine

```
CREATE VIEW KliendiOstud AS
SELECT Kliendid.eesnimi, Kliendid.perenimi, Tellimused.toote_nimi, Tellimused.summa
FROM Kliendid
JOIN Tellimused ON Kliendid.id = Tellimused.kliendi_id;

```
### Vaate kasutamine

### Nüüd on andmete pärimine märgatavalt kiirem ja lihtsam:

```
SELECT * FROM KliendiOstud WHERE summa > 50;
```
<img width="580" height="371" alt="{FA0FF14F-A91A-481E-B925-969005B94623}" src="https://github.com/user-attachments/assets/0df96795-ef5b-4f75-b09b-1053a96e1ad0" />

<img width="563" height="306" alt="{B3B6E8DB-F467-48AB-8693-64DFE90C67F4}" src="https://github.com/user-attachments/assets/74e13c6d-5cd2-4d54-be01-2e3852f711dd" />
