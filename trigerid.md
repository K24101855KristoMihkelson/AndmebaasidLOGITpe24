## Triger - trigger - päästik

[Select laused](select.md) | [Kasutaja loomine SQL Server](Kasutaja.md) | [Triggerid](trigerid.md) | [Kodutöö - Keys](keys.md) | [Küsimused](kysimused.md) |  [Protseduuride tegemine](charindex_proceduur.md) | [vaate tegemine](vaade.md)



### Trigger - andmebaasi objekt, mis käivitub automaatselt, kui toimub teatud sündmus (nt INSERT, UPDATE, DELETE).
trigerite loomine automatiseerub protsessid SQL serveris.

Tabelid mis tuleb luua enne trigerit!

```
create database trigerLogitpe24;

use trigerLogitpe24;
create table linnad(
linnId int primary key identity(1,1),
linnanimi varchar(30) unique,
maakond varchar(50),
rahvaarv int);
select * from linnad;
Insert into linnad(linnanimi, maakond, rahvaarv)
values ('Tallinn', 'Harjumaa', 600000);

--tabel logi - tabel, mis täidab triger, kui kasutaja täidab tabeli linnad!
create table logi(
id int primary key identity(1,1),
kasutaja varchar(50),
aeg datetime,
andmed text);
```
### Linnastamise triggeri täiendus ja tulemus
```
create trigger linnaLisamine
On linnad -- tabel, mida triger jälgib
for insert
as
insert into logi(kasutaja, aeg, andmed)
select system_user, --sisselogitud user
getdate(), 
concat('lisatud: ',inserted.linnanimi,', ', 
inserted.maakond,',' ,inserted.rahvaarv)
from inserted;
--kontrollimiseks tuleb lisada linna tabelisse linnad
Insert into linnad(linnanimi, maakond, rahvaarv)
values ('Viljandi', 'Viljandimaa', 5000);
```
<img width="490" height="372" alt="{DF2F948C-DF2E-495F-B764-B29DAA95BFFF}" src="https://github.com/user-attachments/assets/38305229-3f1d-465e-a8ca-2598703ea1ee" />

### Trigger, mis kustutab triggeris ära linna andmed

```
--2. DELETE triger - järgib kustutamine tabelis linnad
--ja teeb vastava kirje logi tabelisse
create trigger linnakustutamine
On linnad -- tabel, mida triger jälgib
for delete
as
insert into logi(kasutaja, aeg, andmed)
select system_user, --sisselogitud user
getdate(), 
concat('lisatud: ',deleted.linnanimi,', ', 
deleted.maakond,',' ,deleted.rahvaarv)
from deleted;

--kontroll
delete from linnad where linnId=2;
```
### Tulemus

<img width="505" height="417" alt="{33F71E9A-C77C-449A-9F23-5811AC42DB81}" src="https://github.com/user-attachments/assets/486d7ac7-48d1-4537-99af-ba074ad1ebcf" />

```
--3.UPDATE TRIGGER -jälgib uuendused/muutused tabelis linnad
--ja teeb vastava kirje tabelis logi
create trigger linnaUuendamine
On linnad -- tabel, mida triger jälgib
for UPDATE
as
insert into logi(kasutaja, aeg, andmed)
select 
system_user, --sisselogitud user
getdate(), 
concat('vana andmed: ',
deleted.linnanimi,', ', deleted.maakond,',' ,deleted.rahvaarv,
'||| uued andmed: ',
inserted.linnanimi,', ', inserted.maakond,',' ,inserted.rahvaarv)
from deleted inner join inserted
ON deleted.linnId=inserted.linnId;
```
<img width="779" height="600" alt="{FE1495DD-8427-4681-8C25-0626555915AF}" src="https://github.com/user-attachments/assets/95c580a2-41d3-4e11-b0a5-36c9073fe14e" />

