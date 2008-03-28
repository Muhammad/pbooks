SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";

-- Table structure for table `pb_accounts`

CREATE TABLE IF NOT EXISTS `pb_accounts` (
  `id` int(11) NOT NULL auto_increment,
  `name` text,
  `account_type_id` int(11) NOT NULL default '0',
  `description` text,
  `creation_datetime` timestamp NOT NULL default CURRENT_TIMESTAMP,
  `account_number` int(11) default NULL,
  `parent_account_id` int(11) default NULL,
  PRIMARY KEY  (`id`),
  UNIQUE KEY `account_number` (`account_number`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=1050 ;


-- Table structure for table `pb_accounts_metadata`

CREATE TABLE IF NOT EXISTS `pb_accounts_metadata` (
  `meta_id` int(11) NOT NULL auto_increment,
  `account_id` int(11) NOT NULL,
  `meta_key` varchar(255) NOT NULL,
  `meta_value` varchar(255) NOT NULL,
  PRIMARY KEY  (`meta_id`),
  KEY `account_id` (`account_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=5 ;

-- Table structure for table `pb_account_groups`

CREATE TABLE IF NOT EXISTS `pb_account_groups` (
  `ID` smallint(8) NOT NULL auto_increment,
  `name` varchar(255) NOT NULL default 'Undefined',
  `description` varchar(255) NOT NULL default ' ',
  PRIMARY KEY  (`ID`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=10 ;

-- Table structure for table `pb_account_group_parents`

CREATE TABLE IF NOT EXISTS `pb_account_group_parents` (
  `account_group_id` smallint(8) NOT NULL default '0',
  `parent_group_id` smallint(8) NOT NULL default '0',
  UNIQUE KEY `account_group_id` (`account_group_id`,`parent_group_id`),
  KEY `pb_account_group_parents_ibfk_1` (`parent_group_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Table structure for table `pb_account_parent_groups`

CREATE TABLE IF NOT EXISTS `pb_account_parent_groups` (
  `account_id` int(11) NOT NULL default '0',
  `group_id` smallint(8) NOT NULL default '0',
  KEY `pb_parent_groups_ibfk_1` (`account_id`),
  KEY `pb_parent_groups_ibfk_2` (`group_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Table structure for table `pb_entries`

CREATE TABLE IF NOT EXISTS `pb_entries` (
  `entry_id` int(11) NOT NULL auto_increment,
  `entry_datetime` timestamp NOT NULL default CURRENT_TIMESTAMP,
  `memorandum` text,
  `entry_type` enum('adjusting','budget','comparative','external-accountant','standard','passed-adjusting','eliminating','proposed','recurring','reclassifying','simulated','tax','other') NOT NULL default 'standard',
  PRIMARY KEY  (`entry_id`),
  KEY `entry_datetime` (`entry_datetime`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=1350 ;

-- Table structure for table `pb_entry_amounts`

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
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=3736 ;

-- Table structure for table `pb_entry_metadata`

CREATE TABLE IF NOT EXISTS `pb_entry_metadata` (
  `meta_id` bigint(20) NOT NULL auto_increment,
  `entry_id` int(11) NOT NULL,
  `meta_key` varchar(255) NOT NULL,
  `meta_value` varchar(255) NOT NULL,
  PRIMARY KEY  (`meta_id`),
  KEY `entry_id` (`entry_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=2 ;

-- Table structure for table `pb_general_ledger`

CREATE TABLE IF NOT EXISTS `pb_general_ledger` (
  `transaction_id` int(11) NOT NULL auto_increment,
  `entry_datetime` timestamp NOT NULL default CURRENT_TIMESTAMP,
  `memorandum` text,
  `entry_amount` decimal(10,2) default NULL,
  `account_id` int(11) NOT NULL default '1002',
  `entry_id` int(11) NOT NULL default '0',
  `entry_amount_id` bigint(20) NOT NULL,
  PRIMARY KEY  (`transaction_id`),
  KEY `pb_general_ledger_ibfk_1` (`account_id`),
  KEY `pb_general_ledger_ibfk_2` (`entry_id`),
  KEY `entry_amount_id` (`entry_amount_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=2176 ;

-- Table structure for table `pb_options`

CREATE TABLE IF NOT EXISTS `pb_options` (
  `option_id` smallint(11) NOT NULL auto_increment,
  `option_key` varchar(255) NOT NULL default 'untitled',
  `option_value` varchar(255) default NULL,
  `option_type` enum('text','textarea','option','select','checkbox','other') NOT NULL default 'other',
  PRIMARY KEY  (`option_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=594 ;

-- Constraints for table `pb_accounts_metadata`
ALTER TABLE `pb_accounts_metadata`
  ADD CONSTRAINT `pb_accounts_metadata_ibfk_1` FOREIGN KEY (`account_id`) REFERENCES `pb_accounts` (`id`) ON DELETE CASCADE;

-- Constraints for table `pb_account_group_parents`
ALTER TABLE `pb_account_group_parents`
  ADD CONSTRAINT `pb_account_group_parents_ibfk_1` FOREIGN KEY (`parent_group_id`) REFERENCES `pb_account_groups` (`ID`) ON DELETE CASCADE ON UPDATE NO ACTION,
  ADD CONSTRAINT `pb_account_group_parents_ibfk_2` FOREIGN KEY (`account_group_id`) REFERENCES `pb_account_groups` (`ID`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- Constraints for table `pb_account_parent_groups`
ALTER TABLE `pb_account_parent_groups`
  ADD CONSTRAINT `pb_parent_groups_ibfk_1` FOREIGN KEY (`account_id`) REFERENCES `pb_accounts` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `pb_parent_groups_ibfk_2` FOREIGN KEY (`group_id`) REFERENCES `pb_account_groups` (`ID`) ON DELETE CASCADE;

-- Constraints for table `pb_entry_amounts`
ALTER TABLE `pb_entry_amounts`
  ADD CONSTRAINT `pb_entry_amounts_ibfk_1` FOREIGN KEY (`account_id`) REFERENCES `pb_accounts` (`id`),
  ADD CONSTRAINT `pb_entry_amounts_ibfk_2` FOREIGN KEY (`entry_id`) REFERENCES `pb_entries` (`entry_id`) ON DELETE CASCADE;

-- Constraints for table `pb_entry_metadata`
ALTER TABLE `pb_entry_metadata`
  ADD CONSTRAINT `pb_entry_metadata_ibfk_1` FOREIGN KEY (`entry_id`) REFERENCES `pb_entries` (`entry_id`) ON DELETE CASCADE ON UPDATE NO ACTION;

-- Constraints for table `pb_general_ledger`
ALTER TABLE `pb_general_ledger`
  ADD CONSTRAINT `pb_general_ledger_ibfk_1` FOREIGN KEY (`account_id`) REFERENCES `pb_accounts` (`id`),
  ADD CONSTRAINT `pb_general_ledger_ibfk_2` FOREIGN KEY (`entry_id`) REFERENCES `pb_entries` (`entry_id`) ON DELETE CASCADE;
  
-- Accounts
INSERT INTO `pb_accounts` (`id`, `name`, `account_type_id`, `description`, `creation_datetime`, `account_number`) VALUES 
(1010, 'Cash', 10000, '', '2007-04-01 01:01:01', 1010),
(1100, 'Accounts Receivable', 10000, '', '2007-04-01 01:01:01', 1100),
(2100, 'Accounts Payable', 20000, '', '2007-04-01 01:01:01', 2100),
(2550, 'Long-Term Bank Loan', 20000, '', '2007-04-01 01:01:01', 2550),
(2560, 'Notes Payable', 20000, '', '2007-04-01 01:01:01', 2560),
(2800, 'Shareholder Loans', 20000, '', '2007-04-01 01:01:01', 2800),
(3100, 'Capital Stock', 30000, '', '2007-04-01 01:01:01', 3100),
(3500, 'Retained Earnings', 30000, '', '2007-04-01 01:01:01', 3500),
(4100,'Product Sales',40000, '', '2007-04-01 01:01:01', 4100),
(4500,'Consulting Services',40000, '', '2007-04-01 01:01:01', 4500),
(5100, 'Production Expenses', 50000, '', '2007-04-01 01:01:01', 5100),
(6100, 'Advertising', 50000, '', '2007-04-01 01:01:01', 6100),
(6150, 'Promotion', 50000, '', '2007-04-01 01:01:01', 6150),
(6200, 'Communications', 50000, '', '2007-04-01 01:01:01', 6200),
(6900, 'Professional Services', 50000, '', '2007-04-01 01:01:01', 6900),
(7500, 'Office Supplies', 50000, '', '2007-04-01 01:01:01', 7500),
(7600, 'Automotive Expenses', 50000, '', '2007-04-01 01:01:01', 7600),
(7610, 'Communication Expenses', 50000, '', '2007-04-01 01:01:01', 7610),
(7620, 'Insurance Expenses', 50000, '', '2007-04-01 01:01:01', 7620),
(7640, 'Miscellaneous Expenses', 50000, '', '2007-04-01 01:01:01', 7640),
(7650, 'Travel Expenses', 50000, '', '2007-04-01 01:01:01', 7650),
(7660, 'Utilities', 50000, '', '2007-04-01 01:01:01', 7660),
(7700, 'Ammortization Expenses', 50000, '', '2007-04-01 01:01:01', 7700),
(7750, 'Depreciation Expenses', 50000, '', '2007-04-01 01:01:01', 7750),
(7800, 'Interest Expense', 50000, '', '2007-04-01 01:01:01', 7800),
(7900, 'Bad Debt Expense', 50000, '', '2007-04-01 01:01:01', 7900);