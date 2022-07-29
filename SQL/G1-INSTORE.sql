CREATE DATABASE  IF NOT EXISTS `db_warehouse_app` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `db_warehouse_app`;
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
-- Table structure for table `admin`
--

DROP TABLE IF EXISTS `admin`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `admin` (
  `admin_id` varchar(100) NOT NULL,
  `username` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `status` varchar(155) NOT NULL DEFAULT 'unverified',
  PRIMARY KEY (`admin_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `admin`
--

LOCK TABLES `admin` WRITE;
/*!40000 ALTER TABLE `admin` DISABLE KEYS */;
INSERT INTO `admin` VALUES ('1','admin123','admin123@gmail.com','Admin123*','unverified'),('2','aleanajla','aleanajla123@gmail.com','Alea120802*','unverified'),('8958966f-65a2-4d98-992b-40f2828c4349','admin13','azimachea@gmail.com','$2b$10$oHrJNFtLrbqlnZ647PlYS.QoIpwRAJeEX.q2SwAHeIgNv/DldD67W','unverified'),('ab91ac2e-a348-4a08-829a-856b1606234a','admin12','perareva36@gmail.com','$2b$10$tUC/Db8q86GWTiwvlZv3yOu1DBswtUBBGVMA.OFdok./4/VEyqOIG','verified');
/*!40000 ALTER TABLE `admin` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cart`
--

DROP TABLE IF EXISTS `cart`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cart` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` varchar(150) NOT NULL,
  `product_id` int NOT NULL,
  `qty` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_cartProductId` (`product_id`),
  KEY `fk_userIdCart` (`user_id`),
  CONSTRAINT `fk_cartProductId` FOREIGN KEY (`product_id`) REFERENCES `product` (`id`),
  CONSTRAINT `fk_userIdCart` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=40 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cart`
--

LOCK TABLES `cart` WRITE;
/*!40000 ALTER TABLE `cart` DISABLE KEYS */;
INSERT INTO `cart` VALUES (29,'e7534183-d96c-4f2f-8937-cfdc61be81f0',17,1),(30,'e7534183-d96c-4f2f-8937-cfdc61be81f0',18,3),(31,'e7534183-d96c-4f2f-8937-cfdc61be81f0',15,1),(32,'e7534183-d96c-4f2f-8937-cfdc61be81f0',30,1),(33,'e7534183-d96c-4f2f-8937-cfdc61be81f0',34,1),(39,'0E10719C-BFF8-9514-CDA3-A78E348AC465',29,1);
/*!40000 ALTER TABLE `cart` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `category`
--

DROP TABLE IF EXISTS `category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `category` (
  `categoryId` int NOT NULL AUTO_INCREMENT,
  `categoryName` varchar(150) NOT NULL,
  PRIMARY KEY (`categoryId`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `category`
--

LOCK TABLES `category` WRITE;
/*!40000 ALTER TABLE `category` DISABLE KEYS */;
INSERT INTO `category` VALUES (2,'T-Shirt'),(12,'Shirt'),(14,'Blazer'),(15,'Jacket'),(16,'Denim'),(20,'Skirt');
/*!40000 ALTER TABLE `category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `payment_verif`
--

DROP TABLE IF EXISTS `payment_verif`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `payment_verif` (
  `id` int NOT NULL AUTO_INCREMENT,
  `transaction_header_id` int NOT NULL,
  `img_url` varchar(140) NOT NULL,
  `is_verified` varchar(156) NOT NULL DEFAULT 'false',
  PRIMARY KEY (`id`),
  KEY `fk_paymentTransactionId` (`transaction_header_id`),
  CONSTRAINT `fk_paymentTransactionId` FOREIGN KEY (`transaction_header_id`) REFERENCES `transaction_header` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `payment_verif`
--

LOCK TABLES `payment_verif` WRITE;
/*!40000 ALTER TABLE `payment_verif` DISABLE KEYS */;
INSERT INTO `payment_verif` VALUES (11,27,'http://localhost:4100/images/af370705341ba4122519fee0d4eabd4b.jpg','false'),(12,28,'http://localhost:4100/images/8269cbdfd32b5812df33333674b62881.png','false'),(13,29,'http://localhost:4100/images/1f205dc52a6abcc7a930647042d3747e.jpg','false'),(14,30,'http://localhost:4100/images/6302d6393c42762f6ef9da1251c5a49a.jpg','false');
/*!40000 ALTER TABLE `payment_verif` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product`
--

DROP TABLE IF EXISTS `product`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(60) NOT NULL,
  `price` decimal(12,2) NOT NULL,
  `weight_gram` float NOT NULL,
  `description` varchar(200) NOT NULL,
  `img_url` varchar(140) NOT NULL,
  `categoryId` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product`
--

LOCK TABLES `product` WRITE;
/*!40000 ALTER TABLE `product` DISABLE KEYS */;
INSERT INTO `product` VALUES (12,'Jeans Wide Leg Belel',670000.00,700,'Jeans made of high-waisted stiff fabric and five pockets. Extra long wide leg section with bell. Closure with zipper and metal buttons.','http://localhost:4100/images/623418bb6d3e4032a7c46b296491d97c.jpg',16),(13,'Rustic Blazer with knot',999000.00,700,'Blazer with lapel collar and long sleeves. Double-breasted fastening with matching tie.','http://localhost:4100/images/c36a1f23e170702f4425e94d1026064e.jpg',14),(15,'Blazer Cropped',799000.00,780,'Short blazer with a lapel collar and neckline V. Long sleeves with shoulder pads. Front cover with buttons.','http://localhost:4100/images/704fb8030e0561bf70e633ea92f521cc.jpg',14),(16,'Blaze Oversize Linen',139900.00,800,'Blazer with lapel collar and long sleeves with shoulder padding. Various front pockets with lapel. Front cover cross buttoned.','http://localhost:4100/images/739a112d0b7fd99bee9bd9b1e5e7a490.jpg',14),(17,'Jewelry Buttoned Miniskirt',299000.00,240,'High waist model miniskirt. Assorted decorative paspoil pockets on the front. Jewelry buttoned front cover.','http://localhost:4100/images/2e7bfacf5caa31ee01eeede9fe4ea7ba.jpg',20),(18,'Lose Shirt V Neck',629000.00,200,'Cross-neck V-neck shirt and long-sleeved bloomers.','http://localhost:4100/images/8d23033fa12d76e470283ab55dc7665a.jpg',12),(19,'Linen Shirt Oversize',799000.00,300,'The wide shirt is made of 100% linen. Lapel collar and long sleeves with cuffs. Asymmetrical bottom with various side slits. Buttoned front cover.','http://localhost:4100/images/ba3597cb108d813ee7ab118f25447c4d.jpg',12),(20,'Embroidered Kit Blouse',1399000.00,600,'Lapel collar blouse and long sleeves A-line hem. Bottom hems with various knots. Buttoned front cover.','http://localhost:4100/images/14091d32899f45065c0d0556a938eda2.jpg',12),(21,'Snoopy PEANUTS™ T-shirts',499900.00,150,'Round collar and short sleeves. Details in the form of a combination of contrasting embroidery from Snoopy PEANUTS™.','http://localhost:4100/images/ee8cea5cec83639385c9eccc737ce5e1.jpg',2),(22,'Minimalist T-Shirt',199000.00,130,'Minimalist round neck short sleeve T-shirt with matching visible topstitching.','http://localhost:4100/images/b8f2acc0cfa55fe2306281a4231f2a2f.jpg',2),(23,'Bee Jewelry T-Shirt',499900.00,150,'Round collar and short sleeves. Patch pocket on chest. Details in the form of jewelry applications in the shape of a bee.','http://localhost:4100/images/743a86b0c149714ef402ebd6cc307f12.jpg',2),(24,'Outside Shirt Fall Material',999900.00,560,'Lapel collared overshirt and long sleeves, rolled up hem with hooks and buttons. Various patch pockets in front with lapel. Waist is easy to adjust. Buttoned front cover.','http://localhost:4100/images/dbf01aca76ced328321af6cfb7213511.jpg',15),(25,'Rimple Open Jacket',799900.00,500,'Round collared jacket with long hem with hooks and buttons. Various patch pockets in front with lapel. The bottom of the hem is ruffled.','http://localhost:4100/images/c1b03952537dc4ef7ad493b29f9dab17.jpg',15),(26,'Synthetic Leather Jacket',1099000.00,1050,'Lapel collared jacket with long sleeves. Multiple front pockets with metal zippers. Detail in the form of a hook on the shoulder. The application is a cloth belt made of the same material as a buckle.','http://localhost:4100/images/007102e245ebac5c969e260711d414a6.jpg',15),(27,'Embroidered Kimono',3499900.00,775,'Kimono with V-neckline and wide sleeves. Belt made of the same fabric. Details in the form of embroidered combinations of contrasting patterns.','http://localhost:4100/images/21a30f4f99ab9c22c88bba4f9989c8a4.jpg',15),(28,'Jumpsuit Denim Full Length',1099000.00,876,'Lapel collared jumpsuit and sleeves. Various patch pockets on the chest and on the back and sides. Slit detail at waist. Front closure with zipper and metal button.','http://localhost:4100/images/e92c21a07de6bfe257118513e23db1e1.jpg',16),(29,'Bermuda Denim Trousers',699000.00,235,'High-waisted Bermuda pants with various patch pockets at the back. Various slit detail at the waist. Front closure with zipper and metal buttons.','http://localhost:4100/images/bcb34ea683fb0a6bb51b0ffd5e3e0568.jpg',16),(30,'Jeans Z1975 Mom Fit',699000.00,600,'High waist jeans with five pockets. Faded effect. Front closure with zipper and metal buttons.','http://localhost:4100/images/55f916ea2d1d33894c62a338cca68c2c.jpg',16),(31,'Fold Pants Skirt',629000.00,345,'High-waist skort with pleat on the front. Fastening on the front with zip and metal hook.','http://localhost:4100/images/1323e5f4541cdb40cff1b01b6ffc9d0a.jpg',20),(32,'Long Pants With Folds Skirt',699000.00,230,'High-waisted skirt with buttons in the front. Side closure with seam closed zip.','http://localhost:4100/images/40bbf20bed4724f34cb83ac9b80bd2bc.jpg',20),(33,'Asymetric Long Pants Skirt',629000.00,240,'High-waisted trouser skirt. Details in the form of overlapping fabrics made from the same type of pareo. Side closure with seam closed zip.','http://localhost:4100/images/52be00fd40b88627130471dcf2336006.jpg',20),(34,'Vest Without Lapel',1099000.00,460,'V-neck striped vest without lapel and sleeve cuffs. Assorted pockets with placket in front. Buttoned front cover.','http://localhost:4100/images/936ce87576d7e41d1a6a8bd9a50ae9f5.jpg',14),(35,'Outboard Pocket Blazer',1399000.00,1030,'Blazer with lapel collar and long sleeves with shoulder padding. Various pockets in front of the patch. Gold buttoned front cover.','http://localhost:4100/images/55f4a6ca595cbb91093ffad752f36c72.jpg',14);
/*!40000 ALTER TABLE `product` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `registration_token`
--

DROP TABLE IF EXISTS `registration_token`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `registration_token` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` varchar(150) NOT NULL,
  `token` varchar(250) NOT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `registration_token`
--

LOCK TABLES `registration_token` WRITE;
/*!40000 ALTER TABLE `registration_token` DISABLE KEYS */;
INSERT INTO `registration_token` VALUES (1,'5b144429-3f3d-4724-a4b1-969f16863e9b','eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI1YjE0NDQyOS0zZjNkLTQ3MjQtYTRiMS05NjlmMTY4NjNlOWIiLCJpYXQiOjE2NTg2NzYzNzksImV4cCI6MTY1ODc2Mjc3OX0.olMSK_L50vO4qz6P6GnNMCBg5fOw9AozciUu25Fjjwc','2022-07-24 22:26:19'),(2,'2a3e6331-7504-40b4-b644-c3dc69dbd323','eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiIyYTNlNjMzMS03NTA0LTQwYjQtYjY0NC1jM2RjNjlkYmQzMjMiLCJpYXQiOjE2NTg3NTI5MDgsImV4cCI6MTY1ODgzOTMwOH0.exTqtT-Y3ad_s--HO837bEUeYXChIe8ZzBg8qEa-VMY','2022-07-25 19:41:48');
/*!40000 ALTER TABLE `registration_token` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `stock`
--

DROP TABLE IF EXISTS `stock`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `stock` (
  `id` int NOT NULL AUTO_INCREMENT,
  `product_id` int NOT NULL,
  `warehouse_id` int NOT NULL,
  `stock` int NOT NULL,
  `reserved_stock` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_stockWarehouseId` (`product_id`),
  KEY `fk_warehouseIdStock` (`warehouse_id`),
  CONSTRAINT `fk_stockProductId` FOREIGN KEY (`product_id`) REFERENCES `product` (`id`),
  CONSTRAINT `fk_warehouseIdStock` FOREIGN KEY (`warehouse_id`) REFERENCES `warehouses` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `stock`
--

LOCK TABLES `stock` WRITE;
/*!40000 ALTER TABLE `stock` DISABLE KEYS */;
INSERT INTO `stock` VALUES (6,12,1,30,0),(7,15,3,15,0),(12,17,3,25,0),(13,18,1,20,0),(14,22,1,10,0),(15,31,3,23,0),(16,24,1,17,0),(17,35,3,13,0),(18,25,1,26,0),(19,30,3,31,0),(20,26,1,23,0),(21,34,3,10,0),(22,23,1,10,0),(23,23,3,25,0),(24,29,1,14,0),(25,28,1,10,0),(26,21,1,30,0);
/*!40000 ALTER TABLE `stock` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `transaction_detail`
--

DROP TABLE IF EXISTS `transaction_detail`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `transaction_detail` (
  `id` int NOT NULL AUTO_INCREMENT,
  `transaction_header_id` int NOT NULL,
  `product_id` int NOT NULL,
  `qty` int NOT NULL,
  `price` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_detailHeaderId_idx` (`transaction_header_id`),
  KEY `fk_detailProductId_idx` (`product_id`),
  CONSTRAINT `fk_detailHeaderId` FOREIGN KEY (`transaction_header_id`) REFERENCES `transaction_header` (`id`),
  CONSTRAINT `fk_detailProductId` FOREIGN KEY (`product_id`) REFERENCES `product` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=38 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `transaction_detail`
--

LOCK TABLES `transaction_detail` WRITE;
/*!40000 ALTER TABLE `transaction_detail` DISABLE KEYS */;
INSERT INTO `transaction_detail` VALUES (1,1,12,3,670000),(2,2,13,2,999000),(3,3,15,1,799000),(4,4,16,1,139900),(6,5,17,2,299000),(7,6,18,1,629000),(8,7,19,2,799000),(9,8,20,3,1399000),(10,9,21,1,499900),(11,10,22,2,199000),(28,27,15,1,799000),(29,27,12,1,670000),(30,28,15,1,799000),(31,28,12,1,670000),(32,28,18,1,629000),(33,29,15,1,799000),(34,30,35,2,1399000),(35,30,31,1,629000),(36,30,21,1,499900),(37,30,23,1,499900);
/*!40000 ALTER TABLE `transaction_detail` ENABLE KEYS */;
UNLOCK TABLES;

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
  `status` varchar(22) NOT NULL DEFAULT 'pending',
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
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `transaction_header`
--

LOCK TABLES `transaction_header` WRITE;
/*!40000 ALTER TABLE `transaction_header` DISABLE KEYS */;
INSERT INTO `transaction_header` VALUES (1,'B5743',3,'0E10719C-BFF8-9514-CDA3-A78E348AC465','pending','0000-00-00 00:00:00',60000,'2022-05-11 00:00:00',NULL,'Jln Akasia 12','Padang','12345','Sumatera Barat',12.99999999,999.99999999),(2,'B12A9',1,'11603E82-4A35-AD4A-87DA-CF2386DE880B','pending','0000-00-00 00:00:00',2000000,'2022-05-10 00:00:00',NULL,'Jln kemangi 17','Kuningan','54321','Jawa Barat',99.99999999,999.99999999),(3,'B12A8',3,'1B5D97EB-FE4A-59EE-E13B-8EDEE1C19FCA','pending','0000-00-00 00:00:00',1000000,'2022-05-15 00:00:00',NULL,'Jln Akasia 12','Padang','98765','Sumatera Barat',99.99999999,999.99999999),(4,'B6758',1,'851ADD42-0F79-7B80-17EB-E9A3EAB4791C','pending','0000-00-00 00:00:00',200000,'2022-06-17 00:00:00',NULL,'Jln Kenanga 11','Surabaya','87909','Jawa Timur',99.99999999,999.99999999),(5,'B6666',3,'C4950E46-50BF-6AB1-EB5E-08AD3809DE73','pending','0000-00-00 00:00:00',300000,'2022-06-17 00:00:00',NULL,'Jln Mawar 11','Jakarta','90908','DKI Jakarta',99.99999999,999.99999999),(6,'B3746',1,'DD1FC4B9-F195-5CCC-8982-3AB9AC6C5D57','pending','0000-00-00 00:00:00',500000,'2022-06-11 00:00:00',NULL,'Jln Anggrek 11','Jakarta','90909','DKI Jakarta',99.99999999,999.99999999),(7,'B2384',3,'DDA2ABB5-9A80-1BA1-B2D4-D7A3A7611152','pending','0000-00-00 00:00:00',900000,'2022-07-01 00:00:00',NULL,'Jln Boulevard 5','Bekasi','38439','Jawa Barat',99.99999999,999.99999999),(8,'B3678',1,'E1BE7B09-570B-DFAE-F85D-9A491C17311A','pending','0000-00-00 00:00:00',100000,'2022-07-01 00:00:00',NULL,'Jln Boulevard 4','Bekasi','29928','Jawa Barat',99.99999999,999.99999999),(9,'B887Y',1,'CAB25192-4AE1-B2A5-19EB-C4B5482949A9','pending','0000-00-00 00:00:00',500000,'2022-07-02 00:00:00',NULL,'jln Boulevard 10','Karawang','90290','Jawa Barat',99.99999999,999.99999999),(10,'B91029',3,'ECDE1236-5F6E-15B8-9CAB-437873EDA2CB','pending','0000-00-00 00:00:00',800000,'2022-07-03 00:00:00',NULL,'Jln Boulevard 11','Purwakarta','92029','Jawa Barat',99.99999999,999.99999999),(27,'TR108',1,'e7534183-d96c-4f2f-8937-cfdc61be81f0','pending',NULL,1552450,'2022-07-25 22:15:07',NULL,'Jl. Komp. Puri Bintaro, Sawah Baru, Kec. Ciputat, Kota Tangerang Selatan, Banten 15413','Tangerang Selatan','15413','Banten',-6.28671398,106.71744259),(28,'TR466',1,'e7534183-d96c-4f2f-8937-cfdc61be81f0','pending',NULL,2211900,'2022-07-25 23:05:17',NULL,'Jl. Alam Segar I Blok Us No.6, RT.9/RW.16, Pd. Pinang, Kec. Kby. Lama, Kota Jakarta Selatan, Daerah Khusus Ibukota Jakarta 12310','Jakarta Selatan','12310','DKI Jakarta',-6.26848525,106.78267973),(29,'TR967',1,'e7534183-d96c-4f2f-8937-cfdc61be81f0','pending',NULL,850950,'2022-07-25 23:06:12',NULL,'Jl. Alam Segar I Blok Us No.6, RT.9/RW.16, Pd. Pinang, Kec. Kby. Lama, Kota Jakarta Selatan, Daerah Khusus Ibukota Jakarta 12310','Jakarta Selatan','12310','DKI Jakarta',-6.26848525,106.78267973),(30,'TR365',1,'0E10719C-BFF8-9514-CDA3-A78E348AC465','Approved',NULL,4658140,'2022-07-28 22:50:30',NULL,'236-2456 Mattis. Rd.','Kendari','55295','West Papua',99.99999999,999.99999999);
/*!40000 ALTER TABLE `transaction_header` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `transaction_shipping`
--

DROP TABLE IF EXISTS `transaction_shipping`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `transaction_shipping` (
  `id` int NOT NULL AUTO_INCREMENT,
  `transaction_header_id` int NOT NULL,
  `warehouse_id` int NOT NULL,
  `product_id` int NOT NULL,
  `qty` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_shippingTransaction` (`transaction_header_id`),
  KEY `fk_shippingWarehouse` (`warehouse_id`),
  KEY `fk_shippingProduct` (`product_id`),
  CONSTRAINT `fk_shippingProduct` FOREIGN KEY (`product_id`) REFERENCES `product` (`id`),
  CONSTRAINT `fk_shippingTransaction` FOREIGN KEY (`transaction_header_id`) REFERENCES `transaction_header` (`id`),
  CONSTRAINT `fk_shippingWarehouse` FOREIGN KEY (`warehouse_id`) REFERENCES `warehouses` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `transaction_shipping`
--

LOCK TABLES `transaction_shipping` WRITE;
/*!40000 ALTER TABLE `transaction_shipping` DISABLE KEYS */;
/*!40000 ALTER TABLE `transaction_shipping` ENABLE KEYS */;
UNLOCK TABLES;

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
  `status` varchar(155) NOT NULL DEFAULT 'inactive',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES ('0E10719C-BFF8-9514-CDA3-A78E348AC465','denywi2','szalai@gmail.com','$2b$10$WvUJNihMRPnatQb19FjEcuP/Fr249O88M8zd7lllKwYHy.WUQ2p6a','active'),('1','aleanajla','aleanajal@gmail.com','aleanajlaa12','active'),('11603E82-4A35-AD4A-87DA-CF2386DE880B','reecejames','reezz@gmail.com','sjakjakj','active'),('1B5D97EB-FE4A-59EE-E13B-8EDEE1C19FCA','dtbowo','dtprabowo188@gmail.com','$2b$10$W8nPIQqpMbTOVoFeNUYpTugJp4xCuYUVDvcadKch4u5ZakTb5DDpm','active'),('2a3e6331-7504-40b4-b644-c3dc69dbd323','test12333','dtprabowo19@gmail.com','$2b$10$K2ow5RtnlYxtcygy89oA6.39SVUe/2CisAuHpl.8jb0a6Sbu9krei','active'),('5b144429-3f3d-4724-a4b1-969f16863e9b','dimastrip','dtprabowo11@gmail.com','$2b$10$kv5z8/4XXorV4dX9zwrIZ.zURzr5hpgizHuR4CfPrPD9iyh0xU.ZS','active'),('851ADD42-0F79-7B80-17EB-E9A3EAB4791C','nicogoblin','nico@gmail.com','sjakjkasj','active'),('a48365dc-d30e-45b4-b326-2111d43d7888','xxxxxx','xxxx','$2b$10$3lE7UenGrcBgXvxXBe6KTuUBQCVghtREBD4rwGnEnYYMit4vyEWPW','inactive'),('C4950E46-50BF-6AB1-EB5E-08AD3809DE73','georgediaz','gdiaz@gmail.com','$2b$10$8ODcqgunS7si5R2bQfxoKO1JolJiAk.HlDBDl4yofTplPBMj8PSve','inactive'),('CAB25192-4AE1-B2A5-19EB-C4B5482949A9','andypurgatory','purge@gmail.com','sutggs','active'),('DD1FC4B9-F195-5CCC-8982-3AB9AC6C5D57','jorgemendez','Jmendez@gmail.com','skjaskjaksj','active'),('DDA2ABB5-9A80-1BA1-B2D4-D7A3A7611152','lorenzgossling','lgossling@gmail.com','asjsakjkjasj','active'),('e15cda05-6bfa-427d-b7ad-bf247e511c2d','zzzzz','zzzz','$2b$10$9QRpPQQen.PjcOa7xf5GP.9d.iArFsmFBX6FxBYb2/Kp8rrkUYJIS','inactive'),('E1BE7B09-570B-DFAE-F85D-9A491C17311A','michaelpage','michael@yahoo.com','skaokao','active'),('e7534183-d96c-4f2f-8937-cfdc61be81f0','denywi','dtprabowo1@gmail.com','$2b$10$WvUJNihMRPnatQb19FjEcuP/Fr249O88M8zd7lllKwYHy.WUQ2p6a','active'),('ECDE1236-5F6E-15B8-9CAB-437873EDA2CB','deniwijaya','deny.wijaya23@gmail.com','Deny12345','active');
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_address`
--

DROP TABLE IF EXISTS `user_address`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_address` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` varchar(150) NOT NULL,
  `address` varchar(140) DEFAULT NULL,
  `postal` varchar(10) DEFAULT NULL,
  `city` varchar(20) DEFAULT NULL,
  `province` varchar(20) DEFAULT NULL,
  `label` varchar(255) DEFAULT NULL,
  `latitude` decimal(10,8) DEFAULT NULL,
  `longitude` decimal(11,8) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_userIdAddress` (`user_id`),
  CONSTRAINT `fk_userIdAddress` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_address`
--

LOCK TABLES `user_address` WRITE;
/*!40000 ALTER TABLE `user_address` DISABLE KEYS */;
INSERT INTO `user_address` VALUES (1,'0E10719C-BFF8-9514-CDA3-A78E348AC465','236-2456 Mattis. Rd.','55295','Kendari','West Papuaa','Home',99.99999999,999.99999999),(2,'11603E82-4A35-AD4A-87DA-CF2386DE880B','640-6991 Eget, Street','25524','Palangka Raya','Aceh','Home',99.99999999,999.99999999),(3,'1B5D97EB-FE4A-59EE-E13B-8EDEE1C19FCA','876-5296 Egestas Rd.','82664','Dumai','East Nusa Tenggara','Home',99.99999999,999.99999999),(4,'851ADD42-0F79-7B80-17EB-E9A3EAB4791C','8310 Lectus Road','74828','Semarang','East Java','Home',99.99999999,999.99999999),(5,'C4950E46-50BF-6AB1-EB5E-08AD3809DE73','Ap #842-3938 Et, Av.','87724','Tanjung Pinang','Aceh','Home',99.99999999,999.99999999),(6,'CAB25192-4AE1-B2A5-19EB-C4B5482949A9','Ap #664-7919 Dolor Rd.','56551','Kupang','Papua','Home',99.99999999,999.99999999),(7,'DD1FC4B9-F195-5CCC-8982-3AB9AC6C5D57','Ap #815-3894 Netus Rd.','95354','Tidore','East Java','Home',99.99999999,999.99999999),(8,'DDA2ABB5-9A80-1BA1-B2D4-D7A3A7611152','P.O. Box 786, 6243 Magna. Road','34130','Tual','East Nusa Tenggara','Home',99.99999999,999.99999999),(9,'E1BE7B09-570B-DFAE-F85D-9A491C17311A','454-4658 Ut Street','41548','Tanjung Pinang','Papua','Home',99.99999999,999.99999999),(10,'ECDE1236-5F6E-15B8-9CAB-437873EDA2CB','P.O. Box 534, 1080 Neque Ave','84208','Semarang','West Java','Home',99.99999999,999.99999999),(11,'a48365dc-d30e-45b4-b326-2111d43d7888',NULL,NULL,NULL,NULL,NULL,NULL,NULL),(12,'e15cda05-6bfa-427d-b7ad-bf247e511c2d',NULL,NULL,NULL,NULL,NULL,NULL,NULL),(13,'5b144429-3f3d-4724-a4b1-969f16863e9b','','','','','Office',NULL,NULL),(14,'2a3e6331-7504-40b4-b644-c3dc69dbd323','','','Surabaya','','Home',NULL,NULL),(15,'e7534183-d96c-4f2f-8937-cfdc61be81f0','Jl. Komp. Puri Bintaro, Sawah Baru, Kec. Ciputat, Kota Tangerang Selatan, Banten 15413','15413','Tangerang Selatan','Banten','Home',-6.28671398,106.71744259),(16,'e7534183-d96c-4f2f-8937-cfdc61be81f0','Jl. Alam Segar I Blok Us No.6, RT.9/RW.16, Pd. Pinang, Kec. Kby. Lama, Kota Jakarta Selatan, Daerah Khusus Ibukota Jakarta 12310','12310','Jakarta Selatan','DKI Jakarta','Anida\'s Home',-6.26848525,106.78267973);
/*!40000 ALTER TABLE `user_address` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `warehouses`
--

DROP TABLE IF EXISTS `warehouses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `warehouses` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name_location` varchar(150) NOT NULL,
  `address` varchar(140) NOT NULL,
  `city` varchar(20) NOT NULL,
  `province` varchar(20) NOT NULL,
  `postal` varchar(10) NOT NULL,
  `latitude` decimal(10,8) NOT NULL,
  `longitude` decimal(11,8) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `warehouses`
--

LOCK TABLES `warehouses` WRITE;
/*!40000 ALTER TABLE `warehouses` DISABLE KEYS */;
INSERT INTO `warehouses` VALUES (1,'Bekasi','Jl. Raya Teuku Umar, Gandasari, Kec. Cibitung, Kabupaten Bekasi, Jawa Barat 17510','Bekasi','Jawa Barat','17510',-6.26979813,107.08584769),(3,'Banten','Link. Kubangsaron, Jl. Kyai H. Mudzakir, Tegalratu, Kec. Ciwandan, Kota Cilegon, Banten','Cilegon','Banten','42445',-6.01990344,105.98459415);
/*!40000 ALTER TABLE `warehouses` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-07-29  1:46:37
