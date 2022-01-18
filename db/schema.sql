\c postgres;

DROP DATABASE IF EXISTS products;

CREATE DATABASE products;

\c products;

CREATE TABLE product (
  id SERIAL PRIMARY KEY,
  name VARCHAR(500) NOT NULL,
  slogan TEXT NULL,
  description TEXT NULL,
  category VARCHAR(255) NOT NULL,
  default_price VARCHAR(255) NOT NULL
);

\copy product FROM '/home/salarmalik/SDC_Files/product.csv' WITH (FORMAT csv, HEADER TRUE);

CREATE TABLE related (
  id SERIAL PRIMARY KEY,
  current_product_id INT NOT NULL,
  related_product_id INT NOT NULL,
  FOREIGN KEY (current_product_id) REFERENCES product (id)
);

\copy related(id, current_product_id, related_product_id) FROM '/home/salarmalik/SDC_Files/related.csv' WITH (FORMAT csv, HEADER TRUE);

CREATE TABLE features (
  id SERIAL PRIMARY KEY,
  product_id INT NOT NULL,
  feature VARCHAR(100) NOT NULL,
  value VARCHAR(255) NULL,
  FOREIGN KEY (product_id) REFERENCES product (id)
);

\copy features(id, product_id, feature, value) FROM '/home/salarmalik/SDC_Files/features.csv' WITH (FORMAT csv, HEADER TRUE);

CREATE TABLE styles (
  id SERIAL PRIMARY KEY,
  productId INT NOT NULL,
  name VARCHAR(500) NOT NULL,
  sale_price VARCHAR(255) NULL,
  original_price VARCHAR(255) NOT NULL,
  default_style SMALLINT,
  FOREIGN KEY (productId) REFERENCES product (id)
);

\copy styles(id, productId, name, sale_price, original_price, default_style) FROM '/home/salarmalik/SDC_Files/styles.csv' WITH (FORMAT csv, HEADER TRUE);

ALTER TABLE styles ALTER COLUMN default_style DROP DEFAULT;
ALTER TABLE styles ALTER default_style TYPE bool USING CASE WHEN default_style=0 THEN FALSE ELSE TRUE END;
ALTER TABLE styles ALTER COLUMN default_style SET DEFAULT FALSE;

CREATE TABLE photos (
  id SERIAL PRIMARY KEY,
  styleId INT NOT NULL,
  url TEXT NULL,
  thumbnail_url TEXT NULL,
  FOREIGN KEY (styleId) REFERENCES styles (id)
);

\copy photos(id, styleId, url, thumbnail_url) FROM '/home/salarmalik/SDC_Files/photos.csv' WITH (FORMAT csv, HEADER TRUE);

CREATE TABLE skus (
  id SERIAL PRIMARY KEY,
  styleId INT NOT NULL,
  size VARCHAR(50) NOT NULL,
  quantity INT NOT NULL DEFAULT 0,
  FOREIGN KEY (styleId) REFERENCES styles (id)
);

\copy skus(id, styleId, size, quantity) FROM '/home/salarmalik/SDC_Files/skus.csv' WITH (FORMAT csv, HEADER TRUE);

CREATE INDEX product_id_index ON product (id);
CREATE INDEX related_productId_index ON related (current_product_id);
CREATE INDEX features_productId_index ON features (product_id);
-- CREATE INDEX styles_id_index ON styles (id);
-- CREATE INDEX styles_productId_index ON styles (productId);
CREATE INDEX photos_styleId_index ON photos (styleId);
CREATE INDEX skus_styleId_index ON skus (styleId);
CREATE INDEX styles_productId_id_index ON styles (productId, id);
DROP INDEX styles_productId_id_index CASCADE;

EXPLAIN ANALYZE SELECT s.id AS style_id, s.name, s.original_price, s.sale_price, s.default_style AS default,
  json_agg(DISTINCT jsonb_build_object('url', p.url, 'thumbnail_url', p.thumbnail_url)) as photos,
  json_object_agg(COALESCE(sk.id::VARCHAR, 'null'), jsonb_build_object('size', sk.size, 'quantity', sk.quantity)) as skus
  FROM styles as s
  LEFT JOIN photos as p ON p.styleId = s.id
  LEFT JOIN skus as sk ON sk.styleId = s.id
  WHERE s.productId = 3
  GROUP BY s.id;

SELECT p.*, json_agg(jsonb_build_object('value', f.value, 'feature', f.feature)) AS features FROM product p LEFT JOIN features f ON f.product_id = p.id WHERE p.id = 1 GROUP BY p.id;