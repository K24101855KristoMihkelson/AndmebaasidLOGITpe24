<img width="944" height="545" alt="{F1FADFEE-E01D-4C9E-B2C2-A185CC75702D}" src="https://github.com/user-attachments/assets/233960f6-d53c-40d8-a9fe-c7157e12ecb0" />

```sql
create database selectMihkelson2;
use selectMihkelson2;
create table auto(
autonumber char(6) primary key,
mark varchar(30),
mudell varchar(50),
v_aasta int,
varv varchar(50),
hind money);

select * from auto;
--mockaroo.com--kasutame andmete genereerimiseks
insert into auto (autonumber, mark, mudell, v_aasta, varv, hind) values ('965W4V', 'Lexus', 'LS', 1999, 'Orange', '$4201.66');
insert into auto (autonumber, mark, mudell, v_aasta, varv, hind) values ('518Fzz', 'Austin', 'Mini Cooper', 1964, 'Khaki', '$792.18');
insert into auto (autonumber, mark, mudell, v_aasta, varv, hind) values ('695Ao4', 'Chevrolet', 'Venture', 2001, 'Purple', '$4000.02');
insert into auto (autonumber, mark, mudell, v_aasta, varv, hind) values ('1094Jm', 'Toyota', 'Yaris', 2012, 'Blue', '$9276.19');
insert into auto (autonumber, mark, mudell, v_aasta, varv, hind) values ('500bMr', 'Chevrolet', 'Camaro', 1992, 'Crimson', '$2524.23');
insert into auto (autonumber, mark, mudell, v_aasta, varv, hind) values ('459vjz', 'BMW', 'Z3', 2001, 'Teal', '$8425.13');
insert into auto (autonumber, mark, mudell, v_aasta, varv, hind) values ('261wdo', 'Chevrolet', 'Sportvan G30', 1994, 'Pink', '$5720.31');
insert into auto (autonumber, mark, mudell, v_aasta, varv, hind) values ('784AKh', 'Lincoln', 'Mark VIII', 1996, 'Fuscia', '$2877.02');
insert into auto (autonumber, mark, mudell, v_aasta, varv, hind) values ('073Ghg', 'Mitsubishi', 'Mirage', 1994, 'Puce', '$6846.37');
insert into auto (autonumber, mark, mudell, v_aasta, varv, hind) values ('231QtR', 'Dodge', 'Ram 1500', 1999, 'Purple', '$6280.20');
insert into auto (autonumber, mark, mudell, v_aasta, varv, hind) values ('359f1E', 'Chevrolet', 'Sportvan G20', 1994, 'Red', '$7241.23');
insert into auto (autonumber, mark, mudell, v_aasta, varv, hind) values ('539PUX', 'Land Rover', 'Range Rover', 1993, 'Crimson', '$4733.77');
insert into auto (autonumber, mark, mudell, v_aasta, varv, hind) values ('785LA2', 'GMC', 'Sierra 2500', 2007, 'Puce', '$8653.62');
insert into auto (autonumber, mark, mudell, v_aasta, varv, hind) values ('545ZWt', 'Aston Martin', 'V8 Vantage', 2009, 'Orange', '$9279.81');
insert into auto (autonumber, mark, mudell, v_aasta, varv, hind) values ('453iKF', 'Chrysler', '300C', 2005, 'Crimson', '$6684.22');
insert into auto (autonumber, mark, mudell, v_aasta, varv, hind) values ('569qlk', 'Lincoln', 'Continental Mark VII', 1985, 'Teal', '$1219.25');
insert into auto (autonumber, mark, mudell, v_aasta, varv, hind) values ('200MGj', 'Volkswagen', 'Passat', 1995, 'Fuscia', '$6894.34');
insert into auto (autonumber, mark, mudell, v_aasta, varv, hind) values ('911Fox', 'Scion', 'tC', 2009, 'Puce', '$1363.74');
insert into auto (autonumber, mark, mudell, v_aasta, varv, hind) values ('838QlI', 'GMC', 'Yukon', 2007, 'Purple', '$4212.29');
insert into auto (autonumber, mark, mudell, v_aasta, varv, hind) values ('121b73', 'Mitsubishi', 'Raider', 2008, 'Orange', '$6605.81');
insert into auto (autonumber, mark, mudell, v_aasta, varv, hind) values ('442m9V', 'Chevrolet', 'Caprice', 1977, 'Yellow', '$5385.94');
insert into auto (autonumber, mark, mudell, v_aasta, varv, hind) values ('126PoK', 'Mazda', 'B-Series Plus', 1998, 'Aquamarine', '$375.33');
insert into auto (autonumber, mark, mudell, v_aasta, varv, hind) values ('2907gW', 'Mercedes-Benz', 'C-Class', 2010, 'Khaki', '$715.41');
insert into auto (autonumber, mark, mudell, v_aasta, varv, hind) values ('012IEp', 'GMC', 'Vandura G3500', 1996, 'Fuscia', '$2633.25');
insert into auto (autonumber, mark, mudell, v_aasta, varv, hind) values ('444tlP', 'Nissan', 'NX', 1992, 'Orange', '$5782.40');
insert into auto (autonumber, mark, mudell, v_aasta, varv, hind) values ('439Db6', 'Porsche', '911', 2012, 'Maroon', '$3759.88');
insert into auto (autonumber, mark, mudell, v_aasta, varv, hind) values ('584tFF', 'Nissan', 'Maxima', 1994, 'Aquamarine', '$6063.67');
insert into auto (autonumber, mark, mudell, v_aasta, varv, hind) values ('388fbk', 'Buick', 'Enclave', 2010, 'Orange', '$824.93');
insert into auto (autonumber, mark, mudell, v_aasta, varv, hind) values ('092ZqP', 'Kia', 'Spectra', 2002, 'Teal', '$9129.37');
insert into auto (autonumber, mark, mudell, v_aasta, varv, hind) values ('946oZz', 'Maserati', 'Spyder', 1991, 'Violet', '$3267.22');
insert into auto (autonumber, mark, mudell, v_aasta, varv, hind) values ('715ON3', 'Ford', 'Expedition', 2003, 'Red', '$147.18');
insert into auto (autonumber, mark, mudell, v_aasta, varv, hind) values ('605Eg8', 'Dodge', 'Grand Caravan', 2001, 'Orange', '$5607.09');
insert into auto (autonumber, mark, mudell, v_aasta, varv, hind) values ('985xRx', 'Chevrolet', 'Silverado 2500', 2009, 'Maroon', '$8574.24');
insert into auto (autonumber, mark, mudell, v_aasta, varv, hind) values ('545k0j', 'Kia', 'Soul', 2011, 'Turquoise', '$147.23');
insert into auto (autonumber, mark, mudell, v_aasta, varv, hind) values ('394BGG', 'GMC', 'Sierra', 2010, 'Red', '$5131.43');
insert into auto (autonumber, mark, mudell, v_aasta, varv, hind) values ('935Rvc', 'Hyundai', 'Elantra', 1998, 'Khaki', '$3694.24');
insert into auto (autonumber, mark, mudell, v_aasta, varv, hind) values ('743Ixr', 'Mercedes-Benz', 'GL-Class', 2010, 'Turquoise', '$4577.98');
insert into auto (autonumber, mark, mudell, v_aasta, varv, hind) values ('996BvK', 'Mazda', 'RX-8', 2007, 'Green', '$2777.96');
insert into auto (autonumber, mark, mudell, v_aasta, varv, hind) values ('500UZO', 'BMW', 'M5', 2008, 'Aquamarine', '$2788.65');
insert into auto (autonumber, mark, mudell, v_aasta, varv, hind) values ('405q91', 'Ford', 'Econoline E150', 1997, 'Goldenrod', '$1218.80');
insert into auto (autonumber, mark, mudell, v_aasta, varv, hind) values ('7373bQ', 'Ford', 'Thunderbird', 2003, 'Violet', '$545.67');
insert into auto (autonumber, mark, mudell, v_aasta, varv, hind) values ('494MNa', 'Mitsubishi', 'Precis', 1992, 'Khaki', '$6131.78');
insert into auto (autonumber, mark, mudell, v_aasta, varv, hind) values ('3261Ea', 'Infiniti', 'QX', 2002, 'Purple', '$7239.23');
insert into auto (autonumber, mark, mudell, v_aasta, varv, hind) values ('355H7O', 'Chrysler', 'Sebring', 2005, 'Red', '$8836.71');
insert into auto (autonumber, mark, mudell, v_aasta, varv, hind) values ('906MHN', 'Mercedes-Benz', '400SE', 1992, 'Maroon', '$2133.53');
insert into auto (autonumber, mark, mudell, v_aasta, varv, hind) values ('789frc', 'Audi', 'S5', 2008, 'Maroon', '$412.53');
insert into auto (autonumber, mark, mudell, v_aasta, varv, hind) values ('243bMV', 'Pontiac', 'Grand Prix', 1971, 'Puce', '$6054.81');
insert into auto (autonumber, mark, mudell, v_aasta, varv, hind) values ('794Kg9', 'Dodge', 'Caravan', 1992, 'Mauv', '$7674.83');
insert into auto (autonumber, mark, mudell, v_aasta, varv, hind) values ('5757j5', 'Chevrolet', 'Beretta', 1996, 'Teal', '$6791.48');
insert into auto (autonumber, mark, mudell, v_aasta, varv, hind) values ('332sNA', 'Lexus', 'GX', 2006, 'Teal', '$4350.25');
```

