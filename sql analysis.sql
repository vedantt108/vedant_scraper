USE amazon_price_tracker;

SELECT
    product_id,
    title,
    url,
    target_price,
    rating,
    reviews,
    availability,
    asin
FROM products
ORDER BY product_id;


USE amazon_price_tracker;

SELECT
    ph.history_id,
    p.product_id,
    p.title,
    ph.price,
    ph.scraped_at
FROM price_history ph
JOIN products p
    ON ph.product_id = p.product_id
ORDER BY ph.history_id;

-- min

USE amazon_price_tracker;

SELECT
    p.title,
    MIN(ph.price) AS lowest_price
FROM products p
JOIN price_history ph
    ON p.product_id = ph.product_id
GROUP BY p.product_id, p.title
ORDER BY lowest_price ASC;

-- max 

USE amazon_price_tracker;

SELECT
    p.title,
    MAX(ph.price) AS highest_price,
    ROUND(AVG(ph.price), 2) AS average_price
FROM products p
JOIN price_history ph
    ON p.product_id = ph.product_id
GROUP BY p.product_id, p.title
ORDER BY highest_price DESC;

USE amazon_price_tracker;

-- avg

SELECT
    p.title,
    p.target_price,
    ph.price AS current_price,
    ROUND(ph.price - p.target_price, 2) AS difference,
    CASE
        WHEN ph.price <= p.target_price THEN 'Target Reached'
        ELSE 'Above Target'
    END AS price_status
FROM products p
JOIN price_history ph
    ON p.product_id = ph.product_id
WHERE ph.scraped_at = (
    SELECT MAX(ph2.scraped_at)
    FROM price_history ph2
    WHERE ph2.product_id = p.product_id
)
ORDER BY difference ASC;

-- difference

USE amazon_price_tracker;

SELECT
    p.title,
    MIN(ph.price) AS lowest_price,
    MAX(ph.price) AS highest_price,
    ROUND(MAX(ph.price) - MIN(ph.price), 2) AS price_range
FROM products p
JOIN price_history ph
    ON p.product_id = ph.product_id
GROUP BY p.product_id, p.title
ORDER BY price_range DESC;

-- ranking

USE amazon_price_tracker;

SELECT
    p.title,
    ph.price AS current_price,
    RANK() OVER (ORDER BY ph.price DESC) AS price_rank
FROM products p
JOIN price_history ph
    ON p.product_id = ph.product_id
WHERE ph.scraped_at = (
    SELECT MAX(ph2.scraped_at)
    FROM price_history ph2
    WHERE ph2.product_id = p.product_id
)
ORDER BY price_rank;

-- price observation

USE amazon_price_tracker;

SELECT
    p.title,
    COUNT(ph.history_id) AS price_observations
FROM products p
LEFT JOIN price_history ph
    ON p.product_id = ph.product_id
GROUP BY p.product_id, p.title
ORDER BY price_observations DESC;