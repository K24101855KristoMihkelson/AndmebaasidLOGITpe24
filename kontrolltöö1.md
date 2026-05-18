
SQL Basics: praktiline juhend
SQL-i kasutatakse andmebaasist andmete küsimiseks, filtreerimiseks, ühendamiseks, muutmiseks ja kokkuvõtmiseks.

Kõige tüüpilisem SQL ülesanne näeb välja nii:

SELECT veerud
FROM tabel
WHERE tingimus
GROUP BY grupeeritavad_veerud
HAVING grupi_tingimus
ORDER BY sorteerimine
LIMIT arv;
SQL-i loogiline järjekord on umbes selline:

FROM
WHERE
GROUP BY
HAVING
SELECT
ORDER BY
LIMIT
1. Andmete vaatamine tabelist
Kõik veerud
SELECT *
FROM customers;
Kindlad veerud
SELECT first_name, last_name, email
FROM customers;
Veeru ümbernimetamine
SELECT 
    first_name AS eesnimi,
    last_name AS perenimi
FROM customers;
2. Filtreerimine: WHERE
Lihtne tingimus
SELECT *
FROM customers
WHERE country = 'Estonia';
Mitte võrdne
SELECT *
FROM customers
WHERE country <> 'Estonia';
Mõnes andmebaasis töötab ka:

WHERE country != 'Estonia'
Suurem / väiksem
SELECT *
FROM orders
WHERE total_amount > 100;
SELECT *
FROM products
WHERE price <= 50;
3. Mitu tingimust: AND / OR
AND — mõlemad peavad kehtima
SELECT *
FROM orders
WHERE status = 'completed'
  AND total_amount > 100;
OR — üks tingimus peab kehtima
SELECT *
FROM customers
WHERE country = 'Estonia'
   OR country = 'Finland';
Sulud on tähtsad
SELECT *
FROM orders
WHERE status = 'completed'
  AND (country = 'Estonia' OR country = 'Finland');
4. Väärtuste nimekiri: IN
Selle asemel, et kirjutada palju OR tingimusi:

SELECT *
FROM customers
WHERE country IN ('Estonia', 'Finland', 'Latvia');
Vastupidine:

SELECT *
FROM customers
WHERE country NOT IN ('Estonia', 'Finland');
5. Vahemikud: BETWEEN
SELECT *
FROM products
WHERE price BETWEEN 10 AND 50;
Kuupäevadega:

SELECT *
FROM orders
WHERE order_date BETWEEN '2024-01-01' AND '2024-12-31';
6. Teksti otsimine: LIKE
Algab millegagi
SELECT *
FROM customers
WHERE first_name LIKE 'A%';
Leiab näiteks Anna, Andres, Aleks.

Lõpeb millegagi
SELECT *
FROM customers
WHERE email LIKE '%gmail.com';
Sisaldab mingit teksti
SELECT *
FROM products
WHERE product_name LIKE '%phone%';
Üks suvaline märk
SELECT *
FROM customers
WHERE first_name LIKE 'A_n';
Leiab näiteks Ann.

7. NULL väärtused
NULL tähendab, et väärtus puudub.

Vale:

WHERE phone = NULL
Õige:

SELECT *
FROM customers
WHERE phone IS NULL;
SELECT *
FROM customers
WHERE phone IS NOT NULL;
8. Sorteerimine: ORDER BY
Kasvav järjekord
SELECT *
FROM products
ORDER BY price ASC;
ASC on vaikimisi, seega võib kirjutada ka:

ORDER BY price;
Kahanev järjekord
SELECT *
FROM products
ORDER BY price DESC;
Mitme veeru järgi
SELECT *
FROM orders
ORDER BY customer_id ASC, order_date DESC;
9. Tulemuste piiramine: LIMIT
SELECT *
FROM products
LIMIT 10;
Kõige kallimad 5 toodet:

SELECT *
FROM products
ORDER BY price DESC
LIMIT 5;
10. Duplikaatide eemaldamine: DISTINCT
SELECT DISTINCT country
FROM customers;
Mitme veeru kombinatsioon:

SELECT DISTINCT country, city
FROM customers;
11. Arvutused SELECT-is
SELECT 
    product_name,
    price,
    price * 1.2 AS price_with_vat
FROM products;
Tellimuse rea kogusumma:

SELECT
    product_id,
    quantity,
    unit_price,
    quantity * unit_price AS line_total
FROM order_items;
12. Aggregate funktsioonid
Aggregate funktsioonid teevad kokkuvõtteid.

Ridade arv
SELECT COUNT(*) AS total_customers
FROM customers;
Mitte-NULL väärtuste arv
SELECT COUNT(phone) AS customers_with_phone
FROM customers;
Summa
SELECT SUM(total_amount) AS total_revenue
FROM orders;
Keskmine
SELECT AVG(price) AS average_price
FROM products;
Min ja max
SELECT 
    MIN(price) AS cheapest,
    MAX(price) AS most_expensive
FROM products;
13. Grupeerimine: GROUP BY
GROUP BY kasutatakse siis, kui tahad kokkuvõtet gruppide kaupa.

Tellimuste arv kliendi kohta
SELECT 
    customer_id,
    COUNT(*) AS order_count
FROM orders
GROUP BY customer_id;
Müük riigi kaupa
SELECT 
    country,
    SUM(total_amount) AS total_sales
FROM orders
GROUP BY country;
Keskmine hind kategooria kaupa
SELECT 
    category_id,
    AVG(price) AS avg_price
FROM products
GROUP BY category_id;
14. GROUP BY + WHERE
WHERE filtreerib ridu enne grupeerimist.

Näide: müük ainult lõpetatud tellimustest.

SELECT 
    customer_id,
    SUM(total_amount) AS total_spent
FROM orders
WHERE status = 'completed'
GROUP BY customer_id;
15. HAVING
HAVING filtreerib gruppe pärast GROUP BY.

Näide: kliendid, kellel on rohkem kui 3 tellimust.

SELECT 
    customer_id,
    COUNT(*) AS order_count
FROM orders
GROUP BY customer_id
HAVING COUNT(*) > 3;
Näide: kliendid, kes on kulutanud üle 500 euro.

SELECT 
    customer_id,
    SUM(total_amount) AS total_spent
FROM orders
GROUP BY customer_id
HAVING SUM(total_amount) > 500;
16. WHERE vs HAVING
Kasuta WHERE, kui filtreerid tavalisi ridu.

SELECT *
FROM orders
WHERE status = 'completed';
Kasuta HAVING, kui filtreerid aggregate tulemust.

SELECT customer_id, COUNT(*) AS order_count
FROM orders
GROUP BY customer_id
HAVING COUNT(*) > 5;
Lihtne reegel:

WHERE = enne GROUP BY
HAVING = pärast GROUP BY
17. JOIN-id
JOIN ühendab mitu tabelit.

Oletame, et meil on tabelid:

customers
- customer_id
- first_name
- last_name

orders
- order_id
- customer_id
- order_date
- total_amount
INNER JOIN
Näitab ainult ridu, millel on vaste mõlemas tabelis.

SELECT 
    customers.first_name,
    customers.last_name,
    orders.order_id,
    orders.total_amount
FROM customers
INNER JOIN orders
    ON customers.customer_id = orders.customer_id;