```
--triger sisse/välja lülitamine
disable trigger linnaLisamine ON linnad;
disable trigger linnakustutamine ON linnad;
enable trigger linnaUuendamine ON linnad;
--Ühine triger mis jälgib kas lisamine või kustutamine tabelisse linnad
create trigger linnaLisamineKustutamine
On linnad -- tabel, mida triger jälgib
for insert, delete
as
Begin
set nocount on;
	insert into logi(kasutaja, aeg, andmed)
	select 
	system_user, --sisselogitud user
	getdate(), 
	concat('lisatud: ',inserted.linnanimi,', ', 
	inserted.maakond,',' ,inserted.rahvaarv)
	from inserted

	UNION ALL

	select 
	system_user, --sisselogitud user
	getdate(), 
	concat('kustutatud: ',deleted.linnanimi,', ', 
	deleted.maakond,',' ,deleted.rahvaarv)
	from deleted;
end;
```
<img width="671" height="536" alt="{FDE74C7D-5BA1-4841-BB9D-826B1D668FDA}" src="https://github.com/user-attachments/assets/f4c64765-1054-43ab-828c-e8d080a5257a" />

```
--teeme kasutaja sekretarKristo - õigustega linnalisamine, kustutamine, uuendamine, 
--ja ei näe tabeli logi ning ei saa trigerid muuta

--security--New login

kasutaja sekretarKristo osa
--select permission was denied on the object '
select * from logi;


delete from linnad where linnId=4;

Insert into linnad(linnanimi, maakond, rahvaarv)
values ('Viljandi2', 'Viljandimaa', 5000);

select * from linnad;
select * from logi;

grant select, insert, delete on linnad to sekretarKristo;
deny select on logi to sekretarKristo;
```

<img width="616" height="322" alt="{3A8375BD-FD67-45A9-A78E-E4A70CE6EF47}" src="https://github.com/user-attachments/assets/29bb1fd9-2fda-424b-b95f-1747bd755199" />

### Trigerid

<img width="711" height="659" alt="{D4A0B4A7-679B-420F-B5FF-ED4AEE4E58EE}" src="https://github.com/user-attachments/assets/da4b6588-af22-4791-b63a-be238e777f16" />

### logid kontroll ning trigerite kontroll

<img width="697" height="350" alt="{90ED6F7A-4914-406C-B47B-C5E418986CDA}" src="https://github.com/user-attachments/assets/2f7a083b-9e91-4c66-a3b7-fbe01a8067c6" />

<img width="972" height="411" alt="{BD2F39FC-3582-4F5F-A728-BFA141033449}" src="https://github.com/user-attachments/assets/51e4412e-acc4-4a6f-b8e2-58db2ef93ab6" />

### Linna kustutamise triger

<img width="683" height="735" alt="{4F99CB19-1EEC-4FB0-B9C4-B1CBEF3C8136}" src="https://github.com/user-attachments/assets/30f5b165-2805-4177-beb0-7697cd02dda0" />

### Kontroll

<img width="1060" height="399" alt="{B6B60960-6D2F-4E96-83B3-49C3384918A7}" src="https://github.com/user-attachments/assets/5d2ac7c9-789f-4e45-832d-050f203ee2d9" />


### Update trigger

<img width="712" height="746" alt="{4219E97C-9AF3-47C0-A0A9-471BA3C18E76}" src="https://github.com/user-attachments/assets/0127f819-b821-4d39-992f-c46f8f9c5180" />

### tulemus
<img width="809" height="309" alt="{43664553-5AE6-42B6-A7B9-8D70DFF09A34}" src="https://github.com/user-attachments/assets/a805fdcd-735c-44d0-8e9b-f5782d1e6baa" />

<img width="1013" height="363" alt="{9E1B14D5-4256-455B-AEF8-C36C1E6C7D72}" src="https://github.com/user-attachments/assets/f15414f4-4fff-45bd-8180-b9f439443e98" />


<img width="1013" height="363" alt="{9E1B14D5-4256-455B-AEF8-C36C1E6C7D72}" src="https://github.com/user-attachments/assets/e1df9217-d7b6-49bb-875c-3f38f511d4d1" />


