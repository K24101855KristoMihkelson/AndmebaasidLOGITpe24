## SQL Server – Kasutajate autentimine ja õiguste haldamine

[Select laused](select.md) | [Kasutaja loomine SQL Server](Kasutaja.md) | [Triggerid](trigerid.md) | [Kodutöö - Keys](keys.md) | [Küsimused](kysimused.md) |  [Protseduuride tegemine](charindex_proceduur.md) | [vaate tegemine](vaade.md)


Mis on autentimine SQL Serveris?
### Autentimine tähendab kasutaja tuvastamist ehk kontrollimist, kas kasutajal on õigus SQL Serverisse sisse logida.

**SQL Serveris kasutatakse kahte peamist autentimise tüüpi:** 

1. Windows Authentication
Selle puhul kasutatakse samu kasutajaandmeid, millega logitakse sisse Windows operatsioonisüsteemi.

>Kasutajanimi ja parool on seotud Windowsiga.
>Turvalisem lahendus.
>Paroole haldab Windows.
>Kasutaja ei pea eraldi SQL Serveri parooli teadma.
2. SQL Server Authentication
>Selle puhul luuakse kasutaja otse SQL Serverisse.
>Kasutaja ei ole seotud Windowsiga.
>Määratakse eraldi kasutajanimi ja parool.
>Sobib veebirakenduste jaoks.
-------------------------------------------------------
**Näide kasutajast: DirectorKristo. Parool: director
-------------------------------------------------------
Näide kasutajast: DirectorNimi
Parool: director
## Kasutaja loomine SQL Serveris
1. Serveritaseme kasutaja loomine (Login)
Sammud
Ava:

Security → Logins
Tee paremklikk ja vali:

New Login...

>>>>>pilt
<img width="715" height="661" alt="{B5E09FED-8E98-41C5-A5D2-6AB06DA2B95F}" src="https://github.com/user-attachments/assets/cd851baf-245a-46ad-a5c5-47323056a254" />
>>>>>
Harjutamiseks võib eemaldada linnukese:  User must change password at next login

**Server Roles**
Menüüst Server Roles saab määrata serveri üldised õigused.

Tavaliselt piisab rollist: public


>>>>>pilt
<img width="705" height="666" alt="{251B3F11-7DBF-4FE6-97E8-3652182B4687}" src="https://github.com/user-attachments/assets/b6457907-be31-41ac-ad60-badb91a9d11e" />

>>>>>
2. Andmebaasi kasutaja loomine (User)
Ava:

Database → Security → Users
Tee paremklikk:  New User...

Seosta kasutaja loginiga
>>>>>pilt
<img width="301" height="417" alt="{259CD6BD-4A10-4AEA-913F-ECC397B7756D}" src="https://github.com/user-attachments/assets/d47e1e3f-9d55-47bf-8fac-9186a11ec35b" />
>>>>>
Membership ja õigused
Menüüst Membership saab määrata kasutaja rollid.

db_datareader → võib lugeda
db_datawriter → võib kirjutada
>>>>>pilt
<img width="703" height="663" alt="{31DDE20E-EA48-407F-9849-7E0F2131B52A}" src="https://github.com/user-attachments/assets/ee103f13-1035-4ee4-a646-93a34ea1871b" />


>>>>>
----------------------------------------------------------------
## Kasutaja õiguste kontroll

1. tuleb sisselogida kasutajana directorKristo. Connect --> Database Engine
<img width="438" height="273" alt="{C3900DA9-8DCE-469D-9DE5-64FB66FCA9FF}" src="https://github.com/user-attachments/assets/3ed38a65-fab1-4d9c-a316-6feba4af4317" />

2. Saab näha tabeli sisu ning sisestada uut kirja:

<img width="498" height="302" alt="{A8D2E9BB-ECD9-45A3-BFBC-D41944DB233A}" src="https://github.com/user-attachments/assets/fe0fc1b0-ae02-41ed-9d4e-7ea5f9688398" />

3. Kontrollime tegevus, mis ei ole lubatud kasutajale, näiteks tabeli loomine
<img width="560" height="292" alt="{20D87E28-F345-4815-903E-B2B5BAB98466}" src="https://github.com/user-attachments/assets/caed9ddc-a48c-47d1-b895-e3fbdb352263" />



SQL Server Authentication Mode muutmine
Kui ilmub viga: Error 18456, siis on tavaliselt lubatud ainult Windows Authentication.
Lahendus
Server → Properties
Security
Vali: SQL Server and Windows Authentication mode
GRANT käsud õiguste jagamiseks
GRANT käsuga antakse kasutajale õigused.

Käsk	Tähendus
SELECT	Lugemine
INSERT	Lisamine
UPDATE	Muutmine
DELETE	Kustutamine
```
--GRANT - õiguste määramine
--DENY - õiguste keelamine

--db_datareader -select
--db_datawriter - INSERT, DELETE, UPDATE

--anname kasutajale directorKristo õiguse 
-- ainult kustutada ja uuendada tabelit 
--(DELETE, UPDATE, SELECT)

GRANT DELETE ON puhkus TO directorKristo;
GRANT UPDATE ON puhkus TO directorKristo;
GRANT SELECT ON puhkus TO directorKristo;

--keelame INSERT
DENY INSERT ON puhkus TO directorKristo;
--GRANT - õiguste määramine
--DENY - õiguste keelamine

--db_datareader -select
--db_datawriter - INSERT, DELETE, UPDATE

--anname kasutajale directorKristo õiguse 
-- ainult kustutada ja uuendada tabelit 
--(DELETE, UPDATE, SELECT)

GRANT DELETE ON puhkus TO directorKristo;
GRANT UPDATE ON puhkus TO directorKristo;
GRANT SELECT ON puhkus TO directorKristo;

--keelame INSERT
DENY INSERT ON puhkus TO directorKristo;
```
>>>>>pilt
<img width="719" height="263" alt="{B5D65D3B-4E99-4E6B-AA9E-4CE75B03C595}" src="https://github.com/user-attachments/assets/c804bb26-ae95-4ec8-9c40-f2af087b19ab" />

<img width="430" height="158" alt="{276E2696-2C7E-447E-A940-1B365D6B7FD8}" src="https://github.com/user-attachments/assets/a08e5137-251b-417b-93de-a3ef391bf715" />

<img width="487" height="290" alt="{62937897-4979-4A79-9905-7E6ED95CFD7F}" src="https://github.com/user-attachments/assets/70b7da34-e14d-43f9-9da2-1d54127c0f48" />

<img width="656" height="454" alt="{B1A8A0A9-5819-47C1-BC95-07B5E9EE0D23}" src="https://github.com/user-attachments/assets/f362d46b-637b-4422-8ea7-f98aa78c0d0d" />

    
Ülesanne 1:
Luua andmebaas: MovieBase

Luua tabelid: 

movies (id, moviesNimi, moviesYear, movieDir и movieCost).
guest (id, name)
Lisada vähemalt 7 kirjet.

Luua kasutaja Produtsent parooliga director, kellel on järgmised õigused:
Õigus vaadata ja uuendada tabeli movies välju movieDir ja movieCost + lisada üks enda valitud privileeg.
Õigus vaadata ja lisada kirjeid tabelisse guest.
Keela andmete kustutamine tabelis.
Vihje! UPDATE õigused parem lubada SQL käsuga
GRANT UPDATE (movieCost, movieDir)
ON movies
TO Produtsent;
    