Lühem variant aliasega:

SELECT 
    c.first_name,
    c.last_name,
    o.order_id,
    o.total_amount
FROM customers AS c
INNER JOIN orders AS o
    ON c.customer_id = o.customer_id;
18. LEFT JOIN
Näitab kõik read vasakust tabelist, isegi kui paremas tabelis vastet pole.

Kõik kliendid ja nende tellimused, ka need kliendid, kellel tellimusi pole:

SELECT 
    c.customer_id,
    c.first_name,
    c.last_name,
    o.order_id,
    o.total_amount
FROM customers AS c
LEFT JOIN orders AS o
    ON c.customer_id = o.customer_id;
Kliendid, kellel pole ühtegi tellimust:

SELECT 
    c.customer_id,
    c.first_name,
    c.last_name
FROM customers AS c
LEFT JOIN orders AS o
    ON c.customer_id = o.customer_id
WHERE o.order_id IS NULL;
19. RIGHT JOIN
Näitab kõik read paremast tabelist.

SELECT 
    c.first_name,
    o.order_id
FROM customers AS c
RIGHT JOIN orders AS o
    ON c.customer_id = o.customer_id;
Praktikas kasutatakse tihti pigem LEFT JOIN, sest seda on lihtsam lugeda.

20. FULL OUTER JOIN
Näitab kõik read mõlemast tabelist, ka siis kui vastet pole.

SELECT 
    c.customer_id,
    o.order_id
FROM customers AS c
FULL OUTER JOIN orders AS o
    ON c.customer_id = o.customer_id;
Kõik andmebaasid ei toeta seda otse, näiteks MySQL-is mitte.

21. JOIN + GROUP BY
Tellimuste arv iga kliendi kohta
SELECT 
    c.customer_id,
    c.first_name,
    c.last_name,
    COUNT(o.order_id) AS order_count
FROM customers AS c
LEFT JOIN orders AS o
    ON c.customer_id = o.customer_id
GROUP BY 
    c.customer_id,
    c.first_name,
    c.last_name;
Kliendi kogukulu
SELECT 
    c.customer_id,
    c.first_name,
    c.last_name,
    SUM(o.total_amount) AS total_spent
FROM customers AS c
LEFT JOIN orders AS o
    ON c.customer_id = o.customer_id
GROUP BY 
    c.customer_id,
    c.first_name,
    c.last_name;
Kui kliendil pole tellimusi, võib SUM anda NULL.

Selle parandamiseks:

SELECT 
    c.customer_id,
    c.first_name,
    c.last_name,
    COALESCE(SUM(o.total_amount), 0) AS total_spent
FROM customers AS c
LEFT JOIN orders AS o
    ON c.customer_id = o.customer_id
GROUP BY 
    c.customer_id,
    c.first_name,
    c.last_name;
22. COALESCE
COALESCE asendab NULL väärtuse millegi muuga.

SELECT 
    first_name,
    COALESCE(phone, 'No phone') AS phone_number
FROM customers;
Näide summaga:

SELECT 
    customer_id,
    COALESCE(SUM(total_amount), 0) AS total_spent
FROM orders
GROUP BY customer_id;
23. CASE WHEN
CASE võimaldab teha tingimusloogikat.

SELECT 
    product_name,
    price,
    CASE
        WHEN price < 20 THEN 'cheap'
        WHEN price BETWEEN 20 AND 100 THEN 'medium'
        ELSE 'expensive'
    END AS price_category
FROM products;
Tellimuse staatuse tõlgendamine:

SELECT 
    order_id,
    status,
    CASE
        WHEN status = 'completed' THEN 'Done'
        WHEN status = 'cancelled' THEN 'Cancelled'
        ELSE 'In progress'
    END AS status_text
FROM orders;
24. Kuupäevad
Kuupäeva filtrid:

SELECT *
FROM orders
WHERE order_date >= '2024-01-01';
Ühe kuu tellimused:

SELECT *
FROM orders
WHERE order_date >= '2024-01-01'
  AND order_date < '2024-02-01';
See on parem kui BETWEEN, kui veerus on ka kellaaeg.

25. Kuupäeva osad
Sõltub andmebaasist.

PostgreSQL
SELECT 
    EXTRACT(YEAR FROM order_date) AS order_year,
    COUNT(*) AS order_count
FROM orders
GROUP BY EXTRACT(YEAR FROM order_date);
SELECT 
    DATE_TRUNC('month', order_date) AS order_month,
    SUM(total_amount) AS revenue
FROM orders
GROUP BY DATE_TRUNC('month', order_date)
ORDER BY order_month;
MySQL
SELECT 
    YEAR(order_date) AS order_year,
    COUNT(*) AS order_count
FROM orders
GROUP BY YEAR(order_date);
SELECT 
    DATE_FORMAT(order_date, '%Y-%m') AS order_month,
    SUM(total_amount) AS revenue
FROM orders
GROUP BY DATE_FORMAT(order_date, '%Y-%m')
ORDER BY order_month;
SQLite
SELECT 
    strftime('%Y', order_date) AS order_year,
    COUNT(*) AS order_count
FROM orders
GROUP BY strftime('%Y', order_date);
SELECT 
    strftime('%Y-%m', order_date) AS order_month,
    SUM(total_amount) AS revenue
FROM orders
GROUP BY strftime('%Y-%m', order_date)
ORDER BY order_month;
26. Subquery ehk alamküsimus
Tooted, mis on keskmisest kallimad
SELECT *
FROM products
WHERE price > (
    SELECT AVG(price)
    FROM products
);
Kliendid, kellel on tellimusi
SELECT *
FROM customers
WHERE customer_id IN (
    SELECT customer_id
    FROM orders
);
Kliendid, kellel pole tellimusi
SELECT *
FROM customers
WHERE customer_id NOT IN (
    SELECT customer_id
    FROM orders
    WHERE customer_id IS NOT NULL
);
Veel parem variant NOT EXISTS-iga:

SELECT *
FROM customers AS c
WHERE NOT EXISTS (
    SELECT 1
    FROM orders AS o
    WHERE o.customer_id = c.customer_id
);
27. EXISTS
EXISTS kontrollib, kas alamquery tagastab vähemalt ühe rea.

Kliendid, kellel on vähemalt üks tellimus:

SELECT *
FROM customers AS c
WHERE EXISTS (
    SELECT 1
    FROM orders AS o
    WHERE o.customer_id = c.customer_id
);
Kliendid, kellel pole tellimusi:

SELECT *
FROM customers AS c
WHERE NOT EXISTS (
    SELECT 1
    FROM orders AS o
    WHERE o.customer_id = c.customer_id
);
28. CTE ehk WITH
CTE teeb query loetavamaks.

WITH customer_spending AS (
    SELECT 
        customer_id,
        SUM(total_amount) AS total_spent
    FROM orders
    GROUP BY customer_id
)
SELECT *
FROM customer_spending
WHERE total_spent > 500;
JOIN-iga:

WITH customer_spending AS (
    SELECT 
        customer_id,
        SUM(total_amount) AS total_spent
    FROM orders
    GROUP BY customer_id
)
SELECT 
    c.first_name,
    c.last_name,
    cs.total_spent
