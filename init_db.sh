#!/bin/bash

# Nom du conteneur MySQL
CONTAINER_NAME="mysql-server"

# Base de données et informations d'authentification
DB_NAME="petclinic"
DB_ROOT_PASSWORD="rootpassword"
DB_USER="petclinic"
DB_PASSWORD="petclinicpassword"

# Commandes SQL à exécuter
SQL_COMMANDS="
CREATE DATABASE IF NOT EXISTS $DB_NAME;
USE $DB_NAME;
ALTER DATABASE $DB_NAME
  DEFAULT CHARACTER SET utf8
  DEFAULT COLLATE utf8_general_ci;

CREATE TABLE IF NOT EXISTS vets (
  id INT(4) UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  first_name VARCHAR(30),
  last_name VARCHAR(30),
  INDEX(last_name)
) engine=InnoDB;

CREATE TABLE IF NOT EXISTS specialties (
  id INT(4) UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(80),
  INDEX(name)
) engine=InnoDB;

CREATE TABLE IF NOT EXISTS vet_specialties (
  vet_id INT(4) UNSIGNED NOT NULL,
  specialty_id INT(4) UNSIGNED NOT NULL,
  FOREIGN KEY (vet_id) REFERENCES vets(id),
  FOREIGN KEY (specialty_id) REFERENCES specialties(id),
  UNIQUE (vet_id,specialty_id)
) engine=InnoDB;

CREATE TABLE IF NOT EXISTS types (
  id INT(4) UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(80),
  INDEX(name)
) engine=InnoDB;

CREATE TABLE IF NOT EXISTS owners (
  id INT(4) UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  first_name VARCHAR(30),
  last_name VARCHAR(30),
  address VARCHAR(255),
  city VARCHAR(80),
  telephone VARCHAR(20),
  INDEX(last_name)
) engine=InnoDB;

CREATE TABLE IF NOT EXISTS pets (
  id INT(4) UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(30),
  birth_date DATE,
  type_id INT(4) UNSIGNED NOT NULL,
  owner_id INT(4) UNSIGNED NOT NULL,
  INDEX(name),
  FOREIGN KEY (owner_id) REFERENCES owners(id),
  FOREIGN KEY (type_id) REFERENCES types(id)
) engine=InnoDB;

CREATE TABLE IF NOT EXISTS visits (
  id INT(4) UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  pet_id INT(4) UNSIGNED NOT NULL,
  visit_date DATE,
  description VARCHAR(255),
  FOREIGN KEY (pet_id) REFERENCES pets(id)
) engine=InnoDB;

INSERT IGNORE INTO vets VALUES (1, 'James', 'Carter'), (2, 'Helen', 'Leary'), (3, 'Linda', 'Douglas'), (4, 'Rafael', 'Ortega'), (5, 'Henry', 'Stevens'), (6, 'Sharon', 'Jenkins');

INSERT IGNORE INTO specialties VALUES (1, 'radiology'), (2, 'surgery'), (3, 'dentistry');

INSERT IGNORE INTO vet_specialties VALUES (2, 1), (3, 2), (3, 3), (4, 2), (5, 1);

INSERT IGNORE INTO types VALUES (1, 'cat'), (2, 'dog'), (3, 'lizard'), (4, 'snake'), (5, 'bird'), (6, 'hamster');

INSERT IGNORE INTO owners VALUES (1, 'George', 'Franklin', '110 W. Liberty St.', 'Madison', '6085551023'), (2, 'Betty', 'Davis', '638 Cardinal Ave.', 'Sun Prairie', '6085551749'), (3, 'Eduardo', 'Rodriquez', '2693 Commerce St.', 'McFarland', '6085558763'), (4, 'Harold', 'Davis', '563 Friendly St.', 'Windsor', '6085553198'), (5, 'Peter', 'McTavish', '2387 S. Fair Way', 'Madison', '6085552765'), (6, 'Jean', 'Coleman', '105 N. Lake St.', 'Monona', '6085552654'), (7, 'Jeff', 'Black', '1450 Oak Blvd.', 'Monona', '6085555387'), (8, 'Maria', 'Escobito', '345 Maple St.', 'Madison', '6085557683'), (9, 'David', 'Schroeder', '2749 Blackhawk Trail', 'Madison', '6085559435'), (10, 'Carlos', 'Estaban', '2335 Independence La.', 'Waunakee', '6085555487');

INSERT IGNORE INTO pets VALUES (1, 'Leo', '2000-09-07', 1, 1), (2, 'Basil', '2002-08-06', 6, 2), (3, 'Rosy', '2001-04-17', 2, 3), (4, 'Jewel', '2000-03-07', 2, 3), (5, 'Iggy', '2000-11-30', 3, 4), (6, 'George', '2000-01-20', 4, 5), (7, 'Samantha', '1995-09-04', 1, 6), (8, 'Max', '1995-09-04', 1, 6), (9, 'Lucky', '1999-08-06', 5, 7), (10, 'Mulligan', '1997-02-24', 2, 8), (11, 'Freddy', '2000-03-09', 5, 9), (12, 'Lucky', '2000-06-24', 2, 10), (13, 'Sly', '2002-06-08', 1, 10);

INSERT IGNORE INTO visits VALUES (1, 7, '2010-03-04', 'rabies shot'), (2, 8, '2011-03-04', 'rabies shot'), (3, 8, '2009-06-04', 'neutered'), (4, 7, '2008-09-04', 'spayed');
"

# Exécution des commandes SQL
echo "Exécution des commandes SQL sur le conteneur MySQL..."
docker exec -i $CONTAINER_NAME mysql -uroot -p$DB_ROOT_PASSWORD -e "$SQL_COMMANDS"

echo "Les commandes SQL ont été exécutées."
