-- price trend and volatility analysis.

USE amazon_price_tracker;

SELECT
    p.title,
    p.target_price,
    ph.price AS current_price,
    ROUND(p.target_price - ph.price, 2) AS savings,
    'Target Reached' AS status
FROM products p
JOIN price_history ph
    ON p.product_id = ph.product_id
WHERE ph.scraped_at = (
    SELECT MAX(ph2.scraped_at)
    FROM price_history ph2
    WHERE ph2.product_id = p.product_id
)
AND ph.price <= p.target_price
ORDER BY savings DESC;

-- avg price combined

USE amazon_price_tracker;

SELECT
    ROUND(AVG(price), 2) AS overall_average_price
FROM price_history;

-- compare w overall avgg

USE amazon_price_tracker;

SELECT
    p.title,
    ph.price AS current_price,
    ROUND((
        SELECT AVG(price)
        FROM price_history
    ), 2) AS overall_average_price,
    ROUND(
        ph.price - (
            SELECT AVG(price)
            FROM price_history
        ), 2
    ) AS difference_from_average,
    CASE
        WHEN ph.price > (
            SELECT AVG(price)
            FROM price_history
        ) THEN 'Above Average'
        WHEN ph.price < (
            SELECT AVG(price)
            FROM price_history
        ) THEN 'Below Average'
        ELSE 'At Average'
    END AS price_category
FROM products p
JOIN price_history ph
    ON p.product_id = ph.product_id
WHERE ph.scraped_at = (
    SELECT MAX(ph2.scraped_at)
    FROM price_history ph2
    WHERE ph2.product_id = p.product_id
)
ORDER BY difference_from_average DESC;

-- price volatility

USE amazon_price_tracker;

SELECT
    p.title,
    ROUND(MIN(ph.price), 2) AS lowest_price,
    ROUND(MAX(ph.price), 2) AS highest_price,
    ROUND(AVG(ph.price), 2) AS average_price,
    ROUND(MAX(ph.price) - MIN(ph.price), 2) AS price_range
FROM products p
JOIN price_history ph
    ON p.product_id = ph.product_id
GROUP BY p.product_id, p.title
ORDER BY price_range DESC;