FROM customer_spending AS cs
JOIN customers AS c
    ON cs.customer_id = c.customer_id
ORDER BY cs.total_spent DESC;
29. INSERT
Uue rea lisamine:

INSERT INTO customers (first_name, last_name, email, country)
VALUES ('Mari', 'Tamm', 'mari@example.com', 'Estonia');
Mitme rea lisamine:

INSERT INTO customers (first_name, last_name, email, country)
VALUES 
    ('Mari', 'Tamm', 'mari@example.com', 'Estonia'),
    ('Jaan', 'Kask', 'jaan@example.com', 'Estonia');
30. UPDATE
Andmete muutmine:

UPDATE customers
SET country = 'Estonia'
WHERE customer_id = 1;
Mitme veeru muutmine:

UPDATE products
SET 
    price = 29.99,
    category_id = 2
WHERE product_id = 10;
Väga tähtis: ära unusta WHERE.

Ohtlik:

UPDATE customers
SET country = 'Estonia';
See muudab kõik read.

31. DELETE
Rea kustutamine:

DELETE FROM customers
WHERE customer_id = 1;
Ohtlik:

DELETE FROM customers;
See kustutab kõik read tabelist.

32. CREATE TABLE
Lihtne tabel:

CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(100),
    country VARCHAR(50)
);
Tabel automaatse ID-ga, PostgreSQL:

CREATE TABLE customers (
    customer_id SERIAL PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE,
    country VARCHAR(50)
);
MySQL:

CREATE TABLE customers (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE,
    country VARCHAR(50)
);
SQLite:

CREATE TABLE customers (
    customer_id INTEGER PRIMARY KEY AUTOINCREMENT,
    first_name TEXT NOT NULL,
    last_name TEXT NOT NULL,
    email TEXT UNIQUE,
    country TEXT
);
33. Primary key ja foreign key
Primary key
Unikaalne identifikaator tabelis.

CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    first_name VARCHAR(50)
);
Foreign key
Viitab teise tabeli primary key-le.

CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    total_amount DECIMAL(10, 2),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);
34. ALTER TABLE
Uue veeru lisamine:

ALTER TABLE customers
ADD phone VARCHAR(30);
Veeru kustutamine:

ALTER TABLE customers
DROP COLUMN phone;
Veeru tüübi muutmine sõltub andmebaasist.

PostgreSQL:

ALTER TABLE products
ALTER COLUMN price TYPE DECIMAL(10, 2);
MySQL:

ALTER TABLE products
MODIFY price DECIMAL(10, 2);
35. Tüüpilised SQL ülesannete mustrid
Muster 1: Leia kõik midagi
Ülesanne: leia kõik Eesti kliendid.

SELECT *
FROM customers
WHERE country = 'Estonia';
Muster 2: Leia top N
Ülesanne: leia 10 kõige kallimat toodet.

SELECT *
FROM products
ORDER BY price DESC
LIMIT 10;
Muster 3: Arvuta kokku
Ülesanne: leia kogu müük.

SELECT SUM(total_amount) AS total_sales
FROM orders;
Muster 4: Arvuta gruppide kaupa
Ülesanne: leia müük kliendi kaupa.

SELECT 
    customer_id,
    SUM(total_amount) AS total_spent
FROM orders
GROUP BY customer_id;
Muster 5: Filtreeri gruppe
Ülesanne: leia kliendid, kes on kulutanud üle 1000.

SELECT 
    customer_id,
    SUM(total_amount) AS total_spent
FROM orders
GROUP BY customer_id
HAVING SUM(total_amount) > 1000;
Muster 6: Ühenda tabelid
Ülesanne: näita tellimusi koos kliendi nimega.

SELECT 
    o.order_id,
    o.order_date,
    o.total_amount,
    c.first_name,
    c.last_name
FROM orders AS o
JOIN customers AS c
    ON o.customer_id = c.customer_id;
Muster 7: Leia puuduvad seosed
Ülesanne: leia kliendid, kellel pole tellimusi.

SELECT 
    c.customer_id,
    c.first_name,
    c.last_name
FROM customers AS c
LEFT JOIN orders AS o
    ON c.customer_id = o.customer_id
WHERE o.order_id IS NULL;
Muster 8: Kasuta CASE-i kategooriateks
Ülesanne: jaga tooted hinna järgi kategooriatesse.

SELECT 
    product_name,
    price,
    CASE
        WHEN price < 20 THEN 'cheap'
        WHEN price BETWEEN 20 AND 100 THEN 'medium'
        ELSE 'expensive'
    END AS price_group
FROM products;
Muster 9: Võrdle keskmisega
Ülesanne: leia tooted, mis on keskmisest kallimad.

SELECT *
FROM products
WHERE price > (
    SELECT AVG(price)
    FROM products
);
Muster 10: Kuu kaupa kokkuvõte
PostgreSQL:

SELECT 
    DATE_TRUNC('month', order_date) AS month,
    SUM(total_amount) AS revenue
FROM orders
GROUP BY DATE_TRUNC('month', order_date)
ORDER BY month;
MySQL:

SELECT 
    DATE_FORMAT(order_date, '%Y-%m') AS month,
    SUM(total_amount) AS revenue
FROM orders
GROUP BY DATE_FORMAT(order_date, '%Y-%m')
ORDER BY month;
36. JOIN tüübi valimine
Kasuta seda mõtteviisi:

Tahan ainult sobivaid vasteid mõlemast tabelist
= INNER JOIN

Tahan kõik read esimesest tabelist, isegi kui teises vastet pole
= LEFT JOIN

Tahan leida read, millel puudub vaste
= LEFT JOIN + WHERE teine_tabel.id IS NULL
37. Praktiline lahendamise protsess
Kui saad SQL ülesande, tee nii:

Samm 1: Mis tabelitest andmeid vaja on?
Näiteks:

customers
orders
products
order_items
Samm 2: Mis on lõpptulemus?
Näiteks:

Kliendi nimi + kogu kulutatud summa
Samm 3: Kas on vaja JOIN-i?
Kui andmed on mitmes tabelis, kasuta JOIN.

FROM customers AS c
JOIN orders AS o
    ON c.customer_id = o.customer_id
Samm 4: Kas on vaja filtreerida ridu?
Kasuta WHERE.

WHERE o.status = 'completed'
Samm 5: Kas on vaja kokkuvõtet?
Kasuta aggregate funktsioone ja GROUP BY.

GROUP BY c.customer_id, c.first_name, c.last_name
Samm 6: Kas on vaja filtreerida gruppe?
Kasuta HAVING.

HAVING SUM(o.total_amount) > 500
Samm 7: Kas on vaja sorteerida?
Kasuta ORDER BY.

ORDER BY total_spent DESC
Samm 8: Kas on vaja piirata tulemusi?
Kasuta LIMIT.

LIMIT 10
38. Näidisülesanne algusest lõpuni
Ülesanne:

Leia top 5 klienti, kes on lõpetatud tellimuste põhjal kõige rohkem raha kulutanud.

Oletame tabelid:

customers(customer_id, first_name, last_name)
orders(order_id, customer_id, total_amount, status)
Lahendus:

SELECT 
    c.customer_id,
    c.first_name,
    c.last_name,
    SUM(o.total_amount) AS total_spent
