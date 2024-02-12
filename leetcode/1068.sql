-- Product Sales Analysis I

CREATE TABLE sales (
    sale_id int,
    product_id int,
    year int,
    quantity int,
    price int
);

CREATE TABLE product (
    product_id int,
    product_name varchar
);

INSERT INTO sales (sale_id,product_id,year,quantity,price)
VALUES
(1,100,2008,10,5000),
(2,100,2009,12,5000),
(7,200,2011,15,9000);

INSERT INTO product (product_id,product_name)
VALUES
(100,'Nokia'),
(200,'Apple'),
(300,'Samsung');

-- Write a solution to report the product_name, year and price for each sale_id in the sales table
SELECT product_name,year,price
FROM sales s
LEFT JOIN product p ON s.product_id = p.product_id;