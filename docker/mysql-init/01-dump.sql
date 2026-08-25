/*M!999999\- enable the sandbox mode */ 
-- MariaDB dump 10.19-11.8.8-MariaDB, for Linux (x86_64)
--
-- Host: localhost    Database: datn
-- ------------------------------------------------------
-- Server version	11.8.8-MariaDB

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*M!100616 SET @OLD_NOTE_VERBOSITY=@@NOTE_VERBOSITY, NOTE_VERBOSITY=0 */;

--
-- Current Database: `datn`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `datn` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci */;

USE `datn`;

--
-- Table structure for table `ai_chat_histories`
--

DROP TABLE IF EXISTS `ai_chat_histories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `ai_chat_histories` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) unsigned DEFAULT NULL,
  `sender` enum('user','ai') NOT NULL,
  `message` text NOT NULL,
  `rooms_data` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`rooms_data`)),
  `ai_parsed` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`ai_parsed`)),
  `suggestions` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`suggestions`)),
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `ai_chat_histories_user_id_created_at_index` (`user_id`,`created_at`),
  CONSTRAINT `ai_chat_histories_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ai_chat_histories`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `ai_chat_histories` WRITE;
/*!40000 ALTER TABLE `ai_chat_histories` DISABLE KEYS */;
/*!40000 ALTER TABLE `ai_chat_histories` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `amenities`
--

DROP TABLE IF EXISTS `amenities`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `amenities` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `icon` varchar(255) NOT NULL DEFAULT 'bi-star',
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `amenities`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `amenities` WRITE;
/*!40000 ALTER TABLE `amenities` DISABLE KEYS */;
INSERT INTO `amenities` VALUES
(1,'Tiền điện','bi-lightning-charge',1,'2026-08-25 16:49:37','2026-08-25 16:49:37'),
(2,'Tiền nước','bi-droplet',1,'2026-08-25 16:49:37','2026-08-25 16:49:37'),
(3,'Internet/Wi-Fi','bi-wifi',1,'2026-08-25 16:49:37','2026-08-25 16:49:37'),
(4,'Phí rác','bi-trash',1,'2026-08-25 16:49:37','2026-08-25 16:49:37'),
(5,'Phí gửi xe','bi-bicycle',1,'2026-08-25 16:49:37','2026-08-25 16:49:37'),
(6,'Phí dịch vụ/chung','bi-tools',1,'2026-08-25 16:49:37','2026-08-25 16:49:37'),
(7,'Phí máy giặt','bi-layers',1,'2026-08-25 16:49:37','2026-08-25 16:49:37'),
(8,'Phí điều hòa','bi-thermometer-snow',1,'2026-08-25 16:49:37','2026-08-25 16:49:37'),
(9,'Phí phát sinh','bi-plus-circle',1,'2026-08-25 16:49:37','2026-08-25 16:49:37');
/*!40000 ALTER TABLE `amenities` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `appointments`
--

DROP TABLE IF EXISTS `appointments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `appointments` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) unsigned NOT NULL,
  `landlord_id` bigint(20) unsigned NOT NULL,
  `room_id` bigint(20) unsigned NOT NULL,
  `date` date NOT NULL,
  `time` time NOT NULL,
  `note` text DEFAULT NULL,
  `status` varchar(255) NOT NULL DEFAULT 'pending',
  `feedback_result` varchar(255) DEFAULT NULL,
  `feedback_reason` varchar(255) DEFAULT NULL,
  `feedback_time` timestamp NULL DEFAULT NULL,
  `cancellation_reason` varchar(255) DEFAULT NULL,
  `notified` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `appointments_user_id_foreign` (`user_id`),
  KEY `appointments_landlord_id_foreign` (`landlord_id`),
  KEY `appointments_room_id_foreign` (`room_id`),
  CONSTRAINT `appointments_landlord_id_foreign` FOREIGN KEY (`landlord_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `appointments_room_id_foreign` FOREIGN KEY (`room_id`) REFERENCES `rooms` (`id`) ON DELETE CASCADE,
  CONSTRAINT `appointments_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `appointments`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `appointments` WRITE;
/*!40000 ALTER TABLE `appointments` DISABLE KEYS */;
/*!40000 ALTER TABLE `appointments` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `areas`
--

DROP TABLE IF EXISTS `areas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `areas` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `icon` varchar(255) NOT NULL DEFAULT 'bi-geo-alt',
  `map_embed` text DEFAULT NULL COMMENT 'Mã nhúng iframe Google Maps',
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `areas`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `areas` WRITE;
/*!40000 ALTER TABLE `areas` DISABLE KEYS */;
INSERT INTO `areas` VALUES
(1,'Xã Bình Lục','bi-geo-alt',NULL,1,'2026-08-25 16:49:37','2026-08-25 16:49:37'),
(2,'Xã Bình Mỹ','bi-geo-alt',NULL,1,'2026-08-25 16:49:37','2026-08-25 16:49:37'),
(3,'Xã Bình An','bi-geo-alt',NULL,1,'2026-08-25 16:49:37','2026-08-25 16:49:37'),
(4,'Xã Bình Giang','bi-geo-alt',NULL,1,'2026-08-25 16:49:37','2026-08-25 16:49:37'),
(5,'Xã Bình Sơn','bi-geo-alt',NULL,1,'2026-08-25 16:49:37','2026-08-25 16:49:37'),
(6,'Xã Liêm Hà','bi-geo-alt',NULL,1,'2026-08-25 16:49:37','2026-08-25 16:49:37'),
(7,'Xã Tân Thanh','bi-geo-alt',NULL,1,'2026-08-25 16:49:37','2026-08-25 16:49:37'),
(8,'Xã Thanh Bình','bi-geo-alt',NULL,1,'2026-08-25 16:49:37','2026-08-25 16:49:37'),
(9,'Xã Thanh Lâm','bi-geo-alt',NULL,1,'2026-08-25 16:49:37','2026-08-25 16:49:37'),
(10,'Xã Thanh Liêm','bi-geo-alt',NULL,1,'2026-08-25 16:49:37','2026-08-25 16:49:37'),
(11,'Xã Lý Nhân','bi-geo-alt',NULL,1,'2026-08-25 16:49:37','2026-08-25 16:49:37'),
(12,'Xã Nam Xang','bi-geo-alt',NULL,1,'2026-08-25 16:49:37','2026-08-25 16:49:37'),
(13,'Xã Bắc Lý','bi-geo-alt',NULL,1,'2026-08-25 16:49:37','2026-08-25 16:49:37'),
(14,'Xã Vĩnh Trụ','bi-geo-alt',NULL,1,'2026-08-25 16:49:37','2026-08-25 16:49:37'),
(15,'Xã Trần Thương','bi-geo-alt',NULL,1,'2026-08-25 16:49:37','2026-08-25 16:49:37'),
(16,'Xã Nhân Hòa','bi-geo-alt',NULL,1,'2026-08-25 16:49:37','2026-08-25 16:49:37'),
(17,'Xã Nam Lý','bi-geo-alt',NULL,1,'2026-08-25 16:49:37','2026-08-25 16:49:37'),
(18,'Phường Duy Tiên','bi-geo-alt-fill',NULL,1,'2026-08-25 16:49:37','2026-08-25 16:49:37'),
(19,'Phường Duy Tân','bi-geo-alt-fill',NULL,1,'2026-08-25 16:49:37','2026-08-25 16:49:37'),
(20,'Phường Đồng Văn','bi-geo-alt-fill',NULL,1,'2026-08-25 16:49:37','2026-08-25 16:49:37'),
(21,'Phường Duy Hà','bi-geo-alt-fill',NULL,1,'2026-08-25 16:49:37','2026-08-25 16:49:37'),
(22,'Phường Tiên Sơn','bi-geo-alt-fill',NULL,1,'2026-08-25 16:49:37','2026-08-25 16:49:37'),
(23,'Phường Lê Hồ','bi-geo-alt-fill',NULL,1,'2026-08-25 16:49:37','2026-08-25 16:49:37'),
(24,'Phường Nguyễn Úy','bi-geo-alt-fill',NULL,1,'2026-08-25 16:49:37','2026-08-25 16:49:37'),
(25,'Phường Lý Thường Kiệt','bi-geo-alt-fill',NULL,1,'2026-08-25 16:49:37','2026-08-25 16:49:37'),
(26,'Phường Kim Thanh','bi-geo-alt-fill',NULL,1,'2026-08-25 16:49:37','2026-08-25 16:49:37'),
(27,'Phường Tam Chúc','bi-geo-alt-fill',NULL,1,'2026-08-25 16:49:37','2026-08-25 16:49:37'),
(28,'Phường Kim Bảng','bi-geo-alt-fill',NULL,1,'2026-08-25 16:49:37','2026-08-25 16:49:37'),
(29,'Phường Hà Nam','bi-geo-alt-fill',NULL,1,'2026-08-25 16:49:37','2026-08-25 16:49:37'),
(30,'Phường Phù Vân','bi-geo-alt-fill',NULL,1,'2026-08-25 16:49:37','2026-08-25 16:49:37'),
(31,'Phường Châu Sơn','bi-geo-alt-fill',NULL,1,'2026-08-25 16:49:37','2026-08-25 16:49:37'),
(32,'Phường Phủ Lý','bi-geo-alt-fill','<iframe src=\"https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d59745!2d105.91!3d20.54!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x3135cf570d8a5725%3A0x8849b2512f455c11!2zVFAuIFBow7ogTMO9LCBIw6AgTmFt!5e0!3m2!1svi!2svn!4v1\" width=\"600\" height=\"450\" style=\"border:0;\" allowfullscreen=\"\" loading=\"lazy\"></iframe>',1,'2026-08-25 16:49:37','2026-08-25 16:49:37'),
(33,'Phường Liêm Tuyền','bi-geo-alt-fill',NULL,1,'2026-08-25 16:49:37','2026-08-25 16:49:37');
/*!40000 ALTER TABLE `areas` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `audit_logs`
--

DROP TABLE IF EXISTS `audit_logs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `audit_logs` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) unsigned DEFAULT NULL,
  `action` varchar(255) NOT NULL,
  `target` text NOT NULL,
  `ip_address` varchar(45) DEFAULT NULL,
  `user_agent` varchar(255) DEFAULT NULL,
  `sensitive` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `audit_logs_user_id_foreign` (`user_id`),
  CONSTRAINT `audit_logs_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `audit_logs`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `audit_logs` WRITE;
/*!40000 ALTER TABLE `audit_logs` DISABLE KEYS */;
/*!40000 ALTER TABLE `audit_logs` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `boarding_houses`
--

DROP TABLE IF EXISTS `boarding_houses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `boarding_houses` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) unsigned NOT NULL,
  `name` varchar(255) NOT NULL COMMENT 'tên cơ sở trọ',
  `district` varchar(255) NOT NULL COMMENT 'Quận/phường',
  `address_detail` varchar(255) NOT NULL COMMENT 'địa chỉ chi tiết',
  `latitude` decimal(10,8) DEFAULT NULL,
  `longitude` decimal(11,8) DEFAULT NULL,
  `contract_images` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT 'đường dẫn mảng ảnh hợp đồng' CHECK (json_valid(`contract_images`)),
  `room_images` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT 'đường dẫn ảnh không gian của trọ' CHECK (json_valid(`room_images`)),
  `status` enum('pending','approved','rejected') NOT NULL DEFAULT 'pending',
  `invoice_billing_day` tinyint(4) NOT NULL DEFAULT 30 COMMENT 'Ngày chốt hóa đơn định kỳ hàng tháng (1-31)',
  `cancel_after_minutes` int(11) NOT NULL DEFAULT 30,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `directions_guide` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `boarding_houses_user_id_foreign` (`user_id`),
  CONSTRAINT `boarding_houses_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `boarding_houses`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `boarding_houses` WRITE;
/*!40000 ALTER TABLE `boarding_houses` DISABLE KEYS */;
INSERT INTO `boarding_houses` VALUES
(1,2,'Nhà trọ Nguyễn Văn Chủ','Ninh Khánh','456 Đường Lê Hồng Phong',NULL,NULL,'[\"private\\/properties\\/contracts\\/user_2_hop_dong_0_1780282532.png\"]','[\"private\\/properties\\/rooms\\/user_2_phong_tro_0_1780282532.png\"]','approved',30,30,'2026-08-25 16:49:40','2026-08-25 16:49:40',NULL),
(2,5,'Nhà trọ Hoa Lư View','Hoa Lư','123 Đường Tràng An',NULL,NULL,'[\"private\\/properties\\/contracts\\/user_5_hop_dong_0_1780282532.png\"]','[\"private\\/properties\\/rooms\\/user_5_phong_tro_0_1780282532.png\"]','approved',30,30,'2026-08-25 16:49:37','2026-08-25 16:49:37',NULL);
/*!40000 ALTER TABLE `boarding_houses` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `categories`
--

DROP TABLE IF EXISTS `categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `categories` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `icon` varchar(255) NOT NULL DEFAULT 'bi-tag',
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categories`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `categories` WRITE;
/*!40000 ALTER TABLE `categories` DISABLE KEYS */;
INSERT INTO `categories` VALUES
(1,'Phòng đơn','bi-door-closed',1,'2026-08-25 16:49:37','2026-08-25 16:49:37'),
(2,'Phòng ghép','bi-people',1,'2026-08-25 16:49:37','2026-08-25 16:49:37'),
(3,'Nhà nguyên căn','bi-house',1,'2026-08-25 16:49:37','2026-08-25 16:49:37'),
(4,'Studio','bi-building',1,'2026-08-25 16:49:37','2026-08-25 16:49:37'),
(5,'Căn hộ dịch vụ','bi-buildings',1,'2026-08-25 16:49:37','2026-08-25 16:49:37');
/*!40000 ALTER TABLE `categories` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `contacts`
--

DROP TABLE IF EXISTS `contacts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `contacts` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) unsigned DEFAULT NULL,
  `ticket_code` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `phone` varchar(255) DEFAULT NULL,
  `subject` varchar(255) DEFAULT NULL,
  `category` varchar(255) NOT NULL DEFAULT 'general',
  `message` text DEFAULT NULL,
  `status` varchar(255) NOT NULL DEFAULT 'pending',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `contacts_ticket_code_unique` (`ticket_code`),
  KEY `contacts_user_id_foreign` (`user_id`),
  CONSTRAINT `contacts_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `contacts`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `contacts` WRITE;
/*!40000 ALTER TABLE `contacts` DISABLE KEYS */;
/*!40000 ALTER TABLE `contacts` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `contract_extensions`
--

DROP TABLE IF EXISTS `contract_extensions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `contract_extensions` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `contract_id` bigint(20) unsigned NOT NULL,
  `old_end_date` date NOT NULL,
  `new_end_date` date NOT NULL,
  `old_monthly_rent` decimal(10,2) NOT NULL,
  `new_monthly_rent` decimal(10,2) NOT NULL,
  `tenant_cccd_number` varchar(255) DEFAULT NULL,
  `verified_document_paths` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`verified_document_paths`)),
  `notes` text DEFAULT NULL,
  `created_by` bigint(20) unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `contract_extensions_contract_id_foreign` (`contract_id`),
  KEY `contract_extensions_created_by_foreign` (`created_by`),
  CONSTRAINT `contract_extensions_contract_id_foreign` FOREIGN KEY (`contract_id`) REFERENCES `contracts` (`id`) ON DELETE CASCADE,
  CONSTRAINT `contract_extensions_created_by_foreign` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `contract_extensions`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `contract_extensions` WRITE;
/*!40000 ALTER TABLE `contract_extensions` DISABLE KEYS */;
/*!40000 ALTER TABLE `contract_extensions` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `contracts`
--

DROP TABLE IF EXISTS `contracts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `contracts` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `tenant_id` bigint(20) unsigned NOT NULL,
  `room_id` bigint(20) unsigned NOT NULL COMMENT 'Liên kết tới bảng rooms',
  `start_date` date NOT NULL,
  `end_date` date NOT NULL,
  `monthly_rent` decimal(10,2) NOT NULL DEFAULT 0.00 COMMENT 'giá thuê hàng tháng (thỏa thuận)',
  `deposit_amount` decimal(10,2) NOT NULL DEFAULT 0.00,
  `number_of_tenants` int(10) unsigned NOT NULL DEFAULT 1 COMMENT 'Số lượng người ở theo hợp đồng',
  `contract_file_path` varchar(255) DEFAULT NULL COMMENT 'đường dẫn file PDF hợp đồng',
  `signed_contract_image` longtext DEFAULT NULL,
  `status` enum('draft','awaiting_upload','active','signed','pending','expired','cancelled','termination_requested','terminated') DEFAULT 'draft',
  `ocr_status` varchar(255) NOT NULL DEFAULT 'pending',
  `ocr_rejection_reason` text DEFAULT NULL,
  `terms_accepted` tinyint(1) NOT NULL DEFAULT 0,
  `terms_accepted_at` timestamp NULL DEFAULT NULL,
  `cancellation_reason` text DEFAULT NULL,
  `signed_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `cancelled_by` bigint(20) unsigned DEFAULT NULL,
  `liquidated_at` timestamp NULL DEFAULT NULL,
  `deposit_refund_amount` decimal(10,2) DEFAULT NULL,
  `deposit_handling` varchar(255) DEFAULT NULL,
  `entry_elec_index` int(11) DEFAULT NULL COMMENT 'Chỉ số điện ban đầu lúc nhận phòng',
  `entry_elec_image` varchar(255) DEFAULT NULL COMMENT 'Ảnh công tơ điện ban đầu',
  `entry_water_index` int(11) DEFAULT NULL COMMENT 'Chỉ số nước ban đầu lúc nhận phòng',
  `entry_water_image` varchar(255) DEFAULT NULL COMMENT 'Ảnh công tơ nước ban đầu',
  `entry_readings_submitted_at` timestamp NULL DEFAULT NULL COMMENT 'Thời điểm gửi chỉ số ban đầu',
  PRIMARY KEY (`id`),
  KEY `contracts_tenant_id_foreign` (`tenant_id`),
  KEY `contracts_cancelled_by_foreign` (`cancelled_by`),
  CONSTRAINT `contracts_cancelled_by_foreign` FOREIGN KEY (`cancelled_by`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  CONSTRAINT `contracts_tenant_id_foreign` FOREIGN KEY (`tenant_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `contracts`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `contracts` WRITE;
/*!40000 ALTER TABLE `contracts` DISABLE KEYS */;
INSERT INTO `contracts` VALUES
(1,6,1,'2026-08-25','2027-02-25',0.00,2500000.00,1,NULL,NULL,'signed','pending',NULL,0,NULL,NULL,NULL,'2026-08-25 16:49:37','2026-08-25 16:49:37',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `contracts` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `failed_jobs`
--

DROP TABLE IF EXISTS `failed_jobs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `failed_jobs` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `uuid` varchar(255) NOT NULL,
  `connection` text NOT NULL,
  `queue` text NOT NULL,
  `payload` longtext NOT NULL,
  `exception` longtext NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `failed_jobs`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `failed_jobs` WRITE;
/*!40000 ALTER TABLE `failed_jobs` DISABLE KEYS */;
/*!40000 ALTER TABLE `failed_jobs` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `favorites`
--

DROP TABLE IF EXISTS `favorites`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `favorites` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) unsigned NOT NULL,
  `room_id` bigint(20) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `favorites_user_id_room_id_unique` (`user_id`,`room_id`),
  KEY `favorites_room_id_foreign` (`room_id`),
  CONSTRAINT `favorites_room_id_foreign` FOREIGN KEY (`room_id`) REFERENCES `rooms` (`id`) ON DELETE CASCADE,
  CONSTRAINT `favorites_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `favorites`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `favorites` WRITE;
/*!40000 ALTER TABLE `favorites` DISABLE KEYS */;
/*!40000 ALTER TABLE `favorites` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `features`
--

DROP TABLE IF EXISTS `features`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `features` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `feature_code` varchar(100) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `features_feature_code_unique` (`feature_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `features`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `features` WRITE;
/*!40000 ALTER TABLE `features` DISABLE KEYS */;
/*!40000 ALTER TABLE `features` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `floors`
--

DROP TABLE IF EXISTS `floors`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `floors` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `property_id` bigint(20) unsigned NOT NULL,
  `name` varchar(255) NOT NULL COMMENT 'Tên tầng: Tầng 1, Tầng 2...',
  `address` varchar(255) DEFAULT NULL,
  `latitude` decimal(10,8) DEFAULT NULL,
  `longitude` decimal(11,8) DEFAULT NULL,
  `sort_order` int(11) NOT NULL DEFAULT 0 COMMENT 'Thứ tự sắp xếp',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `floors_property_id_foreign` (`property_id`),
  CONSTRAINT `floors_property_id_foreign` FOREIGN KEY (`property_id`) REFERENCES `properties` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `floors`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `floors` WRITE;
/*!40000 ALTER TABLE `floors` DISABLE KEYS */;
INSERT INTO `floors` VALUES
(1,1,'Tầng 1','123 Đường Tràng An',NULL,NULL,1,'2026-08-25 16:49:37','2026-08-25 16:49:37');
/*!40000 ALTER TABLE `floors` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `invoice_details`
--

DROP TABLE IF EXISTS `invoice_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `invoice_details` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `invoice_id` bigint(20) unsigned NOT NULL,
  `service_id` bigint(20) unsigned DEFAULT NULL,
  `item_name` varchar(255) NOT NULL COMMENT 'tên khoản phí (tiền phòng, tiền điện, tiền nước',
  `old_index` int(11) DEFAULT NULL COMMENT 'chỉ số cũ đối với điện, nước',
  `new_index` int(11) DEFAULT NULL COMMENT 'chỉ số mới điện, nước',
  `meter_image_path` varchar(255) DEFAULT NULL COMMENT 'Đường dẫn ảnh chụp công tơ điện/nước lúc chốt số',
  `old_meter_image_path` varchar(255) DEFAULT NULL COMMENT 'Đường dẫn ảnh chụp công tơ điện/nước kỳ cũ',
  `quantity` int(11) NOT NULL DEFAULT 1 COMMENT 'Số lượng tiêu thụ',
  `price` decimal(10,2) NOT NULL COMMENT 'đơn giá tại thời điểm chốt',
  `subtotal` decimal(10,2) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `invoice_details_invoice_id_foreign` (`invoice_id`),
  KEY `invoice_details_service_id_foreign` (`service_id`),
  CONSTRAINT `invoice_details_invoice_id_foreign` FOREIGN KEY (`invoice_id`) REFERENCES `invoices` (`id`) ON DELETE CASCADE,
  CONSTRAINT `invoice_details_service_id_foreign` FOREIGN KEY (`service_id`) REFERENCES `services` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `invoice_details`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `invoice_details` WRITE;
/*!40000 ALTER TABLE `invoice_details` DISABLE KEYS */;
INSERT INTO `invoice_details` VALUES
(1,1,NULL,'Tiền thuê nhà tháng này',NULL,NULL,NULL,NULL,1,2500000.00,2500000.00,'2026-08-25 16:49:37','2026-08-25 16:49:37'),
(2,1,1,'Tiền Điện',1200,1250,'uploads/meters/dien_thang5_2026.jpg',NULL,50,3500.00,175000.00,'2026-08-25 16:49:37','2026-08-25 16:49:37'),
(3,1,3,'Internet Wifi',NULL,NULL,NULL,NULL,1,50000.00,50000.00,'2026-08-25 16:49:37','2026-08-25 16:49:37');
/*!40000 ALTER TABLE `invoice_details` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `invoices`
--

DROP TABLE IF EXISTS `invoices`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `invoices` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `contract_id` bigint(20) unsigned NOT NULL,
  `invoice_code` varchar(255) NOT NULL COMMENT 'mã hoá đơn tự động tạo',
  `billing_month` varchar(7) NOT NULL COMMENT 'Tháng thu tiền định dạng YYYY-MM',
  `total_amount` decimal(10,2) NOT NULL DEFAULT 0.00,
  `paid_amount` decimal(10,2) NOT NULL DEFAULT 0.00,
  `status` enum('unpaid','partially_paid','paid','overdue') DEFAULT 'unpaid',
  `due_date` date NOT NULL COMMENT 'hạn chót thanh toán',
  `paid_at` timestamp NULL DEFAULT NULL,
  `archived_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `invoices_invoice_code_unique` (`invoice_code`),
  KEY `invoices_contract_id_foreign` (`contract_id`),
  CONSTRAINT `invoices_contract_id_foreign` FOREIGN KEY (`contract_id`) REFERENCES `contracts` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `invoices`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `invoices` WRITE;
/*!40000 ALTER TABLE `invoices` DISABLE KEYS */;
INSERT INTO `invoices` VALUES
(1,1,'HD-202608-001','2026-08',2725000.00,0.00,'unpaid','2026-09-01',NULL,NULL,'2026-08-25 16:49:37','2026-08-25 16:49:37');
/*!40000 ALTER TABLE `invoices` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `landlord_availabilities`
--

DROP TABLE IF EXISTS `landlord_availabilities`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `landlord_availabilities` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `landlord_id` bigint(20) unsigned NOT NULL,
  `boarding_house_id` bigint(20) unsigned NOT NULL,
  `day_of_week` tinyint(4) NOT NULL COMMENT '0: Chủ nhật, 1: Thứ 2, ..., 6: Thứ 7',
  `start_time` time NOT NULL,
  `end_time` time NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `landlord_availabilities_landlord_id_foreign` (`landlord_id`),
  KEY `landlord_availabilities_boarding_house_id_foreign` (`boarding_house_id`),
  CONSTRAINT `landlord_availabilities_boarding_house_id_foreign` FOREIGN KEY (`boarding_house_id`) REFERENCES `boarding_houses` (`id`) ON DELETE CASCADE,
  CONSTRAINT `landlord_availabilities_landlord_id_foreign` FOREIGN KEY (`landlord_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `landlord_availabilities`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `landlord_availabilities` WRITE;
/*!40000 ALTER TABLE `landlord_availabilities` DISABLE KEYS */;
/*!40000 ALTER TABLE `landlord_availabilities` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `landlord_subscriptions`
--

DROP TABLE IF EXISTS `landlord_subscriptions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `landlord_subscriptions` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) unsigned NOT NULL,
  `plan_id` bigint(20) unsigned NOT NULL,
  `payment_code` varchar(50) DEFAULT NULL,
  `price_at_purchase` decimal(12,2) NOT NULL DEFAULT 0.00,
  `start_date` date DEFAULT NULL,
  `end_date` date DEFAULT NULL,
  `proof_image` varchar(255) DEFAULT NULL,
  `payment_method` varchar(50) NOT NULL DEFAULT 'vietqr',
  `status` varchar(30) NOT NULL DEFAULT 'pending' COMMENT 'pending|active|rejected|expired',
  `admin_note` text DEFAULT NULL,
  `approved_by` bigint(20) unsigned DEFAULT NULL,
  `approved_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `landlord_subscriptions_payment_code_unique` (`payment_code`),
  KEY `landlord_subscriptions_user_id_foreign` (`user_id`),
  KEY `landlord_subscriptions_plan_id_foreign` (`plan_id`),
  KEY `landlord_subscriptions_approved_by_foreign` (`approved_by`),
  CONSTRAINT `landlord_subscriptions_approved_by_foreign` FOREIGN KEY (`approved_by`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  CONSTRAINT `landlord_subscriptions_plan_id_foreign` FOREIGN KEY (`plan_id`) REFERENCES `subscription_plans` (`id`) ON DELETE CASCADE,
  CONSTRAINT `landlord_subscriptions_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `landlord_subscriptions`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `landlord_subscriptions` WRITE;
/*!40000 ALTER TABLE `landlord_subscriptions` DISABLE KEYS */;
/*!40000 ALTER TABLE `landlord_subscriptions` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `maintenance_requests`
--

DROP TABLE IF EXISTS `maintenance_requests`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `maintenance_requests` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `room_id` bigint(20) unsigned NOT NULL COMMENT 'Liên kết tới bảng rooms',
  `tenant_id` bigint(20) unsigned NOT NULL,
  `title` varchar(255) NOT NULL,
  `description` text NOT NULL,
  `image_path` varchar(255) DEFAULT NULL COMMENT 'Hình ảnh chụp sự cố hư hỏng',
  `status` enum('pending','in_progress','resolved','cancelled') NOT NULL DEFAULT 'pending',
  `repair_cost` decimal(10,2) DEFAULT NULL COMMENT 'Chi phí sửa chữa nếu có',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `maintenance_requests_tenant_id_foreign` (`tenant_id`),
  CONSTRAINT `maintenance_requests_tenant_id_foreign` FOREIGN KEY (`tenant_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `maintenance_requests`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `maintenance_requests` WRITE;
/*!40000 ALTER TABLE `maintenance_requests` DISABLE KEYS */;
INSERT INTO `maintenance_requests` VALUES
(1,1,6,'Hỏng vòi hoa sen','Vòi hoa sen trong nhà tắm bị rỉ nước mạnh, nhờ chủ nhà qua sửa giúp.',NULL,'pending',NULL,'2026-08-25 16:49:37','2026-08-25 16:49:37');
/*!40000 ALTER TABLE `maintenance_requests` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `migrations`
--

DROP TABLE IF EXISTS `migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `migrations` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `migration` varchar(255) NOT NULL,
  `batch` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=88 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `migrations`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `migrations` WRITE;
/*!40000 ALTER TABLE `migrations` DISABLE KEYS */;
INSERT INTO `migrations` VALUES
(1,'2014_10_12_000000_create_users_table',1),
(2,'2014_10_12_100000_create_password_reset_tokens_table',1),
(3,'2019_08_19_000000_create_failed_jobs_table',1),
(4,'2019_12_14_000001_create_personal_access_tokens_table',1),
(5,'2026_05_19_000001_change_role_to_string_in_users_table',1),
(6,'2026_05_25_150935_create_properties',1),
(7,'2026_05_25_151000_create_boarding_houses_table',1),
(8,'2026_05_25_151100_create_floors_and_update_rooms',1),
(9,'2026_05_25_151200_create_rooms_table',1),
(10,'2026_05_25_151854_create_contracts',1),
(11,'2026_05_25_152658_create_services',1),
(12,'2026_05_25_153300_create_invoices',1),
(13,'2026_05_25_153820_create_invoice_details',1),
(14,'2026_05_25_154852_create_maintenance_requests',1),
(15,'2026_05_25_155218_create_reviews',1),
(16,'2026_05_26_014733_add_google_id_to_users_table',1),
(17,'2026_05_26_100000_create_categories_table',1),
(18,'2026_05_26_100001_create_areas_table',1),
(19,'2026_05_26_100002_create_amenities_table',1),
(20,'2026_05_26_120000_add_map_embed_to_areas_table',1),
(21,'2026_05_26_143209_create_user_verifications_table',1),
(22,'2026_06_01_032141_add_otp_columns_to_users_table',1),
(23,'2026_06_01_050203_add_status_to_users_table',1),
(24,'2026_06_02_022155_create_notifications_table',1),
(25,'2026_06_02_044451_add_profile_fields_to_users_table',1),
(26,'2026_06_02_044927_add_under_construction_to_rooms_status_enum',1),
(27,'2026_06_02_072148_add_avatar_to_users_table',1),
(28,'2026_06_02_075212_add_address_to_rooms_table',1),
(29,'2026_06_02_080000_update_rooms_status_enum',1),
(30,'2026_06_04_012013_add_last_profile_update_at_to_users_table',1),
(31,'2026_06_09_045719_add_maintenance_reason_to_rooms_table',1),
(32,'2026_06_11_040149_add_current_people_to_rooms_table',1),
(33,'2026_06_14_143630_add_gps_to_boarding_houses_table',1),
(34,'2026_06_17_074114_add_icon_color_status_to_services_table',1),
(35,'2026_06_17_092314_create_room_service_table',1),
(36,'2026_06_17_152744_create_room_posts_table',1),
(37,'2026_06_19_095920_add_draft_status_to_room_posts_table',1),
(38,'2026_06_21_151852_add_landlord_id_to_room_posts_table',1),
(39,'2026_06_23_125811_create_posts_table',1),
(40,'2026_06_27_042933_alter_reviews_table_for_boarding_houses',1),
(41,'2026_06_28_154320_add_gps_to_rooms_table',1),
(42,'2026_06_28_161500_move_gps_from_rooms_to_floors',1),
(43,'2026_07_01_020249_add_bank_details_to_users_table',1),
(44,'2026_07_02_140000_create_appointments_table',1),
(45,'2026_07_02_150000_create_favorites_table',1),
(46,'2026_07_03_154222_add_cancellation_reason_to_appointments_table',1),
(47,'2026_07_05_075634_create_landlord_availabilities_table',1),
(48,'2026_07_08_152435_add_feedback_fields_to_appointments_table',1),
(49,'2026_07_10_160321_change_status_type_in_appointments_table',1),
(50,'2026_07_11_104720_add_cancel_after_minutes_to_boarding_houses_table',1),
(51,'2026_07_11_134444_update_contracts_table_for_registration',1),
(52,'2026_07_12_084049_add_last_seen_at_to_users_table',1),
(53,'2026_07_12_140759_alter_reviews_table_for_appointments',1),
(54,'2026_07_13_025105_create_settings_table',1),
(55,'2026_07_13_073541_change_signed_contract_image_to_text_in_contracts_table',1),
(56,'2026_07_18_032124_add_directions_guide_to_boarding_houses_table',1),
(57,'2026_07_20_084100_add_archived_at_and_old_meter_image',1),
(58,'2026_07_22_012016_create_room_post_views_table',1),
(59,'2026_07_22_083753_create_reports_table',1),
(60,'2026_07_23_173600_add_due_date_to_invoices_table',1),
(61,'2026_07_23_174000_drop_due_table_from_invoices_table',1),
(62,'2026_07_23_174500_add_indexes_to_invoice_details_table',1),
(63,'2026_07_24_065945_create_report_reasons_table',1),
(64,'2026_07_24_101000_add_invoice_billing_day_to_boarding_houses_table',1),
(65,'2026_07_25_000001_add_ocr_legal_and_liquidation_to_contracts_table',1),
(66,'2026_07_25_000002_create_contract_extensions_table',1),
(67,'2026_07_25_041104_create_audit_logs_table',1),
(68,'2026_07_27_000000_add_entry_meter_readings_to_contracts_table',1),
(69,'2026_07_29_000001_add_termination_requested_to_contracts_table',1),
(70,'2026_07_30_024035_create_property_managers_table',1),
(71,'2026_08_01_035950_add_boarding_house_id_to_services_table',1),
(72,'2026_08_02_000001_add_number_of_tenants_to_contracts_table',1),
(73,'2026_08_04_161320_create_room_residents_table',1),
(74,'2026_08_06_012028_create_roommate_requests_table',1),
(75,'2026_08_11_111952_add_fcm_token_to_users_table',1),
(76,'2026_08_11_120000_add_amenity_id_to_services_table',1),
(77,'2026_08_11_121000_create_contacts_table',1),
(78,'2026_08_12_033014_create_subscriptions-tables',1),
(79,'2026_08_15_162000_add_fields_to_contacts_table',1),
(80,'2026_08_18_000000_add_price_to_room_service_table',1),
(81,'2026_08_18_000001_add_price_updated_at_to_services_table',1),
(82,'2026_08_18_000001_create_ai_chat_histories_table',1),
(83,'2026_08_19_000002_add_boarding_house_id_to_rooms_table',1),
(84,'2026_08_19_000003_add_proof_image_to_landlord_subscriptions_table',1),
(85,'2026_08_20_150000_add_paid_amount_and_partially_paid_to_invoices_table',1),
(86,'2026_08_24_150431_add_is_visible_to_reviews_table',1),
(87,'2026_08_24_150749_add_lock_reason_to_users_table',1);
/*!40000 ALTER TABLE `migrations` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `notifications`
--

DROP TABLE IF EXISTS `notifications`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `notifications` (
  `id` char(36) NOT NULL,
  `type` varchar(255) NOT NULL,
  `notifiable_type` varchar(255) NOT NULL,
  `notifiable_id` bigint(20) unsigned NOT NULL,
  `data` text NOT NULL,
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

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `notifications` WRITE;
/*!40000 ALTER TABLE `notifications` DISABLE KEYS */;
/*!40000 ALTER TABLE `notifications` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `password_reset_tokens`
--

DROP TABLE IF EXISTS `password_reset_tokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `password_reset_tokens` (
  `email` varchar(255) NOT NULL,
  `token` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `password_reset_tokens`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `password_reset_tokens` WRITE;
/*!40000 ALTER TABLE `password_reset_tokens` DISABLE KEYS */;
/*!40000 ALTER TABLE `password_reset_tokens` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `personal_access_tokens`
--

DROP TABLE IF EXISTS `personal_access_tokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `personal_access_tokens` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `tokenable_type` varchar(255) NOT NULL,
  `tokenable_id` bigint(20) unsigned NOT NULL,
  `name` varchar(255) NOT NULL,
  `token` varchar(64) NOT NULL,
  `abilities` text DEFAULT NULL,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `expires_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `personal_access_tokens`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `personal_access_tokens` WRITE;
/*!40000 ALTER TABLE `personal_access_tokens` DISABLE KEYS */;
/*!40000 ALTER TABLE `personal_access_tokens` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `posts`
--

DROP TABLE IF EXISTS `posts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `posts` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `slug` varchar(255) NOT NULL,
  `image` varchar(255) DEFAULT NULL,
  `summary` text DEFAULT NULL,
  `content` longtext NOT NULL,
  `category` varchar(255) NOT NULL DEFAULT 'Tin Tức',
  `tags` varchar(255) DEFAULT NULL,
  `author_id` bigint(20) unsigned NOT NULL,
  `views` int(10) unsigned NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `posts_slug_unique` (`slug`),
  KEY `posts_author_id_foreign` (`author_id`),
  CONSTRAINT `posts_author_id_foreign` FOREIGN KEY (`author_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `posts`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `posts` WRITE;
/*!40000 ALTER TABLE `posts` DISABLE KEYS */;
INSERT INTO `posts` VALUES
(1,'Top 5 Homestay view đẹp nhất tại Tràng An, Ninh Bình','top-5-homestay-view-dep-nhat-tai-trang-an-ninh-binh','https://images.unsplash.com/photo-1540555700478-4be289fbecef?auto=format&fit=crop&w=800&q=80','Khám phá ngay danh sách 5 homestay có tầm nhìn tuyệt đẹp hướng ra danh thắng Tràng An, giúp bạn có kỳ nghỉ dưỡng trọn vẹn và nhiều ảnh check-in cực chất.','<p>Ninh Bình luôn là điểm đến hấp dẫn du khách trong và ngoài nước bởi vẻ đẹp kỳ vĩ của sông núi, hang động. Để hành trình khám phá vùng đất cố đô thêm phần trọn vẹn, việc lựa chọn một nơi lưu trú có không gian đẹp, gần gũi thiên nhiên là vô cùng quan trọng. Dưới đây là danh sách 5 homestay view đẹp nhất tại khu vực Tràng An mà bạn không nên bỏ lỡ.</p>\n                <h4>1. Tràng An River View Homestay</h4>\n                <p>Nằm ngay bên dòng sông sào khê thơ mộng, Tràng An River View mang lại cảm giác bình yên đến lạ kỳ. Buổi sáng thức dậy, bạn có thể phóng tầm mắt ngắm nhìn sương mờ bảng lảng trên các dãy núi đá vôi dựng đứng.</p>\n                <h4>2. Ninh Bình Valley Homestay</h4>\n                <p>Nổi tiếng với thiết kế hòa quyện vào thung lũng, đây là địa điểm lý tưởng cho những ai muốn lánh xa khói bụi thành thị. Các phòng nghỉ dạng bungalow tre nứa mộc mạc nhưng đầy đủ tiện nghi.</p>\n                <h4>3. Hoa Lu Eco Homestay</h4>\n                <p>Tọa lạc gần cố đô Hoa Lư cổ kính, homestay này sở hữu không gian sân vườn rộng rãi và hướng núi tuyệt đẹp. Đội ngũ nhân viên thân thiện và các món ăn đặc sản Ninh Bình tại đây luôn được đánh giá cao.</p>','Tin Tức','Ninh Binh, Homestay, Du Lich, Trang An',1,125,'2026-08-15 16:49:40','2026-08-15 16:49:40'),
(2,'Kinh nghiệm thuê phòng trọ giá rẻ cho sinh viên tại Ninh Bình','kinh-nghiem-thue-phong-tro-gia-re-cho-sinh-vien-tai-ninh-binh','https://images.unsplash.com/photo-1522771739844-6a9f6d5f14af?auto=format&fit=crop&w=800&q=80','Hướng dẫn chi tiết các bước tìm phòng trọ, kinh nghiệm thương lượng giá cả, đọc hợp đồng thuê nhà để tránh những rủi ro không đáng có cho tân sinh viên.','<p>Tìm kiếm một căn phòng trọ ưng ý, giá cả phải chăng luôn là thử thách lớn đối với các bạn sinh viên, đặc biệt là những bạn tân sinh viên mới nhập học tại các trường Cao đẳng, Đại học ở Ninh Bình. Bài viết dưới đây sẽ chia sẻ một số kinh nghiệm quý báu giúp các bạn tìm được phòng trọ như ý.</p>\n                <h4>1. Xác định khu vực tìm kiếm phòng trọ</h4>\n                <p>Nên ưu tiên các phòng trọ nằm gần trường học hoặc các tuyến xe bus thuận tiện. Khu vực gần trường Đại học Hoa Lư thường có mức giá phòng đa dạng phù hợp túi tiền sinh viên.</p>\n                <h4>2. Kiểm tra kỹ cơ sở vật chất trước khi đặt cọc</h4>\n                <p>Hãy đảm bảo hệ thống điện, nước, nhà vệ sinh hoạt động bình thường. Đọc kỹ đồng hồ điện nước và chụp ảnh lại làm bằng chứng để tránh tranh chấp chỉ số sau này.</p>\n                <h4>3. Đọc kỹ hợp đồng thuê nhà</h4>\n                <p>Hợp đồng cần thể hiện rõ thông tin tiền đặt cọc, tiền thuê hàng tháng, chi phí dịch vụ (WiFi, rác, điện, nước) và thời hạn thông báo trước khi chuyển đi (thường là 30 ngày).</p>','Tin Tức','Sinh Vien, Phong Tro, Gia Re, Kinh Nghiem',1,340,'2026-08-16 16:49:40','2026-08-16 16:49:40'),
(3,'Tuyển dụng nhân viên lễ tân Homestay tại Tam Cốc - Bích Động','tuyen-dung-nhan-vien-le-tan-homestay-tai-tam-coc-bich-dong','https://images.unsplash.com/photo-1556742049-0cfed4f6a45d?auto=format&fit=crop&w=800&q=80','Cơ hội việc làm hấp dẫn cho các bạn trẻ năng động, yêu thích ngành du lịch - khách sạn tại Ninh Bình. Yêu cầu giao tiếp tiếng Anh cơ bản.','<p>Homestay Tam Cốc Green View đang cần tuyển gấp 02 nhân viên lễ tân ca ngày và ca đêm làm việc tại khu vực Tam Cốc, Hoa Lư, Ninh Bình.</p>\n                <h4>Mô tả công việc:</h4>\n                <ul>\n                    <li>Thực hiện thủ tục check-in, check-out cho khách lưu trú (chủ yếu là khách nước ngoài).</li>\n                    <li>Tư vấn lịch trình tham quan, đặt vé xe, dịch vụ thuê xe cho khách hàng.</li>\n                    <li>Giải đáp các thắc mắc và hỗ trợ khách hàng trong thời gian lưu trú.</li>\n                </ul>\n                <h4>Yêu cầu công việc:</h4>\n                <ul>\n                    <li>Nhanh nhẹn, trung thực, có thái độ làm việc tốt.</li>\n                    <li>Giao tiếp tiếng Anh cơ bản (sẽ được đào tạo thêm).</li>\n                    <li>Ưu tiên ứng viên có kinh nghiệm làm lễ tân hoặc có hộ khẩu tại Ninh Bình.</li>\n                </ul>\n                <h4>Quyền lợi được hưởng:</h4>\n                <ul>\n                    <li>Mức lương hấp dẫn: 5.000.000đ - 7.000.000đ + thưởng doanh thu dịch vụ.</li>\n                    <li>Môi trường làm việc năng động, nâng cao khả năng giao tiếp ngoại ngữ.</li>\n                    <li>Hỗ trợ ăn ca tại Homestay.</li>\n                </ul>','Việc Làm','Viec Lam, Le Tan, Tam Coc, Tuyen Dung',1,89,'2026-08-17 16:49:40','2026-08-17 16:49:40'),
(4,'Những lưu ý quan trọng khi ký hợp đồng thuê nhà mà bạn cần biết','nhung-luu-y-quan-trong-khi-ky-hop-dong-thue-nha-ma-ban-can-biet','https://images.unsplash.com/photo-1450133064473-71024230f91b?auto=format&fit=crop&w=800&q=80','Các điều khoản pháp lý quan trọng, tiền đặt cọc, quyền hạn của người thuê và chủ nhà mà bạn bắt buộc phải kiểm tra kỹ trước khi ký tên.','<p>Ký hợp đồng thuê nhà là một bước pháp lý cực kỳ quan trọng để bảo vệ quyền lợi của cả chủ nhà và người đi thuê. Tuy nhiên, rất nhiều bạn thường bỏ qua các chi tiết nhỏ dẫn đến những tranh chấp không đáng có.</p>\n                <h4>1. Xác định rõ tiền cọc và cách thức hoàn trả</h4>\n                <p>Số tiền cọc là bao nhiêu tháng thuê? Khi kết thúc hợp đồng hoặc chuyển đi trước hạn thì điều kiện hoàn trả cọc như thế nào? Tất cả phải ghi rõ bằng văn bản.</p>\n                <h4>2. Thời gian và phương thức thanh toán tiền nhà</h4>\n                <p>Cần làm rõ đóng tiền nhà vào ngày nào trong tháng, hình thức chuyển khoản hay tiền mặt, và có phát sinh phạt nếu trả chậm hay không.</p>\n                <h4>3. Trách nhiệm bảo trì và sửa chữa thiết bị</h4>\n                <p>Thông thường, các hư hỏng tự nhiên lớn (mái dột, tường thấm, hỏng đường ống nước âm tường) chủ nhà phải sửa. Còn các hư hỏng nhỏ do hao mòn sử dụng (hỏng bóng đèn, vỡ kính) người thuê tự khắc phục.</p>','Tin Tức','Hop Dong, Phap Ly, Thue Nha, Kinh Nghiem',1,210,'2026-08-18 16:49:40','2026-08-18 16:49:40'),
(5,'Cẩm nang du lịch Ninh Bình tự túc 2 ngày 1 đêm tiết kiệm nhất','cam-nang-du-lich-ninh-binh-tu-tuc-2-ngay-1-dem-tiet-kiem-nhat','https://images.unsplash.com/photo-1528127269322-539801943592?auto=format&fit=crop&w=800&q=80','Chia sẻ lịch trình chi tiết, gợi ý phương tiện di chuyển, địa điểm ăn uống, nghỉ dưỡng lý tưởng cho chuyến du lịch Ninh Bình trọn vẹn.','<p>Ninh Bình chỉ cách Hà Nội khoảng 100km, rất thích hợp cho những chuyến phượt ngắn ngày vào cuối tuần. Hãy bỏ túi ngay cẩm nang du lịch tự túc cực kỳ tiết kiệm sau đây.</p>\n                <h4>Lịch trình Ngày 1: Tràng An - Hang Múa</h4>\n                <p>Sáng: Xuất phát từ Hà Nội bằng xe máy hoặc xe limousine. Đến Ninh Bình check-in phòng nghỉ, thuê xe máy đi Tràng An trải nghiệm chèo đò ngắm hang động hùng vĩ. Chiều: Leo đỉnh Hang Múa ngắm toàn cảnh thung lũng lúa chín từ trên cao.</p>\n                <h4>Lịch trình Ngày 2: Chùa Bái Đính - Đầm Vân Long</h4>\n                <p>Sáng: Viếng chùa Bái Đính - ngôi chùa sở hữu nhiều kỷ lục châu Á. Chiều: Khám phá khu bảo tồn thiên nhiên Đầm Vân Long thanh bình trước khi lên xe quay trở về.</p>','Tin Tức','Du Lich, Phuot, Ninh Binh, Tiet Kiem',1,450,'2026-08-19 16:49:40','2026-08-19 16:49:40'),
(6,'Tuyển dụng nhân viên buồng phòng Homestay tại Hoa Lư','tuyen-dung-nhan-vien-buong-phong-homestay-tai-hoa-lu','https://images.unsplash.com/photo-1582719508461-905c673771fd?auto=format&fit=crop&w=800&q=80','Tuyển gấp nhân viên dọn dẹp buồng phòng homestay tại Hoa Lư, làm việc xoay ca linh hoạt, có hỗ trợ nhà ở cho nhân viên ở xa.','<p>Do nhu cầu mở rộng dịch vụ đón khách mùa hè, Homestay Mountain View Ninh Bình cần tuyển dụng 03 nhân viên buồng phòng.</p>\n                <h4>Công việc chính:</h4>\n                <ul>\n                    <li>Dọn dẹp, chuẩn bị phòng nghỉ sạch sẽ trước khi khách check-in và sau khi check-out.</li>\n                    <li>Thay ga trải giường, vỏ gối, bổ sung khăn tắm và các vật phẩm cá nhân vào phòng nghỉ.</li>\n                    <li>Báo cáo kịp thời các thiết bị hư hỏng trong phòng nghỉ cho quản lý.</li>\n                </ul>\n                <h4>Yêu cầu:</h4>\n                <ul>\n                    <li>Sức khỏe tốt, chăm chỉ, tỉ mỉ, có trách nhiệm trong công việc.</li>\n                    <li>Không yêu cầu bằng cấp hay ngoại ngữ, sẽ được hướng dẫn công việc bài bản.</li>\n                </ul>','Việc Làm','Buong Phong, Viec Lam, Hoa Lu, Tuyen Dung',1,75,'2026-08-20 16:49:40','2026-08-20 16:49:40'),
(7,'Các địa điểm ăn vặt ngon rẻ không thể bỏ qua tại thành phố Ninh Bình','cac-dia-diem-an-vat-ngon-re-khong-the-bo-qua-tai-thanh-pho-ninh-binh','https://images.unsplash.com/photo-1563379091339-03b21ab4a4f8?auto=format&fit=crop&w=800&q=80','Điểm danh những món ăn đường phố nổi tiếng và địa chỉ các quán ăn vặt vừa ngon vừa túi tiền cho học sinh, sinh viên tại Ninh Bình.','<p>Bên cạnh các món dê núi cơm cháy nổi tiếng, ẩm thực đường phố tại Ninh Bình cũng vô cùng phong phú và có mức giá cực kỳ học sinh sinh viên. Cùng điểm qua một số địa chỉ ăn vặt nổi bật.</p>\n                <h4>1. Phố ăn vặt cổng trường Đại học Hoa Lư</h4>\n                <p>Nơi đây tập trung vô vàn các xe đồ ăn nhanh như bánh tráng trộn, trà sữa, xiên nướng, bánh mì muối ớt... với mức giá chỉ từ 10.000đ.</p>\n                <h4>2. Bánh tráng nướng cổng Chùa Vàng</h4>\n                <p>Không gian rộng rãi, thoáng mát, thích hợp tụ tập bạn bè vào buổi tối. Bánh tráng nướng nóng hổi giòn rụm kết hợp với sữa đậu nành mát lạnh là combo tuyệt vời.</p>','Tin Tức','An Vat, Sinh Vien, Ngon Re, Am Thuc',1,520,'2026-08-21 16:49:40','2026-08-21 16:49:40'),
(8,'Tuyển dụng hướng dẫn viên du lịch nội địa tại Tràng An','tuyen-dung-huong-dan-vien-du-lich-noi-dia-tai-trang-an','https://images.unsplash.com/photo-1527631746610-bca00a040d60?auto=format&fit=crop&w=800&q=80','Công ty du lịch nội địa tuyển hướng dẫn viên dẫn các tour du lịch Ninh Bình - Tràng An - Bái Đính, yêu cầu am hiểu văn hóa địa phương.','<p>Công ty TNHH Lữ hành Tràng An Tour tuyển dụng nhân sự Hướng dẫn viên du lịch nội địa làm việc tại Ninh Bình.</p>\n                <h4>Nhiệm vụ:</h4>\n                <ul>\n                    <li>Dẫn đoàn khách tham quan các danh thắng nổi tiếng tại Ninh Bình theo lịch trình có sẵn.</li>\n                    <li>Thuyết minh, giới thiệu các giá trị văn hóa, lịch sử đặc sắc của địa phương cho khách du lịch.</li>\n                    <li>Chăm sóc, đảm bảo an toàn và hỗ trợ nhu cầu của khách trong suốt hành trình.</li>\n                </ul>\n                <h4>Yêu cầu:</h4>\n                <ul>\n                    <li>Có thẻ hướng dẫn viên du lịch nội địa hoặc quốc tế còn hạn.</li>\n                    <li>Giao tiếp tự tin, giọng nói truyền cảm, không ngọng, nói lắp.</li>\n                </ul>','Việc Làm','Huong Dan Vien, Du Lich, Viec Lam, Tuyen Dung',1,140,'2026-08-22 16:49:40','2026-08-22 16:49:40'),
(9,'Tải mẫu biên bản bàn giao thiết bị phòng trọ tiêu chuẩn mới nhất','tai-mau-bien-ban-ban-giao-thiet-bi-phong-tro-tieu-chuan-moi-nhat','https://images.unsplash.com/photo-1586281380349-632531db7ed4?auto=format&fit=crop&w=800&q=80','Tải ngay mẫu biên bản bàn giao tài sản, đồ đạc trong phòng trọ khi bắt đầu thuê để bảo vệ quyền lợi của cả chủ nhà và người thuê.','<p>Khi nhận phòng trọ mới, việc lập biên bản kiểm tra và bàn giao thiết bị hiện có là bước đệm pháp lý thiết yếu. Điều này giúp hai bên xác định rõ hiện trạng vật chất tại thời điểm bắt đầu thuê, tránh việc đền bù oan khi chuyển đi.</p>\n                <h4>Biên bản cần bao gồm:</h4>\n                <ul>\n                    <li>Thông tin người bàn giao (chủ nhà) và người nhận bàn giao (người thuê).</li>\n                    <li>Danh sách chi tiết thiết bị kèm hiện trạng (ví dụ: máy lạnh hiệu Daikin hoạt động tốt, tủ lạnh Hitachi bị xước nhẹ ở cửa, tường phòng ngủ có 1 vết ố...).</li>\n                    <li>Chữ ký xác nhận của hai bên.</li>\n                </ul>','Tin Tức','Tai Lieu, Mau Don, Bien Ban, Phong Tro',1,95,'2026-08-23 16:49:40','2026-08-23 16:49:40'),
(10,'Tuyển dụng nhân viên chạy bàn cafe sân vườn tại TP. Ninh Bình','tuyen-dung-nhan-vien-chay-ban-cafe-san-vuon-tai-tp-ninh-binh','https://images.unsplash.com/photo-1501339847302-ac426a4a7cbb?auto=format&fit=crop&w=800&q=80','Tuyển nhân viên phục vụ, chạy bàn bán thời gian hoặc toàn thời gian cho quán cafe phong cách sân vườn tại trung tâm TP. Ninh Bình.','<p>Quán Cố Đô Cafe cần tuyển dụng 04 bạn nhân viên phục vụ chạy bàn ca sáng và ca tối.</p>\n                <h4>Thời gian làm việc:</h4>\n                <ul>\n                    <li>Ca sáng: 07h00 - 12h00</li>\n                    <li>Ca tối: 17h30 - 22h30</li>\n                </ul>\n                <h4>Mức lương:</h4>\n                <ul>\n                    <li>Lương thỏa thuận: từ 20.000đ - 25.000đ/giờ + thưởng doanh số cuối tháng.</li>\n                </ul>','Việc Làm','Cafe, Phuc Vu, Viec Lam, Ban Thoi Gian',1,112,'2026-08-24 16:49:40','2026-08-24 16:49:40'),
(11,'Tuyển dụng nhân viên kế toán Homestay tại Hoa Lư, Ninh Bình','tuyen-dung-nhan-vien-ke-toan-homestay-tai-hoa-lu-ninh-binh','https://images.unsplash.com/photo-1554224155-8d04cb21cd6c?auto=format&fit=crop&w=800&q=80','Tuyển nhân viên kế toán nội bộ làm việc tại văn phòng homestay ở Tràng An, yêu cầu biết sử dụng phần mềm Misa và Excel cơ bản.','<p>Homestay Tràng An Retreat cần tuyển gấp 01 nhân viên kế toán nội bộ.</p>\n                <h4>Yêu cầu:</h4>\n                <ul>\n                    <li>Tốt nghiệp Cao đẳng/Đại học chuyên ngành kế toán, tài chính.</li>\n                    <li>Sử dụng thành thạo Word, Excel. Biết sử dụng phần mềm Misa là một lợi thế.</li>\n                    <li>Cẩn thận, trung thực, có tinh thần trách nhiệm.</li>\n                </ul>\n                <h4>Quyền lợi:</h4>\n                <ul>\n                    <li>Mức lương: 6.500.000đ - 8.000.000đ tùy năng lực.</li>\n                    <li>Đóng BHXH đầy đủ theo luật lao động.</li>\n                </ul>','Việc Làm','Ke Toan, Viec Lam, Hoa Lu, Tuyen Dung',1,64,'2026-08-24 16:49:40','2026-08-24 16:49:40'),
(12,'Chia sẻ 5 quán cơm cháy ngon nhất định phải thử ở Ninh Bình','chia-se-5-quan-com-chay-ngon-nhat-dinh-phai-thu-o-ninh-binh','https://images.unsplash.com/photo-1611143669185-af224c5e3252?auto=format&fit=crop&w=800&q=80','Khám phá bản đồ ẩm thực cố đô với 5 địa chỉ quán cơm cháy chà bông thơm ngon giòn rụm nổi tiếng nhất được người bản địa khuyên dùng.','<p>Cơm cháy là món đặc sản Ninh Bình nổi tiếng nhất. Hãy cùng khám phá 5 địa chỉ mua cơm cháy giòn rụm, chà bông ngập tràn được người dân địa phương vô cùng yêu thích.</p>\n                <h4>1. Cơm cháy Cổ Hoàng</h4>\n                <p>Nổi tiếng với nước sốt dê gia truyền đi kèm cơm cháy giòn tan.</p>\n                <h4>2. Cơm cháy Đại Long</h4>\n                <p>Thương hiệu đóng gói sẵn nổi tiếng, phù hợp mua làm quà tặng du lịch.</p>','Tin Tức','Com Chay, Dac San, Ninh Binh, Am Thuc',1,198,'2026-08-24 16:49:40','2026-08-24 16:49:40'),
(13,'Kế hoạch tổ chức tuần lễ du lịch Sắc Vàng Tam Cốc năm nay','ke-hoach-to-chức-tuan-le-du-lich-sac-vang-tam-coc-nam-nay','https://images.unsplash.com/photo-1508739773434-c26b3d09e071?auto=format&fit=crop&w=800&q=80','Cập nhật thời gian khai mạc, lịch trình chi tiết và các hoạt động văn hóa nghệ thuật đặc sắc diễn ra tại Tam Cốc Ninh Bình trong tuần lễ vàng.','<p>Tuần lễ du lịch Ninh Bình với chủ đề \"Sắc vàng Tam Cốc - Tràng An\" là sự kiện quảng bá hình ảnh thiên nhiên, văn hóa đặc sắc của tỉnh đến bạn bè bốn phương.</p>\n                <p>Sự kiện sẽ khai mạc vào cuối tháng 5 khi các cánh đồng lúa hai bên dòng sông Ngô Đồng chín vàng ruộm. Du khách sẽ được thưởng thức trình diễn nghệ thuật múa rối nước, biểu diễn hát xẩm và chèo thuyền ngắm lúa.</p>','Tin Tức','Tam Coc, Du Lich, Sac Vang, Su Kien',1,310,'2026-08-24 16:49:40','2026-08-24 16:49:40'),
(14,'Tuyển dụng nhân viên tư vấn tour du lịch online làm việc tại nhà','tuyen-dung-nhan-vien-tu-van-tour-du-lich-online-lam-viec-tai-nha','https://images.unsplash.com/photo-1521791136368-1a883a75a31f?auto=format&fit=crop&w=800&q=80','Tuyển cộng tác viên tư vấn tour du lịch trực tuyến, hỗ trợ khách hàng đặt phòng homestay, làm việc online linh hoạt phù hợp với sinh viên kiếm thêm thu nhập.','<p>Công ty Du lịch Ninh Bình Star cần tuyển 05 cộng tác viên tư vấn và chốt sales tour online.</p>\n                <h4>Mô tả công việc:</h4>\n                <p>Tư vấn khách hàng qua Fanpage/Zalo về các gói tour du lịch Ninh Bình, hỗ trợ book phòng homestay, khách sạn. Công việc hoàn toàn làm online tại nhà.</p>\n                <h4>Quyền lợi:</h4>\n                <p>Thu nhập theo hoa hồng hấp dẫn từ 10% - 15% trên mỗi dịch vụ chốt thành công.</p>','Việc Làm','Viec Lam, Online, Tu Van, Sales Tour',1,155,'2026-08-24 16:49:40','2026-08-24 16:49:40'),
(15,'Cách tính toán chi phí điện nước phòng trọ để không bị hớ','cach-tinh-toan-chi-phi-dien-nuoc-phong-tro-de-khong-bi-ho','https://images.unsplash.com/photo-1473341304170-971dccb5ac1e?auto=format&fit=crop&w=800&q=80','Bí quyết giúp người đi thuê trọ tự tính toán chỉ số điện nước, giá bậc thang nhà nước và nhận biết các dấu hiệu công tơ điện bị rò rỉ hoặc chạy sai.','<p>Chi phí điện nước luôn chiếm một phần không nhỏ trong sinh hoạt phí hàng tháng của các bạn thuê phòng trọ. Việc tự kiểm tra chỉ số và hiểu cách tính tiền sẽ giúp bạn tự chủ tài chính tốt hơn.</p>\n                <h4>1. Tìm hiểu đơn giá quy định</h4>\n                <p>Chủ nhà trọ thu tiền điện theo giá kinh doanh cố định hay theo lũy tiến của nhà nước? Hãy thỏa thuận chi tiết trong hợp đồng.</p>\n                <h4>2. Theo dõi chỉ số công tơ định kỳ</h4>\n                <p>Ghi lại số điện cũ và mới vào ngày chốt chỉ số hàng tháng, chụp ảnh lại mặt công tơ để đối chiếu.</p>','Tin Tức','Dien Nuoc, Phong Tro, Chi Phi, Meo Vat',1,148,'2026-08-24 16:49:40','2026-08-24 16:49:40'),
(16,'Tuyển nhân viên pha chế (Bartender) tại Cafe Homestay Tam Cốc','tuyen-nhan-vien-pha-che-bartender-tai-cafe-homestay-tam-coc','https://images.unsplash.com/photo-1514362545857-3bc16c4c7d1b?auto=format&fit=crop&w=800&q=80','Quán bar sân vườn thuộc Homestay cần tuyển gấp nhân viên pha chế đồ uống sinh tố, cocktail, lương thưởng theo ca cực hấp dẫn.','<p>Quán cafe sân vườn thuộc Eco Homestay Tam Cốc tuyển 02 Bartender pha chế nước ép, sinh tố và cocktail.</p>\n                <h4>Yêu cầu:</h4>\n                <p>Nhanh nhẹn, sạch sẽ, có kiến thức cơ bản về pha chế sinh tố, cà phê máy và nước ép trái cây. Có tiếng Anh giao tiếp là lợi thế lớn.</p>\n                <h4>Mức lương:</h4>\n                <p>25.000đ - 30.000đ/giờ + thưởng doanh số thức uống.</p>','Việc Làm','Pha Che, Bartender, Cafe, Tuyen Dung',1,99,'2026-08-24 16:49:40','2026-08-24 16:49:40'),
(17,'Giải mã sức hút của khu du lịch sinh thái Đầm Vân Long','giai-ma-suc-hut-cua-khu-du-lich-sinh-thai-dam-van-long','https://images.unsplash.com/photo-1476514525535-07fb3b4ae5f1?auto=format&fit=crop&w=800&q=80','Nơi quay bộ phim bom tấn Kong: Skull Island sở hữu khung cảnh hoang sơ trữ tình, đàn cò trắng bay lượn ngập trời thu hút hàng ngàn du khách.','<p>Đầm Vân Long là khu bảo tồn thiên nhiên ngập nước lớn nhất vùng đồng bằng Bắc Bộ. Đây là bức tranh sơn thủy hữu tình làm đắm say bao tâm hồn xê dịch.</p>\n                <p>Khi chèo thuyền xuyên qua đầm nước trong vắt đến mức nhìn rõ rong rêu phía dưới, bạn sẽ ngỡ như đang đi lạc vào một cõi tiên cảnh thanh bình, không tiếng còi xe, chỉ có tiếng mái chèo nhẹ khua và tiếng chim kêu vang.</p>','Tin Tức','Van Long, Du Lich, Sinh Thai, Khám Pha',1,280,'2026-08-24 16:49:40','2026-08-24 16:49:40'),
(18,'Tìm bạn ở ghép căn hộ 2 phòng ngủ gần khu công nghiệp Gián Khẩu','tim-ban-o-ghep-can-ho-2-phong-ngu-gan-khu-cong-nghiep-gian-khau','https://images.unsplash.com/photo-1517486808906-6ca8b3f04846?auto=format&fit=crop&w=800&q=80','Cần tìm 01 bạn nam hoặc nữ ở ghép căn hộ chung cư mini sạch sẽ, tiện nghi đầy đủ máy lạnh tủ lạnh máy giặt, chi phí chia đôi tiết kiệm.','<p>Mình cần tìm 01 bạn ở ghép share phòng chung cư mini 45m2 mới coong gần khu công nghiệp Gián Khẩu.</p>\n                <p>Phòng đã trang bị sẵn máy lạnh, tủ lạnh, máy giặt, tủ bếp nấu ăn. Chi phí thuê phòng là 3.000.000đ/tháng chia đôi mỗi người 1.500.000đ + điện nước chia theo hóa đơn.</p>','Tin Tức','O Ghep, Sinh Vien, Chung Cu, Phong Tro',1,88,'2026-08-24 16:49:40','2026-08-24 16:49:40');
/*!40000 ALTER TABLE `posts` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `properties`
--

DROP TABLE IF EXISTS `properties`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `properties` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `landlord_id` bigint(20) unsigned NOT NULL,
  `name` varchar(255) NOT NULL,
  `description` text DEFAULT NULL,
  `address` varchar(255) NOT NULL,
  `city` varchar(255) NOT NULL DEFAULT 'Ninh Bình',
  `type` enum('homestay','motel_room','apartment') NOT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `properties_landlord_id_foreign` (`landlord_id`),
  CONSTRAINT `properties_landlord_id_foreign` FOREIGN KEY (`landlord_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `properties`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `properties` WRITE;
/*!40000 ALTER TABLE `properties` DISABLE KEYS */;
INSERT INTO `properties` VALUES
(1,5,'Homestay Hoa Lư View','Homestay thoáng mát gần trung tâm, đầy đủ tiện nghi.','123 Đường Tràng An','Ninh Bình','homestay',1,'2026-08-25 16:49:37','2026-08-25 16:49:37');
/*!40000 ALTER TABLE `properties` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `property_mangagers`
--

DROP TABLE IF EXISTS `property_mangagers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `property_mangagers` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `boarding_house_id` bigint(20) unsigned NOT NULL,
  `user_id` bigint(20) unsigned NOT NULL,
  `permissions` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`permissions`)),
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `property_mangagers_boarding_house_id_user_id_unique` (`boarding_house_id`,`user_id`),
  KEY `property_mangagers_user_id_foreign` (`user_id`),
  CONSTRAINT `property_mangagers_boarding_house_id_foreign` FOREIGN KEY (`boarding_house_id`) REFERENCES `boarding_houses` (`id`) ON DELETE CASCADE,
  CONSTRAINT `property_mangagers_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `property_mangagers`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `property_mangagers` WRITE;
/*!40000 ALTER TABLE `property_mangagers` DISABLE KEYS */;
/*!40000 ALTER TABLE `property_mangagers` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `report_reasons`
--

DROP TABLE IF EXISTS `report_reasons`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `report_reasons` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `reason` varchar(255) NOT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `report_reasons`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `report_reasons` WRITE;
/*!40000 ALTER TABLE `report_reasons` DISABLE KEYS */;
/*!40000 ALTER TABLE `report_reasons` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `reports`
--

DROP TABLE IF EXISTS `reports`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `reports` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `reporter_id` bigint(20) unsigned NOT NULL,
  `reportable_type` varchar(255) NOT NULL,
  `reportable_id` bigint(20) unsigned NOT NULL,
  `reason` varchar(255) NOT NULL,
  `description` text NOT NULL,
  `evidence_images` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`evidence_images`)),
  `status` enum('pending','investigating','resolved','rejected') NOT NULL DEFAULT 'pending',
  `admin_note` text DEFAULT NULL,
  `negotiation_deadline` timestamp NULL DEFAULT NULL,
  `target_resolved` tinyint(1) NOT NULL DEFAULT 0,
  `reporter_resolved` tinyint(1) NOT NULL DEFAULT 0,
  `response_note` text DEFAULT NULL,
  `response_evidence` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`response_evidence`)),
  `resolved_by` bigint(20) unsigned DEFAULT NULL,
  `resolved_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `reports_reporter_id_foreign` (`reporter_id`),
  KEY `reports_reportable_type_reportable_id_index` (`reportable_type`,`reportable_id`),
  KEY `reports_resolved_by_foreign` (`resolved_by`),
  CONSTRAINT `reports_reporter_id_foreign` FOREIGN KEY (`reporter_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `reports_resolved_by_foreign` FOREIGN KEY (`resolved_by`) REFERENCES `users` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reports`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `reports` WRITE;
/*!40000 ALTER TABLE `reports` DISABLE KEYS */;
/*!40000 ALTER TABLE `reports` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `reviews`
--

DROP TABLE IF EXISTS `reviews`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `reviews` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `property_id` bigint(20) unsigned DEFAULT NULL,
  `tenant_id` bigint(20) unsigned NOT NULL,
  `rating` tinyint(3) unsigned NOT NULL COMMENT 'Số sao từ 1 đến 5',
  `comment` text DEFAULT NULL,
  `is_visible` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `room_id` bigint(20) unsigned DEFAULT NULL,
  `appointment_id` bigint(20) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `reviews_property_id_foreign` (`property_id`),
  KEY `reviews_tenant_id_foreign` (`tenant_id`),
  KEY `reviews_room_id_foreign` (`room_id`),
  KEY `reviews_appointment_id_foreign` (`appointment_id`),
  CONSTRAINT `reviews_appointment_id_foreign` FOREIGN KEY (`appointment_id`) REFERENCES `appointments` (`id`) ON DELETE CASCADE,
  CONSTRAINT `reviews_property_id_foreign` FOREIGN KEY (`property_id`) REFERENCES `properties` (`id`) ON DELETE CASCADE,
  CONSTRAINT `reviews_room_id_foreign` FOREIGN KEY (`room_id`) REFERENCES `rooms` (`id`) ON DELETE CASCADE,
  CONSTRAINT `reviews_tenant_id_foreign` FOREIGN KEY (`tenant_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reviews`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `reviews` WRITE;
/*!40000 ALTER TABLE `reviews` DISABLE KEYS */;
INSERT INTO `reviews` VALUES
(1,1,6,5,'Phòng sạch sẽ, chủ nhà thân thiện, thủ tục ký hợp đồng online rất nhanh gọn.',1,'2026-08-25 16:49:37','2026-08-25 16:49:37',NULL,NULL);
/*!40000 ALTER TABLE `reviews` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `room_post_views`
--

DROP TABLE IF EXISTS `room_post_views`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `room_post_views` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `room_post_id` bigint(20) unsigned NOT NULL,
  `user_id` bigint(20) unsigned DEFAULT NULL,
  `ip_address` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `room_post_views_room_post_id_foreign` (`room_post_id`),
  KEY `room_post_views_user_id_foreign` (`user_id`),
  CONSTRAINT `room_post_views_room_post_id_foreign` FOREIGN KEY (`room_post_id`) REFERENCES `room_posts` (`id`) ON DELETE CASCADE,
  CONSTRAINT `room_post_views_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `room_post_views`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `room_post_views` WRITE;
/*!40000 ALTER TABLE `room_post_views` DISABLE KEYS */;
INSERT INTO `room_post_views` VALUES
(1,1,NULL,'127.0.0.1','2026-08-25 16:50:43','2026-08-25 16:50:43');
/*!40000 ALTER TABLE `room_post_views` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `room_posts`
--

DROP TABLE IF EXISTS `room_posts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `room_posts` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `landlord_id` bigint(20) unsigned NOT NULL,
  `room_id` bigint(20) unsigned NOT NULL,
  `title` varchar(255) NOT NULL COMMENT 'tiêu đề của tin đăng',
  `description` text NOT NULL COMMENT 'Nội dung mô tả cho tiết bài đăng quảng cáo phòng',
  `image` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT 'phần ảnh quảng cáo do chủ trọ tự chụp up lên' CHECK (json_valid(`image`)),
  `status` enum('draft','pending','approved','rejected','hidden','expired') NOT NULL DEFAULT 'pending',
  `reject_reason` varchar(255) DEFAULT NULL COMMENT 'lý do admin từ chối',
  `view_count` int(11) NOT NULL DEFAULT 0,
  `is_vip` tinyint(1) NOT NULL DEFAULT 0,
  `published_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `room_posts_landlord_id_foreign` (`landlord_id`),
  KEY `room_posts_room_id_foreign` (`room_id`),
  CONSTRAINT `room_posts_landlord_id_foreign` FOREIGN KEY (`landlord_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `room_posts_room_id_foreign` FOREIGN KEY (`room_id`) REFERENCES `rooms` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `room_posts`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `room_posts` WRITE;
/*!40000 ALTER TABLE `room_posts` DISABLE KEYS */;
INSERT INTO `room_posts` VALUES
(1,5,1,'Phòng trọ P101 đầy đủ tiện nghi, thoáng mát sạch sẽ','Phòng trọ khép kín, an ninh tốt, gần trung tâm du lịch Tràng An, phù hợp cho học sinh, sinh viên và người đi làm.','[\"private\\/properties\\/rooms\\/user_5_phong_tro_0_1780282532.png\"]','approved',NULL,13,0,'2026-08-25 16:49:37','2026-08-25 16:49:37','2026-08-25 16:49:37');
/*!40000 ALTER TABLE `room_posts` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `room_residents`
--

DROP TABLE IF EXISTS `room_residents`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `room_residents` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `room_id` bigint(20) unsigned NOT NULL,
  `user_id` bigint(20) unsigned NOT NULL,
  `start_date` date NOT NULL,
  `end_date` date DEFAULT NULL,
  `status` enum('active','inactive') NOT NULL DEFAULT 'active',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `room_residents_room_id_foreign` (`room_id`),
  KEY `room_residents_user_id_foreign` (`user_id`),
  CONSTRAINT `room_residents_room_id_foreign` FOREIGN KEY (`room_id`) REFERENCES `rooms` (`id`) ON DELETE CASCADE,
  CONSTRAINT `room_residents_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `room_residents`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `room_residents` WRITE;
/*!40000 ALTER TABLE `room_residents` DISABLE KEYS */;
/*!40000 ALTER TABLE `room_residents` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `room_service`
--

DROP TABLE IF EXISTS `room_service`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `room_service` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `room_id` bigint(20) unsigned NOT NULL,
  `service_id` bigint(20) unsigned NOT NULL,
  `price` decimal(10,2) DEFAULT NULL COMMENT 'Giá dịch vụ riêng cho phòng khi có hợp đồng hoạt động',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `room_service_room_id_foreign` (`room_id`),
  KEY `room_service_service_id_foreign` (`service_id`),
  CONSTRAINT `room_service_room_id_foreign` FOREIGN KEY (`room_id`) REFERENCES `rooms` (`id`) ON DELETE CASCADE,
  CONSTRAINT `room_service_service_id_foreign` FOREIGN KEY (`service_id`) REFERENCES `services` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `room_service`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `room_service` WRITE;
/*!40000 ALTER TABLE `room_service` DISABLE KEYS */;
/*!40000 ALTER TABLE `room_service` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `roommate_requests`
--

DROP TABLE IF EXISTS `roommate_requests`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `roommate_requests` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `room_id` bigint(20) unsigned NOT NULL,
  `tetant_id` bigint(20) unsigned NOT NULL,
  `type` varchar(255) NOT NULL DEFAULT 'stranger',
  `status` varchar(255) NOT NULL DEFAULT 'pending',
  `new_resident_name` varchar(255) DEFAULT NULL,
  `new_resident_phone` varchar(255) DEFAULT NULL,
  `new_resident_email` varchar(255) DEFAULT NULL,
  `new_resident_cccd` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `roommate_requests_room_id_foreign` (`room_id`),
  KEY `roommate_requests_tetant_id_foreign` (`tetant_id`),
  CONSTRAINT `roommate_requests_room_id_foreign` FOREIGN KEY (`room_id`) REFERENCES `rooms` (`id`) ON DELETE CASCADE,
  CONSTRAINT `roommate_requests_tetant_id_foreign` FOREIGN KEY (`tetant_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `roommate_requests`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `roommate_requests` WRITE;
/*!40000 ALTER TABLE `roommate_requests` DISABLE KEYS */;
/*!40000 ALTER TABLE `roommate_requests` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `rooms`
--

DROP TABLE IF EXISTS `rooms`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `rooms` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `boarding_house_id` bigint(20) unsigned DEFAULT NULL,
  `property_id` bigint(20) unsigned DEFAULT NULL,
  `floor_id` bigint(20) unsigned DEFAULT NULL,
  `room_number` varchar(255) NOT NULL,
  `address` varchar(255) DEFAULT NULL COMMENT 'địa chỉ cụ thể phòng trọ',
  `price` decimal(10,2) NOT NULL,
  `area` decimal(8,2) NOT NULL COMMENT 'diện tích phòng theo m2',
  `capacity` int(11) NOT NULL DEFAULT 2 COMMENT 'số người ở tối đa',
  `current_people` int(11) NOT NULL DEFAULT 0 COMMENT 'Số người hiện tại',
  `status` enum('available','rented','maintenance','deposited','expiring_soon','pending_renewal','suspended') NOT NULL DEFAULT 'available',
  `maintenance_reason` varchar(255) DEFAULT NULL,
  `amenities` varchar(255) DEFAULT NULL COMMENT 'Danh sách tiện ích dạng chuỗi',
  `images` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT 'Mảng đường dẫn ảnh gốc của phòng' CHECK (json_valid(`images`)),
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `rooms_property_id_foreign` (`property_id`),
  KEY `rooms_floor_id_foreign` (`floor_id`),
  KEY `rooms_boarding_house_id_foreign` (`boarding_house_id`),
  CONSTRAINT `rooms_boarding_house_id_foreign` FOREIGN KEY (`boarding_house_id`) REFERENCES `boarding_houses` (`id`) ON DELETE CASCADE,
  CONSTRAINT `rooms_floor_id_foreign` FOREIGN KEY (`floor_id`) REFERENCES `floors` (`id`) ON DELETE SET NULL,
  CONSTRAINT `rooms_property_id_foreign` FOREIGN KEY (`property_id`) REFERENCES `properties` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rooms`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `rooms` WRITE;
/*!40000 ALTER TABLE `rooms` DISABLE KEYS */;
INSERT INTO `rooms` VALUES
(1,2,NULL,1,'P101','123 Đường Tràng An, Tầng 1',2500000.00,25.50,2,0,'rented',NULL,NULL,NULL,'2026-08-25 16:49:37','2026-08-25 16:49:37');
/*!40000 ALTER TABLE `rooms` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `services`
--

DROP TABLE IF EXISTS `services`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `services` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `property_id` bigint(20) unsigned DEFAULT NULL,
  `boarding_house_id` bigint(20) unsigned DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `price_updated_at` timestamp NULL DEFAULT NULL COMMENT 'Thời gian cập nhật giá gần nhất',
  `type` enum('per_kwh','per_m3','fixed','per_person') NOT NULL DEFAULT 'fixed' COMMENT 'Cách tính: theo số điện, số nước, cố định, hoặc theo đầu người',
  `description` text DEFAULT NULL,
  `icon` varchar(255) NOT NULL DEFAULT 'bi-lightning-charge-fill',
  `color` varchar(255) NOT NULL DEFAULT 'emerald',
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `amenity_id` bigint(20) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `services_property_id_foreign` (`property_id`),
  KEY `services_boarding_house_id_foreign` (`boarding_house_id`),
  KEY `services_amenity_id_foreign` (`amenity_id`),
  CONSTRAINT `services_amenity_id_foreign` FOREIGN KEY (`amenity_id`) REFERENCES `amenities` (`id`) ON DELETE SET NULL,
  CONSTRAINT `services_boarding_house_id_foreign` FOREIGN KEY (`boarding_house_id`) REFERENCES `boarding_houses` (`id`) ON DELETE CASCADE,
  CONSTRAINT `services_property_id_foreign` FOREIGN KEY (`property_id`) REFERENCES `properties` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `services`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `services` WRITE;
/*!40000 ALTER TABLE `services` DISABLE KEYS */;
INSERT INTO `services` VALUES
(1,1,NULL,'Tiền Điện',3500.00,NULL,'per_kwh','Tính theo số ký điện tiêu thụ','bi-lightning-charge-fill','emerald',1,'2026-08-25 16:49:37','2026-08-25 16:49:37',NULL),
(2,1,NULL,'Tiền Nước',20000.00,NULL,'per_m3','Tính theo khối nước tiêu thụ','bi-lightning-charge-fill','emerald',1,'2026-08-25 16:49:37','2026-08-25 16:49:37',NULL),
(3,1,NULL,'Internet Wifi',50000.00,NULL,'fixed','Phí cố định theo phòng hàng tháng','bi-lightning-charge-fill','emerald',1,'2026-08-25 16:49:37','2026-08-25 16:49:37',NULL);
/*!40000 ALTER TABLE `services` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `settings`
--

DROP TABLE IF EXISTS `settings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `settings` (
  `key` varchar(255) NOT NULL,
  `value` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `settings`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `settings` WRITE;
/*!40000 ALTER TABLE `settings` DISABLE KEYS */;
INSERT INTO `settings` VALUES
('banners','[{\"id\":1,\"title\":\"Banner chính trang chủ\",\"img\":\"\\/anh\\/banner.png\",\"active\":true,\"order\":1},{\"id\":2,\"title\":\"Banner khuyến mãi hè\",\"img\":\"\\/anh\\/banner.png\",\"active\":false,\"order\":2}]','2026-08-25 16:49:37','2026-08-25 16:49:37'),
('contact_address','Ninh Bình, Việt Nam','2026-08-25 16:49:37','2026-08-25 16:49:37'),
('contact_email','contact@ninhbinhhomestay.vn','2026-08-25 16:49:37','2026-08-25 16:49:37'),
('contact_map','https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d2611.291724627434!2d105.93314109429076!3d20.603915192384463!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x3135cf62d752dc67%3A0xd79f03899b4e83d8!2zVHLGsOG7nW5nIENhbyDEkeG6s25nIEZQVCBQb2x5dGVjaG5pYyBjxqEgc-G7nyBIw6AgTmFt!5e1!3m2!1svi!2s!4v1774600950495!5m2!1svi!2s','2026-08-25 16:49:37','2026-08-25 16:49:37'),
('contact_phone','0912 345 678','2026-08-25 16:49:37','2026-08-25 16:49:37'),
('hero_subtitle','Hệ thống tìm kiếm và quản lý phòng trọ thông minh số 1 tại Ninh Bình.','2026-08-25 16:49:37','2026-08-25 16:49:37'),
('hero_title','Tìm Phòng Và Nhà Trọ Phù Hợp','2026-08-25 16:49:37','2026-08-25 16:49:37');
/*!40000 ALTER TABLE `settings` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `subscription_plan_feature`
--

DROP TABLE IF EXISTS `subscription_plan_feature`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `subscription_plan_feature` (
  `plan_id` bigint(20) unsigned NOT NULL,
  `feature_id` bigint(20) unsigned NOT NULL,
  `feature_value` varchar(255) DEFAULT NULL COMMENT '10,50,unlimited, true, false...',
  PRIMARY KEY (`plan_id`,`feature_id`),
  KEY `subscription_plan_feature_feature_id_foreign` (`feature_id`),
  CONSTRAINT `subscription_plan_feature_feature_id_foreign` FOREIGN KEY (`feature_id`) REFERENCES `features` (`id`) ON DELETE CASCADE,
  CONSTRAINT `subscription_plan_feature_plan_id_foreign` FOREIGN KEY (`plan_id`) REFERENCES `subscription_plans` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `subscription_plan_feature`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `subscription_plan_feature` WRITE;
/*!40000 ALTER TABLE `subscription_plan_feature` DISABLE KEYS */;
/*!40000 ALTER TABLE `subscription_plan_feature` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `subscription_plans`
--

DROP TABLE IF EXISTS `subscription_plans`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `subscription_plans` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `price` decimal(12,2) NOT NULL DEFAULT 0.00,
  `duration_days` int(11) NOT NULL DEFAULT 30,
  `badge` varchar(255) DEFAULT NULL,
  `sort_order` int(11) NOT NULL DEFAULT 0 COMMENT 'Thứ tự sắp xếp',
  `description` text DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `subscription_plans`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `subscription_plans` WRITE;
/*!40000 ALTER TABLE `subscription_plans` DISABLE KEYS */;
/*!40000 ALTER TABLE `subscription_plans` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `user_verifications`
--

DROP TABLE IF EXISTS `user_verifications`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_verifications` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) unsigned NOT NULL,
  `id_card_number` varchar(255) DEFAULT NULL,
  `id_card_front` varchar(255) DEFAULT NULL,
  `id_card_back` varchar(255) DEFAULT NULL,
  `face_auth_image` varchar(255) DEFAULT NULL,
  `kyc_status` enum('unverified','pending','approved','rejected') NOT NULL DEFAULT 'unverified',
  `kyc_notes` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `user_verifications_user_id_foreign` (`user_id`),
  CONSTRAINT `user_verifications_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_verifications`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `user_verifications` WRITE;
/*!40000 ALTER TABLE `user_verifications` DISABLE KEYS */;
INSERT INTO `user_verifications` VALUES
(1,2,'037123456789','private/kyc/id_cards/user_2_cccd_truoc_1780282532.jpg','private/kyc/id_cards/user_2_cccd_sau_1780282532.jpg','private/kyc/faces/user_2_khuon_mat_1780282532.jpg','approved','Hồ sơ đầy đủ, hợp lệ','2026-08-25 16:49:40','2026-08-25 16:49:40'),
(2,5,'037123456789','private/kyc/id_cards/user_5_cccd_truoc_1780282532.jpg','private/kyc/id_cards/user_5_cccd_sau_1780282532.jpg','private/kyc/faces/user_5_khuon_mat_1780282532.jpg','approved','Hồ sơ đầy đủ, hợp lệ','2026-08-25 16:49:40','2026-08-25 16:49:40');
/*!40000 ALTER TABLE `user_verifications` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `google_id` varchar(255) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `otp_code` varchar(6) DEFAULT NULL,
  `otp_expires_at` timestamp NULL DEFAULT NULL,
  `phone` varchar(10) DEFAULT NULL,
  `cccd_number` varchar(255) DEFAULT NULL COMMENT 'số cccd để xác minh tài khoản',
  `role` varchar(255) NOT NULL DEFAULT 'user',
  `status` varchar(255) NOT NULL DEFAULT 'active',
  `lock_reason` text DEFAULT NULL,
  `is_verified` tinyint(1) NOT NULL DEFAULT 0,
  `remember_token` varchar(100) DEFAULT NULL,
  `fcm_token` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `job` varchar(255) DEFAULT NULL,
  `dob` date DEFAULT NULL,
  `gender` enum('male','female','other') DEFAULT NULL,
  `avatar` varchar(255) DEFAULT NULL,
  `last_profile_update_at` timestamp NULL DEFAULT NULL,
  `bank_name` varchar(255) DEFAULT NULL COMMENT 'Tên ngân hàng',
  `bank_account_no` varchar(255) DEFAULT NULL COMMENT 'Số tài khoản',
  `bank_account_name` varchar(255) DEFAULT NULL COMMENT 'Tên chủ tài khoản',
  `last_seen_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_email_unique` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES
(1,NULL,'Admin','admin@ninhbinhhomestay.vn','2026-08-25 16:49:40','$2y$10$NSgxyHuNi7B6bg8z2haBm.gFejSv/GYOSnC9dlrhy/i2YcPURu91S',NULL,NULL,NULL,NULL,'admin','active',NULL,0,NULL,NULL,'2026-08-25 16:49:32','2026-08-25 16:49:40',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(2,NULL,'Nguyễn Văn Chủ','landlord@test.com',NULL,'$2y$10$jpUJ8KNZVIna3iGa7eP1zudilBOiRo00c3b6GIhRG9NyBlWP6.hBO',NULL,NULL,'0912345678','037123456789','landlord','active',NULL,1,NULL,NULL,'2026-08-25 16:49:32','2026-08-25 16:49:40',NULL,NULL,NULL,NULL,NULL,NULL,'Vietcombank','1234567890','NGUYEN VAN CHU',NULL),
(3,NULL,'System Admin','admin@gmail.com','2026-08-25 16:49:40','$2y$10$O7sjDB51yvjavs1xRp0cQe/G.Dx6o5FOH3rrjxEF5tEJffMEXFcaC',NULL,NULL,NULL,NULL,'admin','active',NULL,0,NULL,NULL,'2026-08-25 16:49:37','2026-08-25 16:49:40',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(4,NULL,'Admin Ninh Binh StayWork','admin@staywork.com',NULL,'$2y$10$Y0w3JkSVyVDtALr2hjKereAXFLDQH/XDJKXvxAqv7H88Q2.qk.b4m',NULL,NULL,NULL,NULL,'admin','active',NULL,0,NULL,NULL,'2026-08-25 16:49:37','2026-08-25 16:49:37',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
(5,NULL,'Nguyễn Văn Chủ Trọ','chutro@staywork.com',NULL,'$2y$10$bjKyse4eRl6Rcd7CDnAb/OiasNrlwAgji5vgVzYNbA7kNH2Af.eyO',NULL,NULL,'0912345678','037123456789','landlord','active',NULL,1,NULL,NULL,'2026-08-25 16:49:37','2026-08-25 16:49:37',NULL,NULL,NULL,NULL,NULL,NULL,'Vietcombank','1234567890','NGUYEN VAN CHU TRO',NULL),
(6,NULL,'Trần Thị Người Thuê','nguoithue@staywork.com',NULL,'$2y$10$JMYcX6ldkhPezo1XjcGwQu.KMEDn1T3vkCk4v8kdQ47LwuxZWOyHO',NULL,NULL,'0987654321','037987654321','tenant','active',NULL,1,NULL,NULL,'2026-08-25 16:49:37','2026-08-25 16:49:37',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Dumping routines for database 'datn'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*M!100616 SET NOTE_VERBOSITY=@OLD_NOTE_VERBOSITY */;

-- Dump completed on 2026-08-25 16:54:34
