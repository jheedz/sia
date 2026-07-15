-- MySQL dump 10.13  Distrib 8.0.19, for Win64 (x86_64)
--
-- Host: localhost    Database: monitoring_laravel
-- ------------------------------------------------------
-- Server version	8.4.3

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `app_metrics`
--

DROP TABLE IF EXISTS `app_metrics`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `app_metrics` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `recorded_at` timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `value` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `satuan` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `master_aplikasi_id` bigint unsigned DEFAULT NULL,
  `master_metrik_id` bigint unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `app_metrics_master_aplikasi_id_foreign` (`master_aplikasi_id`),
  KEY `app_metrics_master_metrik_id_foreign` (`master_metrik_id`),
  CONSTRAINT `app_metrics_master_aplikasi_id_foreign` FOREIGN KEY (`master_aplikasi_id`) REFERENCES `master_aplikasi` (`id`) ON DELETE SET NULL,
  CONSTRAINT `app_metrics_master_metrik_id_foreign` FOREIGN KEY (`master_metrik_id`) REFERENCES `master_metrik` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `app_metrics`
--

LOCK TABLES `app_metrics` WRITE;
/*!40000 ALTER TABLE `app_metrics` DISABLE KEYS */;
/*!40000 ALTER TABLE `app_metrics` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `attendances`
--

DROP TABLE IF EXISTS `attendances`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `attendances` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `employee_id` bigint unsigned NOT NULL,
  `date` date NOT NULL,
  `clock_in` time NOT NULL,
  `clock_out` time DEFAULT NULL,
  `status` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `attendances_employee_id_foreign` (`employee_id`),
  CONSTRAINT `attendances_employee_id_foreign` FOREIGN KEY (`employee_id`) REFERENCES `employees` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `attendances`
--

LOCK TABLES `attendances` WRITE;
/*!40000 ALTER TABLE `attendances` DISABLE KEYS */;
INSERT INTO `attendances` VALUES (1,1,'2026-07-07','08:21:00','16:21:00','hadir','2026-07-08 03:21:41','2026-07-09 04:53:47'),(2,1,'2026-07-03','07:31:00','16:32:00','hadir','2026-07-08 03:23:42','2026-07-08 03:32:16'),(3,2,'2026-07-03','07:36:00','16:36:00','hadir','2026-07-08 03:36:55','2026-07-08 03:36:55'),(4,3,'2026-07-07','07:23:00','16:26:00','hadir','2026-07-08 07:23:31','2026-07-08 07:25:41'),(5,1,'2026-07-08','07:17:00','16:22:00','hadir','2026-07-09 04:17:31','2026-07-09 04:17:31'),(6,2,'2026-07-08','07:52:00','16:37:00','hadir','2026-07-09 04:52:36','2026-07-09 04:52:36'),(7,9,'2026-07-09','14:15:19','14:33:52','hadir','2026-07-09 07:15:19','2026-07-09 07:33:52'),(8,3,'2026-07-09','14:15:34','14:15:37','hadir','2026-07-09 07:15:34','2026-07-09 07:15:37'),(9,2,'2026-07-09','14:23:23','14:39:19','hadir','2026-07-09 07:23:23','2026-07-09 07:39:19'),(10,1,'2026-07-09','14:40:19','14:43:31','hadir','2026-07-09 07:40:19','2026-07-09 07:43:31'),(12,6,'2026-07-09','14:49:37','16:35:00','hadir','2026-07-09 07:49:37','2026-07-10 01:35:11'),(13,13,'2026-07-10','09:45:37','18:43:33','hadir','2026-07-10 02:45:37','2026-07-10 11:43:33'),(14,9,'2026-07-10','09:48:15','18:44:20','hadir','2026-07-10 02:48:15','2026-07-10 11:44:20'),(15,12,'2026-07-10','09:54:43','19:03:41','hadir','2026-07-10 02:54:43','2026-07-10 12:03:41'),(16,10,'2026-07-10','10:03:56','19:05:39','hadir','2026-07-10 03:03:56','2026-07-10 12:05:39'),(17,3,'2026-07-10','10:05:16','19:06:56','terlambat','2026-07-10 03:05:16','2026-07-10 12:28:28'),(18,2,'2026-07-10','19:04:01','19:24:50','hadir','2026-07-10 12:04:01','2026-07-10 12:24:50'),(19,1,'2026-07-10','19:04:35','19:19:30','hadir','2026-07-10 12:04:35','2026-07-10 12:19:30'),(20,11,'2026-07-10','19:25:38','19:30:47','terlambat','2026-07-10 12:25:38','2026-07-10 12:30:47'),(21,6,'2026-07-10','19:33:47','19:40:31','terlambat','2026-07-10 12:33:47','2026-07-10 12:40:31'),(22,7,'2026-07-10','19:41:56',NULL,'terlambat','2026-07-10 12:41:56','2026-07-10 12:41:56'),(23,12,'2026-07-11','10:44:51',NULL,'terlambat','2026-07-11 03:44:51','2026-07-11 03:44:51'),(24,1,'2026-07-11','10:46:00',NULL,'terlambat','2026-07-11 03:46:00','2026-07-11 03:46:00'),(25,13,'2026-07-11','10:47:08',NULL,'terlambat','2026-07-11 03:47:08','2026-07-11 03:47:08'),(26,14,'2026-07-11','10:47:33',NULL,'terlambat','2026-07-11 03:47:33','2026-07-11 03:47:33'),(27,10,'2026-07-11','10:54:09',NULL,'terlambat','2026-07-11 03:54:09','2026-07-11 03:54:09');
/*!40000 ALTER TABLE `attendances` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cache`
--

DROP TABLE IF EXISTS `cache`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cache` (
  `key` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` mediumtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `expiration` int NOT NULL,
  PRIMARY KEY (`key`),
  KEY `cache_expiration_index` (`expiration`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cache`
--

LOCK TABLES `cache` WRITE;
/*!40000 ALTER TABLE `cache` DISABLE KEYS */;
/*!40000 ALTER TABLE `cache` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cache_locks`
--

DROP TABLE IF EXISTS `cache_locks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cache_locks` (
  `key` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `owner` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `expiration` int NOT NULL,
  PRIMARY KEY (`key`),
  KEY `cache_locks_expiration_index` (`expiration`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cache_locks`
--

LOCK TABLES `cache_locks` WRITE;
/*!40000 ALTER TABLE `cache_locks` DISABLE KEYS */;
/*!40000 ALTER TABLE `cache_locks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `employees`
--

DROP TABLE IF EXISTS `employees`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `employees` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `nik` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `gender` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `photo` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `position` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `address` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `birthday` date DEFAULT NULL,
  `joined_at` date NOT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `employees_nik_unique` (`nik`),
  UNIQUE KEY `employees_email_unique` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `employees`
--

LOCK TABLES `employees` WRITE;
/*!40000 ALTER TABLE `employees` DISABLE KEYS */;
INSERT INTO `employees` VALUES (1,'EMP000111','Mursyid','Laki-laki','employees/hryh1kJmQdRnsCk6g2BSfkuAeCCl6FJdaILprO0G.jpg','mursyid@tes.com','supervisor',NULL,'2001-06-14','2018-02-12',1,'2026-07-07 07:26:04','2026-07-10 02:24:25'),(2,'EMP000113','Kamila kun','Perempuan','employees/nCpl1MbcEYWHc30p71nIpJwZGVDCs0zpTtdChzGX.jpg','kamilakun@tes.com','intern',NULL,'2009-06-22','2026-04-02',1,'2026-07-07 09:21:04','2026-07-10 02:23:41'),(3,'EMP000116','Rangga Hilux','Laki-laki','employees/0f5oO7195rSpWV5lzTuRazafOggEBJahkkWrXGkn.jpg','RanggaHilux@tes.com','manager',NULL,'1995-07-20','2020-10-28',1,'2026-07-07 09:24:01','2026-07-10 02:21:42'),(6,'tes1231','tes tes',NULL,'','tes@gmail.com','manager',NULL,NULL,'2025-01-10',1,'2026-07-08 02:46:57','2026-07-08 02:46:57'),(7,'tes1230','tes2',NULL,'employees/pp_dflt.jpg','tes2@tes.com','supervisor',NULL,NULL,'2023-07-13',1,'2026-07-08 02:48:26','2026-07-09 01:48:52'),(9,'EMP000212','Hasan Adnan','Laki-laki','employees/U95X2bcYhmxj2MMxgoZ9rtPLKBU8Y32gsMZ7uJCH.jpg','hasan.adnan@tes.com','manager',NULL,'1990-06-08','2014-06-18',1,'2026-07-09 02:00:31','2026-07-10 02:31:01'),(10,'EMP000119','Soleh solihun','Laki-laki','employees/vfAAS99ICVqveITuOLTgqrtKHV7FFyofN2wYzHJs.png','solehsolihun@tes.com','staff',NULL,'1986-10-24','2012-10-26',1,'2026-07-10 01:53:20','2026-07-10 01:53:20'),(11,'EMP000102','rudi salam','Laki-laki','employees/YUNQm42NlH3AoFWFDSgqqV4kEIZKkjAfXQcHPcMK.jpg','rudi.salam@tes.com','supervisor',NULL,'1993-06-17','2022-10-12',1,'2026-07-10 02:33:42','2026-07-10 02:33:42'),(12,'EMP000121','nada nadira','Perempuan','employees/235UsiMkD4OcLzzihHu5demgu14sNqYszmvTNf9W.jpg','nadanadira@tes.com','supervisor',NULL,'1995-06-14','2024-06-27',1,'2026-07-10 02:37:51','2026-07-10 02:37:51'),(13,'INT000001','burhan hakimun','Laki-laki','employees/bP0YaeiQ4gqt4yn11falSRMKGanONe8fY9uzQ7s3.jpg','burhan.halimun@tes.com','intern',NULL,'2007-06-20','2026-03-12',1,'2026-07-10 02:44:42','2026-07-10 02:44:42'),(14,'EMP000112','progo gusti','Laki-laki','employees/pp_dflt.jpg','progo.gusti@tes.com','staff',NULL,'1992-10-15','2022-05-24',1,'2026-07-10 12:46:33','2026-07-10 12:46:33'),(15,'INT000002','internship dua','Laki-laki','employees/pp_dflt.jpg','internship.dua@tes.com','intern',NULL,'2008-06-15','2026-03-31',1,'2026-07-10 13:01:42','2026-07-10 13:01:42');
/*!40000 ALTER TABLE `employees` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `engine_notif_reports`
--

DROP TABLE IF EXISTS `engine_notif_reports`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `engine_notif_reports` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `report_hour` datetime NOT NULL,
  `mvrk_success` bigint NOT NULL DEFAULT '0',
  `mvrk_fail` bigint NOT NULL DEFAULT '0',
  `sms_success` bigint NOT NULL DEFAULT '0',
  `sms_fail` bigint NOT NULL DEFAULT '0',
  `email_success` bigint NOT NULL DEFAULT '0',
  `email_fail` bigint NOT NULL DEFAULT '0',
  `avg_response_time` decimal(10,2) NOT NULL DEFAULT '0.00',
  `avg_lifespan` decimal(10,2) NOT NULL DEFAULT '0.00',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `engine_notif_reports_report_hour_unique` (`report_hour`),
  KEY `engine_notif_reports_report_hour_index` (`report_hour`)
) ENGINE=InnoDB AUTO_INCREMENT=145 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `engine_notif_reports`
--

LOCK TABLES `engine_notif_reports` WRITE;
/*!40000 ALTER TABLE `engine_notif_reports` DISABLE KEYS */;
INSERT INTO `engine_notif_reports` VALUES (1,'2026-07-01 00:00:00',254,0,138,1,1358,0,1754.76,562.95,'2026-07-06 03:57:11','2026-07-06 03:57:11'),(2,'2026-07-01 01:00:00',278,0,201,0,1923,0,1754.69,706.49,'2026-07-06 03:57:11','2026-07-06 03:57:11'),(3,'2026-07-01 02:00:00',150,1,98,1,683,0,1754.61,741.52,'2026-07-06 03:57:11','2026-07-06 03:57:11'),(4,'2026-07-01 03:00:00',83,0,50,1,517,0,1754.56,1465.83,'2026-07-06 03:57:11','2026-07-06 03:57:11'),(5,'2026-07-01 04:00:00',267,1,245,0,3096,0,1754.22,868.87,'2026-07-06 03:57:11','2026-07-06 03:57:11'),(6,'2026-07-01 05:00:00',310,5,173,5,2227,0,1754.32,421.42,'2026-07-06 03:57:11','2026-07-06 03:57:11'),(7,'2026-07-01 06:00:00',406,4,177,6,2393,0,1754.38,415.25,'2026-07-06 03:57:11','2026-07-06 03:57:11'),(8,'2026-07-01 07:00:00',738,3,332,2,3786,0,1754.33,347.95,'2026-07-06 03:57:11','2026-07-06 03:57:11'),(9,'2026-07-01 08:00:00',985,2,423,2,4455,0,1754.36,317.09,'2026-07-06 03:57:11','2026-07-06 03:57:11'),(10,'2026-07-01 09:00:00',993,12,454,4,4869,0,1754.27,331.13,'2026-07-06 03:57:11','2026-07-06 03:57:11'),(11,'2026-07-01 10:00:00',1177,5,563,4,5613,0,1754.21,285.57,'2026-07-06 03:57:11','2026-07-06 03:57:11'),(12,'2026-07-01 11:00:00',1406,5,703,3,6443,0,1754.11,268.78,'2026-07-06 03:57:11','2026-07-06 03:57:11'),(13,'2026-07-01 12:00:00',1485,4,798,9,7045,0,1754.05,266.84,'2026-07-06 03:57:11','2026-07-06 03:57:11'),(14,'2026-07-01 13:00:00',1448,3,849,16,7060,0,1753.98,279.78,'2026-07-06 03:57:11','2026-07-06 03:57:11'),(15,'2026-07-01 14:00:00',1237,12,841,11,6132,0,1753.93,273.53,'2026-07-06 03:57:11','2026-07-06 03:57:11'),(16,'2026-07-01 15:00:00',1270,5,850,12,6506,0,1753.89,269.16,'2026-07-06 03:57:11','2026-07-06 03:57:11'),(17,'2026-07-01 16:00:00',1268,5,817,7,6092,0,1753.80,289.90,'2026-07-06 03:57:11','2026-07-06 03:57:11'),(18,'2026-07-01 17:00:00',1406,1,868,8,7160,0,1753.76,283.93,'2026-07-06 03:57:11','2026-07-06 03:57:11'),(19,'2026-07-01 18:00:00',1510,3,769,9,7331,0,1753.70,283.73,'2026-07-06 03:57:11','2026-07-06 03:57:11'),(20,'2026-07-01 19:00:00',1533,2,820,6,7406,0,1753.62,275.22,'2026-07-06 03:57:11','2026-07-06 03:57:11'),(21,'2026-07-01 20:00:00',1438,2,669,10,6532,0,1753.56,277.91,'2026-07-06 03:57:11','2026-07-06 03:57:11'),(22,'2026-07-01 21:00:00',1069,0,502,12,4561,0,1753.51,307.05,'2026-07-06 03:57:11','2026-07-06 03:57:11'),(23,'2026-07-01 22:00:00',696,6,251,4,3131,0,1753.45,355.38,'2026-07-06 03:57:11','2026-07-06 03:57:11'),(24,'2026-07-01 23:00:00',474,15,234,1,2389,0,1753.38,416.48,'2026-07-06 03:57:11','2026-07-06 03:57:11'),(25,'2026-07-02 00:00:00',270,1,132,1,1164,0,1753.34,586.91,'2026-07-06 03:57:12','2026-07-06 03:57:12'),(26,'2026-07-02 01:00:00',211,0,93,1,1026,0,1753.25,780.53,'2026-07-06 03:57:12','2026-07-06 03:57:12'),(27,'2026-07-02 02:00:00',128,0,87,0,617,0,1753.23,989.50,'2026-07-06 03:57:12','2026-07-06 03:57:12'),(28,'2026-07-02 03:00:00',114,0,68,0,550,0,1753.24,1437.78,'2026-07-06 03:57:12','2026-07-06 03:57:12'),(29,'2026-07-02 04:00:00',257,1,268,0,3173,0,1753.07,839.02,'2026-07-06 03:57:12','2026-07-06 03:57:12'),(30,'2026-07-02 05:00:00',233,0,131,0,1368,0,1753.02,504.17,'2026-07-06 03:57:12','2026-07-06 03:57:12'),(31,'2026-07-02 06:00:00',538,2,186,0,2332,0,1753.03,501.14,'2026-07-06 03:57:12','2026-07-06 03:57:12'),(32,'2026-07-02 07:00:00',807,2,307,3,3819,0,1753.01,401.18,'2026-07-06 03:57:12','2026-07-06 03:57:12'),(33,'2026-07-02 08:00:00',1005,2,476,4,5089,0,1752.93,361.29,'2026-07-06 03:57:12','2026-07-06 03:57:12'),(34,'2026-07-02 09:00:00',1100,0,517,6,5278,0,1752.79,324.50,'2026-07-06 03:57:12','2026-07-06 03:57:12'),(35,'2026-07-02 10:00:00',1303,5,647,3,6075,0,1752.77,277.31,'2026-07-06 03:57:12','2026-07-06 03:57:12'),(36,'2026-07-02 11:00:00',1495,4,763,2,6566,0,1752.76,296.40,'2026-07-06 03:57:12','2026-07-06 03:57:12'),(37,'2026-07-02 12:00:00',1531,3,827,11,7156,0,1752.64,285.36,'2026-07-06 03:57:12','2026-07-06 03:57:12'),(38,'2026-07-02 13:00:00',1339,2,887,13,6692,0,1752.61,290.66,'2026-07-06 03:57:12','2026-07-06 03:57:12'),(39,'2026-07-02 14:00:00',1255,1,916,13,6765,0,1752.59,281.22,'2026-07-06 03:57:12','2026-07-06 03:57:12'),(40,'2026-07-02 15:00:00',1205,1,859,11,5772,0,1752.50,340.98,'2026-07-06 03:57:12','2026-07-06 03:57:12'),(41,'2026-07-02 16:00:00',1276,2,865,18,6069,0,1752.39,302.16,'2026-07-06 03:57:12','2026-07-06 03:57:12'),(42,'2026-07-02 17:00:00',1358,1,755,10,6594,0,1752.31,293.80,'2026-07-06 03:57:12','2026-07-06 03:57:12'),(43,'2026-07-02 18:00:00',1539,6,797,7,6890,0,1752.29,307.47,'2026-07-06 03:57:12','2026-07-06 03:57:12'),(44,'2026-07-02 19:00:00',1520,1,783,9,6907,0,1752.21,297.07,'2026-07-06 03:57:12','2026-07-06 03:57:12'),(45,'2026-07-02 20:00:00',1376,5,701,11,6234,0,1752.15,300.40,'2026-07-06 03:57:12','2026-07-06 03:57:12'),(46,'2026-07-02 21:00:00',1023,1,469,9,4351,0,1752.10,334.05,'2026-07-06 03:57:12','2026-07-06 03:57:12'),(47,'2026-07-02 22:00:00',668,1,286,3,2910,0,1752.08,393.04,'2026-07-06 03:57:12','2026-07-06 03:57:12'),(48,'2026-07-02 23:00:00',492,0,243,2,2495,0,1752.01,469.20,'2026-07-06 03:57:12','2026-07-06 03:57:12'),(49,'2026-07-03 00:00:00',303,4,171,9,1132,0,1751.91,596.63,'2026-07-06 03:57:13','2026-07-06 03:57:13'),(50,'2026-07-03 01:00:00',191,2,101,2,878,0,1751.84,794.71,'2026-07-06 03:57:13','2026-07-06 03:57:13'),(51,'2026-07-03 02:00:00',132,2,86,1,571,0,1751.75,1090.11,'2026-07-06 03:57:13','2026-07-06 03:57:13'),(52,'2026-07-03 03:00:00',98,0,61,0,449,0,1751.81,1621.08,'2026-07-06 03:57:13','2026-07-06 03:57:13'),(53,'2026-07-03 04:00:00',220,2,205,0,2254,0,1751.48,656.24,'2026-07-06 03:57:13','2026-07-06 03:57:13'),(54,'2026-07-03 05:00:00',206,0,106,5,1238,0,1751.64,743.55,'2026-07-06 03:57:13','2026-07-06 03:57:13'),(55,'2026-07-03 06:00:00',432,0,217,2,2205,0,1751.56,523.37,'2026-07-06 03:57:13','2026-07-06 03:57:13'),(56,'2026-07-03 07:00:00',702,1,303,2,3640,0,1751.57,422.77,'2026-07-06 03:57:13','2026-07-06 03:57:13'),(57,'2026-07-03 08:00:00',944,0,389,10,4574,0,1751.57,422.62,'2026-07-06 03:57:13','2026-07-06 03:57:13'),(58,'2026-07-03 09:00:00',1079,1,482,9,5275,0,1751.41,325.35,'2026-07-06 03:57:13','2026-07-06 03:57:13'),(59,'2026-07-03 10:00:00',1245,10,689,11,6546,0,1751.41,295.16,'2026-07-06 03:57:13','2026-07-06 03:57:13'),(60,'2026-07-03 11:00:00',1390,4,668,10,6717,0,1751.35,319.57,'2026-07-06 03:57:13','2026-07-06 03:57:13'),(61,'2026-07-03 12:00:00',1615,3,798,11,7348,0,1751.28,304.60,'2026-07-06 03:57:13','2026-07-06 03:57:13'),(62,'2026-07-03 13:00:00',1579,1,862,6,7323,0,1751.18,296.94,'2026-07-06 03:57:13','2026-07-06 03:57:13'),(63,'2026-07-03 14:00:00',1289,1,899,14,6979,0,1751.10,293.23,'2026-07-06 03:57:13','2026-07-06 03:57:13'),(64,'2026-07-03 15:00:00',1384,4,974,10,6494,0,1751.06,278.44,'2026-07-06 03:57:13','2026-07-06 03:57:13'),(65,'2026-07-03 16:00:00',1394,2,888,8,6531,0,1750.99,296.92,'2026-07-06 03:57:13','2026-07-06 03:57:13'),(66,'2026-07-03 17:00:00',1485,2,868,9,6941,0,1750.91,289.68,'2026-07-06 03:57:13','2026-07-06 03:57:13'),(67,'2026-07-03 18:00:00',1622,3,803,10,7395,0,1750.89,294.92,'2026-07-06 03:57:13','2026-07-06 03:57:13'),(68,'2026-07-03 19:00:00',1588,2,797,8,7414,0,1750.77,307.45,'2026-07-06 03:57:13','2026-07-06 03:57:13'),(69,'2026-07-03 20:00:00',1499,4,694,9,6468,0,1750.73,303.71,'2026-07-06 03:57:13','2026-07-06 03:57:13'),(70,'2026-07-03 21:00:00',1095,0,463,7,4690,0,1750.69,336.14,'2026-07-06 03:57:13','2026-07-06 03:57:13'),(71,'2026-07-03 22:00:00',768,0,310,4,3121,0,1750.61,383.78,'2026-07-06 03:57:13','2026-07-06 03:57:13'),(72,'2026-07-03 23:00:00',547,0,292,3,2374,0,1750.54,427.40,'2026-07-06 03:57:13','2026-07-06 03:57:13'),(73,'2026-07-04 00:00:00',354,1,150,1,1337,0,1750.49,597.09,'2026-07-06 03:57:14','2026-07-06 03:57:14'),(74,'2026-07-04 01:00:00',210,1,123,1,994,0,1750.49,771.16,'2026-07-06 03:57:14','2026-07-06 03:57:14'),(75,'2026-07-04 02:00:00',138,0,87,3,685,0,1750.37,944.31,'2026-07-06 03:57:14','2026-07-06 03:57:14'),(76,'2026-07-04 03:00:00',91,0,53,0,550,0,1750.28,1389.81,'2026-07-06 03:57:14','2026-07-06 03:57:14'),(77,'2026-07-04 04:00:00',236,2,236,1,2551,0,1750.14,1220.11,'2026-07-06 03:57:14','2026-07-06 03:57:14'),(78,'2026-07-04 05:00:00',217,0,98,2,1069,0,1750.31,570.25,'2026-07-06 03:57:14','2026-07-06 03:57:14'),(79,'2026-07-04 06:00:00',405,0,189,1,2004,0,1750.17,579.88,'2026-07-06 03:57:14','2026-07-06 03:57:14'),(80,'2026-07-04 07:00:00',617,0,317,1,3202,0,1750.12,472.99,'2026-07-06 03:57:14','2026-07-06 03:57:14'),(81,'2026-07-04 08:00:00',955,6,408,4,4593,0,1750.08,395.34,'2026-07-06 03:57:14','2026-07-06 03:57:14'),(82,'2026-07-04 09:00:00',1220,3,571,10,5629,0,1750.01,350.71,'2026-07-06 03:57:14','2026-07-06 03:57:14'),(83,'2026-07-04 10:00:00',1348,0,678,10,6885,0,1749.91,338.63,'2026-07-06 03:57:14','2026-07-06 03:57:14'),(84,'2026-07-04 11:00:00',1591,4,791,7,8148,0,1749.83,289.42,'2026-07-06 03:57:14','2026-07-06 03:57:14'),(85,'2026-07-04 12:00:00',1654,3,915,11,8435,0,1749.77,288.83,'2026-07-06 03:57:14','2026-07-06 03:57:14'),(86,'2026-07-04 13:00:00',1754,5,957,16,8887,0,1749.71,281.75,'2026-07-06 03:57:14','2026-07-06 03:57:14'),(87,'2026-07-04 14:00:00',1699,4,1067,16,8811,0,1749.65,274.64,'2026-07-06 03:57:14','2026-07-06 03:57:14'),(88,'2026-07-04 15:00:00',1632,4,949,17,8519,0,1749.60,288.95,'2026-07-06 03:57:14','2026-07-06 03:57:14'),(89,'2026-07-04 16:00:00',1666,2,936,16,8293,0,1749.53,285.55,'2026-07-06 03:57:14','2026-07-06 03:57:14'),(90,'2026-07-04 17:00:00',1622,2,918,5,8124,0,1749.48,290.95,'2026-07-06 03:57:14','2026-07-06 03:57:14'),(91,'2026-07-04 18:00:00',1685,4,928,21,8146,0,1749.44,296.73,'2026-07-06 03:57:14','2026-07-06 03:57:14'),(92,'2026-07-04 19:00:00',1850,1,917,12,8416,0,1749.37,295.53,'2026-07-06 03:57:14','2026-07-06 03:57:14'),(93,'2026-07-04 20:00:00',1662,2,780,7,7728,0,1749.31,301.59,'2026-07-06 03:57:14','2026-07-06 03:57:14'),(94,'2026-07-04 21:00:00',1254,4,521,5,5534,0,1749.27,310.37,'2026-07-06 03:57:14','2026-07-06 03:57:14'),(95,'2026-07-04 22:00:00',702,4,308,5,3212,0,1749.18,369.21,'2026-07-06 03:57:14','2026-07-06 03:57:14'),(96,'2026-07-04 23:00:00',556,5,283,5,2444,0,1749.17,428.89,'2026-07-06 03:57:14','2026-07-06 03:57:14'),(97,'2026-07-05 00:00:00',416,1,175,6,1430,0,1749.08,569.09,'2026-07-06 03:57:15','2026-07-06 03:57:15'),(98,'2026-07-05 01:00:00',289,4,135,1,1001,0,1748.98,728.35,'2026-07-06 03:57:15','2026-07-06 03:57:15'),(99,'2026-07-05 02:00:00',180,0,96,0,656,0,1753.45,1019.75,'2026-07-06 03:57:15','2026-07-06 03:57:15'),(100,'2026-07-05 03:00:00',106,0,55,0,556,0,1748.87,1288.05,'2026-07-06 03:57:15','2026-07-06 03:57:15'),(101,'2026-07-05 04:00:00',143,0,77,0,798,0,1748.83,1143.12,'2026-07-06 03:57:15','2026-07-06 03:57:15'),(102,'2026-07-05 05:00:00',199,0,99,1,1115,0,1748.76,903.84,'2026-07-06 03:57:15','2026-07-06 03:57:15'),(103,'2026-07-05 06:00:00',386,1,164,0,1885,0,1748.69,622.10,'2026-07-06 03:57:15','2026-07-06 03:57:15'),(104,'2026-07-05 07:00:00',634,1,276,1,3334,0,1748.63,485.83,'2026-07-06 03:57:15','2026-07-06 03:57:15'),(105,'2026-07-05 08:00:00',859,1,384,2,4434,0,1748.64,419.91,'2026-07-06 03:57:15','2026-07-06 03:57:15'),(106,'2026-07-05 09:00:00',1145,0,485,8,5607,0,1748.60,383.30,'2026-07-06 03:57:15','2026-07-06 03:57:15'),(107,'2026-07-05 10:00:00',1462,2,710,7,6943,0,1748.46,353.70,'2026-07-06 03:57:15','2026-07-06 03:57:15'),(108,'2026-07-05 11:00:00',1568,0,885,15,8069,0,1748.41,311.01,'2026-07-06 03:57:15','2026-07-06 03:57:15'),(109,'2026-07-05 12:00:00',1653,7,843,12,8255,0,1748.37,310.90,'2026-07-06 03:57:15','2026-07-06 03:57:15'),(110,'2026-07-05 13:00:00',1731,3,969,15,8564,0,1748.32,326.66,'2026-07-06 03:57:15','2026-07-06 03:57:15'),(111,'2026-07-05 14:00:00',1585,2,897,11,8479,0,1748.38,307.56,'2026-07-06 03:57:15','2026-07-06 03:57:15'),(112,'2026-07-05 15:00:00',1675,0,935,19,8195,0,1748.19,315.88,'2026-07-06 03:57:15','2026-07-06 03:57:15'),(113,'2026-07-05 16:00:00',1615,4,855,10,8008,0,1748.11,314.01,'2026-07-06 03:57:15','2026-07-06 03:57:15'),(114,'2026-07-05 17:00:00',1694,3,868,19,8489,0,1748.07,315.19,'2026-07-06 03:57:15','2026-07-06 03:57:15'),(115,'2026-07-05 18:00:00',1882,3,876,14,8607,0,1748.02,313.79,'2026-07-06 03:57:15','2026-07-06 03:57:15'),(116,'2026-07-05 19:00:00',1831,4,907,8,8712,0,1747.93,307.67,'2026-07-06 03:57:15','2026-07-06 03:57:15'),(117,'2026-07-05 20:00:00',1487,4,738,10,6987,0,1747.87,308.31,'2026-07-06 03:57:15','2026-07-06 03:57:15'),(118,'2026-07-05 21:00:00',954,6,469,4,4612,0,1747.87,357.04,'2026-07-06 03:57:15','2026-07-06 03:57:15'),(119,'2026-07-05 22:00:00',622,6,288,5,2803,0,1747.81,440.60,'2026-07-06 03:57:15','2026-07-06 03:57:15'),(120,'2026-07-05 23:00:00',468,4,229,3,2141,0,1747.68,469.40,'2026-07-06 03:57:15','2026-07-06 03:57:15'),(121,'2026-07-06 00:00:00',229,1,122,2,1105,0,1747.66,661.22,'2026-07-07 01:29:29','2026-07-07 01:29:29'),(122,'2026-07-06 01:00:00',164,0,112,1,813,0,1747.56,869.04,'2026-07-07 01:29:29','2026-07-07 01:29:29'),(123,'2026-07-06 02:00:00',104,1,60,0,597,0,1747.48,1145.39,'2026-07-07 01:29:29','2026-07-07 01:29:29'),(124,'2026-07-06 03:00:00',228,0,273,1,3349,0,1747.24,737.19,'2026-07-07 01:29:29','2026-07-07 01:29:29'),(125,'2026-07-06 04:00:00',144,2,91,1,947,0,1747.57,667.37,'2026-07-07 01:29:29','2026-07-07 01:29:29'),(126,'2026-07-06 05:00:00',296,1,115,0,1487,0,1747.35,796.44,'2026-07-07 01:29:29','2026-07-07 01:29:29'),(127,'2026-07-06 06:00:00',449,2,174,1,2388,0,1747.28,558.13,'2026-07-07 01:29:29','2026-07-07 01:29:29'),(128,'2026-07-06 07:00:00',719,2,316,9,3924,0,1747.24,446.70,'2026-07-07 01:29:29','2026-07-07 01:29:29'),(129,'2026-07-06 08:00:00',1237,8,461,5,5584,0,1747.21,350.75,'2026-07-07 01:29:29','2026-07-07 01:29:29'),(130,'2026-07-06 09:00:00',991,4,539,3,4743,0,1747.12,327.24,'2026-07-07 01:29:29','2026-07-07 01:29:29'),(131,'2026-07-06 10:00:00',1373,11,897,7,8434,0,1747.14,306.52,'2026-07-07 01:29:29','2026-07-07 01:29:29'),(132,'2026-07-06 11:00:00',1889,10,1307,16,12777,0,1747.01,274.26,'2026-07-07 01:29:29','2026-07-07 01:29:29'),(133,'2026-07-06 12:00:00',1789,6,1244,9,10164,0,1746.93,243.60,'2026-07-07 01:29:29','2026-07-07 01:29:29'),(134,'2026-07-06 13:00:00',1465,10,1080,26,8413,0,1746.89,274.95,'2026-07-07 01:29:29','2026-07-07 01:29:29'),(135,'2026-07-06 14:00:00',1736,16,1131,20,9820,0,1746.81,266.07,'2026-07-07 01:29:29','2026-07-07 01:29:29'),(136,'2026-07-06 15:00:00',1179,6,832,12,5830,0,1746.75,279.74,'2026-07-07 01:29:29','2026-07-07 01:29:29'),(137,'2026-07-06 16:00:00',1329,11,871,8,6395,0,1746.73,322.75,'2026-07-07 01:29:29','2026-07-07 01:29:29'),(138,'2026-07-06 17:00:00',1405,6,814,10,7187,0,1746.65,269.24,'2026-07-07 01:29:29','2026-07-07 01:29:29'),(139,'2026-07-06 18:00:00',1539,4,817,11,7147,0,1746.62,302.13,'2026-07-07 01:29:29','2026-07-07 01:29:29'),(140,'2026-07-06 19:00:00',1594,1,789,13,7001,0,1746.50,295.68,'2026-07-07 01:29:29','2026-07-07 01:29:29'),(141,'2026-07-06 20:00:00',1352,2,687,8,6129,0,1746.52,325.90,'2026-07-07 01:29:29','2026-07-07 01:29:29'),(142,'2026-07-06 21:00:00',967,7,483,5,4182,0,1746.38,328.47,'2026-07-07 01:29:29','2026-07-07 01:29:29'),(143,'2026-07-06 22:00:00',569,1,341,1,2970,0,1746.31,397.63,'2026-07-07 01:29:29','2026-07-07 01:29:29'),(144,'2026-07-06 23:00:00',428,2,261,7,2326,0,1746.24,432.25,'2026-07-07 01:29:29','2026-07-07 01:29:29');
/*!40000 ALTER TABLE `engine_notif_reports` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `failed_jobs`
--

DROP TABLE IF EXISTS `failed_jobs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `failed_jobs` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `uuid` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `connection` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `exception` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `failed_jobs`
--

LOCK TABLES `failed_jobs` WRITE;
/*!40000 ALTER TABLE `failed_jobs` DISABLE KEYS */;
/*!40000 ALTER TABLE `failed_jobs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `inventories`
--

DROP TABLE IF EXISTS `inventories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `inventories` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `item_code` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `item_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `stock` int NOT NULL DEFAULT '0',
  `price` decimal(12,2) NOT NULL,
  `total_value` decimal(12,2) DEFAULT NULL,
  `location` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `notes` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `inventories_item_code_unique` (`item_code`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `inventories`
--

LOCK TABLES `inventories` WRITE;
/*!40000 ALTER TABLE `inventories` DISABLE KEYS */;
INSERT INTO `inventories` VALUES (1,'BRG-0001','Laptop',2,3000000.00,6000000.00,'ruang guru','tahun beli 2024','2026-07-10 04:16:00','2026-07-10 04:16:00'),(2,'BRG-0002','papan tulis kelas',4,300000.00,0.00,'setiap kelas',NULL,'2026-07-10 07:21:41','2026-07-10 07:21:41'),(3,'BRG-0003','printer',2,1500000.00,NULL,'ruang guru','rak no. 5','2026-07-10 07:24:49','2026-07-10 07:24:49');
/*!40000 ALTER TABLE `inventories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `job_batches`
--

DROP TABLE IF EXISTS `job_batches`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `job_batches` (
  `id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `total_jobs` int NOT NULL,
  `pending_jobs` int NOT NULL,
  `failed_jobs` int NOT NULL,
  `failed_job_ids` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `options` mediumtext COLLATE utf8mb4_unicode_ci,
  `cancelled_at` int DEFAULT NULL,
  `created_at` int NOT NULL,
  `finished_at` int DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `job_batches`
--

LOCK TABLES `job_batches` WRITE;
/*!40000 ALTER TABLE `job_batches` DISABLE KEYS */;
/*!40000 ALTER TABLE `job_batches` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `jobs`
--

DROP TABLE IF EXISTS `jobs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `jobs` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `queue` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `attempts` tinyint unsigned NOT NULL,
  `reserved_at` int unsigned DEFAULT NULL,
  `available_at` int unsigned NOT NULL,
  `created_at` int unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `jobs_queue_index` (`queue`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `jobs`
--

LOCK TABLES `jobs` WRITE;
/*!40000 ALTER TABLE `jobs` DISABLE KEYS */;
/*!40000 ALTER TABLE `jobs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `master_aplikasi`
--

DROP TABLE IF EXISTS `master_aplikasi`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `master_aplikasi` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `nama` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `keterangan` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `master_aplikasi_nama_unique` (`nama`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `master_aplikasi`
--

LOCK TABLES `master_aplikasi` WRITE;
/*!40000 ALTER TABLE `master_aplikasi` DISABLE KEYS */;
INSERT INTO `master_aplikasi` VALUES (1,'MTELEPLUS','mtel tes te',NULL,'2026-07-06 02:39:35','2026-07-06 03:23:00'),(2,'ENGINE NOTIF CC','Notifikasi kartu kredit BNI',NULL,'2026-07-06 02:40:17','2026-07-06 02:50:12'),(3,'WIC','Walk In Customer',NULL,'2026-07-06 02:40:33','2026-07-06 02:40:33');
/*!40000 ALTER TABLE `master_aplikasi` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `master_metrik`
--

DROP TABLE IF EXISTS `master_metrik`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `master_metrik` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `nama` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `satuan_default` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `keterangan` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `master_metrik_nama_unique` (`nama`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `master_metrik`
--

LOCK TABLES `master_metrik` WRITE;
/*!40000 ALTER TABLE `master_metrik` DISABLE KEYS */;
INSERT INTO `master_metrik` VALUES (1,'CPU','%','CPU Usage',NULL,'2026-07-06 02:36:09','2026-07-06 02:36:09'),(2,'MEMORY','%','Memory Usage',NULL,'2026-07-06 02:36:09','2026-07-06 02:36:09'),(3,'DISK','%','Disk Usage',NULL,'2026-07-06 02:36:09','2026-07-06 02:36:09'),(4,'NETWORK_IN','MB/s','Network Inbound',NULL,'2026-07-06 02:36:09','2026-07-06 02:36:09'),(5,'NETWORK_OUT','MB/s','Network Outbound',NULL,'2026-07-06 02:36:09','2026-07-06 02:36:09'),(6,'LOAD_1M','-','Load Average (1 menit)',NULL,'2026-07-06 02:36:09','2026-07-06 02:36:09'),(7,'LOAD_5M','-','Load Average (5 menit)',NULL,'2026-07-06 02:36:09','2026-07-06 02:36:09'),(8,'LOAD_15M','-','Load Average (15 menit)',NULL,'2026-07-06 02:36:09','2026-07-06 02:36:09'),(9,'RESPONSE_TIME','ms','Response Time',NULL,'2026-07-06 02:36:09','2026-07-06 02:36:09');
/*!40000 ALTER TABLE `master_metrik` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `migrations`
--

DROP TABLE IF EXISTS `migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `migrations` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `migrations`
--

LOCK TABLES `migrations` WRITE;
/*!40000 ALTER TABLE `migrations` DISABLE KEYS */;
INSERT INTO `migrations` VALUES (1,'0001_01_01_000000_create_users_table',1),(2,'0001_01_01_000001_create_cache_table',1),(3,'0001_01_01_000002_create_jobs_table',1),(4,'2020_10_04_115514_create_moonshine_roles_table',1),(5,'2020_10_05_173148_create_moonshine_tables',1),(6,'2026_05_22_014556_create_notifications_table',1),(7,'2026_05_26_033044_create_engine_notif_reports_table',1),(8,'2026_06_04_140613_create_mteleplus_reports_table',1),(9,'2026_06_09_000001_create_app_metrics_table',1),(10,'2026_06_10_000001_add_role_and_avatar_to_users_table',1),(11,'2026_06_12_000001_create_master_tables',1),(12,'2026_07_03_000004_create_report_sources_table',1),(13,'2026_07_03_000006_create_trx_pbi_reports_table',1),(14,'2026_07_07_141405_create_employees_table',2),(15,'2026_07_08_095607_create_attendances_table',3),(16,'2026_07_09_091532_add_gender_and_photo_to_employees_table',4),(17,'2026_07_10_084420_add_address_and_birthday_to_employees_table',5),(18,'2026_07_10_104939_create_inventories_table',6),(19,'2026_07_10_143056_create_students_table',7),(20,'2026_07_10_150413_create_students_table',8),(21,'2026_07_10_151125_add_address_and_foto_to_student_table',9);
/*!40000 ALTER TABLE `migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `moonshine_user_roles`
--

DROP TABLE IF EXISTS `moonshine_user_roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `moonshine_user_roles` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `moonshine_user_roles`
--

LOCK TABLES `moonshine_user_roles` WRITE;
/*!40000 ALTER TABLE `moonshine_user_roles` DISABLE KEYS */;
INSERT INTO `moonshine_user_roles` VALUES (1,'Admin','2026-07-06 02:36:09','2026-07-06 02:36:09'),(2,'User','2026-07-06 02:36:09','2026-07-06 02:36:09'),(3,'Operator','2026-07-09 02:01:34','2026-07-09 02:01:34');
/*!40000 ALTER TABLE `moonshine_user_roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `moonshine_users`
--

DROP TABLE IF EXISTS `moonshine_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `moonshine_users` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `moonshine_user_role_id` bigint unsigned NOT NULL DEFAULT '1',
  `email` varchar(190) COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `avatar` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `moonshine_users_email_unique` (`email`),
  KEY `moonshine_users_moonshine_user_role_id_foreign` (`moonshine_user_role_id`),
  CONSTRAINT `moonshine_users_moonshine_user_role_id_foreign` FOREIGN KEY (`moonshine_user_role_id`) REFERENCES `moonshine_user_roles` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `moonshine_users`
--

LOCK TABLES `moonshine_users` WRITE;
/*!40000 ALTER TABLE `moonshine_users` DISABLE KEYS */;
INSERT INTO `moonshine_users` VALUES (1,1,'admin@gmail.com','$2y$12$4nmpji0RjDfWR8R.J2N12e4HxqRfEcGp7EOH5sdCHolqMjidnYHAK','administrator',NULL,NULL,'2026-07-06 02:36:55','2026-07-06 02:36:55'),(2,2,'user1@tes.com','$2y$12$7zvxDlMa.8059KYJXZ/RSeJUgbodmeq59V4Lw9n5jvMJezi80CW.G','user1','moonshine_users/DTxeKMyPRqAahsKWoVeJrWWLBUyDMjhvce4xV7br.png',NULL,'2026-07-08 17:00:00','2026-07-09 02:02:55');
/*!40000 ALTER TABLE `moonshine_users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mteleplus_reports`
--

DROP TABLE IF EXISTS `mteleplus_reports`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `mteleplus_reports` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `report_hour` datetime NOT NULL,
  `akt_success` bigint NOT NULL DEFAULT '0',
  `akt_fail` bigint NOT NULL DEFAULT '0',
  `rpin_success` bigint NOT NULL DEFAULT '0',
  `rpin_fail` bigint NOT NULL DEFAULT '0',
  `total_incoming` bigint NOT NULL DEFAULT '0',
  `total_outgoing` bigint NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `mteleplus_reports_report_hour_unique` (`report_hour`),
  KEY `mteleplus_reports_report_hour_index` (`report_hour`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mteleplus_reports`
--

LOCK TABLES `mteleplus_reports` WRITE;
/*!40000 ALTER TABLE `mteleplus_reports` DISABLE KEYS */;
/*!40000 ALTER TABLE `mteleplus_reports` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `notifications`
--

DROP TABLE IF EXISTS `notifications`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `notifications` (
  `id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `notifiable_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `notifiable_id` bigint unsigned NOT NULL,
  `data` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `read_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `notifications_notifiable_type_notifiable_id_index` (`notifiable_type`,`notifiable_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notifications`
--

LOCK TABLES `notifications` WRITE;
/*!40000 ALTER TABLE `notifications` DISABLE KEYS */;
/*!40000 ALTER TABLE `notifications` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `password_reset_tokens`
--

DROP TABLE IF EXISTS `password_reset_tokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `password_reset_tokens` (
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `password_reset_tokens`
--

LOCK TABLES `password_reset_tokens` WRITE;
/*!40000 ALTER TABLE `password_reset_tokens` DISABLE KEYS */;
/*!40000 ALTER TABLE `password_reset_tokens` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `report_sources`
--

DROP TABLE IF EXISTS `report_sources`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `report_sources` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `service_name` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `app_id` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `data_source` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'ELK',
  `data_source_name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `service_integrator` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `report_sources_service_name_unique` (`service_name`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `report_sources`
--

LOCK TABLES `report_sources` WRITE;
/*!40000 ALTER TABLE `report_sources` DISABLE KEYS */;
INSERT INTO `report_sources` VALUES (1,'trx_pbi_limit','AFO','ELK','wic-trx-pbi-ceklimit*','WIC','2026-07-06 02:36:09','2026-07-06 02:36:09'),(2,'trx_pbi_settlement','AFO','ELK','log-wic-trx-pbi*','WIC','2026-07-06 02:36:09','2026-07-06 02:36:09');
/*!40000 ALTER TABLE `report_sources` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sessions`
--

DROP TABLE IF EXISTS `sessions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sessions` (
  `id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint unsigned DEFAULT NULL,
  `ip_address` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_agent` text COLLATE utf8mb4_unicode_ci,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_activity` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `sessions_user_id_index` (`user_id`),
  KEY `sessions_last_activity_index` (`last_activity`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sessions`
--

LOCK TABLES `sessions` WRITE;
/*!40000 ALTER TABLE `sessions` DISABLE KEYS */;
INSERT INTO `sessions` VALUES ('0RoNV6btkH3xXSt54LXP9MhYw7mU7gssLAvtH2L0',NULL,'127.0.0.1','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36','YTozOntzOjY6Il90b2tlbiI7czo0MDoiT0dtVnIzR1c2U092NEkxd2ROcWQzRG1wSjl6UHdHQkRnS2ZiSWhZYyI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6Mzg6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hdHRlbmRhbmNlLWtpb3NrIjtzOjU6InJvdXRlIjtzOjE2OiJhdHRlbmRhbmNlLmtpb3NrIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==',1783742049),('MFI7ECwqiiIhB517owIY85EGlK4TezFMLKKXZrfU',1,'127.0.0.1','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36','YTo2OntzOjY6Il90b2tlbiI7czo0MDoiejI2YklhYkR3eldHZkFjbkRqYk5rZ2J1clE4U21Md3dhYVpVRWh3VSI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6NzQ6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC9hZG1pbi9yZXNvdXJjZS9lbXBsb3llZS1yZXNvdXJjZS9lbXBsb3llZS1pbmRleC1wYWdlIjtzOjU6InJvdXRlIjtzOjIzOiJtb29uc2hpbmUucmVzb3VyY2UucGFnZSI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fXM6MzoidXJsIjthOjA6e31zOjU2OiJsb2dpbl9tb29uc2hpbmVfNTliYTM2YWRkYzJiMmY5NDAxNTgwZjAxNGM3ZjU4ZWE0ZTMwOTg5ZCI7aToxO3M6MjM6InBhc3N3b3JkX2hhc2hfbW9vbnNoaW5lIjtzOjY0OiJhNDg4YTNhMWMxNDRiNjZlNWZlOGFhYjYyMmYwNzVjMjc4OTA0YmY0ZjI0NTI4Y2MzZDM1YzZmZmZlNTJiYTgzIjt9',1783689060),('sSdhyhxoYDKYJ1nZu7DGnoxO2572enJ3Q7J5wuQr',1,'127.0.0.1','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36','YTo2OntzOjY6Il90b2tlbiI7czo0MDoibkJ1cmNvTllaNTlPQnFRUHF4Y0RWbjkzejZkcFJyNDBTdnh4cWpMVCI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6NzU6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC9hZG1pbi9yZXNvdXJjZS9pbnZlbnRvcnktcmVzb3VyY2UvaW52ZW50b3J5LWZvcm0tcGFnZSI7czo1OiJyb3V0ZSI7czoyMzoibW9vbnNoaW5lLnJlc291cmNlLnBhZ2UiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX1zOjM6InVybCI7YTowOnt9czo1NjoibG9naW5fbW9vbnNoaW5lXzU5YmEzNmFkZGMyYjJmOTQwMTU4MGYwMTRjN2Y1OGVhNGUzMDk4OWQiO2k6MTtzOjIzOiJwYXNzd29yZF9oYXNoX21vb25zaGluZSI7czo2NDoiYTQ4OGEzYTFjMTQ0YjY2ZTVmZThhYWI2MjJmMDc1YzI3ODkwNGJmNGYyNDUyOGNjM2QzNWM2ZmZmZTUyYmE4MyI7fQ==',1783741974),('YygKqjrOVkpciIehrdvb1Nz3Gn6WkziVwnELZuEa',NULL,'127.0.0.1','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/149.0.0.0 Safari/537.36','YTo0OntzOjY6Il90b2tlbiI7czo0MDoiVW50Y2MzMU93ZW1TYklxNG5IMGl4RTZ5RUtudmR1ZWRESEFQV3FjVCI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6Mzg6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hdHRlbmRhbmNlLWtpb3NrIjtzOjU6InJvdXRlIjtzOjE2OiJhdHRlbmRhbmNlLmtpb3NrIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319czozOiJ1cmwiO2E6MTp7czo4OiJpbnRlbmRlZCI7czoyNzoiaHR0cDovL2xvY2FsaG9zdDo4MDAwL2FkbWluIjt9fQ==',1783687317);
/*!40000 ALTER TABLE `sessions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `students`
--

DROP TABLE IF EXISTS `students`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `students` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `nisn` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `address` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `foto` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `gender` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `birth_date` date NOT NULL,
  `phone` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` enum('aktif','lulus','pindah','keluar') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'aktif',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `students_nisn_unique` (`nisn`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `students`
--

LOCK TABLES `students` WRITE;
/*!40000 ALTER TABLE `students` DISABLE KEYS */;
INSERT INTO `students` VALUES (1,'000121001012','ahmad dahlan',NULL,'students/AV7PoUOco1S8AQHEfkxKFjcagiQYKUDusEijOXPQ.png','L','2022-05-19','08556644123','aktif','2026-07-10 08:08:56','2026-07-10 08:18:33'),(2,'2515424265375','doni karama',NULL,'students/63BjcS4dstPwKRAdu84Xnd3y1UVIr6DxnrZyY5Lx.png','L','2021-12-12','085677778789','aktif','2026-07-10 11:48:37','2026-07-10 11:48:37');
/*!40000 ALTER TABLE `students` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `trx_pbi_limit_reports`
--

DROP TABLE IF EXISTS `trx_pbi_limit_reports`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `trx_pbi_limit_reports` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `report_source_id` bigint unsigned DEFAULT NULL,
  `trx_date` date NOT NULL,
  `trx_hour` tinyint unsigned NOT NULL,
  `trx_currency` varchar(10) COLLATE utf8mb4_unicode_ci NOT NULL,
  `trx_count` bigint unsigned NOT NULL DEFAULT '0',
  `success_count` bigint unsigned NOT NULL DEFAULT '0',
  `trx_amount` decimal(20,2) NOT NULL DEFAULT '0.00',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `trx_pbi_limit_reports_trx_date_trx_hour_trx_currency_unique` (`trx_date`,`trx_hour`,`trx_currency`),
  KEY `trx_pbi_limit_reports_report_source_id_foreign` (`report_source_id`),
  KEY `trx_pbi_limit_reports_trx_date_index` (`trx_date`),
  KEY `trx_pbi_limit_reports_trx_hour_index` (`trx_hour`),
  CONSTRAINT `trx_pbi_limit_reports_report_source_id_foreign` FOREIGN KEY (`report_source_id`) REFERENCES `report_sources` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=968 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `trx_pbi_limit_reports`
--

LOCK TABLES `trx_pbi_limit_reports` WRITE;
/*!40000 ALTER TABLE `trx_pbi_limit_reports` DISABLE KEYS */;
INSERT INTO `trx_pbi_limit_reports` VALUES (1,1,'2026-07-01',0,'EUR',5,5,4283458.00,'2026-07-06 02:38:02','2026-07-06 02:38:02'),(2,1,'2026-07-01',0,'SGD',2,2,17794160.00,'2026-07-06 02:38:02','2026-07-06 02:38:02'),(3,1,'2026-07-01',0,'USD',2,2,35426460.00,'2026-07-06 02:38:02','2026-07-06 02:38:02'),(4,1,'2026-07-01',0,'AUD',1,1,12388.00,'2026-07-06 02:38:02','2026-07-06 02:38:02'),(5,1,'2026-07-01',0,'HKD',1,1,434910.00,'2026-07-06 02:38:02','2026-07-06 02:38:02'),(6,1,'2026-07-01',0,'MYR',1,1,110000000.00,'2026-07-06 02:38:02','2026-07-06 02:38:02'),(7,1,'2026-07-01',1,'MYR',3,3,788773.00,'2026-07-06 02:38:02','2026-07-06 02:38:02'),(8,1,'2026-07-01',1,'SGD',3,3,7778800.00,'2026-07-06 02:38:02','2026-07-06 02:38:02'),(9,1,'2026-07-01',1,'USD',3,3,73748912.00,'2026-07-06 02:38:02','2026-07-06 02:38:02'),(10,1,'2026-07-01',1,'EUR',1,1,4156831.00,'2026-07-06 02:38:02','2026-07-06 02:38:02'),(11,1,'2026-07-01',1,'NZD',1,1,7384212.00,'2026-07-06 02:38:02','2026-07-06 02:38:02'),(12,1,'2026-07-01',2,'USD',2,2,6398500.00,'2026-07-06 02:38:02','2026-07-06 02:38:02'),(13,1,'2026-07-01',2,'MYR',1,1,2000000.00,'2026-07-06 02:38:02','2026-07-06 02:38:02'),(14,1,'2026-07-01',2,'SGD',1,1,2500000.00,'2026-07-06 02:38:02','2026-07-06 02:38:02'),(15,1,'2026-07-01',3,'JPY',3,3,2628895.00,'2026-07-06 02:38:02','2026-07-06 02:38:02'),(16,1,'2026-07-01',3,'EUR',2,2,146379952.00,'2026-07-06 02:38:02','2026-07-06 02:38:02'),(17,1,'2026-07-01',3,'CNY',1,1,13245000.00,'2026-07-06 02:38:02','2026-07-06 02:38:02'),(18,1,'2026-07-01',3,'NZD',1,1,1079829.00,'2026-07-06 02:38:02','2026-07-06 02:38:02'),(19,1,'2026-07-01',3,'SAR',1,1,5000000.00,'2026-07-06 02:38:02','2026-07-06 02:38:02'),(20,1,'2026-07-01',3,'USD',1,1,7188000.00,'2026-07-06 02:38:02','2026-07-06 02:38:02'),(21,1,'2026-07-01',4,'USD',8,8,9257733.00,'2026-07-06 02:38:02','2026-07-06 02:38:02'),(22,1,'2026-07-01',4,'SAR',3,3,587261.00,'2026-07-06 02:38:02','2026-07-06 02:38:02'),(23,1,'2026-07-01',4,'EUR',2,2,57458464.00,'2026-07-06 02:38:02','2026-07-06 02:38:02'),(24,1,'2026-07-01',4,'JPY',2,2,2250000.00,'2026-07-06 02:38:02','2026-07-06 02:38:02'),(25,1,'2026-07-01',4,'GBP',1,1,178391328.00,'2026-07-06 02:38:02','2026-07-06 02:38:02'),(26,1,'2026-07-01',4,'MYR',1,1,400000.00,'2026-07-06 02:38:02','2026-07-06 02:38:02'),(27,1,'2026-07-01',4,'SGD',1,1,874440.00,'2026-07-06 02:38:02','2026-07-06 02:38:02'),(28,1,'2026-07-01',5,'USD',20,20,29312604.00,'2026-07-06 02:38:02','2026-07-06 02:38:02'),(29,1,'2026-07-01',5,'AUD',3,3,30424928.00,'2026-07-06 02:38:02','2026-07-06 02:38:02'),(30,1,'2026-07-01',5,'EUR',3,3,4969165.00,'2026-07-06 02:38:02','2026-07-06 02:38:02'),(31,1,'2026-07-01',5,'MYR',3,3,7846900.00,'2026-07-06 02:38:02','2026-07-06 02:38:02'),(32,1,'2026-07-01',5,'JPY',2,2,388010.00,'2026-07-06 02:38:02','2026-07-06 02:38:02'),(33,1,'2026-07-01',5,'SGD',2,2,4141576.00,'2026-07-06 02:38:02','2026-07-06 02:38:02'),(34,1,'2026-07-01',5,'GBP',1,1,2000000.00,'2026-07-06 02:38:02','2026-07-06 02:38:02'),(35,1,'2026-07-01',5,'SAR',1,1,1912400.00,'2026-07-06 02:38:02','2026-07-06 02:38:02'),(36,1,'2026-07-01',6,'USD',18,18,47463805.00,'2026-07-06 02:38:02','2026-07-06 02:38:02'),(37,1,'2026-07-01',6,'SGD',10,10,312523880.00,'2026-07-06 02:38:02','2026-07-06 02:38:02'),(38,1,'2026-07-01',6,'JPY',4,4,8671000.00,'2026-07-06 02:38:02','2026-07-06 02:38:02'),(39,1,'2026-07-01',6,'MYR',3,3,6636048.00,'2026-07-06 02:38:02','2026-07-06 02:38:02'),(40,1,'2026-07-01',6,'CNY',2,2,5443700.00,'2026-07-06 02:38:02','2026-07-06 02:38:02'),(41,1,'2026-07-01',6,'AUD',1,1,1238800.00,'2026-07-06 02:38:02','2026-07-06 02:38:02'),(42,1,'2026-07-01',6,'GBP',1,1,451744.00,'2026-07-06 02:38:02','2026-07-06 02:38:02'),(43,1,'2026-07-01',6,'HKD',1,1,860020.00,'2026-07-06 02:38:02','2026-07-06 02:38:02'),(44,1,'2026-07-01',6,'KRW',1,1,650000.00,'2026-07-06 02:38:02','2026-07-06 02:38:02'),(45,1,'2026-07-01',6,'SAR',1,1,300000.00,'2026-07-06 02:38:02','2026-07-06 02:38:02'),(46,1,'2026-07-01',7,'USD',17,17,222712530.00,'2026-07-06 02:38:02','2026-07-06 02:38:02'),(47,1,'2026-07-01',7,'AUD',5,5,96780612.00,'2026-07-06 02:38:02','2026-07-06 02:38:02'),(48,1,'2026-07-01',7,'SGD',4,4,228589712.00,'2026-07-06 02:38:02','2026-07-06 02:38:02'),(49,1,'2026-07-01',7,'JPY',3,3,56161676.00,'2026-07-06 02:38:02','2026-07-06 02:38:02'),(50,1,'2026-07-01',7,'CNY',2,2,65181792.00,'2026-07-06 02:38:02','2026-07-06 02:38:02'),(51,1,'2026-07-01',7,'GBP',2,2,475520.00,'2026-07-06 02:38:02','2026-07-06 02:38:02'),(52,1,'2026-07-01',7,'KRW',1,1,100000000.00,'2026-07-06 02:38:02','2026-07-06 02:38:02'),(53,1,'2026-07-01',7,'MYR',1,1,1850998.00,'2026-07-06 02:38:02','2026-07-06 02:38:02'),(54,1,'2026-07-01',7,'SAR',1,1,6695814.00,'2026-07-06 02:38:02','2026-07-06 02:38:02'),(55,1,'2026-07-01',7,'THB',1,1,4000000.00,'2026-07-06 02:38:02','2026-07-06 02:38:02'),(56,1,'2026-07-01',8,'USD',28,28,422810715.00,'2026-07-06 02:38:02','2026-07-06 02:38:02'),(57,1,'2026-07-01',8,'SGD',13,13,48450332.00,'2026-07-06 02:38:02','2026-07-06 02:38:02'),(58,1,'2026-07-01',8,'AUD',8,8,253923474.00,'2026-07-06 02:38:02','2026-07-06 02:38:02'),(59,1,'2026-07-01',8,'JPY',8,8,68390141.00,'2026-07-06 02:38:02','2026-07-06 02:38:02'),(60,1,'2026-07-01',8,'CNY',4,4,22162745.00,'2026-07-06 02:38:02','2026-07-06 02:38:02'),(61,1,'2026-07-01',8,'GBP',2,2,40424112.00,'2026-07-06 02:38:02','2026-07-06 02:38:02'),(62,1,'2026-07-01',8,'SAR',2,2,1203800.00,'2026-07-06 02:38:02','2026-07-06 02:38:02'),(63,1,'2026-07-01',8,'EUR',1,1,266019.00,'2026-07-06 02:38:02','2026-07-06 02:38:02'),(64,1,'2026-07-01',8,'MYR',1,1,5812656.00,'2026-07-06 02:38:02','2026-07-06 02:38:02'),(65,1,'2026-07-01',9,'USD',39,39,441555701.00,'2026-07-06 02:38:02','2026-07-06 02:38:02'),(66,1,'2026-07-01',9,'SGD',12,12,57055390.00,'2026-07-06 02:38:02','2026-07-06 02:38:02'),(67,1,'2026-07-01',9,'MYR',10,10,42108297.00,'2026-07-06 02:38:02','2026-07-06 02:38:02'),(68,1,'2026-07-01',9,'AUD',5,5,195795031.00,'2026-07-06 02:38:02','2026-07-06 02:38:02'),(69,1,'2026-07-01',9,'EUR',5,5,115446967.00,'2026-07-06 02:38:02','2026-07-06 02:38:02'),(70,1,'2026-07-01',9,'JPY',5,5,10697400.00,'2026-07-06 02:38:02','2026-07-06 02:38:02'),(71,1,'2026-07-01',9,'HKD',4,4,2182730.00,'2026-07-06 02:38:02','2026-07-06 02:38:02'),(72,1,'2026-07-01',9,'SAR',4,4,2024780.00,'2026-07-06 02:38:02','2026-07-06 02:38:02'),(73,1,'2026-07-01',9,'CNY',2,2,3002647.00,'2026-07-06 02:38:02','2026-07-06 02:38:02'),(74,1,'2026-07-01',9,'GBP',2,2,2404537.00,'2026-07-06 02:38:02','2026-07-06 02:38:02'),(75,1,'2026-07-01',9,'KRW',1,1,17900000.00,'2026-07-06 02:38:02','2026-07-06 02:38:02'),(76,1,'2026-07-01',10,'USD',29,29,137165014.00,'2026-07-06 02:38:02','2026-07-06 02:38:02'),(77,1,'2026-07-01',10,'SGD',18,18,29209086.00,'2026-07-06 02:38:02','2026-07-06 02:38:02'),(78,1,'2026-07-01',10,'JPY',12,12,31435578.00,'2026-07-06 02:38:02','2026-07-06 02:38:02'),(79,1,'2026-07-01',10,'AUD',8,8,79783546.00,'2026-07-06 02:38:02','2026-07-06 02:38:02'),(80,1,'2026-07-01',10,'MYR',6,6,7828072.00,'2026-07-06 02:38:02','2026-07-06 02:38:02'),(81,1,'2026-07-01',10,'SAR',5,5,1656300.00,'2026-07-06 02:38:02','2026-07-06 02:38:02'),(82,1,'2026-07-01',10,'HKD',3,3,4239640.00,'2026-07-06 02:38:02','2026-07-06 02:38:02'),(83,1,'2026-07-01',10,'EUR',2,2,160313009.00,'2026-07-06 02:38:02','2026-07-06 02:38:02'),(84,1,'2026-07-01',10,'KRW',2,2,1990530.00,'2026-07-06 02:38:02','2026-07-06 02:38:02'),(85,1,'2026-07-01',10,'THB',2,2,4508002.00,'2026-07-06 02:38:02','2026-07-06 02:38:02'),(86,1,'2026-07-01',10,'CNY',1,1,794100.00,'2026-07-06 02:38:02','2026-07-06 02:38:02'),(87,1,'2026-07-01',10,'GBP',1,1,237940.00,'2026-07-06 02:38:02','2026-07-06 02:38:02'),(88,1,'2026-07-01',11,'USD',27,27,694770519.00,'2026-07-06 02:38:02','2026-07-06 02:38:02'),(89,1,'2026-07-01',11,'SGD',16,16,90482308.00,'2026-07-06 02:38:02','2026-07-06 02:38:02'),(90,1,'2026-07-01',11,'MYR',12,12,75740490.00,'2026-07-06 02:38:02','2026-07-06 02:38:02'),(91,1,'2026-07-01',11,'AUD',6,6,502241099.00,'2026-07-06 02:38:02','2026-07-06 02:38:02'),(92,1,'2026-07-01',11,'JPY',6,6,29466541.00,'2026-07-06 02:38:02','2026-07-06 02:38:02'),(93,1,'2026-07-01',11,'EUR',3,3,87977464.00,'2026-07-06 02:38:02','2026-07-06 02:38:02'),(94,1,'2026-07-01',11,'HKD',3,3,2735682.00,'2026-07-06 02:38:02','2026-07-06 02:38:02'),(95,1,'2026-07-01',11,'CNY',1,1,1900000.00,'2026-07-06 02:38:02','2026-07-06 02:38:02'),(96,1,'2026-07-01',11,'GBP',1,1,23801000.00,'2026-07-06 02:38:02','2026-07-06 02:38:02'),(97,1,'2026-07-01',11,'KRW',1,1,1000000.00,'2026-07-06 02:38:02','2026-07-06 02:38:02'),(98,1,'2026-07-01',11,'SAR',1,1,100000.00,'2026-07-06 02:38:02','2026-07-06 02:38:02'),(99,1,'2026-07-01',12,'USD',25,25,259075796.00,'2026-07-06 02:38:02','2026-07-06 02:38:02'),(100,1,'2026-07-01',12,'SGD',7,7,90597536.00,'2026-07-06 02:38:02','2026-07-06 02:38:02'),(101,1,'2026-07-01',12,'JPY',6,6,36124644.00,'2026-07-06 02:38:02','2026-07-06 02:38:02'),(102,1,'2026-07-01',12,'AUD',3,3,118985767.00,'2026-07-06 02:38:02','2026-07-06 02:38:02'),(103,1,'2026-07-01',12,'CNY',3,3,148144100.00,'2026-07-06 02:38:02','2026-07-06 02:38:02'),(104,1,'2026-07-01',12,'MYR',3,3,12303396.00,'2026-07-06 02:38:02','2026-07-06 02:38:02'),(105,1,'2026-07-01',12,'EUR',2,2,5043254.00,'2026-07-06 02:38:02','2026-07-06 02:38:02'),(106,1,'2026-07-01',12,'HKD',2,2,1087000.00,'2026-07-06 02:38:02','2026-07-06 02:38:02'),(107,1,'2026-07-01',12,'KRW',2,2,1536600.00,'2026-07-06 02:38:02','2026-07-06 02:38:02'),(108,1,'2026-07-01',12,'GBP',1,1,41710880.00,'2026-07-06 02:38:02','2026-07-06 02:38:02'),(109,1,'2026-07-01',12,'THB',1,1,810330.00,'2026-07-06 02:38:02','2026-07-06 02:38:02'),(110,1,'2026-07-01',13,'USD',28,28,352900514.00,'2026-07-06 02:38:02','2026-07-06 02:38:02'),(111,1,'2026-07-01',13,'SGD',11,11,47659058.00,'2026-07-06 02:38:02','2026-07-06 02:38:02'),(112,1,'2026-07-01',13,'JPY',8,8,318156089.00,'2026-07-06 02:38:02','2026-07-06 02:38:02'),(113,1,'2026-07-01',13,'CNY',5,5,102749000.00,'2026-07-06 02:38:02','2026-07-06 02:38:02'),(114,1,'2026-07-01',13,'EUR',5,5,6629948.00,'2026-07-06 02:38:02','2026-07-06 02:38:02'),(115,1,'2026-07-01',13,'AUD',4,4,149596984.00,'2026-07-06 02:38:02','2026-07-06 02:38:02'),(116,1,'2026-07-01',13,'SAR',4,4,17499700.00,'2026-07-06 02:38:02','2026-07-06 02:38:02'),(117,1,'2026-07-01',13,'MYR',3,3,18901788.00,'2026-07-06 02:38:02','2026-07-06 02:38:02'),(118,1,'2026-07-01',13,'HKD',1,1,11455000.00,'2026-07-06 02:38:02','2026-07-06 02:38:02'),(119,1,'2026-07-01',13,'KRW',1,1,1000000.00,'2026-07-06 02:38:02','2026-07-06 02:38:02'),(120,1,'2026-07-01',14,'USD',26,26,207386260.00,'2026-07-06 02:38:02','2026-07-06 02:38:02'),(121,1,'2026-07-01',14,'SGD',9,9,48884109.00,'2026-07-06 02:38:02','2026-07-06 02:38:02'),(122,1,'2026-07-01',14,'JPY',7,7,52309225.00,'2026-07-06 02:38:02','2026-07-06 02:38:02'),(123,1,'2026-07-01',14,'AUD',6,6,253068208.00,'2026-07-06 02:38:02','2026-07-06 02:38:02'),(124,1,'2026-07-01',14,'EUR',6,6,16784695.00,'2026-07-06 02:38:02','2026-07-06 02:38:02'),(125,1,'2026-07-01',14,'MYR',5,5,31922134.00,'2026-07-06 02:38:02','2026-07-06 02:38:02'),(126,1,'2026-07-01',14,'CNY',3,3,2685490.00,'2026-07-06 02:38:02','2026-07-06 02:38:02'),(127,1,'2026-07-01',14,'GBP',2,2,28241032.00,'2026-07-06 02:38:02','2026-07-06 02:38:02'),(128,1,'2026-07-01',14,'KRW',2,2,2086400.00,'2026-07-06 02:38:02','2026-07-06 02:38:02'),(129,1,'2026-07-01',14,'HKD',1,1,435480.00,'2026-07-06 02:38:02','2026-07-06 02:38:02'),(130,1,'2026-07-01',14,'SAR',1,1,14355000.00,'2026-07-06 02:38:02','2026-07-06 02:38:02'),(131,1,'2026-07-01',15,'USD',20,20,247025832.00,'2026-07-06 02:38:02','2026-07-06 02:38:02'),(132,1,'2026-07-01',15,'EUR',10,10,51250531.00,'2026-07-06 02:38:02','2026-07-06 02:38:02'),(133,1,'2026-07-01',15,'MYR',10,10,116683341.00,'2026-07-06 02:38:02','2026-07-06 02:38:02'),(134,1,'2026-07-01',15,'JPY',6,6,10074800.00,'2026-07-06 02:38:02','2026-07-06 02:38:02'),(135,1,'2026-07-01',15,'SGD',6,6,3632127.00,'2026-07-06 02:38:02','2026-07-06 02:38:02'),(136,1,'2026-07-01',15,'AUD',2,2,45010499.00,'2026-07-06 02:38:02','2026-07-06 02:38:02'),(137,1,'2026-07-01',15,'SAR',2,2,1670000.00,'2026-07-06 02:38:02','2026-07-06 02:38:02'),(138,1,'2026-07-01',15,'CNY',1,1,1061200.00,'2026-07-06 02:38:02','2026-07-06 02:38:02'),(139,1,'2026-07-01',15,'GBP',1,1,6730000.00,'2026-07-06 02:38:02','2026-07-06 02:38:02'),(140,1,'2026-07-01',15,'HKD',1,1,629708.00,'2026-07-06 02:38:02','2026-07-06 02:38:02'),(141,1,'2026-07-01',15,'KRW',1,1,2000000.00,'2026-07-06 02:38:02','2026-07-06 02:38:02'),(142,1,'2026-07-01',16,'USD',14,14,81021581.00,'2026-07-06 02:38:02','2026-07-06 02:38:02'),(143,1,'2026-07-01',16,'JPY',9,9,29317553.00,'2026-07-06 02:38:02','2026-07-06 02:38:02'),(144,1,'2026-07-01',16,'GBP',5,5,2571580.00,'2026-07-06 02:38:02','2026-07-06 02:38:02'),(145,1,'2026-07-01',16,'AUD',4,4,24331093.00,'2026-07-06 02:38:02','2026-07-06 02:38:02'),(146,1,'2026-07-01',16,'EUR',4,4,24320848.00,'2026-07-06 02:38:02','2026-07-06 02:38:02'),(147,1,'2026-07-01',16,'CNY',3,3,1162950.00,'2026-07-06 02:38:02','2026-07-06 02:38:02'),(148,1,'2026-07-01',16,'SGD',3,3,55194973.00,'2026-07-06 02:38:03','2026-07-06 02:38:03'),(149,1,'2026-07-01',16,'KRW',2,2,15593500.00,'2026-07-06 02:38:03','2026-07-06 02:38:03'),(150,1,'2026-07-01',16,'SAR',2,2,1079325.00,'2026-07-06 02:38:03','2026-07-06 02:38:03'),(151,1,'2026-07-01',17,'USD',21,21,189240075.00,'2026-07-06 02:38:03','2026-07-06 02:38:03'),(152,1,'2026-07-01',17,'JPY',12,12,27880834.00,'2026-07-06 02:38:03','2026-07-06 02:38:03'),(153,1,'2026-07-01',17,'SGD',8,8,121824704.00,'2026-07-06 02:38:03','2026-07-06 02:38:03'),(154,1,'2026-07-01',17,'MYR',7,7,20432139.00,'2026-07-06 02:38:03','2026-07-06 02:38:03'),(155,1,'2026-07-01',17,'AUD',6,6,1034376.00,'2026-07-06 02:38:03','2026-07-06 02:38:03'),(156,1,'2026-07-01',17,'EUR',5,5,5642754.00,'2026-07-06 02:38:03','2026-07-06 02:38:03'),(157,1,'2026-07-01',17,'HKD',3,3,6765476.00,'2026-07-06 02:38:03','2026-07-06 02:38:03'),(158,1,'2026-07-01',17,'SAR',3,3,4720000.00,'2026-07-06 02:38:03','2026-07-06 02:38:03'),(159,1,'2026-07-01',17,'CNY',2,2,520000.00,'2026-07-06 02:38:03','2026-07-06 02:38:03'),(160,1,'2026-07-01',17,'THB',2,2,225872.00,'2026-07-06 02:38:03','2026-07-06 02:38:03'),(161,1,'2026-07-01',17,'GBP',1,1,190760.00,'2026-07-06 02:38:03','2026-07-06 02:38:03'),(162,1,'2026-07-01',17,'KRW',1,1,20000.00,'2026-07-06 02:38:03','2026-07-06 02:38:03'),(163,1,'2026-07-01',18,'USD',18,18,21524730.00,'2026-07-06 02:38:03','2026-07-06 02:38:03'),(164,1,'2026-07-01',18,'JPY',6,6,2262256.00,'2026-07-06 02:38:03','2026-07-06 02:38:03'),(165,1,'2026-07-01',18,'MYR',6,6,13006992.00,'2026-07-06 02:38:03','2026-07-06 02:38:03'),(166,1,'2026-07-01',18,'EUR',5,5,2514431.00,'2026-07-06 02:38:03','2026-07-06 02:38:03'),(167,1,'2026-07-01',18,'SGD',5,5,128078064.00,'2026-07-06 02:38:03','2026-07-06 02:38:03'),(168,1,'2026-07-01',18,'CNY',2,2,795000.00,'2026-07-06 02:38:03','2026-07-06 02:38:03'),(169,1,'2026-07-01',18,'GBP',2,2,583000.00,'2026-07-06 02:38:03','2026-07-06 02:38:03'),(170,1,'2026-07-01',18,'KRW',2,2,683600.00,'2026-07-06 02:38:03','2026-07-06 02:38:03'),(171,1,'2026-07-01',18,'AUD',1,1,409992.00,'2026-07-06 02:38:03','2026-07-06 02:38:03'),(172,1,'2026-07-01',18,'HKD',1,1,513632.00,'2026-07-06 02:38:03','2026-07-06 02:38:03'),(173,1,'2026-07-01',18,'SAR',1,1,100000.00,'2026-07-06 02:38:03','2026-07-06 02:38:03'),(174,1,'2026-07-01',19,'USD',19,19,13898750.00,'2026-07-06 02:38:03','2026-07-06 02:38:03'),(175,1,'2026-07-01',19,'SGD',8,8,16933216.00,'2026-07-06 02:38:03','2026-07-06 02:38:03'),(176,1,'2026-07-01',19,'MYR',7,7,70281190.00,'2026-07-06 02:38:03','2026-07-06 02:38:03'),(177,1,'2026-07-01',19,'JPY',5,5,2730744.00,'2026-07-06 02:38:03','2026-07-06 02:38:03'),(178,1,'2026-07-01',19,'CNY',4,4,69970001.00,'2026-07-06 02:38:03','2026-07-06 02:38:03'),(179,1,'2026-07-01',19,'SAR',4,4,6113476.00,'2026-07-06 02:38:03','2026-07-06 02:38:03'),(180,1,'2026-07-01',19,'EUR',2,2,807485.00,'2026-07-06 02:38:03','2026-07-06 02:38:03'),(181,1,'2026-07-01',19,'AUD',1,1,18673272.00,'2026-07-06 02:38:03','2026-07-06 02:38:03'),(182,1,'2026-07-01',19,'GBP',1,1,21293584.00,'2026-07-06 02:38:03','2026-07-06 02:38:03'),(183,1,'2026-07-01',20,'USD',22,22,147320832.00,'2026-07-06 02:38:03','2026-07-06 02:38:03'),(184,1,'2026-07-01',20,'MYR',9,9,14737592.00,'2026-07-06 02:38:03','2026-07-06 02:38:03'),(185,1,'2026-07-01',20,'EUR',5,5,26922332.00,'2026-07-06 02:38:03','2026-07-06 02:38:03'),(186,1,'2026-07-01',20,'JPY',5,5,16444888.00,'2026-07-06 02:38:03','2026-07-06 02:38:03'),(187,1,'2026-07-01',20,'SGD',5,5,15697655.00,'2026-07-06 02:38:03','2026-07-06 02:38:03'),(188,1,'2026-07-01',20,'CNY',4,4,20783500.00,'2026-07-06 02:38:03','2026-07-06 02:38:03'),(189,1,'2026-07-01',20,'GBP',2,2,35839035.00,'2026-07-06 02:38:03','2026-07-06 02:38:03'),(190,1,'2026-07-01',20,'SAR',2,2,5650000.00,'2026-07-06 02:38:03','2026-07-06 02:38:03'),(191,1,'2026-07-01',20,'AUD',1,1,4348400.00,'2026-07-06 02:38:03','2026-07-06 02:38:03'),(192,1,'2026-07-01',20,'KRW',1,1,1813500.00,'2026-07-06 02:38:03','2026-07-06 02:38:03'),(193,1,'2026-07-01',21,'USD',12,12,185156456.00,'2026-07-06 02:38:03','2026-07-06 02:38:03'),(194,1,'2026-07-01',21,'MYR',7,7,14668685.00,'2026-07-06 02:38:03','2026-07-06 02:38:03'),(195,1,'2026-07-01',21,'EUR',6,6,4211497.00,'2026-07-06 02:38:03','2026-07-06 02:38:03'),(196,1,'2026-07-01',21,'SGD',4,4,511104.00,'2026-07-06 02:38:03','2026-07-06 02:38:03'),(197,1,'2026-07-01',21,'GBP',3,3,143070.00,'2026-07-06 02:38:03','2026-07-06 02:38:03'),(198,1,'2026-07-01',21,'CNY',2,2,765000.00,'2026-07-06 02:38:03','2026-07-06 02:38:03'),(199,1,'2026-07-01',21,'SAR',2,2,88136.00,'2026-07-06 02:38:03','2026-07-06 02:38:03'),(200,1,'2026-07-01',21,'AUD',1,1,14946072.00,'2026-07-06 02:38:03','2026-07-06 02:38:03'),(201,1,'2026-07-01',21,'HKD',1,1,1091310.00,'2026-07-06 02:38:03','2026-07-06 02:38:03'),(202,1,'2026-07-01',21,'JPY',1,1,98800.00,'2026-07-06 02:38:03','2026-07-06 02:38:03'),(203,1,'2026-07-01',22,'USD',11,11,28045328.00,'2026-07-06 02:38:03','2026-07-06 02:38:03'),(204,1,'2026-07-01',22,'SGD',9,9,8889032.00,'2026-07-06 02:38:03','2026-07-06 02:38:03'),(205,1,'2026-07-01',22,'CNY',3,3,729225.00,'2026-07-06 02:38:03','2026-07-06 02:38:03'),(206,1,'2026-07-01',22,'JPY',3,3,7632340.00,'2026-07-06 02:38:03','2026-07-06 02:38:03'),(207,1,'2026-07-01',22,'EUR',2,2,4673772.00,'2026-07-06 02:38:03','2026-07-06 02:38:03'),(208,1,'2026-07-01',22,'MYR',2,2,31400190.00,'2026-07-06 02:38:03','2026-07-06 02:38:03'),(209,1,'2026-07-01',22,'SAR',2,2,568830.00,'2026-07-06 02:38:03','2026-07-06 02:38:03'),(210,1,'2026-07-01',22,'GBP',1,1,10921010.00,'2026-07-06 02:38:03','2026-07-06 02:38:03'),(211,1,'2026-07-01',23,'USD',4,4,100463534.00,'2026-07-06 02:38:03','2026-07-06 02:38:03'),(212,1,'2026-07-01',23,'CNY',3,3,2530000.00,'2026-07-06 02:38:03','2026-07-06 02:38:03'),(213,1,'2026-07-01',23,'EUR',3,3,4300000.00,'2026-07-06 02:38:03','2026-07-06 02:38:03'),(214,1,'2026-07-01',23,'JPY',2,2,5806521.00,'2026-07-06 02:38:03','2026-07-06 02:38:03'),(215,1,'2026-07-01',23,'KRW',2,2,5362700.00,'2026-07-06 02:38:03','2026-07-06 02:38:03'),(216,1,'2026-07-01',23,'SAR',2,2,2550000.00,'2026-07-06 02:38:03','2026-07-06 02:38:03'),(217,1,'2026-07-01',23,'THB',2,2,1146820.00,'2026-07-06 02:38:03','2026-07-06 02:38:03'),(218,1,'2026-07-01',23,'GBP',1,1,50000000.00,'2026-07-06 02:38:03','2026-07-06 02:38:03'),(219,1,'2026-07-02',0,'SGD',6,6,7405259.00,'2026-07-06 02:38:03','2026-07-06 02:38:03'),(220,1,'2026-07-02',0,'USD',5,5,84612894.00,'2026-07-06 02:38:03','2026-07-06 02:38:03'),(221,1,'2026-07-02',0,'CNY',3,3,550000.00,'2026-07-06 02:38:03','2026-07-06 02:38:03'),(222,1,'2026-07-02',0,'EUR',1,1,1000000.00,'2026-07-06 02:38:03','2026-07-06 02:38:03'),(223,1,'2026-07-02',0,'MYR',1,1,92715.00,'2026-07-06 02:38:03','2026-07-06 02:38:03'),(224,1,'2026-07-02',1,'JPY',2,2,1188670.00,'2026-07-06 02:38:03','2026-07-06 02:38:03'),(225,1,'2026-07-02',1,'USD',2,2,1471460.00,'2026-07-06 02:38:03','2026-07-06 02:38:03'),(226,1,'2026-07-02',2,'SGD',2,2,69440.00,'2026-07-06 02:38:03','2026-07-06 02:38:03'),(227,1,'2026-07-02',2,'USD',2,2,30449750.00,'2026-07-06 02:38:03','2026-07-06 02:38:03'),(228,1,'2026-07-02',2,'AUD',1,1,47087.00,'2026-07-06 02:38:03','2026-07-06 02:38:03'),(229,1,'2026-07-02',2,'CNY',1,1,13250000.00,'2026-07-06 02:38:03','2026-07-06 02:38:03'),(230,1,'2026-07-02',2,'EUR',1,1,4099800.00,'2026-07-06 02:38:03','2026-07-06 02:38:03'),(231,1,'2026-07-02',2,'GBP',1,1,14378535.00,'2026-07-06 02:38:03','2026-07-06 02:38:03'),(232,1,'2026-07-02',3,'USD',3,3,1074820.00,'2026-07-06 02:38:03','2026-07-06 02:38:03'),(233,1,'2026-07-02',3,'EUR',2,2,351000.00,'2026-07-06 02:38:03','2026-07-06 02:38:03'),(234,1,'2026-07-02',3,'SGD',1,1,2083200.00,'2026-07-06 02:38:03','2026-07-06 02:38:03'),(235,1,'2026-07-02',4,'EUR',4,4,22938381.00,'2026-07-06 02:38:03','2026-07-06 02:38:03'),(236,1,'2026-07-02',4,'USD',4,4,152402972.00,'2026-07-06 02:38:03','2026-07-06 02:38:03'),(237,1,'2026-07-02',4,'MYR',3,3,5931500.00,'2026-07-06 02:38:03','2026-07-06 02:38:03'),(238,1,'2026-07-02',4,'JPY',2,2,5640821.00,'2026-07-06 02:38:03','2026-07-06 02:38:03'),(239,1,'2026-07-02',4,'SAR',2,2,1158000.00,'2026-07-06 02:38:03','2026-07-06 02:38:03'),(240,1,'2026-07-02',4,'SGD',1,1,874944.00,'2026-07-06 02:38:03','2026-07-06 02:38:03'),(241,1,'2026-07-02',5,'USD',9,9,186386700.00,'2026-07-06 02:38:03','2026-07-06 02:38:03'),(242,1,'2026-07-02',5,'JPY',3,3,1605539.00,'2026-07-06 02:38:03','2026-07-06 02:38:03'),(243,1,'2026-07-02',5,'SGD',3,3,1424632.00,'2026-07-06 02:38:03','2026-07-06 02:38:03'),(244,1,'2026-07-02',5,'EUR',2,2,2152395.00,'2026-07-06 02:38:03','2026-07-06 02:38:03'),(245,1,'2026-07-02',5,'MYR',2,2,10050075.00,'2026-07-06 02:38:03','2026-07-06 02:38:03'),(246,1,'2026-07-02',5,'SAR',2,2,1113877.00,'2026-07-06 02:38:03','2026-07-06 02:38:03'),(247,1,'2026-07-02',5,'CNY',1,1,265000.00,'2026-07-06 02:38:03','2026-07-06 02:38:03'),(248,1,'2026-07-02',6,'USD',9,9,197510350.00,'2026-07-06 02:38:03','2026-07-06 02:38:03'),(249,1,'2026-07-02',6,'SAR',3,3,4526900.00,'2026-07-06 02:38:03','2026-07-06 02:38:03'),(250,1,'2026-07-02',6,'HKD',2,2,16503000.00,'2026-07-06 02:38:03','2026-07-06 02:38:03'),(251,1,'2026-07-02',6,'JPY',2,2,310000.00,'2026-07-06 02:38:03','2026-07-06 02:38:03'),(252,1,'2026-07-02',6,'AUD',1,1,1490880.00,'2026-07-06 02:38:03','2026-07-06 02:38:03'),(253,1,'2026-07-02',6,'EUR',1,1,5186247.00,'2026-07-06 02:38:03','2026-07-06 02:38:03'),(254,1,'2026-07-02',6,'MYR',1,1,2000000.00,'2026-07-06 02:38:03','2026-07-06 02:38:03'),(255,1,'2026-07-02',7,'USD',12,12,372241576.00,'2026-07-06 02:38:03','2026-07-06 02:38:03'),(256,1,'2026-07-02',7,'JPY',6,6,64025650.00,'2026-07-06 02:38:03','2026-07-06 02:38:03'),(257,1,'2026-07-02',7,'SGD',5,5,27479105.00,'2026-07-06 02:38:03','2026-07-06 02:38:03'),(258,1,'2026-07-02',7,'MYR',2,2,1101450.00,'2026-07-06 02:38:03','2026-07-06 02:38:03'),(259,1,'2026-07-02',7,'AUD',1,1,1862979.00,'2026-07-06 02:38:03','2026-07-06 02:38:03'),(260,1,'2026-07-02',7,'GBP',1,1,11922500.00,'2026-07-06 02:38:03','2026-07-06 02:38:03'),(261,1,'2026-07-02',7,'HKD',1,1,1206525.00,'2026-07-06 02:38:03','2026-07-06 02:38:03'),(262,1,'2026-07-02',8,'USD',24,24,710695839.00,'2026-07-06 02:38:03','2026-07-06 02:38:03'),(263,1,'2026-07-02',8,'SGD',8,8,30245015.00,'2026-07-06 02:38:03','2026-07-06 02:38:03'),(264,1,'2026-07-02',8,'MYR',6,6,165836743.00,'2026-07-06 02:38:03','2026-07-06 02:38:03'),(265,1,'2026-07-02',8,'AUD',4,4,18104389.00,'2026-07-06 02:38:03','2026-07-06 02:38:03'),(266,1,'2026-07-02',8,'GBP',2,2,12423500.00,'2026-07-06 02:38:03','2026-07-06 02:38:03'),(267,1,'2026-07-02',8,'JPY',2,2,11000000.00,'2026-07-06 02:38:03','2026-07-06 02:38:03'),(268,1,'2026-07-02',8,'KRW',2,2,52300000.00,'2026-07-06 02:38:03','2026-07-06 02:38:03'),(269,1,'2026-07-02',8,'CNY',1,1,5000000.00,'2026-07-06 02:38:03','2026-07-06 02:38:03'),(270,1,'2026-07-02',8,'SAR',1,1,150000.00,'2026-07-06 02:38:03','2026-07-06 02:38:03'),(271,1,'2026-07-02',9,'USD',21,21,415967623.00,'2026-07-06 02:38:03','2026-07-06 02:38:03'),(272,1,'2026-07-02',9,'SGD',11,11,44737871.00,'2026-07-06 02:38:03','2026-07-06 02:38:03'),(273,1,'2026-07-02',9,'EUR',5,5,10597390.00,'2026-07-06 02:38:03','2026-07-06 02:38:03'),(274,1,'2026-07-02',9,'MYR',5,5,194935631.00,'2026-07-06 02:38:03','2026-07-06 02:38:03'),(275,1,'2026-07-02',9,'JPY',4,4,5983335.00,'2026-07-06 02:38:03','2026-07-06 02:38:03'),(276,1,'2026-07-02',9,'AUD',2,2,212608808.00,'2026-07-06 02:38:03','2026-07-06 02:38:03'),(277,1,'2026-07-02',9,'HKD',1,1,1000000.00,'2026-07-06 02:38:03','2026-07-06 02:38:03'),(278,1,'2026-07-02',9,'KRW',1,1,118800.00,'2026-07-06 02:38:03','2026-07-06 02:38:03'),(279,1,'2026-07-02',9,'SAR',1,1,671020.00,'2026-07-06 02:38:03','2026-07-06 02:38:03'),(280,1,'2026-07-02',10,'USD',25,25,347967486.00,'2026-07-06 02:38:03','2026-07-06 02:38:03'),(281,1,'2026-07-02',10,'SGD',9,9,160712718.00,'2026-07-06 02:38:03','2026-07-06 02:38:03'),(282,1,'2026-07-02',10,'JPY',7,7,164794224.00,'2026-07-06 02:38:03','2026-07-06 02:38:03'),(283,1,'2026-07-02',10,'MYR',7,7,20385605.00,'2026-07-06 02:38:03','2026-07-06 02:38:03'),(284,1,'2026-07-02',10,'AUD',6,6,85636405.00,'2026-07-06 02:38:03','2026-07-06 02:38:03'),(285,1,'2026-07-02',10,'SAR',5,5,2618520.00,'2026-07-06 02:38:03','2026-07-06 02:38:03'),(286,1,'2026-07-02',10,'EUR',4,4,28821368.00,'2026-07-06 02:38:03','2026-07-06 02:38:03'),(287,1,'2026-07-02',10,'KRW',2,2,15250000.00,'2026-07-06 02:38:03','2026-07-06 02:38:03'),(288,1,'2026-07-02',10,'CNY',1,1,796800.00,'2026-07-06 02:38:03','2026-07-06 02:38:03'),(289,1,'2026-07-02',10,'GBP',1,1,717660.00,'2026-07-06 02:38:03','2026-07-06 02:38:03'),(290,1,'2026-07-02',11,'USD',20,20,186622891.00,'2026-07-06 02:38:03','2026-07-06 02:38:03'),(291,1,'2026-07-02',11,'MYR',8,8,142853117.00,'2026-07-06 02:38:03','2026-07-06 02:38:03'),(292,1,'2026-07-02',11,'SGD',6,6,19623388.00,'2026-07-06 02:38:03','2026-07-06 02:38:03'),(293,1,'2026-07-02',11,'JPY',5,5,10597680.00,'2026-07-06 02:38:03','2026-07-06 02:38:03'),(294,1,'2026-07-02',11,'SAR',5,5,12557483.00,'2026-07-06 02:38:03','2026-07-06 02:38:03'),(295,1,'2026-07-02',11,'EUR',3,3,1153420.00,'2026-07-06 02:38:03','2026-07-06 02:38:03'),(296,1,'2026-07-02',11,'CNY',2,2,36059200.00,'2026-07-06 02:38:03','2026-07-06 02:38:03'),(297,1,'2026-07-02',11,'AUD',1,1,12464281.00,'2026-07-06 02:38:03','2026-07-06 02:38:03'),(298,1,'2026-07-02',11,'GBP',1,1,84993184.00,'2026-07-06 02:38:03','2026-07-06 02:38:03'),(299,1,'2026-07-02',11,'HKD',1,1,872100.00,'2026-07-06 02:38:03','2026-07-06 02:38:03'),(300,1,'2026-07-02',12,'USD',19,19,91419717.00,'2026-07-06 02:38:03','2026-07-06 02:38:03'),(301,1,'2026-07-02',12,'MYR',11,11,73569904.00,'2026-07-06 02:38:03','2026-07-06 02:38:03'),(302,1,'2026-07-02',12,'SGD',9,9,150605687.00,'2026-07-06 02:38:03','2026-07-06 02:38:03'),(303,1,'2026-07-02',12,'JPY',8,8,7236802.00,'2026-07-06 02:38:03','2026-07-06 02:38:03'),(304,1,'2026-07-02',12,'EUR',6,6,62617628.00,'2026-07-06 02:38:03','2026-07-06 02:38:03'),(305,1,'2026-07-02',12,'SAR',6,6,3608406.00,'2026-07-06 02:38:03','2026-07-06 02:38:03'),(306,1,'2026-07-02',12,'CNY',4,4,26655906.00,'2026-07-06 02:38:03','2026-07-06 02:38:03'),(307,1,'2026-07-02',12,'HKD',3,3,3306200.00,'2026-07-06 02:38:03','2026-07-06 02:38:03'),(308,1,'2026-07-02',12,'GBP',1,1,11970000.00,'2026-07-06 02:38:03','2026-07-06 02:38:03'),(309,1,'2026-07-02',13,'USD',17,17,332679841.00,'2026-07-06 02:38:03','2026-07-06 02:38:03'),(310,1,'2026-07-02',13,'AUD',7,7,612810903.00,'2026-07-06 02:38:03','2026-07-06 02:38:03'),(311,1,'2026-07-02',13,'SGD',6,6,7612467.00,'2026-07-06 02:38:03','2026-07-06 02:38:03'),(312,1,'2026-07-02',13,'JPY',3,3,3610612.00,'2026-07-06 02:38:03','2026-07-06 02:38:03'),(313,1,'2026-07-02',13,'EUR',2,2,12414600.00,'2026-07-06 02:38:03','2026-07-06 02:38:03'),(314,1,'2026-07-02',13,'KRW',2,2,1255420.00,'2026-07-06 02:38:03','2026-07-06 02:38:03'),(315,1,'2026-07-02',13,'MYR',2,2,49970745.00,'2026-07-06 02:38:03','2026-07-06 02:38:03'),(316,1,'2026-07-02',13,'THB',2,2,8500000.00,'2026-07-06 02:38:03','2026-07-06 02:38:03'),(317,1,'2026-07-02',13,'CNY',1,1,106240000.00,'2026-07-06 02:38:03','2026-07-06 02:38:03'),(318,1,'2026-07-02',13,'SAR',1,1,2158650.00,'2026-07-06 02:38:03','2026-07-06 02:38:03'),(319,1,'2026-07-02',14,'USD',16,16,414587634.00,'2026-07-06 02:38:03','2026-07-06 02:38:03'),(320,1,'2026-07-02',14,'JPY',11,11,45078913.00,'2026-07-06 02:38:03','2026-07-06 02:38:03'),(321,1,'2026-07-02',14,'MYR',7,7,16287027.00,'2026-07-06 02:38:03','2026-07-06 02:38:03'),(322,1,'2026-07-02',14,'SGD',6,6,27094937.00,'2026-07-06 02:38:03','2026-07-06 02:38:03'),(323,1,'2026-07-02',14,'AUD',4,4,36699250.00,'2026-07-06 02:38:03','2026-07-06 02:38:03'),(324,1,'2026-07-02',14,'EUR',3,3,2459810.00,'2026-07-06 02:38:03','2026-07-06 02:38:03'),(325,1,'2026-07-02',14,'SAR',3,3,1212000.00,'2026-07-06 02:38:03','2026-07-06 02:38:03'),(326,1,'2026-07-02',14,'GBP',2,2,56784642.00,'2026-07-06 02:38:03','2026-07-06 02:38:03'),(327,1,'2026-07-02',14,'HKD',2,2,128295555.00,'2026-07-06 02:38:03','2026-07-06 02:38:03'),(328,1,'2026-07-02',14,'KRW',1,1,5945000.00,'2026-07-06 02:38:03','2026-07-06 02:38:03'),(329,1,'2026-07-02',14,'THB',1,1,200000.00,'2026-07-06 02:38:03','2026-07-06 02:38:03'),(330,1,'2026-07-02',15,'USD',23,23,370758935.00,'2026-07-06 02:38:03','2026-07-06 02:38:03'),(331,1,'2026-07-02',15,'SGD',9,9,40644458.00,'2026-07-06 02:38:03','2026-07-06 02:38:03'),(332,1,'2026-07-02',15,'MYR',6,6,46888214.00,'2026-07-06 02:38:03','2026-07-06 02:38:03'),(333,1,'2026-07-02',15,'JPY',5,5,8162512.00,'2026-07-06 02:38:03','2026-07-06 02:38:03'),(334,1,'2026-07-02',15,'SAR',4,4,4500000.00,'2026-07-06 02:38:03','2026-07-06 02:38:03'),(335,1,'2026-07-02',15,'CNY',2,2,16100000.00,'2026-07-06 02:38:03','2026-07-06 02:38:03'),(336,1,'2026-07-02',15,'HKD',2,2,5343400.00,'2026-07-06 02:38:03','2026-07-06 02:38:03'),(337,1,'2026-07-02',15,'NZD',2,2,4227660.00,'2026-07-06 02:38:03','2026-07-06 02:38:03'),(338,1,'2026-07-02',15,'AUD',1,1,37365.00,'2026-07-06 02:38:03','2026-07-06 02:38:03'),(339,1,'2026-07-02',15,'EUR',1,1,10311500.00,'2026-07-06 02:38:03','2026-07-06 02:38:03'),(340,1,'2026-07-02',15,'GBP',1,1,15257832.00,'2026-07-06 02:38:03','2026-07-06 02:38:03'),(341,1,'2026-07-02',16,'USD',12,12,128798937.00,'2026-07-06 02:38:03','2026-07-06 02:38:03'),(342,1,'2026-07-02',16,'SGD',7,7,76300466.00,'2026-07-06 02:38:03','2026-07-06 02:38:03'),(343,1,'2026-07-02',16,'MYR',4,4,35892000.00,'2026-07-06 02:38:03','2026-07-06 02:38:03'),(344,1,'2026-07-02',16,'EUR',3,3,11861354.00,'2026-07-06 02:38:03','2026-07-06 02:38:03'),(345,1,'2026-07-02',16,'HKD',2,2,10138171.00,'2026-07-06 02:38:03','2026-07-06 02:38:03'),(346,1,'2026-07-02',16,'JPY',2,2,15714272.00,'2026-07-06 02:38:03','2026-07-06 02:38:03'),(347,1,'2026-07-02',16,'AUD',1,1,250000.00,'2026-07-06 02:38:03','2026-07-06 02:38:03'),(348,1,'2026-07-02',16,'GBP',1,1,8435700.00,'2026-07-06 02:38:03','2026-07-06 02:38:03'),(349,1,'2026-07-02',16,'SAR',1,1,480800.00,'2026-07-06 02:38:03','2026-07-06 02:38:03'),(350,1,'2026-07-02',16,'THB',1,1,10000.00,'2026-07-06 02:38:03','2026-07-06 02:38:03'),(351,1,'2026-07-02',17,'USD',10,10,41653220.00,'2026-07-06 02:38:03','2026-07-06 02:38:03'),(352,1,'2026-07-02',17,'SAR',6,6,49807220.00,'2026-07-06 02:38:03','2026-07-06 02:38:03'),(353,1,'2026-07-02',17,'SGD',6,6,16368064.00,'2026-07-06 02:38:03','2026-07-06 02:38:03'),(354,1,'2026-07-02',17,'EUR',4,4,28373356.00,'2026-07-06 02:38:03','2026-07-06 02:38:03'),(355,1,'2026-07-02',17,'JPY',4,4,7481920.00,'2026-07-06 02:38:03','2026-07-06 02:38:03'),(356,1,'2026-07-02',17,'AUD',2,2,82524294.00,'2026-07-06 02:38:03','2026-07-06 02:38:03'),(357,1,'2026-07-02',17,'CNY',2,2,2000000.00,'2026-07-06 02:38:03','2026-07-06 02:38:03'),(358,1,'2026-07-02',17,'MYR',2,2,1179330.00,'2026-07-06 02:38:03','2026-07-06 02:38:03'),(359,1,'2026-07-02',17,'GBP',1,1,200000.00,'2026-07-06 02:38:03','2026-07-06 02:38:03'),(360,1,'2026-07-02',17,'THB',1,1,619112.00,'2026-07-06 02:38:03','2026-07-06 02:38:03'),(361,1,'2026-07-02',18,'USD',12,12,76466943.00,'2026-07-06 02:38:03','2026-07-06 02:38:03'),(362,1,'2026-07-02',18,'JPY',6,6,4867344.00,'2026-07-06 02:38:03','2026-07-06 02:38:03'),(363,1,'2026-07-02',18,'SGD',5,5,2596345.00,'2026-07-06 02:38:03','2026-07-06 02:38:03'),(364,1,'2026-07-02',18,'CNY',4,4,13639680.00,'2026-07-06 02:38:03','2026-07-06 02:38:03'),(365,1,'2026-07-02',18,'EUR',3,3,915700.00,'2026-07-06 02:38:03','2026-07-06 02:38:03'),(366,1,'2026-07-02',18,'SAR',2,2,3962400.00,'2026-07-06 02:38:03','2026-07-06 02:38:03'),(367,1,'2026-07-02',18,'AUD',1,1,18747.00,'2026-07-06 02:38:03','2026-07-06 02:38:03'),(368,1,'2026-07-02',18,'THB',1,1,162924.00,'2026-07-06 02:38:03','2026-07-06 02:38:03'),(369,1,'2026-07-02',19,'USD',7,7,15149940.00,'2026-07-06 02:38:03','2026-07-06 02:38:03'),(370,1,'2026-07-02',19,'JPY',6,6,32416341.00,'2026-07-06 02:38:03','2026-07-06 02:38:03'),(371,1,'2026-07-02',19,'AUD',4,4,189169732.00,'2026-07-06 02:38:03','2026-07-06 02:38:03'),(372,1,'2026-07-02',19,'GBP',4,4,31040383.00,'2026-07-06 02:38:03','2026-07-06 02:38:03'),(373,1,'2026-07-02',19,'MYR',3,3,4093990.00,'2026-07-06 02:38:03','2026-07-06 02:38:03'),(374,1,'2026-07-02',19,'SGD',3,3,63772488.00,'2026-07-06 02:38:03','2026-07-06 02:38:03'),(375,1,'2026-07-02',19,'CNY',2,2,1666000.00,'2026-07-06 02:38:03','2026-07-06 02:38:03'),(376,1,'2026-07-02',19,'EUR',1,1,103140.00,'2026-07-06 02:38:03','2026-07-06 02:38:03'),(377,1,'2026-07-02',19,'HKD',1,1,1076000.00,'2026-07-06 02:38:03','2026-07-06 02:38:03'),(378,1,'2026-07-02',20,'USD',9,9,199253173.00,'2026-07-06 02:38:03','2026-07-06 02:38:03'),(379,1,'2026-07-02',20,'SGD',6,6,69530461.00,'2026-07-06 02:38:03','2026-07-06 02:38:03'),(380,1,'2026-07-02',20,'JPY',4,4,11079945.00,'2026-07-06 02:38:03','2026-07-06 02:38:03'),(381,1,'2026-07-02',20,'AUD',3,3,645203.00,'2026-07-06 02:38:03','2026-07-06 02:38:03'),(382,1,'2026-07-02',20,'MYR',3,3,4611101.00,'2026-07-06 02:38:03','2026-07-06 02:38:03'),(383,1,'2026-07-02',20,'EUR',2,2,1134540.00,'2026-07-06 02:38:03','2026-07-06 02:38:03'),(384,1,'2026-07-02',20,'GBP',1,1,7236600.00,'2026-07-06 02:38:03','2026-07-06 02:38:03'),(385,1,'2026-07-02',20,'HKD',1,1,748377.00,'2026-07-06 02:38:03','2026-07-06 02:38:03'),(386,1,'2026-07-02',20,'KRW',1,1,500000.00,'2026-07-06 02:38:03','2026-07-06 02:38:03'),(387,1,'2026-07-02',20,'SAR',1,1,500000.00,'2026-07-06 02:38:03','2026-07-06 02:38:03'),(388,1,'2026-07-02',21,'USD',18,18,369988371.00,'2026-07-06 02:38:03','2026-07-06 02:38:03'),(389,1,'2026-07-02',21,'SGD',8,8,10057031.00,'2026-07-06 02:38:03','2026-07-06 02:38:03'),(390,1,'2026-07-02',21,'MYR',6,6,4995625.00,'2026-07-06 02:38:03','2026-07-06 02:38:03'),(391,1,'2026-07-02',21,'EUR',5,5,9551017.00,'2026-07-06 02:38:03','2026-07-06 02:38:03'),(392,1,'2026-07-02',21,'AUD',2,2,3107006.00,'2026-07-06 02:38:03','2026-07-06 02:38:03'),(393,1,'2026-07-02',21,'JPY',2,2,5766000.00,'2026-07-06 02:38:03','2026-07-06 02:38:03'),(394,1,'2026-07-02',21,'SAR',2,2,1500575.00,'2026-07-06 02:38:03','2026-07-06 02:38:03'),(395,1,'2026-07-02',21,'CNY',1,1,26640000.00,'2026-07-06 02:38:03','2026-07-06 02:38:03'),(396,1,'2026-07-02',21,'GBP',1,1,24194366.00,'2026-07-06 02:38:03','2026-07-06 02:38:03'),(397,1,'2026-07-02',21,'KRW',1,1,500000.00,'2026-07-06 02:38:03','2026-07-06 02:38:03'),(398,1,'2026-07-02',21,'THB',1,1,499998.00,'2026-07-06 02:38:03','2026-07-06 02:38:03'),(399,1,'2026-07-02',22,'USD',5,5,44259281.00,'2026-07-06 02:38:03','2026-07-06 02:38:03'),(400,1,'2026-07-02',22,'MYR',4,4,10629660.00,'2026-07-06 02:38:03','2026-07-06 02:38:03'),(401,1,'2026-07-02',22,'SGD',3,3,55687400.00,'2026-07-06 02:38:03','2026-07-06 02:38:03'),(402,1,'2026-07-02',22,'EUR',1,1,525000.00,'2026-07-06 02:38:03','2026-07-06 02:38:03'),(403,1,'2026-07-02',22,'GBP',1,1,12061000.00,'2026-07-06 02:38:03','2026-07-06 02:38:03'),(404,1,'2026-07-02',22,'JPY',1,1,4567380.00,'2026-07-06 02:38:03','2026-07-06 02:38:03'),(405,1,'2026-07-02',22,'SAR',1,1,14436.00,'2026-07-06 02:38:03','2026-07-06 02:38:03'),(406,1,'2026-07-02',22,'THB',1,1,1520624.00,'2026-07-06 02:38:03','2026-07-06 02:38:03'),(407,1,'2026-07-02',23,'SGD',2,2,2320016.00,'2026-07-06 02:38:03','2026-07-06 02:38:03'),(408,1,'2026-07-02',23,'EUR',1,1,2062800.00,'2026-07-06 02:38:03','2026-07-06 02:38:03'),(409,1,'2026-07-02',23,'JPY',1,1,3400000.00,'2026-07-06 02:38:03','2026-07-06 02:38:03'),(410,1,'2026-07-02',23,'SAR',1,1,5000000.00,'2026-07-06 02:38:03','2026-07-06 02:38:03'),(411,1,'2026-07-02',23,'USD',1,1,9030000.00,'2026-07-06 02:38:03','2026-07-06 02:38:03'),(412,1,'2026-07-03',0,'EUR',3,3,60398784.00,'2026-07-06 02:38:03','2026-07-06 02:38:03'),(413,1,'2026-07-03',0,'SAR',3,3,12751800.00,'2026-07-06 02:38:03','2026-07-06 02:38:03'),(414,1,'2026-07-03',0,'AUD',1,1,177509088.00,'2026-07-06 02:38:03','2026-07-06 02:38:03'),(415,1,'2026-07-03',0,'MYR',1,1,3037657.00,'2026-07-06 02:38:03','2026-07-06 02:38:03'),(416,1,'2026-07-03',0,'USD',1,1,36120.00,'2026-07-06 02:38:03','2026-07-06 02:38:03'),(417,1,'2026-07-03',1,'USD',3,3,14292740.00,'2026-07-06 02:38:03','2026-07-06 02:38:03'),(418,1,'2026-07-03',1,'CNY',1,1,50000.00,'2026-07-06 02:38:03','2026-07-06 02:38:03'),(419,1,'2026-07-03',1,'GBP',1,1,6030500.00,'2026-07-06 02:38:03','2026-07-06 02:38:03'),(420,1,'2026-07-03',1,'MYR',1,1,108544256.00,'2026-07-06 02:38:03','2026-07-06 02:38:03'),(421,1,'2026-07-03',1,'SAR',1,1,4999671.00,'2026-07-06 02:38:03','2026-07-06 02:38:03'),(422,1,'2026-07-03',2,'SGD',2,2,10526200.00,'2026-07-06 02:38:03','2026-07-06 02:38:03'),(423,1,'2026-07-03',2,'SAR',1,1,3500000.00,'2026-07-06 02:38:03','2026-07-06 02:38:03'),(424,1,'2026-07-03',2,'USD',1,1,50000.00,'2026-07-06 02:38:03','2026-07-06 02:38:03'),(425,1,'2026-07-03',3,'USD',3,3,190300.00,'2026-07-06 02:38:03','2026-07-06 02:38:03'),(426,1,'2026-07-03',3,'CNY',2,2,905760.00,'2026-07-06 02:38:03','2026-07-06 02:38:03'),(427,1,'2026-07-03',3,'AUD',1,1,2480853.00,'2026-07-06 02:38:03','2026-07-06 02:38:03'),(428,1,'2026-07-03',3,'EUR',1,1,995000.00,'2026-07-06 02:38:03','2026-07-06 02:38:03'),(429,1,'2026-07-03',3,'MYR',1,1,1500000.00,'2026-07-06 02:38:03','2026-07-06 02:38:03'),(430,1,'2026-07-03',4,'JPY',4,4,2435625.00,'2026-07-06 02:38:03','2026-07-06 02:38:03'),(431,1,'2026-07-03',4,'USD',3,3,9672480.00,'2026-07-06 02:38:03','2026-07-06 02:38:03'),(432,1,'2026-07-03',4,'EUR',1,1,309420.00,'2026-07-06 02:38:03','2026-07-06 02:38:03'),(433,1,'2026-07-03',5,'SGD',3,3,8551608.00,'2026-07-06 02:38:03','2026-07-06 02:38:03'),(434,1,'2026-07-03',5,'USD',2,2,61440120.00,'2026-07-06 02:38:03','2026-07-06 02:38:03'),(435,1,'2026-07-03',5,'GBP',1,1,6030500.00,'2026-07-06 02:38:03','2026-07-06 02:38:03'),(436,1,'2026-07-03',5,'JPY',1,1,5616.00,'2026-07-06 02:38:03','2026-07-06 02:38:03'),(437,1,'2026-07-03',6,'USD',15,15,1268151952.00,'2026-07-06 02:38:03','2026-07-06 02:38:03'),(438,1,'2026-07-03',6,'SGD',5,5,5548496.00,'2026-07-06 02:38:03','2026-07-06 02:38:03'),(439,1,'2026-07-03',6,'AUD',3,3,175346934.00,'2026-07-06 02:38:03','2026-07-06 02:38:03'),(440,1,'2026-07-03',6,'MYR',3,3,8408785.00,'2026-07-06 02:38:03','2026-07-06 02:38:03'),(441,1,'2026-07-03',6,'GBP',2,2,2519686.00,'2026-07-06 02:38:03','2026-07-06 02:38:03'),(442,1,'2026-07-03',6,'CNY',1,1,355000.00,'2026-07-06 02:38:03','2026-07-06 02:38:03'),(443,1,'2026-07-03',6,'EUR',1,1,82512.00,'2026-07-06 02:38:03','2026-07-06 02:38:03'),(444,1,'2026-07-03',6,'JPY',1,1,1000000.00,'2026-07-06 02:38:03','2026-07-06 02:38:03'),(445,1,'2026-07-03',7,'USD',11,11,371837639.00,'2026-07-06 02:38:03','2026-07-06 02:38:03'),(446,1,'2026-07-03',7,'EUR',6,6,44570061.00,'2026-07-06 02:38:03','2026-07-06 02:38:03'),(447,1,'2026-07-03',7,'SGD',5,5,3186576.00,'2026-07-06 02:38:03','2026-07-06 02:38:03'),(448,1,'2026-07-03',7,'MYR',4,4,27015873.00,'2026-07-06 02:38:03','2026-07-06 02:38:03'),(449,1,'2026-07-03',7,'JPY',3,3,1173920.00,'2026-07-06 02:38:03','2026-07-06 02:38:03'),(450,1,'2026-07-03',7,'AUD',2,2,150050992.00,'2026-07-06 02:38:03','2026-07-06 02:38:03'),(451,1,'2026-07-03',7,'CNY',1,1,479520.00,'2026-07-06 02:38:03','2026-07-06 02:38:03'),(452,1,'2026-07-03',7,'GBP',1,1,120610.00,'2026-07-06 02:38:03','2026-07-06 02:38:03'),(453,1,'2026-07-03',7,'HKD',1,1,115100.00,'2026-07-06 02:38:03','2026-07-06 02:38:03'),(454,1,'2026-07-03',8,'USD',13,13,209324820.00,'2026-07-06 02:38:03','2026-07-06 02:38:03'),(455,1,'2026-07-03',8,'SGD',8,8,24596498.00,'2026-07-06 02:38:03','2026-07-06 02:38:03'),(456,1,'2026-07-03',8,'MYR',6,6,20126803.00,'2026-07-06 02:38:03','2026-07-06 02:38:03'),(457,1,'2026-07-03',8,'JPY',4,4,18430416.00,'2026-07-06 02:38:03','2026-07-06 02:38:03'),(458,1,'2026-07-03',8,'AUD',3,3,26254984.00,'2026-07-06 02:38:03','2026-07-06 02:38:03'),(459,1,'2026-07-03',8,'EUR',2,2,50628000.00,'2026-07-06 02:38:03','2026-07-06 02:38:03'),(460,1,'2026-07-03',8,'KRW',2,2,26203670.00,'2026-07-06 02:38:03','2026-07-06 02:38:03'),(461,1,'2026-07-03',8,'SAR',2,2,2960400.00,'2026-07-06 02:38:03','2026-07-06 02:38:03'),(462,1,'2026-07-03',8,'CNY',1,1,300000.00,'2026-07-06 02:38:03','2026-07-06 02:38:03'),(463,1,'2026-07-03',8,'HKD',1,1,1208990.00,'2026-07-06 02:38:03','2026-07-06 02:38:03'),(464,1,'2026-07-03',9,'USD',25,25,177987391.00,'2026-07-06 02:38:03','2026-07-06 02:38:03'),(465,1,'2026-07-03',9,'SGD',8,8,155903181.00,'2026-07-06 02:38:03','2026-07-06 02:38:03'),(466,1,'2026-07-03',9,'MYR',5,5,21287284.00,'2026-07-06 02:38:03','2026-07-06 02:38:03'),(467,1,'2026-07-03',9,'AUD',4,4,64072304.00,'2026-07-06 02:38:03','2026-07-06 02:38:03'),(468,1,'2026-07-03',9,'EUR',4,4,3725000.00,'2026-07-06 02:38:03','2026-07-06 02:38:03'),(469,1,'2026-07-03',9,'SAR',4,4,17301310.00,'2026-07-06 02:38:03','2026-07-06 02:38:03'),(470,1,'2026-07-03',9,'THB',2,2,2040000.00,'2026-07-06 02:38:03','2026-07-06 02:38:03'),(471,1,'2026-07-03',9,'CNY',1,1,5306000.00,'2026-07-06 02:38:03','2026-07-06 02:38:03'),(472,1,'2026-07-03',9,'GBP',1,1,125000.00,'2026-07-06 02:38:03','2026-07-06 02:38:03'),(473,1,'2026-07-03',9,'HKD',1,1,2800000.00,'2026-07-06 02:38:03','2026-07-06 02:38:03'),(474,1,'2026-07-03',9,'JPY',1,1,1397125.00,'2026-07-06 02:38:03','2026-07-06 02:38:03'),(475,1,'2026-07-03',10,'USD',41,41,1143391539.00,'2026-07-06 02:38:03','2026-07-06 02:38:03'),(476,1,'2026-07-03',10,'SGD',12,12,77235801.00,'2026-07-06 02:38:03','2026-07-06 02:38:03'),(477,1,'2026-07-03',10,'MYR',9,9,12314140.00,'2026-07-06 02:38:03','2026-07-06 02:38:03'),(478,1,'2026-07-03',10,'AUD',5,5,168681956.00,'2026-07-06 02:38:03','2026-07-06 02:38:03'),(479,1,'2026-07-03',10,'SAR',4,4,6460000.00,'2026-07-06 02:38:03','2026-07-06 02:38:03'),(480,1,'2026-07-03',10,'THB',3,3,446208.00,'2026-07-06 02:38:03','2026-07-06 02:38:03'),(481,1,'2026-07-03',10,'EUR',2,2,21064000.00,'2026-07-06 02:38:03','2026-07-06 02:38:03'),(482,1,'2026-07-03',10,'JPY',2,2,13351300.00,'2026-07-06 02:38:03','2026-07-06 02:38:03'),(483,1,'2026-07-03',10,'CNY',1,1,350064.00,'2026-07-06 02:38:03','2026-07-06 02:38:03'),(484,1,'2026-07-03',10,'HKD',1,1,7000000.00,'2026-07-06 02:38:03','2026-07-06 02:38:03'),(485,1,'2026-07-03',10,'KRW',1,1,1031140.00,'2026-07-06 02:38:03','2026-07-06 02:38:03'),(486,1,'2026-07-03',11,'USD',35,35,458174899.00,'2026-07-06 02:38:03','2026-07-06 02:38:03'),(487,1,'2026-07-03',11,'MYR',13,13,83401443.00,'2026-07-06 02:38:03','2026-07-06 02:38:03'),(488,1,'2026-07-03',11,'SGD',11,11,187775857.00,'2026-07-06 02:38:03','2026-07-06 02:38:03'),(489,1,'2026-07-03',11,'CNY',6,6,252156000.00,'2026-07-06 02:38:03','2026-07-06 02:38:03'),(490,1,'2026-07-03',11,'SAR',5,5,4064320.00,'2026-07-06 02:38:04','2026-07-06 02:38:04'),(491,1,'2026-07-03',11,'AUD',4,4,255608904.00,'2026-07-06 02:38:04','2026-07-06 02:38:04'),(492,1,'2026-07-03',11,'HKD',4,4,2420520.00,'2026-07-06 02:38:04','2026-07-06 02:38:04'),(493,1,'2026-07-03',11,'JPY',4,4,6048725.00,'2026-07-06 02:38:04','2026-07-06 02:38:04'),(494,1,'2026-07-03',11,'EUR',3,3,13416100.00,'2026-07-06 02:38:04','2026-07-06 02:38:04'),(495,1,'2026-07-03',12,'USD',22,22,655024033.00,'2026-07-06 02:38:04','2026-07-06 02:38:04'),(496,1,'2026-07-03',12,'SGD',10,10,94239748.00,'2026-07-06 02:38:04','2026-07-06 02:38:04'),(497,1,'2026-07-03',12,'JPY',7,7,21067509.00,'2026-07-06 02:38:04','2026-07-06 02:38:04'),(498,1,'2026-07-03',12,'SAR',6,6,19635668.00,'2026-07-06 02:38:04','2026-07-06 02:38:04'),(499,1,'2026-07-03',12,'MYR',4,4,10432101.00,'2026-07-06 02:38:04','2026-07-06 02:38:04'),(500,1,'2026-07-03',12,'AUD',3,3,179900270.00,'2026-07-06 02:38:04','2026-07-06 02:38:04'),(501,1,'2026-07-03',12,'CNY',3,3,10793996.00,'2026-07-06 02:38:04','2026-07-06 02:38:04'),(502,1,'2026-07-03',12,'THB',3,3,1334376.00,'2026-07-06 02:38:04','2026-07-06 02:38:04'),(503,1,'2026-07-03',12,'EUR',1,1,34414244.00,'2026-07-06 02:38:04','2026-07-06 02:38:04'),(504,1,'2026-07-03',12,'GBP',1,1,2941792.00,'2026-07-06 02:38:04','2026-07-06 02:38:04'),(505,1,'2026-07-03',12,'HKD',1,1,261174.00,'2026-07-06 02:38:04','2026-07-06 02:38:04'),(506,1,'2026-07-03',13,'USD',21,21,186316530.00,'2026-07-06 02:38:04','2026-07-06 02:38:04'),(507,1,'2026-07-03',13,'SGD',12,12,146474547.00,'2026-07-06 02:38:04','2026-07-06 02:38:04'),(508,1,'2026-07-03',13,'CNY',3,3,8609000.00,'2026-07-06 02:38:04','2026-07-06 02:38:04'),(509,1,'2026-07-03',13,'EUR',3,3,1117805.00,'2026-07-06 02:38:04','2026-07-06 02:38:04'),(510,1,'2026-07-03',13,'JPY',3,3,9392100.00,'2026-07-06 02:38:04','2026-07-06 02:38:04'),(511,1,'2026-07-03',13,'MYR',3,3,16176500.00,'2026-07-06 02:38:04','2026-07-06 02:38:04'),(512,1,'2026-07-03',13,'SAR',3,3,5956400.00,'2026-07-06 02:38:04','2026-07-06 02:38:04'),(513,1,'2026-07-03',13,'AUD',2,2,69561192.00,'2026-07-06 02:38:04','2026-07-06 02:38:04'),(514,1,'2026-07-03',13,'HKD',2,2,944897.00,'2026-07-06 02:38:04','2026-07-06 02:38:04'),(515,1,'2026-07-03',13,'GBP',1,1,11419000.00,'2026-07-06 02:38:04','2026-07-06 02:38:04'),(516,1,'2026-07-03',13,'THB',1,1,5000000.00,'2026-07-06 02:38:04','2026-07-06 02:38:04'),(517,1,'2026-07-03',14,'USD',20,20,351246204.00,'2026-07-06 02:38:04','2026-07-06 02:38:04'),(518,1,'2026-07-03',14,'MYR',9,9,128425518.00,'2026-07-06 02:38:04','2026-07-06 02:38:04'),(519,1,'2026-07-03',14,'SGD',7,7,87865898.00,'2026-07-06 02:38:04','2026-07-06 02:38:04'),(520,1,'2026-07-03',14,'CNY',4,4,18726236.00,'2026-07-06 02:38:04','2026-07-06 02:38:04'),(521,1,'2026-07-03',14,'EUR',4,4,11159410.00,'2026-07-06 02:38:04','2026-07-06 02:38:04'),(522,1,'2026-07-03',14,'JPY',4,4,8415496.00,'2026-07-06 02:38:04','2026-07-06 02:38:04'),(523,1,'2026-07-03',14,'GBP',2,2,153725852.00,'2026-07-06 02:38:04','2026-07-06 02:38:04'),(524,1,'2026-07-03',14,'HKD',2,2,1168410.00,'2026-07-06 02:38:04','2026-07-06 02:38:04'),(525,1,'2026-07-03',15,'SGD',11,11,15178084.00,'2026-07-06 02:38:04','2026-07-06 02:38:04'),(526,1,'2026-07-03',15,'USD',10,10,86891860.00,'2026-07-06 02:38:04','2026-07-06 02:38:04'),(527,1,'2026-07-03',15,'JPY',7,7,117878026.00,'2026-07-06 02:38:04','2026-07-06 02:38:04'),(528,1,'2026-07-03',15,'MYR',6,6,21249604.00,'2026-07-06 02:38:04','2026-07-06 02:38:04'),(529,1,'2026-07-03',15,'AUD',4,4,18873793.00,'2026-07-06 02:38:04','2026-07-06 02:38:04'),(530,1,'2026-07-03',15,'CNY',4,4,442653.00,'2026-07-06 02:38:04','2026-07-06 02:38:04'),(531,1,'2026-07-03',15,'EUR',3,3,57795600.00,'2026-07-06 02:38:04','2026-07-06 02:38:04'),(532,1,'2026-07-03',15,'KRW',1,1,1000000.00,'2026-07-06 02:38:04','2026-07-06 02:38:04'),(533,1,'2026-07-03',15,'SAR',1,1,2495000.00,'2026-07-06 02:38:04','2026-07-06 02:38:04'),(534,1,'2026-07-03',15,'THB',1,1,10000000.00,'2026-07-06 02:38:04','2026-07-06 02:38:04'),(535,1,'2026-07-03',16,'SGD',17,17,209428728.00,'2026-07-06 02:38:04','2026-07-06 02:38:04'),(536,1,'2026-07-03',16,'USD',17,17,172591272.00,'2026-07-06 02:38:04','2026-07-06 02:38:04'),(537,1,'2026-07-03',16,'EUR',5,5,34044994.00,'2026-07-06 02:38:04','2026-07-06 02:38:04'),(538,1,'2026-07-03',16,'MYR',5,5,27513220.00,'2026-07-06 02:38:04','2026-07-06 02:38:04'),(539,1,'2026-07-03',16,'JPY',4,4,2017730.00,'2026-07-06 02:38:04','2026-07-06 02:38:04'),(540,1,'2026-07-03',16,'AUD',3,3,8595806.00,'2026-07-06 02:38:04','2026-07-06 02:38:04'),(541,1,'2026-07-03',16,'SAR',3,3,2203250.00,'2026-07-06 02:38:04','2026-07-06 02:38:04'),(542,1,'2026-07-03',16,'GBP',1,1,6082373.00,'2026-07-06 02:38:04','2026-07-06 02:38:04'),(543,1,'2026-07-03',16,'KRW',1,1,200000.00,'2026-07-06 02:38:04','2026-07-06 02:38:04'),(544,1,'2026-07-03',17,'USD',16,16,147473304.00,'2026-07-06 02:38:04','2026-07-06 02:38:04'),(545,1,'2026-07-03',17,'SGD',8,8,52517581.00,'2026-07-06 02:38:04','2026-07-06 02:38:04'),(546,1,'2026-07-03',17,'JPY',5,5,16830000.00,'2026-07-06 02:38:04','2026-07-06 02:38:04'),(547,1,'2026-07-03',17,'MYR',5,5,5307535.00,'2026-07-06 02:38:04','2026-07-06 02:38:04'),(548,1,'2026-07-03',17,'GBP',3,3,59346824.00,'2026-07-06 02:38:04','2026-07-06 02:38:04'),(549,1,'2026-07-03',17,'CNY',2,2,2921600.00,'2026-07-06 02:38:04','2026-07-06 02:38:04'),(550,1,'2026-07-03',17,'EUR',2,2,450000.00,'2026-07-06 02:38:04','2026-07-06 02:38:04'),(551,1,'2026-07-03',17,'AUD',1,1,50036.00,'2026-07-06 02:38:04','2026-07-06 02:38:04'),(552,1,'2026-07-03',17,'HKD',1,1,745617.00,'2026-07-06 02:38:04','2026-07-06 02:38:04'),(553,1,'2026-07-03',18,'SGD',11,11,12497930.00,'2026-07-06 02:38:04','2026-07-06 02:38:04'),(554,1,'2026-07-03',18,'USD',11,11,38571470.00,'2026-07-06 02:38:04','2026-07-06 02:38:04'),(555,1,'2026-07-03',18,'JPY',7,7,6342935.00,'2026-07-06 02:38:04','2026-07-06 02:38:04'),(556,1,'2026-07-03',18,'MYR',4,4,53983687.00,'2026-07-06 02:38:04','2026-07-06 02:38:04'),(557,1,'2026-07-03',18,'HKD',2,2,1361000.00,'2026-07-06 02:38:04','2026-07-06 02:38:04'),(558,1,'2026-07-03',18,'CNY',1,1,1000000.00,'2026-07-06 02:38:04','2026-07-06 02:38:04'),(559,1,'2026-07-03',18,'EUR',1,1,4180988.00,'2026-07-06 02:38:04','2026-07-06 02:38:04'),(560,1,'2026-07-03',18,'GBP',1,1,3436862.00,'2026-07-06 02:38:04','2026-07-06 02:38:04'),(561,1,'2026-07-03',18,'KRW',1,1,122900.00,'2026-07-06 02:38:04','2026-07-06 02:38:04'),(562,1,'2026-07-03',18,'SAR',1,1,100558.00,'2026-07-06 02:38:04','2026-07-06 02:38:04'),(563,1,'2026-07-03',18,'THB',1,1,163173.00,'2026-07-06 02:38:04','2026-07-06 02:38:04'),(564,1,'2026-07-03',19,'USD',19,19,66546768.00,'2026-07-06 02:38:04','2026-07-06 02:38:04'),(565,1,'2026-07-03',19,'SGD',6,6,5230828.00,'2026-07-06 02:38:04','2026-07-06 02:38:04'),(566,1,'2026-07-03',19,'JPY',5,5,16947558.00,'2026-07-06 02:38:04','2026-07-06 02:38:04'),(567,1,'2026-07-03',19,'MYR',5,5,15561723.00,'2026-07-06 02:38:04','2026-07-06 02:38:04'),(568,1,'2026-07-03',19,'EUR',3,3,38535116.00,'2026-07-06 02:38:04','2026-07-06 02:38:04'),(569,1,'2026-07-03',19,'CNY',2,2,200000.00,'2026-07-06 02:38:04','2026-07-06 02:38:04'),(570,1,'2026-07-03',19,'AUD',1,1,27006932.00,'2026-07-06 02:38:04','2026-07-06 02:38:04'),(571,1,'2026-07-03',19,'GBP',1,1,4975038.00,'2026-07-06 02:38:04','2026-07-06 02:38:04'),(572,1,'2026-07-03',19,'HKD',1,1,229401.00,'2026-07-06 02:38:04','2026-07-06 02:38:04'),(573,1,'2026-07-03',19,'SAR',1,1,958600.00,'2026-07-06 02:38:04','2026-07-06 02:38:04'),(574,1,'2026-07-03',20,'USD',17,17,79788230.00,'2026-07-06 02:38:04','2026-07-06 02:38:04'),(575,1,'2026-07-03',20,'EUR',5,5,2820760.00,'2026-07-06 02:38:04','2026-07-06 02:38:04'),(576,1,'2026-07-03',20,'MYR',4,4,2545262.00,'2026-07-06 02:38:04','2026-07-06 02:38:04'),(577,1,'2026-07-03',20,'SGD',3,3,13413940.00,'2026-07-06 02:38:04','2026-07-06 02:38:04'),(578,1,'2026-07-03',20,'AUD',2,2,1270900.00,'2026-07-06 02:38:04','2026-07-06 02:38:04'),(579,1,'2026-07-03',20,'JPY',2,2,1450000.00,'2026-07-06 02:38:04','2026-07-06 02:38:04'),(580,1,'2026-07-03',20,'THB',2,2,3947595.00,'2026-07-06 02:38:04','2026-07-06 02:38:04'),(581,1,'2026-07-03',20,'CNY',1,1,5000000.00,'2026-07-06 02:38:04','2026-07-06 02:38:04'),(582,1,'2026-07-03',20,'GBP',1,1,2000000.00,'2026-07-06 02:38:04','2026-07-06 02:38:04'),(583,1,'2026-07-03',20,'HKD',1,1,871720.00,'2026-07-06 02:38:04','2026-07-06 02:38:04'),(584,1,'2026-07-03',21,'USD',12,12,81131192.00,'2026-07-06 02:38:04','2026-07-06 02:38:04'),(585,1,'2026-07-03',21,'JPY',7,7,26480387.00,'2026-07-06 02:38:04','2026-07-06 02:38:04'),(586,1,'2026-07-03',21,'SGD',4,4,15820434.00,'2026-07-06 02:38:04','2026-07-06 02:38:04'),(587,1,'2026-07-03',21,'SAR',3,3,2198250.00,'2026-07-06 02:38:04','2026-07-06 02:38:04'),(588,1,'2026-07-03',21,'EUR',2,2,1029800.00,'2026-07-06 02:38:04','2026-07-06 02:38:04'),(589,1,'2026-07-03',21,'HKD',2,2,1501034.00,'2026-07-06 02:38:04','2026-07-06 02:38:04'),(590,1,'2026-07-03',21,'AUD',1,1,3129627.00,'2026-07-06 02:38:04','2026-07-06 02:38:04'),(591,1,'2026-07-03',21,'CNY',1,1,227487.00,'2026-07-06 02:38:04','2026-07-06 02:38:04'),(592,1,'2026-07-03',21,'MYR',1,1,1501396.00,'2026-07-06 02:38:04','2026-07-06 02:38:04'),(593,1,'2026-07-03',22,'USD',9,9,142740190.00,'2026-07-06 02:38:04','2026-07-06 02:38:04'),(594,1,'2026-07-03',22,'MYR',7,7,19426393.00,'2026-07-06 02:38:04','2026-07-06 02:38:04'),(595,1,'2026-07-03',22,'SGD',5,5,2550797.00,'2026-07-06 02:38:04','2026-07-06 02:38:04'),(596,1,'2026-07-03',22,'EUR',4,4,4212448.00,'2026-07-06 02:38:04','2026-07-06 02:38:04'),(597,1,'2026-07-03',22,'AUD',2,2,149983.00,'2026-07-06 02:38:04','2026-07-06 02:38:04'),(598,1,'2026-07-03',22,'CNY',1,1,100000.00,'2026-07-06 02:38:04','2026-07-06 02:38:04'),(599,1,'2026-07-03',22,'JPY',1,1,412754.00,'2026-07-06 02:38:04','2026-07-06 02:38:04'),(600,1,'2026-07-03',22,'SAR',1,1,718950.00,'2026-07-06 02:38:04','2026-07-06 02:38:04'),(601,1,'2026-07-03',23,'SGD',6,6,81585031.00,'2026-07-06 02:38:04','2026-07-06 02:38:04'),(602,1,'2026-07-03',23,'MYR',5,5,23277418.00,'2026-07-06 02:38:04','2026-07-06 02:38:04'),(603,1,'2026-07-03',23,'USD',3,3,2961154.00,'2026-07-06 02:38:04','2026-07-06 02:38:04'),(604,1,'2026-07-03',23,'GBP',2,2,179630110.00,'2026-07-06 02:38:04','2026-07-06 02:38:04'),(605,1,'2026-07-03',23,'JPY',2,2,1693458.00,'2026-07-06 02:38:04','2026-07-06 02:38:04'),(606,1,'2026-07-03',23,'SAR',1,1,23965000.00,'2026-07-06 02:38:04','2026-07-06 02:38:04'),(607,1,'2026-07-04',0,'MYR',2,2,1690625.00,'2026-07-06 02:38:04','2026-07-06 02:38:04'),(608,1,'2026-07-04',0,'USD',2,2,1097390.00,'2026-07-06 02:38:04','2026-07-06 02:38:04'),(609,1,'2026-07-04',0,'AUD',1,1,1538607.00,'2026-07-06 02:38:04','2026-07-06 02:38:04'),(610,1,'2026-07-04',0,'EUR',1,1,432516.00,'2026-07-06 02:38:04','2026-07-06 02:38:04'),(611,1,'2026-07-04',0,'GBP',1,1,2475502.00,'2026-07-06 02:38:04','2026-07-06 02:38:04'),(612,1,'2026-07-04',0,'SAR',1,1,4793000.00,'2026-07-06 02:38:04','2026-07-06 02:38:04'),(613,1,'2026-07-04',0,'SGD',1,1,27902.00,'2026-07-06 02:38:04','2026-07-06 02:38:04'),(614,1,'2026-07-04',1,'GBP',2,2,2836012.00,'2026-07-06 02:38:04','2026-07-06 02:38:04'),(615,1,'2026-07-04',1,'USD',2,2,1149500.00,'2026-07-06 02:38:04','2026-07-06 02:38:04'),(616,1,'2026-07-04',1,'EUR',1,1,1000000.00,'2026-07-06 02:38:04','2026-07-06 02:38:04'),(617,1,'2026-07-04',1,'SAR',1,1,575160.00,'2026-07-06 02:38:04','2026-07-06 02:38:04'),(618,1,'2026-07-04',1,'SGD',1,1,250000.00,'2026-07-06 02:38:04','2026-07-06 02:38:04'),(619,1,'2026-07-04',2,'EUR',2,2,812372.00,'2026-07-06 02:38:04','2026-07-06 02:38:04'),(620,1,'2026-07-04',2,'USD',2,2,4011770.00,'2026-07-06 02:38:04','2026-07-06 02:38:04'),(621,1,'2026-07-04',2,'SGD',1,1,167453856.00,'2026-07-06 02:38:04','2026-07-06 02:38:04'),(622,1,'2026-07-04',3,'USD',3,3,1263900.00,'2026-07-06 02:38:04','2026-07-06 02:38:04'),(623,1,'2026-07-04',4,'SGD',4,4,5191815.00,'2026-07-06 02:38:04','2026-07-06 02:38:04'),(624,1,'2026-07-04',4,'USD',2,2,3617990.00,'2026-07-06 02:38:04','2026-07-06 02:38:04'),(625,1,'2026-07-04',4,'AUD',1,1,450000.00,'2026-07-06 02:38:04','2026-07-06 02:38:04'),(626,1,'2026-07-04',4,'EUR',1,1,5000000.00,'2026-07-06 02:38:04','2026-07-06 02:38:04'),(627,1,'2026-07-04',4,'HKD',1,1,1206645.00,'2026-07-06 02:38:04','2026-07-06 02:38:04'),(628,1,'2026-07-04',4,'JPY',1,1,250000.00,'2026-07-06 02:38:04','2026-07-06 02:38:04'),(629,1,'2026-07-04',4,'KRW',1,1,250000.00,'2026-07-06 02:38:04','2026-07-06 02:38:04'),(630,1,'2026-07-04',4,'SAR',1,1,1000000.00,'2026-07-06 02:38:04','2026-07-06 02:38:04'),(631,1,'2026-07-04',5,'USD',4,4,90989700.00,'2026-07-06 02:38:04','2026-07-06 02:38:04'),(632,1,'2026-07-04',5,'SGD',3,3,376678.00,'2026-07-06 02:38:04','2026-07-06 02:38:04'),(633,1,'2026-07-04',5,'MYR',2,2,3518153.00,'2026-07-06 02:38:04','2026-07-06 02:38:04'),(634,1,'2026-07-04',5,'GBP',1,1,3677202.00,'2026-07-06 02:38:04','2026-07-06 02:38:04'),(635,1,'2026-07-04',5,'HKD',1,1,5000000.00,'2026-07-06 02:38:04','2026-07-06 02:38:04'),(636,1,'2026-07-04',5,'KRW',1,1,230000.00,'2026-07-06 02:38:04','2026-07-06 02:38:04'),(637,1,'2026-07-04',5,'SAR',1,1,1491207.00,'2026-07-06 02:38:04','2026-07-06 02:38:04'),(638,1,'2026-07-04',6,'USD',11,11,44773382.00,'2026-07-06 02:38:04','2026-07-06 02:38:04'),(639,1,'2026-07-04',6,'JPY',5,5,30760705.00,'2026-07-06 02:38:04','2026-07-06 02:38:04'),(640,1,'2026-07-04',6,'EUR',2,2,520597.00,'2026-07-06 02:38:04','2026-07-06 02:38:04'),(641,1,'2026-07-04',6,'MYR',2,2,821770.00,'2026-07-06 02:38:04','2026-07-06 02:38:04'),(642,1,'2026-07-04',6,'SGD',2,2,2790200.00,'2026-07-06 02:38:04','2026-07-06 02:38:04'),(643,1,'2026-07-04',6,'AUD',1,1,1250900.00,'2026-07-06 02:38:04','2026-07-06 02:38:04'),(644,1,'2026-07-04',6,'HKD',1,1,630350.00,'2026-07-06 02:38:04','2026-07-06 02:38:04'),(645,1,'2026-07-04',6,'KRW',1,1,2458000.00,'2026-07-06 02:38:04','2026-07-06 02:38:04'),(646,1,'2026-07-04',6,'SAR',1,1,1264729.00,'2026-07-06 02:38:04','2026-07-06 02:38:04'),(647,1,'2026-07-04',7,'JPY',7,7,25133872.00,'2026-07-06 02:38:04','2026-07-06 02:38:04'),(648,1,'2026-07-04',7,'USD',7,7,81607730.00,'2026-07-06 02:38:04','2026-07-06 02:38:04'),(649,1,'2026-07-04',7,'SGD',5,5,2488178.00,'2026-07-06 02:38:04','2026-07-06 02:38:04'),(650,1,'2026-07-04',7,'CNY',4,4,88744.00,'2026-07-06 02:38:04','2026-07-06 02:38:04'),(651,1,'2026-07-04',7,'MYR',4,4,15828894.00,'2026-07-06 02:38:04','2026-07-06 02:38:04'),(652,1,'2026-07-04',7,'EUR',3,3,2459120.00,'2026-07-06 02:38:04','2026-07-06 02:38:04'),(653,1,'2026-07-04',7,'AUD',1,1,62582528.00,'2026-07-06 02:38:04','2026-07-06 02:38:04'),(654,1,'2026-07-04',8,'USD',11,11,2610903.00,'2026-07-06 02:38:04','2026-07-06 02:38:04'),(655,1,'2026-07-04',8,'JPY',5,5,8091300.00,'2026-07-06 02:38:04','2026-07-06 02:38:04'),(656,1,'2026-07-04',8,'MYR',5,5,15955866.00,'2026-07-06 02:38:04','2026-07-06 02:38:04'),(657,1,'2026-07-04',8,'SGD',4,4,4843403.00,'2026-07-06 02:38:04','2026-07-06 02:38:04'),(658,1,'2026-07-04',8,'SAR',3,3,8834400.00,'2026-07-06 02:38:04','2026-07-06 02:38:04'),(659,1,'2026-07-04',8,'AUD',2,2,74501699.00,'2026-07-06 02:38:04','2026-07-06 02:38:04'),(660,1,'2026-07-04',8,'THB',2,2,1332580.00,'2026-07-06 02:38:04','2026-07-06 02:38:04'),(661,1,'2026-07-04',8,'CNY',1,1,664000.00,'2026-07-06 02:38:04','2026-07-06 02:38:04'),(662,1,'2026-07-04',8,'EUR',1,1,4120800.00,'2026-07-06 02:38:04','2026-07-06 02:38:04'),(663,1,'2026-07-04',8,'GBP',1,1,6009750.00,'2026-07-06 02:38:04','2026-07-06 02:38:04'),(664,1,'2026-07-04',8,'KRW',1,1,736143.00,'2026-07-06 02:38:04','2026-07-06 02:38:04'),(665,1,'2026-07-04',9,'USD',23,23,519712347.00,'2026-07-06 02:38:04','2026-07-06 02:38:04'),(666,1,'2026-07-04',9,'JPY',7,7,4788900.00,'2026-07-06 02:38:04','2026-07-06 02:38:04'),(667,1,'2026-07-04',9,'SGD',6,6,3474907.00,'2026-07-06 02:38:04','2026-07-06 02:38:04'),(668,1,'2026-07-04',9,'MYR',3,3,53484785.00,'2026-07-06 02:38:04','2026-07-06 02:38:04'),(669,1,'2026-07-04',9,'CNY',2,2,7017200.00,'2026-07-06 02:38:04','2026-07-06 02:38:04'),(670,1,'2026-07-04',9,'EUR',1,1,150000.00,'2026-07-06 02:38:04','2026-07-06 02:38:04'),(671,1,'2026-07-04',9,'HKD',1,1,745626.00,'2026-07-06 02:38:04','2026-07-06 02:38:04'),(672,1,'2026-07-04',9,'KRW',1,1,2100000.00,'2026-07-06 02:38:04','2026-07-06 02:38:04'),(673,1,'2026-07-04',9,'SAR',1,1,1000000.00,'2026-07-06 02:38:04','2026-07-06 02:38:04'),(674,1,'2026-07-04',10,'USD',7,7,108241511.00,'2026-07-06 02:38:04','2026-07-06 02:38:04'),(675,1,'2026-07-04',10,'JPY',5,5,4310095.00,'2026-07-06 02:38:04','2026-07-06 02:38:04'),(676,1,'2026-07-04',10,'MYR',5,5,16343681.00,'2026-07-06 02:38:04','2026-07-06 02:38:04'),(677,1,'2026-07-04',10,'SGD',5,5,11209127.00,'2026-07-06 02:38:04','2026-07-06 02:38:04'),(678,1,'2026-07-04',10,'EUR',3,3,13465520.00,'2026-07-06 02:38:04','2026-07-06 02:38:04'),(679,1,'2026-07-04',10,'CNY',2,2,200000.00,'2026-07-06 02:38:04','2026-07-06 02:38:04'),(680,1,'2026-07-04',10,'SAR',2,2,10586000.00,'2026-07-06 02:38:04','2026-07-06 02:38:04'),(681,1,'2026-07-04',10,'HKD',1,1,630350.00,'2026-07-06 02:38:04','2026-07-06 02:38:04'),(682,1,'2026-07-04',10,'NZD',1,1,6255282.00,'2026-07-06 02:38:04','2026-07-06 02:38:04'),(683,1,'2026-07-04',11,'USD',13,13,75698243.00,'2026-07-06 02:38:04','2026-07-06 02:38:04'),(684,1,'2026-07-04',11,'SGD',6,6,75598990.00,'2026-07-06 02:38:04','2026-07-06 02:38:04'),(685,1,'2026-07-04',11,'JPY',4,4,17962320.00,'2026-07-06 02:38:04','2026-07-06 02:38:04'),(686,1,'2026-07-04',11,'MYR',4,4,34806794.00,'2026-07-06 02:38:04','2026-07-06 02:38:04'),(687,1,'2026-07-04',11,'SAR',4,4,12553376.00,'2026-07-06 02:38:04','2026-07-06 02:38:04'),(688,1,'2026-07-04',11,'EUR',2,2,55115082.00,'2026-07-06 02:38:04','2026-07-06 02:38:04'),(689,1,'2026-07-04',11,'HKD',1,1,3447695.00,'2026-07-06 02:38:04','2026-07-06 02:38:04'),(690,1,'2026-07-04',12,'USD',11,11,84858099.00,'2026-07-06 02:38:04','2026-07-06 02:38:04'),(691,1,'2026-07-04',12,'MYR',5,5,2867586.00,'2026-07-06 02:38:04','2026-07-06 02:38:04'),(692,1,'2026-07-04',12,'JPY',4,4,28587270.00,'2026-07-06 02:38:04','2026-07-06 02:38:04'),(693,1,'2026-07-04',12,'SGD',3,3,9878724.00,'2026-07-06 02:38:04','2026-07-06 02:38:04'),(694,1,'2026-07-04',12,'AUD',2,2,23550540.00,'2026-07-06 02:38:04','2026-07-06 02:38:04'),(695,1,'2026-07-04',12,'HKD',2,2,1154127.00,'2026-07-06 02:38:04','2026-07-06 02:38:04'),(696,1,'2026-07-04',12,'SAR',2,2,1720000.00,'2026-07-06 02:38:04','2026-07-06 02:38:04'),(697,1,'2026-07-04',12,'THB',2,2,10163173.00,'2026-07-06 02:38:04','2026-07-06 02:38:04'),(698,1,'2026-07-04',12,'CNY',1,1,2500000.00,'2026-07-06 02:38:04','2026-07-06 02:38:04'),(699,1,'2026-07-04',12,'EUR',1,1,456000.00,'2026-07-06 02:38:04','2026-07-06 02:38:04'),(700,1,'2026-07-04',12,'KRW',1,1,2900000.00,'2026-07-06 02:38:04','2026-07-06 02:38:04'),(701,1,'2026-07-04',13,'USD',10,10,62176393.00,'2026-07-06 02:38:04','2026-07-06 02:38:04'),(702,1,'2026-07-04',13,'JPY',7,7,18150433.00,'2026-07-06 02:38:04','2026-07-06 02:38:04'),(703,1,'2026-07-04',13,'MYR',6,6,30352989.00,'2026-07-06 02:38:04','2026-07-06 02:38:04'),(704,1,'2026-07-04',13,'SAR',4,4,105594750.00,'2026-07-06 02:38:04','2026-07-06 02:38:04'),(705,1,'2026-07-04',13,'SGD',4,4,3062929.00,'2026-07-06 02:38:04','2026-07-06 02:38:04'),(706,1,'2026-07-04',13,'HKD',3,3,2001690.00,'2026-07-06 02:38:04','2026-07-06 02:38:04'),(707,1,'2026-07-04',13,'CNY',1,1,100000.00,'2026-07-06 02:38:04','2026-07-06 02:38:04'),(708,1,'2026-07-04',13,'EUR',1,1,4223820.00,'2026-07-06 02:38:04','2026-07-06 02:38:04'),(709,1,'2026-07-04',13,'GBP',1,1,1008196.00,'2026-07-06 02:38:04','2026-07-06 02:38:04'),(710,1,'2026-07-04',14,'USD',9,9,76852273.00,'2026-07-06 02:38:04','2026-07-06 02:38:04'),(711,1,'2026-07-04',14,'SGD',6,6,65882832.00,'2026-07-06 02:38:04','2026-07-06 02:38:04'),(712,1,'2026-07-04',14,'MYR',4,4,3548674.00,'2026-07-06 02:38:04','2026-07-06 02:38:04'),(713,1,'2026-07-04',14,'GBP',3,3,3663538.00,'2026-07-06 02:38:04','2026-07-06 02:38:04'),(714,1,'2026-07-04',14,'AUD',2,2,110000000.00,'2026-07-06 02:38:04','2026-07-06 02:38:04'),(715,1,'2026-07-04',14,'JPY',2,2,1372750.00,'2026-07-06 02:38:04','2026-07-06 02:38:04'),(716,1,'2026-07-04',14,'EUR',1,1,1530000.00,'2026-07-06 02:38:04','2026-07-06 02:38:04'),(717,1,'2026-07-04',14,'HKD',1,1,3300000.00,'2026-07-06 02:38:04','2026-07-06 02:38:04'),(718,1,'2026-07-04',14,'SAR',1,1,100000.00,'2026-07-06 02:38:04','2026-07-06 02:38:04'),(719,1,'2026-07-04',15,'USD',10,10,35849013.00,'2026-07-06 02:38:04','2026-07-06 02:38:04'),(720,1,'2026-07-04',15,'JPY',5,5,12207300.00,'2026-07-06 02:38:04','2026-07-06 02:38:04'),(721,1,'2026-07-04',15,'SGD',5,5,2146454.00,'2026-07-06 02:38:04','2026-07-06 02:38:04'),(722,1,'2026-07-04',15,'AUD',2,2,3059838.00,'2026-07-06 02:38:04','2026-07-06 02:38:04'),(723,1,'2026-07-04',15,'CNY',2,2,69056.00,'2026-07-06 02:38:04','2026-07-06 02:38:04'),(724,1,'2026-07-04',15,'EUR',2,2,4020604.00,'2026-07-06 02:38:04','2026-07-06 02:38:04'),(725,1,'2026-07-04',15,'HKD',2,2,100293.00,'2026-07-06 02:38:04','2026-07-06 02:38:04'),(726,1,'2026-07-04',15,'SAR',2,2,1504793.00,'2026-07-06 02:38:04','2026-07-06 02:38:04'),(727,1,'2026-07-04',15,'GBP',1,1,24039.00,'2026-07-06 02:38:04','2026-07-06 02:38:04'),(728,1,'2026-07-04',15,'KRW',1,1,3000000.00,'2026-07-06 02:38:04','2026-07-06 02:38:04'),(729,1,'2026-07-04',15,'MYR',1,1,1554700.00,'2026-07-06 02:38:04','2026-07-06 02:38:04'),(730,1,'2026-07-04',16,'JPY',8,8,63150520.00,'2026-07-06 02:38:04','2026-07-06 02:38:04'),(731,1,'2026-07-04',16,'MYR',7,7,6518591.00,'2026-07-06 02:38:04','2026-07-06 02:38:04'),(732,1,'2026-07-04',16,'USD',6,6,12256550.00,'2026-07-06 02:38:04','2026-07-06 02:38:04'),(733,1,'2026-07-04',16,'SGD',5,5,79290199.00,'2026-07-06 02:38:04','2026-07-06 02:38:04'),(734,1,'2026-07-04',16,'HKD',3,3,3152650.00,'2026-07-06 02:38:04','2026-07-06 02:38:04'),(735,1,'2026-07-04',16,'EUR',2,2,1150000.00,'2026-07-06 02:38:04','2026-07-06 02:38:04'),(736,1,'2026-07-04',16,'CNY',1,1,5000000.00,'2026-07-06 02:38:04','2026-07-06 02:38:04'),(737,1,'2026-07-04',16,'GBP',1,1,30000000.00,'2026-07-06 02:38:04','2026-07-06 02:38:04'),(738,1,'2026-07-04',17,'JPY',8,8,29689750.00,'2026-07-06 02:38:04','2026-07-06 02:38:04'),(739,1,'2026-07-04',17,'SGD',5,5,3230189.00,'2026-07-06 02:38:04','2026-07-06 02:38:04'),(740,1,'2026-07-04',17,'USD',4,4,1173468.00,'2026-07-06 02:38:04','2026-07-06 02:38:04'),(741,1,'2026-07-04',17,'EUR',3,3,9542280.00,'2026-07-06 02:38:04','2026-07-06 02:38:04'),(742,1,'2026-07-04',17,'MYR',3,3,2011391.00,'2026-07-06 02:38:04','2026-07-06 02:38:04'),(743,1,'2026-07-04',17,'KRW',2,2,395940.00,'2026-07-06 02:38:04','2026-07-06 02:38:04'),(744,1,'2026-07-04',17,'CNY',1,1,53120.00,'2026-07-06 02:38:04','2026-07-06 02:38:04'),(745,1,'2026-07-04',17,'HKD',1,1,1180000.00,'2026-07-06 02:38:04','2026-07-06 02:38:04'),(746,1,'2026-07-04',17,'SAR',1,1,150980.00,'2026-07-06 02:38:04','2026-07-06 02:38:04'),(747,1,'2026-07-04',18,'MYR',7,7,6792068.00,'2026-07-06 02:38:04','2026-07-06 02:38:04'),(748,1,'2026-07-04',18,'SGD',7,7,164281468.00,'2026-07-06 02:38:04','2026-07-06 02:38:04'),(749,1,'2026-07-04',18,'USD',7,7,7198750.00,'2026-07-06 02:38:04','2026-07-06 02:38:04'),(750,1,'2026-07-04',18,'CNY',4,4,1980736.00,'2026-07-06 02:38:04','2026-07-06 02:38:04'),(751,1,'2026-07-04',18,'JPY',3,3,1227711.00,'2026-07-06 02:38:04','2026-07-06 02:38:04'),(752,1,'2026-07-04',18,'AUD',2,2,5540321.00,'2026-07-06 02:38:04','2026-07-06 02:38:04'),(753,1,'2026-07-04',18,'EUR',1,1,900000.00,'2026-07-06 02:38:04','2026-07-06 02:38:04'),(754,1,'2026-07-04',18,'KRW',1,1,24600000.00,'2026-07-06 02:38:04','2026-07-06 02:38:04'),(755,1,'2026-07-04',18,'SAR',1,1,2396500.00,'2026-07-06 02:38:04','2026-07-06 02:38:04'),(756,1,'2026-07-04',19,'USD',10,10,8891225.00,'2026-07-06 02:38:04','2026-07-06 02:38:04'),(757,1,'2026-07-04',19,'EUR',5,5,33455464.00,'2026-07-06 02:38:04','2026-07-06 02:38:04'),(758,1,'2026-07-04',19,'JPY',4,4,167564907.00,'2026-07-06 02:38:04','2026-07-06 02:38:04'),(759,1,'2026-07-04',19,'MYR',3,3,21100367.00,'2026-07-06 02:38:04','2026-07-06 02:38:04'),(760,1,'2026-07-04',19,'AUD',1,1,41310620.00,'2026-07-06 02:38:04','2026-07-06 02:38:04'),(761,1,'2026-07-04',19,'CNY',1,1,295000.00,'2026-07-06 02:38:04','2026-07-06 02:38:04'),(762,1,'2026-07-04',19,'GBP',1,1,432702.00,'2026-07-06 02:38:04','2026-07-06 02:38:04'),(763,1,'2026-07-04',20,'USD',7,7,16281850.00,'2026-07-06 02:38:04','2026-07-06 02:38:04'),(764,1,'2026-07-04',20,'JPY',4,4,4000742.00,'2026-07-06 02:38:04','2026-07-06 02:38:04'),(765,1,'2026-07-04',20,'SGD',4,4,3625493.00,'2026-07-06 02:38:04','2026-07-06 02:38:04'),(766,1,'2026-07-04',20,'CNY',3,3,26760800.00,'2026-07-06 02:38:04','2026-07-06 02:38:04'),(767,1,'2026-07-04',20,'KRW',2,2,14200000.00,'2026-07-06 02:38:04','2026-07-06 02:38:04'),(768,1,'2026-07-04',20,'AUD',1,1,1250700.00,'2026-07-06 02:38:04','2026-07-06 02:38:04'),(769,1,'2026-07-04',20,'EUR',1,1,900000.00,'2026-07-06 02:38:04','2026-07-06 02:38:04'),(770,1,'2026-07-04',20,'MYR',1,1,15219.00,'2026-07-06 02:38:04','2026-07-06 02:38:04'),(771,1,'2026-07-04',20,'THB',1,1,163173.00,'2026-07-06 02:38:04','2026-07-06 02:38:04'),(772,1,'2026-07-04',21,'USD',6,6,240396708.00,'2026-07-06 02:38:04','2026-07-06 02:38:04'),(773,1,'2026-07-04',21,'MYR',5,5,6463164.00,'2026-07-06 02:38:04','2026-07-06 02:38:04'),(774,1,'2026-07-04',21,'SAR',5,5,5279300.00,'2026-07-06 02:38:04','2026-07-06 02:38:04'),(775,1,'2026-07-04',21,'JPY',3,3,4540000.00,'2026-07-06 02:38:04','2026-07-06 02:38:04'),(776,1,'2026-07-04',21,'SGD',3,3,3601272.00,'2026-07-06 02:38:04','2026-07-06 02:38:04'),(777,1,'2026-07-04',21,'EUR',2,2,572000.00,'2026-07-06 02:38:04','2026-07-06 02:38:04'),(778,1,'2026-07-04',21,'AUD',1,1,20000.00,'2026-07-06 02:38:04','2026-07-06 02:38:04'),(779,1,'2026-07-04',21,'CNY',1,1,10000.00,'2026-07-06 02:38:04','2026-07-06 02:38:04'),(780,1,'2026-07-04',21,'HKD',1,1,150000.00,'2026-07-06 02:38:04','2026-07-06 02:38:04'),(781,1,'2026-07-04',21,'KRW',1,1,2460000.00,'2026-07-06 02:38:04','2026-07-06 02:38:04'),(782,1,'2026-07-04',22,'USD',4,4,24809723.00,'2026-07-06 02:38:04','2026-07-06 02:38:04'),(783,1,'2026-07-04',22,'SAR',3,3,2578203.00,'2026-07-06 02:38:04','2026-07-06 02:38:04'),(784,1,'2026-07-04',22,'EUR',2,2,310000.00,'2026-07-06 02:38:04','2026-07-06 02:38:04'),(785,1,'2026-07-04',22,'JPY',2,2,503729.00,'2026-07-06 02:38:04','2026-07-06 02:38:04'),(786,1,'2026-07-04',22,'CNY',1,1,1000000.00,'2026-07-06 02:38:04','2026-07-06 02:38:04'),(787,1,'2026-07-04',22,'GBP',1,1,25000000.00,'2026-07-06 02:38:04','2026-07-06 02:38:04'),(788,1,'2026-07-04',22,'MYR',1,1,621880.00,'2026-07-06 02:38:04','2026-07-06 02:38:04'),(789,1,'2026-07-04',22,'SGD',1,1,500000.00,'2026-07-06 02:38:04','2026-07-06 02:38:04'),(790,1,'2026-07-04',23,'SGD',3,3,2006924.00,'2026-07-06 02:38:04','2026-07-06 02:38:04'),(791,1,'2026-07-04',23,'EUR',2,2,31167812.00,'2026-07-06 02:38:04','2026-07-06 02:38:04'),(792,1,'2026-07-04',23,'AUD',1,1,87549000.00,'2026-07-06 02:38:04','2026-07-06 02:38:04'),(793,1,'2026-07-04',23,'CNY',1,1,140768.00,'2026-07-06 02:38:04','2026-07-06 02:38:04'),(794,1,'2026-07-04',23,'GBP',1,1,4879917.00,'2026-07-06 02:38:04','2026-07-06 02:38:04'),(795,1,'2026-07-04',23,'JPY',1,1,1990000.00,'2026-07-06 02:38:04','2026-07-06 02:38:04'),(796,1,'2026-07-04',23,'SAR',1,1,239650.00,'2026-07-06 02:38:04','2026-07-06 02:38:04'),(797,1,'2026-07-05',0,'EUR',1,1,420322.00,'2026-07-06 02:38:04','2026-07-06 02:38:04'),(798,1,'2026-07-05',0,'GBP',1,1,1153872.00,'2026-07-06 02:38:04','2026-07-06 02:38:04'),(799,1,'2026-07-05',0,'MYR',1,1,450000.00,'2026-07-06 02:38:04','2026-07-06 02:38:04'),(800,1,'2026-07-05',0,'SGD',1,1,139530.00,'2026-07-06 02:38:04','2026-07-06 02:38:04'),(801,1,'2026-07-05',0,'USD',1,1,1259300.00,'2026-07-06 02:38:04','2026-07-06 02:38:04'),(802,1,'2026-07-05',1,'SAR',3,3,4979300.00,'2026-07-06 02:38:04','2026-07-06 02:38:04'),(803,1,'2026-07-05',1,'SGD',2,2,2595258.00,'2026-07-06 02:38:04','2026-07-06 02:38:04'),(804,1,'2026-07-05',1,'USD',2,2,21857850.00,'2026-07-06 02:38:04','2026-07-06 02:38:04'),(805,1,'2026-07-05',1,'EUR',1,1,600000.00,'2026-07-06 02:38:04','2026-07-06 02:38:04'),(806,1,'2026-07-05',2,'JPY',1,1,540000.00,'2026-07-06 02:38:04','2026-07-06 02:38:04'),(807,1,'2026-07-05',2,'SAR',1,1,500000.00,'2026-07-06 02:38:04','2026-07-06 02:38:04'),(808,1,'2026-07-05',2,'USD',1,1,539700.00,'2026-07-06 02:38:04','2026-07-06 02:38:04'),(809,1,'2026-07-05',3,'USD',3,3,935480.00,'2026-07-06 02:38:04','2026-07-06 02:38:04'),(810,1,'2026-07-05',4,'AUD',1,1,400000.00,'2026-07-06 02:38:04','2026-07-06 02:38:04'),(811,1,'2026-07-05',4,'EUR',1,1,250000.00,'2026-07-06 02:38:04','2026-07-06 02:38:04'),(812,1,'2026-07-05',4,'MYR',1,1,444200.00,'2026-07-06 02:38:04','2026-07-06 02:38:04'),(813,1,'2026-07-05',4,'SGD',1,1,1437159.00,'2026-07-06 02:38:04','2026-07-06 02:38:04'),(814,1,'2026-07-05',4,'USD',1,1,6044640.00,'2026-07-06 02:38:04','2026-07-06 02:38:04'),(815,1,'2026-07-05',5,'USD',8,8,629650.00,'2026-07-06 02:38:04','2026-07-06 02:38:04'),(816,1,'2026-07-05',5,'MYR',2,2,1687072.00,'2026-07-06 02:38:04','2026-07-06 02:38:04'),(817,1,'2026-07-05',5,'GBP',1,1,31505.00,'2026-07-06 02:38:04','2026-07-06 02:38:04'),(818,1,'2026-07-05',6,'USD',9,9,45269180.00,'2026-07-06 02:38:04','2026-07-06 02:38:04'),(819,1,'2026-07-05',6,'JPY',4,4,2923853.00,'2026-07-06 02:38:04','2026-07-06 02:38:04'),(820,1,'2026-07-05',6,'SGD',3,3,2246433.00,'2026-07-06 02:38:04','2026-07-06 02:38:04'),(821,1,'2026-07-05',6,'AUD',2,2,5290321.00,'2026-07-06 02:38:04','2026-07-06 02:38:04'),(822,1,'2026-07-05',6,'EUR',2,2,5151000.00,'2026-07-06 02:38:04','2026-07-06 02:38:04'),(823,1,'2026-07-05',6,'KRW',2,2,2706000.00,'2026-07-06 02:38:04','2026-07-06 02:38:04'),(824,1,'2026-07-05',6,'MYR',2,2,2350000.00,'2026-07-06 02:38:04','2026-07-06 02:38:04'),(825,1,'2026-07-05',6,'GBP',1,1,168273.00,'2026-07-06 02:38:04','2026-07-06 02:38:04'),(826,1,'2026-07-05',7,'USD',6,6,10573650.00,'2026-07-06 02:38:04','2026-07-06 02:38:04'),(827,1,'2026-07-05',7,'JPY',4,4,3657614.00,'2026-07-06 02:38:04','2026-07-06 02:38:04'),(828,1,'2026-07-05',7,'MYR',4,4,11584320.00,'2026-07-06 02:38:04','2026-07-06 02:38:04'),(829,1,'2026-07-05',7,'SGD',4,4,8216030.00,'2026-07-06 02:38:04','2026-07-06 02:38:04'),(830,1,'2026-07-05',7,'AUD',1,1,2900000.00,'2026-07-06 02:38:04','2026-07-06 02:38:04'),(831,1,'2026-07-05',8,'USD',9,9,239278203.00,'2026-07-06 02:38:04','2026-07-06 02:38:04'),(832,1,'2026-07-05',8,'SGD',7,7,113647227.00,'2026-07-06 02:38:04','2026-07-06 02:38:04'),(833,1,'2026-07-05',8,'MYR',5,5,2221594.00,'2026-07-06 02:38:04','2026-07-06 02:38:04'),(834,1,'2026-07-05',8,'KRW',4,4,5458790.00,'2026-07-06 02:38:04','2026-07-06 02:38:04'),(835,1,'2026-07-05',8,'CNY',3,3,14192736.00,'2026-07-06 02:38:04','2026-07-06 02:38:04'),(836,1,'2026-07-05',8,'JPY',3,3,25945695.00,'2026-07-06 02:38:04','2026-07-06 02:38:04'),(837,1,'2026-07-05',8,'AUD',1,1,31305020.00,'2026-07-06 02:38:04','2026-07-06 02:38:04'),(838,1,'2026-07-05',8,'EUR',1,1,8076768.00,'2026-07-06 02:38:04','2026-07-06 02:38:04'),(839,1,'2026-07-05',8,'SAR',1,1,95860.00,'2026-07-06 02:38:04','2026-07-06 02:38:04'),(840,1,'2026-07-05',9,'USD',15,15,313101970.00,'2026-07-06 02:38:04','2026-07-06 02:38:04'),(841,1,'2026-07-05',9,'JPY',9,9,6530947.00,'2026-07-06 02:38:04','2026-07-06 02:38:04'),(842,1,'2026-07-05',9,'SGD',8,8,32690231.00,'2026-07-06 02:38:04','2026-07-06 02:38:04'),(843,1,'2026-07-05',9,'CNY',4,4,16397216.00,'2026-07-06 02:38:04','2026-07-06 02:38:04'),(844,1,'2026-07-05',9,'MYR',4,4,7629536.00,'2026-07-06 02:38:04','2026-07-06 02:38:04'),(845,1,'2026-07-05',9,'AUD',2,2,16921971.00,'2026-07-06 02:38:04','2026-07-06 02:38:04'),(846,1,'2026-07-05',9,'EUR',2,2,3290600.00,'2026-07-06 02:38:05','2026-07-06 02:38:05'),(847,1,'2026-07-05',9,'HKD',1,1,1206730.00,'2026-07-06 02:38:05','2026-07-06 02:38:05'),(848,1,'2026-07-05',9,'THB',1,1,1631730.00,'2026-07-06 02:38:05','2026-07-06 02:38:05'),(849,1,'2026-07-05',10,'USD',10,10,45883862.00,'2026-07-06 02:38:05','2026-07-06 02:38:05'),(850,1,'2026-07-05',10,'JPY',7,7,64562764.00,'2026-07-06 02:38:05','2026-07-06 02:38:05'),(851,1,'2026-07-05',10,'SGD',5,5,8760176.00,'2026-07-06 02:38:05','2026-07-06 02:38:05'),(852,1,'2026-07-05',10,'KRW',2,2,13810000.00,'2026-07-06 02:38:05','2026-07-06 02:38:05'),(853,1,'2026-07-05',10,'SAR',2,2,1049000.00,'2026-07-06 02:38:05','2026-07-06 02:38:05'),(854,1,'2026-07-05',10,'AUD',1,1,31305020.00,'2026-07-06 02:38:05','2026-07-06 02:38:05'),(855,1,'2026-07-05',10,'CNY',1,1,100000.00,'2026-07-06 02:38:05','2026-07-06 02:38:05'),(856,1,'2026-07-05',10,'HKD',1,1,630350.00,'2026-07-06 02:38:05','2026-07-06 02:38:05'),(857,1,'2026-07-05',10,'MYR',1,1,250000.00,'2026-07-06 02:38:05','2026-07-06 02:38:05'),(858,1,'2026-07-05',11,'USD',9,9,136684220.00,'2026-07-06 02:38:05','2026-07-06 02:38:05'),(859,1,'2026-07-05',11,'SGD',8,8,26177502.00,'2026-07-06 02:38:05','2026-07-06 02:38:05'),(860,1,'2026-07-05',11,'JPY',6,6,125795020.00,'2026-07-06 02:38:05','2026-07-06 02:38:05'),(861,1,'2026-07-05',11,'MYR',3,3,1412776.00,'2026-07-06 02:38:05','2026-07-06 02:38:05'),(862,1,'2026-07-05',11,'CNY',2,2,10500000.00,'2026-07-06 02:38:05','2026-07-06 02:38:05'),(863,1,'2026-07-05',11,'AUD',1,1,5040321.00,'2026-07-06 02:38:05','2026-07-06 02:38:05'),(864,1,'2026-07-05',11,'HKD',1,1,630350.00,'2026-07-06 02:38:05','2026-07-06 02:38:05'),(865,1,'2026-07-05',11,'SAR',1,1,2500000.00,'2026-07-06 02:38:05','2026-07-06 02:38:05'),(866,1,'2026-07-05',11,'THB',1,1,100000.00,'2026-07-06 02:38:05','2026-07-06 02:38:05'),(867,1,'2026-07-05',12,'USD',8,8,171974083.00,'2026-07-06 02:38:05','2026-07-06 02:38:05'),(868,1,'2026-07-05',12,'JPY',4,4,30503505.00,'2026-07-06 02:38:05','2026-07-06 02:38:05'),(869,1,'2026-07-05',12,'MYR',4,4,5776800.00,'2026-07-06 02:38:05','2026-07-06 02:38:05'),(870,1,'2026-07-05',12,'SGD',3,3,544167.00,'2026-07-06 02:38:05','2026-07-06 02:38:05'),(871,1,'2026-07-05',12,'AUD',2,2,622000.00,'2026-07-06 02:38:05','2026-07-06 02:38:05'),(872,1,'2026-07-05',12,'HKD',2,2,3866880.00,'2026-07-06 02:38:05','2026-07-06 02:38:05'),(873,1,'2026-07-05',12,'EUR',1,1,20604.00,'2026-07-06 02:38:05','2026-07-06 02:38:05'),(874,1,'2026-07-05',12,'THB',1,1,5439100.00,'2026-07-06 02:38:05','2026-07-06 02:38:05'),(875,1,'2026-07-05',13,'USD',12,12,4305375.00,'2026-07-06 02:38:05','2026-07-06 02:38:05'),(876,1,'2026-07-05',13,'SGD',8,8,12901991.00,'2026-07-06 02:38:05','2026-07-06 02:38:05'),(877,1,'2026-07-05',13,'JPY',6,6,14454740.00,'2026-07-06 02:38:05','2026-07-06 02:38:05'),(878,1,'2026-07-05',13,'CNY',2,2,580000.00,'2026-07-06 02:38:05','2026-07-06 02:38:05'),(879,1,'2026-07-05',13,'SAR',2,2,3700000.00,'2026-07-06 02:38:05','2026-07-06 02:38:05'),(880,1,'2026-07-05',13,'AUD',1,1,675378.00,'2026-07-06 02:38:05','2026-07-06 02:38:05'),(881,1,'2026-07-05',13,'HKD',1,1,435670.00,'2026-07-06 02:38:05','2026-07-06 02:38:05'),(882,1,'2026-07-05',13,'KRW',1,1,553500.00,'2026-07-06 02:38:05','2026-07-06 02:38:05'),(883,1,'2026-07-05',13,'MYR',1,1,10000.00,'2026-07-06 02:38:05','2026-07-06 02:38:05'),(884,1,'2026-07-05',14,'USD',7,7,93585920.00,'2026-07-06 02:38:05','2026-07-06 02:38:05'),(885,1,'2026-07-05',14,'JPY',3,3,15043567.00,'2026-07-06 02:38:05','2026-07-06 02:38:05'),(886,1,'2026-07-05',14,'KRW',3,3,4070000.00,'2026-07-06 02:38:05','2026-07-06 02:38:05'),(887,1,'2026-07-05',14,'MYR',2,2,2559485.00,'2026-07-06 02:38:05','2026-07-06 02:38:05'),(888,1,'2026-07-05',14,'SAR',2,2,5500000.00,'2026-07-06 02:38:05','2026-07-06 02:38:05'),(889,1,'2026-07-05',14,'SGD',2,2,2985000.00,'2026-07-06 02:38:05','2026-07-06 02:38:05'),(890,1,'2026-07-05',14,'AUD',1,1,500000.00,'2026-07-06 02:38:05','2026-07-06 02:38:05'),(891,1,'2026-07-05',14,'CNY',1,1,249664.00,'2026-07-06 02:38:05','2026-07-06 02:38:05'),(892,1,'2026-07-05',15,'SGD',7,7,882543.00,'2026-07-06 02:38:05','2026-07-06 02:38:05'),(893,1,'2026-07-05',15,'USD',7,7,12109880.00,'2026-07-06 02:38:05','2026-07-06 02:38:05'),(894,1,'2026-07-05',15,'MYR',5,5,21971400.00,'2026-07-06 02:38:05','2026-07-06 02:38:05'),(895,1,'2026-07-05',15,'JPY',4,4,9195120.00,'2026-07-06 02:38:05','2026-07-06 02:38:05'),(896,1,'2026-07-05',15,'KRW',3,3,5560000.00,'2026-07-06 02:38:05','2026-07-06 02:38:05'),(897,1,'2026-07-05',15,'CNY',2,2,7133447.00,'2026-07-06 02:38:05','2026-07-06 02:38:05'),(898,1,'2026-07-05',15,'SAR',2,2,1445090.00,'2026-07-06 02:38:05','2026-07-06 02:38:05'),(899,1,'2026-07-05',15,'EUR',1,1,3000000.00,'2026-07-06 02:38:05','2026-07-06 02:38:05'),(900,1,'2026-07-05',16,'JPY',12,12,44427716.00,'2026-07-06 02:38:05','2026-07-06 02:38:05'),(901,1,'2026-07-05',16,'USD',8,8,9514380.00,'2026-07-06 02:38:05','2026-07-06 02:38:05'),(902,1,'2026-07-05',16,'SGD',7,7,12070604.00,'2026-07-06 02:38:05','2026-07-06 02:38:05'),(903,1,'2026-07-05',16,'MYR',3,3,23519461.00,'2026-07-06 02:38:05','2026-07-06 02:38:05'),(904,1,'2026-07-05',16,'CNY',2,2,2656000.00,'2026-07-06 02:38:05','2026-07-06 02:38:05'),(905,1,'2026-07-05',16,'EUR',2,2,1400748.00,'2026-07-06 02:38:05','2026-07-06 02:38:05'),(906,1,'2026-07-05',16,'AUD',1,1,387717.00,'2026-07-06 02:38:05','2026-07-06 02:38:05'),(907,1,'2026-07-05',16,'KRW',1,1,300000.00,'2026-07-06 02:38:05','2026-07-06 02:38:05'),(908,1,'2026-07-05',16,'SAR',1,1,150000.00,'2026-07-06 02:38:05','2026-07-06 02:38:05'),(909,1,'2026-07-05',16,'THB',1,1,271955.00,'2026-07-06 02:38:05','2026-07-06 02:38:05'),(910,1,'2026-07-05',17,'USD',10,10,374058643.00,'2026-07-06 02:38:05','2026-07-06 02:38:05'),(911,1,'2026-07-05',17,'JPY',7,7,6370562.00,'2026-07-06 02:38:05','2026-07-06 02:38:05'),(912,1,'2026-07-05',17,'MYR',6,6,17319067.00,'2026-07-06 02:38:05','2026-07-06 02:38:05'),(913,1,'2026-07-05',17,'SGD',6,6,35915023.00,'2026-07-06 02:38:05','2026-07-06 02:38:05'),(914,1,'2026-07-05',17,'EUR',2,2,50051510.00,'2026-07-06 02:38:05','2026-07-06 02:38:05'),(915,1,'2026-07-05',17,'HKD',2,2,9899798.00,'2026-07-06 02:38:05','2026-07-06 02:38:05'),(916,1,'2026-07-05',17,'SAR',2,2,9793000.00,'2026-07-06 02:38:05','2026-07-06 02:38:05'),(917,1,'2026-07-05',17,'AUD',1,1,10668471.00,'2026-07-06 02:38:05','2026-07-06 02:38:05'),(918,1,'2026-07-05',17,'CNY',1,1,79680.00,'2026-07-06 02:38:05','2026-07-06 02:38:05'),(919,1,'2026-07-05',18,'JPY',9,9,24268475.00,'2026-07-06 02:38:05','2026-07-06 02:38:05'),(920,1,'2026-07-05',18,'USD',6,6,6040920.00,'2026-07-06 02:38:05','2026-07-06 02:38:05'),(921,1,'2026-07-05',18,'MYR',4,4,4423482.00,'2026-07-06 02:38:05','2026-07-06 02:38:05'),(922,1,'2026-07-05',18,'EUR',3,3,1545300.00,'2026-07-06 02:38:05','2026-07-06 02:38:05'),(923,1,'2026-07-05',18,'SGD',3,3,10199643.00,'2026-07-06 02:38:05','2026-07-06 02:38:05'),(924,1,'2026-07-05',18,'THB',3,3,864818.00,'2026-07-06 02:38:05','2026-07-06 02:38:05'),(925,1,'2026-07-05',18,'KRW',2,2,7460000.00,'2026-07-06 02:38:05','2026-07-06 02:38:05'),(926,1,'2026-07-05',18,'CNY',1,1,5312000.00,'2026-07-06 02:38:05','2026-07-06 02:38:05'),(927,1,'2026-07-05',18,'HKD',1,1,515074.00,'2026-07-06 02:38:05','2026-07-06 02:38:05'),(928,1,'2026-07-05',18,'SAR',1,1,31154500.00,'2026-07-06 02:38:05','2026-07-06 02:38:05'),(929,1,'2026-07-05',19,'JPY',5,5,44081833.00,'2026-07-06 02:38:05','2026-07-06 02:38:05'),(930,1,'2026-07-05',19,'SGD',5,5,180873462.00,'2026-07-06 02:38:05','2026-07-06 02:38:05'),(931,1,'2026-07-05',19,'MYR',4,4,5805404.00,'2026-07-06 02:38:05','2026-07-06 02:38:05'),(932,1,'2026-07-05',19,'USD',4,4,2734480.00,'2026-07-06 02:38:05','2026-07-06 02:38:05'),(933,1,'2026-07-05',19,'EUR',2,2,20804000.00,'2026-07-06 02:38:05','2026-07-06 02:38:05'),(934,1,'2026-07-05',19,'KRW',2,2,17470000.00,'2026-07-06 02:38:05','2026-07-06 02:38:05'),(935,1,'2026-07-05',19,'AUD',1,1,20000.00,'2026-07-06 02:38:05','2026-07-06 02:38:05'),(936,1,'2026-07-05',19,'CNY',1,1,7968000.00,'2026-07-06 02:38:05','2026-07-06 02:38:05'),(937,1,'2026-07-05',19,'THB',1,1,326346.00,'2026-07-06 02:38:05','2026-07-06 02:38:05'),(938,1,'2026-07-05',20,'USD',10,10,30086110.00,'2026-07-06 02:38:05','2026-07-06 02:38:05'),(939,1,'2026-07-05',20,'SGD',3,3,11622849.00,'2026-07-06 02:38:05','2026-07-06 02:38:05'),(940,1,'2026-07-05',20,'GBP',2,2,40000000.00,'2026-07-06 02:38:05','2026-07-06 02:38:05'),(941,1,'2026-07-05',20,'JPY',2,2,5374770.00,'2026-07-06 02:38:05','2026-07-06 02:38:05'),(942,1,'2026-07-05',20,'CNY',1,1,132800.00,'2026-07-06 02:38:05','2026-07-06 02:38:05'),(943,1,'2026-07-05',20,'EUR',1,1,206040.00,'2026-07-06 02:38:05','2026-07-06 02:38:05'),(944,1,'2026-07-05',20,'HKD',1,1,871340.00,'2026-07-06 02:38:05','2026-07-06 02:38:05'),(945,1,'2026-07-05',20,'SAR',1,1,300000.00,'2026-07-06 02:38:05','2026-07-06 02:38:05'),(946,1,'2026-07-05',21,'SGD',6,6,2730183.00,'2026-07-06 02:38:05','2026-07-06 02:38:05'),(947,1,'2026-07-05',21,'USD',5,5,5002770.00,'2026-07-06 02:38:05','2026-07-06 02:38:05'),(948,1,'2026-07-05',21,'MYR',3,3,5350000.00,'2026-07-06 02:38:05','2026-07-06 02:38:05'),(949,1,'2026-07-05',21,'JPY',2,2,2965520.00,'2026-07-06 02:38:05','2026-07-06 02:38:05'),(950,1,'2026-07-05',21,'CNY',1,1,292160.00,'2026-07-06 02:38:05','2026-07-06 02:38:05'),(951,1,'2026-07-05',21,'EUR',1,1,391476.00,'2026-07-06 02:38:05','2026-07-06 02:38:05'),(952,1,'2026-07-05',21,'GBP',1,1,48078.00,'2026-07-06 02:38:05','2026-07-06 02:38:05'),(953,1,'2026-07-05',21,'SAR',1,1,2500000.00,'2026-07-06 02:38:05','2026-07-06 02:38:05'),(954,1,'2026-07-05',21,'THB',1,1,231000.00,'2026-07-06 02:38:05','2026-07-06 02:38:05'),(955,1,'2026-07-05',22,'EUR',4,4,4479310.00,'2026-07-06 02:38:05','2026-07-06 02:38:05'),(956,1,'2026-07-05',22,'USD',3,3,1942920.00,'2026-07-06 02:38:05','2026-07-06 02:38:05'),(957,1,'2026-07-05',22,'MYR',1,1,50000.00,'2026-07-06 02:38:05','2026-07-06 02:38:05'),(958,1,'2026-07-05',22,'SAR',1,1,359475.00,'2026-07-06 02:38:05','2026-07-06 02:38:05'),(959,1,'2026-07-05',22,'SGD',1,1,390684.00,'2026-07-06 02:38:05','2026-07-06 02:38:05'),(960,1,'2026-07-05',23,'USD',5,5,15169600.00,'2026-07-06 02:38:05','2026-07-06 02:38:05'),(961,1,'2026-07-05',23,'EUR',4,4,9738920.00,'2026-07-06 02:38:05','2026-07-06 02:38:05'),(962,1,'2026-07-05',23,'SAR',4,4,3091485.00,'2026-07-06 02:38:05','2026-07-06 02:38:05'),(963,1,'2026-07-05',23,'SGD',3,3,6000000.00,'2026-07-06 02:38:05','2026-07-06 02:38:05'),(964,1,'2026-07-05',23,'MYR',2,2,26014819.00,'2026-07-06 02:38:05','2026-07-06 02:38:05'),(965,1,'2026-07-05',23,'AUD',1,1,10043121.00,'2026-07-06 02:38:05','2026-07-06 02:38:05'),(966,1,'2026-07-05',23,'CNY',1,1,250000.00,'2026-07-06 02:38:05','2026-07-06 02:38:05'),(967,1,'2026-07-05',23,'KRW',1,1,123000.00,'2026-07-06 02:38:05','2026-07-06 02:38:05');
/*!40000 ALTER TABLE `trx_pbi_limit_reports` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `trx_pbi_settlement_reports`
--

DROP TABLE IF EXISTS `trx_pbi_settlement_reports`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `trx_pbi_settlement_reports` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `report_source_id` bigint unsigned DEFAULT NULL,
  `trx_date` date NOT NULL,
  `trx_hour` tinyint unsigned NOT NULL,
  `trx_currency` varchar(10) COLLATE utf8mb4_unicode_ci NOT NULL,
  `trx_count` bigint unsigned NOT NULL DEFAULT '0',
  `success_count` bigint unsigned NOT NULL DEFAULT '0',
  `trx_amount` decimal(20,2) NOT NULL DEFAULT '0.00',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `trx_pbi_settlement_reports_trx_date_trx_hour_trx_currency_unique` (`trx_date`,`trx_hour`,`trx_currency`),
  KEY `trx_pbi_settlement_reports_report_source_id_foreign` (`report_source_id`),
  KEY `trx_pbi_settlement_reports_trx_date_index` (`trx_date`),
  KEY `trx_pbi_settlement_reports_trx_hour_index` (`trx_hour`),
  CONSTRAINT `trx_pbi_settlement_reports_report_source_id_foreign` FOREIGN KEY (`report_source_id`) REFERENCES `report_sources` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `trx_pbi_settlement_reports`
--

LOCK TABLES `trx_pbi_settlement_reports` WRITE;
/*!40000 ALTER TABLE `trx_pbi_settlement_reports` DISABLE KEYS */;
/*!40000 ALTER TABLE `trx_pbi_settlement_reports` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `moonshine_user_role_id` bigint unsigned NOT NULL DEFAULT '2',
  `avatar` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_email_unique` (`email`),
  KEY `users_moonshine_user_role_id_foreign` (`moonshine_user_role_id`),
  CONSTRAINT `users_moonshine_user_role_id_foreign` FOREIGN KEY (`moonshine_user_role_id`) REFERENCES `moonshine_user_roles` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'monitoring_laravel'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-07-11 17:10:11
