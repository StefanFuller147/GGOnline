-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema ggonlinedb
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `ggonlinedb` ;

-- -----------------------------------------------------
-- Schema ggonlinedb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `ggonlinedb` DEFAULT CHARACTER SET utf8 ;
USE `ggonlinedb` ;

-- -----------------------------------------------------
-- Table `user`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `user` ;

CREATE TABLE IF NOT EXISTS `user` (
  `username` VARCHAR(16) NOT NULL,
  `email` VARCHAR(255) NOT NULL,
  `password` VARCHAR(32) NOT NULL,
  `create_time` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `id` INT NOT NULL,
  `fname` VARCHAR(45) NOT NULL,
  `lname` VARCHAR(45) NOT NULL,
  `active` TINYINT(1) NULL,
  `status` TINYINT(1) NULL,
  PRIMARY KEY (`id`));


-- -----------------------------------------------------
-- Table `game`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `game` ;

CREATE TABLE IF NOT EXISTS `game` (
  `id` INT NOT NULL,
  `name` VARCHAR(45) NULL,
  `genera` VARCHAR(50) NULL,
  `rating` VARCHAR(1) NULL,
  `description` VARCHAR(500) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `team`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `team` ;

CREATE TABLE IF NOT EXISTS `team` (
  `id` INT NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `create_time` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `active` TINYINT(1) NULL,
  `game_id` INT NOT NULL,
  PRIMARY KEY (`id`, `game_id`),
  INDEX `fk_team_game1_idx` (`game_id` ASC),
  CONSTRAINT `fk_team_game1`
    FOREIGN KEY (`game_id`)
    REFERENCES `game` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `user_team`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `user_team` ;

CREATE TABLE IF NOT EXISTS `user_team` (
  `user_id` INT NOT NULL,
  `team_id` INT NOT NULL,
  `id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_user_has_team_team1_idx` (`team_id` ASC),
  INDEX `fk_user_has_team_user_idx` (`user_id` ASC),
  CONSTRAINT `fk_user_has_team_user`
    FOREIGN KEY (`user_id`)
    REFERENCES `user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_user_has_team_team1`
    FOREIGN KEY (`team_id`)
    REFERENCES `team` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table `message`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `message` ;

CREATE TABLE IF NOT EXISTS `message` (
  `id` INT NOT NULL,
  `message` VARCHAR(500) NULL,
  `user_id` INT NOT NULL,
  `create_date` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `message_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_message_user1_idx` (`user_id` ASC),
  INDEX `fk_message_message1_idx` (`message_id` ASC),
  CONSTRAINT `fk_message_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_message_message1`
    FOREIGN KEY (`message_id`)
    REFERENCES `message` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `message_recipient`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `message_recipient` ;

CREATE TABLE IF NOT EXISTS `message_recipient` (
  `id` INT NOT NULL,
  `user_id` INT NOT NULL,
  `message_id` INT NOT NULL,
  `user_team_id` INT NOT NULL,
  `is_read` TINYINT(1) NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  INDEX `fk_recipient_user1_idx` (`user_id` ASC),
  INDEX `fk_recipient_message1_idx` (`message_id` ASC),
  INDEX `fk_recipient_user_team1_idx` (`user_team_id` ASC),
  CONSTRAINT `fk_recipient_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_recipient_message1`
    FOREIGN KEY (`message_id`)
    REFERENCES `message` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_recipient_user_team1`
    FOREIGN KEY (`user_team_id`)
    REFERENCES `user_team` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `captain`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `captain` ;

CREATE TABLE IF NOT EXISTS `captain` (
  `id` INT NOT NULL,
  `status` TINYINT(1) NULL,
  `user_id` INT NOT NULL,
  `team_id` INT NOT NULL,
  PRIMARY KEY (`id`, `team_id`),
  INDEX `fk_captain_user1_idx` (`user_id` ASC),
  INDEX `fk_captain_team1_idx` (`team_id` ASC),
  CONSTRAINT `fk_captain_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_captain_team1`
    FOREIGN KEY (`team_id`)
    REFERENCES `team` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `user_game`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `user_game` ;

CREATE TABLE IF NOT EXISTS `user_game` (
  `user_id` INT NOT NULL,
  `game_id` INT NOT NULL,
  `id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_user_has_game_game1_idx` (`game_id` ASC),
  INDEX `fk_user_has_game_user1_idx` (`user_id` ASC),
  CONSTRAINT `fk_user_has_game_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_user_has_game_game1`
    FOREIGN KEY (`game_id`)
    REFERENCES `game` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table `rating`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `rating` ;

CREATE TABLE IF NOT EXISTS `rating` (
  `id` INT NOT NULL,
  `rating` INT NULL,
  `comment` VARCHAR(100) NULL,
  `user_id` INT NOT NULL,
  PRIMARY KEY (`id`, `user_id`),
  INDEX `fk_rating_user1_idx` (`user_id` ASC),
  CONSTRAINT `fk_rating_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SET SQL_MODE = '';
GRANT USAGE ON *.* TO admin;
 DROP USER admin;
SET SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';
CREATE USER 'admin' IDENTIFIED BY 'admin';

GRANT ALL ON * TO 'admin';
GRANT SELECT ON TABLE * TO 'admin';
GRANT SELECT, INSERT, TRIGGER ON TABLE * TO 'admin';
GRANT SELECT, INSERT, TRIGGER, UPDATE, DELETE ON TABLE * TO 'admin';
SET SQL_MODE = '';
GRANT USAGE ON *.* TO student;
 DROP USER student;
SET SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';
CREATE USER 'student' IDENTIFIED BY 'student';


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;