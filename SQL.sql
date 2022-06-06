-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Server version:               10.4.24-MariaDB - mariadb.org binary distribution
-- Server OS:                    Win64
-- HeidiSQL Version:             12.0.0.6468
-- --------------------------------------------------------
/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */
;
/*!40101 SET NAMES utf8 */
;
/*!50503 SET NAMES utf8mb4 */
;
/*!40103 SET @OLD_TIgit ME_ZONE=@@TIME_ZONE */
;
/*!40103 SET TIME_ZONE='+00:00' */
;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */
;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */
;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */
;
-- Dumping database structure for dorm_register
DROP DATABASE IF EXISTS `dorm_register`;
CREATE DATABASE IF NOT EXISTS `dorm_register`
/*!40100 DEFAULT CHARACTER SET utf8mb4 */
;
USE `dorm_register`;
-- Dumping structure for table dorm_register.courses
DROP TABLE IF EXISTS `courses`;
CREATE TABLE IF NOT EXISTS `courses` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE = InnoDB AUTO_INCREMENT = 7 DEFAULT CHARSET = utf8mb4 COMMENT = 'All the courses available at HEART NSTA Stony Hill';
-- Dumping data for table dorm_register.courses: ~6 rows (approximately)
DELETE FROM `courses`;
INSERT INTO `courses` (`id`, `name`)
VALUES (1, 'Amber'),
  (2, 'Early Child Hood'),
  (3, 'Accounts'),
  (4, 'Food & Beverage'),
  (5, 'Network Support'),
  (6, 'Administration Assistant');
-- Dumping structure for table dorm_register.dorm_rooms
DROP TABLE IF EXISTS `dorm_rooms`;
CREATE TABLE IF NOT EXISTS `dorm_rooms` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(10) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE = InnoDB AUTO_INCREMENT = 27 DEFAULT CHARSET = utf8mb4;
-- Dumping data for table dorm_register.dorm_rooms: ~26 rows (approximately)
DELETE FROM `dorm_rooms`;
INSERT INTO `dorm_rooms` (`id`, `name`)
VALUES (1, 'A1'),
  (2, 'A2'),
  (3, 'A3'),
  (4, 'A4'),
  (5, 'A5'),
  (6, 'A6'),
  (7, 'A7'),
  (8, 'A8'),
  (9, 'A9'),
  (10, 'A10'),
  (11, 'A11'),
  (12, 'A12'),
  (13, 'B14'),
  (14, 'B16'),
  (15, 'B17'),
  (16, 'B18'),
  (17, 'B19'),
  (18, 'B20'),
  (19, 'B21'),
  (20, 'B22'),
  (21, 'B23'),
  (22, 'B24'),
  (23, 'C27'),
  (24, 'C28'),
  (25, 'C29'),
  (26, 'C30');
-- Dumping structure for table dorm_register.dorm_wardens
DROP TABLE IF EXISTS `dorm_wardens`;
CREATE TABLE IF NOT EXISTS `dorm_wardens` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `first_nm` varchar(50) NOT NULL,
  `last_nm` varchar(50) NOT NULL,
  `email` varchar(255) DEFAULT NULL,
  `gender_id` int(11) NOT NULL,
  `password` varchar(80) DEFAULT NULL,
  `phone_num` int(11) NOT NULL,
  `uuid` varchar(100) DEFAULT uuid_short(),
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT NULL ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `gender_id` (`gender_id`),
  CONSTRAINT `dorm_wardens_ibfk_1` FOREIGN KEY (`gender_id`) REFERENCES `genders` (`id`)
) ENGINE = InnoDB AUTO_INCREMENT = 2 DEFAULT CHARSET = utf8mb4;
-- Dumping data for table dorm_register.dorm_wardens: ~1 rows (approximately)
DELETE FROM `dorm_wardens`;
INSERT INTO `dorm_wardens` (
    `id`,
    `first_nm`,
    `last_nm`,
    `email`,
    `gender_id`,
    `password`,
    `phone_num`,
    `uuid`,
    `created_at`,
    `updated_at`
  )
VALUES (
    1,
    'Gerald',
    'Banks',
    'mail@mail.com',
    1,
    'password',
    0,
    '99805289292759047',
    '2022-06-03 11:19:14',
    NULL
  );
-- Dumping structure for table dorm_register.genders
DROP TABLE IF EXISTS `genders`;
CREATE TABLE IF NOT EXISTS `genders` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `gender` varchar(35) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE = InnoDB AUTO_INCREMENT = 3 DEFAULT CHARSET = utf8mb4;
-- Dumping data for table dorm_register.genders: ~2 rows (approximately)
DELETE FROM `genders`;
INSERT INTO `genders` (`id`, `gender`)
VALUES (1, 'Male'),
  (2, 'Female');
