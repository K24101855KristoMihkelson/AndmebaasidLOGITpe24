## Triger - trigger - päästik
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
