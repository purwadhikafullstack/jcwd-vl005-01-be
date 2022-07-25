-- MySQL dump 10.13  Distrib 8.0.28, for Win64 (x86_64)
--
-- Host: localhost    Database: db_warehouse_app
-- ------------------------------------------------------
-- Server version	8.0.28

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
-- Table structure for table `transaction_header`
--

DROP TABLE IF EXISTS `transaction_header`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `transaction_header` (
  `id` int NOT NULL AUTO_INCREMENT,
  `tcode` varchar(255) NOT NULL,
  `shipping_warehouse_id` int NOT NULL,
  `user_id` varchar(150) NOT NULL,
  `status` varchar(20) NOT NULL DEFAULT '''pending''',
  `shipped_date` datetime DEFAULT NULL,
  `grand_total` int NOT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT NULL,
  `address` varchar(255) NOT NULL,
  `city` varchar(255) NOT NULL,
  `postal` varchar(255) NOT NULL,
  `province` varchar(255) NOT NULL,
  `latitude` decimal(10,8) NOT NULL,
  `longitude` decimal(11,8) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_userIdTransactionHeader` (`user_id`),
  CONSTRAINT `fk_userIdTransactionHeader` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `transaction_header`
--

LOCK TABLES `transaction_header` WRITE;
/*!40000 ALTER TABLE `transaction_header` DISABLE KEYS */;
INSERT INTO `transaction_header` VALUES (1,'B5743',3,'0E10719C-BFF8-9514-CDA3-A78E348AC465','Approved','0000-00-00 00:00:00',60000,'2022-05-11 00:00:00',NULL,'Jln Akasia 12','Padang','12345','Sumatera Barat',12.99999999,999.99999999),(2,'B12A9',3,'11603E82-4A35-AD4A-87DA-CF2386DE880B','pending','0000-00-00 00:00:00',2000000,'2022-05-10 00:00:00',NULL,'Jln kemangi 17','Kuningan','54321','Jawa Barat',99.99999999,999.99999999),(3,'B12A8',2,'1B5D97EB-FE4A-59EE-E13B-8EDEE1C19FCA','pending','0000-00-00 00:00:00',1000000,'2022-05-15 00:00:00',NULL,'Jln Akasia 12','Padang','98765','Sumatera Barat',99.99999999,999.99999999),(4,'B6758',1,'851ADD42-0F79-7B80-17EB-E9A3EAB4791C','pending','0000-00-00 00:00:00',200000,'2022-06-17 00:00:00',NULL,'Jln Kenanga 11','Surabaya','87909','Jawa Timur',99.99999999,999.99999999),(5,'B6666',2,'C4950E46-50BF-6AB1-EB5E-08AD3809DE73','pending','0000-00-00 00:00:00',300000,'2022-06-17 00:00:00',NULL,'Jln Mawar 11','Jakarta','90908','DKI Jakarta',99.99999999,999.99999999),(6,'B3746',3,'DD1FC4B9-F195-5CCC-8982-3AB9AC6C5D57','pending','0000-00-00 00:00:00',500000,'2022-06-11 00:00:00',NULL,'Jln Anggrek 11','Jakarta','90909','DKI Jakarta',99.99999999,999.99999999),(7,'B2384',2,'DDA2ABB5-9A80-1BA1-B2D4-D7A3A7611152','pending','0000-00-00 00:00:00',900000,'2022-07-01 00:00:00',NULL,'Jln Boulevard 5','Bekasi','38439','Jawa Barat',99.99999999,999.99999999),(8,'B3678',1,'E1BE7B09-570B-DFAE-F85D-9A491C17311A','pending','0000-00-00 00:00:00',100000,'2022-07-01 00:00:00',NULL,'Jln Boulevard 4','Bekasi','29928','Jawa Barat',99.99999999,999.99999999),(9,'B887Y',1,'CAB25192-4AE1-B2A5-19EB-C4B5482949A9','pending','0000-00-00 00:00:00',500000,'2022-07-02 00:00:00',NULL,'jln Boulevard 10','Karawang','90290','Jawa Barat',99.99999999,999.99999999),(10,'B91029',2,'ECDE1236-5F6E-15B8-9CAB-437873EDA2CB','pending','0000-00-00 00:00:00',800000,'2022-07-03 00:00:00',NULL,'Jln Boulevard 11','Purwakarta','92029','Jawa Barat',99.99999999,999.99999999);
/*!40000 ALTER TABLE `transaction_header` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-07-25 21:12:50
