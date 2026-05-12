--DB loomine
create database LOGITpe24person;
use LOGITpe24person

--DB kustutamine
DRop DataBASE IKTpv25person

--Tabel Gender loomine
create table Gender
(
Id int NOT NULL primary key,
Gender nvarchar(10) not null
)

--Tabel Person loomine
create table Person
(
Id int not null primary key,
Name nvarchar(25),
Email nvarchar(30),
GenderId int
)

--- andmete sisestamine tabelisse
insert into Gender (Id, Gender)
values (1, 'Female')
insert into Gender (Id, Gender)  
values (2, 'Male')

-- muudab tabeli ja lisab foreign key
alter table Person add constraint tblPerson_GenderId_FK
foreign key (GenderId) references Gender(Id)

select * from Gender;
--  Lisab person tabelisse andmeid sisse
insert into Person (Id, Name, Email, GenderId)
values (1, 'Supermees', 's@s.com', 2)
insert into Person (Id, Name, Email, GenderId)
values (2, 'Wonderwoman', 'w@w.com', 1)
insert into Person (Id, Name, Email, GenderId)
values (3, 'Batman', 'b@b.com', 2)
insert into Person (Id, Name, Email, GenderId)
values (4, 'Aquaman', 'a@a.com', 2)
insert into Person (Id, Name, Email, GenderId)
values (5, 'Catwoman', 'c@c.com', 1)
insert into Person (Id, Name, Email, GenderId)
values (6, 'Antman', 'ant"ant.com', 2)
insert into Person (Id, Name, Email, GenderId)
values (7, 'Spiderman', 'spider@spiderman.com', 2)

-- vaatame tabeli andmeid
select * from Person

--- muudab tabelit person ja eemaldab foreign key
alter table Person
drop constraint tblPerson_GenderId_FK

-- sisestab gender tabelisse kolmas tundmatu sugu
insert into Gender (Id, Gender)
values (3, 'Unknown')
-- vaikimisi lisame gender id = 3
alter table Person
add constraint DF_Person_GenderId
default 3 for GenderId


select * from Person
select * from Gender

insert into Person (Id, Name, Email)
values (9, 'Kristo', 'krismihkel@gmail.com')
--- muudame tabel person ja lisame vanuse
alter table Person
add Age nvarchar(10)

--uuendame andmeid
update Person
set Age = 149
where Id = 9

-- muudab tabelit person ja lisab täiendava kontrolli ,et vanus on rohkem kui 0 ja väiksem kui 150
alter table Person
add constraint CK_Person_Age check (Age > 0 and Age < 150)

insert into Person (Id, Name, Email, GenderId, Age)
values (9, 'Test', 'Test', 2, 160)

-- kuvab andmed tabelist person ja käivitab scripti mis kustutab inimse kelle id = 8
select * from Person
go
delete from Person where Id = 8
go
select * from Person

--- lisame veeru juurde
alter table Person
add City nvarchar(25)

-- kuvab ainult tabelist person linna mille nimi on Gotham
select * from Person where City = 'Tabivere'
update person set city = 'Gotham' where id = 2

-- kõik, kes ei ela Gothamis
select * from Person where City <> 'Gotham'
select * from Person where City != 'Gotham'

-- kuvab tabelist person inimesed kes on 100 aastased, 50 aastased või 20 aastased
select *from Person where Age = 100 or 
Age = 50 or Age = 20
select * from Person where Age in (100, 50, 20)
update person set age = 20 where id = 9

--- kuvab tabelist person inimesed kes elavad linnas mis algavad n tähega ja emailid
select * from Person where City like 'n%'
select * from Person where Email like '%@%'

-- kuvab inimesed tabelist person kellele ei ole email
select * from Person where Email not like '%@%'

--- näitab, kelle on emailis ees ja peale @-märki
-- ainult üks täht
select * from Person where Email like '_@_.com'

-- kuvab inimesed tabelist person kelle nimi sisaldab täht WAS
select * from Person where Name like '[^WAS]%'
--- kuvab inimesed tabelist kes elavad kas linnas Gotham või Tallinn ja kelle vanus on suurem või võrdne 40
select * from Person where (City = 'Gotham' or City = 'Tallinn')
and Age >= 40

---võtab kolm esimest rida
select top 3 * from Person

--- kuvab esimest 3 ridade vanus ja nimi
select * from Person
select top 3 Age, Name from Person

