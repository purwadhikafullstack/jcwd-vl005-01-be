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
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-07-25 21:12:50
