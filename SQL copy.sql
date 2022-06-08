DROP TABLE IF EXISTS `courses`;
CREATE TABLE IF NOT EXISTS `courses` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE = InnoDB AUTO_INCREMENT = 7 DEFAULT CHARSET = utf8mb4 COMMENT = 'All the courses available at HEART NSTA Stony Hill';
DROP TABLE IF EXISTS `dorm_rooms`;
CREATE TABLE IF NOT EXISTS `dorm_rooms` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(10) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE = InnoDB AUTO_INCREMENT = 27 DEFAULT CHARSET = utf8mb4;
DROP TABLE IF EXISTS `dorm_wardens`;
CREATE TABLE IF NOT EXISTS `dorm_wardens` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `first_nm` varchar(50) NOT NULL,
  `last_nm` varchar(50) NOT NULL,
  `email` varchar(255) DEFAULT NULL,
  `gender_id` int(11) NOT NULL,
  `password` varchar(80) DEFAULT NULL,
  `phone_num` int(11) NOT NULL,
  `uuid` varchar(100) DEFAULT UUID_SHORT(),
  `created_at` DATETIME DEFAULT CURRENT_TIMESTAMP(),
  `updated_at` DATETIME DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(),
  PRIMARY KEY (`id`),
  KEY `gender_id` (`gender_id`),
  CONSTRAINT `dorm_wardens_ibfk_1` FOREIGN KEY (`gender_id`) REFERENCES `genders` (`id`)
) ENGINE = InnoDB AUTO_INCREMENT = 2 DEFAULT CHARSET = utf8mb4;
DROP TABLE IF EXISTS `genders`;
CREATE TABLE IF NOT EXISTS `genders` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `gender` varchar(35) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE = InnoDB AUTO_INCREMENT = 3 DEFAULT CHARSET = utf8mb4;
DROP TABLE IF EXISTS `marksheet`;
CREATE TABLE IF NOT EXISTS `marksheet` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `date` date NOT NULL,
  `trainee_id` int(11) NOT NULL,
  `dorm_warden_id` int(11) NOT NULL,
  `mark_status_id` int(11) NOT NULL,
  `created_at` DATETIME DEFAULT CURRENT_TIMESTAMP(),
  `updated_at` DATETIME DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(),
  PRIMARY KEY (`id`),
  KEY `trainee_id` (`trainee_id`),
  KEY `dorm_warden_id` (`dorm_warden_id`),
  KEY `mark_status_id` (`mark_status_id`),
  CONSTRAINT `marksheet_ibfk_1` FOREIGN KEY (`trainee_id`) REFERENCES `trainees` (`id`),
  CONSTRAINT `marksheet_ibfk_2` FOREIGN KEY (`dorm_warden_id`) REFERENCES `dorm_wardens` (`id`),
  CONSTRAINT `marksheet_ibfk_3` FOREIGN KEY (`mark_status_id`) REFERENCES `mark_statuses` (`id`)
) ENGINE = InnoDB AUTO_INCREMENT = 18 DEFAULT CHARSET = utf8mb4;
DROP TABLE IF EXISTS `mark_statuses`;
CREATE TABLE IF NOT EXISTS `mark_statuses` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `status` varchar(35) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE = InnoDB AUTO_INCREMENT = 4 DEFAULT CHARSET = utf8mb4;
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
  `uuid` varchar(100) NOT NULL DEFAULT UUID_SHORT(),
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP(),
  `updated_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP() ON UPDATE CURRENT_TIMESTAMP(),
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