FROM customers AS c
JOIN orders AS o
    ON c.customer_id = o.customer_id
WHERE o.status = 'completed'
GROUP BY 
    c.customer_id,
    c.first_name,
    c.last_name
ORDER BY total_spent DESC
LIMIT 5;
Miks nii?

FROM/JOIN = ühendame kliendid ja tellimused
WHERE = võtame ainult completed tellimused
GROUP BY = grupeerime kliendi kaupa
SUM = arvutame kliendi kogukulu
ORDER BY DESC = kõige suuremad ette
LIMIT 5 = ainult top 5
39. Teine näidisülesanne
Ülesanne:

Leia kategooriad, kus keskmine tootehind on üle 50 euro.

Tabelid:

categories(category_id, category_name)
products(product_id, product_name, category_id, price)
Lahendus:

SELECT 
    c.category_name,
    AVG(p.price) AS avg_price
FROM categories AS c
JOIN products AS p
    ON c.category_id = p.category_id
GROUP BY c.category_name
HAVING AVG(p.price) > 50
ORDER BY avg_price DESC;
40. Kolmas näidisülesanne
Ülesanne:

Leia kliendid, kellel pole ühtegi tellimust.

SELECT 
    c.customer_id,
    c.first_name,
    c.last_name
FROM customers AS c
LEFT JOIN orders AS o
    ON c.customer_id = o.customer_id
WHERE o.order_id IS NULL;
See on väga tavaline SQL mustriülesanne.

41. Neljas näidisülesanne
Ülesanne:

Leia iga kuu müük ainult completed tellimustest.

PostgreSQL:

SELECT 
    DATE_TRUNC('month', order_date) AS month,
    SUM(total_amount) AS revenue
FROM orders
WHERE status = 'completed'
GROUP BY DATE_TRUNC('month', order_date)
ORDER BY month;
MySQL:

SELECT 
    DATE_FORMAT(order_date, '%Y-%m') AS month,
    SUM(total_amount) AS revenue
FROM orders
WHERE status = 'completed'
GROUP BY DATE_FORMAT(order_date, '%Y-%m')
ORDER BY month;
42. Väga kasulik mall SQL ülesande jaoks
Kasuta seda peaaegu iga keerulisema ülesande algusena:

SELECT 
    -- veerud, mida tahad näha
FROM table1 AS t1
JOIN table2 AS t2
    ON t1.id = t2.table1_id
WHERE 
    -- rea tingimused
GROUP BY 
    -- kõik mitte-aggregate SELECT veerud
HAVING 
    -- aggregate tingimused
ORDER BY 
    -- sorteerimine
LIMIT 10;
Näiteks:

SELECT 
    c.customer_id,
    c.first_name,
    c.last_name,
    COUNT(o.order_id) AS order_count,
    SUM(o.total_amount) AS total_spent
FROM customers AS c
LEFT JOIN orders AS o
    ON c.customer_id = o.customer_id
WHERE c.country = 'Estonia'
GROUP BY 
    c.customer_id,
    c.first_name,
    c.last_name
HAVING COUNT(o.order_id) >= 1
ORDER BY total_spent DESC
LIMIT 10;
43. Kõige levinumad vead
1. Unustad WHERE-i UPDATE või DELETE puhul
Ohtlik:

DELETE FROM customers;
Parem:

DELETE FROM customers
WHERE customer_id = 5;
2. Kasutad WHERE aggregate funktsiooniga
Vale:

SELECT customer_id, COUNT(*) AS order_count
FROM orders
GROUP BY customer_id
WHERE COUNT(*) > 3;
Õige:

SELECT customer_id, COUNT(*) AS order_count
FROM orders
GROUP BY customer_id
HAVING COUNT(*) > 3;
3. Unustad GROUP BY
Vale:

SELECT customer_id, SUM(total_amount)
FROM orders;
Õige:

SELECT customer_id, SUM(total_amount)
FROM orders
GROUP BY customer_id;
4. Kasutad = NULL
Vale:

WHERE phone = NULL;
Õige:

WHERE phone IS NULL;
5. JOIN ilma ON tingimuseta
Vale:

SELECT *
FROM customers
JOIN orders;
Õige:

SELECT *
FROM customers
JOIN orders
    ON customers.customer_id = orders.customer_id;
44. Kiire meelespea
SELECT      -- mida näidata
FROM        -- millisest tabelist
JOIN        -- millise tabeliga ühendada
ON          -- kuidas tabelid seotud on
WHERE       -- filtreeri tavalisi ridu
GROUP BY    -- grupeerimine
HAVING      -- filtreeri gruppe
ORDER BY    -- sorteeri
LIMIT       -- piira tulemusi
45. Kõige olulisemad SQL käsud
SELECT
FROM
WHERE
AND
OR
IN
BETWEEN
LIKE
IS NULL
IS NOT NULL
ORDER BY
LIMIT
DISTINCT
COUNT
SUM
AVG
MIN
MAX
GROUP BY
HAVING
JOIN
LEFT JOIN
CASE
COALESCE
WITH
INSERT
UPDATE
DELETE
CREATE TABLE
ALTER TABLE
46. Kui SQL ülesanne tundub keeruline
Ära alusta kohe täispäringust. Ehita query samm-sammult.

Näiteks:

Samm 1
SELECT *
FROM orders;
Samm 2
SELECT *
FROM orders
WHERE status = 'completed';
Samm 3
SELECT customer_id, total_amount
FROM orders
WHERE status = 'completed';
Samm 4
SELECT 
    customer_id,
    SUM(total_amount) AS total_spent
FROM orders
WHERE status = 'completed'
GROUP BY customer_id;
Samm 5
SELECT 
    customer_id,
    SUM(total_amount) AS total_spent
FROM orders
WHERE status = 'completed'
GROUP BY customer_id
ORDER BY total_spent DESC;
Samm 6
SELECT 
    customer_id,
    SUM(total_amount) AS total_spent
FROM orders
WHERE status = 'completed'
GROUP BY customer_id
ORDER BY total_spent DESC
LIMIT 5;
See on parim viis SQL ülesande lahendamiseks.

47. Mini-harjutused koos lahendustega
Harjutus 1
Leia kõik tooted, mille hind on üle 100.

SELECT *
FROM products
WHERE price > 100;
Harjutus 2
Leia kõik kliendid Eestist või Soomest.

SELECT *
FROM customers
WHERE country IN ('Estonia', 'Finland');
Harjutus 3
Leia tellimuste koguarv.

SELECT COUNT(*) AS order_count
FROM orders;
Harjutus 4
Leia iga kliendi tellimuste arv.

SELECT 
    customer_id,
    COUNT(*) AS order_count
FROM orders
GROUP BY customer_id;
Harjutus 5
Leia kliendid, kellel on rohkem kui 2 tellimust.

SELECT 
    customer_id,
    COUNT(*) AS order_count
FROM orders
GROUP BY customer_id
HAVING COUNT(*) > 2;
Harjutus 6
Näita tellimusi koos kliendi nimega.

SELECT 
    o.order_id,
    o.order_date,
    c.first_name,
    c.last_name
FROM orders AS o
JOIN customers AS c
    ON o.customer_id = c.customer_id;
Harjutus 7
Leia kliendid, kellel pole tellimusi.

