USE amazon_price_tracker;

CREATE TABLE products (
    product_id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(500),
    url VARCHAR(500) UNIQUE,
    target_price DECIMAL(10,2),
    rating DECIMAL(3,2),
    reviews INT,
    availability VARCHAR(100),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


CREATE TABLE price_history (
    history_id INT AUTO_INCREMENT PRIMARY KEY,
    product_id INT,
    price DECIMAL(10,2),
    scraped_at DATETIME,

    FOREIGN KEY (product_id)
        REFERENCES products(product_id)
);

SHOW TABLES;
DESCRIBE products;