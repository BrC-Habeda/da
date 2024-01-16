--1757. Recyclable and Low Fat Products
-- Define the enum type
CREATE TYPE enum AS ENUM ('Y', 'N');

--Create Products Table
CREATE TABLE products (
    product_id INT PRIMARY KEY,
    low_fats enum('Y','N'),
    recyclable enum('Y','N')
);

--INSERT data into Table
INSERT INTO products (product_id,low_fats,recyclable)
VALUES
(1,'Y','Y'),
(2,'N','Y'),
(3,'Y','Y'),
(4,'N','N');

--Query to answer the Question
SELECT product_id
FROM products
WHERE low_fats = 'Y' AND recyclable = 'Y'; 