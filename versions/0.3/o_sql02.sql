-- phpMyAdmin SQL Dump
-- version 3.4.11.1
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Feb 18, 2013 at 01:35 AM
-- Server version: 5.1.66
-- PHP Version: 5.2.17

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `phjrsz_wp4`
--

-- --------------------------------------------------------

--
-- Table structure for table `wp_posts`
--

CREATE TABLE IF NOT EXISTS `wp_posts` (
  `ID` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `post_author` bigint(20) unsigned NOT NULL DEFAULT '0',
  `post_date` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `post_date_gmt` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `post_content` longtext NOT NULL,
  `post_title` text NOT NULL,
  `post_excerpt` text NOT NULL,
  `post_status` varchar(20) NOT NULL DEFAULT 'publish',
  `comment_status` varchar(20) NOT NULL DEFAULT 'open',
  `ping_status` varchar(20) NOT NULL DEFAULT 'open',
  `post_password` varchar(20) NOT NULL DEFAULT '',
  `post_name` varchar(200) NOT NULL DEFAULT '',
  `to_ping` text NOT NULL,
  `pinged` text NOT NULL,
  `post_modified` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `post_modified_gmt` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `post_content_filtered` longtext NOT NULL,
  `post_parent` bigint(20) unsigned NOT NULL DEFAULT '0',
  `guid` varchar(255) NOT NULL DEFAULT '',
  `menu_order` int(11) NOT NULL DEFAULT '0',
  `post_type` varchar(20) NOT NULL DEFAULT 'post',
  `post_mime_type` varchar(100) NOT NULL DEFAULT '',
  `comment_count` bigint(20) NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`),
  KEY `post_name` (`post_name`),
  KEY `type_status_date` (`post_type`,`post_status`,`post_date`,`ID`),
  KEY `post_parent` (`post_parent`),
  KEY `post_author` (`post_author`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=14 ;

--
-- Table structure for table `wp_geo_mashup_locations`
--

CREATE TABLE IF NOT EXISTS `wp_geo_mashup_locations` (
  `id` mediumint(9) NOT NULL AUTO_INCREMENT,
  `lat` float(11,7) NOT NULL,
  `lng` float(11,7) NOT NULL,
  `address` tinytext,
  `saved_name` varchar(100) DEFAULT NULL,
  `geoname` tinytext,
  `postal_code` tinytext,
  `country_code` varchar(2) DEFAULT NULL,
  `admin_code` varchar(20) DEFAULT NULL,
  `sub_admin_code` varchar(80) DEFAULT NULL,
  `locality_name` tinytext,
  PRIMARY KEY (`id`),
  UNIQUE KEY `latlng` (`lat`,`lng`),
  UNIQUE KEY `saved_name` (`saved_name`),
  KEY `lat` (`lat`),
  KEY `lng` (`lng`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=2 ;

--
-- Table structure for table `wp_geo_mashup_location_relationships`
--

CREATE TABLE IF NOT EXISTS `wp_geo_mashup_location_relationships` (
  `object_name` varchar(80) NOT NULL,
  `object_id` bigint(20) NOT NULL,
  `location_id` mediumint(9) NOT NULL,
  `geo_date` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`object_name`,`object_id`,`location_id`),
  KEY `object_name` (`object_name`,`object_id`),
  KEY `object_date_key` (`object_name`,`geo_date`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;



--
-- Dumping data for table `wp_posts`
--

INSERT INTO `wp_posts` (`ID`, `post_author`, `post_date`, `post_date_gmt`, `post_content`, `post_title`, `post_excerpt`, `post_status`, `comment_status`, `ping_status`, `post_password`, `post_name`, `to_ping`, `pinged`, `post_modified`, `post_modified_gmt`, `post_content_filtered`, `post_parent`, `guid`, `menu_order`, `post_type`, `post_mime_type`, `comment_count`) VALUES
(25, 1, '2013-02-18 03:26:14', '2013-02-18 03:26:14', 'Pedestrian Crossing', 'Pedestrian Crossing', '', 'publish', 'open', 'open', '', 'pedestrian-crossing-25', '', '', '2013-02-18 03:26:14', '2013-02-18 03:26:14', '', 0, 'http://www.opendawn.com/test/geo1/2013/02/18/pedestrian-crossing-25/', 0, 'post', '', 0),
(26, 1, '2013-02-18 03:26:14', '2013-02-18 03:26:14', 'Parking:山上駐車場', '山上駐車場', '', 'publish', 'open', 'open', '', '%E5%B1%B1%E4%B8%8A%E9%A7%90%E8%BB%8A%E5%A0%B4-26', '', '', '2013-02-18 03:26:14', '2013-02-18 03:26:14', '', 0, 'http://www.opendawn.com/test/geo1/2013/02/18/%E5%B1%B1%E4%B8%8A%E9%A7%90%E8%BB%8A%E5%A0%B4-26/', 0, 'post', '', 0);

--
-- Dumping data for table `wp_geo_mashup_locations`
--

INSERT INTO `wp_geo_mashup_locations` (`id`, `lat`, `lng`, `address`, `saved_name`, `geoname`, `postal_code`, `country_code`, `admin_code`, `sub_admin_code`, `locality_name`) VALUES
(25, 34.122842400, 133.645256100, '', 'Pedestrian Crossing', NULL, '', '', '', NULL, ''),
(26, 34.134121250, 133.646043150, '', '山上駐車場', NULL, '', '', '', NULL, '');

--
-- Dumping data for table `wp_geo_mashup_location_relationships`
--

INSERT INTO `wp_geo_mashup_location_relationships` (`object_name`, `object_id`, `location_id`, `geo_date`) VALUES
('post', 25, 25, '2013-02-18 03:26:14'),
('post', 26, 26, '2013-02-18 03:26:14');

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
