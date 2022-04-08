-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema pgs
-- -----------------------------------------------------
-- Database for Pet Grooming Shop related data

CREATE SCHEMA IF NOT EXISTS `pgs` DEFAULT CHARACTER SET utf8 ;
USE `pgs` ;

-- -----------------------------------------------------
-- Table `pgs`.`users`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pgs`.`users` (
  `id_user` INT(11) NOT NULL COMMENT 'Id for this registry',
  `email` LONGTEXT NOT NULL COMMENT 'email of the user',
  `password` LONGTEXT NOT NULL COMMENT 'password of the user',
  `login` LONGTEXT NOT NULL COMMENT 'login or username to make login to the system',
  `phone` DOUBLE NOT NULL COMMENT 'Phone number of the user',
  `address` LONGTEXT NOT NULL COMMENT 'Address of the user',
  PRIMARY KEY (`id_user`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3
COMMENT = 'The users of the system. It may include pet owners and steticists and pet grooming shop owners or admins';


-- -----------------------------------------------------
-- Table `pgs`.`clients`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pgs`.`clients` (
  `id_client` INT(11) NOT NULL AUTO_INCREMENT COMMENT 'Id for this registry',
  `client_number` INT(11) NOT NULL COMMENT 'Client ID Number',
  `document_type` INT(11) NOT NULL COMMENT 'Type of Document Number',
  `client_name` LONGTEXT NOT NULL COMMENT 'Name of the Client',
  `last_visited` TIMESTAMP NOT NULL COMMENT 'Last time when the client came',
  `discount` INT(11) NOT NULL COMMENT 'Special disccount fot this client',
  `pending_payment` INT(11) NOT NULL COMMENT 'Amount pending for payment',
  `id_user` INT(11) NOT NULL COMMENT 'The user registry for this client',
  PRIMARY KEY (`id_client`),
  UNIQUE INDEX `client_number_UNIQUE` (`client_number` ASC) VISIBLE,
  INDEX `fk_clients_users_idx` (`id_user` ASC) VISIBLE,
  CONSTRAINT `fk_clients_users`
    FOREIGN KEY (`id_user`)
    REFERENCES `pgs`.`users` (`id_user`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3
COMMENT = 'Table for Clients of HYP';


-- -----------------------------------------------------
-- Table `pgs`.`statuses`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pgs`.`statuses` (
  `id_status` INT(11) NOT NULL COMMENT 'Id for this registry',
  `description` LONGTEXT NOT NULL COMMENT 'Description of the status',
  PRIMARY KEY (`id_status`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3
COMMENT = 'Statuses of the visits of the pets';


-- -----------------------------------------------------
-- Table `pgs`.`fur_statuses`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pgs`.`fur_statuses` (
  `id_fur_status` INT(11) NOT NULL COMMENT 'Id for this registry',
  `description` LONGTEXT NOT NULL COMMENT 'Description of the fur status',
  `factor` INT(11) NOT NULL COMMENT 'Factor to calculate the final amount of the service',
  PRIMARY KEY (`id_fur_status`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3
COMMENT = 'Fur statuses for the pets';


-- -----------------------------------------------------
-- Table `pgs`.`pet_types`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pgs`.`pet_types` (
  `id_pet_type` INT(11) NOT NULL AUTO_INCREMENT COMMENT 'ID for registry',
  `name` LONGTEXT NOT NULL COMMENT 'Name of the Pet Type',
  PRIMARY KEY (`id_pet_type`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3
COMMENT = 'Types of pets in the system';


-- -----------------------------------------------------
-- Table `pgs`.`pet_breeds`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pgs`.`pet_breeds` (
  `id_pet_breed` INT(11) NOT NULL COMMENT 'ID for this regisrty',
  `name` LONGTEXT NOT NULL COMMENT 'Name of the Pet Breed',
  `id_pet_type` INT(11) NOT NULL COMMENT 'Type of Pet for this Pet Breed',
  PRIMARY KEY (`id_pet_breed`),
  INDEX `fk_pet_types_id_pet_types` (`id_pet_type` ASC) VISIBLE,
  CONSTRAINT `fk_pet_types_id_pet_types`
    FOREIGN KEY (`id_pet_type`)
    REFERENCES `pgs`.`pet_types` (`id_pet_type`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3
COMMENT = 'Breeds of Pets in the system';


-- -----------------------------------------------------
-- Table `pgs`.`pets`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pgs`.`pets` (
  `id_pet` INT(11) NOT NULL COMMENT 'Id for this registry',
  `name` LONGTEXT NOT NULL COMMENT 'Name of the pet',
  `birth_date` DATE NOT NULL COMMENT 'Dat for birth of the pet',
  `gender` INT(11) NOT NULL COMMENT 'Gender of the pet',
  `is_sterilized` SMALLINT(6) NOT NULL COMMENT 'Is the peat already sterilized',
  `weight` LONGTEXT NOT NULL COMMENT 'Weight in KG of the pet',
  `photo` LONGTEXT NULL DEFAULT NULL COMMENT 'Binary of the photo of the pet',
  `additional_observations` LONGTEXT NULL DEFAULT NULL COMMENT 'Some important things to know about the pet',
  `last_visited` TIMESTAMP NOT NULL COMMENT 'Las time when the pet came',
  `id_user` INT(11) NOT NULL COMMENT 'Owner of the pet',
  `id_pet_breed` INT(11) NOT NULL COMMENT 'Breed of the pet',
  `id_fur_status` INT(11) NOT NULL COMMENT 'Current status of the fur of the pet',
  PRIMARY KEY (`id_pet`),
  INDEX `fk_users_id_user` (`id_user` ASC) VISIBLE,
  INDEX `fk_pet_breeds_id_pet_breed` (`id_pet_breed` ASC) VISIBLE,
  INDEX `fk_fur_statuses_id_fur_status` (`id_fur_status` ASC) VISIBLE,
  CONSTRAINT `fk_fur_statuses_id_fur_status`
    FOREIGN KEY (`id_fur_status`)
    REFERENCES `pgs`.`fur_statuses` (`id_fur_status`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_pet_breeds_id_pet_breed`
    FOREIGN KEY (`id_pet_breed`)
    REFERENCES `pgs`.`pet_breeds` (`id_pet_breed`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_users_id_user`
    FOREIGN KEY (`id_user`)
    REFERENCES `pgs`.`users` (`id_user`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3
COMMENT = 'Pets';


-- -----------------------------------------------------
-- Table `pgs`.`vaccines`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pgs`.`vaccines` (
  `id_vaccine` INT(11) NOT NULL COMMENT 'Id for this registry',
  `name` LONGTEXT NOT NULL COMMENT 'Name of the vaccine',
  PRIMARY KEY (`id_vaccine`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3
COMMENT = 'Vaccines for all pets';


-- -----------------------------------------------------
-- Table `pgs`.`pets_and_vaccines`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pgs`.`pets_and_vaccines` (
  `id_pets_vaccines` INT(11) NOT NULL COMMENT 'Id for this registry',
  `id_pet` INT(11) NULL DEFAULT NULL COMMENT 'The pet',
  `id_vaccine` INT(11) NULL DEFAULT NULL COMMENT 'The vaccine',
  `application` DATE NULL DEFAULT NULL COMMENT 'The date when the vaccine was applicated',
  PRIMARY KEY (`id_pets_vaccines`),
  INDEX `fk_pets_id_pet` (`id_pet` ASC) VISIBLE,
  INDEX `fk_vaccine_id_vaccine` (`id_vaccine` ASC) VISIBLE,
  CONSTRAINT `fk_pets_id_pet`
    FOREIGN KEY (`id_pet`)
    REFERENCES `pgs`.`pets` (`id_pet`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_vaccines_id_vaccine`
    FOREIGN KEY (`id_vaccine`)
    REFERENCES `pgs`.`vaccines` (`id_vaccine`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3
COMMENT = 'Where the vaccines and the pets are related';


-- -----------------------------------------------------
-- Table `pgs`.`services`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pgs`.`services` (
  `id_service` INT(11) NOT NULL COMMENT 'Id for this registry',
  `name` LONGTEXT NOT NULL COMMENT 'Name of the service',
  `average_time` TIME NOT NULL COMMENT 'Average time of completion for this service',
  `base_amount` INT(11) NOT NULL COMMENT 'base amount to charge the owner of the pet',
  PRIMARY KEY (`id_service`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3
COMMENT = 'Services offered by the pet grooming store';


-- -----------------------------------------------------
-- Table `pgs`.`visits`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pgs`.`visits` (
  `id_visit` INT(11) NOT NULL COMMENT 'ID for this registry',
  `visit_date` TIMESTAMP NOT NULL COMMENT 'The date when the pet visited us',
  `initial_description` LONGTEXT NOT NULL COMMENT 'Some notes written by the steticist when the pet got in',
  `final_description` LONGTEXT NOT NULL COMMENT 'Some notes written by the steticist when the pet got out',
  `real_time_used` TIME NOT NULL COMMENT 'The amount of time in minutes effectively used for attend the visit',
  `total_amount` INT(11) NOT NULL COMMENT 'Total amount in currency charged to the owner for the visit',
  `id_service` INT(11) NOT NULL COMMENT 'The service made in this visit',
  `id_status` INT(11) NOT NULL COMMENT 'The current status of the service',
  `id_user` INT(11) NOT NULL COMMENT 'The steticist that is making the service to the pet',
  `id_pet` INT(11) NOT NULL COMMENT 'The pet',
  PRIMARY KEY (`id_visit`),
  INDEX `fk_pets_id_pet_1` (`id_pet` ASC) VISIBLE,
  INDEX `fk_services_id_service` (`id_service` ASC) VISIBLE,
  INDEX `fk_status_id_status` (`id_status` ASC) VISIBLE,
  INDEX `fk_steticist_id_user` (`id_user` ASC) VISIBLE,
  CONSTRAINT `fk_status_id_status`
    FOREIGN KEY (`id_status`)
    REFERENCES `pgs`.`statuses` (`id_status`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_steticist_id_user`
    FOREIGN KEY (`id_user`)
    REFERENCES `pgs`.`users` (`id_user`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_pets_id_pet_1`
    FOREIGN KEY (`id_pet`)
    REFERENCES `pgs`.`pets` (`id_pet`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_services_id_service`
    FOREIGN KEY (`id_service`)
    REFERENCES `pgs`.`services` (`id_service`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3
COMMENT = 'The visits of the pets and owner in the pet grooming store';


-- -----------------------------------------------------
-- Table `pgs`.`promotions`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pgs`.`promotions` (
  `id_promotion` INT(11) NOT NULL COMMENT 'Id for this registry',
  `id_visit` INT(11) NOT NULL COMMENT 'The visit to make promotion',
  `factor` DOUBLE NOT NULL COMMENT 'The factor of the promotion in percent',
  PRIMARY KEY (`id_promotion`),
  INDEX `fk_visits_id_visit` (`id_visit` ASC) VISIBLE,
  CONSTRAINT `fk_visits_id_visit`
    FOREIGN KEY (`id_visit`)
    REFERENCES `pgs`.`visits` (`id_visit`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3
COMMENT = 'Promotions for the visitors';


-- -----------------------------------------------------
-- Table `pgs`.`roles`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pgs`.`roles` (
  `id_role` INT(11) NOT NULL COMMENT 'Id for this registry',
  `name` LONGTEXT NOT NULL COMMENT 'Name of the role',
  PRIMARY KEY (`id_role`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3
COMMENT = 'Roles of the users in the system';


-- -----------------------------------------------------
-- Table `pgs`.`user_roles`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pgs`.`user_roles` (
  `id_user_role` INT(11) NOT NULL COMMENT 'Id for this registry',
  `id_user` INT(11) NULL DEFAULT NULL COMMENT 'The user',
  `id_role` INT(11) NULL DEFAULT NULL COMMENT 'The role',
  PRIMARY KEY (`id_user_role`),
  INDEX `fk_users_id_user_1` (`id_user` ASC) VISIBLE,
  INDEX `fk_roles_id_role` (`id_role` ASC) VISIBLE,
  CONSTRAINT `fk_roles_id_role`
    FOREIGN KEY (`id_role`)
    REFERENCES `pgs`.`roles` (`id_role`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_users_id_user_1`
    FOREIGN KEY (`id_user`)
    REFERENCES `pgs`.`users` (`id_user`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3
COMMENT = 'Roles mapping for users';


-- -----------------------------------------------------
-- Table `pgs`.`satisfaction_assessments`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pgs`.`satisfaction_assessments` (
  `id_satisfaction_assessment` INT(11) NOT NULL COMMENT 'TRIAL',
  `score` INT(11) NOT NULL COMMENT 'TRIAL',
  `id_visit` INT(11) NOT NULL COMMENT 'TRIAL',
  PRIMARY KEY (`id_satisfaction_assessment`),
  INDEX `fk_visits_id_visit_1` (`id_visit` ASC) VISIBLE,
  CONSTRAINT `fk_visits_id_visit_1`
    FOREIGN KEY (`id_visit`)
    REFERENCES `pgs`.`visits` (`id_visit`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3
COMMENT = 'TRIAL';


-- -----------------------------------------------------
-- Table `pgs`.`audit`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pgs`.`audit` (
  `id_audit` INT NOT NULL COMMENT 'Id for this registry',
  `table_name` LONGTEXT NOT NULL COMMENT 'Name of the table affected',
  `creation_user` LONGTEXT NOT NULL COMMENT 'User that created the registry',
  `update_user` LONGTEXT NOT NULL COMMENT 'User that updated the registry',
  `creation_date` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Date of creation of the registry',
  `update_date` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Date of update of the registry',
  `description` LONGTEXT NULL DEFAULT '',
  PRIMARY KEY (`id_audit`))
ENGINE = InnoDB
COMMENT = 'Dates of creation and update\nUsers of creation and update\nFor any record in the tables';


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