```
--näita kõik 
select * from auto;
--näita ainult mark, mudel ja hind
select mark, mudell, hind from auto;
--tingimused
-- sorteerimine - ORDER by -kasvavalt, DESC - kahanevalt
select mark, mudell, hind
from auto
ORDER by hind;
```
<img width="509" height="114" alt="{E641FB32-45DA-405F-8A1E-D30AA54C51F6}" src="https://github.com/user-attachments/assets/683327f8-6cde-48cf-8c32-d983ab113bd8" />

<img width="537" height="97" alt="{74985A1C-6897-406C-8B1E-228A81B265AC}" src="https://github.com/user-attachments/assets/4d1ec73c-31c2-4e3d-bbf2-8ab769f002ad" />


<img width="412" height="429" alt="{F9B25BA2-8286-4316-9B1E-9DFD6DB1410B}" src="https://github.com/user-attachments/assets/76d02076-418e-4bf2-8023-e2d78e4e37ec" />
<img width="329" height="445" alt="{518D6670-7583-4D5A-B33A-FCD3ED1A3913}" src="https://github.com/user-attachments/assets/d744ce50-523a-41bf-af0a-553a03358e20" />

<img width="237" height="83" alt="{A40093A1-9B23-4230-BAB0-AF3F913655B6}" src="https://github.com/user-attachments/assets/ce1e48ab-247b-44f0-8152-09937ad55830" />
<img width="144" height="271" alt="{224B543D-E10D-44DD-ACB0-6C09A4C2A6B0}" src="https://github.com/user-attachments/assets/6ca940df-6a4e-4a15-b02f-62e2eade68ba" />

