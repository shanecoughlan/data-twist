-- phpMyAdmin SQL Dump
-- version 3.4.11.1
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Feb 22, 2013 at 06:25 AM
-- Server version: 5.1.66
-- PHP Version: 5.2.17

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `phjrsz_wp6`
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
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1985941793 ;

--
-- Dumping data for table `wp_posts`
--

INSERT INTO `wp_posts` (`ID`, `post_author`, `post_date`, `post_date_gmt`, `post_content`, `post_title`, `post_excerpt`, `post_status`, `comment_status`, `ping_status`, `post_password`, `post_name`, `to_ping`, `pinged`, `post_modified`, `post_modified_gmt`, `post_content_filtered`, `post_parent`, `guid`, `menu_order`, `post_type`, `post_mime_type`, `comment_count`) VALUES
(2, 1, '2013-02-22 14:56:05', '2013-02-22 05:56:05', '[geo_mashup_map]', 'Overview Page', '', 'publish', 'closed', 'closed', '', 'overview-page', '', '', '2013-02-22 14:56:05', '2013-02-22 05:56:05', '', 0, 'http://www.opendawn.com/matsue/?page_id=1985941784', 0, 'page', '', 0),
(1, 1, '2013-02-22 14:58:57', '2013-02-22 05:58:57', 'Welcome to the Data Twist documentation. Here be dragons.\r\n<h2>== Introduction ==</h2>\r\nData Twist is an experimental script family to twist Open Data into new shapes.\r\n\r\nThese scripts are designed to take OpenStreetMap XML data and import it into a\r\ngeo-aware version of Wordpress. This allows information like shops and tourist\r\nlocations to quickly populate directories, at least in theory.\r\n\r\nThe initial focus is on allowing OSM website XML downloads, XAPI pulls and\r\nOsmosis node filters from a database to be converted into SQL files that we can\r\nquickly load into a Wordpress install. There are some dependencies at the\r\nmoment, with the key item being the Geo Mashup plug-in for Wordpress to allow\r\nus to store geo-references with each post.\r\n\r\nData Twist is not a solution for making local directories by itself. It is the\r\nfoundation for doing so via Open Data in the form of a OpenStreetMap''s\r\ndatabase.\r\n\r\nData Twist is a Ruby application. It was originally coded in Spring 2013 by\r\nKana Fukuma and Shane Coughlan over a four day (24 hour) hack session. Our\r\ngoal was to provide proof-of-concept regarding the "twisting" of Open Data\r\ninto new use cases. The idea is that this can help more people do more cool\r\nthings.\r\n<h2>== Dependancies ==</h2>\r\nData Twist has some dependancies.\r\n\r\n(1) A working Ruby installation. We used version 1.9.2p290.\r\n(2) An XML version of the OpenStreetMap data. The ".osm" files will work.\r\n(3) A vanilla Wordpress installation. We used version 3.5.1.\r\n(4) The Geo Mashup plug-in for Wordpress installed. We used version 1.5.2.\r\n\r\nTo protect your sanity while playing with massive amounts of data from\r\nOpenStreetMap you will probably also find Osmosis and OSMembrane useful.\r\n\r\nOsmosis is the Java-based command line tool for manipulating OpenStreetMap\r\ndata. It works very well on its own. We used version 0.41:\r\nhttp://bretth.dev.openstreetmap.org/osmosis-build/osmosis-0.41.tgz\r\nhttp://bretth.dev.openstreetmap.org/osmosis-build/osmosis-0.41.zip\r\nhttp://dev.openstreetmap.de:23457/hudson/job/osmosis-release/6/\r\n\r\nWhen dealing with large data-sets you might need various command-line options\r\nto ensure the process completes. It''s a lot easier to hand over this job to\r\nsomeone else, and that''s where OSMembrane comes it. It calls Osmosis in a\r\nsmart and easy way. We used OSMembrane Build 845:\r\nhttp://code.google.com/p/osmembrane-gui/\r\n<h2>== Known Issues ==</h2>\r\nData Twist has several known issues.\r\n(1) It will probably only work on a vanilla Wordpress installation. This is\r\ndue to the way that we write directly to the Wordpress database both for\r\ncreating new posts and for adding geo-data to Geo Mashup tables. This places\r\nsome limitations on how you can use it.\r\n(2) It will probably only work on single site installations of Wordpress for\r\nmuch the same reasons as point (1). This issue, as with point (1), can be\r\novercome with testing. It''s a code maturity issue.\r\n(3) Data Twist can conflict with Wordpress plug-ins that want to oversee\r\nposts. For example, we encountered errors with getting it to work on a\r\nWordpress installation with WPML. This is a high-priority bug and will be\r\naddress in the next development phase.\r\n(4) Data Twist currently fails when trying to import duplicate OpenStreetMap\r\ndata. For example, if the data has the same ID, it fails.\r\n\r\nDid you find a new issue? Submit a bug:\r\nhttps://github.com/shanecoughlan/data-twist/issues\r\n<h2>== Extracting Big Data ==</h2>\r\nThere are different types of OpenStreetMap data that you can download and use\r\nas the basis of local maps or directories.\r\n\r\nIf you want to download the whole world, you can obtain "the planet" from the\r\nOpenStreetMap project website at this URL:\r\nhttp://planet.openstreetmap.org/planet/\r\n(you want to download planet-latest.osm.bz2)\r\n\r\nYou can also download extracts by continent or country at this URL:\r\nhttp://download.geofabrik.de/openstreetmap/\r\n\r\nWe downloaded some test data for Tokyo city at this URL:\r\nhttp://metro.teczno.com\r\n\r\nHowever, this resource looks even more promising for quick tests:\r\nhttp://download.bbbike.org/osm/\r\n\r\nWe started our testing on simple (and outdate) XML data from Cloudmade:\r\nhttp://downloads.cloudmade.com\r\nThis data is from the OpenStreetMap database, but be aware that supporting its\r\nstructure will not mean you can support imports from most OpenStreetMap\r\nresources. To do that please look at the links above.\r\n\r\nOur second test data-sets were obtained via the OpenStreetMap XAPI. Here is an\r\nexample dataset of 223 public libraries in London, UK that we used:\r\nwget --timeout=0 http://open.mapquestapi.com/xapi/api/0.6/node[amenity=library][bbox=-0.57,51.24,0.31,51.75] -O data.osm\r\n\r\nThis data was useful to help us do basic imports, though when we tried to\r\nscale up to larger datasets using a similar command we ran into database\r\nduplication errors around the entries. This issue is worth expanding on, as\r\nit is something you are likely to find when experimenting too. Learn more here:\r\nhttps://github.com/shanecoughlan/data-twist/issues/5\r\n\r\nAs we proceeded from simple OpenStreetMap XML to more complex sets we decided\r\nto focus on the website export from OpenStreetMap for our test-case setup, and\r\nloaded data from Matsue city, Shimane Prefecture, Japan. This data is lined\r\nup to be our first "demo recipe", and will be complemented by a second\r\n"demo recipe" using Osmosis data in time.\r\n\r\nEssentially the import process filters &lt;nodes&gt; by searching for &lt;tag&gt; with\r\n" k="amenity" v="type" " data inside. We use the "amenity" as a positive hit\r\nand the "type" as an information type listed in the resulting Wordpress post.\r\nWe read the &lt;tag&gt; that contains the name and use this as the title. We also\r\nread the node timestamp and use this both to record a data for the information\r\nand to show a "last updated" note in the relevant post.\r\n<h2>== Usage ==</h2>\r\nYou will notice several different files and directories in our GitHub\r\nrepository. Essentially we are included the proof-of-concept steps that lead\r\nus to the currently-used solution, which will always be located in the root.\r\n\r\nTo use the current root solution as of 19th February 2013, execute a command\r\nwith "ruby output_sql3.rb"\r\n\r\nThis will read "osm-website-central-matsue-min.osm.xml" and use "sql_format.sql"\r\nas a templete to write the output file. At the moment that is called\r\n"o_sql07.sql"\r\n\r\nThere are those who say we don''t think up sexy names for our files. They are\r\nwrong.\r\n\r\nAnyway, load "o_sql07.sql" into your Wordpress MySQL database. Don''t\r\nforget to install Wordpress and the Geo Mashup plug-in first.\r\nThere are three iterations of our experiments in the current repo.\r\n\r\nThe first is simpleXML2XML, where a Ruby script takes simple POI from a\r\nCloudmade download to transform the data into a format that allows import\r\nthrough the Wordpress RSS import feature. This allowed import of items\r\nthat did not have duplicate titles, but ran into issue with the automatic\r\nduplication filter used by Wordpress for RSS import.\r\n\r\nThe second is simpleXML2dbXML, an experiment to push the data directly into\r\na Wordpress MySQL database and avoid any duplication filters. This had\r\nimport errors with phpMyAdmin. Then we found that an export from the same\r\napplication failed to import too, so we decided it''s probably better to\r\nlook for a more flexbile solution.\r\n\r\nThe third iteration is simpleXML2SQL, which allows us to convert the data\r\nfrom OpenStreetMap into a format that can be imported into a Wordpress\r\ndatabase in several ways. It looks like a winner, and Kana included geo\r\nawareness for the Geo Mashup plug-in.\r\n\r\nThe basic usage instructions for the earlier proof-of-concept code is the\r\nsame, but please restrict usage to the test data included in each folder. It''s\r\nunlikely to work elsewhere.\r\n<h2>== Notes ==</h2>\r\nThis project provides a proof-of-concept for twisting OpenStreetMap data\r\ninto new shapes. In our case we are helping people build Open Source\r\ngeo-directories using Open Data (OpenStreetMap) and Open Source (Wordpress) as\r\na foundation.\r\n\r\nTo contact us please use the following addresses. We are always glad to get\r\ninput.\r\n\r\nShane Coughlan &lt;shane@opendawn.com&gt;\r\nKana Fukuma &lt;kana@opendawn.com&gt; (Japanese preferred)', 'About', '', 'publish', 'closed', 'closed', '', 'about', '', '', '2013-02-22 14:58:57', '2013-02-22 05:58:57', '', 0, 'http://www.opendawn.com/matsue/?page_id=1985941786', 0, 'page', '', 0);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