--- kuvatakse 50 protsenti kasutajatest
select top 50 percent * from Person
-- esimeses selectis kuvamine toimub väiksemast suuremani teises toimub vastupidi
select * from Person order by cast(Age as int)
select * from Person order by Age


-- kuvab maksimaalse vanuse määra
select max(cast(Age as int)) from Person

select City, sum(cast(Age as int)) as TotalAge from Person group by City


--- loome uued tabelid
create table Department
(
Id int primary key,
DepartmentName nvarchar(50),
Location nvarchar(50),
DepartmentHead nvarchar(50)
)

create table Employees
(
Id int primary key,
Name nvarchar(50),
Gender nvarchar(10),
Salary nvarchar(50),
DepartmentId int
)

-- Täidab tabeli department 
insert into Department (Id, DepartmentName, Location, DepartmentHead)
values (1, 'IT', 'London', 'Rick')
insert into Department (Id, DepartmentName, Location, DepartmentHead)
values (2, 'Payroll', 'Delhi', 'Ron')
insert into Department (Id, DepartmentName, Location, DepartmentHead)
values (3, 'HR', 'New York', 'Christie')
insert into Department (Id, DepartmentName, Location, DepartmentHead)
values (4, 'Other Deparment', 'Sydney', 'Cindrella')

select * from Department

insert into Employees (Id, Name, Gender, Salary, DepartmentId)
values (1, 'Tom', 'Male', 4000, 1)
insert into Employees (Id, Name, Gender, Salary, DepartmentId)
values (2, 'Pam', 'Female', 3000, 1)
insert into Employees (Id, Name, Gender, Salary, DepartmentId)
values (3, 'John', 'Male', 3500, 1)
insert into Employees (Id, Name, Gender, Salary, DepartmentId)
values (4, 'Sam', 'Male', 4500, 2)
insert into Employees (Id, Name, Gender, Salary, DepartmentId)
values (5, 'Todd', 'Male', 2800, 1)
insert into Employees (Id, Name, Gender, Salary, DepartmentId)
values (6, 'Ben', 'Male', 7000, 1)
insert into Employees (Id, Name, Gender, Salary, DepartmentId)
values (7, 'Sara', 'Female', 4800, 3)
insert into Employees (Id, Name, Gender, Salary, DepartmentId)
values (8, 'Valarie', 'Female', 5500, 1)
insert into Employees (Id, Name, Gender, Salary, DepartmentId)
values (9, 'James', 'Male', 6500, NULL)
insert into Employees (Id, Name, Gender, Salary, DepartmentId)
values (10, 'Russell', 'Male', 8800, NULL)

select * from Employees

--- kuvab employees kasutajate departmentid
select distinct Name, DepartmentId from Employees

--- kuvab maksimaalse employees arvu
select sum(cast(Salary as int)) from Employees
--- kuvab minimaalse employees arvu
select min(cast(Salary as int)) from Employees


alter table Employees
add City nvarchar(25)


alter table Employees
add DepartmentId
int null


-- kuvab employeese tabelisse kesknime
alter table Employees
add MiddleName nvarchar(30)

alter table Employees
add LastName nvarchar(30)

update Employees set FirstName = 'Tom', MiddleName = 'Nick', LastName = 'Jones'
where Id = 1
update Employees set FirstName = 'Pam', MiddleName = NULL, LastName = 'Anderson'
where Id = 2
update Employees set FirstName = 'John', MiddleName = NULL, LastName = NULL
where Id = 3
update Employees set FirstName = 'Sam', MiddleName = NULL, LastName = 'Smith'
where Id = 4
update Employees set FirstName = NULL, MiddleName = 'Todd', LastName = 'Someone'
where Id = 5
update Employees set FirstName = 'Ben', MiddleName = 'Ten', LastName = 'Sven'
where Id = 6
update Employees set FirstName = 'Sara', MiddleName = NULL, LastName = 'Connor'
where Id = 7
update Employees set FirstName = 'Valarie', MiddleName = 'Balerine', LastName = NULL
where Id = 8
update Employees set FirstName = 'James', MiddleName = '007', LastName = 'Bond'
where Id = 9
update Employees set FirstName = NULL, MiddleName = NULL, LastName = 'Crowe'
where Id = 10


--- igast reast võtab esimeses veerus täidetud lahtri ja kuvab ainult seda
select Id, coalesce(FirstName, MiddleName, LastName) as Name
from Employees

select * from Employees
select * from Department
