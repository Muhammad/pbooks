
--
-- Table structure for table `pb_accounts`
--

CREATE TABLE IF NOT EXISTS `pb_accounts` (
  `id` int(11) NOT NULL auto_increment,
  `name` text,
  `account_type_id` int(11) NOT NULL default '0',
  `description` text,
  `creation_datetime` timestamp NOT NULL,
  `account_number` int(11) default NULL,
  `parent_account_id` int(11) default NULL,
  `hide` enum('off','on') default NULL,
  `group_id` tinyint(2) default NULL,
  PRIMARY KEY  (`id`),
  UNIQUE KEY `account_number` (`account_number`)
) TYPE=InnoDB AUTO_INCREMENT=1067 ;

-- --------------------------------------------------------

--
-- Table structure for table `pb_accounts_metadata`
--

CREATE TABLE IF NOT EXISTS `pb_accounts_metadata` (
  `meta_id` int(11) NOT NULL auto_increment,
  `account_id` int(11) NOT NULL,
  `meta_key` varchar(255) NOT NULL,
  `meta_value` varchar(255) NOT NULL,
  PRIMARY KEY  (`meta_id`),
  KEY `account_id` (`account_id`)
) TYPE=InnoDB AUTO_INCREMENT=434 ;

-- --------------------------------------------------------

--
-- Table structure for table `pb_account_groups`
--

CREATE TABLE IF NOT EXISTS `pb_account_groups` (
  `ID` smallint(8) NOT NULL auto_increment,
  `name` varchar(255) NOT NULL default 'Undefined',
  `description` varchar(255) NOT NULL default ' ',
  PRIMARY KEY  (`ID`)
) TYPE=InnoDB AUTO_INCREMENT=11 ;

-- --------------------------------------------------------

--
-- Table structure for table `pb_account_group_parents`
--

CREATE TABLE IF NOT EXISTS `pb_account_group_parents` (
  `account_group_id` smallint(8) NOT NULL default '0',
  `parent_group_id` smallint(8) NOT NULL default '0',
  UNIQUE KEY `account_group_id` (`account_group_id`,`parent_group_id`),
  KEY `pb_account_group_parents_ibfk_1` (`parent_group_id`)
) TYPE=InnoDB;

-- --------------------------------------------------------

--
-- Table structure for table `pb_entries`
--

CREATE TABLE IF NOT EXISTS `pb_entries` (
  `entry_id` int(11) NOT NULL auto_increment,
  `entry_datetime` timestamp NOT NULL,
  `memorandum` text,
  `entry_type` enum('adjusting','budget','comparative','external-accountant','standard','passed-adjusting','eliminating','proposed','recurring','reclassifying','simulated','tax','other') NOT NULL default 'standard',
  `status` tinyint(2) default '2',
  PRIMARY KEY  (`entry_id`),
  KEY `entry_datetime` (`entry_datetime`)
) TYPE=InnoDB AUTO_INCREMENT=2227 ;

-- --------------------------------------------------------

--
-- Table structure for table `pb_entry_amounts`
--

CREATE TABLE IF NOT EXISTS `pb_entry_amounts` (
  `entry_amount_id` bigint(20) NOT NULL auto_increment,
  `entry_id` int(11) NOT NULL default '0',
  `entry_type_id` enum('Credit','Debit') default NULL,
  `entry_amount` decimal(10,2) default NULL,
  `account_id` int(11) default NULL,
  `memorandum` varchar(100) NOT NULL,
  PRIMARY KEY  (`entry_amount_id`),
  KEY `pb_entry_amounts_ibfk_1` (`account_id`),
  KEY `entry_index` (`entry_id`)
) TYPE=InnoDB AUTO_INCREMENT=7789 ;

-- --------------------------------------------------------

--
-- Table structure for table `pb_entry_metadata`
--