SELECT 
    c.customer_id,
    c.first_name,
    c.last_name
FROM customers AS c
LEFT JOIN orders AS o
    ON c.customer_id = o.customer_id
WHERE o.order_id IS NULL;
Harjutus 8
Leia top 3 kõige kallimat toodet.

SELECT *
FROM products
ORDER BY price DESC
LIMIT 3;
Harjutus 9
Leia iga kategooria keskmine hind.

SELECT 
    category_id,
    AVG(price) AS avg_price
FROM products
GROUP BY category_id;
Harjutus 10
Leia tooted, mis sisaldavad nimes sõna phone.

SELECT *
FROM products
WHERE product_name LIKE '%phone%';
Kõige praktilisem lõppreegel
Kui näed SQL ülesannet, küsi endalt:

1. Milliseid veerge tahan näha?        → SELECT
2. Millisest tabelist alustan?         → FROM
3. Kas vaja teist tabelit?             → JOIN
4. Kuidas tabelid seotud on?           → ON
5. Millised read välja filtreerin?     → WHERE
6. Kas vaja kokkuvõtet gruppide kaupa? → GROUP BY
7. Kas vaja gruppe filtreerida?        → HAVING
8. Mis järjekorras tulemus peab olema? → ORDER BY
9. Kas vaja ainult top N rida?         → LIMIT
Kõige universaalsem SQL mall:

SELECT 
    t1.column_name,
    COUNT(t2.id) AS count_value,
    SUM(t2.amount) AS total_value
FROM table1 AS t1
LEFT JOIN table2 AS t2
    ON t1.id = t2.table1_id
WHERE t1.some_column = 'some value'
GROUP BY t1.column_name
HAVING SUM(t2.amount) > 0
ORDER BY total_value DESC
LIMIT 10;
Kui selle malli loogika selgeks saad, saad hakkama suure osa SQL basics ülesannetega.


tee siis ülesannete kaupa, ehk päris ülesanne koos selgitusega 

Mõtles sekundi
Muidugi. Allpool on SQL ülesanded päris ülesande stiilis, igaühel:

mida küsitakse

kuidas mõelda

SQL lahendus

selgitus

Kasutan näidisandmebaasi e-poe stiilis.

Näidistabelid
customers
- customer_id
- first_name
- last_name
- email
- country
- city
orders
- order_id
- customer_id
- order_date
- status
- total_amount
products
- product_id
- product_name
- category_id
- price
categories
- category_id
- category_name
order_items
- order_item_id
- order_id
- product_id
- quantity
- unit_price
Ülesanne 1: Leia kõik kliendid Eestist
Ülesanne
Leia kõik kliendid, kelle riik on Estonia.

Mõtlemine
Andmed on tabelis customers.
Peame filtreerima ainult need read, kus country = 'Estonia'.

SQL
SELECT *
FROM customers
WHERE country = 'Estonia';
Selgitus
SELECT *
näitab kõik veerud.

FROM customers
ütleb, millisest tabelist andmeid võetakse.

WHERE country = 'Estonia'
jätab alles ainult Eesti kliendid.

Ülesanne 2: Leia kliendi eesnimi, perenimi ja email
Ülesanne
Näita ainult klientide eesnime, perenime ja emaili.

SQL
SELECT 
    first_name,
    last_name,
    email
FROM customers;
Selgitus
Siin ei kasuta me SELECT *, sest me ei taha kõiki veerge.
Valime ainult need veerud, mida ülesanne küsib.

Ülesanne 3: Leia kõik tellimused, mille summa on üle 100 euro
Ülesanne
Leia kõik tellimused, kus total_amount on suurem kui 100.

SQL
SELECT *
FROM orders
WHERE total_amount > 100;
Selgitus
WHERE total_amount > 100
filtreerib välja ainult need tellimused, mille summa on üle 100.

Ülesanne 4: Leia completed tellimused üle 100 euro
Ülesanne
Leia kõik tellimused, mille staatus on completed ja summa on üle 100 euro.

Mõtlemine
Siin on kaks tingimust:

status = completed
total_amount > 100
Mõlemad peavad kehtima, seega kasutame AND.

SQL
SELECT *
FROM orders
WHERE status = 'completed'
  AND total_amount > 100;
Selgitus
AND
tähendab, et mõlemad tingimused peavad olema tõesed.

Ülesanne 5: Leia kliendid Eestist või Soomest
Ülesanne
Leia kliendid, kelle riik on Estonia või Finland.

Variant 1: OR
SELECT *
FROM customers
WHERE country = 'Estonia'
   OR country = 'Finland';
Variant 2: IN
SELECT *
FROM customers
WHERE country IN ('Estonia', 'Finland');
Selgitus
Kui kontrollid sama veergu mitme väärtuse vastu, on IN tavaliselt puhtam.

See:

WHERE country IN ('Estonia', 'Finland')
tähendab:

country on kas Estonia või Finland
Ülesanne 6: Leia tooted hinnavahemikus 10 kuni 50 eurot
Ülesanne
Leia kõik tooted, mille hind jääb 10 ja 50 vahele.

SQL
SELECT *
FROM products
WHERE price BETWEEN 10 AND 50;
Selgitus
BETWEEN 10 AND 50
tähendab, et väärtus võib olla 10, 50 või nende vahel.

Sama asi pikemalt:

SELECT *
FROM products
WHERE price >= 10
  AND price <= 50;
Ülesanne 7: Leia tooted, mille nimi sisaldab sõna “phone”
Ülesanne
Leia kõik tooted, mille nimes esineb sõna phone.

SQL
SELECT *
FROM products
WHERE product_name LIKE '%phone%';
Selgitus
LIKE
kasutatakse teksti otsimiseks.

'%phone%'
tähendab, et enne ja pärast sõna phone võib olla ükskõik milline tekst.

Näiteks leiab:

iPhone
Phone case
Samsung phone charger
Ülesanne 8: Leia kliendid, kellel pole emaili
Ülesanne
Leia kliendid, kelle email puudub.

Vale variant
SELECT *
FROM customers
WHERE email = NULL;
See on vale.

Õige variant
SELECT *
FROM customers
WHERE email IS NULL;
Selgitus
NULL ei ole tavaline väärtus.
See tähendab, et väärtus puudub.

Seetõttu peab kasutama:

IS NULL
või

IS NOT NULL
Ülesanne 9: Leia 5 kõige kallimat toodet
Ülesanne
Näita 5 toodet, mille hind on kõige suurem.

Mõtlemine
Peame:

1. võtma products tabeli
2. sorteerima hinna järgi kahanevalt
3. võtma ainult esimesed 5
SQL
SELECT *
FROM products
ORDER BY price DESC
LIMIT 5;
Selgitus
ORDER BY price DESC
paneb kõige kallimad tooted ette.

LIMIT 5
jätab alles ainult 5 esimest rida.

Ülesanne 10: Leia kõik erinevad riigid, kust kliendid pärit on
Ülesanne
Näita iga riiki ainult ühe korra.

SQL
SELECT DISTINCT country
FROM customers;
Selgitus
Kui tabelis on 100 klienti Eestist, siis ilma DISTINCT-ita näeksid Estonia 100 korda.

DISTINCT
eemaldab kordused.

