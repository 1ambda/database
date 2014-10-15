
/*
 * remove database `university`
 */ 

DROP DATABASE IF EXISTS `university`;
CREATE DATABASE `university` DEFAULT CHARACTER SET=utf8;
USE university;

/*
 * remove tables in reverse order
 */
DROP TABLE IF EXISTS `student`;
DROP TABLE IF EXISTS `instructor`;
DROP TABLE IF EXISTS `department`;

/*
 * http://dba.stackexchange.com/questions/51855/advantages-of-middle-tables-in-one-to-many-relationships
 */

CREATE TABLE `department` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `dept_name` VARCHAR(50) NOT NULL,
  `building` VARCHAR(50) NOT NULL,
  `budget` VARCHAR(50) NOT NULL DEFAULT 0,
  PRIMARY KEY(`id`),
  UNIQUE KEY `ix_dept_name` (`dept_name`)
) ENGINE=InnoDB;

CREATE TABLE `instructor` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `inst_name` VARCHAR(30) NOT NULL,
  `salary` int(13) UNSIGNED NOT NULL,
  `inst_dept` VARCHAR(50) NOT NULL,
  FOREIGN KEY (`inst_dept`) REFERENCES `department` (`dept_name`)
  ON UPDATE CASCADE ON DELETE RESTRICT
) ENGINE=InnoDB;

/*
 * It you do not specify ON UPDATE or ON DELETE constraint, 
 * All update and delete statements will be rejected. 
 * (same as ON UPDATE RESTRICT, ON UPDATE RESTRICT)
 */

CREATE TABLE `student` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `advisor_id` INT(10) UNSIGNED DEFAULT NULL,
  `stud_name` VARCHAR(30) NOT NULL,
  `tot_cred` INT(3) UNSIGNED NOT NULL,
  `stud_dept` VARCHAR(50) NOT NULL,
  FOREIGN KEY (`advisor_id`) REFERENCES `instructor` (`id`)
  ON UPDATE CASCADE ON DELETE SET NULL,
  FOREIGN KEY (`stud_dept`) REFERENCES `department` (`dept_name`)
  ON UPDATE CASCADE ON DELETE RESTRICT
) ENGINE=InnoDB;

/*
 * Self-referencing
 * http://stackoverflow.com/questions/12490031/how-to-add-records-in-self-referencing-table
 */
 
CREATE TABLE `course` (
  `course_id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `title` VARCHAR(50) NOT NULL,
  `credits` INT(3) UNSIGNED NOT NULL DEFAULT 0,
  `course_dept` VARCHAR(50) NOT NULL,
  FOREIGN KEY (`course_dept`) REFERENCES `department` (`dept_name`)
  ON UPDATE CASCADE ON DELETE RESTRICT
) ENGINE=InnoDB;

/*
 * Many to Many
 * http://stackoverflow.com/questions/17459762/mysql-many-to-many-relationship-with-foreign-keys
 */

CREATE TABLE `prereq` (
  `course_id` INT(10) UNSIGNED NOT NULL,
  `prereq_id` INT(10) UNSIGNED NOT NULL,
  PRIMARY KEY (`course_id`, `prereq_id`),
  FOREIGN KEY (`course_id`) REFERENCES `course` (`course_id`)
  ON UPDATE CASCADE ON DELETE CASCADE,
  FOREIGN KEY (`prereq_id`) REFERENCES `course` (`course_id`)
  ON UPDATE CASCADE ON DELETE CASCADE
) ENGINE=InnoDB;

/*
 * TODO
 * 1. Weak Entity
 * http://en.wikipedia.org/wiki/Weak_entity
 * 2. Example OF wek entity
 * http://stackoverflow.com/questions/4741967/could-someone-give-me-an-example-of-a-strong-and-weak-entity-TYPE
 * 3. WHEN TO USE week entity
 * http://programmers.stackexchange.com/questions/178504/when-should-we-use-weak-entities-when-modelling-a-database
 */

/*
 * Data
 */

INSERT INTO `department` (dept_name, building, budget) VALUES
  ("Computer Science", "Network", 1600000),
  ("Economics", "Efficient", 1200000),
  ("Art", "Pretty", 600000),
  ("Business", "Big", 3200000),
  ("Music", "Sound", 120000),
  ("Math", "Theory", 40000),
  ("Statistics", "Probably", 70000);

INSERT INTO `instructor` (inst_name, salary, inst_dept) VALUES
  ("A retired Professor", 65000, "Computer Science"),
  ("Alan Smith", 40000, "Computer Science"),
  ("Cristiano Roony", 38000, "Economics"),
  ("John Marry", 34000, "Economics"),
  ("Marron5", 60000, "Music"),
  ("Peter Drucker", 120000, "Business");

INSERT INTO `student` (advisor_id, stud_name, tot_cred, stud_dept) VALUES
  (1, "Appler", 14, "Computer Science"),
  (2, "Microsofter", 18, "Computer Science"),
  (2, "Googler", 20, "Computer Science"),
  (6, "Mac Marshall", 15, "Economics"),
  (NULL, "Eminem", 17, "Music");

INSERT INTO `course` (title, credits, course_dept) VALUES
  ("Linear Regression", 3, "Math"),
  ("Inferential Statistics", 3, "Statistics"),
  ("Descriptive Statistics", 3, "Statistics"),
  ("Machine Learning", 4, "Computer Science");

INSERT INTO `prereq` (course_id, prereq_id) VALUES
  (4, 3),
  (4, 2),
  (4, 1),
  (3, 2);
