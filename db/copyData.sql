COPY product(product_id, name, slogan, description, category, default_price)
FROM '/Users/salar/Documents/SDC_Files/product.csv'
DELIMITER ','
CSV HEADER;

COPY related(id, current_product_id, related_product_id)
FROM '/Users/salar/Documents/SDC_Files/related.csv'
DELIMITER ','
CSV HEADER;

COPY features(id, product_id, feature, value)
FROM '/Users/salar/Documents/SDC_Files/features.csv'
DELIMITER ','
NULL AS 'null'
CSV HEADER;

COPY styles(id, productId, name, sale_price, original_price, default_style)
FROM '/Users/salar/Documents/SDC_Files/styles.csv'
DELIMITER ','
NULL AS 'null'
CSV HEADER;

COPY skus(id, styleId, size, quantity)
FROM '/Users/salar/Documents/SDC_Files/skus.csv'
DELIMITER ','
CSV HEADER;

