CREATE DATABASE online_retail_store;
USE online_retail_store;

CREATE TABLE customers(
	customerid INT AUTO_INCREMENT PRIMARY KEY,
    firstname VARCHAR(50),
    lastname VARCHAR(50),
    email VARCHAR(100) UNIQUE,
    phone VARCHAR(15),
    address TEXT,
    city VARCHAR(50),
    state VARCHAR(50),
    country VARCHAR(50),
    postalcode VARCHAR(10)
);

CREATE TABLE products(
	productid INT AUTO_INCREMENT PRIMARY KEY,
    productname VARCHAR(100),
    description TEXT,
    price DECIMAL(10, 2),
    stock INT,
    category VARCHAR(50)
);

CREATE TABLE orders(
	orderid INT AUTO_INCREMENT PRIMARY KEY,
    customerid INT,
    orderdate DATETIME,
    status VARCHAR(20),
    FOREIGN KEY (customerid)
    REFERENCES customers(customerid)
);

CREATE TABLE order_details(
	order_detail_id INT AUTO_INCREMENT PRIMARY KEY,
    orderid INT,
    productid INT,
    quantity INT,
    totalprice DECIMAL(10,2),
    FOREIGN KEY(orderid)
    REFERENCES orders(orderid),
    FOREIGN KEY(productid)
    REFERENCES products(productid)
);

CREATE TABLE payments(
	paymentid INT AUTO_INCREMENT PRIMARY KEY,
    orderid INT,
    payment_date DATETIME,
    amount DECIMAL(10, 2),
    paymentmethod VARCHAR(50),
    FOREIGN KEY (orderid)
    REFERENCES orders(orderid)
);

INSERT INTO customers
(firstname, lastname, email, phone, address, city, state, country, postalcode)
VALUES
('Alice', 'Smith', 'alicesmith@email.com', '9876543210', '456 Park Ave', 'Washington', 'DC', 'United States', '54321');

INSERT INTO orders
(customerid, orderdate, status)
VALUES
(LAST_INSERT_ID(), NOW(), 'Pending');

