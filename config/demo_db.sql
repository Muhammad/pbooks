CREATE TABLE IF NOT EXISTS  `pb_accounts` (
  `id` int(11) NOT NULL auto_increment,
  `name` text,
  `account_type_id` int(11) NOT NULL default '0',
  `description` text,
  `creation_datetime` timestamp NOT NULL default CURRENT_TIMESTAMP,
  `account_number` int(11) default NULL,
  `parent_account_id` int(11) default NULL,
  `hide` enum('yes','no') default 'no',
  `group_id` tinyint(2) default NULL,
  PRIMARY KEY  (`id`),
  UNIQUE KEY `account_number` (`account_number`)
) ENGINE=InnoDB AUTO_INCREMENT=1 ;


CREATE TABLE IF NOT EXISTS  `pb_accounts_metadata` (
  `meta_id` int(11) NOT NULL auto_increment,
  `account_id` int(11) NOT NULL,
  `meta_key` varchar(255) NOT NULL,
  `meta_value` varchar(255) NOT NULL,
  PRIMARY KEY  (`meta_id`),
  KEY `account_id` (`account_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 ;


CREATE TABLE IF NOT EXISTS  `pb_account_groups` (
  `ID` int(11) NOT NULL auto_increment,
  `name` varchar(255) NOT NULL default 'Undefined',
  `description` varchar(255) NOT NULL default ' ',
  PRIMARY KEY  (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=1 ;


CREATE TABLE IF NOT EXISTS  `pb_account_group_parents` (
  `account_group_id` int(11) NOT NULL default 0,
  `parent_group_id` int(11) NOT NULL default 0,
  UNIQUE KEY `account_group_id` (`account_group_id`,`parent_group_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 ;


CREATE TABLE IF NOT EXISTS  `pb_entries` (
  `entry_id` int(11) NOT NULL auto_increment,
  `entry_datetime` timestamp NOT NULL default CURRENT_TIMESTAMP,
  `memorandum` text,
  `entry_type` enum('adjusting','budget','comparative','external-accountant','standard','passed-adjusting','eliminating','proposed','recurring','reclassifying','simulated','tax','other') NOT NULL default 'standard',
  `status` tinyint(2) default 2,
  `fiscal_period_id` int(11) NOT NULL default 0,
  PRIMARY KEY  (`entry_id`),
  KEY `entry_datetime` (`entry_datetime`)
) ENGINE=InnoDB AUTO_INCREMENT=1 ;

CREATE TABLE IF NOT EXISTS  `pb_entry_amounts` (
  `entry_amount_id` int(11) NOT NULL auto_increment,
  `entry_id` int(11) NOT NULL default '0',
  `entry_type_id` enum('Credit','Debit') default NULL,
  `entry_amount` decimal(10,2) default NULL,
  `account_id` int(11) default NULL,
  `memorandum` varchar(100) NOT NULL,
  PRIMARY KEY  (`entry_amount_id`),
  KEY `pb_entry_amounts_ibfk_1` (`account_id`),
  KEY `entry_index` (`entry_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 ;

CREATE TABLE IF NOT EXISTS  `pb_entry_metadata` (
  `meta_id` int(11) NOT NULL auto_increment,
  `entry_id` int(11) NOT NULL,
  `meta_key` varchar(255) NOT NULL,
  `meta_value` varchar(255) NOT NULL,
  PRIMARY KEY  (`meta_id`),
  KEY `entry_id` (`entry_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 ;


CREATE TABLE IF NOT EXISTS  `pb_general_ledger` (
  `transaction_id` int(11) NOT NULL auto_increment,
  `entry_datetime` timestamp NOT NULL default CURRENT_TIMESTAMP,
  `memorandum` text,
  `entry_amount` decimal(10,2) default NULL,
  `account_id` int(11) NOT NULL default '1002',
  `entry_id` int(11) NOT NULL default '0',
  `entry_amount_id` bigint(20) NOT NULL,
  `fiscal_period_id` int(20) NOT NULL default '0',
  PRIMARY KEY  (`transaction_id`),
  KEY `pb_general_ledger_ibfk_1` (`account_id`),
  KEY `pb_general_ledger_ibfk_2` (`entry_id`),
  KEY `entry_amount_id` (`entry_amount_id`)
)ENGINE=InnoDB AUTO_INCREMENT=1 ;


CREATE TABLE IF NOT EXISTS  `pb_options` (
  `option_id` smallint(11) NOT NULL auto_increment,
  `option_key` varchar(255) NOT NULL default 'untitled',
  `option_value` varchar(255) default NULL,
  `option_type` enum('text','textarea','option','select','checkbox','other') NOT NULL default 'other',
  PRIMARY KEY  (`option_id`)
) ENGINE=MyISAM;

INSERT INTO `pb_options` (`option_key`,`option_value`,`option_type`) VALUES ('pbooks_database_version','e','other');


ALTER TABLE `pb_accounts_metadata`
  ADD CONSTRAINT `pb_accounts_metadata_ibfk_1` FOREIGN KEY (`account_id`) REFERENCES `pb_accounts` (`id`) ON DELETE CASCADE;

ALTER TABLE `pb_account_group_parents`
  ADD CONSTRAINT `pb_account_group_parents_ibfk_1` FOREIGN KEY (`parent_group_id`) REFERENCES `pb_account_groups` (`ID`) ON DELETE CASCADE ON UPDATE NO ACTION,
  ADD CONSTRAINT `pb_account_group_parents_ibfk_2` FOREIGN KEY (`account_group_id`) REFERENCES `pb_account_groups` (`ID`) ON DELETE CASCADE ON UPDATE NO ACTION;

ALTER TABLE `pb_entry_amounts`
  ADD CONSTRAINT `pb_entry_amounts_ibfk_1` FOREIGN KEY (`account_id`) REFERENCES `pb_accounts` (`id`),
  ADD CONSTRAINT `pb_entry_amounts_ibfk_2` FOREIGN KEY (`entry_id`) REFERENCES `pb_entries` (`entry_id`) ON DELETE CASCADE;

ALTER TABLE `pb_entry_metadata`
  ADD CONSTRAINT `pb_entry_metadata_ibfk_1` FOREIGN KEY (`entry_id`) REFERENCES `pb_entries` (`entry_id`) ON DELETE CASCADE ON UPDATE NO ACTION;

ALTER TABLE `pb_general_ledger`
  ADD CONSTRAINT `pb_general_ledger_ibfk_1` FOREIGN KEY (`account_id`) REFERENCES `pb_accounts` (`id`),
  ADD CONSTRAINT `pb_general_ledger_ibfk_2` FOREIGN KEY (`entry_id`) REFERENCES `pb_entries` (`entry_id`) ON DELETE CASCADE;


CREATE TABLE `auth_group` (
  `group_id` int(11) NOT NULL auto_increment,
  `name` char(25) default NULL,
  PRIMARY KEY  (`group_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=6 ;


INSERT INTO `auth_group` (`group_id`, `name`) VALUES 
(1, 'PBooks Admin'),
(4, 'Prodgex Admin'),
(5, 'User Admin');

CREATE TABLE `auth_group_role` (
  `group_id` int(11) default NULL,
  `role_id` int(11) default NULL,
  KEY `role_id` (`role_id`),
  KEY `group_id` (`group_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


INSERT INTO `auth_group_role` (`group_id`, `role_id`) VALUES 
(1, 1001),
(NULL, 1001),
(4, 1002),
(5, 1003);

CREATE TABLE `auth_role` (
  `role_id` int(11) NOT NULL auto_increment,
  `name` varchar(255) NOT NULL default 'Untitled',
  `description` varchar(255) default NULL,
  PRIMARY KEY  (`role_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1004 ;


INSERT INTO `auth_role` (`role_id`, `name`, `description`) VALUES 
(1001, 'pb_admin', NULL),
(1002, 'prodgex', NULL),
(1003, 'user_admin', NULL);

CREATE TABLE `auth_user` (
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
  PRIMARY KEY  (`user_id`),
  KEY `user_login_key` (`user_name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1017 ;


INSERT INTO `auth_user` (`user_id`, `user_name`, `user_password`, `user_nicename`, `email`, `user_url`, `user_registered`, 
`user_activation_key`, `user_status`, `display_name`) VALUES 
(1016, 'demo', '$1$Iw/GCM2A$BNcUnIIawg7wFq9Iw3VA4/', '', 'demo', '', '2007-04-24 13:36:21', '', 0, '');

CREATE TABLE `auth_user_group` (
  `user_id` int(11) NOT NULL default '0',
  `group_id` int(11) NOT NULL default '0',
  UNIQUE KEY `user_group_index` (`user_id`,`group_id`),
  KEY `group_id` (`group_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


INSERT INTO `auth_user_group` (`user_id`, `group_id`) VALUES 
(1000, 1),
(1000, 4),
(1012, 4),
(1000, 5);

INSERT INTO `pb_accounts` (`id`, `name`, `account_type_id`, `description`, `creation_datetime`, `account_number`, `parent_account_id`) VALUES 
(0, 'PLACEHOLDER', 0, 'DO NOT DELETE', '2007-05-30 20:01:03', 0, NULL),
(1010, 'Petty Cash', 10000, '', '2007-04-01 01:01:01', 1010, NULL),
(1020, 'Cash on Hand', 10000, '', '2007-04-01 01:01:01', 1020, NULL),
(1030, 'Cheque Accounts', 10000, '', '2007-04-01 01:01:01', 1030, NULL),
(1040, 'Savings Accounts', 10000, '', '2007-04-01 01:01:01', 1040, NULL),
(1050, 'Payroll Accounts', 10000, '', '2007-04-01 01:01:01', 1050, NULL),
(1070, 'Money Market Investments', 10000, '', '2007-04-01 01:01:01', 1070, NULL),
(1080, 'Short-Term Investments ( less than 90 days)', 10000, '', '2007-04-01 01:01:01', 1080, NULL),
(1090, 'Interest Receivable', 10000, '', '2007-04-01 01:01:01', 1090, NULL),
(1100, 'Accounts Receivable', 10000, '', '2007-04-01 01:01:01', 1100, NULL),
(1150, 'Allowance for Doubtful Accounts', 10000, '', '2007-04-01 01:01:01', 1150, NULL),
(1200, 'Notes Receivable', 10000, '', '2007-04-01 01:01:01', 1200, NULL),
(1250, 'Income Tax Receivable', 10000, '', '2007-04-01 01:01:01', 1250, NULL),
(1300, 'Prepaid Expenses', 10000, '', '2007-04-01 01:01:01', 1300, NULL),
(1400, 'Supplies Inventory', 10000, '', '2007-04-01 01:01:01', 1400, NULL),
(1420, 'Raw Material Inventory', 10000, '', '2007-04-01 01:01:01', 1420, NULL),
(1440, 'Work in Progress Inventory', 10000, '', '2007-04-01 01:01:01', 1440, NULL),
(1460, 'Finished Goods Inventory', 10000, '', '2007-04-01 01:01:01', 1460, NULL),
(1500, 'Land', 10000, '', '2007-04-01 01:01:01', 1500, NULL),
(1550, 'Bonds', 10000, '', '2007-04-01 01:01:01', 1550, NULL),
(1600, 'Buildings', 10000, '', '2007-04-01 01:01:01', 1600, NULL),
(1620, 'Accumulated Depreciation of Buildings', 10000, '', '2007-04-01 01:01:01', 1620, NULL),
(1650, 'Equipment', 10000, '', '2007-04-01 01:01:01', 1650, NULL),
(1670, 'Accumulated Depreciation of Equipment', 10000, '', '2007-04-01 01:01:01', 1670, NULL),
(1700, 'Furniture and Fixtures', 10000, '', '2007-04-01 01:01:01', 1700, NULL),
(1720, 'Office Equipment', 10000, '', '2007-04-01 01:01:01', 1720, NULL),
(1730, 'Accumulated Depreciation of Office Equipment', 10000, '', '2007-04-01 01:01:01', 1730, NULL),
(1740, 'Software', 10000, '', '2007-04-01 01:01:01', 1740, NULL),
(1750, 'Accumulated Depreciation of Software', 10000, '', '2007-04-01 01:01:01', 1750, NULL),
(1760, 'Vehicles', 10000, '', '2007-04-01 01:01:01', 1760, NULL),
(1770, 'Accumulated Depreciation Vehicles', 10000, '', '2007-04-01 01:01:01', 1770, NULL),
(1780, 'Other Depreciable Property', 10000, '', '2007-04-01 01:01:01', 1780, NULL),
(1790, 'Accumulated Depreciation of Other Depreciable Prop', 10000, '', '2007-04-01 01:01:01', 1790, NULL),
(1800, 'Patents', 10000, '', '2007-04-01 01:01:01', 1800, NULL),
(1850, 'Goodwill', 10000, '', '2007-04-01 01:01:01', 1850, NULL),
(1900, 'Future Income Tax Receivable', 10000, '', '2007-04-01 01:01:01', 1900, NULL),
(2010, 'Bank Indedebtedness (overdraft)', 20000, '', '2007-04-01 01:01:01', 2010, NULL),
(2020, 'Retainers or Advances on Work', 20000, '', '2007-04-01 01:01:01', 2020, NULL),
(2050, 'Interest Payable', 20000, '', '2007-04-01 01:01:01', 2050, NULL),
(2100, 'Accounts Payable', 20000, '', '2007-04-01 01:01:01', 2100, NULL),
(2150, 'Goods Received Suspense', 20000, '', '2007-04-01 01:01:01', 2150, NULL),
(2200, 'Short-Term Loan Payable', 20000, '', '2007-04-01 01:01:01', 2200, NULL),
(2230, 'Current Portion of Long-Term Debt Payable', 20000, '', '2007-04-01 01:01:01', 2230, NULL),
(2250, 'Income Tax Payable', 20000, '', '2007-04-01 01:01:01', 2250, NULL),
(2340, 'Payroll Tax Payable', 20000, '', '2007-04-01 01:01:01', 2340, NULL),
(2350, 'Withholding Income Tax Payable', 20000, '', '2007-04-01 01:01:01', 2350, NULL),
(2360, 'Other Taxes Payable', 20000, '', '2007-04-01 01:01:01', 2360, NULL),
(2400, 'Employee Salaries Payable', 20000, '', '2007-04-01 01:01:01', 2400, NULL),
(2410, 'Management Salaries Payable', 20000, '', '2007-04-01 01:01:01', 2410, NULL),
(2420, 'Director / Partner Fees Payable', 20000, '', '2007-04-01 01:01:01', 2420, NULL),
(2450, 'Health Benefits Payable', 20000, '', '2007-04-01 01:01:01', 2450, NULL),
(2460, 'Pension Benefits Payable', 20000, '', '2007-04-01 01:01:01', 2460, NULL),
(2480, 'Employment Insurance Premiums Payable', 20000, '', '2007-04-01 01:01:01', 2480, NULL),
(2500, 'Land Payable', 20000, '', '2007-04-01 01:01:01', 2500, NULL),
(2550, 'Long-Term Bank Loan', 20000, '', '2007-04-01 01:01:01', 2550, NULL),
(2560, 'Notes Payable', 20000, '', '2007-04-01 01:01:01', 2560, NULL),
(2720, 'Office Equipment Payable', 20000, '', '2007-04-01 01:01:01', 2720, NULL),
(2740, 'Vehicle Payable', 20000, '', '2007-04-01 01:01:01', 2740, NULL),
(2760, 'Other Property Payable', 20000, '', '2007-04-01 01:01:01', 2760, NULL),
(2800, 'Shareholder Loans', 20000, '', '2007-04-01 01:01:01', 2800, NULL),
(2900, 'Suspense', 20000, '', '2007-04-01 01:01:01', 2900, NULL),
(3100, 'Capital Stock', 30000, '', '2007-04-01 01:01:01', 3100, NULL),
(3200, 'Capital Surplus / Dividends', 30000, '', '2007-04-01 01:01:01', 3200, NULL),
(3300, 'Dividend Taxes Payable', 30000, '', '2007-04-01 01:01:01', 3300, NULL),
(3400, 'Dividend Taxes Refundable', 30000, '', '2007-04-01 01:01:01', 3400, NULL),
(3500, 'Retained Earnings', 30000, '', '2007-04-01 01:01:01', 3500, NULL),
(4100, 'Product / Service Sales', 40000, '', '2007-04-01 01:01:01', 4100, NULL),
(4200, 'Sales Exchange Gains/Losses', 40000, '', '2007-04-01 01:01:01', 4200, NULL),
(4500, 'Consulting Services', 40000, '', '2007-04-01 01:01:01', 4500, NULL),
(4600, 'Rentals', 40000, '', '2007-04-01 01:01:01', 4600, NULL),
(4700, 'Finance Charge Income', 40000, '', '2007-04-01 01:01:01', 4700, NULL),
(4800, 'Sales Returns and Allowances', 40000, '', '2007-04-01 01:01:01', 4800, NULL),
(4900, 'Sales Discounts', 40000, '', '2007-04-01 01:01:01', 4900, NULL),
(5100, 'Production Expenses', 50000, '', '2007-04-01 01:01:01', 5100, NULL),
(5200, 'Purchases Exchange Gains/Losses', 50000, '', '2007-04-01 01:01:01', 5200, NULL),
(5500, 'Direct Labour Costs', 50000, '', '2007-04-01 01:01:01', 5500, NULL),
(5600, 'Freight Charges', 50000, '', '2007-04-01 01:01:01', 5600, NULL),
(5700, 'Inventory Adjustment', 50000, '', '2007-04-01 01:01:01', 5700, NULL),
(5900, 'Purchase Discounts', 50000, '', '2007-04-01 01:01:01', 5900, NULL),
(6100, 'Advertising', 50000, '', '2007-04-01 01:01:01', 6100, NULL),
(6150, 'Promotion', 50000, '', '2007-04-01 01:01:01', 6150, NULL),
(6200, 'Communications', 50000, '', '2007-04-01 01:01:01', 6200, NULL),
(6250, 'Meeting Expenses', 50000, '', '2007-04-01 01:01:01', 6250, NULL),
(6300, 'Travelling Expenses', 50000, '', '2007-04-01 01:01:01', 6300, NULL),
(6400, 'Delivery Expenses', 50000, '', '2007-04-01 01:01:01', 6400, NULL),
(6590, 'Benefits', 50000, '', '2007-04-01 01:01:01', 6590, NULL),
(6600, 'Other Selling Expenses', 50000, '', '2007-04-01 01:01:01', 6600, NULL),
(6900, 'Professional Services', 50000, '', '2007-04-01 01:01:01', 6900, NULL),
(7040, 'Management Salaries', 50000, '', '2007-04-01 01:01:01', 7040, NULL),
(7050, 'Management Salary deductions', 50000, '', '2007-04-01 01:01:01', 7050, NULL),
(7060, 'Director / Partner Fees', 50000, '', '2007-04-01 01:01:01', 7060, NULL),
(7070, 'Director / Partner Deductions', 50000, '', '2007-04-01 01:01:01', 7070, NULL),
(7080, 'Payroll Tax', 50000, '', '2007-04-01 01:01:01', 7080, NULL),
(7090, 'Benefits', 50000, '', '2007-04-01 01:01:01', 7090, NULL),
(7150, 'Dues and Subscriptions', 50000, '', '2007-04-01 01:01:01', 7150, NULL),
(7200, 'Accounting Fees', 50000, '', '2007-04-01 01:01:01', 7200, NULL),
(7210, 'Audit Fees', 50000, '', '2007-04-01 01:01:01', 7210, NULL),
(7220, 'Banking Fees', 50000, '', '2007-04-01 01:01:01', 7220, NULL),
(7230, 'Credit Card Fees', 50000, '', '2007-04-01 01:01:01', 7230, NULL),
(7240, 'Consulting Fees', 50000, '', '2007-04-01 01:01:01', 7240, NULL),
(7260, 'Legal Fees', 50000, '', '2007-04-01 01:01:01', 7260, NULL),
(7280, 'Other Professional Fees', 50000, '', '2007-04-01 01:01:01', 7280, NULL),
(7300, 'Business Tax', 50000, '', '2007-04-01 01:01:01', 7300, NULL),
(7350, 'Property Tax', 50000, '', '2007-04-01 01:01:01', 7350, NULL),
(7390, 'Corporation Capital Tax', 50000, '', '2007-04-01 01:01:01', 7390, NULL),
(7400, 'Office Rent', 50000, '', '2007-04-01 01:01:01', 7400, NULL),
(7450, 'Equipment Rental', 50000, '', '2007-04-01 01:01:01', 7450, NULL),
(7500, 'Office Supplies', 50000, '', '2007-04-01 01:01:01', 7500, NULL),
(7600, 'Automotive Expenses', 50000, '', '2007-04-01 01:01:01', 7600, NULL),
(7610, 'Communication Expenses', 50000, '', '2007-04-01 01:01:01', 7610, NULL),
(7620, 'Insurance Expenses', 50000, '', '2007-04-01 01:01:01', 7620, NULL),
(7640, 'Miscellaneous Expenses', 50000, '', '2007-04-01 01:01:01', 7640, NULL),
(7650, 'Travel Expenses', 50000, '', '2007-04-01 01:01:01', 7650, NULL),
(7660, 'Utilities', 50000, '', '2007-04-01 01:01:01', 7660, NULL),
(7700, 'Ammortization Expenses', 50000, '', '2007-04-01 01:01:01', 7700, NULL),
(7750, 'Depreciation Expenses', 50000, '', '2007-04-01 01:01:01', 7750, NULL),
(7800, 'Interest Expense', 50000, '', '2007-04-01 01:01:01', 7800, NULL),
(7900, 'Bad Debt Expense', 50000, '', '2007-04-01 01:01:01', 7900, NULL);


