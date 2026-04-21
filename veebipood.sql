create database Kristo_veebipood;
use Kristo_veebipood;

--Tabel Brands
create table brands(
brand_id int primary key identity(1,1),
brand_name varchar(25) UNIQUE)

insert into brands
values ('Adidas')

INSERT INTO brands (brand_name) 
VALUES ('Trek');


Select * from brands

--Tabel Categories
create table categories(
category_id int Primary key identity(1,1),
category_name varchar(25) UNIQUE)

insert into categories
values('tossud')

INSERT INTO categories (category_name) 
VALUES ('Maastikurattad');

Select * from categories
Select * from brands

--Tabel Product
create table products(
product_id int Primary key identity(1,1),
product_name varchar(25) UNIQUE,
brand_id int,
foreign key (brand_id) references brands(brand_id),
category_id int,
foreign key (category_id) references categories(category_id),
model_year int,
list_price money)

insert into products
values ('jooksu püksid',1,2,2026,35.50)


select * from products
select * from brands
select * from categories

--Tabel Customers
CREATE TABLE customers (
    customer_id INT PRIMARY KEY IDENTITY(1,1),
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    phone VARCHAR(25),
    email VARCHAR(255) NOT NULL,
    street VARCHAR(255),
    city VARCHAR(50),
    state VARCHAR(50),
    zip_code VARCHAR(20)
);

INSERT INTO customers (first_name, last_name, phone, email, street, city, state, zip_code)
VALUES ('Priit', 'Mets', '573498', 'priit.mets@gmail.com', 'Punane tänav', 'Mustamäe', 'Tallinn', '12345');

--Tabel stores
CREATE TABLE stores (
    store_id INT PRIMARY KEY IDENTITY(1,1),
    store_name VARCHAR(255) NOT NULL,
    phone VARCHAR(25),
    email VARCHAR(255) NOT NULL,
    street VARCHAR(255),
    city VARCHAR(255),
    state VARCHAR(25),
    zip_code VARCHAR(20)
);

INSERT INTO stores (store_name, phone, email, street, city, state, zip_code)
VALUES ('Jalgrattakeskus', '5551234', 'info@jalgrattakeskus.ee', 'Pärnu mnt 15', 'Tallinn', 'Harjumaa', '10111');


--Tabel staffs

CREATE TABLE staffs (
    staff_id INT PRIMARY KEY IDENTITY(1,1),
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    phone VARCHAR(25),
    active TINYINT NOT NULL,
    store_id INT NOT NULL,
    manager_id INT,
    FOREIGN KEY (store_id) REFERENCES stores (store_id),
    FOREIGN KEY (manager_id) REFERENCES staffs (staff_id)
);

INSERT INTO staffs (first_name, last_name, email, phone, active, store_id, manager_id)
VALUES ('Mari', 'Maasikas', 'mari.maasikas@jalgrattakeskus.ee', '5559876', 1, 1, NULL);

--Tabel stocks
CREATE TABLE stocks (
    store_id INT,
    product_id INT,
    quantity INT,
    PRIMARY KEY (store_id, product_id),
    FOREIGN KEY (store_id) REFERENCES stores (store_id),
    FOREIGN KEY (product_id) REFERENCES products (product_id)
);

INSERT INTO stocks (store_id, product_id, quantity)
VALUES (1, 2, 25);


--Tabel orders
CREATE TABLE orders (
    order_id INT PRIMARY KEY IDENTITY(1,1),
    customer_id INT,
    order_status TINYINT NOT NULL,
    order_date DATE NOT NULL,
    required_date DATE NOT NULL,
    shipped_date DATE,
    store_id INT NOT NULL,
    staff_id INT NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES customers (customer_id),
    FOREIGN KEY (store_id) REFERENCES stores (store_id),
    FOREIGN KEY (staff_id) REFERENCES staffs (staff_id)
);

INSERT INTO orders (customer_id, order_status, order_date, required_date, shipped_date, store_id, staff_id)
VALUES (1, 1, '2026-04-21', '2026-04-25', NULL, 1, 1);


--Tabel Order_items
CREATE TABLE order_items (
    order_id INT,
    item_id INT,
    product_id INT NOT NULL,
    quantity INT NOT NULL,
    list_price DECIMAL(10, 2) NOT NULL,
    discount DECIMAL(4, 2) NOT NULL DEFAULT 0,
    PRIMARY KEY (order_id, item_id),
    FOREIGN KEY (order_id) REFERENCES orders (order_id),
    FOREIGN KEY (product_id) REFERENCES products (product_id)
);

INSERT INTO order_items (order_id, item_id, product_id, quantity, list_price, discount)
VALUES (1, 1, 3, 2, 599.99, 0.05);



select * from brands
select * from products
select * from categories
select * from customers
select * from stores
select * from staffs
select * from stocks
select * from orders
select * from order_items