Ülesanne 11: Leia kõikide tellimuste kogusumma
Ülesanne
Arvuta kogu müük kõikide tellimuste põhjal.

SQL
SELECT SUM(total_amount) AS total_sales
FROM orders;
Selgitus
SUM(total_amount)
liidab kõik total_amount väärtused kokku.

AS total_sales
annab tulemuse veerule parema nime.

Ülesanne 12: Leia tellimuste arv
Ülesanne
Mitu tellimust kokku on?

SQL
SELECT COUNT(*) AS order_count
FROM orders;
Selgitus
COUNT(*)
loeb ridade arvu.

Ülesanne 13: Leia iga kliendi tellimuste arv
Ülesanne
Näita iga customer_id kohta, mitu tellimust tal on.

Mõtlemine
Kuna tahame tulemust kliendi kaupa, peame kasutama GROUP BY.

SQL
SELECT 
    customer_id,
    COUNT(*) AS order_count
FROM orders
GROUP BY customer_id;
Selgitus
GROUP BY customer_id
teeb iga kliendi kohta eraldi grupi.

COUNT(*)
loeb mitu tellimust selles grupis on.

Ülesanne 14: Leia iga kliendi kogukulu
Ülesanne
Näita iga kliendi kohta, kui palju ta kokku kulutanud on.

SQL
SELECT 
    customer_id,
    SUM(total_amount) AS total_spent
FROM orders
GROUP BY customer_id;
Selgitus
Iga kliendi tellimused pannakse gruppi ja siis arvutatakse nende tellimuste summa.

Ülesanne 15: Leia kliendid, kes on kulutanud üle 500 euro
Ülesanne
Näita klientide ID-d ja kogukulu ainult nende kohta, kelle kogukulu on üle 500.

Mõtlemine
Siin ei saa kasutada WHERE SUM(...) > 500, sest SUM tekib alles pärast grupeerimist.

Seega kasutame HAVING.

SQL
SELECT 
    customer_id,
    SUM(total_amount) AS total_spent
FROM orders
GROUP BY customer_id
HAVING SUM(total_amount) > 500;
Selgitus
WHERE
filtreerib üksikuid ridu enne grupeerimist.

HAVING
filtreerib gruppe pärast grupeerimist.

Ülesanne 16: Leia completed tellimuste kogusumma iga kliendi kohta
Ülesanne
Näita iga kliendi kohta, kui palju ta on kulutanud ainult lõpetatud tellimuste põhjal.

Mõtlemine
Enne grupeerimist tuleb alles jätta ainult completed tellimused.

SQL
SELECT 
    customer_id,
    SUM(total_amount) AS completed_spent
FROM orders
WHERE status = 'completed'
GROUP BY customer_id;
Selgitus
Järjekord mõttes:

1. FROM orders
2. WHERE status = 'completed'
3. GROUP BY customer_id
4. SUM(total_amount)
Ülesanne 17: Näita tellimusi koos kliendi nimega
Ülesanne
Näita iga tellimuse kohta:

order_id
order_date
total_amount
kliendi eesnimi
kliendi perenimi
Mõtlemine
Tellimuse info on tabelis orders.
Kliendi nimi on tabelis customers.

Peame tabelid ühendama.

SQL
SELECT 
    o.order_id,
    o.order_date,
    o.total_amount,
    c.first_name,
    c.last_name
FROM orders AS o
JOIN customers AS c
    ON o.customer_id = c.customer_id;
Selgitus
orders AS o
annab tabelile lühinime o.

customers AS c
annab tabelile lühinime c.

ON o.customer_id = c.customer_id
ütleb, kuidas tabelid omavahel seotud on.

Ülesanne 18: Leia iga kliendi tellimuste arv koos nimega
Ülesanne
Näita iga kliendi kohta:

customer_id
first_name
last_name
order_count
SQL
SELECT 
    c.customer_id,
    c.first_name,
    c.last_name,
    COUNT(o.order_id) AS order_count
FROM customers AS c
LEFT JOIN orders AS o
    ON c.customer_id = o.customer_id
GROUP BY 
    c.customer_id,
    c.first_name,
    c.last_name;
Selgitus
Kasutame LEFT JOIN, sest tahame näha ka neid kliente, kellel pole tellimusi.

COUNT(o.order_id)
loeb ainult olemasolevaid tellimusi.

Kui kliendil pole tellimusi, on tulemus 0.

Ülesanne 19: Leia kliendid, kellel pole ühtegi tellimust
Ülesanne
Näita kliente, kellel pole tellimusi.

Mõtlemine
Selleks kasutatakse väga tihti mustrit:

LEFT JOIN + WHERE parema tabeli id IS NULL
SQL
SELECT 
    c.customer_id,
    c.first_name,
    c.last_name
FROM customers AS c
LEFT JOIN orders AS o
    ON c.customer_id = o.customer_id
WHERE o.order_id IS NULL;
Selgitus
LEFT JOIN jätab kõik kliendid alles.
Kui kliendil pole tellimust, siis orders veerud on NULL.

Seega:

WHERE o.order_id IS NULL
leiab kliendid ilma tellimusteta.

Ülesanne 20: Leia top 5 klienti kogukulu järgi
Ülesanne
Leia 5 klienti, kes on kõige rohkem raha kulutanud.

SQL
SELECT 
    c.customer_id,
    c.first_name,
    c.last_name,
    SUM(o.total_amount) AS total_spent
FROM customers AS c
JOIN orders AS o
    ON c.customer_id = o.customer_id
GROUP BY 
    c.customer_id,
    c.first_name,
    c.last_name
ORDER BY total_spent DESC
LIMIT 5;
Selgitus
JOIN
ühendab kliendi nime tellimustega.

SUM(o.total_amount)
arvutab iga kliendi kogukulu.

ORDER BY total_spent DESC
paneb kõige suurema kuluga kliendid ette.

LIMIT 5
võtab ainult top 5.

Ülesanne 21: Leia iga kategooria keskmine tootehind
Ülesanne
Näita iga kategooria kohta selle keskmist tootehinda.

Mõtlemine
Toote hind on tabelis products.
Kategooria nimi on tabelis categories.

Vaja on JOIN + GROUP BY.

SQL
SELECT 
    c.category_name,
    AVG(p.price) AS avg_price
FROM categories AS c
JOIN products AS p
    ON c.category_id = p.category_id
GROUP BY c.category_name;
Selgitus
AVG(p.price)
arvutab keskmise hinna.

GROUP BY c.category_name
teeb arvutuse iga kategooria kohta eraldi.

Ülesanne 22: Leia kategooriad, kus keskmine hind on üle 50
Ülesanne
Näita ainult neid kategooriaid, kus toodete keskmine hind on üle 50 euro.

SQL
SELECT 
    c.category_name,
    AVG(p.price) AS avg_price
FROM categories AS c
JOIN products AS p
    ON c.category_id = p.category_id
GROUP BY c.category_name
HAVING AVG(p.price) > 50;
Selgitus
Kuna AVG(p.price) on aggregate arvutus, tuleb kasutada HAVING.

Ülesanne 23: Leia tellimuse ridade kogusummad
Ülesanne
Näita iga tellimuserea kohta:

order_id
product_id
quantity
unit_price
line_total
line_total peab olema:

