-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jul 25, 2022 at 06:41 PM
-- Server version: 10.4.19-MariaDB
-- PHP Version: 8.0.7

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `warehouse`
--

-- --------------------------------------------------------

--
-- Table structure for table `admin`
--

CREATE TABLE `admin` (
  `admin_id` varchar(100) NOT NULL,
  `username` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `status` varchar(150) NOT NULL DEFAULT '''unverified'''
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `admin`
--

INSERT INTO `admin` (`admin_id`, `username`, `email`, `password`, `status`) VALUES
('1', 'admin123', 'admin123@gmail.com', 'Admin123*', '\'unverified\''),
('2', 'aleanajla', 'aleanajla123@gmail.com', 'Alea120802*', '\'unverified\'');

-- --------------------------------------------------------

--
-- Table structure for table `cart`
--

CREATE TABLE `cart` (
  `id` int(11) NOT NULL,
  `user_id` varchar(150) NOT NULL,
  `product_id` int(11) NOT NULL,
  `qty` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `cart`
--

INSERT INTO `cart` (`id`, `user_id`, `product_id`, `qty`) VALUES
(29, 'e7534183-d96c-4f2f-8937-cfdc61be81f0', 17, 1),
(30, 'e7534183-d96c-4f2f-8937-cfdc61be81f0', 18, 3),
(31, 'e7534183-d96c-4f2f-8937-cfdc61be81f0', 15, 1),
(32, 'e7534183-d96c-4f2f-8937-cfdc61be81f0', 30, 1);

-- --------------------------------------------------------

--
-- Table structure for table `category`
--

CREATE TABLE `category` (
  `categoryId` int(11) NOT NULL,
  `categoryName` varchar(150) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `category`
--

INSERT INTO `category` (`categoryId`, `categoryName`) VALUES
(2, 'T-Shirt'),
(12, 'Shirt'),
(14, 'Blazer'),
(15, 'Jacket'),
(16, 'Denim'),
(20, 'Skirt');

-- --------------------------------------------------------

--
-- Table structure for table `payment_verif`
--

CREATE TABLE `payment_verif` (
  `id` int(11) NOT NULL,
  `transaction_header_id` int(11) NOT NULL,
  `img_url` varchar(140) NOT NULL,
  `status` varchar(150) NOT NULL DEFAULT '''false'''
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `payment_verif`
--

INSERT INTO `payment_verif` (`id`, `transaction_header_id`, `img_url`, `status`) VALUES
(11, 27, 'http://localhost:4100/images/af370705341ba4122519fee0d4eabd4b.jpg', '\'false\''),
(12, 28, 'http://localhost:4100/images/8269cbdfd32b5812df33333674b62881.png', '\'false\''),
(13, 29, 'http://localhost:4100/images/1f205dc52a6abcc7a930647042d3747e.jpg', '\'false\'');

-- --------------------------------------------------------

--
-- Table structure for table `product`
--

CREATE TABLE `product` (
  `id` int(11) NOT NULL,
  `name` varchar(60) NOT NULL,
  `price` decimal(12,2) NOT NULL,
  `weight_gram` float NOT NULL,
  `description` varchar(200) NOT NULL,
  `img_url` varchar(140) NOT NULL,
  `categoryId` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `product`
--

INSERT INTO `product` (`id`, `name`, `price`, `weight_gram`, `description`, `img_url`, `categoryId`) VALUES
(12, 'Jeans Wide Leg Belel', '670000.00', 700, 'Jeans made of high-waisted stiff fabric and five pockets. Extra long wide leg section with bell. Closure with zipper and metal buttons.', 'http://localhost:4100/images/623418bb6d3e4032a7c46b296491d97c.jpg', 16),
(13, 'Rustic Blazer with knot', '999000.00', 700, 'Blazer with lapel collar and long sleeves. Double-breasted fastening with matching tie.', 'http://localhost:4100/images/c36a1f23e170702f4425e94d1026064e.jpg', 14),
(15, 'Blazer Cropped', '799000.00', 780, 'Short blazer with a lapel collar and neckline V. Long sleeves with shoulder pads. Front cover with buttons.', 'http://localhost:4100/images/704fb8030e0561bf70e633ea92f521cc.jpg', 14),
(16, 'Blazer Oversize Linen', '1399000.00', 800, 'Blazer with lapel collar and long sleeves with shoulder padding. Various front pockets with lapel. Front cover cross buttoned.', 'http://localhost:4100/images/739a112d0b7fd99bee9bd9b1e5e7a490.jpg', 14),
(17, 'Jewelry Buttoned Miniskirt', '299000.00', 240, 'High waist model miniskirt. Assorted decorative paspoil pockets on the front. Jewelry buttoned front cover.', 'http://localhost:4100/images/2e7bfacf5caa31ee01eeede9fe4ea7ba.jpg', 20),
(18, 'Lose Shirt V Neck', '629000.00', 200, 'Cross-neck V-neck shirt and long-sleeved bloomers.', 'http://localhost:4100/images/8d23033fa12d76e470283ab55dc7665a.jpg', 12),
(19, 'Linen Shirt Oversize', '799000.00', 300, 'The wide shirt is made of 100% linen. Lapel collar and long sleeves with cuffs. Asymmetrical bottom with various side slits. Buttoned front cover.', 'http://localhost:4100/images/ba3597cb108d813ee7ab118f25447c4d.jpg', 12),
(20, 'Embroidered Kit Blouse', '1399000.00', 600, 'Lapel collar blouse and long sleeves A-line hem. Bottom hems with various knots. Buttoned front cover.', 'http://localhost:4100/images/14091d32899f45065c0d0556a938eda2.jpg', 12),
(21, 'Snoopy PEANUTS™ T-shirts', '499900.00', 150, 'Round collar and short sleeves. Details in the form of a combination of contrasting embroidery from Snoopy PEANUTS™.', 'http://localhost:4100/images/ee8cea5cec83639385c9eccc737ce5e1.jpg', 2),
(22, 'Minimalist T-Shirt', '199000.00', 130, 'Minimalist round neck short sleeve T-shirt with matching visible topstitching.', 'http://localhost:4100/images/b8f2acc0cfa55fe2306281a4231f2a2f.jpg', 2),
(23, 'Bee Jewelry T-Shirt', '499900.00', 150, 'Round collar and short sleeves. Patch pocket on chest. Details in the form of jewelry applications in the shape of a bee.', 'http://localhost:4100/images/743a86b0c149714ef402ebd6cc307f12.jpg', 2),
(24, 'Outside Shirt Fall Material', '999900.00', 560, 'Lapel collared overshirt and long sleeves, rolled up hem with hooks and buttons. Various patch pockets in front with lapel. Waist is easy to adjust. Buttoned front cover.', 'http://localhost:4100/images/dbf01aca76ced328321af6cfb7213511.jpg', 15),
(25, 'Rimple Open Jacket', '799900.00', 500, 'Round collared jacket with long hem with hooks and buttons. Various patch pockets in front with lapel. The bottom of the hem is ruffled.', 'http://localhost:4100/images/c1b03952537dc4ef7ad493b29f9dab17.jpg', 15),
(26, 'Synthetic Leather Jacket', '1099000.00', 1050, 'Lapel collared jacket with long sleeves. Multiple front pockets with metal zippers. Detail in the form of a hook on the shoulder. The application is a cloth belt made of the same material as a buckle.', 'http://localhost:4100/images/007102e245ebac5c969e260711d414a6.jpg', 15),
(27, 'Embroidered Kimono', '3499900.00', 775, 'Kimono with V-neckline and wide sleeves. Belt made of the same fabric. Details in the form of embroidered combinations of contrasting patterns.', 'http://localhost:4100/images/21a30f4f99ab9c22c88bba4f9989c8a4.jpg', 15),
(28, 'Jumpsuit Denim Full Length', '1099000.00', 876, 'Lapel collared jumpsuit and sleeves. Various patch pockets on the chest and on the back and sides. Slit detail at waist. Front closure with zipper and metal button.', 'http://localhost:4100/images/e92c21a07de6bfe257118513e23db1e1.jpg', 16),
(29, 'Bermuda Denim Trousers', '699000.00', 235, 'High-waisted Bermuda pants with various patch pockets at the back. Various slit detail at the waist. Front closure with zipper and metal buttons.', 'http://localhost:4100/images/bcb34ea683fb0a6bb51b0ffd5e3e0568.jpg', 16),
(30, 'Jeans Z1975 Mom Fit', '699000.00', 600, 'High waist jeans with five pockets. Faded effect. Front closure with zipper and metal buttons.', 'http://localhost:4100/images/55f916ea2d1d33894c62a338cca68c2c.jpg', 16),
(31, 'Fold Pants Skirt', '629000.00', 345, 'High-waist skort with pleat on the front. Fastening on the front with zip and metal hook.', 'http://localhost:4100/images/1323e5f4541cdb40cff1b01b6ffc9d0a.jpg', 20),
(32, 'Long Pants With Folds Skirt', '699000.00', 230, 'High-waisted skirt with buttons in the front. Side closure with seam closed zip.', 'http://localhost:4100/images/40bbf20bed4724f34cb83ac9b80bd2bc.jpg', 20),
(33, 'Asymetric Long Pants Skirt', '629000.00', 240, 'High-waisted trouser skirt. Details in the form of overlapping fabrics made from the same type of pareo. Side closure with seam closed zip.', 'http://localhost:4100/images/52be00fd40b88627130471dcf2336006.jpg', 20),
(34, 'Vest Without Lapel', '1099000.00', 460, 'V-neck striped vest without lapel and sleeve cuffs. Assorted pockets with placket in front. Buttoned front cover.', 'http://localhost:4100/images/936ce87576d7e41d1a6a8bd9a50ae9f5.jpg', 14),
(35, 'Outboard Pocket Blazer', '1399000.00', 1030, 'Blazer with lapel collar and long sleeves with shoulder padding. Various pockets in front of the patch. Gold buttoned front cover.', 'http://localhost:4100/images/55f4a6ca595cbb91093ffad752f36c72.jpg', 14);

-- --------------------------------------------------------

--
-- Table structure for table `registration_token`
--

CREATE TABLE `registration_token` (
  `id` int(11) NOT NULL,
  `user_id` varchar(150) NOT NULL,
  `token` varchar(60) NOT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `stock`
--

CREATE TABLE `stock` (
  `id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `warehouse_id` int(11) NOT NULL,
  `stock` int(11) NOT NULL DEFAULT 0,
  `reserved_stock` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `stock`
--

INSERT INTO `stock` (`id`, `product_id`, `warehouse_id`, `stock`, `reserved_stock`) VALUES
(6, 12, 1, 20, 0),
(7, 15, 3, 15, 0),
(12, 17, 3, 25, 0),
(13, 18, 1, 20, 0),
(14, 22, 1, 10, 0),
(15, 31, 3, 23, 0),
(16, 24, 1, 17, 0),
(17, 35, 3, 13, 0),
(18, 25, 1, 26, 0),
(19, 30, 3, 31, 0),
(20, 26, 1, 23, 0),
(22, 23, 1, 10, 0),
(23, 23, 3, 25, 0),
(24, 29, 1, 14, 0),
(25, 28, 1, 10, 0),
(26, 21, 1, 30, 0);

-- --------------------------------------------------------

--
-- Table structure for table `transaction_detail`
--

CREATE TABLE `transaction_detail` (
  `id` int(11) NOT NULL,
  `transaction_header_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `qty` int(11) NOT NULL,
  `price` int(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `transaction_detail`
--

INSERT INTO `transaction_detail` (`id`, `transaction_header_id`, `product_id`, `qty`, `price`) VALUES
(28, 27, 15, 1, 799000),
(29, 27, 12, 1, 670000),
(30, 28, 15, 1, 799000),
(31, 28, 12, 1, 670000),
(32, 28, 18, 1, 629000),
(33, 29, 15, 1, 799000);

-- --------------------------------------------------------

--
-- Table structure for table `transaction_header`
--

CREATE TABLE `transaction_header` (
  `id` int(11) NOT NULL,
  `tcode` varchar(255) NOT NULL,
  `shipping_warehouse_id` int(11) NOT NULL,
  `user_id` varchar(150) NOT NULL,
  `status` varchar(20) NOT NULL DEFAULT '''pending''',
  `shipped_date` datetime DEFAULT NULL,
  `grand_total` int(11) NOT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT NULL,
  `address` varchar(255) NOT NULL,
  `city` varchar(255) NOT NULL,
  `postal` varchar(255) NOT NULL,
  `province` varchar(255) NOT NULL,
  `latitude` decimal(10,8) NOT NULL,
  `longitude` decimal(11,8) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `transaction_header`
--

INSERT INTO `transaction_header` (`id`, `tcode`, `shipping_warehouse_id`, `user_id`, `status`, `shipped_date`, `grand_total`, `created_at`, `updated_at`, `address`, `city`, `postal`, `province`, `latitude`, `longitude`) VALUES
(27, 'TR108', 1, 'e7534183-d96c-4f2f-8937-cfdc61be81f0', '\'pending\'', NULL, 1552450, '2022-07-25 22:15:07', NULL, 'Jl. Komp. Puri Bintaro, Sawah Baru, Kec. Ciputat, Kota Tangerang Selatan, Banten 15413', 'Tangerang Selatan', '15413', 'Banten', '-6.28671398', '106.71744259'),
(28, 'TR466', 1, 'e7534183-d96c-4f2f-8937-cfdc61be81f0', '\'pending\'', NULL, 2211900, '2022-07-25 23:05:17', NULL, 'Jl. Alam Segar I Blok Us No.6, RT.9/RW.16, Pd. Pinang, Kec. Kby. Lama, Kota Jakarta Selatan, Daerah Khusus Ibukota Jakarta 12310', 'Jakarta Selatan', '12310', 'DKI Jakarta', '-6.26848525', '106.78267973'),
(29, 'TR967', 1, 'e7534183-d96c-4f2f-8937-cfdc61be81f0', '\'pending\'', NULL, 850950, '2022-07-25 23:06:12', NULL, 'Jl. Alam Segar I Blok Us No.6, RT.9/RW.16, Pd. Pinang, Kec. Kby. Lama, Kota Jakarta Selatan, Daerah Khusus Ibukota Jakarta 12310', 'Jakarta Selatan', '12310', 'DKI Jakarta', '-6.26848525', '106.78267973');

-- --------------------------------------------------------

--
-- Table structure for table `transaction_shipping`
--

CREATE TABLE `transaction_shipping` (
  `id` int(11) NOT NULL,
  `transaction_header_id` int(11) NOT NULL,
  `warehouse_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `qty` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `id` varchar(150) NOT NULL,
  `username` varchar(60) NOT NULL,
  `email` varchar(60) NOT NULL,
  `password` varchar(140) NOT NULL,
  `status` varchar(150) NOT NULL DEFAULT '''inactive'''
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`id`, `username`, `email`, `password`, `status`) VALUES
('7f6b7553-a72b-4cf0-8062-e63eadb99601', 'dtbowo', 'dtprabowo19@gmail.com', '$2b$10$W8nPIQqpMbTOVoFeNUYpTugJp4xCuYUVDvcadKch4u5ZakTb5DDpm', 'inactive'),
('a03faffb-f6be-4e9c-b1f1-2852921755c7', 'dimastrip', 'dtprabowo9@gmail.com', '$2b$10$8ODcqgunS7si5R2bQfxoKO1JolJiAk.HlDBDl4yofTplPBMj8PSve', 'inactive'),
('e7534183-d96c-4f2f-8937-cfdc61be81f0', 'denywi', 'dtprabowo1@gmail.com', '$2b$10$WvUJNihMRPnatQb19FjEcuP/Fr249O88M8zd7lllKwYHy.WUQ2p6a', 'active');

-- --------------------------------------------------------

--
-- Table structure for table `user_address`
--

CREATE TABLE `user_address` (
  `id` int(11) NOT NULL,
  `user_id` varchar(150) NOT NULL,
  `address` varchar(140) NOT NULL,
  `postal` varchar(10) NOT NULL,
  `city` varchar(20) NOT NULL,
  `province` varchar(20) NOT NULL,
  `label` varchar(255) NOT NULL,
  `latitude` decimal(10,8) NOT NULL,
  `longitude` decimal(11,8) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `user_address`
--

INSERT INTO `user_address` (`id`, `user_id`, `address`, `postal`, `city`, `province`, `label`, `latitude`, `longitude`) VALUES
(1, 'e7534183-d96c-4f2f-8937-cfdc61be81f0', 'Jl. Komp. Puri Bintaro, Sawah Baru, Kec. Ciputat, Kota Tangerang Selatan, Banten 15413', '15413', 'Tangerang Selatan', 'Banten', 'Home', '-6.28671398', '106.71744259'),
(3, 'e7534183-d96c-4f2f-8937-cfdc61be81f0', 'Jl. Alam Segar I Blok Us No.6, RT.9/RW.16, Pd. Pinang, Kec. Kby. Lama, Kota Jakarta Selatan, Daerah Khusus Ibukota Jakarta 12310', '12310', 'Jakarta Selatan', 'DKI Jakarta', 'Anida\'s Home', '-6.26848525', '106.78267973');

-- --------------------------------------------------------

--
-- Table structure for table `warehouses`
--

CREATE TABLE `warehouses` (
  `id` int(11) NOT NULL,
  `name_location` varchar(150) NOT NULL,
  `address` varchar(140) NOT NULL,
  `city` varchar(20) NOT NULL,
  `province` varchar(20) NOT NULL,
  `postal` varchar(10) NOT NULL,
  `latitude` decimal(10,8) NOT NULL,
  `longitude` decimal(11,8) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `warehouses`
--

INSERT INTO `warehouses` (`id`, `name_location`, `address`, `city`, `province`, `postal`, `latitude`, `longitude`) VALUES
(1, 'Bekasi', 'Jl. Raya Teuku Umar, Gandasari, Kec. Cibitung, Kabupaten Bekasi, Jawa Barat 17510', 'Bekasi', 'Jawa Barat', '17510', '-6.26979813', '107.08584769'),
(3, 'Banten', 'Link. Kubangsaron, Jl. Kyai H. Mudzakir, Tegalratu, Kec. Ciwandan, Kota Cilegon, Banten', 'Cilegon', 'Banten', '42445', '-6.01990344', '105.98459415');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `admin`
--
ALTER TABLE `admin`
  ADD PRIMARY KEY (`admin_id`);

--
-- Indexes for table `cart`
--
ALTER TABLE `cart`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_cartProductId` (`product_id`),
  ADD KEY `fk_userIdCart` (`user_id`);

--
-- Indexes for table `category`
--
ALTER TABLE `category`
  ADD PRIMARY KEY (`categoryId`);

--
-- Indexes for table `payment_verif`
--
ALTER TABLE `payment_verif`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_paymentTransactionId` (`transaction_header_id`);

--
-- Indexes for table `product`
--
ALTER TABLE `product`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `registration_token`
--
ALTER TABLE `registration_token`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_userIdToken` (`user_id`);

--
-- Indexes for table `stock`
--
ALTER TABLE `stock`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_stockWarehouseId` (`product_id`),
  ADD KEY `fk_warehouseIdStock` (`warehouse_id`);

--
-- Indexes for table `transaction_detail`
--
ALTER TABLE `transaction_detail`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_detailHeaderId` (`transaction_header_id`),
  ADD KEY `fk_detailProductId` (`product_id`);

--
-- Indexes for table `transaction_header`
--
ALTER TABLE `transaction_header`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_userIdTransactionHeader` (`user_id`),
  ADD KEY `fk_warehouseId` (`shipping_warehouse_id`);

--
-- Indexes for table `transaction_shipping`
--
ALTER TABLE `transaction_shipping`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_shippingTransaction` (`transaction_header_id`),
  ADD KEY `fk_shippingWarehouse` (`warehouse_id`),
  ADD KEY `fk_shippingProduct` (`product_id`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `user_address`
--
ALTER TABLE `user_address`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_userIdAddress` (`user_id`);

--
-- Indexes for table `warehouses`
--
ALTER TABLE `warehouses`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `cart`
--
ALTER TABLE `cart`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=33;

--
-- AUTO_INCREMENT for table `category`
--
ALTER TABLE `category`
  MODIFY `categoryId` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT for table `payment_verif`
--
ALTER TABLE `payment_verif`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `product`
--
ALTER TABLE `product`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=36;

--
-- AUTO_INCREMENT for table `registration_token`
--
ALTER TABLE `registration_token`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `stock`
--
ALTER TABLE `stock`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=27;

--
-- AUTO_INCREMENT for table `transaction_detail`
--
ALTER TABLE `transaction_detail`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=34;

--
-- AUTO_INCREMENT for table `transaction_header`
--
ALTER TABLE `transaction_header`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=30;

--
-- AUTO_INCREMENT for table `transaction_shipping`
--
ALTER TABLE `transaction_shipping`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `user_address`
--
ALTER TABLE `user_address`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `warehouses`
--
ALTER TABLE `warehouses`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `cart`
--
ALTER TABLE `cart`
  ADD CONSTRAINT `fk_cartProductId` FOREIGN KEY (`product_id`) REFERENCES `product` (`id`),
  ADD CONSTRAINT `fk_userIdCart` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`);

--
-- Constraints for table `payment_verif`
--
ALTER TABLE `payment_verif`
  ADD CONSTRAINT `fk_paymentTransactionId` FOREIGN KEY (`transaction_header_id`) REFERENCES `transaction_header` (`id`);

--
-- Constraints for table `registration_token`
--
ALTER TABLE `registration_token`
  ADD CONSTRAINT `fk_userIdToken` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`);

--
-- Constraints for table `stock`
--
ALTER TABLE `stock`
  ADD CONSTRAINT `fk_stockProductId` FOREIGN KEY (`product_id`) REFERENCES `product` (`id`),
  ADD CONSTRAINT `fk_warehouseIdStock` FOREIGN KEY (`warehouse_id`) REFERENCES `warehouses` (`id`);

--
-- Constraints for table `transaction_detail`
--
ALTER TABLE `transaction_detail`
  ADD CONSTRAINT `fk_detailHeaderId` FOREIGN KEY (`transaction_header_id`) REFERENCES `transaction_header` (`id`),
  ADD CONSTRAINT `fk_detailProductId` FOREIGN KEY (`product_id`) REFERENCES `product` (`id`);

--
-- Constraints for table `transaction_header`
--
ALTER TABLE `transaction_header`
  ADD CONSTRAINT `fk_userIdTransactionHeader` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`),
  ADD CONSTRAINT `fk_warehouseId` FOREIGN KEY (`shipping_warehouse_id`) REFERENCES `warehouses` (`id`);

--
-- Constraints for table `transaction_shipping`
--
ALTER TABLE `transaction_shipping`
  ADD CONSTRAINT `fk_shippingProduct` FOREIGN KEY (`product_id`) REFERENCES `product` (`id`),
  ADD CONSTRAINT `fk_shippingTransaction` FOREIGN KEY (`transaction_header_id`) REFERENCES `transaction_header` (`id`),
  ADD CONSTRAINT `fk_shippingWarehouse` FOREIGN KEY (`warehouse_id`) REFERENCES `warehouses` (`id`);

--
-- Constraints for table `user_address`
--
ALTER TABLE `user_address`
  ADD CONSTRAINT `fk_userIdAddress` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