-- Dumping structure for table dorm_register.marksheet
DROP TABLE IF EXISTS `marksheet`;
CREATE TABLE IF NOT EXISTS `marksheet` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `date` date NOT NULL,
  `trainee_id` int(11) NOT NULL,
  `dorm_warden_id` int(11) NOT NULL,
  `mark_status_id` int(11) NOT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT NULL ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `trainee_id` (`trainee_id`),
  KEY `dorm_warden_id` (`dorm_warden_id`),
  KEY `mark_status_id` (`mark_status_id`),
  CONSTRAINT `marksheet_ibfk_1` FOREIGN KEY (`trainee_id`) REFERENCES `trainees` (`id`),
  CONSTRAINT `marksheet_ibfk_2` FOREIGN KEY (`dorm_warden_id`) REFERENCES `dorm_wardens` (`id`),
  CONSTRAINT `marksheet_ibfk_3` FOREIGN KEY (`mark_status_id`) REFERENCES `mark_statuses` (`id`)
) ENGINE = InnoDB AUTO_INCREMENT = 18 DEFAULT CHARSET = utf8mb4;
-- Dumping data for table dorm_register.marksheet: ~6 rows (approximately)
DELETE FROM `marksheet`;
INSERT INTO `marksheet` (
    `id`,
    `date`,
    `trainee_id`,
    `dorm_warden_id`,
    `mark_status_id`,
    `created_at`,
    `updated_at`
  )
VALUES (
    3,
    '2022-06-03',
    2,
    1,
    1,
    '2022-06-03 11:20:30',
    '2022-06-03 11:20:45'
  ),
  (
    4,
    '2022-06-03',
    3,
    1,
    2,
    '2022-06-03 20:49:55',
    NULL
  ),
  (
    5,
    '2022-06-04',
    2,
    1,
    1,
    '2022-06-04 20:28:17',
    NULL
  ),
  (
    12,
    '2022-06-05',
    2,
    1,
    1,
    '2022-06-05 13:38:56',
    '2022-06-05 13:52:08'
  ),
  (
    13,
    '2022-06-05',
    3,
    1,
    2,
    '2022-06-05 13:38:56',
    '2022-06-05 13:51:47'
  ),
  (
    14,
    '2022-06-05',
    5,
    1,
    3,
    '2022-06-05 13:38:56',
    '2022-06-05 13:51:27'
  );
-- Dumping structure for table dorm_register.mark_statuses
DROP TABLE IF EXISTS `mark_statuses`;
CREATE TABLE IF NOT EXISTS `mark_statuses` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `status` varchar(35) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE = InnoDB AUTO_INCREMENT = 4 DEFAULT CHARSET = utf8mb4;
-- Dumping data for table dorm_register.mark_statuses: ~3 rows (approximately)
DELETE FROM `mark_statuses`;
INSERT INTO `mark_statuses` (`id`, `status`)
VALUES (1, 'Present'),
  (2, 'Absent'),
  (3, 'Away');
-- Dumping structure for table dorm_register.trainees
DROP TABLE IF EXISTS `trainees`;
CREATE TABLE IF NOT EXISTS `trainees` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `first_nm` varchar(50) NOT NULL,
  `last_nm` varchar(50) NOT NULL,
  `email` varchar(255) DEFAULT NULL,
  `dob` date NOT NULL,
  `phone_num` varchar(15) NOT NULL,
  `gender_id` int(11) NOT NULL,
  `doorm_room_id` int(11) NOT NULL,
  `course_id` int(11) NOT NULL,
  `uuid` varchar(100) NOT NULL DEFAULT uuid_short(),
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `uuid_idx` (`uuid`) USING BTREE,
  KEY `course_id` (`course_id`) USING BTREE,
  KEY `gender_id_idx` (`gender_id`) USING BTREE,
  KEY `doorm_room_id_idx` (`doorm_room_id`) USING BTREE,
  KEY `course_id_idx` (`course_id`),
  CONSTRAINT `course_id_fk` FOREIGN KEY (`course_id`) REFERENCES `courses` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `dorm_room_id_fk` FOREIGN KEY (`doorm_room_id`) REFERENCES `dorm_rooms` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `gender_id_fk` FOREIGN KEY (`gender_id`) REFERENCES `genders` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `trainees_ibfk_3` FOREIGN KEY (`course_id`) REFERENCES `courses` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE = InnoDB AUTO_INCREMENT = 7 DEFAULT CHARSET = utf8mb4;
-- Dumping data for table dorm_register.trainees: ~3 rows (approximately)
DELETE FROM `trainees`;
INSERT INTO `trainees` (
    `id`,
    `first_nm`,
    `last_nm`,
    `email`,
    `dob`,
    `phone_num`,
    `gender_id`,
    `doorm_room_id`,
    `course_id`,
    `uuid`,
    `created_at`,
    `updated_at`
  )
VALUES (
    2,
    'Roshane',
    'Johnson',
    'roshane@mail.com',
    '2000-10-23',
    '18768062720',
    1,
    8,
    1,
    'bc760645-e1d5-11ec-a377-00155dc498e0',
    '2022-06-01 13:07:35',
    '2022-06-03 20:19:42'
  ),
  (
    3,
    'John',
    'Doe',
    'johndoe@email.com',
    '1998-09-14',
    '18763742942',
    1,
    12,
    1,
    '99805289292759042',
    '2022-06-01 13:21:17',
    '2022-06-03 20:19:42'
  ),
  (
    5,
    'Janesha',
    'Doe',
    'janedoe@email.com',
    '1998-06-15',
    '18767821365',
    2,
    15,
    1,
    '99805289292759045',
    '2022-06-02 17:15:08',
    '2022-06-03 20:19:42'
  );
/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */
;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */
;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */
;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */
;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */
;