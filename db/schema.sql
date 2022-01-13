
DROP DATABASE IF EXISTS productsdb;

CREATE DATABASE productsdb;

CREATE TABLE product (
  product_id INT NOT NULL PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  slogan VARCHAR NULL DEFAULT NULL,
  description VARCHAR NULL DEFAULT NULL,
  category VARCHAR(255) NOT NULL,
  default_price INT NOT NULL
);

CREATE TABLE related (
  id INT NOT NULL PRIMARY KEY
  current_product_id INT NOT NULL,
  related_product_id INT NOT NULL,
  FOREIGN KEY (current_product_id) REFERENCES product (id),
  FOREIGN KEY (related_product_id) REFERENCES product (id)
);

CREATE TABLE features (
  id INT NOT NULL PRIMARY KEY,
  product_id INT NOT NULL,
  feature VARCHAR(100) NOT NULL,
  value VARCHAR(255) NULL,
  FOREIGN KEY (product_id) REFERENCES product (id)
);

CREATE TABLE styles (
  id SERIAL PRIMARY KEY,
  productId INT NOT NULL,
  name VARCHAR(500) NOT NULL,
  sale_price INT NULL DEFAULT 0,
  original_price INT NULL DEFAULT 0,
  default_style SMALLINT DEFAULT 0,
  FOREIGN KEY (productId) REFERENCES product (id)
);

CREATE TABLE photos (
  id SERIAL PRIMARY KEY,
  styleId INT NOT NULL,
  url TEXT NULL,
  thumbnail_url TEXT NULL,
  FOREIGN KEY (styleId) REFERENCES styles (id)
);

CREATE TABLE skus (
  id SERIAL PRIMARY KEY,
  styleId INT NOT NULL,
  size VARCHAR(50) NOT NULL,
  quantity INT NOT NULL DEFAULT 0,
  FOREIGN KEY (styleId) REFERENCES styles (id)
);
