-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Versione server:              10.4.19-MariaDB - mariadb.org binary distribution
-- S.O. server:                  Win64
-- HeidiSQL Versione:            11.3.0.6295
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Dump della struttura del database cinema
CREATE DATABASE IF NOT EXISTS `cinema` /*!40100 DEFAULT CHARACTER SET utf8mb4 */;
USE `cinema`;

-- Dump della struttura di tabella cinema.film
DROP TABLE IF EXISTS `film`;
CREATE TABLE IF NOT EXISTS `film` (
  `codice_film` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `titolo` char(100) NOT NULL,
  `genere` char(50) DEFAULT NULL,
  `durata` int(11) unsigned DEFAULT NULL,
  PRIMARY KEY (`codice_film`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4;

-- Dump dei dati della tabella cinema.film: ~2 rows (circa)
DELETE FROM `film`;
/*!40000 ALTER TABLE `film` DISABLE KEYS */;
INSERT INTO `film` (`codice_film`, `titolo`, `genere`, `durata`) VALUES
	(1, 'Man in Black', NULL, NULL),
	(2, 'Frozen', 'Animazione', NULL);
/*!40000 ALTER TABLE `film` ENABLE KEYS */;

-- Dump della struttura di tabella cinema.posto
DROP TABLE IF EXISTS `posto`;
CREATE TABLE IF NOT EXISTS `posto` (
  `codice_posto` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `numero_sala` int(10) unsigned DEFAULT NULL,
  `fila` char(1) NOT NULL,
  `numero` int(10) unsigned NOT NULL,
  PRIMARY KEY (`codice_posto`),
  KEY `FK_posto_sala` (`numero_sala`),
  CONSTRAINT `FK_posto_sala` FOREIGN KEY (`numero_sala`) REFERENCES `sala` (`numero_sala`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4;

-- Dump dei dati della tabella cinema.posto: ~4 rows (circa)
DELETE FROM `posto`;
/*!40000 ALTER TABLE `posto` DISABLE KEYS */;
INSERT INTO `posto` (`codice_posto`, `numero_sala`, `fila`, `numero`) VALUES
	(1, 1, 'a', 0),
	(2, 1, 'a', 1),
	(3, 1, 'b', 0),
	(4, 2, 'a', 1);
/*!40000 ALTER TABLE `posto` ENABLE KEYS */;

-- Dump della struttura di tabella cinema.prenotazione
DROP TABLE IF EXISTS `prenotazione`;
CREATE TABLE IF NOT EXISTS `prenotazione` (
  `codice_prenotazione` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `data` date NOT NULL,
  `ora` time NOT NULL,
  `sala` int(11) unsigned DEFAULT NULL,
  PRIMARY KEY (`codice_prenotazione`),
  KEY `FK_prenotazione_sala` (`sala`),
  CONSTRAINT `FK_prenotazione_sala` FOREIGN KEY (`sala`) REFERENCES `sala` (`numero_sala`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Dump dei dati della tabella cinema.prenotazione: ~0 rows (circa)
DELETE FROM `prenotazione`;
/*!40000 ALTER TABLE `prenotazione` DISABLE KEYS */;
/*!40000 ALTER TABLE `prenotazione` ENABLE KEYS */;

-- Dump della struttura di tabella cinema.proiezione
DROP TABLE IF EXISTS `proiezione`;
CREATE TABLE IF NOT EXISTS `proiezione` (
  `codice_proiezione` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `data` date NOT NULL,
  `ora` time NOT NULL,
  `sala` int(11) unsigned DEFAULT NULL,
  `2D/3D` char(2) DEFAULT NULL,
  `codice_film` int(11) unsigned DEFAULT NULL,
  PRIMARY KEY (`codice_proiezione`),
  UNIQUE KEY `data_ora_sala` (`data`,`ora`,`sala`),
  KEY `FK_proiezione_film` (`codice_film`),
  KEY `FK_proiezione_sala` (`sala`),
  CONSTRAINT `FK_proiezione_film` FOREIGN KEY (`codice_film`) REFERENCES `film` (`codice_film`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `FK_proiezione_sala` FOREIGN KEY (`sala`) REFERENCES `sala` (`numero_sala`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4;

-- Dump dei dati della tabella cinema.proiezione: ~1 rows (circa)
DELETE FROM `proiezione`;
/*!40000 ALTER TABLE `proiezione` DISABLE KEYS */;
INSERT INTO `proiezione` (`codice_proiezione`, `data`, `ora`, `sala`, `2D/3D`, `codice_film`) VALUES
	(1, '2021-10-30', '01:30:00', 1, '2D', 2),
	(2, '2021-10-30', '08:57:02', 2, '3D', 1);
/*!40000 ALTER TABLE `proiezione` ENABLE KEYS */;

-- Dump della struttura di tabella cinema.sala
DROP TABLE IF EXISTS `sala`;
CREATE TABLE IF NOT EXISTS `sala` (
  `numero_sala` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `mq` int(10) unsigned DEFAULT NULL,
  `posizione` char(100) DEFAULT NULL,
  PRIMARY KEY (`numero_sala`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4;

-- Dump dei dati della tabella cinema.sala: ~2 rows (circa)
DELETE FROM `sala`;
/*!40000 ALTER TABLE `sala` DISABLE KEYS */;
INSERT INTO `sala` (`numero_sala`, `mq`, `posizione`) VALUES
	(1, 100, 'a destra'),
	(2, 150, 'a sinistra');
/*!40000 ALTER TABLE `sala` ENABLE KEYS */;

-- Dump della struttura di tabella cinema.vale
DROP TABLE IF EXISTS `vale`;
CREATE TABLE IF NOT EXISTS `vale` (
  `codice_prenotazione` int(11) unsigned NOT NULL,
  `codice_posto` int(10) unsigned NOT NULL,
  PRIMARY KEY (`codice_prenotazione`,`codice_posto`),
  KEY `FK_vale_posto` (`codice_posto`),
  CONSTRAINT `FK_vale_posto` FOREIGN KEY (`codice_posto`) REFERENCES `posto` (`codice_posto`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_vale_prenotazione` FOREIGN KEY (`codice_prenotazione`) REFERENCES `prenotazione` (`codice_prenotazione`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Dump dei dati della tabella cinema.vale: ~0 rows (circa)
DELETE FROM `vale`;
/*!40000 ALTER TABLE `vale` DISABLE KEYS */;
/*!40000 ALTER TABLE `vale` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
