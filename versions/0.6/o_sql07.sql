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
-- Database: `phjrsz_wp7`
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
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `lat` double(11,7) NOT NULL,
  `lng` double(11,7) NOT NULL,
  `address` tinytext,
  `saved_name` varchar(200) DEFAULT NULL,
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
  `location_id` bigint(20) NOT NULL,
  `geo_date` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`object_name`,`object_id`,`location_id`),
  KEY `object_name` (`object_name`,`object_id`),
  KEY `object_date_key` (`object_name`,`geo_date`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;



--
-- Dumping data for table `wp_posts`
--

INSERT INTO `wp_posts` (`ID`, `post_author`, `post_date`, `post_date_gmt`, `post_content`, `post_title`, `post_excerpt`, `post_status`, `comment_status`, `ping_status`, `post_password`, `post_name`, `to_ping`, `pinged`, `post_modified`, `post_modified_gmt`, `post_content_filtered`, `post_parent`, `guid`, `menu_order`, `post_type`, `post_mime_type`, `comment_count`) VALUES
(265970368, 1, '2012-11-10 12:41:58 ', '2012-11-10 12:41:58 ', '<br/><br/>[geo_mashup_map zoom=16]<br/><br/>Data from OpenStreetMap. Data from OpenStreetMap. &copy; OpenStreetMap contributors. OpenStreetMap is <i>open data</i>, licensed under the <a href="http://opendatacommons.org/licenses/odbl/">Open Data Commons Open Database License</a> (ODbL)<br/><br/>Last updated:2012-11-10 12:41:58 ', '乃木', '', 'publish', 'open', 'open', '', '%E4%B9%83%E6%9C%A8-265970368', '', '', '2012-11-10 12:41:58 ', '2012-11-10 12:41:58 ', '', 0, 'http://www.opendawn.com/test/geo1/2012/11/10/%E4%B9%83%E6%9C%A8-265970368/', 0, 'post', '', 0),
(265970626, 1, '2012-11-10 12:42:15 ', '2012-11-10 12:42:15 ', '<br/><br/>[geo_mashup_map zoom=16]<br/><br/>Data from OpenStreetMap. Data from OpenStreetMap. &copy; OpenStreetMap contributors. OpenStreetMap is <i>open data</i>, licensed under the <a href="http://opendatacommons.org/licenses/odbl/">Open Data Commons Open Database License</a> (ODbL)<br/><br/>Last updated:2012-11-10 12:42:15 ', '松江 (Matsue)', '', 'publish', 'open', 'open', '', '%E6%9D%BE%E6%B1%9F-(matsue)-265970626', '', '', '2012-11-10 12:42:15 ', '2012-11-10 12:42:15 ', '', 0, 'http://www.opendawn.com/test/geo1/2012/11/10/%E6%9D%BE%E6%B1%9F-(matsue)-265970626/', 0, 'post', '', 0),
(299002445, 1, '2012-09-15 07:59:28 ', '2012-09-15 07:59:28 ', '<br/><br/>[geo_mashup_map zoom=16]<br/><br/>Data from OpenStreetMap. Data from OpenStreetMap. &copy; OpenStreetMap contributors. OpenStreetMap is <i>open data</i>, licensed under the <a href="http://opendatacommons.org/licenses/odbl/">Open Data Commons Open Database License</a> (ODbL)<br/><br/>Last updated:2012-09-15 07:59:28 ', '大橋南詰', '', 'publish', 'open', 'open', '', '%E5%A4%A7%E6%A9%8B%E5%8D%97%E8%A9%B0-299002445', '', '', '2012-09-15 07:59:28 ', '2012-09-15 07:59:28 ', '', 0, 'http://www.opendawn.com/test/geo1/2012/09/15/%E5%A4%A7%E6%A9%8B%E5%8D%97%E8%A9%B0-299002445/', 0, 'post', '', 0),
(335654738, 1, '2012-11-10 12:42:15 ', '2012-11-10 12:42:15 ', '<br/><br/>[geo_mashup_map zoom=16]<br/><br/>Data from OpenStreetMap. Data from OpenStreetMap. &copy; OpenStreetMap contributors. OpenStreetMap is <i>open data</i>, licensed under the <a href="http://opendatacommons.org/licenses/odbl/">Open Data Commons Open Database License</a> (ODbL)<br/><br/>Last updated:2012-11-10 12:42:15 ', '松江イングリッシュガーデン前', '', 'publish', 'open', 'open', '', '%E6%9D%BE%E6%B1%9F%E3%82%A4%E3%83%B3%E3%82%B0%E3%83%AA%E3%83%83%E3%82%B7%E3%83%A5%E3%82%AC%E3%83%BC%E3%83%87%E3%83%B3%E5%89%8D-335654738', '', '', '2012-11-10 12:42:15 ', '2012-11-10 12:42:15 ', '', 0, 'http://www.opendawn.com/test/geo1/2012/11/10/%E6%9D%BE%E6%B1%9F%E3%82%A4%E3%83%B3%E3%82%B0%E3%83%AA%E3%83%83%E3%82%B7%E3%83%A5%E3%82%AC%E3%83%BC%E3%83%87%E3%83%B3%E5%89%8D-335654738/', 0, 'post', '', 0),
(335654931, 1, '2012-11-10 12:42:15 ', '2012-11-10 12:42:15 ', '<br/><br/>[geo_mashup_map zoom=16]<br/><br/>Data from OpenStreetMap. Data from OpenStreetMap. &copy; OpenStreetMap contributors. OpenStreetMap is <i>open data</i>, licensed under the <a href="http://opendatacommons.org/licenses/odbl/">Open Data Commons Open Database License</a> (ODbL)<br/><br/>Last updated:2012-11-10 12:42:15 ', '松江しんじ湖温泉', '', 'publish', 'open', 'open', '', '%E6%9D%BE%E6%B1%9F%E3%81%97%E3%82%93%E3%81%98%E6%B9%96%E6%B8%A9%E6%B3%89-335654931', '', '', '2012-11-10 12:42:15 ', '2012-11-10 12:42:15 ', '', 0, 'http://www.opendawn.com/test/geo1/2012/11/10/%E6%9D%BE%E6%B1%9F%E3%81%97%E3%82%93%E3%81%98%E6%B9%96%E6%B8%A9%E6%B3%89-335654931/', 0, 'post', '', 0),
(1006278149, 1, '2012-10-27 18:26:59 ', '2012-10-27 18:26:59 ', '<br/><br/>[geo_mashup_map zoom=16]<br/><br/>Data from OpenStreetMap. Data from OpenStreetMap. &copy; OpenStreetMap contributors. OpenStreetMap is <i>open data</i>, licensed under the <a href="http://opendatacommons.org/licenses/odbl/">Open Data Commons Open Database License</a> (ODbL)<br/><br/>Last updated:2012-10-27 18:26:59 ', 'Lawson', '', 'publish', 'open', 'open', '', 'lawson-1006278149', '', '', '2012-10-27 18:26:59 ', '2012-10-27 18:26:59 ', '', 0, 'http://www.opendawn.com/test/geo1/2012/10/27/lawson-1006278149/', 0, 'post', '', 0),
(1009513807, 1, '2010-11-28 00:27:45 ', '2010-11-28 00:27:45 ', '<br/><br/>[geo_mashup_map zoom=16]<br/><br/>Data from OpenStreetMap. Data from OpenStreetMap. &copy; OpenStreetMap contributors. OpenStreetMap is <i>open data</i>, licensed under the <a href="http://opendatacommons.org/licenses/odbl/">Open Data Commons Open Database License</a> (ODbL)<br/><br/>Last updated:2010-11-28 00:27:45 ', '青柳楼の大灯籠', '', 'publish', 'open', 'open', '', '%E9%9D%92%E6%9F%B3%E6%A5%BC%E3%81%AE%E5%A4%A7%E7%81%AF%E7%B1%A0-1009513807', '', '', '2010-11-28 00:27:45 ', '2010-11-28 00:27:45 ', '', 0, 'http://www.opendawn.com/test/geo1/2010/11/28/%E9%9D%92%E6%9F%B3%E6%A5%BC%E3%81%AE%E5%A4%A7%E7%81%AF%E7%B1%A0-1009513807/', 0, 'post', '', 0),
(1009513814, 1, '2010-11-29 06:50:08 ', '2010-11-29 06:50:08 ', '<br/><br/>[geo_mashup_map zoom=16]<br/><br/>Data from OpenStreetMap. Data from OpenStreetMap. &copy; OpenStreetMap contributors. OpenStreetMap is <i>open data</i>, licensed under the <a href="http://opendatacommons.org/licenses/odbl/">Open Data Commons Open Database License</a> (ODbL)<br/><br/>Last updated:2010-11-29 06:50:08 ', '島根県立美術館', '', 'publish', 'open', 'open', '', '%E5%B3%B6%E6%A0%B9%E7%9C%8C%E7%AB%8B%E7%BE%8E%E8%A1%93%E9%A4%A8-1009513814', '', '', '2010-11-29 06:50:08 ', '2010-11-29 06:50:08 ', '', 0, 'http://www.opendawn.com/test/geo1/2010/11/29/%E5%B3%B6%E6%A0%B9%E7%9C%8C%E7%AB%8B%E7%BE%8E%E8%A1%93%E9%A4%A8-1009513814/', 0, 'post', '', 0),
(1011980184, 1, '2010-11-29 03:49:34 ', '2010-11-29 03:49:34 ', '<br/><br/>[geo_mashup_map zoom=16]<br/><br/>Data from OpenStreetMap. Data from OpenStreetMap. &copy; OpenStreetMap contributors. OpenStreetMap is <i>open data</i>, licensed under the <a href="http://opendatacommons.org/licenses/odbl/">Open Data Commons Open Database License</a> (ODbL)<br/><br/>Last updated:2010-11-29 03:49:34 ', '松江ニューアーバンホテル本館', '', 'publish', 'open', 'open', '', '%E6%9D%BE%E6%B1%9F%E3%83%8B%E3%83%A5%E3%83%BC%E3%82%A2%E3%83%BC%E3%83%90%E3%83%B3%E3%83%9B%E3%83%86%E3%83%AB%E6%9C%AC%E9%A4%A8-1011980184', '', '', '2010-11-29 03:49:34 ', '2010-11-29 03:49:34 ', '', 0, 'http://www.opendawn.com/test/geo1/2010/11/29/%E6%9D%BE%E6%B1%9F%E3%83%8B%E3%83%A5%E3%83%BC%E3%82%A2%E3%83%BC%E3%83%90%E3%83%B3%E3%83%9B%E3%83%86%E3%83%AB%E6%9C%AC%E9%A4%A8-1011980184/', 0, 'post', '', 0),
(1011980186, 1, '2010-11-29 03:49:34 ', '2010-11-29 03:49:34 ', '<br/><br/>[geo_mashup_map zoom=16]<br/><br/>Data from OpenStreetMap. Data from OpenStreetMap. &copy; OpenStreetMap contributors. OpenStreetMap is <i>open data</i>, licensed under the <a href="http://opendatacommons.org/licenses/odbl/">Open Data Commons Open Database License</a> (ODbL)<br/><br/>Last updated:2010-11-29 03:49:34 ', '松江ニューアーバンホテル別館', '', 'publish', 'open', 'open', '', '%E6%9D%BE%E6%B1%9F%E3%83%8B%E3%83%A5%E3%83%BC%E3%82%A2%E3%83%BC%E3%83%90%E3%83%B3%E3%83%9B%E3%83%86%E3%83%AB%E5%88%A5%E9%A4%A8-1011980186', '', '', '2010-11-29 03:49:34 ', '2010-11-29 03:49:34 ', '', 0, 'http://www.opendawn.com/test/geo1/2010/11/29/%E6%9D%BE%E6%B1%9F%E3%83%8B%E3%83%A5%E3%83%BC%E3%82%A2%E3%83%BC%E3%83%90%E3%83%B3%E3%83%9B%E3%83%86%E3%83%AB%E5%88%A5%E9%A4%A8-1011980186/', 0, 'post', '', 0),
(1011980187, 1, '2010-11-29 03:49:35 ', '2010-11-29 03:49:35 ', 'place_of_worship<br/><br/>[geo_mashup_map zoom=16]<br/><br/>Data from OpenStreetMap. Data from OpenStreetMap. &copy; OpenStreetMap contributors. OpenStreetMap is <i>open data</i>, licensed under the <a href="http://opendatacommons.org/licenses/odbl/">Open Data Commons Open Database License</a> (ODbL)<br/><br/>Last updated:2010-11-29 03:49:35 ', '須衛都久神社', '', 'publish', 'open', 'open', '', '%E9%A0%88%E8%A1%9B%E9%83%BD%E4%B9%85%E7%A5%9E%E7%A4%BE-1011980187', '', '', '2010-11-29 03:49:35 ', '2010-11-29 03:49:35 ', '', 0, 'http://www.opendawn.com/test/geo1/2010/11/29/%E9%A0%88%E8%A1%9B%E9%83%BD%E4%B9%85%E7%A5%9E%E7%A4%BE-1011980187/', 0, 'post', '', 0),
(1012028275, 1, '2010-11-29 06:05:59 ', '2010-11-29 06:05:59 ', '<br/><br/>[geo_mashup_map zoom=16]<br/><br/>Data from OpenStreetMap. Data from OpenStreetMap. &copy; OpenStreetMap contributors. OpenStreetMap is <i>open data</i>, licensed under the <a href="http://opendatacommons.org/licenses/odbl/">Open Data Commons Open Database License</a> (ODbL)<br/><br/>Last updated:2010-11-29 06:05:59 ', '小泉八雲記念館', '', 'publish', 'open', 'open', '', '%E5%B0%8F%E6%B3%89%E5%85%AB%E9%9B%B2%E8%A8%98%E5%BF%B5%E9%A4%A8-1012028275', '', '', '2010-11-29 06:05:59 ', '2010-11-29 06:05:59 ', '', 0, 'http://www.opendawn.com/test/geo1/2010/11/29/%E5%B0%8F%E6%B3%89%E5%85%AB%E9%9B%B2%E8%A8%98%E5%BF%B5%E9%A4%A8-1012028275/', 0, 'post', '', 0),
(1012042833, 1, '2010-11-29 06:50:08 ', '2010-11-29 06:50:08 ', 'restaurant<br/><br/>[geo_mashup_map zoom=16]<br/><br/>Data from OpenStreetMap. Data from OpenStreetMap. &copy; OpenStreetMap contributors. OpenStreetMap is <i>open data</i>, licensed under the <a href="http://opendatacommons.org/licenses/odbl/">Open Data Commons Open Database License</a> (ODbL)<br/><br/>Last updated:2010-11-29 06:50:08 ', '隠岐料理鶴丸', '', 'publish', 'open', 'open', '', '%E9%9A%A0%E5%B2%90%E6%96%99%E7%90%86%E9%B6%B4%E4%B8%B8-1012042833', '', '', '2010-11-29 06:50:08 ', '2010-11-29 06:50:08 ', '', 0, 'http://www.opendawn.com/test/geo1/2010/11/29/%E9%9A%A0%E5%B2%90%E6%96%99%E7%90%86%E9%B6%B4%E4%B8%B8-1012042833/', 0, 'post', '', 0),
(1012042834, 1, '2012-10-27 18:26:59 ', '2012-10-27 18:26:59 ', '<br/><br/>[geo_mashup_map zoom=16]<br/><br/>Data from OpenStreetMap. Data from OpenStreetMap. &copy; OpenStreetMap contributors. OpenStreetMap is <i>open data</i>, licensed under the <a href="http://opendatacommons.org/licenses/odbl/">Open Data Commons Open Database License</a> (ODbL)<br/><br/>Last updated:2012-10-27 18:26:59 ', '松江観光案内所', '', 'publish', 'open', 'open', '', '%E6%9D%BE%E6%B1%9F%E8%A6%B3%E5%85%89%E6%A1%88%E5%86%85%E6%89%80-1012042834', '', '', '2012-10-27 18:26:59 ', '2012-10-27 18:26:59 ', '', 0, 'http://www.opendawn.com/test/geo1/2012/10/27/%E6%9D%BE%E6%B1%9F%E8%A6%B3%E5%85%89%E6%A1%88%E5%86%85%E6%89%80-1012042834/', 0, 'post', '', 0),
(1012043015, 1, '2012-09-15 07:59:28 ', '2012-09-15 07:59:28 ', '<br/><br/>[geo_mashup_map zoom=16]<br/><br/>Data from OpenStreetMap. Data from OpenStreetMap. &copy; OpenStreetMap contributors. OpenStreetMap is <i>open data</i>, licensed under the <a href="http://opendatacommons.org/licenses/odbl/">Open Data Commons Open Database License</a> (ODbL)<br/><br/>Last updated:2012-09-15 07:59:28 ', '大橋南詰', '', 'publish', 'open', 'open', '', '%E5%A4%A7%E6%A9%8B%E5%8D%97%E8%A9%B0-1012043015', '', '', '2012-09-15 07:59:28 ', '2012-09-15 07:59:28 ', '', 0, 'http://www.opendawn.com/test/geo1/2012/09/15/%E5%A4%A7%E6%A9%8B%E5%8D%97%E8%A9%B0-1012043015/', 0, 'post', '', 0),
(1022974862, 1, '2010-12-05 16:16:21 ', '2010-12-05 16:16:21 ', 'fast_food<br/><br/>[geo_mashup_map zoom=16]<br/><br/>Data from OpenStreetMap. Data from OpenStreetMap. &copy; OpenStreetMap contributors. OpenStreetMap is <i>open data</i>, licensed under the <a href="http://opendatacommons.org/licenses/odbl/">Open Data Commons Open Database License</a> (ODbL)<br/><br/>Last updated:2010-12-05 16:16:21 ', 'ケンタッキーフライドチキン', '', 'publish', 'open', 'open', '', '%E3%82%B1%E3%83%B3%E3%82%BF%E3%83%83%E3%82%AD%E3%83%BC%E3%83%95%E3%83%A9%E3%82%A4%E3%83%89%E3%83%81%E3%82%AD%E3%83%B3-1022974862', '', '', '2010-12-05 16:16:21 ', '2010-12-05 16:16:21 ', '', 0, 'http://www.opendawn.com/test/geo1/2010/12/05/%E3%82%B1%E3%83%B3%E3%82%BF%E3%83%83%E3%82%AD%E3%83%BC%E3%83%95%E3%83%A9%E3%82%A4%E3%83%89%E3%83%81%E3%82%AD%E3%83%B3-1022974862/', 0, 'post', '', 0),
(1022975588, 1, '2010-12-05 16:16:44 ', '2010-12-05 16:16:44 ', 'fast_food<br/><br/>[geo_mashup_map zoom=16]<br/><br/>Data from OpenStreetMap. Data from OpenStreetMap. &copy; OpenStreetMap contributors. OpenStreetMap is <i>open data</i>, licensed under the <a href="http://opendatacommons.org/licenses/odbl/">Open Data Commons Open Database License</a> (ODbL)<br/><br/>Last updated:2010-12-05 16:16:44 ', 'マクドナルド', '', 'publish', 'open', 'open', '', '%E3%83%9E%E3%82%AF%E3%83%89%E3%83%8A%E3%83%AB%E3%83%89-1022975588', '', '', '2010-12-05 16:16:44 ', '2010-12-05 16:16:44 ', '', 0, 'http://www.opendawn.com/test/geo1/2010/12/05/%E3%83%9E%E3%82%AF%E3%83%89%E3%83%8A%E3%83%AB%E3%83%89-1022975588/', 0, 'post', '', 0),
(1423608016, 1, '2011-09-05 03:02:05 ', '2011-09-05 03:02:05 ', 'kindergarten<br/><br/>[geo_mashup_map zoom=16]<br/><br/>Data from OpenStreetMap. Data from OpenStreetMap. &copy; OpenStreetMap contributors. OpenStreetMap is <i>open data</i>, licensed under the <a href="http://opendatacommons.org/licenses/odbl/">Open Data Commons Open Database License</a> (ODbL)<br/><br/>Last updated:2011-09-05 03:02:05 ', 'しらとり保育所', '', 'publish', 'open', 'open', '', '%E3%81%97%E3%82%89%E3%81%A8%E3%82%8A%E4%BF%9D%E8%82%B2%E6%89%80-1423608016', '', '', '2011-09-05 03:02:05 ', '2011-09-05 03:02:05 ', '', 0, 'http://www.opendawn.com/test/geo1/2011/09/05/%E3%81%97%E3%82%89%E3%81%A8%E3%82%8A%E4%BF%9D%E8%82%B2%E6%89%80-1423608016/', 0, 'post', '', 0),
(1423608018, 1, '2011-09-05 03:02:05 ', '2011-09-05 03:02:05 ', 'kindergarten<br/><br/>[geo_mashup_map zoom=16]<br/><br/>Data from OpenStreetMap. Data from OpenStreetMap. &copy; OpenStreetMap contributors. OpenStreetMap is <i>open data</i>, licensed under the <a href="http://opendatacommons.org/licenses/odbl/">Open Data Commons Open Database License</a> (ODbL)<br/><br/>Last updated:2011-09-05 03:02:05 ', 'しらゆり千鳥保育園', '', 'publish', 'open', 'open', '', '%E3%81%97%E3%82%89%E3%82%86%E3%82%8A%E5%8D%83%E9%B3%A5%E4%BF%9D%E8%82%B2%E5%9C%92-1423608018', '', '', '2011-09-05 03:02:05 ', '2011-09-05 03:02:05 ', '', 0, 'http://www.opendawn.com/test/geo1/2011/09/05/%E3%81%97%E3%82%89%E3%82%86%E3%82%8A%E5%8D%83%E9%B3%A5%E4%BF%9D%E8%82%B2%E5%9C%92-1423608018/', 0, 'post', '', 0),
(1423608037, 1, '2011-09-05 03:02:09 ', '2011-09-05 03:02:09 ', 'kindergarten<br/><br/>[geo_mashup_map zoom=16]<br/><br/>Data from OpenStreetMap. Data from OpenStreetMap. &copy; OpenStreetMap contributors. OpenStreetMap is <i>open data</i>, licensed under the <a href="http://opendatacommons.org/licenses/odbl/">Open Data Commons Open Database License</a> (ODbL)<br/><br/>Last updated:2011-09-05 03:02:09 ', 'たまち保育園', '', 'publish', 'open', 'open', '', '%E3%81%9F%E3%81%BE%E3%81%A1%E4%BF%9D%E8%82%B2%E5%9C%92-1423608037', '', '', '2011-09-05 03:02:09 ', '2011-09-05 03:02:09 ', '', 0, 'http://www.opendawn.com/test/geo1/2011/09/05/%E3%81%9F%E3%81%BE%E3%81%A1%E4%BF%9D%E8%82%B2%E5%9C%92-1423608037/', 0, 'post', '', 0);

--
-- Dumping data for table `wp_geo_mashup_locations`
--

INSERT INTO `wp_geo_mashup_locations` (`id`, `lat`, `lng`, `address`, `saved_name`, `geoname`, `postal_code`, `country_code`, `admin_code`, `sub_admin_code`, `locality_name`) VALUES
(265970368, 35.4461810, 133.0489690, '', '%E4%B9%83%E6%9C%A8-265970368', NULL, '', '', '', NULL, ''),
(265970626, 35.4640692, 133.0638539, '', '%E6%9D%BE%E6%B1%9F-(matsue)-265970626', NULL, '', '', '', NULL, ''),
(299002445, 35.4632143, 133.0533281, '', '%E5%A4%A7%E6%A9%8B%E5%8D%97%E8%A9%B0-299002445', NULL, '', '', '', NULL, ''),
(335654738, 35.4772880, 133.0043820, '', '%E6%9D%BE%E6%B1%9F%E3%82%A4%E3%83%B3%E3%82%B0%E3%83%AA%E3%83%83%E3%82%B7%E3%83%A5%E3%82%AC%E3%83%BC%E3%83%87%E3%83%B3%E5%89%8D-335654738', NULL, '', '', '', NULL, ''),
(335654931, 35.4672070, 133.0458290, '', '%E6%9D%BE%E6%B1%9F%E3%81%97%E3%82%93%E3%81%98%E6%B9%96%E6%B8%A9%E6%B3%89-335654931', NULL, '', '', '', NULL, ''),
(1006278149, 35.4639739, 133.0622638, '', 'lawson-1006278149', NULL, '', '', '', NULL, ''),
(1009513807, 35.4633280, 133.0530520, '', '%E9%9D%92%E6%9F%B3%E6%A5%BC%E3%81%AE%E5%A4%A7%E7%81%AF%E7%B1%A0-1009513807', NULL, '', '', '', NULL, ''),
(1009513814, 35.4599895, 133.0527493, '', '%E5%B3%B6%E6%A0%B9%E7%9C%8C%E7%AB%8B%E7%BE%8E%E8%A1%93%E9%A4%A8-1009513814', NULL, '', '', '', NULL, ''),
(1011980184, 35.4686581, 133.0508621, '', '%E6%9D%BE%E6%B1%9F%E3%83%8B%E3%83%A5%E3%83%BC%E3%82%A2%E3%83%BC%E3%83%90%E3%83%B3%E3%83%9B%E3%83%86%E3%83%AB%E6%9C%AC%E9%A4%A8-1011980184', NULL, '', '', '', NULL, ''),
(1011980186, 35.4687805, 133.0512483, '', '%E6%9D%BE%E6%B1%9F%E3%83%8B%E3%83%A5%E3%83%BC%E3%82%A2%E3%83%BC%E3%83%90%E3%83%B3%E3%83%9B%E3%83%86%E3%83%AB%E5%88%A5%E9%A4%A8-1011980186', NULL, '', '', '', NULL, ''),
(1011980187, 35.4688416, 133.0515916, '', '%E9%A0%88%E8%A1%9B%E9%83%BD%E4%B9%85%E7%A5%9E%E7%A4%BE-1011980187', NULL, '', '', '', NULL, ''),
(1012028275, 35.4792659, 133.0492190, '', '%E5%B0%8F%E6%B3%89%E5%85%AB%E9%9B%B2%E8%A8%98%E5%BF%B5%E9%A4%A8-1012028275', NULL, '', '', '', NULL, ''),
(1012042833, 35.4697721, 133.0561343, '', '%E9%9A%A0%E5%B2%90%E6%96%99%E7%90%86%E9%B6%B4%E4%B8%B8-1012042833', NULL, '', '', '', NULL, ''),
(1012042834, 35.4642739, 133.0635153, '', '%E6%9D%BE%E6%B1%9F%E8%A6%B3%E5%85%89%E6%A1%88%E5%86%85%E6%89%80-1012042834', NULL, '', '', '', NULL, ''),
(1012043015, 35.4632363, 133.0534345, '', '%E5%A4%A7%E6%A9%8B%E5%8D%97%E8%A9%B0-1012043015', NULL, '', '', '', NULL, ''),
(1022974862, 35.4727047, 133.0644089, '', '%E3%82%B1%E3%83%B3%E3%82%BF%E3%83%83%E3%82%AD%E3%83%BC%E3%83%95%E3%83%A9%E3%82%A4%E3%83%89%E3%83%81%E3%82%AD%E3%83%B3-1022974862', NULL, '', '', '', NULL, ''),
(1022975588, 35.4731241, 133.0646879, '', '%E3%83%9E%E3%82%AF%E3%83%89%E3%83%8A%E3%83%AB%E3%83%89-1022975588', NULL, '', '', '', NULL, ''),
(1423608016, 35.4769050, 133.0480570, '', '%E3%81%97%E3%82%89%E3%81%A8%E3%82%8A%E4%BF%9D%E8%82%B2%E6%89%80-1423608016', NULL, '', '', '', NULL, ''),
(1423608018, 35.4764890, 133.0572510, '', '%E3%81%97%E3%82%89%E3%82%86%E3%82%8A%E5%8D%83%E9%B3%A5%E4%BF%9D%E8%82%B2%E5%9C%92-1423608018', NULL, '', '', '', NULL, ''),
(1423608037, 35.4710460, 133.0709720, '', '%E3%81%9F%E3%81%BE%E3%81%A1%E4%BF%9D%E8%82%B2%E5%9C%92-1423608037', NULL, '', '', '', NULL, '');

--
-- Dumping data for table `wp_geo_mashup_location_relationships`
--

INSERT INTO `wp_geo_mashup_location_relationships` (`object_name`, `object_id`, `location_id`, `geo_date`) VALUES
('post', 265970368, 265970368, '2012-11-10 12:41:58 '),
('post', 265970626, 265970626, '2012-11-10 12:42:15 '),
('post', 299002445, 299002445, '2012-09-15 07:59:28 '),
('post', 335654738, 335654738, '2012-11-10 12:42:15 '),
('post', 335654931, 335654931, '2012-11-10 12:42:15 '),
('post', 1006278149, 1006278149, '2012-10-27 18:26:59 '),
('post', 1009513807, 1009513807, '2010-11-28 00:27:45 '),
('post', 1009513814, 1009513814, '2010-11-29 06:50:08 '),
('post', 1011980184, 1011980184, '2010-11-29 03:49:34 '),
('post', 1011980186, 1011980186, '2010-11-29 03:49:34 '),
('post', 1011980187, 1011980187, '2010-11-29 03:49:35 '),
('post', 1012028275, 1012028275, '2010-11-29 06:05:59 '),
('post', 1012042833, 1012042833, '2010-11-29 06:50:08 '),
('post', 1012042834, 1012042834, '2012-10-27 18:26:59 '),
('post', 1012043015, 1012043015, '2012-09-15 07:59:28 '),
('post', 1022974862, 1022974862, '2010-12-05 16:16:21 '),
('post', 1022975588, 1022975588, '2010-12-05 16:16:44 '),
('post', 1423608016, 1423608016, '2011-09-05 03:02:05 '),
('post', 1423608018, 1423608018, '2011-09-05 03:02:05 '),
('post', 1423608037, 1423608037, '2011-09-05 03:02:09 ');

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
