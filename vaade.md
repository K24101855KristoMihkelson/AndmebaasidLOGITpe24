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
