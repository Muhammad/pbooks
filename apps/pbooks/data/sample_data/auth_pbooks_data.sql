SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";

-- 
-- Database: `database`
-- 

-- --------------------------------------------------------

-- 
-- Table structure for table `auth_group`
-- 

CREATE TABLE IF NOT EXISTS `auth_group` (
  `group_id` int(11) NOT NULL auto_increment,
  `name` char(25) default NULL,
  PRIMARY KEY  (`group_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=6 ;

-- 
-- Dumping data for table `auth_group`
-- 

INSERT INTO `auth_group` (`group_id`, `name`) VALUES 
(1, 'PBooks Admin'),
(5, 'User Admin');

-- --------------------------------------------------------

-- 
-- Table structure for table `auth_group_role`
-- 

CREATE TABLE IF NOT EXISTS `auth_group_role` (
  `group_id` int(11) default NULL,
  `role_id` int(11) default NULL,
  KEY `role_id` (`role_id`),
  KEY `group_id` (`group_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- 
-- Dumping data for table `auth_group_role`
-- 

INSERT INTO `auth_group_role` (`group_id`, `role_id`) VALUES 
(1, 1001),
(5, 1004),
(5, 1003);

-- --------------------------------------------------------

-- 
-- Table structure for table `auth_role`
-- 

CREATE TABLE IF NOT EXISTS `auth_role` (
  `role_id` int(11) NOT NULL auto_increment,
  `name` varchar(255) NOT NULL default 'Untitled',
  `description` varchar(255) default NULL,
  PRIMARY KEY  (`role_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=1005 ;

-- 
-- Dumping data for table `auth_role`
-- 

INSERT INTO `auth_role` (`role_id`, `name`, `description`) VALUES 
(1001, 'pb_admin', NULL),
(1003, 'user_admin', NULL),
(1004, 'user', NULL);

-- --------------------------------------------------------

-- 
-- Table structure for table `auth_user`
-- 

CREATE TABLE IF NOT EXISTS `auth_user` (
  `user_id` int(11) NOT NULL auto_increment,
  `user_name` varchar(60) NOT NULL default '',
  `user_password` varchar(64) NOT NULL default '',
  `user_nicename` varchar(50) NOT NULL default '',
  `email` varchar(100) NOT NULL default '',
  `user_url` varchar(100) NOT NULL default '',
  `user_registered` timestamp NOT NULL default CURRENT_TIMESTAMP,
  `user_activation_key` varchar(60) NOT NULL default '',
  `user_status` int(11) NOT NULL default '0',
  `display_name` varchar(250) NOT NULL default '',
  PRIMARY KEY  (`user_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=1017 ;

-- 
-- Dumping data for table `auth_user`
-- 

INSERT INTO `auth_user` (`user_id`, `user_name`, `user_password`, `user_nicename`, `email`, `user_url`, `user_registered`, `user_activation_key`, `user_status`, `display_name`) VALUES 
(1016, 'demo', '$1$Iw/GCM2A$BNcUnIIawg7wFq9Iw3VA4/', '', 'demo', '', '2007-04-24 13:36:21', '', 0, '');

-- --------------------------------------------------------

-- 
-- Table structure for table `auth_user_group`
-- 

CREATE TABLE IF NOT EXISTS `auth_user_group` (
  `user_id` int(11) NOT NULL default '0',
  `group_id` int(11) NOT NULL default '0',
  UNIQUE KEY `user_group_index` (`user_id`,`group_id`),
  KEY `group_id` (`group_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- 
-- Dumping data for table `auth_user_group`
-- 

INSERT INTO `auth_user_group` (`user_id`, `group_id`) VALUES 
(1016, 1),
(1016, 5);

-- 
-- Constraints for dumped tables
-- 

-- 
-- Constraints for table `auth_group_role`
-- 
ALTER TABLE `auth_group_role`
  ADD CONSTRAINT `auth_group_role_ibfk_1` FOREIGN KEY (`role_id`) REFERENCES `auth_role` (`role_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `auth_group_role_ibfk_2` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`group_id`) ON DELETE CASCADE;

-- 
-- Constraints for table `auth_user_group`
-- 
ALTER TABLE `auth_user_group`
  ADD CONSTRAINT `auth_user_group_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`user_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `auth_user_group_ibfk_2` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`group_id`) ON DELETE CASCADE;