CREATE TABLE IF NOT EXISTS `pb_entry_metadata` (
  `meta_id` bigint(20) NOT NULL auto_increment,
  `entry_id` int(11) NOT NULL,
  `meta_key` varchar(255) NOT NULL,
  `meta_value` varchar(255) NOT NULL,
  PRIMARY KEY  (`meta_id`),
  KEY `entry_id` (`entry_id`)
) TYPE=InnoDB AUTO_INCREMENT=328 ;

-- --------------------------------------------------------

--
-- Table structure for table `pb_general_ledger`
--

CREATE TABLE IF NOT EXISTS `pb_general_ledger` (
  `transaction_id` int(11) NOT NULL auto_increment,
  `entry_datetime` timestamp NOT NULL,
  `memorandum` text,
  `entry_amount` decimal(10,2) default NULL,
  `account_id` int(11) NOT NULL default '1002',
  `entry_id` int(11) NOT NULL default '0',
  `entry_amount_id` bigint(20) NOT NULL,
  PRIMARY KEY  (`transaction_id`),
  KEY `pb_general_ledger_ibfk_1` (`account_id`),
  KEY `pb_general_ledger_ibfk_2` (`entry_id`),
  KEY `entry_amount_id` (`entry_amount_id`)
) TYPE=InnoDB AUTO_INCREMENT=4796 ;

-- --------------------------------------------------------

--
-- Table structure for table `pb_options`
--

CREATE TABLE IF NOT EXISTS `pb_options` (
  `option_id` smallint(11) NOT NULL auto_increment,
  `option_key` varchar(255) NOT NULL default 'untitled',
  `option_value` varchar(255) default NULL,
  `option_type` enum('text','textarea','option','select','checkbox','other') NOT NULL default 'other',
  PRIMARY KEY  (`option_id`)
) TYPE=MyISAM  AUTO_INCREMENT=669 ;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `pb_accounts_metadata`
--
ALTER TABLE `pb_accounts_metadata`
  ADD CONSTRAINT `pb_accounts_metadata_ibfk_1` FOREIGN KEY (`account_id`) REFERENCES `pb_accounts` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `pb_account_group_parents`
--
ALTER TABLE `pb_account_group_parents`
  ADD CONSTRAINT `pb_account_group_parents_ibfk_1` FOREIGN KEY (`parent_group_id`) REFERENCES `pb_account_groups` (`ID`) ON DELETE CASCADE ON UPDATE NO ACTION,
  ADD CONSTRAINT `pb_account_group_parents_ibfk_2` FOREIGN KEY (`account_group_id`) REFERENCES `pb_account_groups` (`ID`) ON DELETE CASCADE ON UPDATE NO ACTION;

--
-- Constraints for table `pb_entry_amounts`
--
ALTER TABLE `pb_entry_amounts`
  ADD CONSTRAINT `pb_entry_amounts_ibfk_1` FOREIGN KEY (`account_id`) REFERENCES `pb_accounts` (`id`),
  ADD CONSTRAINT `pb_entry_amounts_ibfk_2` FOREIGN KEY (`entry_id`) REFERENCES `pb_entries` (`entry_id`) ON DELETE CASCADE;

--
-- Constraints for table `pb_entry_metadata`
--
ALTER TABLE `pb_entry_metadata`
  ADD CONSTRAINT `pb_entry_metadata_ibfk_1` FOREIGN KEY (`entry_id`) REFERENCES `pb_entries` (`entry_id`) ON DELETE CASCADE ON UPDATE NO ACTION;

--
-- Constraints for table `pb_general_ledger`
--
ALTER TABLE `pb_general_ledger`
  ADD CONSTRAINT `pb_general_ledger_ibfk_1` FOREIGN KEY (`account_id`) REFERENCES `pb_accounts` (`id`),
  ADD CONSTRAINT `pb_general_ledger_ibfk_2` FOREIGN KEY (`entry_id`) REFERENCES `pb_entries` (`entry_id`) ON DELETE CASCADE;
