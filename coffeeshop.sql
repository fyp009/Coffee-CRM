-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Apr 19, 2022 at 06:20 AM
-- Server version: 10.4.22-MariaDB
-- PHP Version: 8.1.2

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `coffeeshop`
--

-- --------------------------------------------------------

--
-- Table structure for table `admin_account`
--

CREATE TABLE `admin_account` (
  `admin_username` varchar(50) NOT NULL,
  `admin_password` varchar(50) NOT NULL DEFAULT 'password',
  `role` varchar(45) NOT NULL,
  `status` varchar(10) NOT NULL DEFAULT 'Offline'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `admin_account`
--

INSERT INTO `admin_account` (`admin_username`, `admin_password`, `role`, `status`) VALUES
('Admin', '123', 'Admin', 'Offline'),
('Khun', 'password', 'Cashier', 'Offline'),
('Muny', 'password', 'Cashier', 'Offline'),
('Setha', 'password', 'Barista', 'Offline'),
('Sothirich', '123', 'Cashier', 'Offline'),
('test', 'password', 'Barista', 'Offline'),
('test1', 'password', 'Barista', 'Offline');

-- --------------------------------------------------------

--
-- Table structure for table `drink_list`
--

CREATE TABLE `drink_list` (
  `drink_id` int(11) NOT NULL,
  `drink_name` varchar(45) NOT NULL,
  `drink_hot_price` decimal(5,2) NOT NULL,
  `drink_iced_price` decimal(5,2) NOT NULL,
  `drink_frappee_price` decimal(5,2) NOT NULL,
  `drink_img` varchar(100) NOT NULL DEFAULT 'resources/img/temp_icon.png'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `drink_list`
--

INSERT INTO `drink_list` (`drink_id`, `drink_name`, `drink_hot_price`, `drink_iced_price`, `drink_frappee_price`, `drink_img`) VALUES
(1, 'Latte', '1.25', '2.80', '3.15', 'resources/img/Latte.png'),
(2, 'Cappucino', '1.25', '2.50', '2.75', 'resources/img/Cappuccino.png'),
(3, 'Americano', '1.30', '2.25', '3.25', 'resources/img/Americano.png'),
(4, 'Caramel Macchiato', '1.25', '2.80', '3.75', 'resources/img/Macchiato.png'),
(5, 'Condensed Milk', '1.00', '2.50', '2.80', 'resources/img/Milk.png'),
(6, 'Mocha', '1.25', '2.15', '2.65', 'resources/img/Mocha.png'),
(7, 'Test1', '1.00', '2.00', '3.00', 'resources/img/temp_icon.png');

-- --------------------------------------------------------

--
-- Table structure for table `history`
--

CREATE TABLE `history` (
  `Nº` int(11) NOT NULL,
  `customer_id` int(11) NOT NULL,
  `drink_name` varchar(45) NOT NULL,
  `drink_type` varchar(45) NOT NULL,
  `drink_price` decimal(10,2) NOT NULL,
  `drink_quantity` int(11) NOT NULL,
  `total_price` decimal(10,2) NOT NULL,
  `date` date NOT NULL DEFAULT current_timestamp(),
  `time` time NOT NULL DEFAULT current_timestamp(),
  `status` varchar(20) NOT NULL DEFAULT 'Ordered',
  `confirmed_by` varchar(45) DEFAULT NULL,
  `accepted_by` varchar(45) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `history`
--

INSERT INTO `history` (`Nº`, `customer_id`, `drink_name`, `drink_type`, `drink_price`, `drink_quantity`, `total_price`, `date`, `time`, `status`, `confirmed_by`, `accepted_by`) VALUES
(1, 1, 'Latte', 'Iced', '2.80', 2, '5.60', '2022-04-01', '09:28:45', 'Ordered', 'Sothirich', NULL),
(2, 2, 'Condensed Milk', 'Hot', '1.00', 1, '1.00', '2022-04-02', '09:37:29', 'Completed', 'Sothirich', 'Sothirich'),
(3, 2, 'Cappucino', 'Hot', '1.25', 1, '1.25', '2022-04-02', '09:37:29', 'Completed', 'Sothirich', 'Sothirich'),
(4, 2, 'Mocha', 'Hot', '1.25', 1, '1.25', '2022-04-02', '09:37:29', 'Completed', 'Sothirich', 'Sothirich'),
(5, 3, 'Condensed Milk', 'Hot', '1.00', 1, '1.00', '2022-04-03', '09:37:43', 'Completed', 'Sothirich', 'Sothirich'),
(6, 3, 'Caramel Macchiato', 'Hot', '1.25', 2, '2.50', '2022-04-03', '09:37:43', 'Completed', 'Sothirich', 'Sothirich'),
(7, 4, 'Condensed Milk', 'Hot', '1.00', 1, '1.00', '2022-04-17', '09:38:09', 'Completed', 'Sothirich', 'Sothirich'),
(8, 4, 'Caramel Macchiato', 'Hot', '1.25', 1, '1.25', '2022-04-17', '09:38:09', 'Completed', 'Sothirich', 'Sothirich'),
(9, 5, 'Caramel Macchiato', 'Iced', '2.80', 2, '5.60', '2022-04-17', '09:39:30', 'Completed', 'Sothirich', 'Sothirich'),
(10, 6, 'Cappucino', 'Hot', '1.25', 1, '1.25', '2022-04-17', '10:09:54', 'Completed', 'Sothirich', 'Sothirich'),
(11, 6, 'Caramel Macchiato', 'Hot', '1.25', 2, '2.50', '2022-04-17', '10:09:54', 'Completed', 'Sothirich', 'Sothirich'),
(12, 7, 'Americano', 'Hot', '1.30', 1, '1.30', '2022-04-17', '10:12:23', 'Completed', 'Sothirich', 'Sothirich'),
(13, 8, 'Cappucino', 'Hot', '1.25', 1, '1.25', '2022-04-17', '12:47:25', 'Canceled', 'Sothirich', NULL),
(14, 9, 'Caramel Macchiato', 'Hot', '1.25', 1, '1.25', '2022-04-17', '12:51:30', 'Completed', 'Sothirich', 'Sothirich'),
(15, 10, 'Condensed Milk', 'Hot', '1.00', 1, '1.00', '2022-04-17', '12:53:02', 'Completed', 'Sothirich', 'Sothirich'),
(16, 10, 'Caramel Macchiato', 'Hot', '1.25', 1, '1.25', '2022-04-17', '12:53:02', 'Completed', 'Sothirich', 'Sothirich'),
(17, 11, 'Condensed Milk', 'Hot', '1.00', 1, '1.00', '2022-04-17', '13:01:39', 'Completed', 'Sothirich', 'Sothirich'),
(18, 11, 'Cappucino', 'Hot', '1.25', 1, '1.25', '2022-04-17', '13:01:39', 'Completed', 'Sothirich', 'Sothirich'),
(19, 12, 'Latte', 'Hot', '1.25', 1, '1.25', '2022-04-17', '13:16:44', 'Completed', 'admin', 'Sothirich'),
(20, 12, 'Condensed Milk', 'Hot', '1.00', 1, '1.00', '2022-04-17', '13:16:44', 'Completed', 'admin', 'Sothirich'),
(21, 13, 'Caramel Macchiato', 'Hot', '1.25', 1, '1.25', '2022-04-17', '13:29:21', 'Completed', 'Sothirich', 'Sothirich'),
(22, 13, 'Mocha', 'Hot', '1.25', 1, '1.25', '2022-04-17', '13:29:21', 'Completed', 'Sothirich', 'Sothirich'),
(23, 14, 'Caramel Macchiato', 'Hot', '1.25', 1, '1.25', '2022-04-17', '13:45:52', 'Completed', 'Sothirich', 'Sothirich'),
(24, 15, 'Condensed Milk', 'Hot', '1.00', 1, '1.00', '2022-04-17', '13:46:11', 'Completed', 'Sothirich', 'Sothirich'),
(25, 16, 'Condensed Milk', 'Hot', '1.00', 1, '1.00', '2022-04-17', '17:19:17', 'Completed', 'null', 'null'),
(26, 16, 'Caramel Macchiato', 'Hot', '1.25', 1, '1.25', '2022-04-17', '17:19:17', 'Completed', 'null', 'null'),
(27, 17, 'Caramel Macchiato', 'Hot', '1.25', 1, '1.25', '2022-04-18', '15:43:19', 'Completed', 'Sothirich', 'Sothirich'),
(28, 17, 'Condensed Milk', 'Hot', '1.00', 1, '1.00', '2022-04-18', '15:43:19', 'Completed', 'Sothirich', 'Sothirich'),
(29, 17, 'Mocha', 'Hot', '1.25', 4, '5.00', '2022-04-18', '15:43:19', 'Completed', 'Sothirich', 'Sothirich'),
(30, 18, 'Condensed Milk', 'Hot', '1.00', 1, '1.00', '2022-04-18', '15:45:45', 'Completed', 'Sothirich', 'Sothirich'),
(31, 18, 'Caramel Macchiato', 'Hot', '1.25', 1, '1.25', '2022-04-18', '15:45:45', 'Completed', 'Sothirich', 'Sothirich'),
(32, 18, 'Mocha', 'Hot', '1.25', 7, '8.75', '2022-04-18', '15:45:45', 'Completed', 'Sothirich', 'Sothirich'),
(33, 19, 'Condensed Milk', 'Hot', '1.00', 3, '3.00', '2022-04-18', '16:08:45', 'Completed', 'Admin', 'Admin'),
(34, 20, 'Caramel Macchiato', 'Hot', '1.25', 5, '6.25', '2022-04-18', '19:50:11', 'Completed', 'Admin', 'Admin'),
(35, 20, 'Condensed Milk', 'Hot', '1.00', 1, '1.00', '2022-04-18', '19:50:11', 'Completed', 'Admin', 'Admin'),
(36, 20, 'Cappucino', 'Hot', '1.25', 1, '1.25', '2022-04-18', '19:50:11', 'Completed', 'Admin', 'Admin'),
(37, 20, 'Cappucino', 'Iced', '2.50', 1, '2.50', '2022-04-18', '19:50:11', 'Completed', 'Admin', 'Admin'),
(38, 21, 'Caramel Macchiato', 'Hot', '1.25', 6, '7.50', '2022-04-18', '20:06:34', 'Completed', 'Admin', 'Admin'),
(39, 21, 'Caramel Macchiato', 'Iced', '2.80', 3, '8.40', '2022-04-18', '20:06:34', 'Completed', 'Admin', 'Admin'),
(40, 22, 'Mocha', 'Hot', '1.25', 1, '1.25', '2022-04-18', '21:41:54', 'Completed', 'Admin', 'Admin'),
(41, 22, 'Cappucino', 'Hot', '1.25', 1, '1.25', '2022-04-18', '21:41:54', 'Completed', 'Admin', 'Admin'),
(42, 22, 'Caramel Macchiato', 'Hot', '1.25', 1, '1.25', '2022-04-18', '21:41:54', 'Completed', 'Admin', 'Admin'),
(43, 23, 'Condensed Milk', 'Hot', '1.00', 1, '1.00', '2022-04-18', '21:43:16', 'Canceled', 'Admin', NULL),
(44, 23, 'Caramel Macchiato', 'Hot', '1.25', 1, '1.25', '2022-04-18', '21:43:16', 'Canceled', 'Admin', NULL),
(45, 23, 'Mocha', 'Hot', '1.25', 4, '5.00', '2022-04-18', '21:43:16', 'Canceled', 'Admin', NULL),
(46, 24, 'Caramel Macchiato', 'Hot', '1.25', 2, '2.50', '2022-04-19', '11:10:26', 'Ordered', NULL, NULL),
(47, 24, 'Condensed Milk', 'Hot', '1.00', 1, '1.00', '2022-04-19', '11:10:26', 'Ordered', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `temp_admin`
--

CREATE TABLE `temp_admin` (
  `Nº` int(11) NOT NULL,
  `admin_username` varchar(45) NOT NULL,
  `admin_password` varchar(45) NOT NULL DEFAULT 'password',
  `role` varchar(45) NOT NULL,
  `status` varchar(45) NOT NULL DEFAULT 'Offline'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `temp_admin`
--

INSERT INTO `temp_admin` (`Nº`, `admin_username`, `admin_password`, `role`, `status`) VALUES
(1, 'Admin', '123', 'Admin', 'Active'),
(2, 'Khun', 'password', 'Cashier', 'Offline'),
(3, 'Muny', 'password', 'Cashier', 'Offline'),
(4, 'Setha', 'password', 'Barista', 'Offline'),
(5, 'Sothirich', '123', 'Cashier', 'Offline'),
(6, 'test', 'password', 'Barista', 'Offline'),
(7, 'test1', 'password', 'Barista', 'Offline');

-- --------------------------------------------------------

--
-- Table structure for table `temp_customer`
--

CREATE TABLE `temp_customer` (
  `Nº` int(11) NOT NULL,
  `customer_id` int(11) NOT NULL,
  `drink_name` varchar(45) NOT NULL,
  `drink_type` varchar(45) NOT NULL,
  `drink_price` decimal(10,2) NOT NULL,
  `drink_quantity` int(11) NOT NULL,
  `total_price` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `temp_customer`
--

INSERT INTO `temp_customer` (`Nº`, `customer_id`, `drink_name`, `drink_type`, `drink_price`, `drink_quantity`, `total_price`) VALUES
(1, 24, 'Caramel Macchiato', 'Hot', '1.25', 2, '2.50'),
(2, 24, 'Condensed Milk', 'Hot', '1.00', 1, '1.00');

-- --------------------------------------------------------

--
-- Table structure for table `temp_drinklist`
--

CREATE TABLE `temp_drinklist` (
  `drink_id` int(11) NOT NULL,
  `drink_name` varchar(45) NOT NULL,
  `drink_hot_price` decimal(10,2) NOT NULL,
  `drink_iced_price` decimal(10,2) NOT NULL,
  `drink_frappee_price` decimal(10,2) NOT NULL,
  `drink_img` varchar(45) NOT NULL DEFAULT 'resources/img/temp_icon.png'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `temp_drinklist`
--

INSERT INTO `temp_drinklist` (`drink_id`, `drink_name`, `drink_hot_price`, `drink_iced_price`, `drink_frappee_price`, `drink_img`) VALUES
(1, 'Latte', '1.25', '2.80', '3.15', 'resources/img/Latte.png'),
(2, 'Cappucino', '1.25', '2.50', '2.75', 'resources/img/Cappuccino.png'),
(3, 'Americano', '1.30', '2.25', '3.25', 'resources/img/Americano.png'),
(4, 'Caramel Macchiato', '1.25', '2.80', '3.75', 'resources/img/Macchiato.png'),
(5, 'Condensed Milk', '1.00', '2.50', '2.80', 'resources/img/Milk.png'),
(6, 'Mocha', '1.25', '2.15', '2.65', 'resources/img/Mocha.png'),
(7, 'Test1', '1.00', '2.00', '3.00', 'resources/img/temp_icon.png');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `admin_account`
--
ALTER TABLE `admin_account`
  ADD PRIMARY KEY (`admin_username`);

--
-- Indexes for table `drink_list`
--
ALTER TABLE `drink_list`
  ADD PRIMARY KEY (`drink_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
