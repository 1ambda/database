USE university;

/*
 * remove tables in reverse order
 */
DROP TABLE IF EXISTS `student`;
DROP TABLE IF EXISTS `instructor`;

CREATE TABLE `instructor` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `name` VARCHAR(30) NOT NULL,
  `salary` int(13) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARACTER SET=utf8;

CREATE TABLE `student` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `advisor_id` INT(10) UNSIGNED DEFAULT NULL,
  `name` VARCHAR(30) NOT NULL,
  `tot_cred` INT(3) NOT NULL,
  FOREIGN KEY (`advisor_id`) REFERENCES `instructor` (`id`) ON UPDATE CASCADE ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARACTER SET=utf8;

/*
 * It you do not specify ON UPDATE or ON DELETE constraint, 
 * All update and delete statements will be rejected. 
 * (same as ON UPDATE RESTRICT, ON UPDATE RESTRICT)
 */

INSERT INTO `instructor` (name, salary) VALUES
  ("A retired Professor", 65000),
  ("Alan Smith", 40000),
  ("Cristiano Roony", 38000),
  ("John Marry", 34000);

INSERT INTO `student` (advisor_id, name, tot_cred) VALUES
  (1, "Appler", 14),
  (2, "Microsofter", 18),
  (3, "Googler", 20);

UPDATE `instructor` SET name="John Terry", id="5" WHERE id=4;
DELETE FROM `instructor` WHERE id=1; 

