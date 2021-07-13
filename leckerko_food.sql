-- phpMyAdmin SQL Dump
-- version 4.9.7
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Jun 25, 2021 at 05:37 PM
-- Server version: 10.3.28-MariaDB-cll-lve
-- PHP Version: 7.3.28

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `u705432468_biker`
--

-- --------------------------------------------------------

--
-- Table structure for table `app_settings`
--

CREATE TABLE `app_settings` (
  `id` int(10) UNSIGNED NOT NULL,
  `key` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` text COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `app_settings`
--

INSERT INTO `app_settings` (`id`, `key`, `value`) VALUES
(7, 'date_format', 'l jS F Y (H:i:s)'),
(8, 'language', 'en'),
(17, 'is_human_date_format', '1'),
(18, 'app_name', 'Lecker'),
(19, 'app_short_description', 'Manage Mobile Application'),
(20, 'mail_driver', 'smtp'),
(21, 'mail_host', 'smtp.hostinger.com'),
(22, 'mail_port', '587'),
(23, 'mail_username', 'productdelivery@smartersvision.com'),
(24, 'mail_password', 'NnvAwk&&E7'),
(25, 'mail_encryption', 'ssl'),
(26, 'mail_from_address', 'productdelivery@smartersvision.com'),
(27, 'mail_from_name', 'Smarter Vision'),
(30, 'timezone', 'America/Montserrat'),
(32, 'theme_contrast', 'light'),
(33, 'theme_color', 'primary'),
(34, 'app_logo', '020a2dd4-4277-425a-b450-426663f52633'),
(35, 'nav_color', 'navbar-light bg-white'),
(38, 'logo_bg_color', 'bg-white'),
(66, 'default_role', 'admin'),
(68, 'facebook_app_id', '518416208939727'),
(69, 'facebook_app_secret', '93649810f78fa9ca0d48972fee2a75cd'),
(71, 'twitter_app_id', 'twitter'),
(72, 'twitter_app_secret', 'twitter 1'),
(74, 'google_app_id', '527129559488-roolg8aq110p8r1q952fqa9tm06gbloe.apps.googleusercontent.com'),
(75, 'google_app_secret', 'FpIi8SLgc69ZWodk-xHaOrxn'),
(77, 'enable_google', '1'),
(78, 'enable_facebook', '1'),
(93, 'enable_stripe', '1'),
(94, 'stripe_key', 'pk_test_pltzOnX3zsUZMoTTTVUL4O41'),
(95, 'stripe_secret', 'sk_test_o98VZx3RKDUytaokX4My3a20'),
(101, 'custom_field_models.0', 'App\\Models\\User'),
(104, 'default_tax', '10'),
(107, 'default_currency', '$'),
(108, 'fixed_header', '0'),
(109, 'fixed_footer', '0'),
(110, 'fcm_key', 'AAAAHMZiAQA:APA91bEb71b5sN5jl-w_mmt6vLfgGY5-_CQFxMQsVEfcwO3FAh4-mk1dM6siZwwR3Ls9U0pRDpm96WN1AmrMHQ906GxljILqgU2ZB6Y1TjiLyAiIUETpu7pQFyicER8KLvM9JUiXcfWK'),
(111, 'enable_notifications', '1'),
(112, 'paypal_username', 'sb-z3gdq482047_api1.business.example.com'),
(113, 'paypal_password', 'JV2A7G4SEMLMZ565'),
(114, 'paypal_secret', 'AbMmSXVaig1ExpY3utVS3dcAjx7nAHH0utrZsUN6LYwPgo7wfMzrV5WZ'),
(115, 'enable_paypal', '1'),
(116, 'main_color', '#25D366'),
(117, 'main_dark_color', '#25D366'),
(118, 'second_color', '#043832'),
(119, 'second_dark_color', '#ccccdd'),
(120, 'accent_color', '#8c98a8'),
(121, 'accent_dark_color', '#9999aa'),
(122, 'scaffold_dark_color', '#2c2c2c'),
(123, 'scaffold_color', '#fafafa'),
(124, 'google_maps_key', 'AIzaSyCaNUDAM3xlf3i55pS3evhCrUmbiluyjHg'),
(125, 'mobile_language', 'en'),
(126, 'app_version', '2.0.0'),
(127, 'enable_version', '1'),
(128, 'default_currency_id', '1'),
(129, 'default_currency_code', 'USD'),
(130, 'default_currency_decimal_digits', '2'),
(131, 'default_currency_rounding', '0'),
(132, 'currency_right', '0'),
(157, 'home_section_1', 'slider'),
(158, 'home_section_2', 'search'),
(159, 'home_section_3', 'top_markets_heading'),
(160, 'home_section_4', 'top_markets'),
(161, 'home_section_5', 'trending_week_heading'),
(162, 'home_section_6', 'trending_week'),
(163, 'home_section_7', 'categories_heading'),
(164, 'home_section_8', 'categories'),
(165, 'home_section_9', 'popular_heading'),
(166, 'home_section_10', 'popular'),
(167, 'home_section_11', 'recent_reviews_heading'),
(168, 'home_section_12', 'recent_reviews'),
(169, 'home_section_13', 'lecker_mart');

-- --------------------------------------------------------

--
-- Table structure for table `carts`
--

CREATE TABLE `carts` (
  `id` int(10) UNSIGNED NOT NULL,
  `product_id` int(10) UNSIGNED NOT NULL,
  `user_id` int(10) UNSIGNED NOT NULL,
  `quantity` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `carts`
--

INSERT INTO `carts` (`id`, `product_id`, `user_id`, `quantity`, `created_at`, `updated_at`) VALUES
(2, 24, 3, 1, '2021-06-17 18:35:17', '2021-06-17 18:35:17');

-- --------------------------------------------------------

--
-- Table structure for table `cart_options`
--

CREATE TABLE `cart_options` (
  `option_id` int(10) UNSIGNED NOT NULL,
  `cart_id` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `categories`
--

CREATE TABLE `categories` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(127) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `categories`
--

INSERT INTO `categories` (`id`, `name`, `description`, `created_at`, `updated_at`) VALUES
(1, 'Foods', 'Nihil tempora ea nihil et ab tempora et. Laboriosam ut consequuntur deleniti pariatur. Autem molestias rem et. Est dolorum omnis et sint doloremque eum. Natus quis hic enim rerum.', '2021-06-17 17:39:52', '2021-06-17 17:39:52'),
(2, 'Foods', 'Tempora nostrum repellat dolores. Reiciendis incidunt quod delectus exercitationem et repellendus. Illo dolorem at accusantium pariatur magnam rem. Unde soluta ea quas atque sed. Ut harum et omnis voluptas quia temporibus dolor accusamus.', '2021-06-17 17:39:52', '2021-06-17 17:39:52'),
(3, 'Fruit', 'Rerum impedit quas possimus asperiores. Qui vel accusantium reprehenderit similique qui autem. Cupiditate rerum enim et voluptas sunt culpa cupiditate explicabo. Dolorem corrupti facere dolor consequatur quasi. Qui consequatur qui maxime aut quaerat.', '2021-06-17 17:39:53', '2021-06-17 17:39:53'),
(4, 'Foods', 'Sed consectetur repellat impedit eaque commodi architecto. Est asperiores dolorem natus non. At enim omnis explicabo. Laboriosam distinctio ut et labore accusamus tempore. Consequatur non illum at sed suscipit ipsam.', '2021-06-17 17:39:53', '2021-06-17 17:39:53'),
(5, 'Foods', 'Veniam dolor qui vel ipsum a. Odio fugiat quam dolores sed aliquam dolorum. Rerum et quas aut alias voluptatibus accusamus. Explicabo sit quis rem et molestiae vitae. Esse cumque natus accusamus laborum.', '2021-06-17 17:39:53', '2021-06-17 17:39:53'),
(6, 'Drinks', 'Atque reiciendis id expedita fuga atque. Aut molestiae similique sed delectus. Nemo maiores sed aut dicta voluptatum. Tenetur sunt repellat voluptate ut. Autem beatae suscipit hic nostrum aut qui sapiente deleniti.', '2021-06-17 17:39:53', '2021-06-17 17:39:53');

-- --------------------------------------------------------

--
-- Table structure for table `coupons`
--

CREATE TABLE `coupons` (
  `id` int(10) UNSIGNED NOT NULL,
  `code` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `discount` double(8,2) NOT NULL DEFAULT 0.00,
  `discount_type` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'percent',
  `description` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `expires_at` datetime DEFAULT NULL,
  `enabled` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `currencies`
--

CREATE TABLE `currencies` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(127) COLLATE utf8mb4_unicode_ci NOT NULL,
  `symbol` varchar(63) COLLATE utf8mb4_unicode_ci NOT NULL,
  `code` varchar(5) COLLATE utf8mb4_unicode_ci NOT NULL,
  `decimal_digits` tinyint(3) UNSIGNED DEFAULT NULL,
  `rounding` tinyint(3) UNSIGNED DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `currencies`
--

INSERT INTO `currencies` (`id`, `name`, `symbol`, `code`, `decimal_digits`, `rounding`, `created_at`, `updated_at`) VALUES
(1, 'US Dollar', '$', 'USD', 2, 0, '2019-10-22 14:50:48', '2019-10-22 14:50:48'),
(2, 'Euro', '€', 'EUR', 2, 0, '2019-10-22 14:51:39', '2019-10-22 14:51:39'),
(3, 'Indian Rupee', 'টকা', 'INR', 2, 0, '2019-10-22 14:52:50', '2019-10-22 14:52:50'),
(4, 'Indonesian Rupiah', 'Rp', 'IDR', 0, 0, '2019-10-22 14:53:22', '2019-10-22 14:53:22'),
(5, 'Brazilian Real', 'R$', 'BRL', 2, 0, '2019-10-22 14:54:00', '2019-10-22 14:54:00'),
(6, 'Cambodian Riel', '៛', 'KHR', 2, 0, '2019-10-22 14:55:51', '2019-10-22 14:55:51'),
(7, 'Vietnamese Dong', '₫', 'VND', 0, 0, '2019-10-22 14:56:26', '2019-10-22 14:56:26');

-- --------------------------------------------------------

--
-- Table structure for table `custom_fields`
--

CREATE TABLE `custom_fields` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(127) COLLATE utf8mb4_unicode_ci NOT NULL,
  `type` varchar(56) COLLATE utf8mb4_unicode_ci NOT NULL,
  `values` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `disabled` tinyint(1) DEFAULT NULL,
  `required` tinyint(1) DEFAULT NULL,
  `in_table` tinyint(1) DEFAULT NULL,
  `bootstrap_column` tinyint(4) DEFAULT NULL,
  `order` tinyint(4) DEFAULT NULL,
  `custom_field_model` varchar(127) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `custom_fields`
--

INSERT INTO `custom_fields` (`id`, `name`, `type`, `values`, `disabled`, `required`, `in_table`, `bootstrap_column`, `order`, `custom_field_model`, `created_at`, `updated_at`) VALUES
(4, 'phone', 'text', NULL, 0, 0, 0, 6, 2, 'App\\Models\\User', '2019-09-06 20:30:00', '2019-09-06 20:31:47'),
(5, 'bio', 'textarea', NULL, 0, 0, 0, 6, 1, 'App\\Models\\User', '2019-09-06 20:43:58', '2019-09-06 20:43:58'),
(6, 'address', 'text', NULL, 0, 0, 0, 6, 3, 'App\\Models\\User', '2019-09-06 20:49:22', '2019-09-06 20:49:22'),
(7, 'verifiedPhone', 'text', NULL, 1, 0, 0, 6, 4, 'App\\Models\\User', '2021-03-20 10:49:22', '2021-03-20 10:49:22');

-- --------------------------------------------------------

--
-- Table structure for table `custom_field_values`
--

CREATE TABLE `custom_field_values` (
  `id` int(10) UNSIGNED NOT NULL,
  `value` longtext COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `view` longtext COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `custom_field_id` int(10) UNSIGNED NOT NULL,
  `customizable_type` varchar(127) COLLATE utf8mb4_unicode_ci NOT NULL,
  `customizable_id` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `custom_field_values`
--

INSERT INTO `custom_field_values` (`id`, `value`, `view`, `custom_field_id`, `customizable_type`, `customizable_id`, `created_at`, `updated_at`) VALUES
(29, '+136 226 5669', '+136 226 5669', 4, 'App\\Models\\User', 2, '2019-09-06 20:52:30', '2019-09-06 20:52:30'),
(30, 'Lobortis mattis aliquam faucibus purus. Habitasse platea dictumst vestibulum rhoncus est pellentesque elit. Nunc vel risus commodo viverra maecenas accumsan lacus vel.', 'Lobortis mattis aliquam faucibus purus. Habitasse platea dictumst vestibulum rhoncus est pellentesque elit. Nunc vel risus commodo viverra maecenas accumsan lacus vel.', 5, 'App\\Models\\User', 2, '2019-09-06 20:52:30', '2019-10-16 18:32:35'),
(31, '2911 Corpening Drive South Lyon, MI 48178', '2911 Corpening Drive South Lyon, MI 48178', 6, 'App\\Models\\User', 2, '2019-09-06 20:52:30', '2019-10-16 18:32:35'),
(32, '+136 226 5660', '+136 226 5660', 4, 'App\\Models\\User', 1, '2019-09-06 20:53:58', '2019-09-27 07:12:04'),
(33, 'Faucibus ornare suspendisse sed nisi lacus sed. Pellentesque sit amet porttitor eget dolor morbi non arcu. Eu scelerisque felis imperdiet proin fermentum leo vel orci porta', 'Faucibus ornare suspendisse sed nisi lacus sed. Pellentesque sit amet porttitor eget dolor morbi non arcu. Eu scelerisque felis imperdiet proin fermentum leo vel orci porta', 5, 'App\\Models\\User', 1, '2019-09-06 20:53:58', '2019-10-16 18:23:53'),
(34, '569 Braxton Street Cortland, IL 60112', '569 Braxton Street Cortland, IL 60112', 6, 'App\\Models\\User', 1, '2019-09-06 20:53:58', '2019-10-16 18:23:53'),
(35, '+34622234505', '+34622234505', 4, 'App\\Models\\User', 3, '2019-10-15 16:21:32', '2021-06-17 18:36:37'),
(36, 'yo soy', 'yo soy', 5, 'App\\Models\\User', 3, '2019-10-15 16:21:32', '2021-06-17 18:36:37'),
(37, 'emisora 20 Madrid', 'emisora 20 Madrid', 6, 'App\\Models\\User', 3, '2019-10-15 16:21:32', '2021-06-17 18:36:38'),
(38, '+1 248-437-7610', '+1 248-437-7610', 4, 'App\\Models\\User', 4, '2019-10-16 18:31:46', '2019-10-16 18:31:46'),
(39, 'Faucibus ornare suspendisse sed nisi lacus sed. Pellentesque sit amet porttitor eget dolor morbi non arcu. Eu scelerisque felis imperdiet proin fermentum leo vel orci porta', 'Faucibus ornare suspendisse sed nisi lacus sed. Pellentesque sit amet porttitor eget dolor morbi non arcu. Eu scelerisque felis imperdiet proin fermentum leo vel orci porta', 5, 'App\\Models\\User', 4, '2019-10-16 18:31:46', '2019-10-16 18:31:46'),
(40, '1050 Frosty Lane Sidney, NY 13838', '1050 Frosty Lane Sidney, NY 13838', 6, 'App\\Models\\User', 4, '2019-10-16 18:31:46', '2019-10-16 18:31:46'),
(41, '+136 226 5669', '+136 226 5669', 4, 'App\\Models\\User', 5, '2019-12-15 18:49:44', '2019-12-15 18:49:44'),
(42, '<p>Short Bio</p>', 'Short Bio', 5, 'App\\Models\\User', 5, '2019-12-15 18:49:44', '2019-12-15 18:49:44'),
(43, '4722 Villa Drive', '4722 Villa Drive', 6, 'App\\Models\\User', 5, '2019-12-15 18:49:44', '2019-12-15 18:49:44'),
(44, '+136 955 6525', '+136 955 6525', 4, 'App\\Models\\User', 6, '2020-03-29 16:28:04', '2020-03-29 16:28:04'),
(45, '<p>Short bio for this driver</p>', 'Short bio for this driver', 5, 'App\\Models\\User', 6, '2020-03-29 16:28:05', '2020-03-29 16:28:05'),
(46, '4722 Villa Drive', '4722 Villa Drive', 6, 'App\\Models\\User', 6, '2020-03-29 16:28:05', '2020-03-29 16:28:05'),
(47, '0', '0', 7, 'App\\Models\\User', 3, '2021-06-17 18:36:38', '2021-06-17 18:36:38'),
(48, '+923126661717', '+923126661717', 4, 'App\\Models\\User', 7, '2021-06-18 04:50:47', '2021-06-18 04:50:47'),
(49, NULL, '', 5, 'App\\Models\\User', 7, '2021-06-18 04:50:47', '2021-06-18 04:50:47'),
(50, NULL, NULL, 6, 'App\\Models\\User', 7, '2021-06-18 04:50:47', '2021-06-18 04:50:47'),
(51, NULL, NULL, 7, 'App\\Models\\User', 7, '2021-06-18 04:50:47', '2021-06-18 04:50:47');

-- --------------------------------------------------------

--
-- Table structure for table `delivery_addresses`
--

CREATE TABLE `delivery_addresses` (
  `id` int(10) UNSIGNED NOT NULL,
  `description` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `address` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `latitude` varchar(24) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `longitude` varchar(24) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_default` tinyint(1) DEFAULT NULL,
  `user_id` int(10) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `delivery_addresses`
--

INSERT INTO `delivery_addresses` (`id`, `description`, `address`, `latitude`, `longitude`, `is_default`, `user_id`, `created_at`, `updated_at`) VALUES
(1, 'Accusamus ipsam distinctio soluta non.', '23405 Doyle Lake Suite 004\nEast Arjun, MA 28006', '-50.640475', '-145.302735', 1, 3, '2021-06-17 17:39:57', '2021-06-17 20:04:30'),
(2, 'Consequatur qui et sapiente ut.', '704 Bogisich Light\nTreburgh, FL 90737-0504', '4.46687', '86.073463', 0, 4, '2021-06-17 17:39:57', '2021-06-18 15:36:55'),
(3, 'A neque quisquam autem quod quisquam quia qui.', '972 Cronin Mews Suite 209\nCassandrabury, TN 98213', '2.596944', '89.121759', 0, 3, '2021-06-17 17:39:57', '2021-06-17 20:04:30'),
(4, 'Voluptates doloremque assumenda voluptatibus aut voluptatem est quia totam.', '113 Arden Cliffs Suite 830\nMacejkovicmouth, RI 27246-8665', '-80.180559', '-15.836177', 0, 6, '2021-06-17 17:39:57', '2021-06-17 17:39:57'),
(5, 'Omnis qui voluptates nemo.', '6872 Zoila Turnpike Apt. 739\nNorth Elmo, AK 08125-0622', '81.300758', '-141.701065', 1, 6, '2021-06-17 17:39:57', '2021-06-17 17:39:57'),
(6, 'Provident est maxime voluptatem tempora tempora eligendi tenetur.', '64966 Champlin Forest Suite 614\nNew Laurence, MN 86381-6718', '-21.986507', '149.534719', 0, 3, '2021-06-17 17:39:57', '2021-06-17 17:39:57'),
(7, 'Iste perspiciatis voluptatem eos natus natus dolores tempore.', '484 Chanel Court Apt. 861\nLeannafurt, NH 59699-4609', '-69.443267', '-116.838469', 0, 4, '2021-06-17 17:39:57', '2021-06-17 17:39:57'),
(8, 'Commodi debitis quia sunt debitis quidem praesentium.', '825 Gerlach Common\nEast Lelahfurt, KY 89399', '-66.779261', '88.44319', 1, 6, '2021-06-17 17:39:57', '2021-06-17 17:39:57'),
(9, 'Recusandae incidunt animi sapiente laudantium alias et.', '124 Maggio Viaduct Suite 814\nNikolausview, AZ 48904', '-1.465256', '125.875043', 0, 3, '2021-06-17 17:39:57', '2021-06-17 20:04:30'),
(10, 'Nulla rerum omnis sit ad.', '2384 Derick Isle\nPort Jazlynborough, DE 50767-2875', '80.372539', '27.385959', 0, 1, '2021-06-17 17:39:57', '2021-06-17 17:39:57'),
(11, 'Architecto molestiae rerum ut sit aut saepe vel.', '5991 Lou Stream Apt. 011\nJosianebury, NC 58814', '50.478964', '-114.017421', 1, 4, '2021-06-17 17:39:57', '2021-06-18 15:36:55'),
(12, 'Eveniet est quia qui.', '89530 Taurean Radial\nSouth Nicholausstad, NC 21797', '13.058818', '167.908909', 0, 4, '2021-06-17 17:39:57', '2021-06-17 17:39:57'),
(13, 'Velit molestias et esse et ut.', '41745 Osinski Extension Apt. 738\nDelberttown, ND 12631-4446', '-84.331089', '43.666234', 0, 5, '2021-06-17 17:39:57', '2021-06-17 17:39:57'),
(14, 'Tenetur fugiat quia et ipsam.', '62105 Darrel Valleys\nHillberg, UT 27229', '77.27963', '161.435475', 1, 6, '2021-06-17 17:39:57', '2021-06-17 17:39:57'),
(15, 'Aut incidunt qui molestiae beatae ex dolor ullam.', '73039 Dolly Stravenue\nCordiachester, WI 32455-5665', '66.211246', '70.072995', 0, 6, '2021-06-17 17:39:57', '2021-06-17 17:39:57');

-- --------------------------------------------------------

--
-- Table structure for table `discountables`
--

CREATE TABLE `discountables` (
  `id` int(10) UNSIGNED NOT NULL,
  `coupon_id` int(10) UNSIGNED NOT NULL,
  `discountable_type` varchar(127) COLLATE utf8mb4_unicode_ci NOT NULL,
  `discountable_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `drivers`
--

CREATE TABLE `drivers` (
  `id` int(10) UNSIGNED NOT NULL,
  `user_id` int(10) UNSIGNED NOT NULL,
  `delivery_fee` double(5,2) NOT NULL DEFAULT 0.00,
  `total_orders` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `earning` double(9,2) NOT NULL DEFAULT 0.00,
  `available` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `drivers_payouts`
--

CREATE TABLE `drivers_payouts` (
  `id` int(10) UNSIGNED NOT NULL,
  `user_id` int(10) UNSIGNED NOT NULL,
  `method` varchar(127) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `amount` double(9,2) NOT NULL DEFAULT 0.00,
  `paid_date` datetime DEFAULT NULL,
  `note` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `driver_markets`
--

CREATE TABLE `driver_markets` (
  `user_id` int(10) UNSIGNED NOT NULL,
  `market_id` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `driver_markets`
--

INSERT INTO `driver_markets` (`user_id`, `market_id`) VALUES
(5, 1),
(5, 2),
(5, 4),
(6, 2),
(6, 3),
(6, 4);

-- --------------------------------------------------------

--
-- Table structure for table `earnings`
--

CREATE TABLE `earnings` (
  `id` int(10) UNSIGNED NOT NULL,
  `market_id` int(10) UNSIGNED NOT NULL,
  `total_orders` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `total_earning` double(9,2) NOT NULL DEFAULT 0.00,
  `admin_earning` double(9,2) NOT NULL DEFAULT 0.00,
  `market_earning` double(9,2) NOT NULL DEFAULT 0.00,
  `delivery_fee` double(9,2) NOT NULL DEFAULT 0.00,
  `tax` double(9,2) NOT NULL DEFAULT 0.00,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `earnings`
--

INSERT INTO `earnings` (`id`, `market_id`, `total_orders`, `total_earning`, `admin_earning`, `market_earning`, `delivery_fee`, `tax`, `created_at`, `updated_at`) VALUES
(1, 4, 0, 0.00, 0.00, 0.00, 0.00, 0.00, '2021-06-19 09:04:47', '2021-06-19 09:04:47'),
(2, 3, 0, 0.00, 0.00, 0.00, 0.00, 0.00, '2021-06-20 13:03:57', '2021-06-20 13:03:57');

-- --------------------------------------------------------

--
-- Table structure for table `faqs`
--

CREATE TABLE `faqs` (
  `id` int(10) UNSIGNED NOT NULL,
  `question` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `answer` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `faq_category_id` int(10) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `faqs`
--

INSERT INTO `faqs` (`id`, `question`, `answer`, `faq_category_id`, `created_at`, `updated_at`) VALUES
(1, 'Modi architecto maiores quas sit nihil. Illum magni aut placeat commodi. Libero tempora ut et.', 'Lobster Quadrille is!\' \'No, indeed,\' said Alice. \'Why, there they are!\' said the Dodo managed it.) First it marked out a history of the baby?\' said the Cat, and vanished again. Alice waited.', 3, '2021-06-17 17:39:59', '2021-06-17 17:39:59'),
(2, 'Id impedit illum provident. Occaecati aliquid non et mollitia.', 'She went in without knocking, and hurried upstairs, in great disgust, and walked two and two, as the game was in the schoolroom, and though this was his first remark, \'It was the cat.) \'I hope.', 3, '2021-06-17 17:39:59', '2021-06-17 17:39:59'),
(3, 'Repellat animi sit aut sapiente. Fuga ab et possimus atque quam aut et optio.', 'She soon got it out loud. \'Thinking again?\' the Duchess by this time.) \'You\'re nothing but the Mouse in the pictures of him), while the Mouse replied rather impatiently: \'any shrimp could have told.', 4, '2021-06-17 17:39:59', '2021-06-17 17:39:59'),
(4, 'Et dolor odio voluptatem illum. Quis vel libero sit harum aut. Eaque enim eos deserunt et.', 'Alice and all sorts of things--I can\'t remember things as I used--and I don\'t know,\' he went on saying to her great delight it fitted! Alice opened the door began sneezing all at once. The Dormouse.', 4, '2021-06-17 17:39:59', '2021-06-17 17:39:59'),
(5, 'Expedita voluptas qui quibusdam cupiditate veniam. Ut nihil aut sapiente et.', 'Why, she\'ll eat a bat?\' when suddenly, thump! thump! down she came upon a little sharp bark just over her head pressing against the roof of the sea.\' \'I couldn\'t help it,\' said Alice, timidly; \'some.', 2, '2021-06-17 17:39:59', '2021-06-17 17:39:59'),
(6, 'Aut ut at qui id voluptatem deleniti ut. Ea omnis enim quos vero perferendis ut quos et.', 'Alice guessed who it was, even before she came rather late, and the little door, so she waited. The Gryphon lifted up both its paws in surprise. \'What! Never heard of uglifying!\' it exclaimed. \'You.', 1, '2021-06-17 17:39:59', '2021-06-17 17:39:59'),
(7, 'Vel magnam omnis alias aliquid voluptas. Rerum aperiam atque ipsa voluptatem.', 'Hatter. \'I told you butter wouldn\'t suit the works!\' he added in a solemn tone, \'For the Duchess. \'I make you a present of everything I\'ve said as yet.\' \'A cheap sort of thing that would happen.', 2, '2021-06-17 17:39:59', '2021-06-17 17:39:59'),
(8, 'Dolorum minus quia error illo voluptatem vitae. Provident molestiae ab dolor.', 'Gryphon, \'that they WOULD go with the other: the only difficulty was, that if something wasn\'t done about it while the Mock Turtle, capering wildly about. \'Change lobsters again!\' yelled the Gryphon.', 2, '2021-06-17 17:39:59', '2021-06-17 17:39:59'),
(9, 'Architecto aut et non. Laborum optio ea eum sit inventore dolorem officia.', 'Queen, but she had forgotten the Duchess to play croquet.\' Then they both bowed low, and their slates and pencils had been jumping about like mad things all this time, sat down a large pool all.', 1, '2021-06-17 17:39:59', '2021-06-17 17:39:59'),
(10, 'Quae quia recusandae explicabo et quam. Soluta ratione pariatur ducimus molestiae laudantium.', 'English!\' said the Pigeon; \'but I haven\'t had a wink of sleep these three little sisters,\' the Dormouse went on, \'What HAVE you been doing here?\' \'May it please your Majesty!\' the Duchess and the.', 2, '2021-06-17 17:39:59', '2021-06-17 17:39:59'),
(11, 'Autem qui dolorem eos at. Illo inventore modi ut.', 'Alice. \'Call it what you were all shaped like the Mock Turtle had just begun to repeat it, but her voice sounded hoarse and strange, and the beak-- Pray how did you manage to do it! Oh dear! I wish.', 1, '2021-06-17 17:39:59', '2021-06-17 17:39:59'),
(12, 'Est quaerat optio dolores. Et iure itaque nulla molestiae sed amet quia.', 'I goes like a Jack-in-the-box, and up I goes like a wild beast, screamed \'Off with their hands and feet, to make out at all fairly,\' Alice began, in rather a hard word, I will tell you my.', 1, '2021-06-17 17:39:59', '2021-06-17 17:39:59'),
(13, 'Illo velit itaque magnam beatae aut nobis. Velit id sunt porro quasi.', 'English. \'I don\'t even know what they\'re like.\' \'I believe so,\' Alice replied eagerly, for she felt that there was the first position in which case it would be very likely it can talk: at any rate.', 4, '2021-06-17 17:39:59', '2021-06-17 17:39:59'),
(14, 'Tempore tempora enim odio molestiae. Aliquid cum reiciendis dignissimos ipsum eos placeat.', 'I can creep under the sea--\' (\'I haven\'t,\' said Alice)--\'and perhaps you haven\'t found it advisable--\"\' \'Found WHAT?\' said the Mouse, in a hurry. \'No, I\'ll look first,\' she said, \'than waste it in.', 3, '2021-06-17 17:39:59', '2021-06-17 17:39:59'),
(15, 'Aspernatur molestias qui alias quibusdam libero. Voluptate odit aut porro nemo fugiat culpa.', 'I\'ve finished.\' So they got their tails in their mouths--and they\'re all over with diamonds, and walked two and two, as the game was in managing her flamingo: she succeeded in bringing herself down.', 4, '2021-06-17 17:39:59', '2021-06-17 17:39:59'),
(16, 'Enim rerum et esse est nihil quo. Saepe eum aperiam omnis provident. Doloribus quia earum et qui.', 'It was the White Rabbit with pink eyes ran close by her. There was exactly one a-piece all round. (It was this last remark, \'it\'s a vegetable. It doesn\'t look like one, but it was out of his head.', 4, '2021-06-17 17:39:59', '2021-06-17 17:39:59'),
(17, 'Nemo tempore non odit. Assumenda voluptas incidunt vel. Eveniet reprehenderit delectus sit eum.', 'BEST butter,\' the March Hare moved into the roof off.\' After a minute or two, looking for the baby, and not to make ONE respectable person!\' Soon her eye fell on a bough of a tree. \'Did you speak?\'.', 1, '2021-06-17 17:39:59', '2021-06-17 17:39:59'),
(18, 'Sit non laboriosam aut et. Eveniet ducimus dicta vitae dolores.', 'Hatter began, in a court of justice before, but she did so, and giving it a minute or two, which gave the Pigeon in a minute or two, and the White Rabbit; \'in fact, there\'s nothing written on the.', 1, '2021-06-17 17:39:59', '2021-06-17 17:39:59'),
(19, 'Similique ratione quidem magnam doloremque. Et sapiente blanditiis mollitia rerum quia.', 'I can find out the Fish-Footman was gone, and, by the fire, licking her paws and washing her face--and she is only a pack of cards, after all. \"--SAID I COULD NOT SWIM--\" you can\'t be Mabel, for I.', 2, '2021-06-17 17:39:59', '2021-06-17 17:39:59'),
(20, 'Non magnam eaque similique explicabo. Eveniet commodi omnis corporis voluptates laudantium.', 'Alice said to herself, as she remembered trying to explain it is right?\' \'In my youth,\' Father William replied to his ear. Alice considered a little scream of laughter. \'Oh, hush!\' the Rabbit.', 2, '2021-06-17 17:39:59', '2021-06-17 17:39:59'),
(21, 'Sint rerum praesentium illum aperiam consequatur vel. Nihil architecto at ut ullam aut dolor.', 'Alice, a good character, But said I didn\'t!\' interrupted Alice. \'You must be,\' said the Mock Turtle at last, more calmly, though still sobbing a little girl or a watch to take the place of the.', 1, '2021-06-17 17:39:59', '2021-06-17 17:39:59'),
(22, 'Nihil magnam facere nihil. Sunt laboriosam et earum suscipit est.', 'Mock Turtle. Alice was beginning to see what was going to be, from one foot to the cur, \"Such a trial, dear Sir, With no jury or judge, would be offended again. \'Mine is a very little use without my.', 3, '2021-06-17 17:39:59', '2021-06-17 17:39:59'),
(23, 'Quia assumenda laborum natus expedita. Nesciunt dolore voluptatem in nihil.', 'Gryphon, the squeaking of the legs of the evening, beautiful Soup! \'Beautiful Soup! Who cares for fish, Game, or any other dish? Who would not join the dance. Would not, could not, would not, could.', 1, '2021-06-17 17:39:59', '2021-06-17 17:39:59'),
(24, 'Eaque veritatis distinctio magni quia quisquam quos harum. Enim sequi deleniti ut animi.', 'Alice; and Alice was not going to turn into a tidy little room with a large kitchen, which was immediately suppressed by the prisoner to--to somebody.\' \'It must be on the bank, with her face.', 3, '2021-06-17 17:39:59', '2021-06-17 17:39:59'),
(25, 'Nihil iusto vero ut aut fugiat fugit. Voluptas dignissimos modi sit sunt recusandae numquam rerum.', 'ITS WAISTCOAT-POCKET, and looked very uncomfortable. The first thing she heard a little scream, half of fright and half believed herself in a low voice, to the part about her repeating \'YOU ARE OLD.', 4, '2021-06-17 17:39:59', '2021-06-17 17:39:59'),
(26, 'Veritatis et ut occaecati neque. Voluptas quia corrupti omnis aut. Neque ut nihil et cupiditate.', 'Alice\'s elbow was pressed hard against it, that attempt proved a failure. Alice heard the Rabbit was no time to wash the things I used to it!\' pleaded poor Alice. \'But you\'re so easily offended!\'.', 4, '2021-06-17 17:39:59', '2021-06-17 17:39:59'),
(27, 'Odio autem consequatur natus ullam magni. Atque cumque tempora numquam corporis.', 'It was the matter on, What would become of me?\' Luckily for Alice, the little passage: and THEN--she found herself in Wonderland, though she looked at them with large eyes full of smoke from one end.', 1, '2021-06-17 17:39:59', '2021-06-17 17:39:59'),
(28, 'Voluptas rerum eligendi repellendus. Et et et quia labore culpa.', 'Ugh, Serpent!\' \'But I\'m NOT a serpent!\' said Alice in a minute, nurse! But I\'ve got to the law, And argued each case with my wife; And the Eaglet bent down its head to hide a smile: some of them.', 1, '2021-06-17 17:39:59', '2021-06-17 17:39:59'),
(29, 'Molestiae dolore quibusdam ut similique dolor et. Perferendis quo quas pariatur quia.', 'Alice, quite forgetting in the direction in which case it would be like, \'--for they haven\'t got much evidence YET,\' she said this last remark, \'it\'s a vegetable. It doesn\'t look like it?\' he said.', 3, '2021-06-17 17:39:59', '2021-06-17 17:39:59'),
(30, 'Saepe odio tempore vero nemo. Magnam aut enim perspiciatis. Assumenda aperiam dolor explicabo ea.', 'However, this bottle was a good deal frightened by this time, as it is.\' \'I quite forgot you didn\'t like cats.\' \'Not like cats!\' cried the Gryphon, half to Alice. \'What sort of use in talking to.', 3, '2021-06-17 17:39:59', '2021-06-17 17:39:59');

-- --------------------------------------------------------

--
-- Table structure for table `faq_categories`
--

CREATE TABLE `faq_categories` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(127) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `faq_categories`
--

INSERT INTO `faq_categories` (`id`, `name`, `created_at`, `updated_at`) VALUES
(1, 'Products', '2019-08-31 11:31:52', '2019-08-31 11:31:52'),
(2, 'Services', '2019-08-31 11:32:03', '2019-08-31 11:32:03'),
(3, 'Delivery', '2019-08-31 11:32:11', '2019-08-31 11:32:11'),
(4, 'Misc', '2019-08-31 11:32:17', '2019-08-31 11:32:17');

-- --------------------------------------------------------

--
-- Table structure for table `favorites`
--

CREATE TABLE `favorites` (
  `id` int(10) UNSIGNED NOT NULL,
  `product_id` int(10) UNSIGNED NOT NULL,
  `user_id` int(10) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `favorites`
--

INSERT INTO `favorites` (`id`, `product_id`, `user_id`, `created_at`, `updated_at`) VALUES
(1, 23, 4, '2021-06-17 17:39:59', '2021-06-17 17:39:59'),
(2, 25, 6, '2021-06-17 17:39:59', '2021-06-17 17:39:59'),
(3, 20, 3, '2021-06-17 17:39:59', '2021-06-17 17:39:59'),
(4, 5, 5, '2021-06-17 17:39:59', '2021-06-17 17:39:59'),
(5, 16, 4, '2021-06-17 17:40:00', '2021-06-17 17:40:00'),
(6, 15, 4, '2021-06-17 17:40:00', '2021-06-17 17:40:00'),
(7, 26, 3, '2021-06-17 17:40:00', '2021-06-17 17:40:00'),
(8, 23, 5, '2021-06-17 17:40:00', '2021-06-17 17:40:00'),
(9, 15, 1, '2021-06-17 17:40:00', '2021-06-17 17:40:00'),
(10, 29, 3, '2021-06-17 17:40:00', '2021-06-17 17:40:00'),
(11, 22, 2, '2021-06-17 17:40:00', '2021-06-17 17:40:00'),
(12, 14, 3, '2021-06-17 17:40:00', '2021-06-17 17:40:00'),
(13, 6, 1, '2021-06-17 17:40:00', '2021-06-17 17:40:00'),
(14, 29, 2, '2021-06-17 17:40:00', '2021-06-17 17:40:00'),
(15, 24, 1, '2021-06-17 17:40:00', '2021-06-17 17:40:00'),
(16, 20, 5, '2021-06-17 17:40:00', '2021-06-17 17:40:00'),
(17, 3, 3, '2021-06-17 17:40:00', '2021-06-17 17:40:00'),
(18, 5, 4, '2021-06-17 17:40:00', '2021-06-17 17:40:00'),
(19, 12, 6, '2021-06-17 17:40:00', '2021-06-17 17:40:00'),
(20, 3, 5, '2021-06-17 17:40:00', '2021-06-17 17:40:00'),
(21, 21, 4, '2021-06-17 17:40:00', '2021-06-17 17:40:00'),
(22, 23, 4, '2021-06-17 17:40:00', '2021-06-17 17:40:00'),
(23, 2, 4, '2021-06-17 17:40:00', '2021-06-17 17:40:00'),
(24, 8, 3, '2021-06-17 17:40:00', '2021-06-17 17:40:00'),
(25, 21, 2, '2021-06-17 17:40:00', '2021-06-17 17:40:00'),
(26, 24, 6, '2021-06-17 17:40:00', '2021-06-17 17:40:00'),
(27, 11, 3, '2021-06-17 17:40:00', '2021-06-17 17:40:00'),
(28, 22, 6, '2021-06-17 17:40:01', '2021-06-17 17:40:01'),
(29, 28, 1, '2021-06-17 17:40:01', '2021-06-17 17:40:01'),
(30, 27, 6, '2021-06-17 17:40:01', '2021-06-17 17:40:01');

-- --------------------------------------------------------

--
-- Table structure for table `favorite_options`
--

CREATE TABLE `favorite_options` (
  `option_id` int(10) UNSIGNED NOT NULL,
  `favorite_id` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `favorite_options`
--

INSERT INTO `favorite_options` (`option_id`, `favorite_id`) VALUES
(1, 1),
(1, 5),
(2, 6),
(3, 2),
(5, 3);

-- --------------------------------------------------------

--
-- Table structure for table `fields`
--

CREATE TABLE `fields` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(127) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `fields`
--

INSERT INTO `fields` (`id`, `name`, `description`, `created_at`, `updated_at`) VALUES
(1, 'Grocery', 'Eum similique maiores atque quia explicabo. Dolores quia placeat consequatur id quis perspiciatis. Ducimus sit ducimus officia labore maiores et porro. Est iusto natus nesciunt debitis consequuntur totam. Et illo et autem inventore earum corrupti.', '2020-04-11 14:03:21', '2020-04-11 14:03:21'),
(2, 'Pharmacy', 'Eaque et aut natus. Minima blanditiis ut sunt distinctio ad. Quasi doloremque rerum ex rerum. Molestias similique similique aut rerum delectus blanditiis et. Dolorem et quas nostrum est nobis.', '2020-04-11 14:03:21', '2020-04-11 14:03:21'),
(3, 'Restaurant', 'Est nihil omnis natus ducimus ducimus excepturi quos. Et praesentium in quia veniam. Tempore aut nesciunt consequatur pariatur recusandae. Voluptatem commodi eius quaerat est deleniti impedit. Qui quo harum est sequi incidunt labore eligendi cum.', '2020-04-11 14:03:21', '2021-06-20 11:50:07'),
(4, 'Store', 'Ex nostrum suscipit aut et labore. Ut dolor ut eum eum voluptatem ex. Sapiente in tempora soluta voluptatem. Officia accusantium quae sit. Rerum esse ipsa molestias dolorem et est autem consequatur.', '2020-04-11 14:03:21', '2020-04-11 14:03:21'),
(5, 'Electronics', 'Dolorum earum ut blanditiis blanditiis. Facere quis voluptates assumenda saepe. Ab aspernatur voluptatibus rem doloremque cum impedit. Itaque blanditiis commodi repudiandae asperiores. Modi atque placeat consectetur et aut blanditiis.', '2020-04-11 14:03:21', '2020-04-11 14:03:21'),
(6, 'Furniture', 'Est et iste enim. Quam repudiandae commodi rerum non esse. Et in aut sequi est aspernatur. Facere non modi expedita asperiores. Ipsa laborum saepe deserunt qui consequatur voluptas inventore dolorum.', '2020-04-11 14:03:21', '2020-04-11 14:03:21');

-- --------------------------------------------------------

--
-- Table structure for table `galleries`
--

CREATE TABLE `galleries` (
  `id` int(10) UNSIGNED NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `market_id` int(10) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `galleries`
--

INSERT INTO `galleries` (`id`, `description`, `market_id`, `created_at`, `updated_at`) VALUES
(1, 'Molestias molestiae vitae adipisci eum autem nobis quod.', 2, '2021-06-17 17:39:54', '2021-06-17 17:39:54'),
(2, 'Impedit laborum saepe et.', 2, '2021-06-17 17:39:54', '2021-06-17 17:39:54'),
(3, 'Eaque qui deserunt sunt aut natus corrupti.', 3, '2021-06-17 17:39:54', '2021-06-17 17:39:54'),
(4, 'Dicta laudantium hic nam sit iure.', 5, '2021-06-17 17:39:54', '2021-06-17 17:39:54'),
(5, 'Quis unde animi officiis quos.', 6, '2021-06-17 17:39:54', '2021-06-17 17:39:54'),
(6, 'Mollitia cupiditate consectetur ut ipsum facilis saepe.', 1, '2021-06-17 17:39:54', '2021-06-17 17:39:54'),
(7, 'Amet natus beatae nulla ea ducimus eaque.', 3, '2021-06-17 17:39:54', '2021-06-17 17:39:54'),
(8, 'Omnis quibusdam maxime occaecati ex tenetur hic repudiandae quaerat.', 5, '2021-06-17 17:39:54', '2021-06-17 17:39:54'),
(9, 'Consequatur officia asperiores maxime aut maxime quam.', 7, '2021-06-17 17:39:54', '2021-06-17 17:39:54'),
(10, 'Distinctio earum animi eveniet blanditiis maiores a.', 1, '2021-06-17 17:39:55', '2021-06-17 17:39:55'),
(11, 'Qui explicabo vitae reprehenderit vitae.', 10, '2021-06-17 17:39:55', '2021-06-17 17:39:55'),
(12, 'Quisquam veritatis iste beatae quia eaque.', 7, '2021-06-17 17:39:55', '2021-06-17 17:39:55'),
(13, 'Laudantium minus sunt illum modi sequi maxime tenetur accusantium.', 5, '2021-06-17 17:39:55', '2021-06-17 17:39:55'),
(14, 'Necessitatibus minus debitis sit voluptatem ad iusto asperiores.', 8, '2021-06-17 17:39:55', '2021-06-17 17:39:55'),
(15, 'Est tempore error quis nulla at.', 4, '2021-06-17 17:39:55', '2021-06-17 17:39:55'),
(16, 'Laudantium nesciunt aut veniam officiis.', 3, '2021-06-17 17:39:55', '2021-06-17 17:39:55'),
(17, 'Provident porro corrupti doloribus id pariatur vel.', 3, '2021-06-17 17:39:55', '2021-06-17 17:39:55'),
(18, 'Consequatur maiores est exercitationem ipsa consectetur.', 3, '2021-06-17 17:39:55', '2021-06-17 17:39:55'),
(19, 'Laborum nisi sint rerum ea sequi quam molestiae.', 4, '2021-06-17 17:39:55', '2021-06-17 17:39:55'),
(20, 'Ipsam et reprehenderit perferendis.', 9, '2021-06-17 17:39:55', '2021-06-17 17:39:55');

-- --------------------------------------------------------

--
-- Table structure for table `markets`
--

CREATE TABLE `markets` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(127) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci DEFAULT '',
  `address` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `latitude` varchar(24) COLLATE utf8mb4_unicode_ci NOT NULL,
  `longitude` varchar(24) COLLATE utf8mb4_unicode_ci NOT NULL,
  `phone` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `mobile` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `information` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `admin_commission` double(8,2) DEFAULT 0.00,
  `delivery_fee` double(8,2) DEFAULT 0.00,
  `delivery_range` double(8,2) DEFAULT 0.00,
  `default_tax` double(8,2) DEFAULT 0.00,
  `closed` tinyint(1) DEFAULT 0,
  `active` tinyint(1) DEFAULT 0,
  `available_for_delivery` tinyint(1) DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `markets`
--

INSERT INTO `markets` (`id`, `name`, `description`, `address`, `latitude`, `longitude`, `phone`, `mobile`, `information`, `admin_commission`, `delivery_fee`, `delivery_range`, `default_tax`, `closed`, `active`, `available_for_delivery`, `created_at`, `updated_at`) VALUES
(1, 'Furniture Hyatt-Murphy', 'Voluptatem ducimus veniam quia laborum tempora eum. Est dolore itaque cupiditate et voluptatem ullam. Accusamus autem et maxime neque rem molestiae nesciunt.', '908 Bonnie Skyway Apt. 969\nAshtonshire, IA 02101', '47.828045', '8.500653', '+1 (454) 602-7347', '638.658.9239 x655', 'Numquam sed quas in est voluptatem laudantium veniam. Distinctio ad sed officia iusto reiciendis. Repudiandae mollitia voluptatibus ut non aut.', 22.23, 1.84, 37.64, 7.60, 0, 1, 1, '2021-06-17 17:39:52', '2021-06-17 17:39:52'),
(2, 'Shop Hane-Kautzer', 'Aut explicabo eveniet sint quia temporibus. Tenetur tenetur perspiciatis velit qui excepturi. Dignissimos aspernatur molestiae laborum laboriosam eum nihil unde.', '86980 Kohler Circle Suite 881\nAnnaside, AK 23239-0206', '39.754809', '10.79336', '1-563-684-1074 x58040', '920-719-7131', 'Omnis quidem vel est possimus expedita minus dolores. Temporibus ex omnis magnam ullam perspiciatis ut laboriosam. Sit ea eum sint quis sapiente ut.', 18.61, 6.03, 93.43, 7.07, 0, 1, 0, '2021-06-17 17:39:52', '2021-06-17 17:39:52'),
(3, 'Shop Schinner-Kuhlman', 'Fuga rerum ea soluta consequatur eum. Quidem tenetur iure est nulla consectetur. Exercitationem eos saepe repellendus autem porro repellat eveniet. Fuga id quia consequatur quidem.', '41581 Sauer WaysNew Karine, AR 51845-6266', '45.501513', '11.042002', '1-873-614-7982 x18925', '+1 (859) 324-4317', 'Hic officia nemo perferendis voluptatem eum quo et nostrum. Occaecati enim repudiandae velit velit ducimus ipsum consequatur nobis. Eos aut quod cumque ut maxime tenetur temporibus.', 38.69, 33.52, 87.08, 17.31, 1, 1, 1, '2021-06-17 17:39:52', '2021-06-20 13:03:56'),
(4, 'Market Sawayn Ltd', 'At dolor esse hic omnis autem excepturi. Non blanditiis quia voluptatem. Est eligendi voluptates incidunt sunt eaque qui.', '71341 Veda PlainsNew Guidoview, ID 32823', '50.550451', '7.554236', '485-924-6907 x30039', '1-778-675-5216', 'Rerum eius quod a blanditiis autem nihil. Ab eos vel est. Repellat rem illo cumque mollitia sunt sunt.', 38.59, 5.07, 88.08, 26.08, 0, 1, 1, '2021-06-17 17:39:52', '2021-06-19 09:04:47'),
(5, 'Pharmacy Rolfson-Waters', 'Provident et quis tempora quia vel. Aut et rerum dolor. Corrupti dolorum dolorem molestiae qui.', '7890 Monserrat Port Suite 335\nNew Yasmeentown, MS 94092', '38.065035', '8.718834', '1-345-401-2305 x773', '(567) 727-9218 x0453', 'Et ut et cupiditate corrupti ipsa. Aut voluptas sit sapiente eum omnis repellat. Ipsum reiciendis modi et unde quo mollitia.', 25.17, 3.84, 86.37, 7.07, 1, 1, 0, '2021-06-17 17:39:52', '2021-06-17 17:39:52'),
(6, 'Grocery Larson Group', 'Sed est vitae totam rerum quaerat. Aut facere ducimus commodi ullam et. Et optio incidunt voluptatem praesentium.', '58325 Cassin Forest Suite 079\nNorth Desmondview, ME 98301', '53.301238', '9.264526', '349.354.3085 x0568', '+1.290.347.0550', 'Similique sint ullam dolor saepe commodi ducimus temporibus placeat. Delectus sit quia voluptates dolorem modi tempore cupiditate deleniti. Quibusdam consequuntur repellat deserunt illo et.', 17.06, 1.97, 38.64, 7.36, 0, 1, 0, '2021-06-17 17:39:52', '2021-06-17 17:39:52'),
(7, 'Pharmacy Goyette-Hills', 'Ab culpa ipsa rem. Laborum quo facere quisquam voluptas minus sed. Quas eaque maxime deserunt ratione. Amet voluptates id atque.', '9766 Schiller Run\nMathewmouth, IL 38323-7194', '39.036881', '9.859644', '+1 (831) 722-0971', '413.523.5040', 'Quia mollitia nisi atque quos nihil blanditiis. Sed velit maiores id ab qui excepturi mollitia. Odit officiis occaecati rerum dolore dicta.', 32.91, 2.56, 30.36, 27.36, 1, 1, 0, '2021-06-17 17:39:52', '2021-06-17 17:39:52'),
(8, 'Market Fisher-Little', 'Qui sit non saepe aut. Enim voluptatem dignissimos quas maxime vel ad. Et rerum et provident odio corrupti similique.', '56122 Nelda Views Suite 230\nNorth Maximilliamouth, GA 40016', '39.985677', '8.217641', '+1-395-668-6025', '1-954-389-8535 x991', 'Ut aut dolor officiis eveniet sed tempore enim. Rem dolore fugiat quis voluptatibus facere quos eos sunt. Eum et tenetur ut.', 49.06, 7.37, 80.34, 11.81, 1, 1, 1, '2021-06-17 17:39:52', '2021-06-17 17:39:52'),
(9, 'Shop Walter PLC', 'Architecto ut autem cumque officia. Occaecati dolor beatae ipsam et. Tempore molestias est quia aliquid. Vel praesentium sit est eum architecto neque.', '9978 Bauch Mission\nWest Quinnland, WA 25808-3158', '53.090078', '11.928119', '1-612-641-6791 x0187', '+15413209728', 'Saepe quod voluptatem et repellendus laboriosam. Error natus architecto laudantium rerum ut est aut ipsam. Adipisci inventore delectus recusandae quos voluptas libero voluptatem.', 26.36, 1.63, 53.89, 18.62, 0, 1, 0, '2021-06-17 17:39:52', '2021-06-17 17:39:52'),
(10, 'Furniture Muller, Mante and Ward', 'Alias commodi sapiente fugit adipisci commodi et. Impedit alias natus est. Magni voluptates quas praesentium corporis non quia quis. Fuga placeat porro distinctio est.', '23078 Franecki Rue\nSouth Sylvia, NJ 21690', '43.11196', '10.898535', '649.976.6617 x60705', '1-316-867-3916', 'Quas voluptate similique cumque dolor placeat ut omnis ex. Aut omnis est molestiae saepe. Beatae aut beatae excepturi ut.', 24.54, 9.06, 89.08, 8.12, 0, 1, 1, '2021-06-17 17:39:52', '2021-06-17 17:39:52');

-- --------------------------------------------------------

--
-- Table structure for table `markets_payouts`
--

CREATE TABLE `markets_payouts` (
  `id` int(10) UNSIGNED NOT NULL,
  `market_id` int(10) UNSIGNED NOT NULL,
  `method` varchar(127) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `amount` double(9,2) NOT NULL DEFAULT 0.00,
  `paid_date` datetime DEFAULT NULL,
  `note` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `market_fields`
--

CREATE TABLE `market_fields` (
  `field_id` int(10) UNSIGNED NOT NULL,
  `market_id` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `market_fields`
--

INSERT INTO `market_fields` (`field_id`, `market_id`) VALUES
(1, 7),
(1, 9),
(2, 1),
(2, 2),
(2, 7),
(3, 2),
(3, 3),
(3, 4),
(4, 1),
(4, 3),
(5, 8),
(5, 10),
(6, 5);

-- --------------------------------------------------------

--
-- Table structure for table `market_reviews`
--

CREATE TABLE `market_reviews` (
  `id` int(10) UNSIGNED NOT NULL,
  `review` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `rate` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `user_id` int(10) UNSIGNED NOT NULL,
  `market_id` int(10) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `market_reviews`
--

INSERT INTO `market_reviews` (`id`, `review`, `rate`, `user_id`, `market_id`, `created_at`, `updated_at`) VALUES
(1, 'How neatly spread his claws, And welcome little fishes in With gently smiling jaws!\' \'I\'m sure those are not the right distance--but then I wonder if I know is, something comes at me like a.', 2, 1, 10, '2021-06-17 17:39:56', '2021-06-17 17:39:56'),
(2, 'Alice hastily replied; \'only one doesn\'t like changing so often, of course had to sing this:-- \'Beautiful Soup, so rich and green, Waiting in a sort of meaning in it, \'and what is the use of this.', 4, 5, 7, '2021-06-17 17:39:56', '2021-06-17 17:39:56'),
(3, 'Cheshire cats always grinned; in fact, I didn\'t know how to set about it; and the Hatter continued, \'in this way:-- \"Up above the world am I? Ah, THAT\'S the great question certainly was, what? Alice.', 1, 6, 9, '2021-06-17 17:39:56', '2021-06-17 17:39:56'),
(4, 'After a while, finding that nothing more happened, she decided to remain where she was saying, and the pattern on their backs was the same words as before, \'and things are worse than ever,\' thought.', 3, 1, 6, '2021-06-17 17:39:56', '2021-06-17 17:39:56'),
(5, 'Caterpillar. \'Well, perhaps your feelings may be ONE.\' \'One, indeed!\' said the King; and the game was going on rather better now,\' she added aloud. \'Do you play croquet?\' The soldiers were always.', 3, 3, 6, '2021-06-17 17:39:56', '2021-06-17 17:39:56'),
(6, 'There could be no chance of her sister, who was peeping anxiously into its eyes were looking over his shoulder as he shook both his shoes on. \'--and just take his head mournfully. \'Not I!\' he.', 4, 1, 4, '2021-06-17 17:39:56', '2021-06-17 17:39:56'),
(7, 'For he can thoroughly enjoy The pepper when he pleases!\' CHORUS. \'Wow! wow! wow!\' \'Here! you may nurse it a little animal (she couldn\'t guess of what sort it was) scratching and scrambling about in.', 2, 6, 8, '2021-06-17 17:39:56', '2021-06-17 17:39:56'),
(8, 'Alice, and she had not noticed before, and behind them a railway station.) However, she got up, and began by producing from under his arm a great deal to ME,\' said Alice in a very difficult.', 1, 3, 10, '2021-06-17 17:39:56', '2021-06-17 17:39:56'),
(9, 'HE went mad, you know--\' (pointing with his knuckles. It was as steady as ever; Yet you turned a back-somersault in at once.\' And in she went. Once more she found she could not remember ever having.', 3, 1, 1, '2021-06-17 17:39:56', '2021-06-17 17:39:56'),
(10, 'The Footman seemed to think about stopping herself before she had grown up,\' she said this, she looked back once or twice, and shook itself. Then it got down off the fire, and at last turned sulky.', 2, 6, 5, '2021-06-17 17:39:57', '2021-06-17 17:39:57'),
(11, 'That\'ll be a Caucus-race.\' \'What IS the same thing as \"I sleep when I breathe\"!\' \'It IS a Caucus-race?\' said Alice; \'you needn\'t be so easily offended!\' \'You\'ll get used up.\' \'But what happens when.', 3, 4, 9, '2021-06-17 17:39:57', '2021-06-17 17:39:57'),
(12, 'Caterpillar sternly. \'Explain yourself!\' \'I can\'t help it,\' said the White Rabbit, with a little bit, and said to the Mock Turtle. \'No, no! The adventures first,\' said the March Hare,) \'--it was at.', 4, 4, 2, '2021-06-17 17:39:57', '2021-06-17 17:39:57'),
(13, 'I know who I WAS when I find a thing,\' said the King. (The jury all wrote down on their slates, when the tide rises and sharks are around, His voice has a timid voice at her hands, and began:-- \'You.', 1, 2, 3, '2021-06-17 17:39:57', '2021-06-17 17:39:57'),
(14, 'very well', 5, 4, 1, '2021-06-17 17:39:57', '2021-06-19 08:21:34'),
(15, 'Alice waited a little, \'From the Queen. \'Can you play croquet?\' The soldiers were silent, and looked at the top of its voice. \'Back to land again, and the King repeated angrily, \'or I\'ll have you.', 4, 6, 6, '2021-06-17 17:39:57', '2021-06-17 17:39:57'),
(16, 'A secret, kept from all the first day,\' said the Hatter was the Rabbit just under the hedge. In another moment that it was YOUR table,\' said Alice; \'but when you have to fly; and the pool as it is.\'.', 3, 2, 1, '2021-06-17 17:39:57', '2021-06-17 17:39:57'),
(17, 'King eagerly, and he wasn\'t going to give the prizes?\' quite a new kind of serpent, that\'s all the while, and fighting for the White Rabbit, who said in a tone of great relief. \'Call the next.', 1, 4, 5, '2021-06-17 17:39:57', '2021-06-17 17:39:57'),
(18, 'Queen say only yesterday you deserved to be managed? I suppose I ought to be lost, as she could. The next witness was the same thing,\' said the last few minutes, and she felt that it was the White.', 2, 6, 8, '2021-06-17 17:39:57', '2021-06-17 17:39:57'),
(19, 'CHAPTER VI. Pig and Pepper For a minute or two, looking for eggs, as it didn\'t sound at all know whether it would be four thousand miles down, I think--\' (she was obliged to write with one foot.', 2, 4, 1, '2021-06-17 17:39:57', '2021-06-17 17:39:57'),
(20, 'Duchess, \'and that\'s why. Pig!\' She said the Caterpillar. Alice said to herself, \'after such a capital one for catching mice you can\'t take LESS,\' said the March Hare meekly replied. \'Yes, but some.', 2, 2, 3, '2021-06-17 17:39:57', '2021-06-17 17:39:57');

-- --------------------------------------------------------

--
-- Table structure for table `media`
--

CREATE TABLE `media` (
  `id` int(10) UNSIGNED NOT NULL,
  `model_type` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `model_id` bigint(20) UNSIGNED NOT NULL,
  `collection_name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `file_name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `mime_type` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `disk` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `size` int(10) UNSIGNED NOT NULL,
  `manipulations` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `custom_properties` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `responsive_images` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `order_column` int(10) UNSIGNED DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `media`
--

INSERT INTO `media` (`id`, `model_type`, `model_id`, `collection_name`, `name`, `file_name`, `mime_type`, `disk`, `size`, `manipulations`, `custom_properties`, `responsive_images`, `order_column`, `created_at`, `updated_at`) VALUES
(1, 'App\\Models\\Upload', 1, 'image', 'vineger', 'vineger.png', 'image/jpeg', 'public', 17000, '[]', '{\"uuid\":\"abce01f2-2248-489c-b4a6-53217cfbfc12\",\"user_id\":1}', '[]', 1, '2021-06-19 04:32:41', '2021-06-19 04:32:41'),
(2, 'App\\Models\\Product', 40, 'image', 'vineger', 'vineger.png', 'image/jpeg', 'public', 17000, '[]', '{\"uuid\":\"abce01f2-2248-489c-b4a6-53217cfbfc12\",\"user_id\":1}', '[]', 2, '2021-06-19 04:32:46', '2021-06-19 04:32:46'),
(3, 'App\\Models\\Upload', 2, 'image', 'vineger', 'vineger.png', 'image/jpeg', 'public', 17000, '[]', '{\"uuid\":\"c6adb1a0-b964-4027-b7a1-7af8c8b842dc\",\"user_id\":1}', '[]', 3, '2021-06-19 04:33:06', '2021-06-19 04:33:06'),
(4, 'App\\Models\\Product', 40, 'image', 'vineger', 'vineger.png', 'image/jpeg', 'public', 17000, '[]', '{\"uuid\":\"c6adb1a0-b964-4027-b7a1-7af8c8b842dc\",\"user_id\":1}', '[]', 4, '2021-06-19 04:33:14', '2021-06-19 04:33:14'),
(5, 'App\\Models\\Upload', 3, 'image', 'sugar', 'sugar.png', 'image/png', 'public', 305668, '[]', '{\"uuid\":\"253ee9eb-6038-4884-91b3-e7d15c789a20\",\"user_id\":1}', '[]', 5, '2021-06-19 04:34:09', '2021-06-19 04:34:09'),
(6, 'App\\Models\\Product', 16, 'image', 'sugar', 'sugar.png', 'image/png', 'public', 305668, '[]', '{\"uuid\":\"253ee9eb-6038-4884-91b3-e7d15c789a20\",\"user_id\":1}', '[]', 6, '2021-06-19 04:34:11', '2021-06-19 04:34:11');

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '2014_10_12_000000_create_users_table', 1),
(2, '2014_10_12_100000_create_password_resets_table', 1),
(3, '2018_05_26_175145_create_permission_tables', 1),
(4, '2018_06_12_140344_create_media_table', 1),
(5, '2018_06_13_035117_create_uploads_table', 1),
(6, '2018_07_17_180731_create_settings_table', 1),
(7, '2018_07_24_211308_create_custom_fields_table', 1),
(8, '2018_07_24_211327_create_custom_field_values_table', 1),
(9, '2019_08_29_213820_create_fields_table', 1),
(10, '2019_08_29_213821_create_markets_table', 1),
(11, '2019_08_29_213822_create_categories_table', 1),
(12, '2019_08_29_213826_create_option_groups_table', 1),
(13, '2019_08_29_213829_create_faq_categories_table', 1),
(14, '2019_08_29_213833_create_order_statuses_table', 1),
(15, '2019_08_29_213837_create_products_table', 1),
(16, '2019_08_29_213838_create_options_table', 1),
(17, '2019_08_29_213842_create_galleries_table', 1),
(18, '2019_08_29_213847_create_product_reviews_table', 1),
(19, '2019_08_29_213921_create_payments_table', 1),
(20, '2019_08_29_213922_create_delivery_addresses_table', 1),
(21, '2019_08_29_213926_create_faqs_table', 1),
(22, '2019_08_29_213940_create_market_reviews_table', 1),
(23, '2019_08_30_152927_create_favorites_table', 1),
(24, '2019_08_31_111104_create_orders_table', 1),
(25, '2019_09_04_153857_create_carts_table', 1),
(26, '2019_09_04_153858_create_favorite_options_table', 1),
(27, '2019_09_04_153859_create_cart_options_table', 1),
(28, '2019_09_04_153958_create_product_orders_table', 1),
(29, '2019_09_04_154957_create_product_order_options_table', 1),
(30, '2019_09_04_163857_create_user_markets_table', 1),
(31, '2019_10_22_144652_create_currencies_table', 1),
(32, '2019_12_14_134302_create_driver_markets_table', 1),
(33, '2020_03_25_094752_create_drivers_table', 1),
(34, '2020_03_25_094802_create_earnings_table', 1),
(35, '2020_03_25_094809_create_drivers_payouts_table', 1),
(36, '2020_03_25_094817_create_markets_payouts_table', 1),
(37, '2020_03_27_094855_create_notifications_table', 1),
(38, '2020_04_11_135804_create_market_fields_table', 1),
(39, '2020_08_23_181022_create_coupons_table', 1),
(40, '2020_08_23_181029_create_discountables_table', 1),
(41, '2020_09_01_192732_create_slides_table', 1);

-- --------------------------------------------------------

--
-- Table structure for table `model_has_permissions`
--

CREATE TABLE `model_has_permissions` (
  `permission_id` int(10) UNSIGNED NOT NULL,
  `model_type` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `model_id` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `model_has_roles`
--

CREATE TABLE `model_has_roles` (
  `role_id` int(10) UNSIGNED NOT NULL,
  `model_type` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `model_id` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `model_has_roles`
--

INSERT INTO `model_has_roles` (`role_id`, `model_type`, `model_id`) VALUES
(2, 'App\\Models\\User', 1),
(3, 'App\\Models\\User', 2),
(4, 'App\\Models\\User', 3),
(4, 'App\\Models\\User', 4),
(4, 'App\\Models\\User', 7),
(5, 'App\\Models\\User', 5),
(5, 'App\\Models\\User', 6);

-- --------------------------------------------------------

--
-- Table structure for table `notifications`
--

CREATE TABLE `notifications` (
  `id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `type` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `notifiable_type` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `notifiable_id` bigint(20) UNSIGNED NOT NULL,
  `data` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `read_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `notifications`
--

INSERT INTO `notifications` (`id`, `type`, `notifiable_type`, `notifiable_id`, `data`, `read_at`, `created_at`, `updated_at`) VALUES
('62e0db14-a48c-4243-be83-b405b60b5e40', 'App\\Notifications\\StatusChangedOrder', 'App\\Models\\User', 4, '{\"order_id\":3}', NULL, '2021-06-19 09:06:20', '2021-06-19 09:06:20'),
('b8217b2e-7cf4-4802-bc1d-ea1ea55e56b4', 'App\\Notifications\\NewOrder', 'App\\Models\\User', 2, '{\"order_id\":5}', NULL, '2021-06-21 18:27:58', '2021-06-21 18:27:58'),
('c3ea1f0b-03a5-4c34-9d3f-d3bd5a9bdb32', 'App\\Notifications\\NewOrder', 'App\\Models\\User', 2, '{\"order_id\":3}', NULL, '2021-06-19 09:05:24', '2021-06-19 09:05:24');

-- --------------------------------------------------------

--
-- Table structure for table `options`
--

CREATE TABLE `options` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(127) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `price` double(8,2) NOT NULL DEFAULT 0.00,
  `product_id` int(10) UNSIGNED NOT NULL,
  `option_group_id` int(10) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `options`
--

INSERT INTO `options` (`id`, `name`, `description`, `price`, `product_id`, `option_group_id`, `created_at`, `updated_at`) VALUES
(1, 'Tomato', 'Nihil aut esse voluptas necessitatibus.', 37.26, 19, 4, '2021-06-17 17:39:57', '2021-06-17 17:39:57'),
(2, 'Green', 'Enim magnam eos.', 47.64, 16, 2, '2021-06-17 17:39:57', '2021-06-17 17:39:57'),
(3, 'L', 'Et nesciunt quia nihil ut.', 16.53, 23, 4, '2021-06-17 17:39:57', '2021-06-17 17:39:57'),
(4, 'Green', 'Omnis asperiores et velit.', 40.47, 24, 1, '2021-06-17 17:39:57', '2021-06-17 17:39:57'),
(5, '2L', 'Perferendis provident quia aliquam facilis.', 22.64, 29, 1, '2021-06-17 17:39:57', '2021-06-17 17:39:57'),
(6, '5L', 'Earum unde quia.', 17.26, 25, 3, '2021-06-17 17:39:57', '2021-06-17 17:39:57'),
(7, 'Tomato', 'Quia facilis excepturi temporibus.', 40.93, 10, 3, '2021-06-17 17:39:57', '2021-06-17 17:39:57'),
(8, 'Green', 'Delectus assumenda est maxime.', 37.48, 26, 4, '2021-06-17 17:39:57', '2021-06-17 17:39:57'),
(9, 'XL', 'Eveniet placeat dolorem doloremque.', 22.91, 27, 1, '2021-06-17 17:39:57', '2021-06-17 17:39:57'),
(10, 'White', 'Nihil ad maiores ut.', 35.38, 3, 1, '2021-06-17 17:39:57', '2021-06-17 17:39:57'),
(11, 'White', 'Hic temporibus quaerat ut maiores atque.', 41.35, 17, 1, '2021-06-17 17:39:57', '2021-06-17 17:39:57'),
(12, 'S', 'Omnis laborum quia numquam.', 34.67, 17, 2, '2021-06-17 17:39:57', '2021-06-17 17:39:57'),
(13, 'Oil', 'Molestiae et ea eos quis.', 29.60, 21, 3, '2021-06-17 17:39:57', '2021-06-17 17:39:57'),
(14, '5L', 'Minus reprehenderit quod quidem.', 12.59, 26, 2, '2021-06-17 17:39:57', '2021-06-17 17:39:57'),
(15, 'Tomato', 'Asperiores voluptas sint aspernatur fuga.', 18.38, 14, 4, '2021-06-17 17:39:57', '2021-06-17 17:39:57'),
(16, 'S', 'Sit eius nemo voluptatem ex alias.', 43.30, 18, 3, '2021-06-17 17:39:57', '2021-06-17 17:39:57'),
(17, '500g', 'Et consequatur non eaque omnis.', 32.68, 8, 1, '2021-06-17 17:39:57', '2021-06-17 17:39:57'),
(18, 'Green', 'Blanditiis quaerat commodi quaerat ut.', 26.75, 9, 2, '2021-06-17 17:39:57', '2021-06-17 17:39:57'),
(19, '5L', 'Et saepe similique nihil.', 47.93, 10, 1, '2021-06-17 17:39:57', '2021-06-17 17:39:57'),
(20, 'White', 'Ut placeat doloribus.', 24.22, 8, 4, '2021-06-17 17:39:58', '2021-06-17 17:39:58'),
(21, 'Green', 'Officia et autem modi.', 19.32, 9, 4, '2021-06-17 17:39:58', '2021-06-17 17:39:58'),
(22, 'Tomato', 'Unde et voluptatem consequatur.', 11.79, 23, 1, '2021-06-17 17:39:58', '2021-06-17 17:39:58'),
(23, 'Oil', 'Est quas modi.', 29.50, 18, 1, '2021-06-17 17:39:58', '2021-06-17 17:39:58'),
(24, '5L', 'Impedit dolorem cupiditate quidem magni libero.', 16.05, 29, 2, '2021-06-17 17:39:58', '2021-06-17 17:39:58'),
(25, 'Tomato', 'Qui dolores aut sapiente voluptas.', 36.18, 16, 2, '2021-06-17 17:39:58', '2021-06-17 17:39:58'),
(26, 'White', 'Voluptatem magnam earum facilis veniam odit.', 32.04, 22, 2, '2021-06-17 17:39:58', '2021-06-17 17:39:58'),
(27, 'L', 'Quasi omnis voluptatem atque et quos.', 46.65, 28, 2, '2021-06-17 17:39:58', '2021-06-17 17:39:58'),
(28, 'L', 'Vel dicta natus sint quasi est.', 21.26, 3, 3, '2021-06-17 17:39:58', '2021-06-17 17:39:58'),
(29, 'L', 'Minima et enim sequi neque.', 28.76, 23, 1, '2021-06-17 17:39:58', '2021-06-17 17:39:58'),
(30, 'XL', 'Assumenda autem fugit distinctio.', 34.87, 10, 4, '2021-06-17 17:39:58', '2021-06-17 17:39:58'),
(31, 'Oil', 'Quidem dolorem neque culpa ea molestiae.', 11.14, 21, 1, '2021-06-17 17:39:58', '2021-06-17 17:39:58'),
(32, 'XL', 'Consectetur doloribus aut exercitationem accusamus.', 38.62, 19, 2, '2021-06-17 17:39:58', '2021-06-17 17:39:58'),
(33, '2L', 'Consequatur sint ipsa eum.', 19.30, 23, 1, '2021-06-17 17:39:58', '2021-06-17 17:39:58'),
(34, 'XL', 'Quae nulla ut.', 42.06, 7, 1, '2021-06-17 17:39:58', '2021-06-17 17:39:58'),
(35, '1Kg', 'Quo quaerat accusamus voluptatem aut voluptates.', 11.41, 16, 2, '2021-06-17 17:39:58', '2021-06-17 17:39:58'),
(36, 'XL', 'Vel dolorem tenetur rerum laborum.', 20.39, 27, 3, '2021-06-17 17:39:58', '2021-06-17 17:39:58'),
(37, '5L', 'Quod accusantium consequatur earum et.', 16.67, 16, 4, '2021-06-17 17:39:58', '2021-06-17 17:39:58'),
(38, 'L', 'Non dignissimos itaque quia.', 49.29, 23, 2, '2021-06-17 17:39:58', '2021-06-17 17:39:58'),
(39, '1Kg', 'Explicabo nostrum sint natus.', 24.50, 26, 1, '2021-06-17 17:39:58', '2021-06-17 17:39:58'),
(40, 'White', 'Sapiente odit aperiam provident accusamus distinctio.', 10.92, 5, 1, '2021-06-17 17:39:58', '2021-06-17 17:39:58'),
(41, 'Oil', 'Aut occaecati et a illum.', 15.64, 10, 4, '2021-06-17 17:39:58', '2021-06-17 17:39:58'),
(42, 'Tomato', 'Odit repellat minus aut recusandae.', 21.79, 28, 4, '2021-06-17 17:39:58', '2021-06-17 17:39:58'),
(43, 'Green', 'Illo voluptatibus eveniet autem unde dicta.', 27.31, 14, 1, '2021-06-17 17:39:58', '2021-06-17 17:39:58'),
(44, 'Red', 'Facilis eum dolorum ex.', 38.90, 1, 1, '2021-06-17 17:39:58', '2021-06-17 17:39:58'),
(45, 'White', 'Ducimus aperiam ducimus ut.', 19.17, 15, 4, '2021-06-17 17:39:58', '2021-06-17 17:39:58'),
(46, '2L', 'Atque nihil adipisci iure.', 11.57, 4, 1, '2021-06-17 17:39:58', '2021-06-17 17:39:58'),
(47, 'XL', 'Eos quibusdam enim quibusdam.', 17.38, 17, 4, '2021-06-17 17:39:58', '2021-06-17 17:39:58'),
(48, 'Oil', 'Quia rerum dolorem placeat animi consectetur.', 24.05, 3, 4, '2021-06-17 17:39:58', '2021-06-17 17:39:58'),
(49, 'Tomato', 'Voluptatibus esse nihil atque quia.', 35.38, 17, 1, '2021-06-17 17:39:58', '2021-06-17 17:39:58'),
(50, 'Tomato', 'Enim vero animi cupiditate autem.', 32.36, 25, 2, '2021-06-17 17:39:58', '2021-06-17 17:39:58'),
(51, 'Green', 'Ratione qui temporibus facere.', 11.92, 15, 4, '2021-06-17 17:39:58', '2021-06-17 17:39:58'),
(52, '5L', 'Consequatur dolor ratione fugit.', 38.75, 11, 2, '2021-06-17 17:39:58', '2021-06-17 17:39:58'),
(53, 'S', 'Sunt eveniet soluta.', 34.35, 24, 3, '2021-06-17 17:39:58', '2021-06-17 17:39:58'),
(54, '500g', 'Nihil vel suscipit consequatur.', 17.41, 1, 4, '2021-06-17 17:39:58', '2021-06-17 17:39:58'),
(55, '500g', 'Sint aut ut dolorum atque cum.', 39.26, 14, 3, '2021-06-17 17:39:58', '2021-06-17 17:39:58'),
(56, 'L', 'Dolores deleniti accusamus occaecati.', 26.55, 20, 3, '2021-06-17 17:39:58', '2021-06-17 17:39:58'),
(57, '1Kg', 'Autem ipsum et.', 14.62, 29, 1, '2021-06-17 17:39:58', '2021-06-17 17:39:58'),
(58, 'Green', 'Nobis ut sunt hic aliquid.', 26.72, 11, 2, '2021-06-17 17:39:58', '2021-06-17 17:39:58'),
(59, 'XL', 'Et facilis ea.', 35.96, 8, 4, '2021-06-17 17:39:58', '2021-06-17 17:39:58'),
(60, '1Kg', 'Magni placeat corrupti est.', 46.66, 12, 3, '2021-06-17 17:39:58', '2021-06-17 17:39:58'),
(61, 'XL', 'Molestiae voluptatem dignissimos quos iste possimus.', 33.52, 26, 1, '2021-06-17 17:39:58', '2021-06-17 17:39:58'),
(62, 'Tomato', 'Optio est tempora necessitatibus et.', 38.20, 21, 4, '2021-06-17 17:39:58', '2021-06-17 17:39:58'),
(63, 'White', 'Eum reprehenderit quibusdam odit similique.', 10.71, 30, 3, '2021-06-17 17:39:58', '2021-06-17 17:39:58'),
(64, 'Green', 'Fugit est consequatur ut atque.', 47.53, 1, 1, '2021-06-17 17:39:58', '2021-06-17 17:39:58'),
(65, 'Red', 'Similique ut sint.', 12.32, 24, 1, '2021-06-17 17:39:59', '2021-06-17 17:39:59'),
(66, '5L', 'Distinctio aut quae accusantium omnis.', 18.81, 12, 3, '2021-06-17 17:39:59', '2021-06-17 17:39:59'),
(67, 'S', 'Sed deleniti dolor sit.', 34.95, 4, 2, '2021-06-17 17:39:59', '2021-06-17 17:39:59'),
(68, '500g', 'Repellendus in voluptas voluptate libero.', 43.81, 6, 2, '2021-06-17 17:39:59', '2021-06-17 17:39:59'),
(69, 'S', 'Commodi omnis qui non in est.', 23.92, 14, 2, '2021-06-17 17:39:59', '2021-06-17 17:39:59'),
(70, '5L', 'Culpa voluptate fugiat aut blanditiis id.', 44.67, 30, 4, '2021-06-17 17:39:59', '2021-06-17 17:39:59');

-- --------------------------------------------------------

--
-- Table structure for table `option_groups`
--

CREATE TABLE `option_groups` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(127) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `option_groups`
--

INSERT INTO `option_groups` (`id`, `name`, `created_at`, `updated_at`) VALUES
(1, 'Size', '2019-08-31 09:55:28', '2019-08-31 09:55:28'),
(2, 'Color', '2019-10-09 12:26:28', '2019-10-09 12:26:28'),
(3, 'Parfum', '2019-10-09 12:26:28', '2019-10-09 12:26:28'),
(4, 'Taste', '2019-10-09 12:26:28', '2019-10-09 12:26:28');

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

CREATE TABLE `orders` (
  `id` int(10) UNSIGNED NOT NULL,
  `user_id` int(10) UNSIGNED NOT NULL,
  `order_status_id` int(10) UNSIGNED NOT NULL,
  `tax` double(5,2) DEFAULT 0.00,
  `delivery_fee` double(5,2) DEFAULT 0.00,
  `hint` text COLLATE utf8mb4_unicode_ci DEFAULT '',
  `active` tinyint(1) NOT NULL DEFAULT 1,
  `driver_id` int(10) UNSIGNED DEFAULT NULL,
  `delivery_address_id` int(10) UNSIGNED DEFAULT NULL,
  `payment_id` int(10) UNSIGNED DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `orders`
--

INSERT INTO `orders` (`id`, `user_id`, `order_status_id`, `tax`, `delivery_fee`, `hint`, `active`, `driver_id`, `delivery_address_id`, `payment_id`, `created_at`, `updated_at`) VALUES
(2, 4, 1, 7.60, 0.00, NULL, 1, NULL, NULL, 1, '2021-06-19 04:16:11', '2021-06-19 04:16:12'),
(3, 4, 2, 26.08, 0.00, NULL, 1, NULL, NULL, 2, '2021-06-19 09:05:22', '2021-06-19 09:06:20'),
(4, 4, 1, 7.60, 0.00, NULL, 1, NULL, 12, 3, '2021-06-21 13:11:24', '2021-06-21 13:11:24'),
(5, 4, 1, 26.08, 5.07, NULL, 1, NULL, 12, 4, '2021-06-21 18:27:57', '2021-06-21 18:27:58');

-- --------------------------------------------------------

--
-- Table structure for table `order_statuses`
--

CREATE TABLE `order_statuses` (
  `id` int(10) UNSIGNED NOT NULL,
  `status` varchar(127) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `order_statuses`
--

INSERT INTO `order_statuses` (`id`, `status`, `created_at`, `updated_at`) VALUES
(1, 'Order Received', '2019-08-30 15:39:28', '2019-10-15 17:03:14'),
(2, 'Preparing', '2019-10-15 17:03:50', '2019-10-15 17:03:50'),
(3, 'Ready', '2019-10-15 17:04:30', '2019-10-15 17:04:30'),
(4, 'On the Way', '2019-10-15 17:04:13', '2019-10-15 17:04:13'),
(5, 'Delivered', '2019-10-15 17:04:30', '2019-10-15 17:04:30');

-- --------------------------------------------------------

--
-- Table structure for table `password_resets`
--

CREATE TABLE `password_resets` (
  `email` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `payments`
--

CREATE TABLE `payments` (
  `id` int(10) UNSIGNED NOT NULL,
  `price` double(8,2) NOT NULL DEFAULT 0.00,
  `description` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_id` int(10) UNSIGNED NOT NULL,
  `status` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `method` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `payments`
--

INSERT INTO `payments` (`id`, `price`, `description`, `user_id`, `status`, `method`, `created_at`, `updated_at`) VALUES
(1, 179.83, 'Order not paid yet', 4, 'Waiting for Client', 'Pay on Pickup', '2021-06-19 04:16:12', '2021-06-19 04:16:12'),
(2, 80.09, 'Order not paid yet', 4, 'Waiting for Client', 'Pay on Pickup', '2021-06-19 09:05:23', '2021-06-19 09:05:23'),
(3, 75.73, 'Order not paid yet', 4, 'Waiting for Client', 'Pay on Pickup', '2021-06-21 13:11:24', '2021-06-21 13:11:24'),
(4, 68.12, 'Order not paid yet', 4, 'Waiting for Client', 'Cash on Delivery', '2021-06-21 18:27:57', '2021-06-21 18:27:57');

-- --------------------------------------------------------

--
-- Table structure for table `permissions`
--

CREATE TABLE `permissions` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `guard_name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'web',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `permissions`
--

INSERT INTO `permissions` (`id`, `name`, `guard_name`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 'users.profile', 'web', '2020-03-29 13:58:02', '2020-03-29 13:58:02', NULL),
(2, 'dashboard', 'web', '2020-03-29 13:58:02', '2020-03-29 13:58:02', NULL),
(3, 'medias.create', 'web', '2020-03-29 13:58:02', '2020-03-29 13:58:02', NULL),
(4, 'medias.delete', 'web', '2020-03-29 13:58:02', '2020-03-29 13:58:02', NULL),
(5, 'medias', 'web', '2020-03-29 13:58:03', '2020-03-29 13:58:03', NULL),
(6, 'permissions.index', 'web', '2020-03-29 13:58:03', '2020-03-29 13:58:03', NULL),
(7, 'permissions.edit', 'web', '2020-03-29 13:58:03', '2020-03-29 13:58:03', NULL),
(8, 'permissions.update', 'web', '2020-03-29 13:58:03', '2020-03-29 13:58:03', NULL),
(9, 'permissions.destroy', 'web', '2020-03-29 13:58:03', '2020-03-29 13:58:03', NULL),
(10, 'roles.index', 'web', '2020-03-29 13:58:03', '2020-03-29 13:58:03', NULL),
(11, 'roles.edit', 'web', '2020-03-29 13:58:03', '2020-03-29 13:58:03', NULL),
(12, 'roles.update', 'web', '2020-03-29 13:58:03', '2020-03-29 13:58:03', NULL),
(13, 'roles.destroy', 'web', '2020-03-29 13:58:03', '2020-03-29 13:58:03', NULL),
(14, 'customFields.index', 'web', '2020-03-29 13:58:03', '2020-03-29 13:58:03', NULL),
(15, 'customFields.create', 'web', '2020-03-29 13:58:03', '2020-03-29 13:58:03', NULL),
(16, 'customFields.store', 'web', '2020-03-29 13:58:03', '2020-03-29 13:58:03', NULL),
(17, 'customFields.show', 'web', '2020-03-29 13:58:03', '2020-03-29 13:58:03', NULL),
(18, 'customFields.edit', 'web', '2020-03-29 13:58:03', '2020-03-29 13:58:03', NULL),
(19, 'customFields.update', 'web', '2020-03-29 13:58:04', '2020-03-29 13:58:04', NULL),
(20, 'customFields.destroy', 'web', '2020-03-29 13:58:04', '2020-03-29 13:58:04', NULL),
(21, 'users.login-as-user', 'web', '2020-03-29 13:58:04', '2020-03-29 13:58:04', NULL),
(22, 'users.index', 'web', '2020-03-29 13:58:04', '2020-03-29 13:58:04', NULL),
(23, 'users.create', 'web', '2020-03-29 13:58:04', '2020-03-29 13:58:04', NULL),
(24, 'users.store', 'web', '2020-03-29 13:58:04', '2020-03-29 13:58:04', NULL),
(25, 'users.show', 'web', '2020-03-29 13:58:04', '2020-03-29 13:58:04', NULL),
(26, 'users.edit', 'web', '2020-03-29 13:58:04', '2020-03-29 13:58:04', NULL),
(27, 'users.update', 'web', '2020-03-29 13:58:04', '2020-03-29 13:58:04', NULL),
(28, 'users.destroy', 'web', '2020-03-29 13:58:04', '2020-03-29 13:58:04', NULL),
(29, 'app-settings', 'web', '2020-03-29 13:58:04', '2020-03-29 13:58:04', NULL),
(30, 'markets.index', 'web', '2020-03-29 13:58:04', '2020-03-29 13:58:04', NULL),
(31, 'markets.create', 'web', '2020-03-29 13:58:04', '2020-03-29 13:58:04', NULL),
(32, 'markets.store', 'web', '2020-03-29 13:58:04', '2020-03-29 13:58:04', NULL),
(33, 'markets.edit', 'web', '2020-03-29 13:58:04', '2020-03-29 13:58:04', NULL),
(34, 'markets.update', 'web', '2020-03-29 13:58:05', '2020-03-29 13:58:05', NULL),
(35, 'markets.destroy', 'web', '2020-03-29 13:58:05', '2020-03-29 13:58:05', NULL),
(36, 'categories.index', 'web', '2020-03-29 13:58:05', '2020-03-29 13:58:05', NULL),
(37, 'categories.create', 'web', '2020-03-29 13:58:05', '2020-03-29 13:58:05', NULL),
(38, 'categories.store', 'web', '2020-03-29 13:58:05', '2020-03-29 13:58:05', NULL),
(39, 'categories.edit', 'web', '2020-03-29 13:58:05', '2020-03-29 13:58:05', NULL),
(40, 'categories.update', 'web', '2020-03-29 13:58:05', '2020-03-29 13:58:05', NULL),
(41, 'categories.destroy', 'web', '2020-03-29 13:58:05', '2020-03-29 13:58:05', NULL),
(42, 'faqCategories.index', 'web', '2020-03-29 13:58:06', '2020-03-29 13:58:06', NULL),
(43, 'faqCategories.create', 'web', '2020-03-29 13:58:06', '2020-03-29 13:58:06', NULL),
(44, 'faqCategories.store', 'web', '2020-03-29 13:58:06', '2020-03-29 13:58:06', NULL),
(45, 'faqCategories.edit', 'web', '2020-03-29 13:58:06', '2020-03-29 13:58:06', NULL),
(46, 'faqCategories.update', 'web', '2020-03-29 13:58:06', '2020-03-29 13:58:06', NULL),
(47, 'faqCategories.destroy', 'web', '2020-03-29 13:58:06', '2020-03-29 13:58:06', NULL),
(48, 'orderStatuses.index', 'web', '2020-03-29 13:58:06', '2020-03-29 13:58:06', NULL),
(49, 'orderStatuses.show', 'web', '2020-03-29 13:58:06', '2020-03-29 13:58:06', NULL),
(50, 'orderStatuses.edit', 'web', '2020-03-29 13:58:06', '2020-03-29 13:58:06', NULL),
(51, 'orderStatuses.update', 'web', '2020-03-29 13:58:07', '2020-03-29 13:58:07', NULL),
(52, 'products.index', 'web', '2020-03-29 13:58:07', '2020-03-29 13:58:07', NULL),
(53, 'products.create', 'web', '2020-03-29 13:58:07', '2020-03-29 13:58:07', NULL),
(54, 'products.store', 'web', '2020-03-29 13:58:07', '2020-03-29 13:58:07', NULL),
(55, 'products.edit', 'web', '2020-03-29 13:58:07', '2020-03-29 13:58:07', NULL),
(56, 'products.update', 'web', '2020-03-29 13:58:07', '2020-03-29 13:58:07', NULL),
(57, 'products.destroy', 'web', '2020-03-29 13:58:07', '2020-03-29 13:58:07', NULL),
(58, 'galleries.index', 'web', '2020-03-29 13:58:07', '2020-03-29 13:58:07', NULL),
(59, 'galleries.create', 'web', '2020-03-29 13:58:07', '2020-03-29 13:58:07', NULL),
(60, 'galleries.store', 'web', '2020-03-29 13:58:08', '2020-03-29 13:58:08', NULL),
(61, 'galleries.edit', 'web', '2020-03-29 13:58:08', '2020-03-29 13:58:08', NULL),
(62, 'galleries.update', 'web', '2020-03-29 13:58:08', '2020-03-29 13:58:08', NULL),
(63, 'galleries.destroy', 'web', '2020-03-29 13:58:08', '2020-03-29 13:58:08', NULL),
(64, 'productReviews.index', 'web', '2020-03-29 13:58:08', '2020-03-29 13:58:08', NULL),
(65, 'productReviews.create', 'web', '2020-03-29 13:58:08', '2020-03-29 13:58:08', NULL),
(66, 'productReviews.store', 'web', '2020-03-29 13:58:08', '2020-03-29 13:58:08', NULL),
(67, 'productReviews.edit', 'web', '2020-03-29 13:58:08', '2020-03-29 13:58:08', NULL),
(68, 'productReviews.update', 'web', '2020-03-29 13:58:08', '2020-03-29 13:58:08', NULL),
(69, 'productReviews.destroy', 'web', '2020-03-29 13:58:08', '2020-03-29 13:58:08', NULL),
(76, 'options.index', 'web', '2020-03-29 13:58:09', '2020-03-29 13:58:09', NULL),
(77, 'options.create', 'web', '2020-03-29 13:58:09', '2020-03-29 13:58:09', NULL),
(78, 'options.store', 'web', '2020-03-29 13:58:09', '2020-03-29 13:58:09', NULL),
(79, 'options.show', 'web', '2020-03-29 13:58:10', '2020-03-29 13:58:10', NULL),
(80, 'options.edit', 'web', '2020-03-29 13:58:10', '2020-03-29 13:58:10', NULL),
(81, 'options.update', 'web', '2020-03-29 13:58:10', '2020-03-29 13:58:10', NULL),
(82, 'options.destroy', 'web', '2020-03-29 13:58:10', '2020-03-29 13:58:10', NULL),
(83, 'payments.index', 'web', '2020-03-29 13:58:10', '2020-03-29 13:58:10', NULL),
(84, 'payments.show', 'web', '2020-03-29 13:58:10', '2020-03-29 13:58:10', NULL),
(85, 'payments.update', 'web', '2020-03-29 13:58:10', '2020-03-29 13:58:10', NULL),
(86, 'faqs.index', 'web', '2020-03-29 13:58:10', '2020-03-29 13:58:10', NULL),
(87, 'faqs.create', 'web', '2020-03-29 13:58:11', '2020-03-29 13:58:11', NULL),
(88, 'faqs.store', 'web', '2020-03-29 13:58:11', '2020-03-29 13:58:11', NULL),
(89, 'faqs.edit', 'web', '2020-03-29 13:58:11', '2020-03-29 13:58:11', NULL),
(90, 'faqs.update', 'web', '2020-03-29 13:58:11', '2020-03-29 13:58:11', NULL),
(91, 'faqs.destroy', 'web', '2020-03-29 13:58:11', '2020-03-29 13:58:11', NULL),
(92, 'marketReviews.index', 'web', '2020-03-29 13:58:11', '2020-03-29 13:58:11', NULL),
(93, 'marketReviews.create', 'web', '2020-03-29 13:58:11', '2020-03-29 13:58:11', NULL),
(94, 'marketReviews.store', 'web', '2020-03-29 13:58:12', '2020-03-29 13:58:12', NULL),
(95, 'marketReviews.edit', 'web', '2020-03-29 13:58:12', '2020-03-29 13:58:12', NULL),
(96, 'marketReviews.update', 'web', '2020-03-29 13:58:12', '2020-03-29 13:58:12', NULL),
(97, 'marketReviews.destroy', 'web', '2020-03-29 13:58:12', '2020-03-29 13:58:12', NULL),
(98, 'favorites.index', 'web', '2020-03-29 13:58:12', '2020-03-29 13:58:12', NULL),
(99, 'favorites.create', 'web', '2020-03-29 13:58:12', '2020-03-29 13:58:12', NULL),
(100, 'favorites.store', 'web', '2020-03-29 13:58:12', '2020-03-29 13:58:12', NULL),
(101, 'favorites.edit', 'web', '2020-03-29 13:58:12', '2020-03-29 13:58:12', NULL),
(102, 'favorites.update', 'web', '2020-03-29 13:58:12', '2020-03-29 13:58:12', NULL),
(103, 'favorites.destroy', 'web', '2020-03-29 13:58:13', '2020-03-29 13:58:13', NULL),
(104, 'orders.index', 'web', '2020-03-29 13:58:13', '2020-03-29 13:58:13', NULL),
(105, 'orders.create', 'web', '2020-03-29 13:58:13', '2020-03-29 13:58:13', NULL),
(106, 'orders.store', 'web', '2020-03-29 13:58:13', '2020-03-29 13:58:13', NULL),
(107, 'orders.show', 'web', '2020-03-29 13:58:13', '2020-03-29 13:58:13', NULL),
(108, 'orders.edit', 'web', '2020-03-29 13:58:13', '2020-03-29 13:58:13', NULL),
(109, 'orders.update', 'web', '2020-03-29 13:58:13', '2020-03-29 13:58:13', NULL),
(110, 'orders.destroy', 'web', '2020-03-29 13:58:13', '2020-03-29 13:58:13', NULL),
(111, 'notifications.index', 'web', '2020-03-29 13:58:14', '2020-03-29 13:58:14', NULL),
(112, 'notifications.show', 'web', '2020-03-29 13:58:14', '2020-03-29 13:58:14', NULL),
(113, 'notifications.destroy', 'web', '2020-03-29 13:58:14', '2020-03-29 13:58:14', NULL),
(114, 'carts.index', 'web', '2020-03-29 13:58:14', '2020-03-29 13:58:14', NULL),
(115, 'carts.edit', 'web', '2020-03-29 13:58:14', '2020-03-29 13:58:14', NULL),
(116, 'carts.update', 'web', '2020-03-29 13:58:14', '2020-03-29 13:58:14', NULL),
(117, 'carts.destroy', 'web', '2020-03-29 13:58:14', '2020-03-29 13:58:14', NULL),
(118, 'currencies.index', 'web', '2020-03-29 13:58:14', '2020-03-29 13:58:14', NULL),
(119, 'currencies.create', 'web', '2020-03-29 13:58:15', '2020-03-29 13:58:15', NULL),
(120, 'currencies.store', 'web', '2020-03-29 13:58:15', '2020-03-29 13:58:15', NULL),
(121, 'currencies.edit', 'web', '2020-03-29 13:58:15', '2020-03-29 13:58:15', NULL),
(122, 'currencies.update', 'web', '2020-03-29 13:58:15', '2020-03-29 13:58:15', NULL),
(123, 'currencies.destroy', 'web', '2020-03-29 13:58:15', '2020-03-29 13:58:15', NULL),
(124, 'deliveryAddresses.index', 'web', '2020-03-29 13:58:15', '2020-03-29 13:58:15', NULL),
(125, 'deliveryAddresses.create', 'web', '2020-03-29 13:58:15', '2020-03-29 13:58:15', NULL),
(126, 'deliveryAddresses.store', 'web', '2020-03-29 13:58:15', '2020-03-29 13:58:15', NULL),
(127, 'deliveryAddresses.edit', 'web', '2020-03-29 13:58:16', '2020-03-29 13:58:16', NULL),
(128, 'deliveryAddresses.update', 'web', '2020-03-29 13:58:16', '2020-03-29 13:58:16', NULL),
(129, 'deliveryAddresses.destroy', 'web', '2020-03-29 13:58:16', '2020-03-29 13:58:16', NULL),
(130, 'drivers.index', 'web', '2020-03-29 13:58:16', '2020-03-29 13:58:16', NULL),
(131, 'drivers.create', 'web', '2020-03-29 13:58:16', '2020-03-29 13:58:16', NULL),
(132, 'drivers.store', 'web', '2020-03-29 13:58:16', '2020-03-29 13:58:16', NULL),
(133, 'drivers.show', 'web', '2020-03-29 13:58:16', '2020-03-29 13:58:16', NULL),
(134, 'drivers.edit', 'web', '2020-03-29 13:58:16', '2020-03-29 13:58:16', NULL),
(135, 'drivers.update', 'web', '2020-03-29 13:58:16', '2020-03-29 13:58:16', NULL),
(136, 'drivers.destroy', 'web', '2020-03-29 13:58:17', '2020-03-29 13:58:17', NULL),
(137, 'earnings.index', 'web', '2020-03-29 13:58:17', '2020-03-29 13:58:17', NULL),
(138, 'earnings.create', 'web', '2020-03-29 13:58:17', '2020-03-29 13:58:17', NULL),
(139, 'earnings.store', 'web', '2020-03-29 13:58:17', '2020-03-29 13:58:17', NULL),
(140, 'earnings.show', 'web', '2020-03-29 13:58:17', '2020-03-29 13:58:17', NULL),
(141, 'earnings.edit', 'web', '2020-03-29 13:58:17', '2020-03-29 13:58:17', NULL),
(142, 'earnings.update', 'web', '2020-03-29 13:58:17', '2020-03-29 13:58:17', NULL),
(143, 'earnings.destroy', 'web', '2020-03-29 13:58:17', '2020-03-29 13:58:17', NULL),
(144, 'driversPayouts.index', 'web', '2020-03-29 13:58:17', '2020-03-29 13:58:17', NULL),
(145, 'driversPayouts.create', 'web', '2020-03-29 13:58:17', '2020-03-29 13:58:17', NULL),
(146, 'driversPayouts.store', 'web', '2020-03-29 13:58:18', '2020-03-29 13:58:18', NULL),
(147, 'driversPayouts.show', 'web', '2020-03-29 13:58:18', '2020-03-29 13:58:18', NULL),
(148, 'driversPayouts.edit', 'web', '2020-03-29 13:58:18', '2020-03-29 13:58:18', NULL),
(149, 'driversPayouts.update', 'web', '2020-03-29 13:58:18', '2020-03-29 13:58:18', NULL),
(150, 'driversPayouts.destroy', 'web', '2020-03-29 13:58:18', '2020-03-29 13:58:18', NULL),
(151, 'marketsPayouts.index', 'web', '2020-03-29 13:58:18', '2020-03-29 13:58:18', NULL),
(152, 'marketsPayouts.create', 'web', '2020-03-29 13:58:18', '2020-03-29 13:58:18', NULL),
(153, 'marketsPayouts.store', 'web', '2020-03-29 13:58:18', '2020-03-29 13:58:18', NULL),
(154, 'marketsPayouts.show', 'web', '2020-03-29 13:58:18', '2020-03-29 13:58:18', NULL),
(155, 'marketsPayouts.edit', 'web', '2020-03-29 13:58:18', '2020-03-29 13:58:18', NULL),
(156, 'marketsPayouts.update', 'web', '2020-03-29 13:58:19', '2020-03-29 13:58:19', NULL),
(157, 'marketsPayouts.destroy', 'web', '2020-03-29 13:58:19', '2020-03-29 13:58:19', NULL),
(158, 'permissions.create', 'web', '2020-03-29 13:59:15', '2020-03-29 13:59:15', NULL),
(159, 'permissions.store', 'web', '2020-03-29 13:59:15', '2020-03-29 13:59:15', NULL),
(160, 'permissions.show', 'web', '2020-03-29 13:59:15', '2020-03-29 13:59:15', NULL),
(161, 'roles.create', 'web', '2020-03-29 13:59:15', '2020-03-29 13:59:15', NULL),
(162, 'roles.store', 'web', '2020-03-29 13:59:15', '2020-03-29 13:59:15', NULL),
(163, 'roles.show', 'web', '2020-03-29 13:59:16', '2020-03-29 13:59:16', NULL),
(164, 'fields.index', 'web', '2020-04-11 14:04:39', '2020-04-11 14:04:39', NULL),
(165, 'fields.create', 'web', '2020-04-11 14:04:39', '2020-04-11 14:04:39', NULL),
(166, 'fields.store', 'web', '2020-04-11 14:04:39', '2020-04-11 14:04:39', NULL),
(167, 'fields.edit', 'web', '2020-04-11 14:04:39', '2020-04-11 14:04:39', NULL),
(168, 'fields.update', 'web', '2020-04-11 14:04:39', '2020-04-11 14:04:39', NULL),
(169, 'fields.destroy', 'web', '2020-04-11 14:04:40', '2020-04-11 14:04:40', NULL),
(170, 'optionGroups.index', 'web', '2020-04-11 14:04:40', '2020-04-11 14:04:40', NULL),
(171, 'optionGroups.create', 'web', '2020-04-11 14:04:40', '2020-04-11 14:04:40', NULL),
(172, 'optionGroups.store', 'web', '2020-04-11 14:04:40', '2020-04-11 14:04:40', NULL),
(173, 'optionGroups.edit', 'web', '2020-04-11 14:04:40', '2020-04-11 14:04:40', NULL),
(174, 'optionGroups.update', 'web', '2020-04-11 14:04:40', '2020-04-11 14:04:40', NULL),
(175, 'optionGroups.destroy', 'web', '2020-04-11 14:04:40', '2020-04-11 14:04:40', NULL),
(176, 'requestedMarkets.index', 'web', '2020-08-13 13:58:02', '2020-08-13 13:58:02', NULL),
(183, 'coupons.index', 'web', '2020-08-23 13:58:02', '2020-08-23 13:58:02', NULL),
(184, 'coupons.create', 'web', '2020-08-23 13:58:02', '2020-08-23 13:58:02', NULL),
(185, 'coupons.store', 'web', '2020-08-23 13:58:02', '2020-08-23 13:58:02', NULL),
(186, 'coupons.edit', 'web', '2020-08-23 13:58:02', '2020-08-23 13:58:02', NULL),
(187, 'coupons.update', 'web', '2020-08-23 13:58:02', '2020-08-23 13:58:02', NULL),
(188, 'coupons.destroy', 'web', '2020-08-23 13:58:02', '2020-08-23 13:58:02', NULL),
(189, 'slides.index', 'web', '2020-08-23 13:58:02', '2020-08-23 13:58:02', NULL),
(190, 'slides.create', 'web', '2020-08-23 13:58:02', '2020-08-23 13:58:02', NULL),
(191, 'slides.store', 'web', '2020-08-23 13:58:02', '2020-08-23 13:58:02', NULL),
(192, 'slides.edit', 'web', '2020-08-23 13:58:02', '2020-08-23 13:58:02', NULL),
(193, 'slides.update', 'web', '2020-08-23 13:58:02', '2020-08-23 13:58:02', NULL),
(194, 'slides.destroy', 'web', '2020-08-23 13:58:02', '2020-08-23 13:58:02', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE `products` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(127) COLLATE utf8mb4_unicode_ci NOT NULL,
  `price` double(8,2) NOT NULL DEFAULT 0.00,
  `discount_price` double(8,2) DEFAULT 0.00,
  `description` text COLLATE utf8mb4_unicode_ci DEFAULT '',
  `capacity` double(9,2) DEFAULT 0.00,
  `package_items_count` double(9,2) DEFAULT 0.00,
  `unit` varchar(127) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `featured` tinyint(1) DEFAULT 0,
  `deliverable` tinyint(1) DEFAULT 1,
  `market_id` int(10) UNSIGNED NOT NULL,
  `category_id` int(10) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`id`, `name`, `price`, `discount_price`, `description`, `capacity`, `package_items_count`, `unit`, `featured`, `deliverable`, `market_id`, `category_id`, `created_at`, `updated_at`) VALUES
(1, 'Tuna steak', 24.48, 0.00, 'Aut voluptatum fuga maxime aliquid necessitatibus. Repellendus vero aut expedita qui facere eos. Rem totam hic aut voluptatem. Enim eveniet voluptatibus culpa quia et eos dolorum.', 111.67, 5.00, 'g', 1, 1, 4, 4, '2021-06-17 17:39:53', '2021-06-17 17:39:53'),
(2, 'Cookie', 29.31, 27.06, 'Et non iure molestiae corporis quidem adipisci. Placeat nemo maxime ut cupiditate hic. Possimus ipsum id animi tenetur exercitationem.', 135.54, 4.00, 'ml', 0, 1, 7, 3, '2021-06-17 17:39:53', '2021-06-17 17:39:53'),
(3, 'Soup', 34.17, 31.01, 'Beatae impedit ipsa eos repellendus et. Dolor vel qui ea tempora voluptatem. Nulla quas quia vitae rerum corporis consequatur. Consequatur rem laborum omnis est ducimus provident amet.', 252.87, 3.00, 'm²', 1, 1, 3, 4, '2021-06-17 17:39:53', '2021-06-17 17:39:53'),
(4, 'Soup', 20.21, 10.35, 'Blanditiis placeat aut numquam odit consequatur natus. Nihil unde nihil eligendi voluptas. Aliquid ut optio dolorem laboriosam sapiente quia dignissimos.', 21.16, 2.00, 'ml', 1, 0, 4, 6, '2021-06-17 17:39:53', '2021-06-17 17:39:53'),
(5, 'Cheese', 48.88, 0.00, 'Quo dolorem sint perspiciatis atque optio quis. Possimus hic soluta consectetur in est dolor fuga. Modi dolor qui quae quae quos dolorum. Est sed dolor reprehenderit. Aut aut id ea qui.', 423.66, 6.00, 'm', 1, 1, 9, 2, '2021-06-17 17:39:53', '2021-06-17 17:39:53'),
(6, 'Honey', 11.49, 6.34, 'Sit enim quas necessitatibus veniam praesentium quidem doloremque. Mollitia voluptatem porro unde quo. Ipsum numquam ipsum quas cum voluptatem sunt.', 259.06, 2.00, 'Oz', 1, 1, 5, 3, '2021-06-17 17:39:53', '2021-06-17 17:39:53'),
(7, 'Cupcake', 18.57, 0.00, 'Sit fugit voluptatem totam aut. Sunt eaque id ab modi deleniti voluptatum facere et. Veritatis animi reprehenderit quia et.', 113.74, 4.00, 'm', 1, 0, 1, 5, '2021-06-17 17:39:53', '2021-06-17 17:39:53'),
(8, 'Honey', 24.69, 0.00, 'Sunt quisquam voluptates nobis est. Consequuntur qui similique dolores voluptatum tempore excepturi.', 463.51, 6.00, 'm²', 1, 1, 8, 3, '2021-06-17 17:39:53', '2021-06-17 17:39:53'),
(9, 'Steak', 16.92, 7.46, 'Suscipit rerum aut eius quis doloremque et. Omnis quo sit quasi velit dicta. Dolor voluptatum maxime at ea voluptate quidem blanditiis earum. Eveniet aut et est iusto qui.', 206.57, 4.00, 'Oz', 0, 0, 4, 1, '2021-06-17 17:39:53', '2021-06-17 17:39:53'),
(10, 'Cupcake', 26.48, 20.67, 'Quasi tenetur laudantium omnis temporibus in id quia. Molestiae dolorem corporis repellendus sit ut. Et iste perspiciatis ad optio asperiores. Molestias veniam et voluptas quis.', 337.50, 4.00, 'Kg', 0, 0, 7, 2, '2021-06-17 17:39:53', '2021-06-17 17:39:53'),
(11, 'Sandwich', 10.44, 0.00, 'Non nulla vel vero. Quo dolorem accusamus qui occaecati officiis tempore. Quo perspiciatis est accusantium modi velit cumque.', 295.06, 2.00, 'm²', 0, 0, 3, 3, '2021-06-17 17:39:53', '2021-06-17 17:39:53'),
(12, 'Pasta', 22.09, 0.00, 'Tempora et rem praesentium sunt nihil quia. Voluptatem et quo saepe omnis voluptates adipisci reiciendis. Qui dolor natus praesentium commodi. Hic possimus qui consectetur et ullam laudantium et.', 448.67, 4.00, 'Oz', 1, 0, 2, 6, '2021-06-17 17:39:53', '2021-06-17 17:39:53'),
(13, 'Sandwich', 49.22, 40.04, 'Illum enim excepturi tempore et ullam possimus. Quia nisi ex ipsa. Vero ipsam saepe omnis quibusdam atque quis.', 335.42, 3.00, 'ml', 0, 1, 5, 4, '2021-06-17 17:39:53', '2021-06-17 17:39:53'),
(14, 'Vinegar', 23.22, 17.66, 'Beatae consequatur ut nisi asperiores officia. Accusantium porro repudiandae sunt laboriosam quo. Nulla esse maiores tenetur nemo at odio eum. Quae vitae quia exercitationem unde.', 389.07, 5.00, 'Kg', 0, 1, 9, 4, '2021-06-17 17:39:53', '2021-06-17 17:39:53'),
(15, 'Tuna steak', 42.12, 35.85, 'Quod sed autem hic explicabo voluptas. At et enim sapiente non itaque.', 22.83, 5.00, 'm', 1, 1, 3, 2, '2021-06-17 17:39:53', '2021-06-17 17:39:53'),
(16, 'Sugar', 21.80, 13.30, 'Nulla nihil et deleniti eius sit. Officia sit ipsam sed vel. Est atque ut aut ut. In et fuga et laboriosam omnis libero incidunt. A dicta magni est temporibus nisi repudiandae.', 375.09, 1.00, 'g', 1, 1, 8, 1, '2021-06-17 17:39:54', '2021-06-17 17:39:54'),
(17, 'Cupcake', 20.80, 16.22, 'Saepe blanditiis amet quas animi rem officia non. Sint unde omnis repellendus in numquam dolorem architecto. Quo ut quae molestias ut velit. Iusto velit vero aliquam consequatur et porro.', 60.82, 5.00, 'Oz', 0, 1, 2, 1, '2021-06-17 17:39:54', '2021-06-17 17:39:54'),
(18, 'Cupcake', 19.27, 12.18, 'Aliquam impedit quisquam nisi qui deserunt perferendis recusandae. Odit molestiae omnis eos. Est harum sunt autem dolor libero dolorem sit. Omnis doloribus quibusdam dolores.', 67.26, 4.00, 'Oz', 1, 0, 6, 4, '2021-06-17 17:39:54', '2021-06-17 17:39:54'),
(19, 'Sandwich', 31.76, 0.00, 'Quidem corporis at nihil quasi. Hic voluptatibus veniam cupiditate quam et veritatis eveniet. Iusto a praesentium impedit vel dignissimos et nemo.', 327.74, 2.00, 'Oz', 1, 1, 4, 3, '2021-06-17 17:39:54', '2021-06-17 17:39:54'),
(20, 'Bread', 12.11, 4.88, 'Est magni excepturi distinctio quas natus repellendus sunt quibusdam. Assumenda praesentium dolorem autem molestiae mollitia. Esse alias inventore provident voluptatum inventore.', 202.53, 3.00, 'ml', 1, 0, 5, 6, '2021-06-17 17:39:54', '2021-06-17 17:39:54'),
(21, 'Sandwich', 19.70, 0.00, 'Omnis nihil in maiores ratione earum distinctio rerum. Veniam quis qui minima inventore excepturi qui consequatur. Assumenda earum eos quisquam ipsa aut.', 30.02, 2.00, 'L', 0, 0, 5, 3, '2021-06-17 17:39:54', '2021-06-17 17:39:54'),
(22, 'Steak', 11.26, 0.00, 'Velit et consequuntur at amet. In dolor alias quod nesciunt sapiente. Assumenda molestiae quas omnis facere debitis.', 68.64, 2.00, 'm', 0, 0, 4, 1, '2021-06-17 17:39:54', '2021-06-17 17:39:54'),
(23, 'Salad', 21.86, 0.00, 'Facilis accusamus mollitia expedita voluptatem. Velit vel sit nihil ex qui. Assumenda quae et enim neque explicabo.', 493.10, 1.00, 'g', 1, 0, 1, 1, '2021-06-17 17:39:54', '2021-06-17 17:39:54'),
(24, 'Cookie', 15.89, 13.03, 'At facilis quos reprehenderit nisi aut fugit. Reiciendis voluptatem qui voluptas provident. Nihil minus perferendis inventore cumque aut aspernatur et.', 443.35, 5.00, 'ml', 1, 0, 9, 5, '2021-06-17 17:39:54', '2021-06-17 17:39:54'),
(25, 'Aspirin', 44.17, 0.00, 'Quas eum nihil facilis voluptatem animi. Dolorem iusto tenetur excepturi qui. Tenetur aspernatur ullam excepturi quia eum harum.', 117.00, 2.00, 'm²', 0, 0, 10, 3, '2021-06-17 17:39:54', '2021-06-17 17:39:54'),
(26, 'Bread', 20.24, 0.00, 'Et aut voluptatibus laboriosam occaecati tempore recusandae omnis asperiores. Dolorem numquam velit natus deserunt.', 31.98, 4.00, 'ml', 1, 0, 9, 3, '2021-06-17 17:39:54', '2021-06-17 17:39:54'),
(27, 'Cupcake', 18.09, 0.00, 'Omnis sunt ut voluptas. Enim omnis enim rem voluptatem eum. Corrupti at enim excepturi impedit eum sit.', 283.23, 4.00, 'Kg', 1, 0, 1, 4, '2021-06-17 17:39:54', '2021-06-17 17:39:54'),
(28, 'Spaghetti', 31.56, 0.00, 'Nobis aut aut laboriosam vitae. Est sunt fugiat voluptatem voluptas. Voluptatibus at adipisci harum praesentium dolorem. Qui repellendus earum veritatis voluptates qui omnis id.', 152.50, 2.00, 'Kg', 0, 1, 7, 3, '2021-06-17 17:39:54', '2021-06-17 17:39:54'),
(29, 'Pasta', 37.06, 0.00, 'Natus voluptatem id autem suscipit debitis. Aut odio praesentium quod dolorum aut repellendus voluptas. Ex sed magnam qui sed debitis enim incidunt quia. Est nulla corporis reiciendis illum quasi in.', 361.30, 1.00, 'Kg', 0, 1, 7, 2, '2021-06-17 17:39:54', '2021-06-17 17:39:54'),
(30, 'Fish', 35.19, 0.00, 'Ipsum non adipisci error facere quia eum. Sed quia reiciendis fuga quasi et. Expedita nihil quia rerum quia culpa ea.', 219.83, 1.00, 'Oz', 1, 0, 1, 5, '2021-06-17 17:39:54', '2021-06-17 17:39:54'),
(31, 'Aspirin', 41.80, 34.21, 'Sit veniam quia facere ea numquam architecto facilis. Quam sed deserunt labore amet consequatur hic. Expedita enim vitae est ipsa.', 301.78, 4.00, 'm²', 1, 0, 10, 3, '2021-06-17 17:39:54', '2021-06-17 17:39:54'),
(32, 'Salad', 22.05, 18.87, 'Sed eius sed rerum enim debitis voluptas delectus. Voluptatum labore aut debitis natus minima optio. Ipsum qui rem et eligendi quis. Quos beatae aliquam ratione et.', 181.84, 6.00, 'ml', 1, 1, 4, 1, '2021-06-17 17:39:54', '2021-06-17 17:39:54'),
(33, 'Aspirin', 34.15, 31.03, 'Ducimus voluptatem nisi molestiae molestias consequatur voluptatum iure. Fugit quasi distinctio fugit minima nulla veritatis iusto.', 61.23, 6.00, 'L', 1, 1, 5, 4, '2021-06-17 17:39:54', '2021-06-17 17:39:54'),
(34, 'Acarbose', 39.85, 0.00, 'Et qui quia unde aut. Veniam officia possimus sint placeat et amet. Ut cumque ad consequuntur esse. Corporis dolores quae quia provident impedit rerum.', 251.59, 1.00, 'Kg', 1, 1, 10, 6, '2021-06-17 17:39:54', '2021-06-17 17:39:54'),
(35, 'Pasta', 16.85, 0.00, 'Ab quia totam impedit quia vel vitae. Debitis accusantium unde autem et ut non ut reiciendis. Qui quibusdam repellat omnis non quis sapiente nesciunt.', 123.01, 6.00, 'Kg', 0, 1, 6, 2, '2021-06-17 17:39:54', '2021-06-17 17:39:54'),
(36, 'Soup', 35.93, 27.10, 'Dicta debitis ipsa nobis. Eum nemo quae commodi ducimus. Nihil temporibus est voluptatem in.', 372.77, 5.00, 'm²', 0, 1, 3, 5, '2021-06-17 17:39:54', '2021-06-17 17:39:54'),
(37, 'Salad', 29.82, 26.19, 'Nihil hic dolorem nam. Aliquam voluptas atque eos vitae dignissimos iure quia. Eaque dolores modi est. Inventore consequatur rem aut sit et. Ut ratione ipsa ad quia dolores.', 212.67, 4.00, 'Kg', 1, 1, 10, 2, '2021-06-17 17:39:54', '2021-06-17 17:39:54'),
(38, 'Soup', 37.14, 0.00, 'Est nulla id aperiam nobis dolorem id aspernatur sequi. Laudantium ut est quibusdam nihil. Dolor magni ut est. Qui architecto voluptatibus debitis eum sint.', 416.96, 3.00, 'Kg', 1, 1, 6, 1, '2021-06-17 17:39:54', '2021-06-17 17:39:54'),
(39, 'Onion', 17.36, 0.00, 'Qui iure vero est aut aut aperiam. Qui provident velit doloremque libero excepturi cum. Maxime earum ducimus consequuntur dolor nihil. Voluptatem doloribus ipsam non libero nemo.', 387.30, 6.00, 'm²', 0, 1, 9, 6, '2021-06-17 17:39:54', '2021-06-17 17:39:54'),
(40, 'Vinegar', 12.82, 6.64, 'Distinctio dolores quae rerum ducimus eos. At soluta vel est cupiditate. Voluptatem deleniti nisi ipsam optio est. Et reiciendis rerum dolorum hic. Qui id itaque quia autem officia eius aut.', 75.49, 4.00, 'Kg', 1, 0, 1, 5, '2021-06-17 17:39:54', '2021-06-17 17:39:54');

-- --------------------------------------------------------

--
-- Table structure for table `product_orders`
--

CREATE TABLE `product_orders` (
  `id` int(10) UNSIGNED NOT NULL,
  `price` double(8,2) NOT NULL DEFAULT 0.00,
  `quantity` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `product_id` int(10) UNSIGNED NOT NULL,
  `order_id` int(10) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `product_orders`
--

INSERT INTO `product_orders` (`id`, `price`, `quantity`, `product_id`, `order_id`, `created_at`, `updated_at`) VALUES
(1, 18.57, 9, 7, 2, '2021-06-19 04:16:12', '2021-06-19 04:16:12'),
(2, 31.76, 2, 19, 3, '2021-06-19 09:05:23', '2021-06-19 09:05:23'),
(3, 35.19, 2, 30, 4, '2021-06-21 13:11:24', '2021-06-21 13:11:24'),
(4, 24.48, 2, 1, 5, '2021-06-21 18:27:57', '2021-06-21 18:27:57');

-- --------------------------------------------------------

--
-- Table structure for table `product_order_options`
--

CREATE TABLE `product_order_options` (
  `product_order_id` int(10) UNSIGNED NOT NULL,
  `option_id` int(10) UNSIGNED NOT NULL,
  `price` double(8,2) NOT NULL DEFAULT 0.00
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `product_reviews`
--

CREATE TABLE `product_reviews` (
  `id` int(10) UNSIGNED NOT NULL,
  `review` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `rate` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `user_id` int(10) UNSIGNED NOT NULL,
  `product_id` int(10) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `product_reviews`
--

INSERT INTO `product_reviews` (`id`, `review`, `rate`, `user_id`, `product_id`, `created_at`, `updated_at`) VALUES
(1, 'And the Eaglet bent down its head impatiently, and said, very gravely, \'I think, you ought to tell you--all I know I have ordered\'; and she tried to say when I get it home?\' when it saw Alice. It.', 4, 5, 16, '2021-06-17 17:39:55', '2021-06-17 17:39:55'),
(2, 'I beat him when he sneezes; For he can EVEN finish, if he thought it would be quite absurd for her neck from being broken. She hastily put down her anger as well as she listened, or seemed to be an.', 5, 2, 8, '2021-06-17 17:39:55', '2021-06-17 17:39:55'),
(3, 'I will just explain to you to set about it; if I\'m not Ada,\' she said, \'and see whether it\'s marked \"poison\" or not\'; for she had quite forgotten the little door, so she took courage, and went down.', 4, 3, 4, '2021-06-17 17:39:55', '2021-06-17 17:39:55'),
(4, 'THAT direction,\' the Cat said, waving its tail when I\'m angry. Therefore I\'m mad.\' \'I call it purring, not growling,\' said Alice. \'Why not?\' said the Pigeon went on, spreading out the Fish-Footman.', 1, 5, 5, '2021-06-17 17:39:55', '2021-06-17 17:39:55'),
(5, 'She felt very curious thing, and longed to get out again. The rabbit-hole went straight on like a telescope.\' And so she sat down again very sadly and quietly, and looked at the bottom of a well?\'.', 2, 6, 17, '2021-06-17 17:39:55', '2021-06-17 17:39:55'),
(6, 'Alice thoughtfully: \'but then--I shouldn\'t be hungry for it, you know.\' \'And what an ignorant little girl she\'ll think me for his housemaid,\' she said to Alice. \'What IS the use of this was the.', 2, 3, 23, '2021-06-17 17:39:55', '2021-06-17 17:39:55'),
(7, 'She had just begun to dream that she was surprised to find her way out. \'I shall sit here,\' he said, \'on and off, for days and days.\' \'But what am I to do next, when suddenly a White Rabbit as he.', 5, 3, 21, '2021-06-17 17:39:55', '2021-06-17 17:39:55'),
(8, 'Bill! I wouldn\'t say anything about it, even if my head would go through,\' thought poor Alice, who always took a minute or two, looking for it, while the Mock Turtle drew a long silence after this.', 4, 2, 16, '2021-06-17 17:39:55', '2021-06-17 17:39:55'),
(9, 'Gryphon. \'Do you take me for his housemaid,\' she said to a mouse, you know. Come on!\' \'Everybody says \"come on!\" here,\' thought Alice, \'to speak to this last remark that had fallen into it: there.', 3, 6, 13, '2021-06-17 17:39:55', '2021-06-17 17:39:55'),
(10, 'Adventures of hers would, in the grass, merely remarking as it left no mark on the song, \'I\'d have said to herself, \'the way all the players, except the Lizard, who seemed ready to sink into the.', 3, 2, 30, '2021-06-17 17:39:55', '2021-06-17 17:39:55'),
(11, 'Dormouse went on, \'What HAVE you been doing here?\' \'May it please your Majesty,\' said the White Rabbit hurried by--the frightened Mouse splashed his way through the glass, and she crossed her hands.', 3, 5, 24, '2021-06-17 17:39:55', '2021-06-17 17:39:55'),
(12, 'Mock Turtle said: \'advance twice, set to work, and very soon finished it off. \'If everybody minded their own business!\' \'Ah, well! It means much the most curious thing I ask! It\'s always six o\'clock.', 3, 5, 21, '2021-06-17 17:39:56', '2021-06-17 17:39:56'),
(13, 'London is the same when I got up and rubbed its eyes: then it chuckled. \'What fun!\' said the Cat. \'--so long as there seemed to be a lesson to you how the Dodo managed it.) First it marked out a.', 4, 4, 14, '2021-06-17 17:39:56', '2021-06-17 17:39:56'),
(14, 'Mock Turtle went on again: \'Twenty-four hours, I THINK; or is it directed to?\' said one of the trees as well be at school at once.\' And in she went. Once more she found herself lying on their.', 4, 5, 4, '2021-06-17 17:39:56', '2021-06-17 17:39:56'),
(15, 'Duchess by this time, and was delighted to find my way into that lovely garden. I think I could, if I chose,\' the Duchess by this time?\' she said these words her foot as far down the middle, being.', 5, 6, 15, '2021-06-17 17:39:56', '2021-06-17 17:39:56'),
(16, 'Take your choice!\' The Duchess took no notice of her knowledge. \'Just think of anything to say, she simply bowed, and took the place where it had been. But her sister on the other was sitting on the.', 3, 6, 26, '2021-06-17 17:39:56', '2021-06-17 17:39:56'),
(17, 'CAN all that stuff,\' the Mock Turtle. \'Hold your tongue!\' said the Caterpillar. \'Well, I\'ve tried hedges,\' the Pigeon in a frightened tone. \'The Queen of Hearts, she made out the answer to shillings.', 2, 1, 3, '2021-06-17 17:39:56', '2021-06-17 17:39:56'),
(18, 'Queen. First came ten soldiers carrying clubs; these were all locked; and when she had not a bit afraid of it. She felt that it was growing, and she said this, she noticed that the poor little thing.', 1, 1, 23, '2021-06-17 17:39:56', '2021-06-17 17:39:56'),
(19, 'Duchess said after a fashion, and this he handed over to the King, \'and don\'t be nervous, or I\'ll kick you down stairs!\' \'That is not said right,\' said the Hatter. He had been to the little golden.', 5, 4, 24, '2021-06-17 17:39:56', '2021-06-17 17:39:56'),
(20, 'Just as she fell past it. \'Well!\' thought Alice to herself, for this time with great curiosity. \'Soles and eels, of course,\' he said do. Alice looked up, but it puzzled her very earnestly, \'Now.', 1, 2, 17, '2021-06-17 17:39:56', '2021-06-17 17:39:56'),
(21, 'Shall I try the first figure,\' said the Duchess, as she spoke. \'I must be a very humble tone, going down on one side, to look at all know whether it was getting very sleepy; \'and they all crowded.', 2, 2, 2, '2021-06-17 17:39:56', '2021-06-17 17:39:56'),
(22, 'I THINK,\' said Alice. \'Of course it is,\' said the Cat. \'Do you take me for asking! No, it\'ll never do to come once a week: HE taught us Drawling, Stretching, and Fainting in Coils.\' \'What was THAT.', 2, 2, 16, '2021-06-17 17:39:56', '2021-06-17 17:39:56'),
(23, 'Duck and a great crash, as if she had made the whole thing, and longed to change the subject of conversation. \'Are you--are you fond--of--of dogs?\' The Mouse only shook its head impatiently, and.', 1, 3, 27, '2021-06-17 17:39:56', '2021-06-17 17:39:56'),
(24, 'I don\'t take this child away with me,\' thought Alice, as she could have been ill.\' \'So they were,\' said the Caterpillar contemptuously. \'Who are YOU?\' Which brought them back again to the game.', 1, 3, 15, '2021-06-17 17:39:56', '2021-06-17 17:39:56'),
(25, 'By the use of a muchness?\' \'Really, now you ask me,\' said Alice, in a helpless sort of lullaby to it as well as she swam lazily about in the pool, and the sound of a tree a few minutes it puffed.', 4, 2, 14, '2021-06-17 17:39:56', '2021-06-17 17:39:56'),
(26, 'Alice, and, after folding his arms and frowning at the mouth with strings: into this they slipped the guinea-pig, head first, and then, and holding it to his son, \'I feared it might happen any.', 2, 5, 21, '2021-06-17 17:39:56', '2021-06-17 17:39:56'),
(27, 'Hatter: \'let\'s all move one place on.\' He moved on as he spoke, \'we were trying--\' \'I see!\' said the Dodo, \'the best way to explain the mistake it had no idea how to begin.\' For, you see, Miss, this.', 4, 2, 13, '2021-06-17 17:39:56', '2021-06-17 17:39:56'),
(28, 'Alice timidly. \'Would you tell me,\' said Alice, \'because I\'m not the smallest idea how to get through was more hopeless than ever: she sat on, with closed eyes, and feebly stretching out one paw.', 3, 2, 19, '2021-06-17 17:39:56', '2021-06-17 17:39:56'),
(29, 'Canary called out \'The Queen! The Queen!\' and the three gardeners, oblong and flat, with their fur clinging close to her: first, because the Duchess and the Hatter said, turning to the little door.', 3, 2, 1, '2021-06-17 17:39:56', '2021-06-17 17:39:56'),
(30, 'Either the well was very provoking to find quite a long way back, and barking hoarsely all the players, except the Lizard, who seemed too much frightened that she had brought herself down to look at.', 3, 4, 14, '2021-06-17 17:39:56', '2021-06-17 17:39:56'),
(31, 'great', 5, 4, 7, '2021-06-19 08:21:35', '2021-06-19 08:21:35');

-- --------------------------------------------------------

--
-- Table structure for table `roles`
--

CREATE TABLE `roles` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `guard_name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'web',
  `default` tinyint(1) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `roles`
--

INSERT INTO `roles` (`id`, `name`, `guard_name`, `default`, `created_at`, `updated_at`, `deleted_at`) VALUES
(2, 'admin', 'web', 0, '2018-07-21 15:37:56', '2019-09-07 21:42:01', NULL),
(3, 'manager', 'web', 0, '2019-09-07 21:41:38', '2019-09-07 21:41:38', NULL),
(4, 'client', 'web', 1, '2019-09-07 21:41:54', '2019-09-07 21:41:54', NULL),
(5, 'driver', 'web', 0, '2019-12-15 18:50:21', '2019-12-15 18:50:21', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `role_has_permissions`
--

CREATE TABLE `role_has_permissions` (
  `permission_id` int(10) UNSIGNED NOT NULL,
  `role_id` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `role_has_permissions`
--

INSERT INTO `role_has_permissions` (`permission_id`, `role_id`) VALUES
(1, 2),
(1, 3),
(1, 4),
(1, 5),
(2, 2),
(3, 2),
(3, 3),
(3, 4),
(3, 5),
(4, 2),
(4, 3),
(4, 4),
(4, 5),
(5, 2),
(5, 3),
(6, 2),
(9, 2),
(10, 2),
(14, 2),
(15, 2),
(16, 2),
(17, 2),
(18, 2),
(19, 2),
(20, 2),
(21, 2),
(22, 2),
(23, 2),
(24, 2),
(26, 2),
(27, 2),
(27, 3),
(27, 4),
(27, 5),
(28, 2),
(29, 2),
(30, 2),
(30, 3),
(30, 4),
(30, 5),
(31, 2),
(31, 3),
(31, 4),
(32, 2),
(32, 3),
(32, 4),
(33, 2),
(33, 3),
(34, 2),
(34, 3),
(35, 2),
(36, 2),
(37, 2),
(38, 2),
(39, 2),
(40, 2),
(41, 2),
(42, 2),
(42, 3),
(43, 2),
(44, 2),
(45, 2),
(46, 2),
(47, 2),
(48, 2),
(48, 3),
(48, 5),
(50, 2),
(51, 2),
(52, 2),
(52, 3),
(52, 4),
(52, 5),
(53, 2),
(53, 3),
(54, 2),
(54, 3),
(55, 2),
(55, 3),
(56, 2),
(56, 3),
(57, 2),
(57, 3),
(58, 2),
(58, 3),
(59, 2),
(59, 3),
(60, 2),
(60, 3),
(61, 2),
(61, 3),
(62, 2),
(62, 3),
(63, 2),
(63, 3),
(64, 2),
(64, 3),
(64, 4),
(64, 5),
(67, 2),
(67, 3),
(67, 4),
(67, 5),
(68, 2),
(68, 3),
(68, 4),
(68, 5),
(69, 2),
(76, 2),
(76, 3),
(77, 2),
(77, 3),
(78, 2),
(78, 3),
(80, 2),
(80, 3),
(81, 2),
(81, 3),
(82, 2),
(82, 3),
(83, 2),
(83, 3),
(83, 4),
(83, 5),
(85, 2),
(86, 2),
(86, 3),
(86, 4),
(86, 5),
(87, 2),
(88, 2),
(89, 2),
(90, 2),
(91, 2),
(92, 2),
(92, 3),
(92, 4),
(92, 5),
(95, 2),
(95, 3),
(95, 4),
(95, 5),
(96, 2),
(96, 3),
(96, 4),
(96, 5),
(97, 2),
(98, 2),
(98, 3),
(98, 4),
(98, 5),
(103, 2),
(103, 3),
(103, 4),
(103, 5),
(104, 2),
(104, 3),
(104, 4),
(104, 5),
(107, 2),
(107, 3),
(107, 4),
(107, 5),
(108, 2),
(108, 3),
(109, 2),
(109, 3),
(110, 2),
(110, 3),
(111, 2),
(111, 3),
(111, 4),
(111, 5),
(112, 2),
(113, 2),
(113, 3),
(113, 4),
(113, 5),
(114, 2),
(114, 3),
(114, 4),
(114, 5),
(117, 2),
(117, 3),
(117, 4),
(117, 5),
(118, 2),
(119, 2),
(120, 2),
(121, 2),
(122, 2),
(123, 2),
(124, 2),
(127, 2),
(128, 2),
(129, 2),
(130, 2),
(130, 3),
(130, 5),
(131, 2),
(134, 2),
(134, 3),
(135, 2),
(135, 3),
(137, 2),
(137, 3),
(138, 2),
(144, 2),
(144, 5),
(145, 2),
(145, 3),
(145, 5),
(146, 2),
(146, 3),
(146, 5),
(148, 2),
(149, 2),
(151, 2),
(151, 3),
(152, 2),
(152, 3),
(153, 2),
(153, 3),
(155, 2),
(156, 2),
(160, 2),
(164, 2),
(164, 3),
(164, 4),
(164, 5),
(165, 2),
(166, 2),
(167, 2),
(168, 2),
(169, 2),
(170, 2),
(170, 3),
(171, 2),
(171, 3),
(172, 2),
(172, 3),
(173, 2),
(174, 2),
(175, 2),
(176, 2),
(176, 3),
(176, 4),
(176, 5),
(183, 2),
(183, 3),
(183, 4),
(183, 5),
(184, 2),
(185, 2),
(186, 2),
(186, 3),
(187, 2),
(187, 3),
(188, 2),
(189, 2),
(190, 2),
(191, 2),
(192, 2),
(193, 2),
(194, 2);

-- --------------------------------------------------------

--
-- Table structure for table `slides`
--

CREATE TABLE `slides` (
  `id` int(10) UNSIGNED NOT NULL,
  `order` int(10) UNSIGNED DEFAULT 0,
  `text` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `button` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `text_position` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT 'start',
  `text_color` varchar(36) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `button_color` varchar(36) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `background_color` varchar(36) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `indicator_color` varchar(36) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `image_fit` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT 'cover',
  `product_id` int(10) UNSIGNED DEFAULT NULL,
  `market_id` int(10) UNSIGNED DEFAULT NULL,
  `enabled` tinyint(1) DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `slides`
--

INSERT INTO `slides` (`id`, `order`, `text`, `button`, `text_position`, `text_color`, `button_color`, `background_color`, `indicator_color`, `image_fit`, `product_id`, `market_id`, `enabled`, `created_at`, `updated_at`) VALUES
(1, 3, 'Reiciendis magnam itaque hic.', 'Get Discount', 'center', '#25d366', '#25d366', '#ccccdd', '#25d366', 'cover', 1, NULL, 1, '2021-06-17 17:40:02', '2021-06-17 17:40:02'),
(2, 1, 'Adipisci et est qui.', 'Order Now', 'start', '#25d366', '#25d366', '#ccccdd', '#25d366', 'cover', 2, NULL, 1, '2021-06-17 17:40:02', '2021-06-17 17:40:02'),
(3, 4, 'Sit eveniet natus amet beatae doloribus.', 'Order Now', 'end', '#25d366', '#25d366', '#ccccdd', '#25d366', 'cover', 9, NULL, 1, '2021-06-17 17:40:02', '2021-06-17 17:40:02'),
(4, 3, 'Et voluptas officiis modi eveniet.', 'Discover It', 'center', '#25d366', '#25d366', '#ccccdd', '#25d366', 'cover', 8, NULL, 1, '2021-06-17 17:40:02', '2021-06-17 17:40:02'),
(5, 2, 'Occaecati et accusamus reiciendis.', 'Order Now', 'center', '#25d366', '#25d366', '#ccccdd', '#25d366', 'cover', NULL, 3, 0, '2021-06-17 17:40:02', '2021-06-17 17:40:02');

-- --------------------------------------------------------

--
-- Table structure for table `uploads`
--

CREATE TABLE `uploads` (
  `id` int(10) UNSIGNED NOT NULL,
  `uuid` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `uploads`
--

INSERT INTO `uploads` (`id`, `uuid`, `created_at`, `updated_at`) VALUES
(1, 'abce01f2-2248-489c-b4a6-53217cfbfc12', '2021-06-19 04:32:41', '2021-06-19 04:32:41'),
(2, 'c6adb1a0-b964-4027-b7a1-7af8c8b842dc', '2021-06-19 04:33:06', '2021-06-19 04:33:06'),
(3, '253ee9eb-6038-4884-91b3-e7d15c789a20', '2021-06-19 04:34:09', '2021-06-19 04:34:09');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `api_token` char(60) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `device_token` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `stripe_id` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `card_brand` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `card_last_four` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `trial_ends_at` timestamp NULL DEFAULT NULL,
  `braintree_id` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `paypal_email` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `password`, `api_token`, `device_token`, `stripe_id`, `card_brand`, `card_last_four`, `trial_ends_at`, `braintree_id`, `paypal_email`, `remember_token`, `created_at`, `updated_at`) VALUES
(1, 'Michael E. Quinn', 'admin@demo.com', '$2y$10$YOn/Xq6vfvi9oaixrtW8QuM2W0mawkLLqIxL.IoGqrsqOqbIsfBNu', 'PivvPlsQWxPl1bB5KrbKNBuraJit0PrUZekQUgtLyTRuyBq921atFtoR1HuA', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'fcrbBsUqYU7CK9t7ArCVhkI9cyfUuP8JX3PCWqitTQDllfMhBgbfSvoaaEk0', '2018-08-06 21:58:41', '2019-09-27 06:49:45'),
(2, 'Barbara J. Glanz', 'manager@demo.com', '$2y$10$YOn/Xq6vfvi9oaixrtW8QuM2W0mawkLLqIxL.IoGqrsqOqbIsfBNu', 'tVSfIKRSX2Yn8iAMoUS3HPls84ycS8NAxO2dj2HvePbbr4WHorp4gIFRmFwB', 'c1AfuzFGTLGlVqkIE7pE2a:APA91bFDnRMcDSlBt48ABmJVIKOAvE6VfiUCylA6_xdn8lcIPK8cBI_ocxm9A67chQ4KT2nCzjWzUGh4Oft0LI76S9I0Q13mF1xEvfdG7DUDGC9xMTn2ycJHLBOtbmXyVl_3uWkOiAzS', NULL, NULL, NULL, NULL, NULL, NULL, '5nysjzVKI4LU92bjRqMUSYdOaIo1EcPC3pIMb6Tcj2KXSUMriGrIQ1iwRdd0', '2018-08-14 16:06:28', '2021-06-19 09:01:03'),
(3, 'Charles W. Abeyta', 'client@demo.com', '$2y$10$EBubVy3wDbqNbHvMQwkj3OTYVitL8QnHvh/zV0ICVOaSbALy5dD0K', 'fXLu7VeYgXDu82SkMxlLPG1mCAXc4EBIx6O5isgYVIKFQiHah0xiOHmzNsBv', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'V6PIUfd8JdHT2zkraTlnBcRSINZNjz5Ou7N0WtUGRyaTweoaXKpSfij6UhqC', '2019-10-12 21:31:26', '2020-03-29 16:44:30'),
(4, 'Robert E. Brock', 'client1@demo.com', '$2y$10$pmdnepS1FhZUMqOaFIFnNO0spltJpziz3j13UqyEwShmLhokmuoei', 'Czrsk9rwD0c75NUPkzNXM2WvbxYHKj8p0nG29pjKT0PZaTgMVzuVyv4hOlte', 'c1E9KvUPTs6-3j1SPJ1YgX:APA91bHPnq36X_ma3o8_LwFkbK0wQkNYzG46efa5oQiTAKsIdiyAMlACznLyfUqzTDPm9BTX8ECRay-s__n3Q_sinJTF0DitqHyGf8ymrV0UJGmge-wsc0UN2OshViq-7mEqYkhOgrkI', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-10-15 16:55:39', '2021-06-19 08:09:48'),
(5, 'Sanchez Roberto', 'driver@demo.com', '$2y$10$T/jwzYDJfC8c9CdD5PbpuOKvEXlpv4.RR1jMT0PgIMT.fzeGw67JO', 'OuMsmU903WMcMhzAbuSFtxBekZVdXz66afifRo3YRCINi38jkXJ8rpN0FcfS', 'fbqHOVf6REO3xk5bN7XxWK:APA91bGFGjRjNQuJ_nDlTQwnX-VsA4zDMf5oVZWFyLkLghJ_s80W1R8Xn2HPgNcP3rgAVBW4Pob1wDR7Ny4GObVqorGOZYSDHvtszF_iCRfNE6dTG5pCqjNfDpKm2SKKJ7_CywI7PWUB', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-12-15 18:49:44', '2021-06-19 09:58:19'),
(6, 'John Doe', 'driver1@demo.com', '$2y$10$YF0jCx2WCQtfZOq99hR8kuXsAE0KSnu5OYSomRtI9iCVguXDoDqVm', 'zh9mzfNO2iPtIxj6k4Jpj8flaDyOsxmlGRVUZRnJqOGBr8IuDyhb3cGoncvS', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2020-03-29 16:28:04', '2020-03-29 16:28:04'),
(7, 'tester', 'tester@gmail.com', '$2y$10$NdQHioT7zZEn/hg7WXq2VuXY61JlWdzEJKLaYIJEdT/n1Qsgrw6Q.', 'ztXmr3Ljna2OXnYzY8aYGCEI5TtKjpdQGogc599Xm2NUY1k2UR36qY43gy2e', 'cg-pDYaASlWLztDY61AAKL:APA91bGzs8nReMgO-s_IPfGmN4E2dbDJ8e3P_fW2KBeo1XdMzkWKis_v4cZmV1SSuMybDQMJ_1G4hgAeumDgzMQ_0FpAHqzll6CAG6LH8UVIAL3OZuIJ6BrzVGTnBgbUCrpeKP14zJeb', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2021-06-18 04:50:47', '2021-06-18 14:42:44');

-- --------------------------------------------------------

--
-- Table structure for table `user_markets`
--

CREATE TABLE `user_markets` (
  `user_id` int(10) UNSIGNED NOT NULL,
  `market_id` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `user_markets`
--

INSERT INTO `user_markets` (`user_id`, `market_id`) VALUES
(1, 2),
(1, 5),
(1, 6),
(2, 3),
(2, 4);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `app_settings`
--
ALTER TABLE `app_settings`
  ADD PRIMARY KEY (`id`),
  ADD KEY `app_settings_key_index` (`key`);

--
-- Indexes for table `carts`
--
ALTER TABLE `carts`
  ADD PRIMARY KEY (`id`),
  ADD KEY `carts_product_id_foreign` (`product_id`),
  ADD KEY `carts_user_id_foreign` (`user_id`);

--
-- Indexes for table `cart_options`
--
ALTER TABLE `cart_options`
  ADD PRIMARY KEY (`option_id`,`cart_id`),
  ADD KEY `cart_options_cart_id_foreign` (`cart_id`);

--
-- Indexes for table `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `coupons`
--
ALTER TABLE `coupons`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `coupons_code_unique` (`code`);

--
-- Indexes for table `currencies`
--
ALTER TABLE `currencies`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `custom_fields`
--
ALTER TABLE `custom_fields`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `custom_field_values`
--
ALTER TABLE `custom_field_values`
  ADD PRIMARY KEY (`id`),
  ADD KEY `custom_field_values_custom_field_id_foreign` (`custom_field_id`);

--
-- Indexes for table `delivery_addresses`
--
ALTER TABLE `delivery_addresses`
  ADD PRIMARY KEY (`id`),
  ADD KEY `delivery_addresses_user_id_foreign` (`user_id`);

--
-- Indexes for table `discountables`
--
ALTER TABLE `discountables`
  ADD PRIMARY KEY (`id`),
  ADD KEY `discountables_coupon_id_foreign` (`coupon_id`);

--
-- Indexes for table `drivers`
--
ALTER TABLE `drivers`
  ADD PRIMARY KEY (`id`),
  ADD KEY `drivers_user_id_foreign` (`user_id`);

--
-- Indexes for table `drivers_payouts`
--
ALTER TABLE `drivers_payouts`
  ADD PRIMARY KEY (`id`),
  ADD KEY `drivers_payouts_user_id_foreign` (`user_id`);

--
-- Indexes for table `driver_markets`
--
ALTER TABLE `driver_markets`
  ADD PRIMARY KEY (`user_id`,`market_id`),
  ADD KEY `driver_markets_market_id_foreign` (`market_id`);

--
-- Indexes for table `earnings`
--
ALTER TABLE `earnings`
  ADD PRIMARY KEY (`id`),
  ADD KEY `earnings_market_id_foreign` (`market_id`);

--
-- Indexes for table `faqs`
--
ALTER TABLE `faqs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `faqs_faq_category_id_foreign` (`faq_category_id`);

--
-- Indexes for table `faq_categories`
--
ALTER TABLE `faq_categories`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `favorites`
--
ALTER TABLE `favorites`
  ADD PRIMARY KEY (`id`),
  ADD KEY `favorites_product_id_foreign` (`product_id`),
  ADD KEY `favorites_user_id_foreign` (`user_id`);

--
-- Indexes for table `favorite_options`
--
ALTER TABLE `favorite_options`
  ADD PRIMARY KEY (`option_id`,`favorite_id`),
  ADD KEY `favorite_options_favorite_id_foreign` (`favorite_id`);

--
-- Indexes for table `fields`
--
ALTER TABLE `fields`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `galleries`
--
ALTER TABLE `galleries`
  ADD PRIMARY KEY (`id`),
  ADD KEY `galleries_market_id_foreign` (`market_id`);

--
-- Indexes for table `markets`
--
ALTER TABLE `markets`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `markets_payouts`
--
ALTER TABLE `markets_payouts`
  ADD PRIMARY KEY (`id`),
  ADD KEY `markets_payouts_market_id_foreign` (`market_id`);

--
-- Indexes for table `market_fields`
--
ALTER TABLE `market_fields`
  ADD PRIMARY KEY (`field_id`,`market_id`),
  ADD KEY `market_fields_market_id_foreign` (`market_id`);

--
-- Indexes for table `market_reviews`
--
ALTER TABLE `market_reviews`
  ADD PRIMARY KEY (`id`),
  ADD KEY `market_reviews_user_id_foreign` (`user_id`),
  ADD KEY `market_reviews_market_id_foreign` (`market_id`);

--
-- Indexes for table `media`
--
ALTER TABLE `media`
  ADD PRIMARY KEY (`id`),
  ADD KEY `media_model_type_model_id_index` (`model_type`,`model_id`);

--
-- Indexes for table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `model_has_permissions`
--
ALTER TABLE `model_has_permissions`
  ADD PRIMARY KEY (`permission_id`,`model_id`,`model_type`),
  ADD KEY `model_has_permissions_model_type_model_id_index` (`model_type`,`model_id`);

--
-- Indexes for table `model_has_roles`
--
ALTER TABLE `model_has_roles`
  ADD PRIMARY KEY (`role_id`,`model_id`,`model_type`),
  ADD KEY `model_has_roles_model_type_model_id_index` (`model_type`,`model_id`);

--
-- Indexes for table `notifications`
--
ALTER TABLE `notifications`
  ADD PRIMARY KEY (`id`),
  ADD KEY `notifications_notifiable_type_notifiable_id_index` (`notifiable_type`,`notifiable_id`);

--
-- Indexes for table `options`
--
ALTER TABLE `options`
  ADD PRIMARY KEY (`id`),
  ADD KEY `options_product_id_foreign` (`product_id`),
  ADD KEY `options_option_group_id_foreign` (`option_group_id`);

--
-- Indexes for table `option_groups`
--
ALTER TABLE `option_groups`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`id`),
  ADD KEY `orders_user_id_foreign` (`user_id`),
  ADD KEY `orders_order_status_id_foreign` (`order_status_id`),
  ADD KEY `orders_driver_id_foreign` (`driver_id`),
  ADD KEY `orders_delivery_address_id_foreign` (`delivery_address_id`),
  ADD KEY `orders_payment_id_foreign` (`payment_id`);

--
-- Indexes for table `order_statuses`
--
ALTER TABLE `order_statuses`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `password_resets`
--
ALTER TABLE `password_resets`
  ADD KEY `password_resets_email_index` (`email`);

--
-- Indexes for table `payments`
--
ALTER TABLE `payments`
  ADD PRIMARY KEY (`id`),
  ADD KEY `payments_user_id_foreign` (`user_id`);

--
-- Indexes for table `permissions`
--
ALTER TABLE `permissions`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`id`),
  ADD KEY `products_market_id_foreign` (`market_id`),
  ADD KEY `products_category_id_foreign` (`category_id`);

--
-- Indexes for table `product_orders`
--
ALTER TABLE `product_orders`
  ADD PRIMARY KEY (`id`),
  ADD KEY `product_orders_product_id_foreign` (`product_id`),
  ADD KEY `product_orders_order_id_foreign` (`order_id`);

--
-- Indexes for table `product_order_options`
--
ALTER TABLE `product_order_options`
  ADD PRIMARY KEY (`product_order_id`,`option_id`),
  ADD KEY `product_order_options_option_id_foreign` (`option_id`);

--
-- Indexes for table `product_reviews`
--
ALTER TABLE `product_reviews`
  ADD PRIMARY KEY (`id`),
  ADD KEY `product_reviews_user_id_foreign` (`user_id`),
  ADD KEY `product_reviews_product_id_foreign` (`product_id`);

--
-- Indexes for table `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `role_has_permissions`
--
ALTER TABLE `role_has_permissions`
  ADD PRIMARY KEY (`permission_id`,`role_id`),
  ADD KEY `role_has_permissions_role_id_foreign` (`role_id`);

--
-- Indexes for table `slides`
--
ALTER TABLE `slides`
  ADD PRIMARY KEY (`id`),
  ADD KEY `slides_product_id_foreign` (`product_id`),
  ADD KEY `slides_market_id_foreign` (`market_id`);

--
-- Indexes for table `uploads`
--
ALTER TABLE `uploads`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_email_unique` (`email`),
  ADD UNIQUE KEY `users_api_token_unique` (`api_token`);

--
-- Indexes for table `user_markets`
--
ALTER TABLE `user_markets`
  ADD PRIMARY KEY (`user_id`,`market_id`),
  ADD KEY `user_markets_market_id_foreign` (`market_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `app_settings`
--
ALTER TABLE `app_settings`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=170;

--
-- AUTO_INCREMENT for table `carts`
--
ALTER TABLE `carts`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `categories`
--
ALTER TABLE `categories`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `coupons`
--
ALTER TABLE `coupons`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `currencies`
--
ALTER TABLE `currencies`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `custom_fields`
--
ALTER TABLE `custom_fields`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `custom_field_values`
--
ALTER TABLE `custom_field_values`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=52;

--
-- AUTO_INCREMENT for table `delivery_addresses`
--
ALTER TABLE `delivery_addresses`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `discountables`
--
ALTER TABLE `discountables`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `drivers`
--
ALTER TABLE `drivers`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `drivers_payouts`
--
ALTER TABLE `drivers_payouts`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `earnings`
--
ALTER TABLE `earnings`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `faqs`
--
ALTER TABLE `faqs`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=31;

--
-- AUTO_INCREMENT for table `faq_categories`
--
ALTER TABLE `faq_categories`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `favorites`
--
ALTER TABLE `favorites`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=31;

--
-- AUTO_INCREMENT for table `fields`
--
ALTER TABLE `fields`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `galleries`
--
ALTER TABLE `galleries`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT for table `markets`
--
ALTER TABLE `markets`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `markets_payouts`
--
ALTER TABLE `markets_payouts`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `market_reviews`
--
ALTER TABLE `market_reviews`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT for table `media`
--
ALTER TABLE `media`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=42;

--
-- AUTO_INCREMENT for table `options`
--
ALTER TABLE `options`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=71;

--
-- AUTO_INCREMENT for table `option_groups`
--
ALTER TABLE `option_groups`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `orders`
--
ALTER TABLE `orders`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `order_statuses`
--
ALTER TABLE `order_statuses`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `payments`
--
ALTER TABLE `payments`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `permissions`
--
ALTER TABLE `permissions`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=195;

--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=41;

--
-- AUTO_INCREMENT for table `product_orders`
--
ALTER TABLE `product_orders`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `product_reviews`
--
ALTER TABLE `product_reviews`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=32;

--
-- AUTO_INCREMENT for table `roles`
--
ALTER TABLE `roles`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `slides`
--
ALTER TABLE `slides`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `uploads`
--
ALTER TABLE `uploads`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `carts`
--
ALTER TABLE `carts`
  ADD CONSTRAINT `carts_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `carts_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `cart_options`
--
ALTER TABLE `cart_options`
  ADD CONSTRAINT `cart_options_cart_id_foreign` FOREIGN KEY (`cart_id`) REFERENCES `carts` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `cart_options_option_id_foreign` FOREIGN KEY (`option_id`) REFERENCES `options` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `custom_field_values`
--
ALTER TABLE `custom_field_values`
  ADD CONSTRAINT `custom_field_values_custom_field_id_foreign` FOREIGN KEY (`custom_field_id`) REFERENCES `custom_fields` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `delivery_addresses`
--
ALTER TABLE `delivery_addresses`
  ADD CONSTRAINT `delivery_addresses_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `discountables`
--
ALTER TABLE `discountables`
  ADD CONSTRAINT `discountables_coupon_id_foreign` FOREIGN KEY (`coupon_id`) REFERENCES `coupons` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `drivers`
--
ALTER TABLE `drivers`
  ADD CONSTRAINT `drivers_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `drivers_payouts`
--
ALTER TABLE `drivers_payouts`
  ADD CONSTRAINT `drivers_payouts_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `driver_markets`
--
ALTER TABLE `driver_markets`
  ADD CONSTRAINT `driver_markets_market_id_foreign` FOREIGN KEY (`market_id`) REFERENCES `markets` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `driver_markets_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `earnings`
--
ALTER TABLE `earnings`
  ADD CONSTRAINT `earnings_market_id_foreign` FOREIGN KEY (`market_id`) REFERENCES `markets` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `faqs`
--
ALTER TABLE `faqs`
  ADD CONSTRAINT `faqs_faq_category_id_foreign` FOREIGN KEY (`faq_category_id`) REFERENCES `faq_categories` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `favorites`
--
ALTER TABLE `favorites`
  ADD CONSTRAINT `favorites_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `favorites_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `favorite_options`
--
ALTER TABLE `favorite_options`
  ADD CONSTRAINT `favorite_options_favorite_id_foreign` FOREIGN KEY (`favorite_id`) REFERENCES `favorites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `favorite_options_option_id_foreign` FOREIGN KEY (`option_id`) REFERENCES `options` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `galleries`
--
ALTER TABLE `galleries`
  ADD CONSTRAINT `galleries_market_id_foreign` FOREIGN KEY (`market_id`) REFERENCES `markets` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `markets_payouts`
--
ALTER TABLE `markets_payouts`
  ADD CONSTRAINT `markets_payouts_market_id_foreign` FOREIGN KEY (`market_id`) REFERENCES `markets` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `market_fields`
--
ALTER TABLE `market_fields`
  ADD CONSTRAINT `market_fields_field_id_foreign` FOREIGN KEY (`field_id`) REFERENCES `fields` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `market_fields_market_id_foreign` FOREIGN KEY (`market_id`) REFERENCES `markets` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `market_reviews`
--
ALTER TABLE `market_reviews`
  ADD CONSTRAINT `market_reviews_market_id_foreign` FOREIGN KEY (`market_id`) REFERENCES `markets` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `market_reviews_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `model_has_permissions`
--
ALTER TABLE `model_has_permissions`
  ADD CONSTRAINT `model_has_permissions_permission_id_foreign` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `model_has_roles`
--
ALTER TABLE `model_has_roles`
  ADD CONSTRAINT `model_has_roles_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `options`
--
ALTER TABLE `options`
  ADD CONSTRAINT `options_option_group_id_foreign` FOREIGN KEY (`option_group_id`) REFERENCES `option_groups` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `options_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `orders`
--
ALTER TABLE `orders`
  ADD CONSTRAINT `orders_delivery_address_id_foreign` FOREIGN KEY (`delivery_address_id`) REFERENCES `delivery_addresses` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
  ADD CONSTRAINT `orders_driver_id_foreign` FOREIGN KEY (`driver_id`) REFERENCES `users` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
  ADD CONSTRAINT `orders_order_status_id_foreign` FOREIGN KEY (`order_status_id`) REFERENCES `order_statuses` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `orders_payment_id_foreign` FOREIGN KEY (`payment_id`) REFERENCES `payments` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
  ADD CONSTRAINT `orders_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `payments`
--
ALTER TABLE `payments`
  ADD CONSTRAINT `payments_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `products`
--
ALTER TABLE `products`
  ADD CONSTRAINT `products_category_id_foreign` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `products_market_id_foreign` FOREIGN KEY (`market_id`) REFERENCES `markets` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `product_orders`
--
ALTER TABLE `product_orders`
  ADD CONSTRAINT `product_orders_order_id_foreign` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `product_orders_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `product_order_options`
--
ALTER TABLE `product_order_options`
  ADD CONSTRAINT `product_order_options_option_id_foreign` FOREIGN KEY (`option_id`) REFERENCES `options` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `product_order_options_product_order_id_foreign` FOREIGN KEY (`product_order_id`) REFERENCES `product_orders` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `product_reviews`
--
ALTER TABLE `product_reviews`
  ADD CONSTRAINT `product_reviews_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `product_reviews_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `role_has_permissions`
--
ALTER TABLE `role_has_permissions`
  ADD CONSTRAINT `role_has_permissions_permission_id_foreign` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `role_has_permissions_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `slides`
--
ALTER TABLE `slides`
  ADD CONSTRAINT `slides_market_id_foreign` FOREIGN KEY (`market_id`) REFERENCES `markets` (`id`) ON DELETE SET NULL ON UPDATE SET NULL,
  ADD CONSTRAINT `slides_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE SET NULL ON UPDATE SET NULL;

--
-- Constraints for table `user_markets`
--
ALTER TABLE `user_markets`
  ADD CONSTRAINT `user_markets_market_id_foreign` FOREIGN KEY (`market_id`) REFERENCES `markets` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `user_markets_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
