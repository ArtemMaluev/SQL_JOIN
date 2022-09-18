create schema sql_join;
use sql_join;

-- script №1 create table customers
create table CUSTOMERS
(
    id           serial auto_increment,
    name         varchar(50) not null ,
    surname      varchar(50) not null ,
    age          int CHECK ( age > 0 AND age < 121),
    phone_number char(15)    not null ,
    PRIMARY KEY (id)
);

INSERT INTO CUSTOMERS(name, surname, age, phone_number)
VALUES ('Ivan', 'Ivanov', 18, '8(921)123-12-31'),
       ('Alexey', 'Petrov', 20, '8(921)565-65-58'),
       ('Olga', 'Frolova', 38, '8(921)954-65-32'),
       ('Elena', 'Sidorova', 22, '8(921)234-54-65'),
       ('Oleg', 'Semenov', 52, '8(921)564-42-12'),
       ('Alexey', 'Filatova', 42, '8(921)954-21-03');

-- script №2 create table orders
create table ORDERS
(
    id           serial auto_increment,
    date         timestamp    not null default now(),
    customer_id  int,
    product_name varchar(255) not null ,
    amount       int CHECK ( amount > 0 ) not null ,
    PRIMARY KEY (id),
    FOREIGN KEY (customer_id) REFERENCES CUSTOMERS (id)
);

create index index_customer_id
    on ORDERS (customer_id);

INSERT INTO ORDERS(customer_id, product_name, amount)
VALUES (1, 'telephone', 15000),
       (5, 'computer', 50000),
       (2, 'telephone', 25000),
       (2, 'televisor', 65000),
       (4, 'telephone', 22000),
       (6, 'computer', 80000);


-- script №3
select product_name, C.name, C.surname
from ORDERS O
         join CUSTOMERS C on O.customer_id = C.id
where lower(C.name) = lower('alexey');