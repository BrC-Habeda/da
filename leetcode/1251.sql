-- 1251 Average Selling Price

CREATE TABLE prices(
    product_id int,
    start_date date,
    end_date date,
    price int
);

CREATE TABLE unitsSold(
    product_id int,
    purchase_date date,
    units int
);

INSERT INTO prices(product_id,start_date,end_date,price)
VALUES
(1,'2019-02-17','2019-02-28',5),
(1,'2019-03-01','2019-03-22',20),
(2,'2019-02-01','2019-02-20',15),
(2,'2019-02-21','2019-03-31',30);

INSERT INTO unitsSold(product_id,purchase_date,units)
VALUES
(1,'2019-02-25',100),
(1,'2019-03-01',15),
(2,'2019-02-10',200),
(2,'2019-03-22',30);