quantity * unit_price
SQL
SELECT 
    order_id,
    product_id,
    quantity,
    unit_price,
    quantity * unit_price AS line_total
FROM order_items;
Selgitus
SQL-is saad teha arvutusi otse SELECT osas.

Ülesanne 24: Leia iga tellimuse tegelik kogusumma order_items põhjal
Ülesanne
Arvuta iga tellimuse kogusumma tellimuseridade põhjal.

Mõtlemine
Igal tellimusel võib olla mitu rida.
Iga rea summa on:

quantity * unit_price
Tellimuse summa on nende ridade summa.

SQL
SELECT 
    order_id,
    SUM(quantity * unit_price) AS order_total
FROM order_items
GROUP BY order_id;
Selgitus
GROUP BY order_id
koondab sama tellimuse read kokku.

SUM(quantity * unit_price)
arvutab tellimuse kogusumma.

Ülesanne 25: Leia kõige rohkem müüdud tooted koguse järgi
Ülesanne
Leia tooted, mida on koguseliselt kõige rohkem müüdud.

Näita:

product_name
total_quantity_sold
SQL
SELECT 
    p.product_name,
    SUM(oi.quantity) AS total_quantity_sold
FROM order_items AS oi
JOIN products AS p
    ON oi.product_id = p.product_id
GROUP BY p.product_name
ORDER BY total_quantity_sold DESC;
Selgitus
order_items ütleb, kui palju mingit toodet telliti.
products annab toote nime.

SUM(oi.quantity)
liidab kokku müüdud kogused.

Ülesanne 26: Leia kõige suurema müügikäibega tooted
Ülesanne
Leia tooted, mis on toonud kõige rohkem raha.

SQL
SELECT 
    p.product_name,
    SUM(oi.quantity * oi.unit_price) AS revenue
FROM order_items AS oi
JOIN products AS p
    ON oi.product_id = p.product_id
GROUP BY p.product_name
ORDER BY revenue DESC;
Selgitus
Siin ei loe me ainult kogust.
Arvestame ka hinda.

quantity * unit_price
annab ühe rea müügisumma.

SUM(...)
annab toote kogukäibe.

Ülesanne 27: Lisa hinnakategooria toodetele
Ülesanne
Näita tooteid koos hinnakategooriaga:

price < 20 → cheap
20 kuni 100 → medium
üle 100 → expensive
SQL
SELECT 
    product_name,
    price,
    CASE
        WHEN price < 20 THEN 'cheap'
        WHEN price BETWEEN 20 AND 100 THEN 'medium'
        ELSE 'expensive'
    END AS price_category
FROM products;
Selgitus
CASE
on SQL-i tingimusloogika.

See töötab nagu:

kui hind < 20, siis cheap
kui hind on 20 kuni 100, siis medium
muidu expensive
Ülesanne 28: Leia completed ja cancelled tellimuste arv
Ülesanne
Näita, mitu tellimust on iga staatusega.

SQL
SELECT 
    status,
    COUNT(*) AS order_count
FROM orders
GROUP BY status;
Selgitus
GROUP BY status
teeb eraldi grupi iga staatuse kohta.

Näiteks:

completed
cancelled
pending
Ülesanne 29: Leia tellimused 2024. aastast
Ülesanne
Leia kõik tellimused, mis tehti aastal 2024.

Hea variant
SELECT *
FROM orders
WHERE order_date >= '2024-01-01'
  AND order_date < '2025-01-01';
Selgitus
See variant töötab hästi ka siis, kui order_date sisaldab kellaaega.

Vähem hea variant oleks:

WHERE order_date BETWEEN '2024-01-01' AND '2024-12-31'
Sest kui kuupäeval on kellaaeg, võib osa 2024-12-31 tellimusi välja jääda.

Ülesanne 30: Leia müük kuude kaupa
Ülesanne
Näita iga kuu müügitulu.

PostgreSQL
SELECT 
    DATE_TRUNC('month', order_date) AS month,
    SUM(total_amount) AS revenue
FROM orders
GROUP BY DATE_TRUNC('month', order_date)
ORDER BY month;
MySQL
SELECT 
    DATE_FORMAT(order_date, '%Y-%m') AS month,
    SUM(total_amount) AS revenue
FROM orders
GROUP BY DATE_FORMAT(order_date, '%Y-%m')
ORDER BY month;
SQLite
SELECT 
    strftime('%Y-%m', order_date) AS month,
    SUM(total_amount) AS revenue
FROM orders
GROUP BY strftime('%Y-%m', order_date)
ORDER BY month;
Selgitus
Kuupäev tuleb muuta kuu formaati ja siis selle järgi grupeerida.

Ülesanne 31: Leia tooted, mis on keskmisest kallimad
Ülesanne
Leia kõik tooted, mille hind on suurem kui toodete keskmine hind.

Mõtlemine
Kõigepealt on vaja teada keskmist hinda:

SELECT AVG(price)
FROM products;
Siis kasutame seda põhiküsimuse sees.

SQL
SELECT *
FROM products
WHERE price > (
    SELECT AVG(price)
    FROM products
);
Selgitus
Sisemine query:

SELECT AVG(price)
FROM products
arvutab keskmise hinna.

Välimine query leiab tooted, mille hind on sellest suurem.

Ülesanne 32: Leia kliendid, kellel on vähemalt üks tellimus
Ülesanne
Näita kliente, kellel eksisteerib vähemalt üks tellimus.

Variant 1: JOIN
SELECT DISTINCT
    c.customer_id,
    c.first_name,
    c.last_name
FROM customers AS c
JOIN orders AS o
    ON c.customer_id = o.customer_id;
Variant 2: EXISTS
SELECT *
FROM customers AS c
WHERE EXISTS (
    SELECT 1
    FROM orders AS o
    WHERE o.customer_id = c.customer_id
);
Selgitus
EXISTS kontrollib, kas seotud rida on olemas.

Kui kliendil on vähemalt üks tellimus, siis tingimus on tõene.

Ülesanne 33: Leia kliendid, kellel pole ühtegi completed tellimust
Ülesanne
Näita kliente, kellel pole mitte ühtegi completed tellimust.

SQL
SELECT *
FROM customers AS c
WHERE NOT EXISTS (
    SELECT 1
    FROM orders AS o
    WHERE o.customer_id = c.customer_id
      AND o.status = 'completed'
);
Selgitus
See query ütleb:

Näita klienti ainult siis, kui tema kohta ei eksisteeri completed tellimust.
See on parem kui NOT IN, sest NULL väärtused võivad NOT IN puhul tekitada segadust.

Ülesanne 34: Kasuta CTE-d kliendi kulutuste arvutamiseks
Ülesanne
Leia kliendid, kes on kulutanud üle 1000 euro.

Kasuta WITH ehk CTE-d.

SQL
WITH customer_spending AS (
    SELECT 
        customer_id,
        SUM(total_amount) AS total_spent
    FROM orders
    GROUP BY customer_id
)
SELECT *
FROM customer_spending
WHERE total_spent > 1000;
Selgitus
CTE teeb query loetavamaks.

Esimene osa:

WITH customer_spending AS (...)
loob ajutise tulemuse.

Teine osa:

