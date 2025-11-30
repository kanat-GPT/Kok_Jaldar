CREATE DATABASE IF NOT EXISTS kokjaldar_db CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE kokjaldar_db;

CREATE TABLE Countries (
    country_id TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    Country VARCHAR(100) NOT NULL UNIQUE
) ENGINE=InnoDB;

CREATE TABLE Categories (
    category_id SMALLINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    category_name VARCHAR(100) NOT NULL UNIQUE
) ENGINE=InnoDB;

CREATE TABLE Products (
    product_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    StockCode VARCHAR(20) NOT NULL UNIQUE,
    Description VARCHAR(500) NOT NULL,
    category_id SMALLINT UNSIGNED NULL,
    FOREIGN KEY (category_id) REFERENCES Categories(category_id) ON DELETE SET NULL,
    INDEX idx_stockcode (StockCode),
    INDEX idx_category (category_id)
) ENGINE=InnoDB;

CREATE TABLE Customers (
    customer_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    CustomerID VARCHAR(20) NOT NULL UNIQUE,
    country_id TINYINT UNSIGNED NOT NULL,
    FOREIGN KEY (country_id) REFERENCES Countries(country_id) ON DELETE RESTRICT,
    INDEX idx_country (country_id)
) ENGINE=InnoDB;

CREATE TABLE Orders (
    order_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    InvoiceNo VARCHAR(20) NOT NULL UNIQUE,
    InvoiceDate DATETIME NOT NULL,
    customer_id INT UNSIGNED NOT NULL,
    total_amount DECIMAL(12,2) NOT NULL DEFAULT 0.00,
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id) ON DELETE RESTRICT,
    INDEX idx_date (InvoiceDate),
    INDEX idx_customer (customer_id)
) ENGINE=InnoDB;

CREATE TABLE Order_Items (
    item_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    order_id INT UNSIGNED NOT NULL,
    product_id INT UNSIGNED NOT NULL,
    Quantity INT NOT NULL CHECK (Quantity > 0),
    UnitPrice DECIMAL(10,2) NOT NULL CHECK (UnitPrice >= 0),
    FOREIGN KEY (order_id) REFERENCES Orders(order_id) ON DELETE CASCADE,
    FOREIGN KEY (product_id) REFERENCES Products(product_id) ON DELETE RESTRICT,
    INDEX idx_order (order_id),
    INDEX idx_product (product_id)
) ENGINE=InnoDB;

CREATE TABLE Payments (
    payment_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    order_id INT UNSIGNED NOT NULL UNIQUE,
    amount_paid DECIMAL(12,2) NOT NULL,
    FOREIGN KEY (order_id) REFERENCES Orders(order_id) ON DELETE RESTRICT
) ENGINE=InnoDB;