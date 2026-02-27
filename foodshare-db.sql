-- FoodShare Green Tech Database Dump
-- Project: FoodShare - Community Food Waste Reduction Platform
-- Year: 2026

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `foodshare_db`
--

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(50) NOT NULL UNIQUE,
  `email` varchar(100) NOT NULL UNIQUE,
  `password_hash` varchar(255) NOT NULL,
  `created_at` timestamp DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `categories`
--

CREATE TABLE `categories` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Table structure for table `food_items`
--

CREATE TABLE `food_items` (
  `id` int NOT NULL AUTO_INCREMENT,
  `donor_id` int NOT NULL,
  `title` varchar(100) NOT NULL,
  `description` text,
  `image_url` varchar(255) DEFAULT '/img/default-food.png',
  `expiry_date` datetime NOT NULL,
  `category_id` int NOT NULL,
  `status` enum('available', 'claimed') DEFAULT 'available',
  `created_at` timestamp DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  FOREIGN KEY (`donor_id`) REFERENCES `users`(`id`),
  FOREIGN KEY (`category_id`) REFERENCES `categories`(`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `claims`
--

CREATE TABLE `claims` (
  `id` int NOT NULL AUTO_INCREMENT,
  `item_id` int NOT NULL,
  `recipient_id` int NOT NULL,
  `claim_date` timestamp DEFAULT CURRENT_TIMESTAMP,
  `status` enum('pending', 'collected') DEFAULT 'pending',
  PRIMARY KEY (`id`),
  FOREIGN KEY (`item_id`) REFERENCES `food_items`(`id`),
  FOREIGN KEY (`recipient_id`) REFERENCES `users`(`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping sample data for table `users`
--

INSERT INTO `users` (`id`, `username`, `email`, `password_hash`) VALUES
(1, 'Sameer_Donor', 'sameer@example.com', 'hashedpassword123'),
(2, 'Mahesh_Student', 'mahesh@example.com', 'hashedpassword456'),
(3, 'Prativa_Bakery', 'prativa@bakery.com', 'hashedpassword789');

--
-- Dumping sample data for table `categories`
--

INSERT INTO `categories` (`id`, `name`) VALUES
(1, 'Bakery'),
(2, 'Produce'),
(3, 'Canned Goods'),
(4, 'Dairy'),
(5, 'Other');

--
-- Dumping sample data for table `food_items`
--

INSERT INTO `food_items` (`id`, `donor_id`, `title`, `description`, `image_url`, `expiry_date`, `category_id`, `status`) VALUES
(1, 1, 'Assorted Pastries', 'Leftover croissants and muffins from the closing shift. Still fresh!', '/img/pastries.png', '2026-06-15 17:00:00', 1, 'available'),
(2, 3, 'Sourdough Bread', 'Day-old artisan bread, perfectly good for toasting.', '/img/bread.png', '2026-06-15 18:30:00', 1, 'available'),
(3, 1, 'Surplus Canned Beans', 'Extra stock from student pantry clean-out.', '/img/beans.png', '2027-01-01 00:00:00', 3, 'available');


/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
