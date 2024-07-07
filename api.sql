/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

CREATE TABLE `migrations` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `password_reset_tokens` (
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `payments` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint unsigned NOT NULL,
  `type` varchar(255) NOT NULL,
  `date` date NOT NULL,
  `amount` int NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_user` (`user_id`),
  CONSTRAINT `fk_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `personal_access_tokens` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `tokenable_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tokenable_id` bigint unsigned NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  `abilities` text COLLATE utf8mb4_unicode_ci,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `expires_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`)
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `products` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `stripe_price_id` varchar(255) DEFAULT NULL,
  `price` int DEFAULT NULL,
  `repeat` int DEFAULT NULL,
  `description` text,
  `details` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

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

CREATE TABLE `users` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `stripe_customer_id` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `remember_token` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `subscription_status` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `current_period_end` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_email_unique` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(2, '0001_01_01_000001_create_cache_table', 1);
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(3, '0001_01_01_000002_create_jobs_table', 1);
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(4, '2024_06_19_130328_create_personal_access_tokens_table', 1);
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(6, '0001_01_01_000000_create_users_table', 2);





INSERT INTO `personal_access_tokens` (`id`, `tokenable_type`, `tokenable_id`, `name`, `token`, `abilities`, `last_used_at`, `expires_at`, `created_at`, `updated_at`) VALUES
(1, 'App\\Models\\User', 1, 'client', '299143f0f841d08d37c3a0f15ee8976ec607750289426653e5b858df5c525b25', '[\"*\"]', NULL, NULL, '2024-07-05 18:05:45', '2024-07-05 18:05:45');
INSERT INTO `personal_access_tokens` (`id`, `tokenable_type`, `tokenable_id`, `name`, `token`, `abilities`, `last_used_at`, `expires_at`, `created_at`, `updated_at`) VALUES
(2, 'App\\Models\\User', 2, 'client', 'a31d6228785f059f70629a7f938fb021b0b0b1f87deb4e5615ded2ffb3f0f609', '[\"*\"]', NULL, NULL, '2024-07-05 18:11:33', '2024-07-05 18:11:33');
INSERT INTO `personal_access_tokens` (`id`, `tokenable_type`, `tokenable_id`, `name`, `token`, `abilities`, `last_used_at`, `expires_at`, `created_at`, `updated_at`) VALUES
(3, 'App\\Models\\User', 3, 'client', '5c0c2066791419b42191390b48d33b4d31160fd2a6c8dd4ce25a65effed88cd2', '[\"*\"]', NULL, NULL, '2024-07-05 18:16:05', '2024-07-05 18:16:05');
INSERT INTO `personal_access_tokens` (`id`, `tokenable_type`, `tokenable_id`, `name`, `token`, `abilities`, `last_used_at`, `expires_at`, `created_at`, `updated_at`) VALUES
(4, 'App\\Models\\User', 4, 'client', 'ba6041aed1c27f26bc5e0aed2c4a5603edc7824ff29830b7b3960d7777172a1a', '[\"*\"]', NULL, NULL, '2024-07-05 18:36:43', '2024-07-05 18:36:43'),
(5, 'App\\Models\\User', 5, 'client', 'eeb6a53453e7a0e57db76b0764582616ef3476469c828bbe164ac3795ce0423c', '[\"*\"]', NULL, NULL, '2024-07-05 18:38:35', '2024-07-05 18:38:35'),
(6, 'App\\Models\\User', 6, 'client', 'a6b0702a82c6f77b99fdb226d071b18baa7c20cbd806a53787741ea9571b728a', '[\"*\"]', NULL, NULL, '2024-07-05 18:47:02', '2024-07-05 18:47:02'),
(8, 'App\\Models\\User', 7, 'client', 'f5eaf25fc512467a2b1195b7bbb51bbf1cff5a0f40a1b22a8cd444a7183fa205', '[\"*\"]', NULL, NULL, '2024-07-05 18:53:02', '2024-07-05 18:53:02'),
(10, 'App\\Models\\User', 8, 'client', '29fd3933c3f58a589c77a4692a4ab2a750d450b0504d3bc8ed7f464f14baff25', '[\"*\"]', NULL, NULL, '2024-07-05 18:54:46', '2024-07-05 18:54:46'),
(28, 'App\\Models\\User', 14, 'client', '3980d56ac2e0e556696b63f50a6c36ddaf1a0c3f6ea92a6d8e943f445aabd225', '[\"*\"]', '2024-07-06 01:48:58', NULL, '2024-07-06 01:37:12', '2024-07-06 01:48:58');

INSERT INTO `products` (`id`, `name`, `stripe_price_id`, `price`, `repeat`, `description`, `details`) VALUES
(1, 'Blue Primary', 'price_1PYWHXCi5Mj5IJor5qF9WLKp', 3000, 1, 'BMW M3 E90', 'Klometrage 1000 km/Mois, Assurance 7/7');
INSERT INTO `products` (`id`, `name`, `stripe_price_id`, `price`, `repeat`, `description`, `details`) VALUES
(2, 'Blue Secondary', 'price_1PYWIRCi5Mj5IJoroiIJ1kaQ', 4000, 1, 'BMW M3 F80', 'Klometrage 2000 km/Mois, Assurance 7/7');
INSERT INTO `products` (`id`, `name`, `stripe_price_id`, `price`, `repeat`, `description`, `details`) VALUES
(3, 'Red', 'price_1PYWInCi5Mj5IJorH01XMPn2', 5000, 1, 'BMW M3 G80', 'Klometrage illimité/Mois, Carburant rembourse, Assurance 7/7');

INSERT INTO `sessions` (`id`, `user_id`, `ip_address`, `user_agent`, `payload`, `last_activity`) VALUES
('4bLZHHc68rbC3v6pr6G0UjRK1RPc6W9Y27g6OTMj', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Code/1.91.0 Chrome/122.0.6261.156 Electron/29.4.0 Safari/537.36', 'YToyOntzOjY6Il90b2tlbiI7czo0MDoiRU11aVA0dXZ4b1dEWTQ2d3ZhNjBTVHVqekhvMnhXRElmSHlCaGlCMyI7czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1720180067);
INSERT INTO `sessions` (`id`, `user_id`, `ip_address`, `user_agent`, `payload`, `last_activity`) VALUES
('5GdMesHrlaq0zoDvOjp1akFoX555cBh5w1Q54lWX', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Code/1.91.0 Chrome/122.0.6261.156 Electron/29.4.0 Safari/537.36', 'YToyOntzOjY6Il90b2tlbiI7czo0MDoiQlVRNjZlRkE3MzdPOG43aXRmRTRrcDVBd0JiM0hHOUdBSkd6a1B4cCI7czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1720182125);
INSERT INTO `sessions` (`id`, `user_id`, `ip_address`, `user_agent`, `payload`, `last_activity`) VALUES
('5rZsfmsCFA6Qr1pbdOyofDOF5ekX1crG6vzi4JYQ', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Code/1.91.0 Chrome/122.0.6261.156 Electron/29.4.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoicUlUOEFBTTdJVFFzSWphQm5kWUQ1ZU16QWNUaDZxSTNZMnlJTXFkWSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzA6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC9wcm9kdWN0cyI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1720182123);
INSERT INTO `sessions` (`id`, `user_id`, `ip_address`, `user_agent`, `payload`, `last_activity`) VALUES
('aApB5eDuFDPagLeDbdzvoRRBR8tsJJmVUM4K27ul', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Code/1.91.0 Chrome/122.0.6261.156 Electron/29.4.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiY0NCTnFMelRGTlhUOWt4cHlScWMyOFplVGVpN0ZxcWJ6QlpyWDlFSCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzA6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC9wcm9kdWN0cyI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1720180060),
('aSuBEsco4rJNsFK3PdMvXNXcrDxH7i0vzM8osIGL', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Code/1.91.0 Chrome/122.0.6261.156 Electron/29.4.0 Safari/537.36', 'YToyOntzOjY6Il90b2tlbiI7czo0MDoiOTBvWmN2OGZIalZKYUFzdTNURnhsOExXUUZxMENhdzBwSDdIV2xpVCI7czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1720181481),
('B5njI5YsJMRrOEvovGXQzWbpgNVV1TxiuQE8gDHU', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Code/1.91.0 Chrome/122.0.6261.156 Electron/29.4.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiN1N1bnhTNWtvNkpBNzE1cTJtWFIwVkpPSU5QN2pXNTFVU3NXNk5LVSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzA6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC9wcm9kdWN0cyI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1720181180),
('bQQwsqKw9DaujDz0n6nkvHtd9vd2Hof2ylsCLm9W', NULL, '127.0.0.1', 'Mozilla/5.0 (iPhone; CPU iPhone OS 17_5_1 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/17.5 Mobile/15E148 Safari/604.1', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiTVFrc0xvclhGYzA1WFllQlNjUTZQZ3g5akJtck5oQnY5bWNxdVZ6WSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NjU6Imh0dHA6Ly9jMTdiLTJhMDItODQyOC01NGEtOWUwMS02MDViLWNiZmItZDlmNC01NTI0Lm5ncm9rLWZyZWUuYXBwIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1720229208),
('c4TB0SvgQHCZXOS0IIHLBuBldvOINmjD5y2PqTOu', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Code/1.91.0 Chrome/122.0.6261.156 Electron/29.4.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiRE9Ua2Q2SmVURWhiNlFkR2xxejM3QTFJajNrcVFYQkVHODlxWURoaiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NTU6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC8/dnNjb2RlQnJvd3NlclJlcUlkPTE3MjAxODI3MzIzOTkiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1720182732),
('DLKj9TWY8sa79ReC2qIECXalKt85gwRkocw0i4of', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Code/1.91.0 Chrome/122.0.6261.156 Electron/29.4.0 Safari/537.36', 'YToyOntzOjY6Il90b2tlbiI7czo0MDoia3dVUHJVbnJKV0tPalhVeTVkTlNPelRKaDFTQUUzcnNqdWxUbDc5ayI7czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1720182954),
('E0vh2XuvH6RThP5a9wJb6NwlVVZLtJIBUjVuzok3', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Code/1.91.0 Chrome/122.0.6261.156 Electron/29.4.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiV2JFaldtZktDYTVLY0hNSE9ta2FKUWR1Z21XM1JCcEIzQmU4T1EyVCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NTU6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC8/dnNjb2RlQnJvd3NlclJlcUlkPTE3MjAxODIxMjAzNjIiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1720182120),
('E8kommy48L4sSlwnyKPY6iH0cl4cuS5SAZeYbhqT', NULL, '127.0.0.1', 'PostmanRuntime/7.39.0', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoienJhUU1Ia1RSZVY2bFlLeTZSZnFCZDh2NUxWUnBKMGIzaVRoVU01RyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjE6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMCI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1720202685),
('fFVdGf6nU9WOnIsMxOtll1OGwg7HFpbm13OruIEx', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Code/1.91.0 Chrome/122.0.6261.156 Electron/29.4.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiQ3J3aWxPbjFJclVYYlBuVFBVWHNKSkFnOElCZHhnMExRSjhIWjlEZSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzA6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC9wcm9kdWN0cyI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1720181186),
('fM001f5273qXOGgaV7xguKaJySfriMRytXayfzPK', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Code/1.91.0 Chrome/122.0.6261.156 Electron/29.4.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiU29uQkZtSTZENHo4Q2kzWjM5UjNpR1ZDMlU1TFBnNTJnazNrY0pmeiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzA6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC9wcm9kdWN0cyI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1720178132),
('Gl2O3KcErDOwS0gz9w2FqN5vhRenuSI5Olk2OYSD', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Code/1.91.0 Chrome/122.0.6261.156 Electron/29.4.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiWE4yYndCdHBveFBXOEhKUHFHZzVtbXNMZ0J0aWtzNXYyM0R4V0g5RSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzA6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC9wcm9kdWN0cyI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1720181476),
('H86j3mIFIrWUY8OOLXAhD1mYXcB2Qic0L6XGwahY', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Code/1.91.0 Chrome/122.0.6261.156 Electron/29.4.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiMU9mT2Nza0tLOGoxa01ISEZyd1VUWU9kaWNoT3ZiZnhCR0xPd3l6VCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzA6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC9wcm9kdWN0cyI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1720178133),
('HPc4L9zaSa9zrkdhhlRhc4MWjl15UPTabqDGRAIk', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Code/1.91.0 Chrome/122.0.6261.156 Electron/29.4.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoibXdFWGtOWTVIUmN6dzF0OWo1Ymg2NXhBRjdtdmV2Z3o4RWk1Rm9pUiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NTU6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC8/dnNjb2RlQnJvd3NlclJlcUlkPTE3MjAxNzgxMTg0NzQiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1720178118),
('IgAlPbzhq7vHEzlun6HXa4oXEMfMn1kd95IiIZ3Y', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Code/1.91.0 Chrome/122.0.6261.156 Electron/29.4.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiU0V3MHMwUkdwQ3JiUjRjdmk5UEM0TmNrd0c5Q0pFRFRmYmtMV3hwOCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NTU6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC8/dnNjb2RlQnJvd3NlclJlcUlkPTE3MjAxODA0OTc1NjYiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1720180497),
('JHjnuKO9ChpjW93kThlG4O4peLxV7wfXhBU4NECC', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Code/1.91.0 Chrome/122.0.6261.156 Electron/29.4.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiQUhza0tlRVRnSmpzbWJWaTVBTUZFMnVKSzNDYzhDR3hYZ0M5NDM3diI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzA6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC9wcm9kdWN0cyI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1720178141),
('kFTwX97mSOEWhCYu73B1Y9xUCKWIBhnzGqBzmZ9F', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Code/1.91.0 Chrome/122.0.6261.156 Electron/29.4.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiVDhHb21yQ204YjduNDVlSmlJRXJpNjFIaURtT092V3RLSjFDb3hpYiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NTU6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC8/dnNjb2RlQnJvd3NlclJlcUlkPTE3MjAxODE0NzM0MzgiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1720181473),
('loNBe3T0PUe6MXC5FPMmhSeunapUReqUFthuClxY', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Code/1.91.0 Chrome/122.0.6261.156 Electron/29.4.0 Safari/537.36', 'YToyOntzOjY6Il90b2tlbiI7czo0MDoia1Rja2xES2pZb1NJSGtzb2RnTVJROFd4YXlQQWo1Umdyd3R6MHFxSSI7czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1720181182),
('MIbOOYxvM4voA9mmfUDwpoYlrWocCVP6JQTqtcQY', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Code/1.91.0 Chrome/122.0.6261.156 Electron/29.4.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiUG9IcEZuMlRvR3J2VXpFallpMFlIdkptcUI2YUNSaVU4TDdCeUdzeSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NTU6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC8/dnNjb2RlQnJvd3NlclJlcUlkPTE3MjAxODExODk0MTYiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1720181189),
('my1H5ZP8HByFq2stsd05zCCfNJlaTeGqPolzOrh6', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Code/1.91.0 Chrome/122.0.6261.156 Electron/29.4.0 Safari/537.36', 'YToyOntzOjY6Il90b2tlbiI7czo0MDoiVkFVZ3VvaURHVFU5dWZLZW01VWhzWnlaejJMd2VBbGZadW43ZDJZWiI7czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1720182222),
('nkG9YkFMl5tfQPHoNUnmNCyOzicA78lBZwHmwdBG', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Code/1.91.0 Chrome/122.0.6261.156 Electron/29.4.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiYkw0aFpLeGZkbUdzZWIzY3ZkazVqT1lqa3FsTTBZUjBMZUxYUVlOWiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzA6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC9wcm9kdWN0cyI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1720184567),
('ogZZRYKwR7LVPBYuk83lQ5RU9nTgoCB83BcAVp7a', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Code/1.91.0 Chrome/122.0.6261.156 Electron/29.4.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiWE5OckhReVAwaTNhT0NJZDNXbU5UdjBUcjg1RWtET2NackRkaWxYUSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NTU6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC8/dnNjb2RlQnJvd3NlclJlcUlkPTE3MjAxODE2MTQ0NTkiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1720181614),
('OramSYPpSjcvCfj92UJv8GWOdbJaKXDA55nABT78', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Code/1.91.0 Chrome/122.0.6261.156 Electron/29.4.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoickcyMkRUem1NVEhqTmVWWktsU1BGZ09mVDFCVE1UbDc1NEpxcTlqciI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NTU6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC8/dnNjb2RlQnJvd3NlclJlcUlkPTE3MjAxODI5NDg2ODgiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1720182948),
('PA4ZrnbDEASoDWygSCzw3E05xG6voDQNmZNDfsNZ', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Code/1.91.0 Chrome/122.0.6261.156 Electron/29.4.0 Safari/537.36', 'YToyOntzOjY6Il90b2tlbiI7czo0MDoiU3loejdwNVlmdTh6NWhnTTFJY2VhMHFxY3FPVW8wc3Z4OTZiTXNoaCI7czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1720184571),
('QImoJkG2YV0UMJ3ZvE96WU8Itpe0Dpxf9aYU6q2Q', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Code/1.91.0 Chrome/122.0.6261.156 Electron/29.4.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoia0F1NjNPOVMxMUEyNXZKb29aUldLckVMNXluRlR0QVhtaGNud0VaOSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NTU6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC8/dnNjb2RlQnJvd3NlclJlcUlkPTE3MjAxODIyMTI1MDMiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1720182212),
('RLraU7M8nd4STBR7qnp7Wu51b1gcsTOAz8BPZowR', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Code/1.91.0 Chrome/122.0.6261.156 Electron/29.4.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiMXVITWo4d0E0YnVDVnRiT1d5UUZmVEM0dVpJRnRVRTVrbGo5VExTRyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzA6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC9wcm9kdWN0cyI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1720178134),
('sO5xLObTWMuV92cFs6lbBczCff2IWuJT9cTBJ5up', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Code/1.91.0 Chrome/122.0.6261.156 Electron/29.4.0 Safari/537.36', 'YToyOntzOjY6Il90b2tlbiI7czo0MDoiWXpFNTBreHBWcW9PYmNWU0hZQk9XZmU5MG9SdnRzSG00UlN2YTY1ZyI7czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1720181187),
('T7RtgrKREPb7Q5duv6iytER9H7jCXfrTbe12nPpc', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Code/1.91.0 Chrome/122.0.6261.156 Electron/29.4.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiWkk3WEVqelpjdUZkS0FCR3hYbk5nQkZObnBmZWFvQ1hlajZQNVVtcyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzA6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC9wcm9kdWN0cyI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1720178133),
('tR1tvbMDgdpCyLqX4MbRi1cBfXdgHIy5QJKPNGCR', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Code/1.91.0 Chrome/122.0.6261.156 Electron/29.4.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiTjZaeU03b0x5ODE3d3EzT2RqSEcza09YVU1lajNnaVJub250bEd0QyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzA6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC9wcm9kdWN0cyI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1720182952),
('udv5ZPD1vVLVL9KNap2RXmll2NCEn2AMo2qcKzXt', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Code/1.91.0 Chrome/122.0.6261.156 Electron/29.4.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiRHpjUFp1VFdCZlhMelRnbnpnQ0lBSmRzVTFXOHAwaDNXR0N1bklNOSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzA6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC9wcm9kdWN0cyI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1720181616),
('v1aMHUu6d8n1U5Cgclya3M5iyjf8qxEFPPSkVc8c', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:127.0) Gecko/20100101 Firefox/127.0', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiRXRRaWdTUEgxMkxneUV3WlFJb2pQcXBpTFliR2JVTnpWcHVhazVYOSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NjU6Imh0dHA6Ly9jMTdiLTJhMDItODQyOC01NGEtOWUwMS02MDViLWNiZmItZDlmNC01NTI0Lm5ncm9rLWZyZWUuYXBwIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1720229205),
('vNUCdGjNmKEIbgOqv1URZkPg6BxjmyDvTo7KnTYf', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Code/1.91.0 Chrome/122.0.6261.156 Electron/29.4.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiek41UUZiR0pxN3NWbk9vdHV1Yk81SWZJVVk5SG1sRUtMdnFUUTVJTCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NTU6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC8/dnNjb2RlQnJvd3NlclJlcUlkPTE3MjAxODExODQ2MjEiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1720181184),
('wevr3CUsNqvf0piitV5MmSShpQynth3yIirkTkXA', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Code/1.91.0 Chrome/122.0.6261.156 Electron/29.4.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoibFg5Z0hJb0FYRVNWODFDa2hoVlgzODZTS2g0Y0ttWkxiVjhzVWdkMiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NTU6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC8/dnNjb2RlQnJvd3NlclJlcUlkPTE3MjAxODQzMjcwNTEiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1720184327),
('wS0kqTLrYXBcIN4JXYbKJdGoUfPHJ69cEvMQcnZn', NULL, '127.0.0.1', 'PostmanRuntime/7.39.0', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoidXJyeHV0VUY2UGwzSGNjNThKVHYxMnBmNzVBUWNtbjRzV2lTc3RIaSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjE6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMCI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1720187751),
('WyZIkTMuMmx55kW8ZuaKYc59cSKjonXGtqLScPIW', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Code/1.91.0 Chrome/122.0.6261.156 Electron/29.4.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoia3VhV05qTzE5eENXeWVSY05Zakc1UVRqWmVhcFUxSE9PSnlDQzNJdiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzA6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC9wcm9kdWN0cyI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1720182221),
('XBSEYleYItl7vRut0pr29F5npp0SAR6b2dVJEXEJ', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Code/1.91.0 Chrome/122.0.6261.156 Electron/29.4.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiS2ZQRDBpVUtobW4zYjd2OHlYVTRRTG1zY3ZQSk1lYVJpZmNpeklDeSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NTU6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC8/dnNjb2RlQnJvd3NlclJlcUlkPTE3MjAxODAwNTg3ODEiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1720180058),
('XLmVHC7yeMN2bk6z41ySYRCbJ5BWtUS8onPMMa7i', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/126.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoibmhxNVR5UVBhYUJDZTZzMkFMVjVEa1NacTQyMGR2REo4MjVPZ2tEdCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjE6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMCI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1720186963),
('z61YOHT9tI0pCme4ZuIRv8hD378UQYsOT3VpLWm7', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Code/1.91.0 Chrome/122.0.6261.156 Electron/29.4.0 Safari/537.36', 'YToyOntzOjY6Il90b2tlbiI7czo0MDoiVXFEWmt3bGowa1Y3Y29XaUh6clg1UklKbmxXVlR1NkhmdG85M0lWaCI7czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1720181618);

INSERT INTO `users` (`id`, `name`, `email`, `email_verified_at`, `password`, `stripe_customer_id`, `remember_token`, `created_at`, `updated_at`, `subscription_status`, `current_period_end`) VALUES
(14, 'Tom Sawyer', 'tototomss93@gmail.com', NULL, '$2y$12$GzTJs35Zm0eD.s3BLFl.FOaIZuonMdMQqxtFXRel.6c0Y.pfRuFIm', 'cus_QQEAk3fHeefQGw', NULL, '2024-07-06 01:36:12', '2024-07-06 01:47:29', 'active', '2024-08-06 01:46:26');



/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;