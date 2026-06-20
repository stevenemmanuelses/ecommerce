-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jun 20, 2026 at 11:41 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `variety_db`
--

-- --------------------------------------------------------

--
-- Table structure for table `auth_group`
--

CREATE TABLE `auth_group` (
  `id` int(11) NOT NULL,
  `name` varchar(150) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `auth_group_permissions`
--

CREATE TABLE `auth_group_permissions` (
  `id` bigint(20) NOT NULL,
  `group_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `auth_permission`
--

CREATE TABLE `auth_permission` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `codename` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `auth_permission`
--

INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES
(1, 'Can add log entry', 1, 'add_logentry'),
(2, 'Can change log entry', 1, 'change_logentry'),
(3, 'Can delete log entry', 1, 'delete_logentry'),
(4, 'Can view log entry', 1, 'view_logentry'),
(5, 'Can add permission', 2, 'add_permission'),
(6, 'Can change permission', 2, 'change_permission'),
(7, 'Can delete permission', 2, 'delete_permission'),
(8, 'Can view permission', 2, 'view_permission'),
(9, 'Can add group', 3, 'add_group'),
(10, 'Can change group', 3, 'change_group'),
(11, 'Can delete group', 3, 'delete_group'),
(12, 'Can view group', 3, 'view_group'),
(13, 'Can add user', 4, 'add_user'),
(14, 'Can change user', 4, 'change_user'),
(15, 'Can delete user', 4, 'delete_user'),
(16, 'Can view user', 4, 'view_user'),
(17, 'Can add content type', 5, 'add_contenttype'),
(18, 'Can change content type', 5, 'change_contenttype'),
(19, 'Can delete content type', 5, 'delete_contenttype'),
(20, 'Can view content type', 5, 'view_contenttype'),
(21, 'Can add session', 6, 'add_session'),
(22, 'Can change session', 6, 'change_session'),
(23, 'Can delete session', 6, 'delete_session'),
(24, 'Can view session', 6, 'view_session'),
(25, 'Can add category', 7, 'add_category'),
(26, 'Can change category', 7, 'change_category'),
(27, 'Can delete category', 7, 'delete_category'),
(28, 'Can view category', 7, 'view_category'),
(29, 'Can add product', 8, 'add_product'),
(30, 'Can change product', 8, 'change_product'),
(31, 'Can delete product', 8, 'delete_product'),
(32, 'Can view product', 8, 'view_product'),
(33, 'Can add order', 9, 'add_order'),
(34, 'Can change order', 9, 'change_order'),
(35, 'Can delete order', 9, 'delete_order'),
(36, 'Can view order', 9, 'view_order'),
(37, 'Can add cart item', 10, 'add_cartitem'),
(38, 'Can change cart item', 10, 'change_cartitem'),
(39, 'Can delete cart item', 10, 'delete_cartitem'),
(40, 'Can view cart item', 10, 'view_cartitem'),
(41, 'Can add return request', 11, 'add_returnrequest'),
(42, 'Can change return request', 11, 'change_returnrequest'),
(43, 'Can delete return request', 11, 'delete_returnrequest'),
(44, 'Can view return request', 11, 'view_returnrequest'),
(45, 'Can add user profile', 12, 'add_userprofile'),
(46, 'Can change user profile', 12, 'change_userprofile'),
(47, 'Can delete user profile', 12, 'delete_userprofile'),
(48, 'Can view user profile', 12, 'view_userprofile'),
(49, 'Can add order item', 13, 'add_orderitem'),
(50, 'Can change order item', 13, 'change_orderitem'),
(51, 'Can delete order item', 13, 'delete_orderitem'),
(52, 'Can view order item', 13, 'view_orderitem'),
(53, 'Can add review', 14, 'add_review'),
(54, 'Can change review', 14, 'change_review'),
(55, 'Can delete review', 14, 'delete_review'),
(56, 'Can view review', 14, 'view_review'),
(57, 'Can add product review', 15, 'add_productreview'),
(58, 'Can change product review', 15, 'change_productreview'),
(59, 'Can delete product review', 15, 'delete_productreview'),
(60, 'Can view product review', 15, 'view_productreview');

-- --------------------------------------------------------

--
-- Table structure for table `auth_user`
--

CREATE TABLE `auth_user` (
  `id` int(11) NOT NULL,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) NOT NULL,
  `first_name` varchar(150) NOT NULL,
  `last_name` varchar(150) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `auth_user`
--

INSERT INTO `auth_user` (`id`, `password`, `last_login`, `is_superuser`, `username`, `first_name`, `last_name`, `email`, `is_staff`, `is_active`, `date_joined`) VALUES
(1, 'pbkdf2_sha256$600000$DfdOsHObFLPkRMxOOaNNHp$Uy8glTlGc1syVIGNiDmCiUj+v/PQve5s6bzp0y84uuw=', '2026-06-20 09:11:32.771026', 1, 'admin', '', '', 'admin@example.com', 1, 1, '2026-06-07 10:15:39.636689'),
(2, 'pbkdf2_sha256$600000$DRl1l8DCbXPj0JaS0OHYr7$cuqF2sj3706MVcSM4QbWIhEvTZl7JyHR9JtJoDMftDM=', '2026-06-10 03:08:14.843673', 0, 'user', '', '', '', 0, 1, '2026-06-07 10:48:25.095070'),
(3, 'pbkdf2_sha256$600000$dJsFFAsk8EtT2Zg4YXyHi1$50+MaOiSIcxga5ykIB+XLaAzbvo1qP1Zhp8m0tww2B8=', '2026-06-10 03:33:10.496079', 0, 'pelis.', '', '', '', 0, 1, '2026-06-10 03:06:56.704666'),
(4, 'pbkdf2_sha256$600000$vTUnwzpkzCWQpgaDDqtivH$xY3RedoVLRC/SHYyMa3ZJg4vscx2xaRdvdw3ZEwvpRg=', NULL, 0, 'budi', '', '', 'budi@gmail.com', 0, 1, '2026-06-10 10:08:17.601097'),
(5, 'pbkdf2_sha256$600000$qhO2ZbPyJ9L1s96vR8HEzp$af0O2/WI3AbZxLs6PmUopL+5W7+s5jMo4K7NYE1YA6E=', '2026-06-20 09:15:40.477830', 0, 'aldi', '', '', 'aldi@gmail.com', 0, 1, '2026-06-10 10:10:49.965757');

-- --------------------------------------------------------

--
-- Table structure for table `auth_user_groups`
--

CREATE TABLE `auth_user_groups` (
  `id` bigint(20) NOT NULL,
  `user_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `auth_user_user_permissions`
--

CREATE TABLE `auth_user_user_permissions` (
  `id` bigint(20) NOT NULL,
  `user_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `django_admin_log`
--

CREATE TABLE `django_admin_log` (
  `id` int(11) NOT NULL,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext DEFAULT NULL,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint(5) UNSIGNED NOT NULL CHECK (`action_flag` >= 0),
  `change_message` longtext NOT NULL,
  `content_type_id` int(11) DEFAULT NULL,
  `user_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `django_content_type`
--

CREATE TABLE `django_content_type` (
  `id` int(11) NOT NULL,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `django_content_type`
--

INSERT INTO `django_content_type` (`id`, `app_label`, `model`) VALUES
(1, 'admin', 'logentry'),
(3, 'auth', 'group'),
(2, 'auth', 'permission'),
(4, 'auth', 'user'),
(5, 'contenttypes', 'contenttype'),
(6, 'sessions', 'session'),
(10, 'store', 'cartitem'),
(7, 'store', 'category'),
(9, 'store', 'order'),
(13, 'store', 'orderitem'),
(8, 'store', 'product'),
(15, 'store', 'productreview'),
(11, 'store', 'returnrequest'),
(14, 'store', 'review'),
(12, 'store', 'userprofile');

-- --------------------------------------------------------

--
-- Table structure for table `django_migrations`
--

CREATE TABLE `django_migrations` (
  `id` bigint(20) NOT NULL,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `django_migrations`
--

INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES
(1, 'contenttypes', '0001_initial', '2026-06-07 10:15:35.468872'),
(2, 'auth', '0001_initial', '2026-06-07 10:15:37.460044'),
(3, 'admin', '0001_initial', '2026-06-07 10:15:37.895554'),
(4, 'admin', '0002_logentry_remove_auto_add', '2026-06-07 10:15:37.919617'),
(5, 'admin', '0003_logentry_add_action_flag_choices', '2026-06-07 10:15:37.950842'),
(6, 'contenttypes', '0002_remove_content_type_name', '2026-06-07 10:15:38.121461'),
(7, 'auth', '0002_alter_permission_name_max_length', '2026-06-07 10:15:38.279941'),
(8, 'auth', '0003_alter_user_email_max_length', '2026-06-07 10:15:38.329171'),
(9, 'auth', '0004_alter_user_username_opts', '2026-06-07 10:15:38.346924'),
(10, 'auth', '0005_alter_user_last_login_null', '2026-06-07 10:15:38.579881'),
(11, 'auth', '0006_require_contenttypes_0002', '2026-06-07 10:15:38.591239'),
(12, 'auth', '0007_alter_validators_add_error_messages', '2026-06-07 10:15:38.612221'),
(13, 'auth', '0008_alter_user_username_max_length', '2026-06-07 10:15:38.669525'),
(14, 'auth', '0009_alter_user_last_name_max_length', '2026-06-07 10:15:38.717983'),
(15, 'auth', '0010_alter_group_name_max_length', '2026-06-07 10:15:38.765196'),
(16, 'auth', '0011_update_proxy_permissions', '2026-06-07 10:15:38.791332'),
(17, 'auth', '0012_alter_user_first_name_max_length', '2026-06-07 10:15:38.837914'),
(18, 'sessions', '0001_initial', '2026-06-07 10:15:38.922898'),
(19, 'store', '0001_initial', '2026-06-07 10:33:13.976250'),
(20, 'store', '0002_product_image_url', '2026-06-07 10:43:34.908145'),
(21, 'store', '0003_cartitem_user_cartitem_unique_user_product_and_more', '2026-06-07 11:02:14.414605'),
(22, 'store', '0004_remove_cartitem_unique_user_product_and_more', '2026-06-07 11:04:43.464680'),
(23, 'store', '0005_return_request', '2026-06-09 16:27:15.801314'),
(24, 'store', '0006_remove_product_image', '2026-06-10 02:54:03.898887'),
(25, 'store', '0007_alter_product_image_url_userprofile', '2026-06-10 10:10:11.028072'),
(26, 'store', '0008_order_shipping_cost', '2026-06-10 10:15:12.868166'),
(27, 'store', '0009_order_status', '2026-06-10 10:20:18.016561'),
(28, 'store', '0010_order_points_used_returnrequest_points_amount_and_more', '2026-06-16 16:58:58.665228'),
(29, 'store', '0011_order_received_at_review', '2026-06-16 16:58:59.048402'),
(30, 'store', '0010_order_points_used_order_total_price_and_more', '2026-06-16 17:25:31.775252'),
(31, 'store', '0011_orderitem_productreview', '2026-06-16 17:52:56.514847'),
(32, 'store', '0012_order_courier_order_payment_method_and_more', '2026-06-20 08:35:09.413154'),
(33, 'store', '0013_order_payment_proof_alter_order_status', '2026-06-20 08:47:26.910877');

-- --------------------------------------------------------

--
-- Table structure for table `django_session`
--

CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `django_session`
--

INSERT INTO `django_session` (`session_key`, `session_data`, `expire_date`) VALUES
('15qqrdojz9l1m5dqnofs9mo2x4bf06ex', '.eJxlj81qwzAQhN9FZ8dIlvXnY6GHHnoppdCTkKwlVmxLjiVDQ8i7V6YppPS438zO7F6RNlse9JZg1d6hDjFUPTJr-hHCLriTCcdY9zHk1dt6t9R3NdWv0cH0dPf-CRhMGsq2wZQyRhSzQJ0kwgllCLGUSmis5FII7qBRBCvRCtP0klDiWGNaSjlxhO-hCVLyMWj4Wvx6QR3HFVqiDznpHPc21BUye5dXE5LuB-jHuGWdsslFu6K4ut83P57fXt4_D-ygWqoUZ8AolqXE-mny4VgCs5lQR7BguOHVffWR4tKVBr8su72PKRf-Q__ftAV_3qC4XJn3uMVcZghZz5CH6PQI5R10Xn1Ct9s3s5OEAQ:1wapr9:5uci2LrGLUAFpfwuqa3r8swf9vOMQPGiyXSqv5f-GM8', '2026-06-20 07:12:07.320163'),
('2qcqx1hwjpapjbhf14t89ub1ofan4m8x', '.eJxVj8FqwzAQRP9lz46xrMiWfWtpCoH2UkqhJyFZS6TalhxLhoaQf69MXUiPO_tmducKQi7RiCXgLKyGFhhk95qSXY9uXegv6U4-77yLs1X5iuTbNuSvXuPwuLH_AowMJrllQSljpGEKqeak1nUjCVGUciwVr3hdVxrLhhRNva9l2XFCiWal3FNaEU2qNTRgCNY7gd-TnS_QVkUGo9Vxli6IzmDX-yWKEGVEaK_gZ_1X6uPwdnz_3LHd88Px5fCUwpQdButOIvooB2gZZUXJs81zJxbpRjB2mla48yFCS37VyVsXQ2LXntAmZXH2vGCidJrXtEleRnRRjBiN16LH9DScZxvgdvsB_sl8Mw:1waql3:DcicK_7-tjIwMnShfJM-PfLsjpli1uXcBnfn315Uy9g', '2026-06-20 08:09:53.531140'),
('2tqcgqh1zb0bbu4m5ovbf2pcrnicjcpd', '.eJxVjMEOwiAQBf-FsyFQCGV79O43kAUWixowpU1qjP9uSHrQ65t582YOt3V2W6PF5cgmJtnpd_MY7lQ6iDcs18pDLeuSPe8KP2jjlxrpcT7cv8CMbe5vDZEGpYU3AeSY0qDIGiIEC0mEBIDCJB1glCJ6C94MGoxELxVGpW2PNmot1-Jof-blxSYjPl_WAz9e:1waqtj:QwnFSkKTmrQKPUwGJUGUfQrMd27SuO0Oxb0kTfz_CgY', '2026-06-20 08:18:51.378667'),
('6yzbznm8525tmd0y25jtskcpkv9z34vb', '.eJxVj8FugzAQRP9lzwRhHAPmWKmHHnqpqko9WWt7FVyITbCRGkX595qKSulxZ9_M7txA4ZoGtUZalLPQg4DiUdNoRvLbwn6hP4XSBJ8Wp8sNKfdtLF-DpelpZ_8FDBiH7MaKcyGYFJq47VhrW4mMac47qnXXdG3bWKolq2R7bLE2HePMihqPnDfMsmYLjRSjC17R9-yWK_RNVcDZ2bSgj8oMZMawJhUTJoL-BmGxf6U-nt9e3j8P4iBRMC46QyR1jtRumpw_qRQSTtDXsqrqY7E7H8QqX4qDm-cNNiEm6Jn4VefgfIqZ3dpCn5XVu8tKmbJ53tJmvJ7JJ3WmNASrRsqvw2VxEe73H8jAfeo:1wapPS:ZsIwM4lipfs34d2FVKnN9h0ekxyd4JmZmg1b-duTcWA', '2026-06-20 06:43:30.026204'),
('8edbw9uuvsk35ssc90e1w6ykptod2yg9', '.eJxVjMsKwjAQRf8lawmdTPPq0r3fECbNYKOSSNOCIv67FrrQ7T3nnpcItC5TWBvPIScxCC0Ov1uk8cplA-lC5VzlWMsy5yg3Re60yVNNfDvu7l9gojZ939Qhag1eR8bkwCbrCSAiOlbRGWetSaw8dN72ltToACFpRT2igQRmizZuLdcS-HHP81MMpnt_AHyFPcc:1wap7t:9sV1VzfqXrz6QXyVtNpqrLEmAhyTs2kEVDxS12BWWi4', '2026-06-20 06:25:21.367399'),
('8q02r7fl7j0rgl1yzaeykifhrac6s3hu', '.eJxVj8FqhDAQht8lZ1eMMYl6LPTQQy-lFHoKk2RYUzVxTYQuy757I7WwPc433_wzcyMKtjSoLeKqnCU94aR4ZBrMiH5v2C_w51Ca4NPqdLkr5dGN5WuwOD0d7r-AAeKQp6FijHPacY3MtlRa2QGlmrEWa92KVkphse5o1clGQm1ayqjlNTSMCWqp2EMjxuiCV_i9uPVKelEVZHY2reCjMgOaMWxJxQQJSX8jYbV_T308v728f574SUrTUdqAaEWdI7WbJufPKoUEE-lpJXlVi-IYfaRV3hUHtyy7bkJMmf_SJTifYpb3f0mfyebdZcNs2VzvcQtcZ_RJzZiGYNWI-XhyWV0k9_sPW8Z9wQ:1waqFI:dUpBpVVLG-ADCObNRkZh7VDxZNY1E41Ew217W7CL4o4', '2026-06-20 07:37:04.502798'),
('8qh0nbzm7h6yp2zajbsekvnmxfg3r167', '.eJxVj8FqwzAQRP9lz46xrMiWfWtpCoH2UkqhJyFZS6TalhxLhoaQf69MXUiPO_tmducKQi7RiCXgLKyGFhhk95qSXY9uXegv6U4-77yLs1X5iuTbNuSvXuPwuLH_AowMJrllQSljpGEKqeak1nUjCVGUciwVr3hdVxrLhhRNva9l2XFCiWal3FNaEU2qNTRgCNY7gd-TnS_QVkUGo9Vxli6IzmDX-yWKEGVEaK_gZ_1X6uPwdnz_3LHd88Px5fCUwpQdButOIvooB2gZZUXJs81zJxbpRjB2mla48yFCS37VyVsXQ2LXntAmZXH2vGCidJrXtEleRnRRjBiN16LH9DScZxvgdvsB_sl8Mw:1waqof:0WnzpudyOhqNryWS7ib1ctPjThZjz30xCY2LKT6vYwU', '2026-06-20 08:13:37.321053'),
('b3v5774mmjf43mxnasrlk3dipoynn0sl', '.eJxVj0tuwzAMBe-idWBYVvSxl933DAIlErXSRHJFGWhQ5O6xgCzSLWf4yPcnPOxt9TtT9QnFIrQ4vc8CxG_KHeAF8lcZYsmtpjB0ZXhRHj4L0vXj5f4LWIHXYxtGpbSWsw6k0EmLdgYpg1KOpuCMs9YgTbMcZ3u2MEUnlUQ9wVkpI1GaHsrEnEr29LuleheLGU-C6UqxEfpY9pqoHqcumcQb2OB-o9z8jdpaepGfmvgQtpJyY99K_1Ms4-MJ7ANZKw:1warlh:MMPwEeqy3_yupEgVA6YvP9PQyXB0_8Tp_BOwMOo1aFg', '2026-06-20 09:14:37.860820'),
('cailia18wfak2dqm33i8d7tsi5tg6oud', '.eJxVj8FugzAQRP9lzwRhHIPhWKmHHnqpqko9WbZ3FVzAJthIjaL8e42aSulxZ97Ozl5B6S0Naou0KofQg4DiUTPajuR3A7-0P4XSBp9WZ8odKe9uLF8D0vR0Z_8FDDoOeVtXnAvBOmGIo2Qttp1mzHAuqTaykW3bINUdq7r22OraSsYZilofOW8YsmYPjRSjC17R9-LWC_RNVcDsMK3aR2UHsmPYkopJJ4L-CmHFv6c-nt9e3j8P4lBxNCRt7i0oRxo3Tc6fVApJT9ALLqpaFvfNB7HKl-LglmWHbYgJevarLsH5FDO7fwt9VjbvzhtlCvO8py36MpNPaqY0BFQj5epwXl2E2-0HEsl-dw:1waqQf:ZgUFpfNDv0mAHU0U_j58-JspEyi6lVHEThG4UFHS87Y', '2026-06-20 07:48:49.811683'),
('cjl1jy68yc08ihi182pmycy0655goxrn', '.eJxVj8tqwzAQRf9Fa8foEUm2l4UuuuimlEJXQo8hUmxLjiUvQsi_V6YppMs5c-5l5oaU3opXW4ZVBYcGxFHzzIy2I8R94c46nlJrUyxrMO2utI9tbt-Tg-nl4f4r8Dr7mtaYMc5Jzw0w1xHpZK8JMYx1QE0nOimFA9oT3Muj1NR2hBHHqT4yJogjopbOwZVVx6ysBzumrahcdAE03FBa3d_9X68fb5_fB34gVOBOGmsN9DVtwjSFeFIlFT2hgWDJMRXNI_pMMW5Q9mFZdt2mXCr_pUsKseQq76-hoZIthssG1XJ13usWfZ0hFjVD8cmpEa71pssaMrrffwA4JHbX:1waqGp:BoMNb0nHGfQjd8OkXAQ50ePXtdd8R8EeEMmDX-jx-nw', '2026-06-20 07:38:39.694194'),
('cxtjoy4k7km0ssehunf0ik3xpv41zkzs', '.eJxVjMEOwiAQBf-FsyFQCGV79O43kAUWixowpU1qjP9uSHrQ65t582YOt3V2W6PF5cgmJtnpd_MY7lQ6iDcs18pDLeuSPe8KP2jjlxrpcT7cv8CMbe5vDZEGpYU3AeSY0qDIGiIEC0mEBIDCJB1glCJ6C94MGoxELxVGpW2PNmot1-Jof-blxSYjPl_WAz9e:1warkP:2uIGB9L-1uPFZ52Fmsz7YBhpetrqLEKdNR5E25swSlU', '2026-06-20 09:13:17.257238'),
('dpqgy3ufus2j1y3c9typv4n7f9tw2mhb', '.eJxVjMEOwiAQBf-FsyFQCGV79O43kAUWixowpU1qjP9uSHrQ65t582YOt3V2W6PF5cgmJtnpd_MY7lQ6iDcs18pDLeuSPe8KP2jjlxrpcT7cv8CMbe5vDZEGpYU3AeSY0qDIGiIEC0mEBIDCJB1glCJ6C94MGoxELxVGpW2PNmot1-Jof-blxSYjPl_WAz9e:1warca:zkzfoRSbjx-YmtfzrrXAk15C8XvcHRsLAUd6g79do54', '2026-06-20 09:05:12.293066'),
('h8gvwtp3mfdbfiqqc73qxz2vs95cdvft', '.eJxVj8FqwzAQRP9lz4mxrEiyfSz00EMvpRR6EitpiVU7kmPJ0BDy75VpCulxZ9_M7lxB45oHvSZatHfQg4Ddo2bQjhS2hfvCcIyVjSEv3lQbUt23qXqNjqanO_svYMA0FDfWnAvBOmGIu5YppzpkzHDeUmNa2SolHTUdqzt1UNjYlnHmRIMHziVzTG6hiVLyMWj6nv1ygV7WOzh5lxcMSduB7BjXrFPGTNBfIS7ur9TH89vL--de7A9WojDYcCV5iTR-mnw46hwzTtALLuqm3d2dD2JdLqXBz_MG25gy9OxXnaMPORV2awt9UdbgzysVypV5S5vxcqKQ9YnyEJ0eqbwO58UnuN1-AK5rfbk:1waqSg:K1BP6SB4bIeKYP-V2kIK0x4fq-mZ9IhTAZU_r_DwNPQ', '2026-06-20 07:50:54.726363'),
('hg7x9utkelbylrqnnxv6lrnjdfrtw61x', '.eJxVj8FqwzAMht9F5zbYcRwnOQ522GGXMQY7GTsSjdfUTmMHVkrfffbooDvq16dP0hW02dKkt0irdggDSNg9ZtaMR_KlgV_GH0I1Bp9WZ6uCVPdurF4D0vx0Z_8JJhOnPG2YEFLyXloS2HGFqjecWyE6qm3Xdkq1SHXPWa8aZeqx44KjrE0jRMuRt0UaKUYXvKbvxa0XGFq2g5PDtBof9TjReAxb0jGZRDBcIaz499TH89vL--de7hvLMPulamVRWjfPzh90CsnMMNQ9Y3Wzu08-hCxvipNblgKPISYYuPxNl-B8ipkt38KQk82780aZwlwX22IuJ_JJnyhNAfWR8ulwXl2E2-0HlMF9hQ:1wapXb:d7UqJxbBZFc11EUWSQIqV8VdGnWnMeDxxpmqlUkcQJo', '2026-06-20 06:51:55.500070'),
('hyjpcg4w8cees2otqnd94dflee3l90xi', '.eJxVj01vwyAMhv8L5zSCUCDJcdIOO-wyTZN2Qny4hSWBNBBpVdX_PqJlUnf048ev7RuSas1OrgkW6S3qEUPVI9PKDBC2hv1S4RxrE0NevK43pd67qX6NFsan3f0X4FRyZVphShkjHdNAbUuEFZ0iRFPaQqNb3grBLTQdwZ04CtWYllBiWaOOlHJiCd9CE6TkY5DwPfvlinqOKzR5mxcVkjQOzBDXLFNWGVB_Q3Gxf099PL-9vH8e2AGooVh0cDqdSInUfhx9OMscsxpRT7BguOHVPvpIcdmVnJ_nTTcx5cJ_6Rx9yKnI27-oL2QN_rJCsWypt7hZXScIWU6QXbRygHI8uiw-ofv9B8ODfoA:1waqCJ:JHm9MBsFV6Sw3cbUDt3cMgcbqrCI5BNlRCeW0waZrrI', '2026-06-20 07:33:59.496850'),
('hzjjhjrktxhoiw2dbiwbclemhj0gjm0z', '.eJxVjMsKwjAQRf8lawmdTPPq0r3fECbNYKOSSNOCIv67FrrQ7T3nnpcItC5TWBvPIScxCC0Ov1uk8cplA-lC5VzlWMsy5yg3Re60yVNNfDvu7l9gojZ939Qhag1eR8bkwCbrCSAiOlbRGWetSaw8dN72ltToACFpRT2igQRmizZuLdcS-HHP81MMpnt_AHyFPcc:1wargu:NMBUTFH9U9edO_t3ANz3Yh12E4_RNZrwJt7RMa-q-c0', '2026-06-20 09:09:40.785941'),
('j43zgo7l7r0vg4qd5o8054l10g3axt0l', '.eJxVjMsKwjAQRf8lawmdTPPq0r3fECbNYKOSSNOCIv67FrrQ7T3nnpcItC5TWBvPIScxCC0Ov1uk8cplA-lC5VzlWMsy5yg3Re60yVNNfDvu7l9gojZ939Qhag1eR8bkwCbrCSAiOlbRGWetSaw8dN72ltToACFpRT2igQRmizZuLdcS-HHP81MMpnt_AHyFPcc:1warng:EOjzNlkJp0Jf3d-RRZf9NYJit6cWrKSIX_-hX-xeI7k', '2026-06-20 09:16:40.557333'),
('jbastxqphg39dkievfsjuafayazs2s23', '.eJxVj81qwzAQhN9lz4nRj2XZPhZ66KGXUgo9ibW0xGocybFkaAh598olhfS4s9_M7lzB4JpHsyZajHfQg4LdozagPVLYFu4LwyFWNoa8-KHakOq-TdVrdDQ93dl_ASOmsbiRSakU79RA0rVcO90h54OULYmhbVqtG0ei46zTtUZhWy65UwJrKRvueLOFJkrJx2Doe_bLBfqG7eDkXV4wJGNHsse4ZpMyZoL-CnFxf6U-nt9e3j_3ao-i5kzbrhHISuTgp8mHg8kx4wS96BgT9e7ufBBZuZRGP88bbGPK0HP1q87Rh5wKu7WFvihr8OeVCuXKvKXNeDlRyOZEeYzOHKm8DufFJ7jdfgCLsH12:1wapV4:zzY-krUnNHPJU0qZpGZz2oxGei_SFJP7nR-bBAmxKa4', '2026-06-20 06:49:18.658424'),
('jibjx2e5ycvcsm7u4p48f9cgkfnruotq', '.eJxVj0tuwzAMBe-idWBYVvSxl933DIIkEjWbRHJFGWhQ5O6xgCzSLWf4yPcnfNjb6nfG6gnEIrQ4vc9iSBfMHcB3yF9lSCW3SnHoyvCiPHwWwOvHy_0XsAZej-0wKqW1nHVEBU5asHOQMirlcIrOOGsN4DTLcbZnG6bkpJKgp3BWykiQpocyMlPJHn83qnexmPEkGK-YGoJPZa-E9TjV6ELijWzhfsPc_A3bWnqTn0p8CFuh3Ni30h8Vy_h4AkqYWZ8:1warfN:Lxg3m7vOKnZfkBcrD3DCtA1MIUplzUiyubIZD7nfPLc', '2026-06-20 09:08:05.909799'),
('k0cqscowgftlanecy1m58lgg2rmb3dgy', '.eJxVj01rwzAMhv-Lzmmw4zhfx8IOO-wyxmAn40Ra7SWx09iBldL_Pmd00B316tEj6QpKb9GoLdCqLEIHErLHrNfDSG5v4Jd2J58P3sXV9vmO5PduyF880nS8s_8ERgeTpjUTQkreyp4ENrzGutWc90I0VPRN1dR1hVS0nLV1WetiaLjgKAtdClFx5NUuDRSC9U7R92LXC3QVy2C2GFftghoMDaPfogpRR4LuCn7Fv6fen16f3z4O8oBVm7aJT5b8SdnbabLupKKPeoKuaBkryuw--RCytCkYuyw7PPgQoePyN128dTEkdv8WupRszp43ShSmerct-jKTi2qmaDyqkdLpcF5tgNvtB5fSfYo:1wapbP:SGmEJhcMCZv6ausZgDTgPmHMh08xjDLM-KzF-Tk2wuQ', '2026-06-20 06:55:51.649150'),
('kamhwvzfjo1bcrkrblfg0hyrq3ei3jyc', '.eJxVjEEOwiAQRe_C2pBOgYG6dO8ZyMBMpWpKUtqV8e7apAvd_vfef6lI21ri1mSJE6uzcur0uyXKD5l3wHeab1XnOq_LlPSu6IM2fa0sz8vh_h0UauVbe7YkYtD2mYWssx4YwbGnlBACeBy6ERCkG7MR43IgRLTUew8DhUG9P-fnN30:1wYkjB:LKjY1q7LHAG0wlmnxStVz63Q5SS_oZq_BNlE52I1UI0', '2026-06-28 13:18:17.659368'),
('ni5gu28pronftvg6gbi8l8pwozs6vtzn', '.eJxVjDkOwjAURO_iGlneYmNKes5g_U04gBwpTirE3UmkFFDOvDfzVgXWpZa1y1xGVhdl1em3Q6CntB3wA9p90jS1ZR5R74o-aNe3ieV1Pdy_gwq9busY8xkxgmVngxGkLeWBHBlm8mwSOpcYKGF2PgwmBBASbz1BAsmsPl_2Ozim:1wZ4Gb:lYHjhOBjfjnHOZ6DLqLEjarqOlq8OV9ifGO455xlK2Q', '2026-06-29 10:10:05.780141'),
('p0rws9ihi0ys8gee17bx5p376jq2w8wa', '.eJxVj81qwzAQhN9F58ToJ5JsHwM99NBLKYWexMraxqptybVkaAh598ohhfS4M9_Ozl6IgTX3Zk24GO9ISyTZPWoWugHDZrgvCKdYdTHkxdtqQ6q7m6qX6HA83tl_AT2kvmwDFUJK1kiLwtVMO90AY1aIGrmtVa21csgbRht90MC7mgnmJIeDEIo5prbQhCn5GAz-zH45k1bRHZm8ywuEZLoeuyGu2aQMGUl7IXFxf0-9P70-v33s5R5qlBS5VsrZEmn9OPpwMjlmGEnLG0r5YXfffBBpuZR6P88b3MWUScvkTZ2jDzkVdvuWtEVZg_9esVCuzFvaDOcJQzYT5j46M2CpTiyEwdyaf-JCrtdfRuSBhg:1wapZM:yxV5rpz-EviutrVeIfptmD50gK24NIFRP8Zlk0Wfub4', '2026-06-20 06:53:44.947675'),
('pdxvozup2qch29c5ack3icrzgc90m342', '.eJxlj8FuwyAQRP-Fs2MZY8D2MVIPPfRSVZV6Qhg2gdoGx2CpUZR_L6iulKrHfTM7s3tDQm7RiC3AKqxGPaKoeGSDVCO4LOhP6c6-VN7F1Q5ltpS7GsoXr2E67t4_AUYGk7ZlRQiluKMDEN1irnknMR4IaaEeWtZyzjTUHa463nBZqxYTrGktG0IY1pjl0AAhWO8EfC12vaKeVQVavHUxiOhzG-oTma2Oq3RBKANq9FsUIcqYtBvyq_598_3p9fnt40APpOk6dQKq2AlSyWCnybpzCoxyQj2uMK1qXuyrj7RKXcHYZcl25UNM_If-v2lz9rJBcuk057hFXmdwUcwQjddihPQOuqw2oPv9GzANhOU:1waqKs:Jii_4GpLqkR239B_qS2W2QUqWHz2Y1ML5_Pcs9wvotk', '2026-06-20 07:42:50.795901'),
('sbrprvlbgkjhooh5uecx3t3g0t8uj9t1', '.eJxVj81qwzAQhN9lz4nRj2XZPhZ66KGXUgo9Ccm7xGocybFkaAh598olhfS4s9_M7lzB2DWPZk20GI_Qg4Ldo-bscKSwLfDLhkOshhjy4l21IdV9m6rXiDQ93dl_AaNNY3FbJqVSvFOOJLZco-4s507KloRrm1brBkl0nHW61lYMLZcclbC1lA1H3myhiVLyMRj6nv1ygb5hOzh5zIsNyQwjDce4ZpOyzQT9FeKCf6U-nt9e3j_3ai-l04oLYoh1iXR-mnw4mByznaAXHWOi3t2dDyIrl9Lo53mDh5gy9Fz9qnP0IafCbm2hL8oa_HmlQmGZt7TZXk4UsjlRHiOaI5XX4bz4BLfbD6ahfao:1wapiN:MqkJbO_fqOtuQF1uxnl3y6JRkkNkmtAsY3bOmqiAqFI', '2026-06-20 07:03:03.373102'),
('syju3dy4clxtvrzva665szc4tujspbml', '.eJxtkM1qwzAQhN9F58RYVuS_W0tTCLSXUgo9CVlaYsWO5EhraAh590rFgQR6nflmNNoLEXLGXswBvDCatIST1b3WSTWATYY-SLt3mXIWvemyhGSLG7J3p2F8XtiHgl6GPqZlzhjntOEdMF3TSleNpLRjrIaiq8u6qkoNRUPzptpUslA1ZVTzQm4YK6mmZSoNEIJxVsDPZPyZtGW-IgFGUAhaKDd7Az4-dbBA7oxJno9gURwBe5c-cvImROBoNHppg1A9qMHNKAJKBNJeiPP6do6v7cfu83vN169Pu7ftS8x1ZhyN3Qt0KEfScsrzol4tmTsxT-t6M00JVi4gaRd1csZiiGy6EGmL_E-drTnNEEmdtNj4OFwMcL6Nv_7fcf0FqWKZFw:1warHX:lCftzf8RG1ZnnwVPAA5x_2fu9CUmA4ssoNmVfKVU3qE', '2026-06-20 08:43:27.608718'),
('tjma9qksls3ecrmubzyt0mub1us7ifgj', '.eJxVj8FqwzAQRP9lz46xrMiWfWtpCoH2UkqhJyFZS6TalhxLhoaQf69MXUiPO_tmducKQi7RiCXgLKyGFhhk95qSXY9uXegv6U4-77yLs1X5iuTbNuSvXuPwuLH_AowMJrllQSljpGEKqeak1nUjCVGUciwVr3hdVxrLhhRNva9l2XFCiWal3FNaEU2qNTRgCNY7gd-TnS_QVkUGo9Vxli6IzmDX-yWKEGVEaK_gZ_1X6uPwdnz_3LHd88Px5fCUwpQdButOIvooB2gZZUXJs81zJxbpRjB2mla48yFCS37VyVsXQ2LXntAmZXH2vGCidJrXtEleRnRRjBiN16LH9DScZxvgdvsB_sl8Mw:1war3J:h-CKy85gbUu3K-efvG8G-rdG4lisQ25xgDc6lF7BLnA', '2026-06-20 08:28:45.087081'),
('u0dzw4p8shqtmu4oy0osnvbgo27u6acb', '.eJxVj8uOwjAMRf8la1Q1DXm0y9nzDZGTWNPMQFziVAKN5t8hEgvY-hxf-_4JD3tb_c5YfU5iEVoc3mcB4i-WDtIPlG8aIpVWcxi6MrwoDydKeP56uR8BK_D63IZRKa3lrAOq5KRNdgYpg1IOp-CMs9YknGY5zvZoYYpOKpn0BEeljEzS9FBG5kzF423L9S4WMx4E4xljw-Qj7TVjfZ7aiMUb2OB-wdL8BdtKvci15i5slEtj36j_KZbx_wHwfllA:1warc2:8WEmBiTa_JqdvVMihmnJsO51jMG5GPHsU4hW-fjz7ic', '2026-06-20 09:04:38.661993'),
('wala5ecqbdmaqvlzu7zzgu0t8egvz8jc', '.eJxVj01rwzAMhv-Lz23wR2wnOQ522GGXMQY7GccSjZfETmMHVkr_-xzWQXfUo0evpCsxdsuD2RKuxgPpiCSHR9ZbN2LYG_BlwylWLoa8-r7alereTdVrBJye7u6_gMGmoUxbKoSUrJU9CmiYBt1axnohGuR9oxqtFSBvGW11rS13DRMMJLe1EIoBU3towpR8DAa_F79eSKfogcwe8mpDMm5AN8Ytm5RtRtJdSVzh76mP57eX98-jPCoOjjrgTS11iez9NPlwMjlmO5GOUS0pV4f76COlZVca_LLsuospF_5Ll-hDTkXe_yVdIVvw5w2LBaXe4xZ7mTFkM2MeIpgRy_HkvPpEbrcfjSd-Gg:1waq8F:Ryl6chUkCFy7Mmyxv2yxdsEelvGGnBReuTOHNY7sh50', '2026-06-20 07:29:47.008177'),
('x0hv70lo8r9yw8h8teqwvfbocbyrhm3y', '.eJxVj8FqwzAQRP9lz46xrMiWfWtpCoH2UkqhJyFZS6TalhxLhoaQf69MXUiPO_tmducKQi7RiCXgLKyGFhhk95qSXY9uXegv6U4-77yLs1X5iuTbNuSvXuPwuLH_AowMJrllQSljpGEKqeak1nUjCVGUciwVr3hdVxrLhhRNva9l2XFCiWal3FNaEU2qNTRgCNY7gd-TnS_QVkUGo9Vxli6IzmDX-yWKEGVEaK_gZ_1X6uPwdnz_3LHd88Px5fCUwpQdButOIvooB2gZZUXJs81zJxbpRjB2mla48yFCS37VyVsXQ2LXntAmZXH2vGCidJrXtEleRnRRjBiN16LH9DScZxvgdvsB_sl8Mw:1waqja:MypZ6eaE2o3hVYEWB6bJDI7BsJ2Vn_ClYBWso5ldjTQ', '2026-06-20 08:08:22.120562'),
('xi0av14c88w30wtlu6vn2uslsmix88c0', '.eJxlT8tOxCAU_RfWnQZKoY-liQsXbowxcUVu4TpgW6iFGieT-XdpHJMxLu953nMmCrZk1RZxVc6QnghS3GID6BH9Tph38MdQ6uDT6oZyl5RXNpaPweB0d9X-CbAQbXYD5VwI1okBuWlZY5oOGBs4b7EaWtk2jTRYdYx2Td1ApVvGmREV1JxLZpjcQyPG6IJX-LW49UR6SQuyBOdTVCnsbaTPyOxMWsFHpS3qMWxJxQQpc2cSVvM78-X-6eH59SAOjFLMHVp2-i2XDG6anD_mwAQT6WspaCWKq_MGpLkpWrcsu1iHmEjPftD_H23efWyYVSbfe9oCpxl9UjMmG4waMY8hn0Aul28DyYM2:1wapkJ:b-LlD_2-E7y7bQ4ZZT2YuU2xKe1sPB9bk3VKLDUfPgc', '2026-06-20 07:05:03.234954'),
('y8scards8vglg3hdqgnjauw0kg2vzo9r', '.eJxVjzFvgzAUhP-LZ4KwjTEwRurQoUtVVepkPdsvwQVsgs0QRfnvNVUqpeO7--5070YUbGlQW8RVOUt6IkjxrGkwI_rdsN_gz6E0wafV6XJHyocby7dgcTo-2H8FA8Qhp6HiXAjaCY3ctlRa2QGlmvMWmW6bVsrGIuto1claAjMt5dQKBjXnDbW0yaWzs2kFH5UZ0IxhSyomSEj6Gwmr_dv_-fL--vF1EAfUHTvBibXUyJzWbpqcP6sUEkykZ11Vsbp4JJ_EqipIHNyy7LAJMZGeil91Cc6nmNn9MdJnZfPusmGmbL73tgWuM_qkZkxDsGrEa150WV0k9_sPhol2ow:1waos8:7Bvw0JjjMRXzhyxwjioss1WjytMoa5zKAisVY7xnZ2o', '2026-06-20 06:13:04.977403'),
('ydu35xhysezb05mvegfvr16bwf8uwrz2', '.eJxVj81qwzAQhN9lz4mxrOjHPhZ66KGXUgo9ibW0xKodybFkaAh598o0hfS4s9_M7lzB4JoHsyZajHfQgYDdo9ajHSlsC_eF4RgrG0NefF9tSHXfpuo1Opqe7uy_gAHTUNxYcy4Ea0VP3GmmnGqRsZ5zTU2vpVZKOmpaVrfqoLCxmnHmRIMHziVzTG6hiVLyMRj6nv1ygU7WOzh5lxcMydiB7BjXbFLGTNBdIS7ur9TH89vL--de7Ekr1FbIlilWIns_TT4cTY4ZJ-gOUtSN2N2dD2JdLqXBz_MG25gydOxXnaMPORV2awtdUdbgzysVypV5S5vxcqKQzYnyEJ0ZqbwO58UnuN1-AJ6VfZk:1wapmc:qGGVaO-U-kq64TgFOInRtFp8HMz4Tvuxt55JhG_QkRg', '2026-06-20 07:07:26.349104'),
('ylkn1mr7q9vaxtc5aauo7gweli4mug8m', '.eJxVj8FuwyAMht-FcxpBCIHkWGmHHXaZpkk7IQheYUkgBSKtqvruI1ondUd__vzbviKptmzlliBKZ9CAGKoemVbjBH5vmC_lT6Eeg8_R6XpX6ns31S_BwHy8u_8CrEq2TCtMKWOkZxqoEYQb3itCNKUCGi06wXlnoOkJ7nnLVTMKQolhjWop7Ygh3R6aICUXvITv1cULGjpcocWZHJVPcrQwTmHLMmWVAQ1XFKL5e-r96fX57ePADr3AQLXg0JLPEqndPDt_kjlkNaOBYM5w01X30UeKy65k3bru-hhSLvyXrsH5nIq8_4uGQjbvzhsUy5R6j1vVZQGf5QLZBiMnKMejc3QJ3W4_kNB-JA:1wapvD:X-ZSg2j6mNd8F_F-lDgRWCOwmgonN3MFVXAo9kZHI5c', '2026-06-20 07:16:19.268979'),
('z5jvfayr69ds8xffqpjsaib8rbbkevge', '.eJxVj8FqwzAQRP9lz4mRrMiSfQz00EMvpRR6EmtpG6txJMeSoSHk3yuXFNLjzr6Z3bmCwSUPZkk0G--gAwmbR61He6SwLtwXhkOsbAx59n21ItV9m6qX6Gjc39l_AQOmobiRCSElb2VPwmmunGqR814ITXWvG61U46huOWvVTmFtNRfcyRp3QjTc8WYNTZSSj8HQ9-TnC3QN28DJuzxjSMYOZI9xySZlzATdFeLs_kq9P70-v31s5fZTc6kJSQlmS2Tvx9GHg8kx4whd3TJW7zZ354PIyqU0-GlaYRtTho7LX3WKPuRU2LUtdEVZgj8vVChX5jVtwsuJQjYnykN05kjldTjPPsHt9gPIHn3m:1wape0:4oLZL_LSTQftlK-UxFh0xv8EQsOaIZDmR-mDgDgv3ao', '2026-06-20 06:58:32.277683');

-- --------------------------------------------------------

--
-- Table structure for table `store_cartitem`
--

CREATE TABLE `store_cartitem` (
  `id` bigint(20) NOT NULL,
  `quantity` int(10) UNSIGNED NOT NULL CHECK (`quantity` >= 0),
  `session_key` varchar(40) DEFAULT NULL,
  `product_id` bigint(20) NOT NULL,
  `user_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `store_cartitem`
--

INSERT INTO `store_cartitem` (`id`, `quantity`, `session_key`, `product_id`, `user_id`) VALUES
(1, 1, '7fiqfalxtavxo3snlm4b6y90jtly143x', 1, NULL),
(2, 1, '7fiqfalxtavxo3snlm4b6y90jtly143x', 3, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `store_category`
--

CREATE TABLE `store_category` (
  `id` bigint(20) NOT NULL,
  `name` varchar(100) NOT NULL,
  `slug` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `store_category`
--

INSERT INTO `store_category` (`id`, `name`, `slug`) VALUES
(1, 'Extrait de Parfum', 'extrait-de-parfum'),
(2, 'Eau de Parfum (EDP)', 'eau-de-parfum-edp'),
(3, 'Eau de Toilette (EDT)', 'eau-de-toilette-edt'),
(4, 'Eau de Cologne (EDC)', 'eau-de-cologne-edc'),
(5, 'Eau Fraiche', 'eau-fraiche');

-- --------------------------------------------------------

--
-- Table structure for table `store_order`
--

CREATE TABLE `store_order` (
  `id` bigint(20) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `paid` tinyint(1) NOT NULL,
  `user_id` int(11) NOT NULL,
  `shipping_cost` decimal(10,2) NOT NULL,
  `status` varchar(20) NOT NULL,
  `points_used` int(10) UNSIGNED NOT NULL CHECK (`points_used` >= 0),
  `received_at` datetime(6) DEFAULT NULL,
  `total_price` decimal(10,2) NOT NULL DEFAULT 0.00,
  `courier` varchar(20) NOT NULL,
  `payment_method` varchar(30) NOT NULL,
  `payment_proof` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `store_order`
--

INSERT INTO `store_order` (`id`, `created_at`, `paid`, `user_id`, `shipping_cost`, `status`, `points_used`, `received_at`, `total_price`, `courier`, `payment_method`, `payment_proof`) VALUES
(1, '2026-06-09 11:10:14.009087', 1, 2, 0.00, 'processing', 0, NULL, 0.00, 'jne', 'qris', NULL),
(2, '2026-06-09 12:05:24.834407', 1, 2, 0.00, 'processing', 0, NULL, 0.00, 'jne', 'qris', NULL),
(3, '2026-06-09 13:59:28.711527', 1, 2, 0.00, 'processing', 0, NULL, 0.00, 'jne', 'qris', NULL),
(4, '2026-06-09 14:02:24.276116', 1, 2, 0.00, 'processing', 0, NULL, 0.00, 'jne', 'qris', NULL),
(5, '2026-06-09 14:18:57.225249', 1, 2, 0.00, 'processing', 0, NULL, 0.00, 'jne', 'qris', NULL),
(6, '2026-06-09 15:59:36.000500', 1, 2, 0.00, 'processing', 0, NULL, 0.00, 'jne', 'qris', NULL),
(7, '2026-06-09 16:00:15.442893', 1, 2, 0.00, 'processing', 0, NULL, 0.00, 'jne', 'qris', NULL),
(8, '2026-06-09 16:03:20.306957', 1, 2, 0.00, 'processing', 0, NULL, 0.00, 'jne', 'qris', NULL),
(9, '2026-06-09 16:07:55.844864', 1, 2, 0.00, 'processing', 0, NULL, 0.00, 'jne', 'qris', NULL),
(10, '2026-06-09 16:08:56.991970', 1, 2, 0.00, 'processing', 0, NULL, 0.00, 'jne', 'qris', NULL),
(11, '2026-06-10 03:05:45.474313', 1, 2, 0.00, 'processing', 0, NULL, 0.00, 'jne', 'qris', NULL),
(12, '2026-06-10 03:08:38.375981', 1, 2, 0.00, 'processing', 0, NULL, 0.00, 'jne', 'qris', NULL),
(13, '2026-06-10 03:34:59.495033', 1, 3, 0.00, 'processing', 0, NULL, 0.00, 'jne', 'qris', NULL),
(14, '2026-06-10 10:20:46.401699', 1, 5, 22000.00, 'processing', 0, NULL, 0.00, 'jne', 'qris', NULL),
(15, '2026-06-13 03:51:20.216358', 1, 5, 60000.00, 'processing', 0, NULL, 0.00, 'jne', 'qris', NULL),
(16, '2026-06-14 13:07:01.373331', 1, 5, 60000.00, 'processing', 0, NULL, 0.00, 'jne', 'qris', NULL),
(17, '2026-06-14 13:50:42.839186', 1, 5, 15000.00, 'shipped', 0, NULL, 0.00, 'jne', 'qris', NULL),
(18, '2026-06-15 10:09:36.016022', 1, 5, 45000.00, 'shipped', 0, NULL, 0.00, 'jne', 'qris', NULL),
(19, '2026-06-16 17:26:14.699269', 1, 5, 45000.00, 'delivered', 0, NULL, 1045000.00, 'jne', 'qris', NULL),
(20, '2026-06-16 17:33:09.678821', 1, 5, 45000.00, 'delivered', 100000, NULL, 555000.00, 'jne', 'qris', NULL),
(21, '2026-06-16 18:01:06.402170', 1, 5, 45000.00, 'delivered', 0, NULL, 495000.00, 'jne', 'qris', NULL),
(22, '2026-06-17 02:37:30.770560', 1, 5, 15000.00, 'delivered', 50000, NULL, 415000.00, 'jne', 'qris', NULL),
(23, '2026-06-17 02:58:13.049439', 1, 5, 15000.00, 'processing', 0, NULL, 290000.00, 'jne', 'qris', NULL),
(24, '2026-06-20 07:03:25.416975', 1, 5, 15000.00, 'processing', 0, NULL, 290000.00, 'jne', 'qris', NULL),
(25, '2026-06-20 07:10:22.450657', 1, 5, 15000.00, 'processing', 0, NULL, 465000.00, 'jne', 'qris', NULL),
(26, '2026-06-20 07:41:21.602894', 1, 5, 15000.00, 'processing', 0, NULL, 1075000.00, 'jne', 'qris', NULL),
(27, '2026-06-20 07:44:56.958795', 1, 5, 15000.00, 'processing', 0, NULL, 1015000.00, 'jne', 'qris', NULL),
(34, '2026-06-20 09:03:09.140501', 0, 5, 13000.00, 'payment_verification', 0, NULL, 533000.00, 'pos', 'qris', 'payment_proofs/image-removebg-preview_1.png'),
(35, '2026-06-20 09:06:26.799285', 0, 5, 81500.00, 'pending_payment', 0, NULL, 531500.00, 'tiki', 'qris', ''),
(36, '2026-06-20 09:10:42.318226', 1, 5, 80000.00, 'delivered', 0, NULL, 1080000.00, 'jne', 'qris', 'payment_proofs/faf117b58d37737319587cbd5cf48315.jpg');

-- --------------------------------------------------------

--
-- Table structure for table `store_orderitem`
--

CREATE TABLE `store_orderitem` (
  `id` bigint(20) NOT NULL,
  `quantity` int(10) UNSIGNED NOT NULL CHECK (`quantity` >= 0),
  `price` decimal(10,2) NOT NULL,
  `order_id` bigint(20) NOT NULL,
  `product_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `store_orderitem`
--

INSERT INTO `store_orderitem` (`id`, `quantity`, `price`, `order_id`, `product_id`) VALUES
(1, 1, 450000.00, 20, 1),
(2, 1, 275000.00, 20, 2),
(3, 3, 450000.00, 19, 1),
(4, 1, 275000.00, 19, 2),
(5, 1, 520000.00, 19, 3),
(6, 1, 450000.00, 21, 1),
(7, 1, 450000.00, 22, 1),
(8, 1, 275000.00, 23, 2),
(9, 1, 275000.00, 24, 2),
(10, 1, 450000.00, 25, 1),
(11, 1, 450000.00, 26, 1),
(12, 1, 610000.00, 26, 4),
(13, 1, 1000000.00, 27, 6),
(20, 1, 520000.00, 34, 3),
(21, 1, 450000.00, 35, 1),
(22, 1, 1000000.00, 36, 6);

-- --------------------------------------------------------

--
-- Table structure for table `store_product`
--

CREATE TABLE `store_product` (
  `id` bigint(20) NOT NULL,
  `name` varchar(200) NOT NULL,
  `slug` varchar(50) NOT NULL,
  `description` longtext NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `stock` int(10) UNSIGNED NOT NULL CHECK (`stock` >= 0),
  `created_at` datetime(6) NOT NULL,
  `category_id` bigint(20) DEFAULT NULL,
  `image_url` varchar(200) NOT NULL,
  `image` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `store_product`
--

INSERT INTO `store_product` (`id`, `name`, `slug`, `description`, `price`, `stock`, `created_at`, `category_id`, `image_url`, `image`) VALUES
(1, 'Parfum Mawar Premium', 'parfum-mawar-premium', 'Aroma mewah dengan sentuhan mawar merah dan vanila, cocok untuk acara spesial.', 450000.00, 7, '2026-06-07 10:40:26.777608', 1, 'https://down-id.img.susercontent.com/file/sg-11134201-81zuw-mir1sh9yrsp32d@resize_w900_nl.webp', ''),
(2, 'Eau de Cologne Citrus', 'eau-de-cologne-citrus', 'Kesegaran citrus yang ringan dan energik untuk aktivitas sehari-hari.', 275000.00, 18, '2026-06-07 10:40:26.786036', 2, 'https://down-id.img.susercontent.com/file/id-11134207-7ra0t-mctb6251lvss2e@resize_w900_nl.webp', ''),
(3, 'Musk Floral Elegance', 'musk-floral-elegance', 'Kombinasi musk lembut dan bunga putih menciptakan kesan elegan dan tahan lama.', 520000.00, 6, '2026-06-07 10:40:26.799915', 3, 'https://down-id.img.susercontent.com/file/id-11134207-822wp-mp34ly164jyk43@resize_w900_nl.webp', ''),
(4, 'Amber Wood Signature', 'amber-wood-signature', 'Wewangian hangat dengan kayu amber dan cendana, cocok untuk suasana malam.', 610000.00, 7, '2026-06-07 10:40:26.809914', 4, 'https://down-id.img.susercontent.com/file/id-11134207-822wt-mntuvosui879d2@resize_w900_nl.webp', ''),
(6, 'Yves Saint Laurent Black Opium', 'Yves-Saint-Laurent-Black-Opium', 'Wangi Banget', 1000000.00, 97, '2026-06-14 14:03:48.885713', 1, 'https://down-id.img.susercontent.com/file/abd618858d41f798c4a18842e3becbda@resize_w900_nl.webp', '');

-- --------------------------------------------------------

--
-- Table structure for table `store_productreview`
--

CREATE TABLE `store_productreview` (
  `id` bigint(20) NOT NULL,
  `rating` int(11) NOT NULL DEFAULT 5,
  `comment` longtext NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `order_item_id` bigint(20) NOT NULL,
  `product_id` bigint(20) DEFAULT NULL,
  `user_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `store_productreview`
--

INSERT INTO `store_productreview` (`id`, `rating`, `comment`, `created_at`, `order_item_id`, `product_id`, `user_id`) VALUES
(1, 5, 'bagus', '2026-06-16 18:01:42.373451', 6, 1, 5),
(2, 4, 'Cukup bagus, tapi harga sedikit mahal.', '2026-06-16 18:04:13.469472', 3, 1, 5),
(3, 5, 'Produk berkualitas tinggi, rekomendasi untuk dibeli. Pengiriman cepat dan packaging rapih.', '2026-06-16 18:04:13.484227', 4, 2, 5),
(4, 1, 'j', '2026-06-16 18:04:13.498380', 1, 1, 5),
(5, 5, 'Produk berkualitas tinggi, rekomendasi untuk dibeli. Pengiriman cepat dan packaging rapih.', '2026-06-16 18:04:13.509921', 2, 2, 5),
(6, 1, 'kemahalan baunya menyengat', '2026-06-20 09:12:57.862500', 22, 6, 5);

-- --------------------------------------------------------

--
-- Table structure for table `store_returnrequest`
--

CREATE TABLE `store_returnrequest` (
  `id` bigint(20) NOT NULL,
  `reason` longtext NOT NULL,
  `status` varchar(20) NOT NULL,
  `accepted_terms` tinyint(1) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `order_id` bigint(20) NOT NULL,
  `user_id` int(11) NOT NULL,
  `points_amount` int(10) UNSIGNED NOT NULL CHECK (`points_amount` >= 0),
  `points_awarded` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `store_returnrequest`
--

INSERT INTO `store_returnrequest` (`id`, `reason`, `status`, `accepted_terms`, `created_at`, `order_id`, `user_id`, `points_amount`, `points_awarded`) VALUES
(1, 'jelek', 'rejected', 1, '2026-06-10 03:08:47.959668', 12, 2, 0, 0),
(2, 'kurang bagus', 'rejected', 1, '2026-06-16 17:26:27.014090', 19, 5, 0, 1);

-- --------------------------------------------------------

--
-- Table structure for table `store_userprofile`
--

CREATE TABLE `store_userprofile` (
  `id` bigint(20) NOT NULL,
  `phone_number` varchar(20) NOT NULL,
  `address_line` longtext NOT NULL,
  `province` varchar(100) NOT NULL,
  `regency` varchar(100) NOT NULL,
  `postal_code` varchar(20) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `user_id` int(11) NOT NULL,
  `store_points` int(10) UNSIGNED NOT NULL CHECK (`store_points` >= 0)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `store_userprofile`
--

INSERT INTO `store_userprofile` (`id`, `phone_number`, `address_line`, `province`, `regency`, `postal_code`, `created_at`, `user_id`, `store_points`) VALUES
(1, '0987654321', 'Jl. Sukadamai No. 21', 'Nanggroe Aceh Darussalam', 'Kota Banda Aceh', '09876', '2026-06-10 10:10:50.737298', 5, 895000);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `auth_group`
--
ALTER TABLE `auth_group`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Indexes for table `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  ADD KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`);

--
-- Indexes for table `auth_permission`
--
ALTER TABLE `auth_permission`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`);

--
-- Indexes for table `auth_user`
--
ALTER TABLE `auth_user`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`);

--
-- Indexes for table `auth_user_groups`
--
ALTER TABLE `auth_user_groups`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_user_groups_user_id_group_id_94350c0c_uniq` (`user_id`,`group_id`),
  ADD KEY `auth_user_groups_group_id_97559544_fk_auth_group_id` (`group_id`);

--
-- Indexes for table `auth_user_user_permissions`
--
ALTER TABLE `auth_user_user_permissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_user_user_permissions_user_id_permission_id_14a6b632_uniq` (`user_id`,`permission_id`),
  ADD KEY `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` (`permission_id`);

--
-- Indexes for table `django_admin_log`
--
ALTER TABLE `django_admin_log`
  ADD PRIMARY KEY (`id`),
  ADD KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  ADD KEY `django_admin_log_user_id_c564eba6_fk_auth_user_id` (`user_id`);

--
-- Indexes for table `django_content_type`
--
ALTER TABLE `django_content_type`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`);

--
-- Indexes for table `django_migrations`
--
ALTER TABLE `django_migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `django_session`
--
ALTER TABLE `django_session`
  ADD PRIMARY KEY (`session_key`),
  ADD KEY `django_session_expire_date_a5c62663` (`expire_date`);

--
-- Indexes for table `store_cartitem`
--
ALTER TABLE `store_cartitem`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique_user_product` (`user_id`,`product_id`),
  ADD UNIQUE KEY `unique_session_product` (`session_key`,`product_id`),
  ADD KEY `store_cartitem_product_id_4238d443_fk_store_product_id` (`product_id`);

--
-- Indexes for table `store_category`
--
ALTER TABLE `store_category`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `slug` (`slug`);

--
-- Indexes for table `store_order`
--
ALTER TABLE `store_order`
  ADD PRIMARY KEY (`id`),
  ADD KEY `store_order_user_id_ae5f7a5f_fk_auth_user_id` (`user_id`);

--
-- Indexes for table `store_orderitem`
--
ALTER TABLE `store_orderitem`
  ADD PRIMARY KEY (`id`),
  ADD KEY `store_orderitem_order_id_acf8722d_fk_store_order_id` (`order_id`),
  ADD KEY `store_orderitem_product_id_f2b098d4_fk_store_product_id` (`product_id`);

--
-- Indexes for table `store_product`
--
ALTER TABLE `store_product`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `slug` (`slug`),
  ADD KEY `store_product_category_id_574bae65_fk_store_category_id` (`category_id`);

--
-- Indexes for table `store_productreview`
--
ALTER TABLE `store_productreview`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `order_item_id` (`order_item_id`),
  ADD KEY `product_id` (`product_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `store_returnrequest`
--
ALTER TABLE `store_returnrequest`
  ADD PRIMARY KEY (`id`),
  ADD KEY `store_returnrequest_order_id_af81ab1f_fk_store_order_id` (`order_id`),
  ADD KEY `store_returnrequest_user_id_6fe55301_fk_auth_user_id` (`user_id`);

--
-- Indexes for table `store_userprofile`
--
ALTER TABLE `store_userprofile`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `user_id` (`user_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `auth_group`
--
ALTER TABLE `auth_group`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `auth_permission`
--
ALTER TABLE `auth_permission`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=61;

--
-- AUTO_INCREMENT for table `auth_user`
--
ALTER TABLE `auth_user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `auth_user_groups`
--
ALTER TABLE `auth_user_groups`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `auth_user_user_permissions`
--
ALTER TABLE `auth_user_user_permissions`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `django_admin_log`
--
ALTER TABLE `django_admin_log`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `django_content_type`
--
ALTER TABLE `django_content_type`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `django_migrations`
--
ALTER TABLE `django_migrations`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=34;

--
-- AUTO_INCREMENT for table `store_cartitem`
--
ALTER TABLE `store_cartitem`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=52;

--
-- AUTO_INCREMENT for table `store_category`
--
ALTER TABLE `store_category`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `store_order`
--
ALTER TABLE `store_order`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=37;

--
-- AUTO_INCREMENT for table `store_orderitem`
--
ALTER TABLE `store_orderitem`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;

--
-- AUTO_INCREMENT for table `store_product`
--
ALTER TABLE `store_product`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `store_productreview`
--
ALTER TABLE `store_productreview`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `store_returnrequest`
--
ALTER TABLE `store_returnrequest`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `store_userprofile`
--
ALTER TABLE `store_userprofile`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  ADD CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  ADD CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`);

--
-- Constraints for table `auth_permission`
--
ALTER TABLE `auth_permission`
  ADD CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`);

--
-- Constraints for table `auth_user_groups`
--
ALTER TABLE `auth_user_groups`
  ADD CONSTRAINT `auth_user_groups_group_id_97559544_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  ADD CONSTRAINT `auth_user_groups_user_id_6a12ed8b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Constraints for table `auth_user_user_permissions`
--
ALTER TABLE `auth_user_user_permissions`
  ADD CONSTRAINT `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  ADD CONSTRAINT `auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Constraints for table `django_admin_log`
--
ALTER TABLE `django_admin_log`
  ADD CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  ADD CONSTRAINT `django_admin_log_user_id_c564eba6_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Constraints for table `store_cartitem`
--
ALTER TABLE `store_cartitem`
  ADD CONSTRAINT `store_cartitem_product_id_4238d443_fk_store_product_id` FOREIGN KEY (`product_id`) REFERENCES `store_product` (`id`),
  ADD CONSTRAINT `store_cartitem_user_id_3ff2f2b5_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Constraints for table `store_order`
--
ALTER TABLE `store_order`
  ADD CONSTRAINT `store_order_user_id_ae5f7a5f_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Constraints for table `store_orderitem`
--
ALTER TABLE `store_orderitem`
  ADD CONSTRAINT `store_orderitem_order_id_acf8722d_fk_store_order_id` FOREIGN KEY (`order_id`) REFERENCES `store_order` (`id`),
  ADD CONSTRAINT `store_orderitem_product_id_f2b098d4_fk_store_product_id` FOREIGN KEY (`product_id`) REFERENCES `store_product` (`id`);

--
-- Constraints for table `store_product`
--
ALTER TABLE `store_product`
  ADD CONSTRAINT `store_product_category_id_574bae65_fk_store_category_id` FOREIGN KEY (`category_id`) REFERENCES `store_category` (`id`);

--
-- Constraints for table `store_productreview`
--
ALTER TABLE `store_productreview`
  ADD CONSTRAINT `store_productreview_ibfk_1` FOREIGN KEY (`order_item_id`) REFERENCES `store_orderitem` (`id`),
  ADD CONSTRAINT `store_productreview_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `store_product` (`id`),
  ADD CONSTRAINT `store_productreview_ibfk_3` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Constraints for table `store_returnrequest`
--
ALTER TABLE `store_returnrequest`
  ADD CONSTRAINT `store_returnrequest_order_id_af81ab1f_fk_store_order_id` FOREIGN KEY (`order_id`) REFERENCES `store_order` (`id`),
  ADD CONSTRAINT `store_returnrequest_user_id_6fe55301_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Constraints for table `store_userprofile`
--
ALTER TABLE `store_userprofile`
  ADD CONSTRAINT `store_userprofile_user_id_6db609dc_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
