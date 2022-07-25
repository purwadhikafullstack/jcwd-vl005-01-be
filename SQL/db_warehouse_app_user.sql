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
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user` (
  `id` varchar(150) NOT NULL,
  `username` varchar(60) NOT NULL,
  `email` varchar(60) NOT NULL,
  `password` varchar(140) NOT NULL,
  `status` varchar(150) NOT NULL DEFAULT '''inactive''',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES ('0E10719C-BFF8-9514-CDA3-A78E348AC465','denywi','szalai@gmail.com','$2b$10$WvUJNihMRPnatQb19FjEcuP/Fr249O88M8zd7lllKwYHy.WUQ2p6a','active'),('1','aleanajla','aleanajal@gmail.com','aleanajlaa12','active'),('11603E82-4A35-AD4A-87DA-CF2386DE880B','reecejames','reezz@gmail.com','sjakjakj','active'),('1B5D97EB-FE4A-59EE-E13B-8EDEE1C19FCA','dtbowo','dtprabowo1@gmail.com','$2b$10$W8nPIQqpMbTOVoFeNUYpTugJp4xCuYUVDvcadKch4u5ZakTb5DDpm','active'),('2a3e6331-7504-40b4-b644-c3dc69dbd323','test12333','dtprabowo19@gmail.com','$2b$10$K2ow5RtnlYxtcygy89oA6.39SVUe/2CisAuHpl.8jb0a6Sbu9krei','active'),('5b144429-3f3d-4724-a4b1-969f16863e9b','dimastrip','dtprabowo11@gmail.com','$2b$10$kv5z8/4XXorV4dX9zwrIZ.zURzr5hpgizHuR4CfPrPD9iyh0xU.ZS','active'),('851ADD42-0F79-7B80-17EB-E9A3EAB4791C','nicogoblin','nico@gmail.com','sjakjkasj','active'),('a48365dc-d30e-45b4-b326-2111d43d7888','xxxxxx','xxxx','$2b$10$3lE7UenGrcBgXvxXBe6KTuUBQCVghtREBD4rwGnEnYYMit4vyEWPW','\'inactive\''),('C4950E46-50BF-6AB1-EB5E-08AD3809DE73','georgediaz','gdiaz@gmail.com','$2b$10$8ODcqgunS7si5R2bQfxoKO1JolJiAk.HlDBDl4yofTplPBMj8PSve','inactive'),('CAB25192-4AE1-B2A5-19EB-C4B5482949A9','andypurgatory','purge@gmail.com','sutggs','active'),('DD1FC4B9-F195-5CCC-8982-3AB9AC6C5D57','jorgemendez','Jmendez@gmail.com','skjaskjaksj','active'),('DDA2ABB5-9A80-1BA1-B2D4-D7A3A7611152','lorenzgossling','lgossling@gmail.com','asjsakjkjasj','active'),('e15cda05-6bfa-427d-b7ad-bf247e511c2d','zzzzz','zzzz','$2b$10$9QRpPQQen.PjcOa7xf5GP.9d.iArFsmFBX6FxBYb2/Kp8rrkUYJIS','\'inactive\''),('E1BE7B09-570B-DFAE-F85D-9A491C17311A','michaelpage','michael@yahoo.com','skaokao','active'),('ECDE1236-5F6E-15B8-9CAB-437873EDA2CB','deniwijaya','deny.wijaya23@gmail.com','Deny12345','active');
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

-- Dump completed on 2022-07-25 21:12:50
