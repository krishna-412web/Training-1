CREATE DATABASE  IF NOT EXISTS `addressbook` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `addressbook`;
-- MySQL dump 10.13  Distrib 8.0.38, for Win64 (x86_64)
--
-- Host: localhost    Database: addressbook
-- ------------------------------------------------------
-- Server version	8.0.38

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `gender`
--

DROP TABLE IF EXISTS `gender`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `gender` (
  `genderid` int NOT NULL,
  `gendername` varchar(45) NOT NULL,
  PRIMARY KEY (`genderid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `gender`
--

LOCK TABLES `gender` WRITE;
/*!40000 ALTER TABLE `gender` DISABLE KEYS */;
INSERT INTO `gender` VALUES (1,'Male'),(2,'Female');
/*!40000 ALTER TABLE `gender` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hobbiecontact`
--

DROP TABLE IF EXISTS `hobbiecontact`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `hobbiecontact` (
  `id` int NOT NULL AUTO_INCREMENT,
  `log_id` int NOT NULL,
  `hobbieid` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `log_id_idx` (`log_id`),
  KEY `hobbieid_idx` (`hobbieid`),
  CONSTRAINT `hobbieid` FOREIGN KEY (`hobbieid`) REFERENCES `hobbies` (`hobbieid`),
  CONSTRAINT `log_id` FOREIGN KEY (`log_id`) REFERENCES `log_book` (`log_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hobbiecontact`
--

LOCK TABLES `hobbiecontact` WRITE;
/*!40000 ALTER TABLE `hobbiecontact` DISABLE KEYS */;
/*!40000 ALTER TABLE `hobbiecontact` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hobbies`
--

DROP TABLE IF EXISTS `hobbies`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `hobbies` (
  `hobbieid` int NOT NULL,
  `hobbieName` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`hobbieid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hobbies`
--

LOCK TABLES `hobbies` WRITE;
/*!40000 ALTER TABLE `hobbies` DISABLE KEYS */;
INSERT INTO `hobbies` VALUES (1,'Reading'),(2,'Gardnening'),(3,'Photography'),(4,'Cooking'),(5,'Hiking'),(6,'Painting'),(7,'Cycling'),(8,'Writing'),(9,'Knitting'),(10,'Music');
/*!40000 ALTER TABLE `hobbies` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `log_book`
--

DROP TABLE IF EXISTS `log_book`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `log_book` (
  `log_id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `title` int NOT NULL,
  `firstname` varchar(45) NOT NULL,
  `lastname` varchar(45) NOT NULL,
  `gender` int NOT NULL,
  `dob` date NOT NULL,
  `profile` varchar(320) NOT NULL,
  `house_flat` varchar(45) NOT NULL,
  `street` varchar(45) NOT NULL,
  `city` varchar(45) NOT NULL,
  `state` varchar(45) NOT NULL,
  `pincode` int NOT NULL,
  `email` varchar(320) NOT NULL,
  `phone` decimal(10,0) NOT NULL,
  `hobbies` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`log_id`),
  UNIQUE KEY `user_id_UNIQUE` (`log_id`),
  KEY `uid_idx` (`user_id`),
  CONSTRAINT `uid` FOREIGN KEY (`user_id`) REFERENCES `user` (`uid`)
) ENGINE=InnoDB AUTO_INCREMENT=35 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `log_book`
--

LOCK TABLES `log_book` WRITE;
/*!40000 ALTER TABLE `log_book` DISABLE KEYS */;
INSERT INTO `log_book` VALUES (9,2,1,'Krishna','Renjith',1,'2002-10-31','./images/background7.jpeg','Athippillil House','Tagore Nagar','Muvattupuzha','Kerala',686661,'krenith567@gmail.com',9847987454,NULL),(10,2,3,'Sandhya','M',2,'2024-05-01','./images/background8.jpeg','Ross Palace','20th street','Gurgaon','New Delhi',685210,'sandhyam@gmail.com',9856471203,NULL),(11,1,1,'Anand Vishnu','K V',1,'2001-05-04','./images/michealfaraday11.jpg','Koikkara House','Kumarapuram','Pallikara','Kerala',686752,'anandvishnu0804@gmail.com',9842345689,NULL),(22,1,1,'Krishna','Renjith',1,'2002-10-31','./images/lifeofpix-duna1512-3078631.jpg','Athippillil House','Tagore Nagar','Muvattupuzha','New Delhi',686554,'krenith567@gmail.com',9874561236,NULL),(23,1,1,'Liju Mon ','A P',1,'2002-09-04','./images/background21.jpeg','Aikkaramattathil','Udumbanoor','Karimannor','Kerala',686254,'lijumon2002@gmail.com',8578989845,NULL),(29,1,1,'Harvey','Specter',1,'2024-06-30','./images/background27.jpeg','Specter House','19th street','Manhattan','New York',789456,'harveypearson@gmail.com',6598745632,NULL);
/*!40000 ALTER TABLE `log_book` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `title`
--

DROP TABLE IF EXISTS `title`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `title` (
  `title` int NOT NULL,
  `value` varchar(5) DEFAULT NULL,
  PRIMARY KEY (`title`),
  UNIQUE KEY `log_id_UNIQUE` (`title`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `title`
--

LOCK TABLES `title` WRITE;
/*!40000 ALTER TABLE `title` DISABLE KEYS */;
INSERT INTO `title` VALUES (1,'Mr.'),(2,'Ms.'),(3,'Mrs.'),(4,'Dr.'),(5,'Prof.'),(6,'');
/*!40000 ALTER TABLE `title` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user` (
  `uid` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) DEFAULT NULL,
  `email` varchar(256) DEFAULT NULL,
  `username` varchar(45) DEFAULT NULL,
  `password` varchar(80) DEFAULT NULL,
  `salt` varchar(80) DEFAULT NULL,
  PRIMARY KEY (`uid`),
  UNIQUE KEY `username_UNIQUE` (`username`),
  UNIQUE KEY `email_UNIQUE` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (1,'Krishna Renjith','krenith567@gmail.com','admin','30560FCBD436A723C98F798FA0380394AB8C43ABBA625710B05DCB2EC6507304','PC0VKLc8hEZxQaS0MyASrA=='),(2,'Anand Vishnu KV','anandvishnu0804@gmail.com','editor','D96D90605FCB16AC7900763B359A81EA30436CDA6090E309CC2BD671A9C2B055','4gojp1uX2B+gaL3MRH6csg=='),(6,'Liju mon A P','lijumon2002@gmail.com','liju123','81C3BEA43219D5CD5CEA24EA9997CB8E71E448E306BC25D0C71A34F4A6512508','Lr7/ZGZ25foIK1qeOi/1/A=='),(7,'Harvey Pearson','harveypearson@gmail.com','harvey123','50B336FDE95D33F807AFD8541B5940B64467129D764B48296F6808038BA511EB','mnPnZJyAOIYkLxKztKAchg==');
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-09-19 17:20:03
