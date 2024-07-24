-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mi_bicing
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `mi_bicing` ;

-- -----------------------------------------------------
-- Schema mi_bicing
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mi_bicing` DEFAULT CHARACTER SET utf8 ;
USE `mi_bicing` ;

-- -----------------------------------------------------
-- Table `mi_bicing`.`CATEGORIA_BICI`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mi_bicing`.`CATEGORIA_BICI` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `Nom` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mi_bicing`.`DISTRICTES`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mi_bicing`.`DISTRICTES` (
  `id` INT NOT NULL,
  `nom_districte` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mi_bicing`.`ESTACIONS`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mi_bicing`.`ESTACIONS` (
  `id` INT NOT NULL,
  `nom` VARCHAR(100) NOT NULL,
  `lat` INT NOT NULL,
  `lon` INT NULL,
  `altitude` INT NULL,
  `postal_code` INT NULL,
  `enclatges` INT NULL,
  `districte_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_ESTACIONS_DISTRICTES1`
    FOREIGN KEY (`districte_id`)
    REFERENCES `mi_bicing`.`DISTRICTES` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- CREATE INDEX `fk_ESTACIONS_DISTRICTES1_idx` ON `mi_bicing`.`ESTACIONS` (`districte_id` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `mi_bicing`.`AVARIES`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mi_bicing`.`AVARIES` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nom` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mi_bicing`.`BICICLETES`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mi_bicing`.`BICICLETES` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `categoria_bici_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_BICICLETES_CATEGORIA_BICI1`
    FOREIGN KEY (`categoria_bici_id`)
    REFERENCES `mi_bicing`.`CATEGORIA_BICI` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- CREATE INDEX `fk_BICICLETES_CATEGORIA_BICI1_idx` ON `mi_bicing`.`BICICLETES` (`categoria_bici_id` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `mi_bicing`.`MANTENIMENT`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mi_bicing`.`MANTENIMENT` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `data_inici_reparacio` TIMESTAMP NOT NULL,
  `data_fi_reparacio` TIMESTAMP NULL,
  `avaria_id` INT NOT NULL,
  `bicicleta_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_MANTENIMENT_AVARIES`
    FOREIGN KEY (`avaria_id`)
    REFERENCES `mi_bicing`.`AVARIES` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_MANTENIMENT_BICICLETES1`
    FOREIGN KEY (`bicicleta_id`)
    REFERENCES `mi_bicing`.`BICICLETES` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- CREATE INDEX `fk_MANTENIMENT_AVARIES_idx` ON `mi_bicing`.`MANTENIMENT` (`avaria_id` ASC) VISIBLE;

-- CREATE INDEX `fk_MANTENIMENT_BICICLETES1_idx` ON `mi_bicing`.`MANTENIMENT` (`bicicleta_id` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `mi_bicing`.`TARIFES`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mi_bicing`.`TARIFES` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nom_tarifa` VARCHAR(45) NULL,
  `preu` INT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mi_bicing`.`USUARIS`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mi_bicing`.`USUARIS` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `dni_u` CHAR(10) NOT NULL,
  `nom` VARCHAR(100) NOT NULL,
  `cognom1` VARCHAR(100) NOT NULL,
  `cognom2` VARCHAR(100) NULL,
  `mail` VARCHAR(45) NOT NULL,
  `data_alta` DATE NULL,
  `compte_corrent` CHAR(20) NOT NULL,
  `tarifa_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_USUARIS_TARIFES1`
    FOREIGN KEY (`tarifa_id`)
    REFERENCES `mi_bicing`.`TARIFES` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- CREATE UNIQUE INDEX `dni_u_UNIQUE` ON `mi_bicing`.`USUARIS` (`dni_u` ASC) VISIBLE;

-- CREATE INDEX `fk_USUARIS_TARIFES1_idx` ON `mi_bicing`.`USUARIS` (`tarifa_id` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `mi_bicing`.`LLOGUER`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mi_bicing`.`LLOGUER` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `inici_lloguer` TIMESTAMP NOT NULL,
  `fi_lloguer` TIMESTAMP NULL,
  `estacio_origen_id` INT NOT NULL,
  `estacio_final_id` INT NULL,
  `tarifa_minutatge` DECIMAL(4,2) NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_LLOGUER_ESTACIONS1`
    FOREIGN KEY (`estacio_origen_id`)
    REFERENCES `mi_bicing`.`ESTACIONS` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- CREATE INDEX `fk_LLOGUER_ESTACIONS1_idx` ON `mi_bicing`.`LLOGUER` (`estacio_origen_id` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `mi_bicing`.`BICICLETES_has_LLOGUER`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mi_bicing`.`BICICLETES_has_LLOGUER` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `BICICLETES_id` INT NOT NULL,
  `LLOGUER_id` INT NOT NULL,
  `USUARIS_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_BICICLETES_has_LLOGUER_BICICLETES1`
    FOREIGN KEY (`BICICLETES_id`)
    REFERENCES `mi_bicing`.`BICICLETES` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_BICICLETES_has_LLOGUER_LLOGUER1`
    FOREIGN KEY (`LLOGUER_id`)
    REFERENCES `mi_bicing`.`LLOGUER` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_BICICLETES_has_LLOGUER_USUARIS1`
    FOREIGN KEY (`USUARIS_id`)
    REFERENCES `mi_bicing`.`USUARIS` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- CREATE INDEX `fk_BICICLETES_has_LLOGUER_LLOGUER1_idx` ON `mi_bicing`.`BICICLETES_has_LLOGUER` (`LLOGUER_id` ASC) VISIBLE;

-- CREATE INDEX `fk_BICICLETES_has_LLOGUER_BICICLETES1_idx` ON `mi_bicing`.`BICICLETES_has_LLOGUER` (`BICICLETES_id` ASC) VISIBLE;

-- CREATE INDEX `fk_BICICLETES_has_LLOGUER_USUARIS1_idx` ON `mi_bicing`.`BICICLETES_has_LLOGUER` (`USUARIS_id` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `mi_bicing`.`FACTURACIO`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mi_bicing`.`FACTURACIO` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `data_factura` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `cost_total` DECIMAL(8,2) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mi_bicing`.`PREU_LLOGUER`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mi_bicing`.`PREU_LLOGUER` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `lloguer_30_minuts` DECIMAL(4,2) NULL,
  `lloguer_30_120_minuts` DECIMAL(4,2) NULL,
  `lloguer_120_minuts` DECIMAL(4,2) NULL,
  `tarifa_id` INT NOT NULL,
  `categoria_bici_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_PREU_LLOGUER_TARIFES1`
    FOREIGN KEY (`tarifa_id`)
    REFERENCES `mi_bicing`.`TARIFES` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_PREU_LLOGUER_CATEGORIA_BICI1`
    FOREIGN KEY (`categoria_bici_id`)
    REFERENCES `mi_bicing`.`CATEGORIA_BICI` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- CREATE INDEX `fk_PREU_LLOGUER_TARIFES1_idx` ON `mi_bicing`.`PREU_LLOGUER` (`tarifa_id` ASC) VISIBLE;

-- CREATE INDEX `fk_PREU_LLOGUER_CATEGORIA_BICI1_idx` ON `mi_bicing`.`PREU_LLOGUER` (`categoria_bici_id` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `mi_bicing`.`BARRIS`
-- -----------------------------------------------------
/*
CREATE TABLE IF NOT EXISTS `mi_bicing`.`BARRIS` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `Nom` VARCHAR(100) NOT NULL,
  `DISTRICTES_id` INT NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;
*/

-- -----------------------------------------------------
-- Table `mi_bicing`.`CATEGORIA_PERSONAL`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mi_bicing`.`CATEGORIA_PERSONAL` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nom` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mi_bicing`.`SALARIS`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mi_bicing`.`SALARIS` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `sou` DECIMAL(8,2) NULL,
  `CATEGORIA_PERSONAL_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_SALARIS_CATEGORIA_PERSONAL1`
    FOREIGN KEY (`CATEGORIA_PERSONAL_id`)
    REFERENCES `mi_bicing`.`CATEGORIA_PERSONAL` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- CREATE INDEX `fk_SALARIS_CATEGORIA_PERSONAL1_idx` ON `mi_bicing`.`SALARIS` (`CATEGORIA_PERSONAL_id` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `mi_bicing`.`PERSONAL`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mi_bicing`.`PERSONAL` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `dni_p` CHAR(9) NOT NULL,
  `nom` VARCHAR(100) NOT NULL,
  `cognom1` VARCHAR(100) NOT NULL,
  `cognom2` VARCHAR(100) NULL,
  `compte_corrent` CHAR(20) NOT NULL,
  `districte_id` INT NOT NULL,
  `CATEGORIA_PERSONAL_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_PERSONAL_DISTRICTES1`
    FOREIGN KEY (`districte_id`)
    REFERENCES `mi_bicing`.`DISTRICTES` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_PERSONAL_CATEGORIA_PERSONAL1`
    FOREIGN KEY (`CATEGORIA_PERSONAL_id`)
    REFERENCES `mi_bicing`.`CATEGORIA_PERSONAL` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- CREATE UNIQUE INDEX `PERSONALcol_UNIQUE` ON `mi_bicing`.`PERSONAL` (`dni_p` ASC) VISIBLE;

-- CREATE INDEX `fk_PERSONAL_DISTRICTES1_idx` ON `mi_bicing`.`PERSONAL` (`districte_id` ASC) VISIBLE;

-- CREATE INDEX `fk_PERSONAL_CATEGORIA_PERSONAL1_idx` ON `mi_bicing`.`PERSONAL` (`CATEGORIA_PERSONAL_id` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `mi_bicing`.`NOMINES`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mi_bicing`.`NOMINES` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `data_nomina` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `salaris_id` INT NOT NULL,
  `PERSONAL_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_NOMINES_SALARIS1`
    FOREIGN KEY (`salaris_id`)
    REFERENCES `mi_bicing`.`SALARIS` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_NOMINES_PERSONAL1`
    FOREIGN KEY (`PERSONAL_id`)
    REFERENCES `mi_bicing`.`PERSONAL` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- CREATE INDEX `fk_NOMINES_SALARIS1_idx` ON `mi_bicing`.`NOMINES` (`salaris_id` ASC) VISIBLE;

-- CREATE INDEX `fk_NOMINES_PERSONAL1_idx` ON `mi_bicing`.`NOMINES` (`PERSONAL_id` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `mi_bicing`.`FACTURACIO_has_USUARIS`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mi_bicing`.`FACTURACIO_has_USUARIS` (
  `FACTURACIO_id` INT NOT NULL,
  `USUARIS_id` INT NOT NULL,
  PRIMARY KEY (`FACTURACIO_id`, `USUARIS_id`),
  CONSTRAINT `fk_FACTURACIO_has_USUARIS_FACTURACIO1`
    FOREIGN KEY (`FACTURACIO_id`)
    REFERENCES `mi_bicing`.`FACTURACIO` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_FACTURACIO_has_USUARIS_USUARIS1`
    FOREIGN KEY (`USUARIS_id`)
    REFERENCES `mi_bicing`.`USUARIS` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- CREATE INDEX `fk_FACTURACIO_has_USUARIS_USUARIS1_idx` ON `mi_bicing`.`FACTURACIO_has_USUARIS` (`USUARIS_id` ASC) VISIBLE;

-- CREATE INDEX `fk_FACTURACIO_has_USUARIS_FACTURACIO1_idx` ON `mi_bicing`.`FACTURACIO_has_USUARIS` (`FACTURACIO_id` ASC) VISIBLE;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- -----------------------------------------------------
-- Data for table `mi_bicing`.`CATEGORIA_BICI`
-- -----------------------------------------------------
START TRANSACTION;
USE `mi_bicing`;
INSERT INTO `mi_bicing`.`CATEGORIA_BICI` (`id`, `Nom`) VALUES (DEFAULT, 'Mecànica');
INSERT INTO `mi_bicing`.`CATEGORIA_BICI` (`id`, `Nom`) VALUES (DEFAULT, 'Elèctrica');

COMMIT;


-- -----------------------------------------------------
-- Data for table `mi_bicing`.`DISTRICTES`
-- -----------------------------------------------------
START TRANSACTION;
USE `mi_bicing`;
INSERT INTO `mi_bicing`.`DISTRICTES` (`id`, `nom_districte`) VALUES (01, 'Ciutat Vella');
INSERT INTO `mi_bicing`.`DISTRICTES` (`id`, `nom_districte`) VALUES (02, 'Eixample');
INSERT INTO `mi_bicing`.`DISTRICTES` (`id`, `nom_districte`) VALUES (03, 'Sants - Montjuic');
INSERT INTO `mi_bicing`.`DISTRICTES` (`id`, `nom_districte`) VALUES (04, 'Les Corts');
INSERT INTO `mi_bicing`.`DISTRICTES` (`id`, `nom_districte`) VALUES (05, 'Sarrià-Sant Gervasi');
INSERT INTO `mi_bicing`.`DISTRICTES` (`id`, `nom_districte`) VALUES (06, 'Gràcia');
INSERT INTO `mi_bicing`.`DISTRICTES` (`id`, `nom_districte`) VALUES (07, 'Horta-Guinardó');
INSERT INTO `mi_bicing`.`DISTRICTES` (`id`, `nom_districte`) VALUES (08, 'Nou Barris');
INSERT INTO `mi_bicing`.`DISTRICTES` (`id`, `nom_districte`) VALUES (09, 'Sant Andreu');
INSERT INTO `mi_bicing`.`DISTRICTES` (`id`, `nom_districte`) VALUES (10, 'Sant Martí');

COMMIT;


-- -----------------------------------------------------
-- Data for table `mi_bicing`.`TARIFES`
-- -----------------------------------------------------
START TRANSACTION;
USE `mi_bicing`;
INSERT INTO `mi_bicing`.`TARIFES` (`id`, `nom_tarifa`, `preu`) VALUES (DEFAULT, 'Plana', 50);
INSERT INTO `mi_bicing`.`TARIFES` (`id`, `nom_tarifa`, `preu`) VALUES (DEFAULT, 'Per ús', 35);

COMMIT;


-- -----------------------------------------------------
-- Data for table `mi_bicing`.`PREU_LLOGUER`
-- -----------------------------------------------------
START TRANSACTION;
USE `mi_bicing`;
INSERT INTO `mi_bicing`.`PREU_LLOGUER` (`id`, `lloguer_30_minuts`, `lloguer_30_120_minuts`, `lloguer_120_minuts`, `tarifa_id`, `categoria_bici_id`) VALUES (DEFAULT, 0, 0.70, 5.00, 1, 1);
INSERT INTO `mi_bicing`.`PREU_LLOGUER` (`id`, `lloguer_30_minuts`, `lloguer_30_120_minuts`, `lloguer_120_minuts`, `tarifa_id`, `categoria_bici_id`) VALUES (DEFAULT, 0.35, 0.90, 5.00, 1, 2);
INSERT INTO `mi_bicing`.`PREU_LLOGUER` (`id`, `lloguer_30_minuts`, `lloguer_30_120_minuts`, `lloguer_120_minuts`, `tarifa_id`, `categoria_bici_id`) VALUES (DEFAULT, 0.35, 0.70, 5.00, 2, 1);
INSERT INTO `mi_bicing`.`PREU_LLOGUER` (`id`, `lloguer_30_minuts`, `lloguer_30_120_minuts`, `lloguer_120_minuts`, `tarifa_id`, `categoria_bici_id`) VALUES (DEFAULT, 0.55, 0.90, 5.00, 2, 2);

COMMIT;


-- -----------------------------------------------------
-- Data for table `mi_bicing`.`BARRIS`
-- -----------------------------------------------------
/*
START TRANSACTION;
USE `mi_bicing`;
INSERT INTO `mi_bicing`.`BARRIS` (`id`, `Nom`, `DISTRICTES_id`) VALUES (id, 'nom_barri', codi_districte);
INSERT INTO `mi_bicing`.`BARRIS` (`id`, `Nom`, `DISTRICTES_id`) VALUES (1, 'el Raval', 1);
INSERT INTO `mi_bicing`.`BARRIS` (`id`, `Nom`, `DISTRICTES_id`) VALUES (2, 'el Barri Gòtic', 1);
INSERT INTO `mi_bicing`.`BARRIS` (`id`, `Nom`, `DISTRICTES_id`) VALUES (3, 'la Barceloneta', 1);
INSERT INTO `mi_bicing`.`BARRIS` (`id`, `Nom`, `DISTRICTES_id`) VALUES (4, 'Sant Pere, Santa Caterina i la Ribera', 1);
INSERT INTO `mi_bicing`.`BARRIS` (`id`, `Nom`, `DISTRICTES_id`) VALUES (5, 'el Fort Pienc', 2);
INSERT INTO `mi_bicing`.`BARRIS` (`id`, `Nom`, `DISTRICTES_id`) VALUES (6, 'la Sagrada Família', 2);
INSERT INTO `mi_bicing`.`BARRIS` (`id`, `Nom`, `DISTRICTES_id`) VALUES (7, 'la Dreta de l\'Eixample', 2);
INSERT INTO `mi_bicing`.`BARRIS` (`id`, `Nom`, `DISTRICTES_id`) VALUES (8, 'l\'Antiga Esquerra de l\'Eixample', 2);
INSERT INTO `mi_bicing`.`BARRIS` (`id`, `Nom`, `DISTRICTES_id`) VALUES (9, 'la Nova Esquerra de l\'Eixample', 2);
INSERT INTO `mi_bicing`.`BARRIS` (`id`, `Nom`, `DISTRICTES_id`) VALUES (10, 'Sant Antoni', 2);
INSERT INTO `mi_bicing`.`BARRIS` (`id`, `Nom`, `DISTRICTES_id`) VALUES (11, 'el Poble-sec', 3);
INSERT INTO `mi_bicing`.`BARRIS` (`id`, `Nom`, `DISTRICTES_id`) VALUES (12, 'la Marina del Prat Vermell', 3);
INSERT INTO `mi_bicing`.`BARRIS` (`id`, `Nom`, `DISTRICTES_id`) VALUES (13, 'la Marina de Port', 3);
INSERT INTO `mi_bicing`.`BARRIS` (`id`, `Nom`, `DISTRICTES_id`) VALUES (14, 'la Font de la Guatlla', 3);
INSERT INTO `mi_bicing`.`BARRIS` (`id`, `Nom`, `DISTRICTES_id`) VALUES (15, 'Hostafrancs', 3);
INSERT INTO `mi_bicing`.`BARRIS` (`id`, `Nom`, `DISTRICTES_id`) VALUES (16, 'la Bordeta', 3);
INSERT INTO `mi_bicing`.`BARRIS` (`id`, `Nom`, `DISTRICTES_id`) VALUES (17, 'Sants - Badal', 3);
INSERT INTO `mi_bicing`.`BARRIS` (`id`, `Nom`, `DISTRICTES_id`) VALUES (18, 'Sants', 3);
INSERT INTO `mi_bicing`.`BARRIS` (`id`, `Nom`, `DISTRICTES_id`) VALUES (19, 'les Corts', 4);
INSERT INTO `mi_bicing`.`BARRIS` (`id`, `Nom`, `DISTRICTES_id`) VALUES (20, 'la Maternitat i Sant Ramon', 4);
INSERT INTO `mi_bicing`.`BARRIS` (`id`, `Nom`, `DISTRICTES_id`) VALUES (21, 'Pedralbes', 4);
INSERT INTO `mi_bicing`.`BARRIS` (`id`, `Nom`, `DISTRICTES_id`) VALUES (22, 'Vallvidrera, el Tibidabo i les Planes', 5);
INSERT INTO `mi_bicing`.`BARRIS` (`id`, `Nom`, `DISTRICTES_id`) VALUES (23, 'Sarrià', 5);
INSERT INTO `mi_bicing`.`BARRIS` (`id`, `Nom`, `DISTRICTES_id`) VALUES (24, 'les Tres Torres', 5);
INSERT INTO `mi_bicing`.`BARRIS` (`id`, `Nom`, `DISTRICTES_id`) VALUES (25, 'Sant Gervasi - la Bonanova', 5);
INSERT INTO `mi_bicing`.`BARRIS` (`id`, `Nom`, `DISTRICTES_id`) VALUES (26, 'Sant Gervasi - Galvany', 5);
INSERT INTO `mi_bicing`.`BARRIS` (`id`, `Nom`, `DISTRICTES_id`) VALUES (27, 'el Putxet i el Farró', 5);
INSERT INTO `mi_bicing`.`BARRIS` (`id`, `Nom`, `DISTRICTES_id`) VALUES (28, 'Vallcarca i els Penitents', 6);
INSERT INTO `mi_bicing`.`BARRIS` (`id`, `Nom`, `DISTRICTES_id`) VALUES (29, 'el Coll', 6);
INSERT INTO `mi_bicing`.`BARRIS` (`id`, `Nom`, `DISTRICTES_id`) VALUES (30, 'la Salut', 6);
INSERT INTO `mi_bicing`.`BARRIS` (`id`, `Nom`, `DISTRICTES_id`) VALUES (31, 'la Vila de Gràcia', 6);
INSERT INTO `mi_bicing`.`BARRIS` (`id`, `Nom`, `DISTRICTES_id`) VALUES (32, 'el Camp d\'en Grassot i Gràcia Nova', 6);
INSERT INTO `mi_bicing`.`BARRIS` (`id`, `Nom`, `DISTRICTES_id`) VALUES (33, 'el Baix Guinardó', 7);
INSERT INTO `mi_bicing`.`BARRIS` (`id`, `Nom`, `DISTRICTES_id`) VALUES (34, 'Can Baró', 7);
INSERT INTO `mi_bicing`.`BARRIS` (`id`, `Nom`, `DISTRICTES_id`) VALUES (35, 'el Guinardó', 7);
INSERT INTO `mi_bicing`.`BARRIS` (`id`, `Nom`, `DISTRICTES_id`) VALUES (36, 'la Font d\'en Fargues', 7);
INSERT INTO `mi_bicing`.`BARRIS` (`id`, `Nom`, `DISTRICTES_id`) VALUES (37, 'el Carmel', 7);
INSERT INTO `mi_bicing`.`BARRIS` (`id`, `Nom`, `DISTRICTES_id`) VALUES (38, 'la Teixonera', 7);
INSERT INTO `mi_bicing`.`BARRIS` (`id`, `Nom`, `DISTRICTES_id`) VALUES (39, 'Sant Genís dels Agudells', 7);
INSERT INTO `mi_bicing`.`BARRIS` (`id`, `Nom`, `DISTRICTES_id`) VALUES (40, 'Montbau', 7);
INSERT INTO `mi_bicing`.`BARRIS` (`id`, `Nom`, `DISTRICTES_id`) VALUES (41, 'la Vall d\'Hebron', 7);
INSERT INTO `mi_bicing`.`BARRIS` (`id`, `Nom`, `DISTRICTES_id`) VALUES (42, 'la Clota', 7);
INSERT INTO `mi_bicing`.`BARRIS` (`id`, `Nom`, `DISTRICTES_id`) VALUES (43, 'Horta', 7);
INSERT INTO `mi_bicing`.`BARRIS` (`id`, `Nom`, `DISTRICTES_id`) VALUES (44, 'Vilapicina i la Torre Llobeta', 8);
INSERT INTO `mi_bicing`.`BARRIS` (`id`, `Nom`, `DISTRICTES_id`) VALUES (45, 'Porta', 8);
INSERT INTO `mi_bicing`.`BARRIS` (`id`, `Nom`, `DISTRICTES_id`) VALUES (46, 'el Turó de la Peira', 8);
INSERT INTO `mi_bicing`.`BARRIS` (`id`, `Nom`, `DISTRICTES_id`) VALUES (47, 'Can Peguera', 8);
INSERT INTO `mi_bicing`.`BARRIS` (`id`, `Nom`, `DISTRICTES_id`) VALUES (48, 'la Guineueta', 8);
INSERT INTO `mi_bicing`.`BARRIS` (`id`, `Nom`, `DISTRICTES_id`) VALUES (49, 'Canyelles', 8);
INSERT INTO `mi_bicing`.`BARRIS` (`id`, `Nom`, `DISTRICTES_id`) VALUES (50, 'les Roquetes', 8);
INSERT INTO `mi_bicing`.`BARRIS` (`id`, `Nom`, `DISTRICTES_id`) VALUES (51, 'Verdun', 8);
INSERT INTO `mi_bicing`.`BARRIS` (`id`, `Nom`, `DISTRICTES_id`) VALUES (52, 'la Prosperitat', 8);
INSERT INTO `mi_bicing`.`BARRIS` (`id`, `Nom`, `DISTRICTES_id`) VALUES (53, 'la Trinitat Nova', 8);
INSERT INTO `mi_bicing`.`BARRIS` (`id`, `Nom`, `DISTRICTES_id`) VALUES (54, 'Torre Baró', 8);
INSERT INTO `mi_bicing`.`BARRIS` (`id`, `Nom`, `DISTRICTES_id`) VALUES (55, 'Ciutat Meridiana', 8);
INSERT INTO `mi_bicing`.`BARRIS` (`id`, `Nom`, `DISTRICTES_id`) VALUES (56, 'Vallbona', 8);
INSERT INTO `mi_bicing`.`BARRIS` (`id`, `Nom`, `DISTRICTES_id`) VALUES (57, 'la Trinitat Vella', 9);
INSERT INTO `mi_bicing`.`BARRIS` (`id`, `Nom`, `DISTRICTES_id`) VALUES (58, 'Baró de Viver', 9);
INSERT INTO `mi_bicing`.`BARRIS` (`id`, `Nom`, `DISTRICTES_id`) VALUES (59, 'el Bon Pastor', 9);
INSERT INTO `mi_bicing`.`BARRIS` (`id`, `Nom`, `DISTRICTES_id`) VALUES (60, 'Sant Andreu', 9);
INSERT INTO `mi_bicing`.`BARRIS` (`id`, `Nom`, `DISTRICTES_id`) VALUES (61, 'la Sagrera', 9);
INSERT INTO `mi_bicing`.`BARRIS` (`id`, `Nom`, `DISTRICTES_id`) VALUES (62, 'el Congrés i els Indians', 9);
INSERT INTO `mi_bicing`.`BARRIS` (`id`, `Nom`, `DISTRICTES_id`) VALUES (63, 'Navas', 9);
INSERT INTO `mi_bicing`.`BARRIS` (`id`, `Nom`, `DISTRICTES_id`) VALUES (64, 'el Camp de l\'Arpa del Clot', 10);
INSERT INTO `mi_bicing`.`BARRIS` (`id`, `Nom`, `DISTRICTES_id`) VALUES (65, 'el Clot', 10);
INSERT INTO `mi_bicing`.`BARRIS` (`id`, `Nom`, `DISTRICTES_id`) VALUES (66, 'el Parc i la Llacuna del Poblenou', 10);
INSERT INTO `mi_bicing`.`BARRIS` (`id`, `Nom`, `DISTRICTES_id`) VALUES (67, 'la Vila Olímpica del Poblenou', 10);
INSERT INTO `mi_bicing`.`BARRIS` (`id`, `Nom`, `DISTRICTES_id`) VALUES (68, 'el Poblenou', 10);
INSERT INTO `mi_bicing`.`BARRIS` (`id`, `Nom`, `DISTRICTES_id`) VALUES (69, 'Diagonal Mar i el Front Marítim del Poblenou', 10);
INSERT INTO `mi_bicing`.`BARRIS` (`id`, `Nom`, `DISTRICTES_id`) VALUES (70, 'el Besós i el Maresme', 10);
INSERT INTO `mi_bicing`.`BARRIS` (`id`, `Nom`, `DISTRICTES_id`) VALUES (71, 'Provençals del Poblenou', 10);
INSERT INTO `mi_bicing`.`BARRIS` (`id`, `Nom`, `DISTRICTES_id`) VALUES (72, 'Sant Martí­ de Provençals', 10);
INSERT INTO `mi_bicing`.`BARRIS` (`id`, `Nom`, `DISTRICTES_id`) VALUES (73, 'la Verneda i la Pau', 10);

COMMIT;
*/

-- Insert estacions
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (1, "GRAN VIA CORTS CATALANES, 760", 413979779, 21801069, 16, 8013, 46, 2);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (2, "C/ ROGER DE FLOR, 126", 413954877, 21771985, 17, 8013, 29, 2);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (3, "C/ NÀPOLS, 82", 413941557, 21813305, 11, 8013, 27, 2);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (4, "C/ RIBES, 13", 413933173, 21812483, 8, 8013, 21, 2);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (5, "PG. LLUIS COMPANYS, 11 (ARC TRIOMF)", 413911035, 21801763, 7, 8018, 39, 10);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (6, "PG. LLUIS COMPANYS, 18 (ARC TRIOMF)", 413914292, 21805685, 10, 8018, 39, 10);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (7, "PG. PUJADES,  1 (JUTJATS)", 41388885, 218329, 6, 8003, 27, 1);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (8, "PG. PUJADES, 2", 41389135, 2183489, 6, 8003, 26, 1);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (9, "AV. MARQUÉS DE L'ARGENTERA,13", 41384546, 2184922, 5, 8003, 27, 1);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (10, "C/ 60, NÚMERO 25", 413467746, 21436235, 4, 8040, 42, 3);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (11, "PG. MARITIM, 11 (DAVANT PL. BRUGADA)", 413812425, 21933482, 7, 8003, 35, 1);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (12, "PG. MARITIM, 23 (HOSPITAL DEL MAR)", 413833653, 21946255, 7, 8003, 26, 1);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (13, "C/ MARINA, 25-33", 41388143, 2195551, 7, 8005, 54, 10);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (14, "AV. MARQUÉS DE  L'ARGENTERA, 15", 41384844, 2185085, 5, 8003, 27, 1);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (15, "C/ DIPUTACIÓ, 272", 413916000000000, 216890000000000, 25, 8009, 27, 2);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (17, "AV. MERIDIANA, 47 (D)", 413982615, 21866517, 14, 8013, 42, 2);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (18, "C/ ROSSELLÓ, 453", 414060589, 21740472, 38, 8025, 27, 2);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (19, "C/ ROSSELLÓ, 354", 414031491, 21707947, 40, 8025, 30, 2);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (20, "C/ CARTAGENA, 308", 41410314, 21757334, 46, 8025, 18, 2);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (21, "C/ SANT ANTONI MARIA CLARET, 214", 414108439, 21740575, 52, 8025, 21, 2);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (22, "C/ SARDENYA, 292", 414016969, 2175767, 28, 8013, 19, 2);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (23, "C/ BRUC, 45", 413924661, 21717397, 21, 8010, 27, 2);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (24, "C/ MARINA, 199", 414005784, 21788855, 23, 8013, 40, 2);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (25, "C/ BRUC, 102", 413954041, 21681961, 29, 8009, 21, 2);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (26, "C/ DOS DE MAIG, 230-232", 414071692, 21820722, 22, 8013, 18, 2);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (27, "C/ PROVENÇA, 322", 413967524, 21646338, 38, 8037, 21, 2);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (28, "C/ SARDENYA, 362", 414055143, 21706498, 46, 8025, 23, 2);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (29, "C/ PROVENÇA, 388-390", 41401061, 2169941, 34, 8025, 23, 2);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (30, "C/ CASTILLEJOS, 184", 414021805, 21829894, 13, 8013, 29, 2);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (31, "PL. DEL MAR", 413748001, 21889045, 4, 8003, 18, 1);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (32, "LA BARCELONETA (CN BARCELONETA)", 413736911, 2188928, 4, 8003, 15, 1);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (33, "C/ PONTEVEDRA, 58B | C/ JUDICI", 4137686, 219067, 4, 8003, 21, 1);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (34, "C/ SANT PERE MÉS ALT, 4", 413871079, 21753364, 9, 8003, 21, 1);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (35, "C/ SANT RAMON DE PENYAFORT, 1", 414134833, 22206913, 5, 8930, 54, 10);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (36, "AV. DE LA CATEDRAL, 6", 413850616, 21766834, 8, 8002, 21, 1);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (37, "PG. DE COLOM - VIA LAIETANA", 41380624, 21820675, 4, 8002, 24, 1);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (39, "PL. PAU VILA (D)", 41381046, 2186576, 4, 8039, 44, 3);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (40, "C/ DOCTOR AIGUADER, 2", 41382335, 2187093, 6, 8039, 18, 3);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (41, "PL. POETA BOSCÀ | C/ ATLÀNTIDA", 41379326, 2189906, 5, 8003, 25, 1);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (42, "C/ CIUTAT DE GRANADA, 168 | AV. DIAGONAL", 41404511, 2189881, 4, 8018, 24, 10);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (43, "C/ CLOT, 1", 414063864, 21874404, 13, 8018, 27, 10);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (44, "AV. MERIDIANA, 66", 4140197, 2187081, 16, 8018, 17, 10);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (45, "C/ SARDENYA, 66", 41391466, 2189371, 5, 8005, 27, 10);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (46, "C/ VILLENA, 1", 413886000000000, 219219000000000, 7, 8005, 54, 10);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (47, "C/ RAMON TRIAS FARGAS, 21", 413902194, 21904003, 5, 8005, 47, 10);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (48, "AV. MERIDIANA, 40", 413960652, 21871959, 11, 8018, 21, 10);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (49, "C/ ROSA SENSAT, 20", 413910756, 21965766, 5, 8005, 21, 10);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (50, "AV. PARAL.LEL, 54", 413751145, 21709386, 8, 8004, 18, 3);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (51, "PL. VICENÇ MARTORELL", 413842634, 21692556, 12, 8001, 20, 1);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (52, "PL. SANT MIQUEL, 4", 41381708, 2177292, 11, 8002, 32, 1);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (53, "PL. CARLES PI I SUNYER", 41385086, 2174016, 10, 8002, 21, 1);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (54, "C/ SANT OLEGUER, 2", 413775319, 21707321, 6, 8001, 18, 1);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (55, "LA RAMBLA, 80", 413811923, 21735007, 8, 8002, 19, 1);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (56, "PORTAL DE SANTA MADRONA, 2-4", 413770715, 21758261, 5, 8001, 27, 1);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (57, "LA RAMBLA, 2 (MUSEO DE CERA)", 41377187, 2176757, 4, 8002, 25, 1);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (58, "PLAÇA DELS ÀNGELS (MACBA)", 4138268, 216712, 11, 8001, 43, 1);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (60, "RBLA. CATALUNYA, 47", 413902625, 2164035, 27, 8007, 27, 2);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (61, "C/ ARAGÓ, 288", 4139352, 2166797, 26, 8009, 20, 2);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (62, "PL. CATALUNYA, 5", 41387235, 2168819, 19, 8002, 25, 1);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (63, "PL. CATALUNYA, 7", 41386543, 2169427, 19, 8002, 26, 1);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (64, "PL. CATALUNYA, 10-11 (LA RAMBLA)", 41387493, 21690686, 21, 8002, 21, 1);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (65, "PL. CATALUNYA, 10-11 (PG. DE GRÀCIA)", 41387696, 21696543, 20, 8002, 21, 1);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (66, "GRAN VIA DE LES CORTS CATALANES, 609", 413893222, 21678388, 23, 8007, 16, 2);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (67, "C/ ROCAFORT, 214 | C/ ROSSELLÓ", 413852864, 21454802, 37, 8029, 24, 2);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (68, "RAMBLA CATALUNYA, 133 /  CÒRSEGA", 413953894, 21572953, 44, 8008, 27, 2);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (69, "CARRER DE LA MARINA,25-33", 41388507, 2195073, 7, 8005, 42, 10);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (70, "C/ COMTE URGELL, 23", 41380393, 21606506, 15, 8011, 27, 2);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (71, "C/ FLORIDABLANCA, 145", 413819459, 21629146, 16, 8011, 21, 2);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (72, "C/ PROVENÇA, 215", 413927771, 21586273, 37, 8008, 27, 2);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (73, "C/ ENRIC GRANADOS, 93", 41392135, 21563542, 39, 8008, 26, 2);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (74, "AV. JOSEP TARRADELLAS, 133", 413900085, 21432105, 47, 8029, 15, 2);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (75, "AV. JOSEP TARRADELLAS, 58", 41385004, 21429115, 40, 8029, 21, 2);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (76, "C/ CÒRSEGA, 216", 413917666, 21532163, 40, 8036, 32, 2);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (77, "AV. FRANCESC CAMBÓ, 10", 413855644, 21773214, 8, 8003, 24, 1);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (78, "PL. UNIVERSITAT /  ARIBAU", 413856474, 21634306, 21, 8011, 27, 2);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (79, "PL.  UNIVERSITAT", 41385503, 21634768, 21, 8007, 24, 2);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (80, "C/ ENRIC  GRANADOS, 35", 41389668, 21599078, 31, 8007, 21, 2);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (81, "C/ VILAMARÍ,  61", 413790718, 21490553, 24, 8015, 21, 2);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (82, "C/ CALÀBRIA, 112", 413803000000000, 21544400000000, 20, 8015, 40, 2);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (83, "C/ CALABRIA, 158", 413821658, 21520645, 25, 8015, 22, 2);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (84, "C/ DEL COMTE D'URGELL, 75 B", 413830299, 21571646, 20, 8011, 26, 2);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (85, "AV. PARAL·LEL, 146 BIS", 413751852, 21592394, 15, 8015, 40, 2);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (86, "C/ VILADOMAT,  2", 413755747, 21629349, 12, 8015, 27, 2);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (87, "C/ ROCAFORT, 187", 413832000000000, 214799000000000, 29, 8029, 25, 2);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (88, "C/ LONDRES, 101-103", 413936144, 21507739, 45, 8036, 20, 2);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (89, "C/ ROSSELLÓ,  101", 413879131, 2150342, 36, 8036, 27, 2);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (90, "C/ ROSSELLÓ, 108-110", 41388296, 2150878, 36, 8036, 18, 2);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (91, "C/ COMTE D'URGELL, 43", 413812504, 21594741, 16, 8011, 35, 2);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (92, "C / PROVENÇA, 241", 413938861, 21601641, 37, 8008, 17, 2);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (94, "GRAN VIA DE LES CORTS CATALANES,375", 413757914, 21499102, 26, 8015, 48, 2);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (95, "C/ TARRAGONA, 103-115", 413763948, 21473272, 28, 8014, 33, 3);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (96, "GRAN VIA DE LES CORTS CATALANES,  368", 413741093, 21481993, 24, 8010, 21, 2);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (97, "C/ TARRAGONA, 141", 413779613, 21450491, 29, 8014, 21, 3);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (98, "C/ VIRIAT, 43", 413806074, 21408633, 31, 8014, 21, 3);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (99, "C/ VIRIAT,  53", 413808222, 2141539, 30, 8014, 21, 3);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (100, "C/ TARRAGONA,  159-173", 413787064, 21443579, 29, 8014, 22, 3);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (101, "AV. DIAGONAL,  602", 41392878, 2143411, 53, 8021, 24, 5);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (102, "AV. DIAGONAL,  612", 41392567, 21422174, 54, 8021, 24, 5);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (103, "C/ ARAGÓ, 629", 41410098, 21884487, 16, 8026, 21, 10);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (104, "C/ VALÈNCIA,  621", 414108005, 21872438, 16, 8026, 26, 10);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (105, "RDA. DE SANT PERE, 26", 41389492, 217425, 15, 8010, 21, 2);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (106, "PL  JOANIC - C / BRUNIQUER, 59", 414055198, 21622548, 56, 8024, 20, 6);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (107, "TRAV. DE GRÀCIA, 92 / VIA AUGUSTA", 413982304, 21531031, 56, 8006, 20, 5);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (108, "C / INDÚSTRIA, 10", 414022081, 21649035, 45, 8037, 21, 2);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (109, "C/ LONDRES,  53", 413912605, 21476308, 43, 8036, 23, 2);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (110, "AV. ROMA,  136", 413852585, 2155089, 25, 8011, 21, 2);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (111, "C/ ARAGÓN 147", 413847528, 21546746, 21, 8015, 19, 2);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (112, "C/ FLORIDABLANCA,  49", 413776721, 2157233, 13, 8015, 20, 2);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (113, "RONDA DE SANT PAU , 51", 413773113, 21646742, 11, 8015, 33, 2);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (114, "PL. JEAN GENET,  1", 41376735, 21740082, 5, 8001, 20, 1);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (115, "AV. MARQUÉS DE L'ARGENTERA,  3", 41383597, 2184171, 4, 8003, 21, 1);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (116, "C/ DEL DR. AIGUADER, 72 / PG. SALVAT", 413838369, 21914756, 5, 8003, 27, 1);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (117, "C/ ROSA SENSAT, 12", 413906051, 21972309, 5, 8005, 21, 10);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (118, "C/ PUJADES,  3", 4139212, 21874966, 6, 8018, 27, 10);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (119, "C/ SARDENYA,  178", 413967169, 21825085, 12, 8013, 39, 2);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (120, "C/ LEPANT,  278", 414047056, 21765126, 28, 8013, 21, 2);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (121, "C/ CASTILLEJOS, 258", 414064529, 21785364, 28, 8013, 21, 2);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (122, "C/ NÀPOLS, 344", 414054458, 21663172, 54, 8025, 33, 2);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (123, "C/ PROVENÇA, 317", 413988000000000, 216674000000000, 34, 8037, 21, 2);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (124, "C/ NOVA  BOCANA", 413702483, 21878126, 3, 8039, 31, 3);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (125, "PG. MARíTIM, 31 B (ANNEXA A LA  12)", 413834753, 2194735, 7, 8003, 21, 1);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (126, "PG. DE COLOM /VIA LAIETANA", 41380628, 21822815, 4, 8002, 23, 1);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (127, "C/ ARAGÓ, 659 / NAVAS DE TOLOSA", 414120681, 21907524, 16, 8026, 27, 10);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (128, "RAMBLA DE GUIPÚSCOA, 43/FLUVIÀ", 414158412, 21959771, 10, 8020, 43, 10);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (129, "C/ MANSO, 46", 41377046, 216113608, 13, 8015, 23, 2);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (130, "RAMBLA DE GUIPÚSCOA, 103 / CANTÀBRIA", 414200135, 22016699, 8, 8020, 24, 10);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (131, "RAMBLA  DE GUIPÚSCOA, 158/ CA N'OLIVA", 414227912, 22060317, 11, 8020, 29, 10);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (132, "PL. VALENTÍ ALMIRALL", 414084796, 2192042, 6, 8018, 27, 10);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (133, "GRAN VIA DE LES CORTS CATALANES,  902", 414075013, 21930174, 6, 8018, 16, 10);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (134, "C/ BAC DE RODA, 157", 414113024, 21987258, 6, 8018, 21, 10);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (135, "GRAN VIA DE LES CORTS CATALANES,  981", 414120452, 21972673, 8, 8018, 21, 10);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (136, "GRAN VIA DE LES CORTS CATALANES,  1062", 414139298, 22017955, 8, 8020, 31, 10);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (137, "GRAN VIA DE LES CORTS CATALANES , 1041", 414145805, 22008139, 7, 8020, 25, 10);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (138, "GRAN VIA DE LES CORTS CATALANES,  1118", 414167933, 22058345, 7, 8020, 21, 10);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (139, "GRAN VIA DE LES CORTS CATALANES,  1131", 414183999, 22058133, 7, 8020, 35, 10);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (140, "C/ VILADOMAT,  122", 413808772, 21559939, 19, 8015, 27, 2);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (141, "C/ BILBAO, 174", 414090202, 21954152, 7, 8018, 32, 10);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (142, "C/ SANCHO DE ÁVILA,  104 - C/ BADAJOZ", 414003793, 21924144, 4, 8018, 32, 10);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (143, "C/ SANCHO DE ÁVILA, 170 / LLACUNA", 414027907, 21956161, 4, 8018, 26, 10);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (144, "C/ CASTELLA,  28 / DIAGONAL", 414056269, 21977119, 4, 8018, 27, 10);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (145, "C/ PERE IV,  301 / FLUVIÀ", 414093405, 22024461, 4, 8020, 27, 10);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (146, "C/ PERE IV, 488", 414148983, 2207186, 4, 8019, 24, 10);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (147, "RAMBLA PRIM, 79", 41416043, 22124993, 5, 8019, 33, 10);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (148, "RONDA SANT PAU, 79", 413783467, 21633139, 12, 8015, 27, 2);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (149, "C/ PUJADES, 57B", 413958685, 2192952, 4, 8019, 27, 10);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (150, "C/ ESPRONCEDA, 124", 414065912, 2203028, 4, 8005, 27, 10);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (151, "C/ PALLARS, 182", 414003471, 21969105, 3, 8005, 27, 10);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (152, "C/ PUJADES, 121", 413993329, 21974184, 3, 8005, 27, 10);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (153, "C/ PUJADES, 173/RBLA POBLE NOU", 414018686, 220077, 3, 8005, 22, 10);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (154, "C/ PUJADES, 191", 414026275, 22017694, 2, 8005, 32, 10);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (155, "C/ PUJADES, 311/ FLUVIÀ", 414070139, 22074469, 4, 8019, 32, 10);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (157, "C/ LLULL, 465", 414132316, 22177652, 4, 8019, 33, 10);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (158, "RAMBLA DE PRIM, 19", 414116634, 22183313, 4, 8019, 27, 10);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (159, "AV. DIAGONAL, 26", 414110822, 22163136, 4, 8019, 32, 10);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (160, "AV. D'EDUARD MARISTANY, 1 /FORUM", 414109763, 22193724, 4, 8019, 33, 10);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (161, "C/ RAMON TURRÓ, 91", 413953011, 21965965, 4, 8005, 27, 10);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (162, "C/ RAMON TURRÓ, 292", 414038559, 22084257, 3, 8005, 26, 10);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (163, "AV. ICÀRIA, 202", 413942108, 22008756, 3, 8005, 26, 10);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (164, "C/ INDEPENDÈNCIA, 379", 414118378, 21778852, 46, 8026, 27, 10);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (165, "C/ DEL DOCTOR TRUETA, 222", 413992169, 22041415, 3, 8005, 27, 10);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (166, "C/ BILBAO, 2", 414008312, 2206645, 3, 8005, 27, 10);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (167, "C/ BAC DE RODA, 11", 414023354, 22105777, 3, 8005, 21, 10);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (168, "SELVA DE MAR / PG. DEL TAULAT", 414053697, 22135818, 5, 8019, 26, 10);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (170, "AV. LITORAL, 40 (D)", 413896642, 21999572, 6, 8005, 54, 10);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (171, "AV. LITORAL, 172", 413919877, 22037136, 5, 8005, 53, 10);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (173, "AV.LITORAL, 84", 413979002, 22088454, 8, 8005, 27, 10);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (174, "PG. DE GARCIA FÀRIA, 21/ESPRONCEDA", 41400654, 2210191, 6, 8005, 27, 10);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (175, "C/ LLULL, 309", 414065291, 22091221, 4, 8019, 27, 10);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (176, "PG. DE GARCIA FÀRIA, 37/JOSEP FERRATER", 41403216, 22136, 6, 8019, 31, 10);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (177, "C/ ROSSELLÓ, 557", 414110754, 21809764, 33, 8026, 34, 10);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (178, "PG. DE GARCIA FÀRIA, 85", 414053649, 22162094, 7, 8019, 27, 10);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (179, "PG. ZONA FRANCA, 244", 4136352, 21369015, 9, 8038, 16, 3);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (180, "GRAN VIA DE LES CORTS CATALANES, 179 (D)", 413675574, 21388216, 14, 8014, 50, 3);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (182, "C/ SANT PERE D´ABANTO, 2", 41371366, 2143565, 18, 8014, 33, 3);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (183, "C/ GAVÀ, 1", 413723682, 21419494, 18, 8014, 30, 3);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (184, "C/ QUETZAL, 22-24", 413675438, 21342316, 22, 8014, 27, 3);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (185, "C/GAVÀ, 81", 413703717, 21389439, 20, 8014, 17, 3);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (186, "C/CONSELL DE CENT, 6", 413755503, 21439036, 27, 8014, 26, 3);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (187, "C/ DE SANT PAU, 89 - 97", 413768806, 21698206, 5, 8001, 19, 1);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (188, "PG. SANT ANTONI /PL. SANTS", 413756948, 21358571, 30, 8014, 27, 3);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (189, "C/ BRUC, 130", 413969839, 21661852, 34, 8037, 28, 2);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (190, "AV. LITORAL, 72", 413961412, 22078439, 6, 8005, 29, 10);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (191, "C/ ENTENÇA, 137", 41381951, 2147474, 15, 8015, 37, 2);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (192, "C/ JOAN GÜELL, 50", 413786364, 21335494, 33, 8028, 21, 4);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (193, "C/ FÍGOLS, 1", 413812979, 21289917, 41, 8028, 27, 4);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (194, "C/ JOAN GÜELL, 98", 413812001, 21323612, 38, 8028, 24, 4);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (195, "C/ VALLESPIR, 130", 413821371, 21354149, 38, 8014, 27, 3);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (196, "C/ BERLÍN, 38", 413832609, 21392662, 38, 8029, 27, 2);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (197, "C/ GELABERT, 1", 413871579, 21410945, 47, 8029, 27, 2);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (198, "C/ VALLESPIR, 194", 413847113, 21334379, 48, 8014, 27, 3);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (199, "C/ MEJÍA LEQUERICA, 2", 413819739, 21268625, 47, 8028, 27, 4);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (200, "C/ JOAN GÜELL, 174", 413839045, 21312876, 47, 8028, 23, 4);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (201, "C/ NUMÀNCIA, 136", 413878061, 21344218, 55, 8029, 24, 2);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (202, "C/ DE LES CORTS, 20", 413854466, 21288753, 52, 8028, 27, 4);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (203, "AV. DIAGONAL, 668", 413887069, 21285766, 64, 8034, 33, 4);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (204, "AV. DIAGONAL, 672", 413880355, 21256248, 63, 8034, 33, 4);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (205, "C/ EUROPA, 25", 41387561, 21306737, 57, 8028, 33, 4);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (206, "AV. DIAGONAL, 650", 413897943, 21328634, 62, 8017, 33, 5);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (207, "AV. DIAGONAL, 634", 413908477, 2136579, 62, 8017, 25, 5);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (208, "AV. DIAGONAL, 630", 413915195, 21390667, 59, 8017, 33, 5);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (209, "C/ DIPUTACIÓ, 200", 413857425, 21610515, 23, 8011, 26, 2);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (210, "C/ VILARDELL, 18", 413745238, 21422556, 22, 8014, 31, 3);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (211, "C/ SANCHO DE ÁVILA, 60-64", 413987543, 21902116, 5, 8018, 28, 10);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (212, "AV. SARRIÀ, 163", 413922355, 21309272, 75, 8017, 24, 5);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (213, "C/ SANTA FE DE NOU MÈXIC, 2", 413935816, 21345892, 70, 8017, 33, 5);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (214, "C/ JOSÉ DE  AGULLÓ, 9", 413952027, 21334873, 72, 8017, 25, 5);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (215, "C/ GANDUXER, 29", 413939378, 21380304, 65, 8021, 21, 5);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (216, "C/ MADRAZO, 131", 413967824, 21445567, 63, 8021, 27, 5);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (217, "C/ RECTOR UBACH, 24", 413985735, 21440826, 75, 8021, 27, 5);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (218, "C/ CONSELL DE CENT, 566", 414040364, 2183145, 17, 8013, 39, 2);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (219, "C/ LAFORJA, 74-76", 413976165, 21471724, 67, 8021, 23, 5);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (220, "C/ TUSET, 19", 413960982, 21513154, 53, 8006, 27, 5);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (221, "GRAN DE GRÀCIA, 155 (METRO FONTANA)", 414025392, 21524704, 68, 8012, 24, 6);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (222, "C/ DEL CANÓ, 1", 414013296, 21574439, 58, 8012, 27, 6);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (223, "C/ DE BONAVISTA, 14", 413983444, 21598243, 48, 8012, 35, 6);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (224, "C / GIRONA, 176", 413999967, 21644531, 40, 8037, 26, 2);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (225, "C/ VILADOMAT, 200", 413848000000000, 215081000000000, 28, 8029, 25, 2);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (226, "C/ MONTMANY, 1", 414035608, 21609345, 52, 8012, 27, 6);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (227, "C/ DEL TORRENT DE LES FLORS, 102", 414078456, 21586704, 69, 8024, 18, 6);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (228, "PL. DEL NORD, 5", 414068417, 21558354, 73, 8024, 21, 6);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (229, "C/ DE LA SANTACREU, 2 (PL.DE LA VIRREIN", 414050968, 21569161, 68, 8024, 28, 6);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (230, "C/ DE NIL FABRA, 16-20", 414059356, 21517977, 80, 8012, 26, 6);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (231, "C/ PAU ALSINA, 54", 414092005, 216400285, 65, 8025, 24, 2);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (232, "C/ MATA, 2", 413732903, 21710273, 7, 8004, 27, 3);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (233, "C/ NOU DE LA RAMBLA, 164", 413719688, 21667829, 21, 8004, 27, 3);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (234, "PG. DE L´EXPOSICIÓ, 38 /BLASCO GARAY", 41371532, 2162203, 31, 8004, 27, 3);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (235, "AV. PARAL.LEL, 98", 413751767, 21658972, 10, 8015, 21, 2);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (236, "AV. PARAL.LEL, 194", 413751161, 21523091, 24, 8015, 26, 2);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (237, "C/ RIUS I TAULET, 4", 413727426, 21539198, 33, 8004, 27, 3);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (238, "C/ ESPRONCEDA, 298", 414158807, 21908473, 16, 8027, 27, 9);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (239, "C/ INDÚSTRIA, 329", 414172922, 21844769, 31, 8027, 35, 9);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (240, "C/ JOSEP ESTIVILL, 32", 414175595, 21877153, 23, 8027, 27, 9);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (241, "C/ TEODOR LLORENTE, 1", 41419178, 218018, 44, 8041, 33, 7);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (242, "C/ RAMON ALBÓ, 1", 414244527, 21773157, 56, 8027, 27, 9);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (243, "C/ ALEXANDRE GALÍ, 1-5", 414239719, 21812399, 42, 8027, 27, 9);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (244, "C/ FELIP II, 214", 41426925, 21786224, 44, 8027, 27, 9);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (245, "LA RAMBLA, 101", 413826647, 21717083, 10, 8002, 27, 1);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (246, "C/ GARCILASO, 77", 414228449, 21866363, 30, 8027, 18, 9);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (247, "C/ FELIPE II, 112", 414219291, 21849107, 32, 8027, 32, 9);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (248, "C/ PALÈNCIA, 31", 414182129, 21904005, 18, 8027, 26, 9);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (249, "C/ ANTILLES, 8", 414250835, 21872818, 21, 8027, 27, 9);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (250, "C/ PORTUGAL, 3", 414258248, 2191206, 25, 8027, 27, 9);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (251, "C/ CARDENAL TEDESCHINI, 13", 414253643, 21852073, 35, 8027, 33, 9);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (252, "RAMBLA DE L'ONZE DE SETEMBRE, 31", 414298991, 21932159, 24, 8030, 33, 9);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (253, "C/ ONZE DE SETEMBRE, 37-39", 414298614, 21922011, 25, 8030, 27, 9);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (254, "RAMBLA DE L'ONZE DE SETEMBRE, 69", 414299999, 2190246, 26, 8030, 26, 9);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (255, "C/ IRLANDA, 34", 414315, 218579, 30, 8030, 15, 9);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (256, "C/ MALATS, 28-30", 414361251, 21894423, 25, 8030, 32, 9);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (257, "C/ SANT ADRIÀ, 2-8", 41433934, 21896502, 27, 8030, 24, 9);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (258, "C/ FERNANDO PESSOA, 45", 414425034, 21929677, 23, 8030, 26, 9);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (259, "C/ DE BARTRINA, 14", 414391174, 21858025, 34, 8030, 24, 9);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (260, "CARRER DEL CINCA, 7", 414356895, 21920873, 22, 8030, 27, 9);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (261, "C/ VILLARROEL, 39", 413821314, 21606534, 17, 8011, 32, 2);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (262, "C/ ENTENÇA, 70", 413791000000000, 21516200000000, 21, 8015, 24, 2);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (263, "PG. TORRAS I BAGES, 29", 414378773, 21910691, 23, 8030, 20, 9);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (264, "C/REPÚBLICA DOMINICANA,25(CENTRE COMERC", 41439929, 21970692, 20, 8030, 33, 9);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (265, "C/ CASANOVA, 55", 413847738, 21592566, 23, 8011, 27, 2);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (266, "C/ CONCEPCIÓ ARENAL, 176", 414268952, 21842572, 37, 8027, 26, 9);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (267, "PG. TORRAS I BAGES, 129", 414433647, 21906302, 29, 8030, 24, 9);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (268, "C/ FERNANDO PESSOA, 72", 414457195, 21929816, 26, 8030, 27, 9);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (269, "VIA BARCINO, 121", 41448152, 219294, 26, 8033, 20, 8);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (270, "CRTA. DE RIBES, 77 (TRINITAT VELLA)", 414486328, 21898372, 35, 8033, 27, 8);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (271, "VIA BARCINO, 69", 414506081, 21923629, 28, 8033, 20, 8);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (272, "C/ CONCEPCIÓ ARENAL, 281", 414325013, 21842021, 32, 8033, 26, 8);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (273, "AV. MERIDIANA, 404", 414304126, 21834174, 38, 8030, 36, 9);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (274, "RAMBLA FABRA I PUIG, 67", 414299201, 21849813, 33, 8030, 32, 9);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (275, "AV. RIO DE JANEIRO, 3", 4143068, 21821802, 38, 8016, 32, 8);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (276, "PLAÇA ALFONS X EL SAVI / RONDA DEL GUIN", 414121345, 21652216, 88, 8024, 27, 6);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (277, "TRAVESSERA DE GRÀCIA, 328", 414082107, 21689962, 60, 8025, 27, 2);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (278, "TRAVESSERA DE GRÀCIA, 368", 414098842, 21715285, 59, 8025, 27, 2);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (279, "C/ MAS CASANOVAS, 137", 414158995, 21745567, 75, 8041, 27, 7);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (280, "C/ SANT ANTONI Mª CLARET, 290-296", 414138664, 21777274, 49, 8041, 27, 7);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (281, "C/ D'ESCORNALBOU, 51", 414180789, 21763994, 74, 8041, 24, 7);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (282, "PG. FONT D´EN- FARGAS, 1", 414275514, 21659881, 75, 8031, 26, 8);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (283, "C/ FULTON, 1", 414297231, 21617032, 76, 8032, 20, 7);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (284, "AV. DIAGONAL, 652", 41389462, 21314948, 63, 8034, 27, 4);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (285, "C/ MALATS, 98-100", 414366708, 2186105, 35, 8030, 16, 9);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (286, "C/ BOLÍVIA, 76", 414030225, 21913538, 7, 8018, 16, 10);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (287, "GRAN VIA DE LES CORTS CATALANES, 632", 413890626, 21679313, 22, 8007, 16, 2);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (288, "PL. VIRREI AMAT", 414296439, 2174444, 55, 8016, 32, 8);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (289, "C/ MÚRCIA, 64", 414166982, 21909952, 17, 8027, 27, 9);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (290, "PL. DELS JARDINS D'ALFÀBIA, 1", 414373376, 21740962, 66, 8016, 17, 8);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (291, "C/ CUBELLES, 2", 41426078, 21751572, 57, 8031, 27, 8);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (292, "C/ AMILCAR, 1", 414300161, 21720191, 61, 8031, 12, 8);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (293, "C/ GRANOLLERS, 1", 414283127, 21629889, 78, 8032, 24, 7);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (294, "SEU DEL DISTRICTE (NOU BARRIS)", 414363473, 21706752, 72, 8042, 24, 8);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (295, "C/ SANT ISCLE, 60", 41433384, 21716309, 61, 8031, 27, 8);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (296, "C/ DE ROSSELLÓ I PORCEL, 1/AV.MERIDIANA", 414364887, 21841014, 41, 8016, 32, 8);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (297, "C/ TURÓ BLAU, 1-3", 414388223, 21767828, 62, 8016, 24, 8);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (298, "C/ ANDREU NIN, 22", 414347233, 21817718, 41, 8016, 33, 8);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (299, "C/ DE L'ESCULTOR ORDÓÑEZ, 55", 414340849, 21748267, 53, 8016, 27, 8);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (300, "C/ DE MALADETA, 1", 414315843, 21769107, 44, 8016, 18, 8);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (301, "C/ MARIE CURIE, 8-14", 414366871, 21693134, 73, 8042, 27, 8);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (302, "C/ CAVALLERS, 41", 413906352, 2111541, 111, 8034, 32, 4);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (303, "C/ CAVALLERS, 67", 413934324, 2115107, 101, 8034, 27, 4);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (304, "PG. MANUEL GIRONA, 7", 4139038, 2121, 78, 8034, 27, 4);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (305, "AV. DIAGONAL, 680", 413875297, 21237141, 65, 8034, 27, 4);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (306, "C/ DOCTOR SALVADOR CARDENAL, 1-5", 413853868, 2122893, 60, 8028, 31, 4);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (307, "C/ PINTOR RIBALTA / AV. XILE", 413791986, 21135824, 60, 8028, 32, 4);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (308, "C/ CARDENAL REIG, 11", 4137684, 2114029, 54, 8028, 26, 4);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (309, "C/ SANT RAMON NONAT,  26", 413770199, 21169828, 50, 8028, 22, 4);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (310, "C/ JOSEP SAMITIER / JOAN XXIII", 413812111, 21190863, 46, 8028, 27, 4);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (311, "C/ GALLEGO, 2", 413785631, 21202487, 43, 8028, 24, 4);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (312, "C/ ARIZALA, 77", 413789061, 21233038, 40, 8028, 36, 4);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (313, "C/ FELIU DE CASANOVA, 1", 413754188, 21297823, 28, 8028, 29, 4);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (314, "RAMBLA DEL BRASIL, 44", 413783067, 21297303, 35, 8028, 24, 4);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (315, "C/ DEL GUINARDÓ, 32-38", 414156285, 21817876, 38, 8041, 27, 7);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (316, "C/ CANTÀBRIA, 55", 414224015, 2198071, 9, 8020, 26, 10);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (317, "RAMBLA DE PRIM, 256", 414256626, 22008632, 11, 8020, 27, 10);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (318, "C/ CASTILLEJOS, 388", 41412427, 2170592, 77, 8025, 32, 2);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (319, "C/ SAGUÉS, 1", 413937414, 21455022, 51, 8021, 31, 5);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (320, "C/ MADRAZO, 39", 41400305, 2149144, 67, 8006, 27, 5);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (321, "C/ SANT HERMENEGILD, 30", 414031529, 21445843, 79, 8006, 27, 5);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (322, "C/ SANTALÓ, 165", 414009, 213892, 106, 8021, 24, 5);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (323, "C/ VALLMAJOR, 13", 413981616, 21386719, 88, 8021, 27, 5);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (324, "C/ REINA VICTORIA, 31", 413969455, 2136346, 80, 8021, 27, 5);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (325, "C/ ALT DE GIRONELLA, 13", 413949601, 21302775, 82, 8017, 23, 5);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (326, "C/ BALMES, 409", 414074131, 21381069, 111, 8022, 32, 5);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (327, "C/ REUS, 23", 414050074, 2134603, 114, 8022, 24, 5);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (328, "C/ ARTESA DE SEGRE, 2", 41402988, 21344691, 106, 8022, 27, 5);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (329, "C/ DE LES ESCOLES PIES, 99", 414029965, 21283866, 121, 8017, 27, 5);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (330, "C/ PAU ALCOVER, 94", 41401883, 2131524, 108, 8017, 27, 5);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (331, "C/ CASTELLNOU, 65", 413970497, 21279409, 95, 8017, 31, 5);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (332, "C/ DOCTOR ROUX, 86", 413998981, 21281922, 104, 8017, 27, 5);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (333, "PASSATGE DE SENILLOSA, 3-5", 413954723, 21250451, 94, 8034, 27, 4);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (334, "PG. BONANOVA, 100", 41400793, 2122889, 117, 8017, 26, 5);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (335, "C/ SANTA AMÈLIA, 2", 413935355, 21231228, 92, 8034, 27, 4);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (336, "C/ CAPONATA, 20", 413953855, 21210928, 101, 8034, 27, 4);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (337, "C/ CARME KARR, 12-14", 413986238, 21204941, 117, 8034, 23, 4);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (338, "AV. JOSEP VICENÇ FOIX, 63", 413977227, 21194557, 111, 8034, 36, 4);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (339, "C/ RAMON TURRÓ, 246", 414017084, 22053803, 2, 8005, 27, 10);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (340, "C/ SANT ADRIÀ, 113", 414361782, 22047037, 13, 8030, 24, 9);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (341, "PG. D'ENRIC SANCHIS, 33", 414339212, 22062245, 11, 8030, 26, 9);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (342, "C/ ROC BORONAT, 134", 414034967, 21936584, 5, 8018, 27, 10);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (343, "CAMPANA DE LA MAQUINISTA (SAO PAULO I P", 414389609, 21996179, 14, 8030, 27, 9);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (344, "C/ CIUTAT D'ASUNCIÓN, 73 / POTOSÍ", 414431441, 21996045, 16, 8030, 27, 9);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (345, "PL. TERESA DE CLARAMUNT/C/ DELS FERROCA", 413631066, 21398322, 10, 8038, 32, 3);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (346, "PG. ZONA FRANCA, 182", 41360798, 2138931, 8, 8038, 36, 3);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (347, "C/ ALTS FORNS, 77", 413595484, 21417765, 9, 8038, 32, 3);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (348, "JARDINS DE CAN FERRERO/PG.DE LA ZONA FR", 41357067, 2141563, 7, 8038, 33, 3);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (349, "C/ DE L'ENERGIA, 2 / ALTS FORNS", 413573288, 21371996, 7, 8038, 33, 3);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (350, "C/ VILLARROEL, 208", 41392052, 21480223, 43, 8036, 31, 2);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (351, "C/ JANE ADDAMS, 26/ CRTA. DEL PRAT", 413621232, 21356187, 9, 8038, 33, 3);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (352, "C/RADI,10/GRAN VIA DE LES CORTS CATALA", 41363279, 21341586, 9, 8038, 28, 3);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (353, "C/ MUNNÉ  2-6", 4137541, 21232547, 34, 8028, 31, 4);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (354, "RAMBLA DEL BRASIL, 5", 413759419, 21299539, 28, 8028, 27, 4);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (355, "C/ RIERA BLANCA, 123", 41371459, 2127854, 22, 8028, 27, 4);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (356, "C/ CAMÈLIES, 73", 414134503, 21631012, 106, 8024, 27, 6);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (357, "C/ CARDENER, 59", 414105956, 21579897, 87, 8024, 27, 6);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (358, "C/ GOMBAU, 24", 413872437, 21793035, 5, 8003, 26, 1);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (359, "C/ MÉNDEZ NÚÑEZ, 16", 413900544, 21775594, 12, 8003, 26, 1);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (360, "C/ BAILÉN, 62", 413952527, 21730023, 22, 8009, 30, 2);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (361, "PG. DE COLOM (LES RAMBLES)", 4137652, 217881, 5, 8039, 33, 3);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (362, "C/ BAILÉN, 100", 41396994, 21706323, 27, 8009, 32, 2);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (363, "C/ BRUC, 20", 413908381, 21743743, 16, 8010, 24, 2);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (364, "PG. DE GRÀCIA, 61", 41393062, 21633226, 32, 8007, 32, 2);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (365, "C/ VILADOMAT, 244", 413875712, 21469336, 39, 8029, 31, 2);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (366, "LA RAMBLA, 75", 413811389, 21729755, 8, 8001, 18, 1);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (367, "C/ MARQUÈS DE SENTMENAT, 46", 41384972, 21376205, 44, 8029, 32, 2);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (368, "C/ DIPUTACIÓ, 373", 413968391, 21756598, 21, 8013, 27, 2);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (369, "C/ CONSELL DE CENT, 482", 4140013, 21780175, 23, 8013, 27, 2);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (370, "C/ SARDENYA, 326", 414039698, 21729061, 37, 8025, 32, 2);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (371, "C/ DELS ENAMORATS, 49", 414040525, 2181199, 19, 8013, 36, 2);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (372, "C/ RIBES, 77", 414001015, 21841711, 9, 8013, 27, 2);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (373, "AV. PARAL.LEL, 132", 413750995, 21613897, 13, 8015, 30, 2);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (374, "PG. DE GRÀCIA, 89", 413949729, 21612814, 37, 8008, 33, 2);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (375, "WORLD TRADE CENTER", 413720293, 21804468, 3, 8039, 39, 3);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (376, "WORLD  TRADE CENTER", 413718728, 2180302, 3, 8039, 39, 3);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (377, "PL. ICTÍNEO", 413776292, 21836886, 2, 8039, 29, 3);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (378, "PL. JOAQUIM XIRAU I PALAU, 1", 413785379, 21767427, 5, 8002, 21, 1);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (379, "AV. JOSEP TARRADELLAS, 27", 413829333, 21420704, 35, 8029, 21, 2);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (380, "C/ DURAN I BAS, 2", 413854094, 21740155, 11, 8002, 24, 1);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (381, "C/ AGUSTÍ DURAN I SANPERE, 10", 413816139, 21677697, 10, 8001, 41, 1);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (382, "C/ LOPE DE VEGA, 79", 414038902, 22041137, 3, 8005, 27, 10);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (383, "C/ NUMÀNCIA, 2", 41381219, 2141767, 32, 8029, 24, 2);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (384, "C/ VILAMARÍ, 85", 413807072, 21468381, 28, 8015, 26, 2);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (385, "C/ CASANOVA, 119", 41387888, 21552902, 30, 8036, 30, 2);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (386, "AV. PARAL.LEL 164", 413751866, 21568773, 17, 8015, 3, 2);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (387, "C/ NÀPOLS, 125", 413957813, 21787074, 15, 8013, 32, 2);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (388, "C/ RIERA ALTA, 6", 413806411, 21671611, 10, 8001, 34, 1);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (389, "RECINTE PARC DE LA CIUTADELLA", 413873901, 21875446, 4, 8003, 27, 1);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (390, "C/ COMERÇ, 36", 413869612, 21820169, 5, 8003, 25, 1);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (391, "C/ GRAN DE LA SAGRERA, 74", 414230551, 21913753, 22, 8027, 27, 9);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (392, "C/ RAMON TURRÓ, 4", 413905303, 21906339, 5, 8005, 19, 10);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (393, "C/ LLACUNA, 86", 414022657, 21976297, 3, 8005, 31, 10);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (394, "C/ DIPUTACIÓ, 226", 413873057, 21631263, 25, 8007, 27, 2);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (395, "PL. CATALUNYA, 22", 413860607, 21702467, 15, 8002, 33, 1);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (396, "C/ JOAN MIRÓ, 2-12", 413890253, 21968267, 5, 8005, 32, 10);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (397, "AV. LITORAL (PG MARÍTIM DEL PORT OLÍMPI", 413889129, 21993105, 6, 8005, 27, 10);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (398, "PG. MARÍTIM DE LA BARCELONETA/ANDREA DÒ", 41380955, 21934636, 4, 8003, 35, 1);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (399, "C/ PAVIA, 3", 413734706, 21332694, 23, 8028, 27, 4);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (400, "MOLL ORIENTAL", 413694508, 21879597, 3, 8039, 44, 3);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (401, "PLA DE PALAU", 41382418, 2183723, 4, 8002, 24, 1);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (402, "PG. DE COLOM (VIA LAIETANA)", 41380628, 21821917, 4, 8002, 31, 1);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (403, "C/ VALLESPIR, 49", 413796421, 21368202, 32, 8014, 22, 3);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (404, "C/ JUAN GRIS, 28", 413653426, 21331357, 11, 8014, 32, 3);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (405, "C/ COMTE BORRELL, 198", 413854003, 21521802, 28, 8029, 26, 2);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (406, "GRAN VIA DE LES CORTS CATALANES, 592", 413863747, 21646697, 21, 8007, 33, 2);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (408, "C/ RAMON TRIAS FARGAS, 23", 413889972, 21923283, 5, 8005, 39, 10);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (409, "C/ JOAN D'ÀUSTRIA, 31B", 41392384, 21925059, 5, 8005, 27, 10);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (410, "PG.DE COLOM (LES RAMBLES)", 41376433, 217871, 5, 8039, 38, 3);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (411, "C/ JOSEP PLA, 67", 41411381, 22122054, 4, 8019, 24, 10);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (412, "PL. URQUINAONA, 3", 413893094, 21727457, 17, 8010, 27, 2);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (413, "C/ BRUC, 66", 41393489, 21707419, 24, 8009, 32, 2);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (414, "C/ CASP, 67", 413937234, 21764275, 16, 8010, 33, 2);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (415, "RAMBLA DEL RAVAL, 13", 413793558, 21689592, 8, 8001, 25, 1);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (416, "RAMBLA DEL RAVAL, 20", 413781065, 21696744, 6, 8001, 27, 1);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (417, "C/ VILLAR, 2", 414164824, 21801094, 46, 8041, 32, 7);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (418, "PG. DE LLUíS COMPANYS (ARC DE TRIOMF)", 41391062, 21801142, 10, 8018, 27, 10);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (419, "PG. DE LLUIS COMPAYNS (ARC DE TRIOMF)", 41391313, 21808391, 10, 8018, 33, 10);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (420, "GRAN VIA DE LES CORTS CATALANES, 368", 413743329, 21479385, 24, 8010, 27, 2);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (421, "C/ VALLESPIR, 13", 41378118, 21378667, 30, 8014, 25, 3);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (422, "C/ JORDI GIRONA, 29", 413881175, 21154135, 82, 8034, 28, 4);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (424, "PG. MARÍTIM DE LA BARCELONETA", 413795862, 21925198, 7, 8003, 26, 1);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (425, "C/ DE CERVELLÓ, 5", 413765618, 21748621, 5, 8001, 24, 1);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (426, "C/ DE RIBES, 59 B", 4139828, 21830315, 12, 8013, 33, 2);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (427, "C/ DE SANT PAU, 119/ RONDA SANT PAU", 413754047, 21680021, 9, 8001, 26, 1);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (428, "C/ PUJADES, 103", 413983902, 21960799, 3, 8005, 27, 10);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (429, "C/ GRAN CAPITÀ, 9", 413881262, 21091535, 105, 8034, 28, 4);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (430, "C/ ALFAMBRA, 2 | AV. DIAGONAL", 41385641, 2113096, 77, 8034, 28, 4);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (431, "AV. JOAN XXIII, 17", 41383467, 2122175, 53, 8028, 20, 4);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (432, "C/ MARTÍ I FRANQUÈS, 1", 413847061, 21170751, 63, 8028, 28, 4);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (433, "C/ JOHN MAYNARD KEYNES, 2 | AV. DIAGONAL", 413862258, 21168609, 70, 8034, 42, 4);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (434, "C/ ROGER, 24", 413767538, 21269152, 34, 8028, 27, 4);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (435, "AV. DOCTOR MARAÑON, 25 | C/ PAU GARGALLO", 41383585, 2112186, 64, 8028, 28, 4);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (436, "PG. ZONA FRANCA, 54", 413545425, 21433038, 6, 8038, 19, 3);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (437, "PG. ZONA FRANCA, 9", 413513237, 21450958, 5, 8038, 36, 3);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (438, "C/ NÀPOLS, 183", 413981669, 21754896, 22, 8013, 27, 2);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (439, "RBLA. BADAL, 73 | C/ CONSTITUCIÓ", 413685394, 21328403, 14, 8014, 18, 3);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (440, "C/ SELVA DE MAR, 230", 41417694, 21976864, 9, 8020, 27, 10);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (441, "C/ WATT, 2", 413754426, 21398409, 25, 8014, 18, 3);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (442, "C/ MINERIA, 30", 413649272, 2138599, 11, 8038, 18, 3);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (443, "C/ CASANOVA, 139", 413887127, 21542277, 33, 8036, 32, 2);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (444, "C/ LLEIDA, 40", 413717304, 21554047, 33, 8004, 27, 3);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (445, "C/ VILAMARÍ, 2", 413755016, 2154004, 21, 8015, 24, 2);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (446, "PG. JOAN DE BORBÓ, 42", 413779974, 21884228, 4, 8003, 15, 1);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (447, "C/ ALMOGÀVERS, 63", 413943033, 21860256, 10, 8018, 27, 10);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (448, "C/ RAMÓN TURRÓ, 160", 413972809, 21997869, 3, 8005, 27, 10);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (449, "C/ BOLIVIA, 120", 414058109, 21949461, 5, 8018, 27, 10);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (450, "C/ CRISTOBAL DE MOURA, 84", 41410712, 22061691, 3, 8019, 27, 10);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (451, "C/ PALLARS, 504", 414140598, 22150487, 4, 8019, 24, 10);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (452, "GRAN VIA DE LES CORTS CATALANES, 1157 (D)", 414194972, 220934, 8, 8020, 54, 10);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (454, "C/ SARDENYA, 402", 414072349, 21684799, 56, 8025, 27, 2);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (455, "C/ PROVENÇA, 595", 414105848, 21826833, 27, 8026, 22, 10);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (456, "C/ MÚRCIA, 1", 414143392, 21874539, 22, 8026, 21, 10);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (457, "C/ GRANADELLA, 10-19 | C/ SAS", 414383117, 22039823, 12, 8030, 18, 9);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (458, "C/ TUCUMÁN, 21", 414457962, 22010422, 17, 8030, 24, 9);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (459, "PG. SANTA COLOMA, 105", 414479402, 21976757, 24, 8030, 39, 9);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (460, "C/ MIREIA, 28", 414513863, 21894717, 56, 8033, 15, 8);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (461, "AV. RIO DE JANEIRO, 118", 41442489, 2185727, 43, 8016, 28, 8);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (462, "C/ PALAMÓS, 33", 41446923, 2184857, 61, 8033, 28, 8);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (463, "C/ PEDROSA, 24", 414490679, 21833801, 68, 8033, 24, 8);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (464, "AV. RIO DE JANEIRO, 96", 41439692, 2182335, 47, 8016, 24, 8);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (465, "C/ ROSSELLÓ, 261", 413954094, 21599427, 41, 8008, 27, 2);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (466, "C/ PABLO IGLESIAS, 21", 41443387, 21813051, 63, 8016, 29, 8);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (467, "PL. JESÚS CARRASCO", 414450463, 2176726, 93, 8042, 20, 8);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (468, "C/ NOU BARRIS, 23", 414480464, 21775154, 107, 8042, 18, 8);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (469, "C/ SANT FRANCESC XAVIER, 1", 414417001, 21781553, 72, 8016, 18, 8);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (470, "C/ GÒNGORA, 23", 414432762, 21746238, 93, 8042, 24, 8);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (471, "PG. VALLDAURA, 171", 414389014, 21715576, 78, 8042, 24, 8);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (472, "VIA FAVÈNCIA, 186", 414427374, 2170393, 105, 8042, 24, 8);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (473, "PG. FABRA I PUIG, 449", 414388644, 21657506, 94, 8042, 31, 8);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (474, "VIA FAVÈNCIA, 47", 414418604, 21664224, 102, 8042, 24, 8);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (475, "C/ CAMPO FLORIDO, 66", 414216738, 21799878, 46, 8027, 19, 9);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (476, "C/ PERIODISTES, 9", 41422037, 2174401, 80, 8032, 18, 7);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (477, "C/ AMILCAR, 78", 414260751, 21722534, 69, 8032, 26, 7);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (478, "C/ ESCULTOR LLIMONA, 7", 414276076, 21697582, 65, 8031, 30, 8);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (479, "PG. FABRA I PUIG, 344", 41430623, 21671068, 73, 8031, 18, 8);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (480, "PG. FABRA I PUIG, 385", 414333259, 21629258, 92, 8031, 28, 8);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (481, "PG. FABRA I PUIG, 411", 414357978, 2163872, 89, 8031, 26, 8);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (482, "PG. UNIVERSAL, 29 | C/ DOCTOR LETAMENDI", 414372022, 21620235, 95, 8042, 20, 8);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (483, "C/ LISBOA, 1", 414296000000000, 215897000000000, 79, 8032, 29, 7);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (484, "C/ EDUARD TODA, 33 | C/ DOCTOR LETAMENDI", 414345997, 21585268, 104, 8031, 27, 8);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (485, "PG. VALLDAURA, 26", 414374904, 21565742, 121, 8031, 27, 8);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (486, "C/ PORTO, 35 | AV. ESTATUT DE CATALUNYA", 414306102, 21564551, 81, 8032, 28, 7);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (487, "C/ LISBOA, 128", 414267638, 21521909, 98, 8032, 27, 7);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (488, "AV. CAN MARCET, 36", 414347859, 2147904, 132, 8035, 27, 7);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (489, "C/ JORGE MANRIQUE, 15", 414312335, 21499103, 119, 8035, 27, 7);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (490, "PG. VALL D'HEBRÓN, 168", 414280668, 21443777, 150, 8035, 50, 7);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (491, "C/ PARE MARIANA, 24", 414306689, 21456449, 125, 8035, 27, 7);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (492, "PL. TETUAN", 413943454, 21751709, 18, 8010, 24, 2);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (493, "PG. VALL D'HEBRÓN, 80", 41419965, 21401823, 166, 8023, 24, 6);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (494, "RAMBLA CATALUNYA/DIPUTACIO", 413896967, 21652199, 25, 8007, 24, 2);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (495, "C/ DIPUTACIÓ, 22", 41377846, 2150523, 24, 8015, 21, 2);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (496, "C/ PROVENÇA,  445", 414048623, 2174799, 33, 8025, 18, 2);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (497, "PTGE. MALUQUER, 16", 414095489, 21360313, 124, 8022, 27, 5);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (498, "C/ ESTEVE TERRADAS, 42", 414144967, 21402433, 145, 8023, 26, 6);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (499, "AV. VALLCARCA, 196", 414160558, 21421504, 127, 8023, 27, 6);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (500, "C/ ARGENTERA, 23", 414117633, 21453424, 101, 8023, 23, 6);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (501, "C/ ELISA, 1", 414052698, 21420204, 95, 8023, 16, 6);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (502, "AV. VALLCARCA, 11", 414074444, 21492066, 88, 8023, 19, 6);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (503, "C/ MAIGNON, 31-41", 414095926, 21524953, 105, 8024, 30, 6);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (504, "C/ MASSENS, 76", 414092333, 21557747, 87, 8024, 28, 6);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (505, "C/ CAMÈLIES, 78", 414145614, 21658677, 118, 8024, 27, 6);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (506, "C/ GARRIGA I ROCA, 2", 414191957, 21718497, 107, 8041, 15, 7);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (507, "C/ SARDENYA, 494", 414107641, 21640965, 81, 8024, 24, 6);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (508, "C/ SARDENYA, 465", 414090922, 21656378, 70, 8025, 27, 2);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (509, "C/ TORRENT DE L'OLLA, 11", 413989713, 21606736, 46, 8012, 32, 6);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (510, "C/ GRAN DE GRÀCIA, 37", 413989151, 21564253, 55, 8012, 27, 6);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (511, "C/ GRAN DE GRÀCIA, 91", 414006862, 21543317, 61, 8012, 20, 6);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (512, "C/ D'ALACANT, 12", 414000778, 21326911, 96, 8017, 27, 5);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (513, "VIA AUGUSTA, 317", 41399017, 2124329, 111, 8017, 28, 5);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (514, "C/ ARAGÓ, 614", 414095069, 21885055, 16, 8018, 18, 10);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (515, "C/ SANT ADRIÀ, 43", 414352071, 21948002, 19, 8030, 24, 9);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (516, "C/ SANT ADRIÀ, 88", 414354601, 22001569, 15, 8030, 21, 9);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (517, "AV. RASOS DE PEGUERA, 10", 41462095, 2178959, 44, 8033, 20, 8);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (518, "C/ LLOBREGÓS, 115", 414246885, 21570492, 112, 8032, 27, 7);
INSERT INTO estacions(id, nom, lat, lon, altitude, postal_code, enclatges, districte_id) VALUES (519, "C/ PEDRELL, 52", 414246548, 2166289, 110, 8032, 24, 7);




