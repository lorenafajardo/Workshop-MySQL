

-- -----------------------------------------------------
--    SCRIPT II
--      Elaborado por:Lorena Fajardo Díaz 
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Tablas requeridas con las relaciones necesarias
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema shop
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS shop DEFAULT CHARACTER SET utf8 ;
USE shop ;

-- -----------------------------------------------------
-- Table shop
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS shop (
  shop_id INT NOT NULL AUTO_INCREMENT,
  shop_nit VARCHAR(20) NOT NULL,
  shop_name VARCHAR(20) NOT NULL,
  shop_phone VARCHAR(15) NULL,
  shop_location VARCHAR(25) NULL,
  PRIMARY KEY (shop_id))
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table provider
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS provider (
  provider_id INT NOT NULL AUTO_INCREMENT,
  provider_identification_type VARCHAR(20) NOT NULL,
  provider_identification_number VARCHAR(15) NOT NULL,
  provider_name VARCHAR(20) NOT NULL,
  status INT NULL DEFAULT 1,
  PRIMARY KEY (provider_id),
  UNIQUE INDEX provider_identification_number_UNIQUE (provider_identification_number ASC, provider_identification_type ASC) VISIBLE)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table product
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS product (
  product_id INT NOT NULL AUTO_INCREMENT,
  shop_id INT NOT NULL,
  provider_provider_id INT NOT NULL,
  product_name VARCHAR(20) NOT NULL,
  product_count INT NOT NULL,
  PRIMARY KEY (product_id, shop_id, provider_provider_id),
  INDEX fk_product_shop1_idx (shop_id ASC) VISIBLE,
  INDEX fk_product_provider1_idx (provider_provider_id ASC) VISIBLE,
  CONSTRAINT fk_product_shop1
    FOREIGN KEY (shop_id)
    REFERENCES shop (shop_id)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
CONSTRAINT fk_product_provider1
    FOREIGN KEY (provider_provider_id)
    REFERENCES provider (provider_id)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)

ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table sold_product
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS sold_product (
  id_sold INT NOT NULL AUTO_INCREMENT,
  product_product_id INT NOT NULL,
  product_shop_id INT NOT NULL,
  product_provider_provider_id INT NOT NULL,
  sold_count INT NOT NULL,
  customer_id_type VARCHAR(20) NOT NULL,
  customer_id_number VARCHAR(20) NOT NULL,
  PRIMARY KEY (id_sold, product_product_id, product_shop_id, product_provider_provider_id),
  UNIQUE INDEX id_sold_UNIQUE (id_sold ASC) VISIBLE,
  UNIQUE INDEX customer_id_number_UNIQUE (customer_id_number ASC, customer_id_type ASC) VISIBLE,
  INDEX fk_sold_product_product1_idx (product_product_id ASC, product_shop_id ASC, product_provider_provider_id ASC) VISIBLE,
  CONSTRAINT fk_sold_product_product1
    FOREIGN KEY (product_product_id , product_shop_id , product_provider_provider_id)
    REFERENCES product (product_id , shop_id , provider_provider_id)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table seller
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS seller (
  seller_id INT NOT NULL AUTO_INCREMENT,
  shop_shop_id INT NOT NULL,
  seller_identification_type VARCHAR(20) NOT NULL,
  seller_identification_number VARCHAR(15) NOT NULL,
  seller_name VARCHAR(15) NOT NULL,
  PRIMARY KEY (seller_id, shop_shop_id),
  INDEX fk_seller_shop_idx (shop_shop_id ASC) VISIBLE,
  UNIQUE INDEX seller_identification_number_UNIQUE (seller_identification_number ASC, seller_identification_type ASC) VISIBLE,
  CONSTRAINT fk_seller_shop
    FOREIGN KEY (shop_shop_id)
    REFERENCES shop (shop_id)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Tablas con información previa para poder manipular la base de datos a nivel de datos.
-- -----------------------------------------------------

INSERT INTO shop ( shop_nit, shop_name, shop_phone, shop_location)
VALUE ('123456', 'Zoe', ' 3148477425', 'Barrio Conquistadores');

INSERT INTO seller ( shop_shop_id, seller_identification_type, seller_identification_number, seller_name)
VALUE ( 1, 'CC', '1003647289', ' Aurelio Uribe');

INSERT INTO provider ( provider_identification_type, provider_identification_number, provider_name)
VALUE ('NIT', '111167839', ' Mil Cosas');

INSERT INTO provider ( provider_identification_type, provider_identification_number, provider_name)
VALUE ('NIT', '4563728', ' Variedades edih ');

INSERT INTO provider ( provider_identification_type, provider_identification_number, provider_name)
VALUE ('NIT', '888999', ' Mas articulos');

INSERT INTO provider ( provider_identification_type, provider_identification_number, provider_name)
VALUE ('NIT', '4500009', ' Carmell ');

INSERT INTO provider ( provider_identification_type, provider_identification_number, provider_name)
VALUE ('NIT', '66699900', ' El zorro');

INSERT INTO provider ( provider_identification_type, provider_identification_number, provider_name)
VALUE ('NIT', '40009', ' Maltis ');

INSERT INTO provider ( provider_identification_type, provider_identification_number, provider_name)
VALUE ('NIT', '11100021', ' La casita');

INSERT INTO product ( shop_id, provider_provider_id, product_name, product_count)
VALUE ( 1, 2,'maquillaje', 30);

INSERT INTO product ( shop_id, provider_provider_id, product_name, product_count)
VALUE (1, 1, 'plasticos',  20);

INSERT INTO product ( shop_id, provider_provider_id, product_name, product_count)
VALUE (1, 3, 'cocina', 7);

INSERT INTO sold_product ( product_product_id, product_shop_id, product_provider_provider_id,  sold_count, customer_id_type, customer_id_number)
VALUE (  3, 1, 3,  4, 'CC' , '19382999' );

INSERT INTO sold_product ( product_product_id, product_shop_id, product_provider_provider_id,  sold_count, customer_id_type, customer_id_number)
VALUE (  2, 1, 1,  2, 'CC' , '123456' );

INSERT INTO sold_product ( product_product_id, product_shop_id, product_provider_provider_id,  sold_count, customer_id_type, customer_id_number)
VALUE (  1, 1, 2,  3, 'CC' , '6666779' );


-- -----------------------------------------------------
-- 1. Consulta SQL donde pueda obtener los productos vendidos digitando tipo de documento y número de documento
-- -----------------------------------------------------

SELECT product_product_id, sold_count, customer_id_type, customer_id_number FROM sold_product
WHERE customer_id_type= 'CC' AND customer_id_number= '6666779';

-- -----------------------------------------------------
-- 2. Consultar productos por medio del nombre, el cual debe mostrar quien o quienes han sido sus proveedores.
-- -----------------------------------------------------

SELECT provider_provider_id, product_name, product_count FROM product
WHERE product_name = 'maquillaje';

-- -----------------------------------------------------
-- 3. [PLUS no obligatorio] Crear una consulta que me permita ver qué producto ha sido el más vendido y en qué cantidades de mayor a menor.
-- -----------------------------------------------------

SELECT product_product_id, product_provider_provider_id, sold_count FROM sold_product
ORDER BY sold_count DESC; 




