-- MySQL Script generated by MySQL Workbench
-- Sat Jun 13 21:35:52 2020
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mannequin_db
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `mannequin_db` ;

-- -----------------------------------------------------
-- Schema mannequin_db
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mannequin_db` DEFAULT CHARACTER SET utf8 ;
USE `mannequin_db` ;

-- -----------------------------------------------------
-- Table `mannequin_db`.`cart`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mannequin_db`.`cart` ;

CREATE TABLE IF NOT EXISTS `mannequin_db`.`cart` (
  `idcart` INT NOT NULL AUTO_INCREMENT,
  `users_idusers` INT NOT NULL,
  `active` INT NOT NULL DEFAULT 1,
  `amount` DECIMAL(10,2) NOT NULL DEFAULT 0,
  PRIMARY KEY (`idcart`, `users_idusers`),
  INDEX `fk_cart_users1_idx` (`users_idusers` ASC) ,
  CONSTRAINT `fk_cart_users1`
    FOREIGN KEY (`users_idusers`)
    REFERENCES `mannequin_db`.`users` (`idusers`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mannequin_db`.`cart_has_products`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mannequin_db`.`cart_has_products` ;

CREATE TABLE IF NOT EXISTS `mannequin_db`.`cart_has_products` (
  `cart_idcart` INT NOT NULL,
  `cart_users_idusers` INT NOT NULL,
  `products_idproducts` INT NOT NULL,
  `sizes_idsizes` INT NOT NULL,
  `colors_idcolors` INT NOT NULL,
  `creation_timestamp` DATE NOT NULL,
  PRIMARY KEY (`cart_idcart`, `cart_users_idusers`, `products_idproducts`, `sizes_idsizes`, `colors_idcolors`),
  INDEX `fk_cart_has_products_products1_idx` (`products_idproducts` ASC) ,
  INDEX `fk_cart_has_products_cart1_idx` (`cart_idcart` ASC, `cart_users_idusers` ASC) ,
  INDEX `fk_cart_has_products_sizes1_idx` (`sizes_idsizes` ASC) ,
  INDEX `fk_cart_has_products_colors1_idx` (`colors_idcolors` ASC) ,
  CONSTRAINT `fk_cart_has_products_cart1`
    FOREIGN KEY (`cart_idcart` , `cart_users_idusers`)
    REFERENCES `mannequin_db`.`cart` (`idcart` , `users_idusers`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_cart_has_products_products1`
    FOREIGN KEY (`products_idproducts`)
    REFERENCES `mannequin_db`.`products` (`idproducts`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_cart_has_products_sizes1`
    FOREIGN KEY (`sizes_idsizes`)
    REFERENCES `mannequin_db`.`sizes` (`idsizes`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_cart_has_products_colors1`
    FOREIGN KEY (`colors_idcolors`)
    REFERENCES `mannequin_db`.`colors` (`idcolors`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mannequin_db`.`colors`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mannequin_db`.`colors` ;

CREATE TABLE IF NOT EXISTS `mannequin_db`.`colors` (
  `idcolors` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `hexa` VARCHAR(45) NOT NULL,
  `active` TINYINT NOT NULL DEFAULT 1,
  PRIMARY KEY (`idcolors`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mannequin_db`.`countries`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mannequin_db`.`countries` ;

CREATE TABLE IF NOT EXISTS `mannequin_db`.`countries` (
  `idcountries` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idcountries`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mannequin_db`.`favorites`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mannequin_db`.`favorites` ;

CREATE TABLE IF NOT EXISTS `mannequin_db`.`favorites` (
  `products_idproducts` INT NOT NULL,
  `active` INT(1) NOT NULL DEFAULT 1,
  `users_idusers` INT NOT NULL,
  PRIMARY KEY (`products_idproducts`, `users_idusers`),
  INDEX `fk_favorites_products1_idx` (`products_idproducts` ASC) ,
  INDEX `fk_favorites_users1_idx` (`users_idusers` ASC) ,
  CONSTRAINT `fk_favorites_products1`
    FOREIGN KEY (`products_idproducts`)
    REFERENCES `mannequin_db`.`products` (`idproducts`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_favorites_users1`
    FOREIGN KEY (`users_idusers`)
    REFERENCES `mannequin_db`.`users` (`idusers`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mannequin_db`.`images`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mannequin_db`.`images` ;

CREATE TABLE IF NOT EXISTS `mannequin_db`.`images` (
  `idimage` INT NOT NULL AUTO_INCREMENT,
  `file_name` VARCHAR(45) NOT NULL,
  `products_has_colors_products_idproducts` INT NOT NULL,
  `products_has_colors_colors_idcolors` INT NOT NULL,
  PRIMARY KEY (`idimage`, `products_has_colors_products_idproducts`, `products_has_colors_colors_idcolors`),
  INDEX `fk_images_products_has_colors1_idx` (`products_has_colors_products_idproducts` ASC, `products_has_colors_colors_idcolors` ASC) ,
  CONSTRAINT `fk_images_products_has_colors1`
    FOREIGN KEY (`products_has_colors_products_idproducts` , `products_has_colors_colors_idcolors`)
    REFERENCES `mannequin_db`.`products_has_colors` (`products_idproducts` , `colors_idcolors`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mannequin_db`.`product_categories`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mannequin_db`.`product_categories` ;

CREATE TABLE IF NOT EXISTS `mannequin_db`.`product_categories` (
  `idproduct_categories` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `active` INT(1) NOT NULL DEFAULT 1,
  PRIMARY KEY (`idproduct_categories`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mannequin_db`.`product_subcategories`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mannequin_db`.`product_subcategories` ;

CREATE TABLE IF NOT EXISTS `mannequin_db`.`product_subcategories` (
  `idproduct_subcategories` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NULL,
  `product_categories_id` INT NOT NULL,
  `active` INT(1) NOT NULL DEFAULT 1,
  PRIMARY KEY (`idproduct_subcategories`, `product_categories_id`),
  INDEX `fk_product_subcategories_product_categories1_idx` (`product_categories_id` ASC) ,
  CONSTRAINT `fk_product_subcategories_product_categories1`
    FOREIGN KEY (`product_categories_id`)
    REFERENCES `mannequin_db`.`product_categories` (`idproduct_categories`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mannequin_db`.`products`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mannequin_db`.`products` ;

CREATE TABLE IF NOT EXISTS `mannequin_db`.`products` (
  `idproducts` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `description` VARCHAR(100) NOT NULL,
  `price` DECIMAL(10,2) NOT NULL DEFAULT 0,
  `creation_timestamp` DATETIME NOT NULL,
  `discontinued_timestamp` DATETIME NULL,
  `active` INT(1) NOT NULL DEFAULT 1,
  `product_categories_id` INT NOT NULL,
  `sale` TINYINT(1) NOT NULL DEFAULT 0,
  `new_season` TINYINT(1) NOT NULL DEFAULT 0,
  `discount` INT(3) NULL DEFAULT 0,
  PRIMARY KEY (`idproducts`, `product_categories_id`),
  INDEX `fk_products_product_categories1_idx` (`product_categories_id` ASC) ,
  CONSTRAINT `fk_products_product_categories1`
    FOREIGN KEY (`product_categories_id`)
    REFERENCES `mannequin_db`.`product_categories` (`idproduct_categories`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mannequin_db`.`products_has_colors`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mannequin_db`.`products_has_colors` ;

CREATE TABLE IF NOT EXISTS `mannequin_db`.`products_has_colors` (
  `products_idproducts` INT NOT NULL,
  `colors_idcolors` INT NOT NULL,
  PRIMARY KEY (`products_idproducts`, `colors_idcolors`),
  INDEX `fk_products_has_colors_colors1_idx` (`colors_idcolors` ASC) ,
  INDEX `fk_products_has_colors_products1_idx` (`products_idproducts` ASC) ,
  CONSTRAINT `fk_products_has_colors_products1`
    FOREIGN KEY (`products_idproducts`)
    REFERENCES `mannequin_db`.`products` (`idproducts`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_products_has_colors_colors1`
    FOREIGN KEY (`colors_idcolors`)
    REFERENCES `mannequin_db`.`colors` (`idcolors`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mannequin_db`.`products_has_sizes`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mannequin_db`.`products_has_sizes` ;

CREATE TABLE IF NOT EXISTS `mannequin_db`.`products_has_sizes` (
  `products_idproducts` INT NOT NULL,
  `sizes_idsizes` INT NOT NULL,
  PRIMARY KEY (`products_idproducts`, `sizes_idsizes`),
  INDEX `fk_products_has_sizes_sizes1_idx` (`sizes_idsizes` ASC) ,
  INDEX `fk_products_has_sizes_products1_idx` (`products_idproducts` ASC) ,
  CONSTRAINT `fk_products_has_sizes_products1`
    FOREIGN KEY (`products_idproducts`)
    REFERENCES `mannequin_db`.`products` (`idproducts`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_products_has_sizes_sizes1`
    FOREIGN KEY (`sizes_idsizes`)
    REFERENCES `mannequin_db`.`sizes` (`idsizes`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mannequin_db`.`sizes`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mannequin_db`.`sizes` ;

CREATE TABLE IF NOT EXISTS `mannequin_db`.`sizes` (
  `idsizes` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `active` TINYINT NOT NULL DEFAULT 1,
  PRIMARY KEY (`idsizes`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mannequin_db`.`stock`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mannequin_db`.`stock` ;

CREATE TABLE IF NOT EXISTS `mannequin_db`.`stock` (
  `idstock` INT NOT NULL AUTO_INCREMENT,
  `sizes_idsizes` INT NOT NULL,
  `colors_idcolors` INT NOT NULL,
  `products_idproducts` INT NOT NULL,
  `amount` INT NOT NULL DEFAULT 0,
  PRIMARY KEY (`idstock`, `sizes_idsizes`, `colors_idcolors`, `products_idproducts`),
  INDEX `fk_products_info_sizes1_idx` (`sizes_idsizes` ASC) ,
  INDEX `fk_products_info_colors1_idx` (`colors_idcolors` ASC) ,
  INDEX `fk_products_info_products1_idx` (`products_idproducts` ASC) ,
  CONSTRAINT `fk_products_info_sizes1`
    FOREIGN KEY (`sizes_idsizes`)
    REFERENCES `mannequin_db`.`sizes` (`idsizes`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_products_info_colors1`
    FOREIGN KEY (`colors_idcolors`)
    REFERENCES `mannequin_db`.`colors` (`idcolors`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_products_info_products1`
    FOREIGN KEY (`products_idproducts`)
    REFERENCES `mannequin_db`.`products` (`idproducts`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mannequin_db`.`suscribers`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mannequin_db`.`suscribers` ;

CREATE TABLE IF NOT EXISTS `mannequin_db`.`suscribers` (
  `idsuscribers` INT NOT NULL AUTO_INCREMENT,
  `email` VARCHAR(45) NOT NULL,
  `active` TINYINT NOT NULL DEFAULT 1,
  `creation_timestamp` DATE NOT NULL,
  `delete_timestamp` DATE NULL,
  PRIMARY KEY (`idsuscribers`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mannequin_db`.`users`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mannequin_db`.`users` ;

CREATE TABLE IF NOT EXISTS `mannequin_db`.`users` (
  `idusers` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `lastname` VARCHAR(45) NOT NULL,
  `password` VARCHAR(45) NOT NULL,
  `countries_idcountries` INT NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  `address` VARCHAR(45) NOT NULL,
  `document` VARCHAR(45) NOT NULL,
  `birth_date` DATE NOT NULL,
  `telephone` INT NULL,
  `avatar` VARCHAR(150) NULL,
  `admin` TINYINT(1) NOT NULL,
  `active` TINYINT(1) NOT NULL DEFAULT 1,
  PRIMARY KEY (`idusers`, `countries_idcountries`),
  INDEX `fk_users_countries1_idx` (`countries_idcountries` ASC) ,
  CONSTRAINT `fk_users_countries1`
    FOREIGN KEY (`countries_idcountries`)
    REFERENCES `mannequin_db`.`countries` (`idcountries`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;