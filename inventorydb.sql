-- MySQL dump 10.13  Distrib 8.0.40, for Win64 (x86_64)
--
-- Host: localhost    Database: inventory
-- ------------------------------------------------------
-- Server version	8.0.40

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
-- Table structure for table `customers`
--

DROP TABLE IF EXISTS `customers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `customers` (
  `id` int NOT NULL AUTO_INCREMENT,
  `first_name` varchar(50) NOT NULL,
  `last_name` varchar(50) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  `role` varchar(50) NOT NULL DEFAULT 'customer',
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customers`
--

LOCK TABLES `customers` WRITE;
/*!40000 ALTER TABLE `customers` DISABLE KEYS */;
INSERT INTO `customers` VALUES (1,'John','Labotoy','john@example.com','$2b$12$ImxeGkzpiwU/i8yWzGyuXu5VRinqEzp0xlcfDk.NHwBvcfy8gV6iK','admin'),(2,'John','Doe','john.doe@example.com','$2b$12$EVxrgQoLMUCr98WdcbikP.8.SGPBAl9DT/z0EvKNJhGj2MnuVrxHe','customer'),(3,'Jane','Smith','jane.smith@example.com','$2b$12$GtGbgfG3QyZG1nWLXyDpLuFfSGLQvbExRP0Fv4F60uYUw06f9jV5A','customer'),(4,'Alice','Johnson','alice.johnson@example.com','$2b$12$Bwz1C6X7pW9YB8Ewp4gD06YHV3chW5R8ORgqZmw5bfFjpFHv1s8YO','customer'),(5,'Bob','Williams','bob.williams@example.com','$2b$12$gZyI.ACFL5p80oYngAYc9.IhptvTZ1hz8mHLjN5X5.GhDcfKT9aaG','customer'),(6,'Charlie','Brown','charlie.brown@example.com','$2b$12$NzL3Fty6hV73n7vCGw1q3VvtoD5aUjj3Vqa1gkkyIQdOGQZcG7giy','customer'),(7,'David','Davis','david.davis@example.com','$2b$12$E5qR0fwjRzwQkwdI0/xJ8yx9khrqGG3gBtmD0brpUugN9FpkdndpK','customer'),(8,'Emma','Miller','emma.miller@example.com','$2b$12$hl3c8d7tLh1gUq7m5S4A7mnoQ9FSrJKgnlVh/Tf5WVGkNRfH2B3Hi','customer'),(9,'Frank','Martinez','frank.martinez@example.com','$2b$12$1F9kX6MzO8yF6NEOG/v2.vI3CK6yV2d7hTZv2pgFYfdCwSgM2D6f6','customer'),(10,'Grace','Lopez','grace.lopez@example.com','$2b$12$1m.DOSmkg3XrrQODjBc6gnMNzYTS1wOFN7rVoj9InFYPpPjRS6V2q','customer'),(11,'Henry','Gonzalez','henry.gonzalez@example.com','$2b$12$k06fYdJKUE5DdqK.WFrfd8OSrk5Cp75dS8YoZZ9T4YP6Ae9PlGFxy','customer'),(12,'Ivy','Perez','ivy.perez@example.com','$2b$12$Iuz8/7pTRhlbcjm4eIOfT6Wb2ZWZUMnpDFg31b9Wyob.nNRpFEHt6','customer'),(13,'Jack','Wilson','jack.wilson@example.com','$2b$12$DghRh4JwNj0WgB7DJnR9eF9SfyBE9DbTzG0L9q5P9yyJle.gH1uYq','customer'),(14,'Kelly','Anderson','kelly.anderson@example.com','$2b$12$S40.n9yUl8Yr3vYxaOQ3xAoHq7VlzSnC9VsRf6czTYGnpYjmzMIoW','customer'),(15,'Leo','Thomas','leo.thomas@example.com','$2b$12$ZG2V8whp78SgH32ehtjQs..UQtwrL9fdO2nbFgRfi2kwkyI2Q0yFe','customer'),(16,'Megan','Jackson','megan.jackson@example.com','$2b$12$D6FcUwA3msGZmrLRmRvaAK39b2PNTPlffvuwrWsjj5/M6e1ghkqOe','customer'),(17,'Nathan','White','nathan.white@example.com','$2b$12$2bTpC/jfPfgqXjkbYohtlS51/ZdBL7Xe9TrmGGthLSZa7ndxrt0eG','customer'),(18,'Olivia','Harris','olivia.harris@example.com','$2b$12$6zDbwDb0zB60Y5TAhzFjPjqu7b0cdUE3gHbq2eUPP2cbIbI7VsAfe','customer'),(19,'Paul','Clark','paul.clark@example.com','$2b$12$olONPS2ctFNXETD4K4wYQwY9mdigvTnk1NN9M7H29roE.gLwbDb9C','customer'),(20,'Quincy','Lewis','quincy.lewis@example.com','$2b$12$Cm6zy.bWphk.MHLDu7fD1wTq9IppfZ9pq7hbhIbUsjs44vNqOQAZy','customer'),(21,'Rachel','Young','rachel.young@example.com','$2b$12$Z5hU1X1Q1mtkPpYoDAfzhtJ2UqAVt4IRe5BoGyTshI80FICQjm5qa','customer'),(22,'Steve','King','steve.king@example.com','$2b$12$eJbD7cmCZ9DohzKNtm1VtEvc5p4ZQ7.m2U4A6ZP35tS8kElkF9hxa','customer'),(23,'Tracy','Scott','tracy.scott@example.com','$2b$12$wC95eE6u9UL5t9q5JpDda09YrrEOyl.Z5xW0fW9ItMk3dBO7xysGm','customer'),(24,'Ursula','Adams','ursula.adams@example.com','$2b$12$9zyCjT1XikcbvFiA1kWqg7vGZf0nm1ntN8tXJwp6hl.JrX6TH0S2f','customer'),(25,'Victor','Baker','victor.baker@example.com','$2b$12$wtSTmn8OGNJ0BvW7cl8MkScBXGHF2P3rO9J0I7IzK2HjfTDOOwHWu','customer'),(26,'Wendy','Gomez','wendy.gomez@example.com','$2b$12$zOKjN.ZCwTEWLJt6.hHh3tOxQ02rdqXsD3TxQ9aoxYXY0PBGsIoTe','customer'),(27,'Xander','Nelson','xander.nelson@example.com','$2b$12$OrrTWKLa1tLP0vUKhpxnIOsykRP7lD07YwrzGrz7UwDWiFiFdxVHG','customer'),(28,'Yvonne','Carter','yvonne.carter@example.com','$2b$12$5yQ6IXIey6lNOI4HXh8Xv5S9Fbl7eehHtElP5XpeAQo3phFcUMGXi','customer'),(29,'Zach','Mitchell','zach.mitchell@example.com','$2b$12$wTgAOl1Dwqz7DLZmlQnJRUyMN2i4HffuO3nP5m7zT0ZEX5zZK7wy','customer');
/*!40000 ALTER TABLE `customers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `inventory_transactions`
--

DROP TABLE IF EXISTS `inventory_transactions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `inventory_transactions` (
  `id` int NOT NULL AUTO_INCREMENT,
  `product_id` int NOT NULL,
  `transaction_type` enum('IN','OUT') NOT NULL,
  `quantity` int NOT NULL,
  `transaction_date` date NOT NULL,
  PRIMARY KEY (`id`),
  KEY `product_id` (`product_id`),
  CONSTRAINT `inventory_transactions_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `inventory_transactions`
--

LOCK TABLES `inventory_transactions` WRITE;
/*!40000 ALTER TABLE `inventory_transactions` DISABLE KEYS */;
INSERT INTO `inventory_transactions` VALUES (1,1,'IN',50,'2024-12-01'),(2,2,'IN',100,'2024-12-01'),(3,3,'IN',200,'2024-12-01'),(4,4,'IN',150,'2024-12-01'),(5,5,'IN',75,'2024-12-01'),(6,6,'IN',120,'2024-12-01'),(7,7,'IN',200,'2024-12-01'),(8,8,'IN',80,'2024-12-01'),(9,9,'IN',300,'2024-12-01'),(10,10,'IN',50,'2024-12-01'),(11,11,'IN',60,'2024-12-01'),(12,12,'IN',25,'2024-12-01'),(13,13,'IN',200,'2024-12-01'),(14,14,'IN',100,'2024-12-01'),(15,15,'IN',500,'2024-12-01'),(16,16,'IN',200,'2024-12-01'),(17,17,'IN',150,'2024-12-01'),(18,18,'IN',40,'2024-12-01'),(19,19,'IN',30,'2024-12-01'),(20,20,'IN',100,'2024-12-01'),(21,21,'IN',80,'2024-12-01'),(22,22,'IN',60,'2024-12-01'),(23,23,'IN',90,'2024-12-01'),(24,24,'IN',150,'2024-12-01'),(25,25,'IN',120,'2024-12-01'),(26,26,'IN',200,'2024-12-01'),(27,27,'IN',25,'2024-12-01'),(28,28,'IN',30,'2024-12-01'),(29,29,'IN',40,'2024-12-01'),(30,30,'IN',50,'2024-12-01'),(31,1,'OUT',4,'2024-12-12');
/*!40000 ALTER TABLE `inventory_transactions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order_items`
--

DROP TABLE IF EXISTS `order_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `order_items` (
  `id` int NOT NULL AUTO_INCREMENT,
  `order_id` int NOT NULL,
  `product_id` int NOT NULL,
  `product_quantity` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `order_id` (`order_id`),
  KEY `product_id` (`product_id`),
  CONSTRAINT `order_items_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`) ON DELETE CASCADE,
  CONSTRAINT `order_items_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_items`
--

LOCK TABLES `order_items` WRITE;
/*!40000 ALTER TABLE `order_items` DISABLE KEYS */;
INSERT INTO `order_items` VALUES (1,1,1,2),(2,1,2,1),(3,2,3,3),(4,3,4,2),(5,4,5,1),(6,5,6,4),(7,6,7,2),(8,7,8,3),(9,8,9,1),(10,9,10,5),(11,10,11,1),(12,11,12,2),(13,12,13,3),(14,13,14,2),(15,14,15,6),(16,15,16,1),(17,16,17,3),(18,17,18,2),(19,18,19,1),(20,19,20,4),(21,20,21,3),(22,21,22,5),(23,22,23,3),(24,23,24,2),(25,24,25,1),(26,25,26,2),(27,26,27,1),(28,27,28,4),(29,28,29,2),(30,29,30,3),(31,3,1,4);
/*!40000 ALTER TABLE `order_items` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orders`
--

DROP TABLE IF EXISTS `orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orders` (
  `id` int NOT NULL AUTO_INCREMENT,
  `customer_id` int NOT NULL,
  `date_of_order` date NOT NULL,
  PRIMARY KEY (`id`),
  KEY `customer_id` (`customer_id`),
  CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=61 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders`
--

LOCK TABLES `orders` WRITE;
/*!40000 ALTER TABLE `orders` DISABLE KEYS */;
INSERT INTO `orders` VALUES (1,1,'2024-12-01'),(2,2,'2024-12-02'),(3,3,'2024-12-03'),(4,4,'2024-12-04'),(5,5,'2024-12-05'),(6,6,'2024-12-06'),(7,7,'2024-12-07'),(8,8,'2024-12-08'),(9,9,'2024-12-09'),(10,10,'2024-12-10'),(11,11,'2024-12-11'),(12,12,'2024-12-12'),(13,13,'2024-12-13'),(14,14,'2024-12-14'),(15,15,'2024-12-15'),(16,16,'2024-12-16'),(17,17,'2024-12-17'),(18,18,'2024-12-18'),(19,19,'2024-12-19'),(20,20,'2024-12-20'),(21,21,'2024-12-21'),(22,22,'2024-12-22'),(23,23,'2024-12-23'),(24,24,'2024-12-24'),(25,25,'2024-12-25'),(26,26,'2024-12-26'),(27,27,'2024-12-27'),(28,28,'2024-12-28'),(29,29,'2024-12-29'),(60,2,'2024-12-12');
/*!40000 ALTER TABLE `orders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `products`
--

DROP TABLE IF EXISTS `products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `products` (
  `id` int NOT NULL AUTO_INCREMENT,
  `product_name` varchar(100) NOT NULL,
  `unit_price` decimal(10,2) NOT NULL,
  `stock_quantity` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `products`
--

LOCK TABLES `products` WRITE;
/*!40000 ALTER TABLE `products` DISABLE KEYS */;
INSERT INTO `products` VALUES (1,'Laptop',1000.00,46),(2,'Smartphone',500.00,100),(3,'Headphones',100.00,200),(4,'Tablet',300.00,150),(5,'Monitor',250.00,75),(6,'Keyboard',50.00,120),(7,'Mouse',30.00,200),(8,'Smartwatch',150.00,80),(9,'Charger',20.00,300),(10,'Camera',400.00,50),(11,'Printer',150.00,60),(12,'Projector',450.00,25),(13,'External Hard Drive',120.00,200),(14,'Speaker',60.00,100),(15,'Phone Case',10.00,500),(16,'Laptop Bag',30.00,200),(17,'Flash Drive',15.00,250),(18,'Power Bank',25.00,150),(19,'VR Headset',350.00,40),(20,'Drone',500.00,30),(21,'Electric Fan',60.00,100),(22,'Hair Dryer',40.00,80),(23,'Coffee Maker',100.00,60),(24,'Blender',80.00,90),(25,'Smart Light Bulb',20.00,150),(26,'Electric Kettle',40.00,120),(27,'Microwave Oven',150.00,50),(28,'Refrigerator',500.00,30),(29,'Washing Machine',350.00,20),(30,'Dishwasher',400.00,15),(31,'Saging',500.00,30);
/*!40000 ALTER TABLE `products` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-12-14  9:48:51