SELECT *
FROM customer_spending
WHERE total_spent > 1000;
kasutab seda tulemust.

Ülesanne 35: Leia kliendid koos kogukuluga, ka need, kellel pole tellimusi
Ülesanne
Näita kõiki kliente ja nende kogukulu.
Kui kliendil pole tellimusi, peab kogukulu olema 0, mitte NULL.

SQL
SELECT 
    c.customer_id,
    c.first_name,
    c.last_name,
    COALESCE(SUM(o.total_amount), 0) AS total_spent
FROM customers AS c
LEFT JOIN orders AS o
    ON c.customer_id = o.customer_id
GROUP BY 
    c.customer_id,
    c.first_name,
    c.last_name;
Selgitus
Kui kliendil pole tellimusi, annab SUM(o.total_amount) tulemuseks NULL.

COALESCE(SUM(o.total_amount), 0)
asendab selle nulliga.

Ülesanne 36: Lisa uus klient
Ülesanne
Lisa tabelisse customers uus klient.

SQL
INSERT INTO customers (
    first_name,
    last_name,
    email,
    country,
    city
)
VALUES (
    'Mari',
    'Tamm',
    'mari.tamm@example.com',
    'Estonia',
    'Tallinn'
);
Selgitus
INSERT INTO customers (...)
ütleb, millisesse tabelisse ja millistesse veergudesse lisame.

VALUES (...)
annab lisatavad väärtused.

Ülesanne 37: Muuda toote hinda
Ülesanne
Muuda toote ID-ga 10 hind väärtuseks 29.99.

SQL
UPDATE products
SET price = 29.99
WHERE product_id = 10;
Selgitus
WHERE product_id = 10
on väga oluline.

Ilma selleta muudaksid kõigi toodete hinna:

UPDATE products
SET price = 29.99;
See oleks ohtlik.

Ülesanne 38: Kustuta cancelled tellimused
Ülesanne
Kustuta kõik tellimused, mille staatus on cancelled.

SQL
DELETE FROM orders
WHERE status = 'cancelled';
Selgitus
DELETE FROM orders
kustutab ridu tabelist.

WHERE status = 'cancelled'
määrab, millised read kustutatakse.

Ilma WHERE-ita kustutaksid kogu tabeli sisu.

Ülesanne 39: Loo customers tabel
Ülesanne
Loo tabel klientide salvestamiseks.

SQL
CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE,
    country VARCHAR(50),
    city VARCHAR(50)
);
Selgitus
PRIMARY KEY
tähendab unikaalset identifikaatorit.

NOT NULL
tähendab, et väärtus peab olemas olema.

UNIQUE
tähendab, et sama email ei tohi korduda.

Ülesanne 40: Loo orders tabel foreign key-ga
Ülesanne
Loo tellimuste tabel, kus iga tellimus kuulub kliendile.

SQL
CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT NOT NULL,
    order_date DATE,
    status VARCHAR(30),
    total_amount DECIMAL(10, 2),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);
Selgitus
FOREIGN KEY (customer_id)
ütleb, et orders.customer_id viitab teise tabeli kliendi ID-le.

REFERENCES customers(customer_id)
ütleb, kuhu see viitab.

Suur praktikaülesanne algusest lõpuni
Ülesanne
Leia iga kliendi kohta:

customer_id
first_name
last_name
completed tellimuste arv
completed tellimuste kogusumma
Näita ainult neid kliente, kelle completed tellimuste kogusumma on üle 500.
Sorteeri kogusumma järgi kahanevalt.

Mõtlemine samm-sammult
Vajame andmeid kahest tabelist:

customers
orders
Kuna tahame ka kliendi nime, alustame customers tabelist.

FROM customers AS c
Tellimused tulevad orders tabelist.

JOIN orders AS o
    ON c.customer_id = o.customer_id
Vajame ainult completed tellimusi.

WHERE o.status = 'completed'
Tahame tulemust kliendi kaupa.

GROUP BY c.customer_id, c.first_name, c.last_name
Tahame ainult neid, kelle summa on üle 500.

HAVING SUM(o.total_amount) > 500
Sorteerime suuremast väiksemaks.

ORDER BY completed_total DESC
Lõplik SQL
SELECT 
    c.customer_id,
    c.first_name,
    c.last_name,
    COUNT(o.order_id) AS completed_order_count,
    SUM(o.total_amount) AS completed_total
FROM customers AS c
JOIN orders AS o
    ON c.customer_id = o.customer_id
WHERE o.status = 'completed'
GROUP BY 
    c.customer_id,
    c.first_name,
    c.last_name
HAVING SUM(o.total_amount) > 500
ORDER BY completed_total DESC;
Selgitus
See query teeb järgmist:

1. ühendab kliendid ja tellimused
2. jätab alles ainult completed tellimused
3. grupeerib tulemuse kliendi kaupa
4. loeb tellimuste arvu
5. arvutab kogusumma
6. jätab alles ainult kliendid üle 500 kogusummaga
7. sorteerib tulemuse kahanevalt
Kõige tähtsam SQL ülesande lahendamise mall
Kui saad ülesande, kasuta seda mõtlemist:

1. Mis tabelitest andmed tulevad?
2. Kas on vaja JOIN-i?
3. Milliseid veerge peab näitama?
4. Kas on vaja WHERE tingimust?
5. Kas on vaja COUNT/SUM/AVG?
6. Kui jah, siis mille järgi GROUP BY?
7. Kas aggregate tulemust peab filtreerima? HAVING
8. Kas tulemust peab sorteerima? ORDER BY
9. Kas tulemust peab piirama? LIMIT
Universaalne mall:

SELECT 
    t1.some_column,
    COUNT(t2.id) AS count_value,
    SUM(t2.amount) AS total_value
FROM table1 AS t1
LEFT JOIN table2 AS t2
    ON t1.id = t2.table1_id
WHERE t1.some_column = 'some value'
GROUP BY t1.some_column
HAVING SUM(t2.amount) > 0
ORDER BY total_value DESC
LIMIT 10;
Harjutamiseks: proovi ise
Proovi enne ise kirjutada ja siis võrdle loogikaga.

Harjutus A
Leia kõik kliendid Tallinnast.

SELECT *
FROM customers
WHERE city = 'Tallinn';
Harjutus B
Leia 10 viimast tellimust.

SELECT *
FROM orders
ORDER BY order_date DESC
LIMIT 10;
Harjutus C
Leia iga riigi klientide arv.

SELECT 
    country,
    COUNT(*) AS customer_count
FROM customers
GROUP BY country;
Harjutus D
Leia riigid, kus on rohkem kui 5 klienti.

SELECT 
    country,
    COUNT(*) AS customer_count
FROM customers
GROUP BY country
HAVING COUNT(*) > 5;
Harjutus E
Leia top 3 toodet müügitulu järgi.

SELECT 
    p.product_name,
    SUM(oi.quantity * oi.unit_price) AS revenue
FROM order_items AS oi
JOIN products AS p
    ON oi.product_id = p.product_id
GROUP BY p.product_name
ORDER BY revenue DESC
LIMIT 3;
Kõige olulisem on mitte queryt pähe õppida, vaid õppida ära muster: FROM → JOIN → WHERE → GROUP BY → HAVING → ORDER BY → LIMIT.