<img width="253" height="78" alt="{AD625B2B-F417-48B6-AB32-A950A08B285C}" src="https://github.com/user-attachments/assets/6419e192-6cdc-461e-9237-3cab88292e79" />

<img width="163" height="421" alt="{064ECE35-F0FE-4AB8-9CC9-63B9F888B9F8}" src="https://github.com/user-attachments/assets/cdfca83f-8d37-405d-88ee-bd524cbc110d" />
<img width="141" height="85" alt="{29F5EA72-03EA-412C-96AB-519BCD049B50}" src="https://github.com/user-attachments/assets/1605360b-c20c-4f4c-9104-b5038be4ef63" />

<img width="398" height="253" alt="{3A19DE08-35D3-463E-9192-B3BF46A48AC5}" src="https://github.com/user-attachments/assets/f96732f4-496a-4454-a375-bc21b1b61a84" />
<img width="394" height="266" alt="{27D6F627-BFA6-4374-B4A0-10F4B173512D}" src="https://github.com/user-attachments/assets/c8cc8fff-320f-4293-a73b-9fde6dc1f88e" />

<img width="434" height="110" alt="{0053424E-27BB-4321-A977-54729B5A30D2}" src="https://github.com/user-attachments/assets/537d9679-f51c-4e13-9133-033c08a5c439" />
<img width="370" height="447" alt="{E3DB9050-8A74-43CF-A33D-5FEEADB3A07E}" src="https://github.com/user-attachments/assets/7c2f94ef-452b-47ec-8487-bb2dab77bf47" />

<img width="293" height="128" alt="{252884A8-8F64-4FCE-A3F6-605B0210420C}" src="https://github.com/user-attachments/assets/887a5fbc-9308-484b-8670-680b9d02a40a" />
<img width="254" height="152" alt="{F1BB7896-01D5-4145-90D9-871F458B4EC1}" src="https://github.com/user-attachments/assets/0414fce3-0087-49b4-bed8-9d695e2bd57e" />


<img width="429" height="58" alt="{875FC664-3812-425D-B8D3-B025582ACC2C}" src="https://github.com/user-attachments/assets/96d773b8-c0df-40a3-9850-7a6649a559e9" />
<img width="182" height="105" alt="{65D2C1C0-4F9A-480A-B0E3-D824EA4EF0B7}" src="https://github.com/user-attachments/assets/1f425a34-abbd-42ff-a1c5-0f963db0e104" />

<img width="423" height="66" alt="{39598FBF-AC4F-43A7-8E6E-B84C4C27178F}" src="https://github.com/user-attachments/assets/1eb2c778-48c4-4ba4-8a61-a0cc245f9c0b" />
<img width="266" height="113" alt="{96698CDA-8C45-4785-ADD2-EA3D6BF07CB7}" src="https://github.com/user-attachments/assets/1b59268d-9a71-4af7-ba03-41790e19d790" />

<img width="446" height="123" alt="{53C87FF6-641A-4B97-984B-8D9CC32DC07F}" src="https://github.com/user-attachments/assets/ec81cbbd-e881-4c20-b5e2-276b2567471a" />
<img width="254" height="436" alt="{87747278-FDF4-4FDC-AA9B-874EC1851EC7}" src="https://github.com/user-attachments/assets/ffe9a3a2-170e-4ae8-8a83-8acf207b8411" />
<img width="263" height="173" alt="{96C9C7CE-A971-4695-B850-A315F430CACB}" src="https://github.com/user-attachments/assets/df1ba380-4105-46a7-bbf2-2bc88b2afe2e" />











