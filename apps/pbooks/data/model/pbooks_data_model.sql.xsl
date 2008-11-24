<!--
Program: PBooks
Component: pbooks_data_model.sql.xsl
Copyright: Savonix Corporation
Author: Albert L. Lash, IV
License: Gnu Affero Public License version 3
http://www.gnu.org/licenses

This program is free software; you can redistribute it and/or modify
it under the terms of the GNU Affero General Public License as published by
the Free Software Foundation; either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License
along with this program; if not, see http://www.gnu.org/licenses
or write to the Free Software Foundation, Inc., 51 Franklin Street,
Fifth Floor, Boston, MA 02110-1301 USA
-->
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="text" indent="yes" encoding="UTF-8" omit-xml-declaration="yes"/>
<xsl:template match="/">


<xsl:variable name="engine_default_timestamp">
	<xsl:if test="//engine='mysqli'">
			<xsl:text>CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP</xsl:text>
	</xsl:if>
	<xsl:if test="//engine='sqlite'">
			<xsl:text>NULL</xsl:text>
	</xsl:if>
</xsl:variable>
<xsl:variable name="engine_auto_increment">
	<xsl:if test="//engine='mysqli'">
			<xsl:text>int(11) NOT NULL auto_increment</xsl:text>
	</xsl:if>
	<xsl:if test="//engine='sqlite'">
			<xsl:text> INTEGER PRIMARY KEY</xsl:text>
	</xsl:if>
	<xsl:if test="//engine='postgres'">
			<xsl:text>integer</xsl:text>
	</xsl:if>
</xsl:variable>
<xsl:variable name="engine_increment_start">
	<xsl:if test="//engine='mysqli'">
			<xsl:text>AUTO_INCREMENT=1</xsl:text>
	</xsl:if>
	<xsl:if test="//engine='sqlite'">
			<xsl:text></xsl:text>
	</xsl:if>
	<xsl:if test="//engine='postgres'">
			<xsl:text></xsl:text>
	</xsl:if>
</xsl:variable>




<xsl:variable name="engine_auto_increment_b">
	<xsl:if test="//engine='mysqli'">
			<xsl:text>, PRIMARY KEY (category_id)</xsl:text>
	</xsl:if>
	<xsl:if test="//engine='sqlite'">
			<xsl:text></xsl:text>
	</xsl:if>
</xsl:variable>

<xsl:variable name="innodb_engine">
	<xsl:if test="//engine='mysqli'">
			<xsl:text>ENGINE=InnoDB</xsl:text>
	</xsl:if>
	<xsl:if test="//engine='sqlite' or //engine='postgres'">
			<xsl:text></xsl:text>
	</xsl:if>
</xsl:variable>
<xsl:variable name="myisam_engine">
	<xsl:if test="//engine='mysqli'">
			<xsl:text>ENGINE=MyISAM</xsl:text>
	</xsl:if>
	<xsl:if test="//engine='sqlite' or //engine='postgres'">
			<xsl:text></xsl:text>
	</xsl:if>
</xsl:variable>


<xsl:variable name="if_not_exists">
	<xsl:if test="//engine='mysqli'">
			<xsl:text>IF NOT EXISTS</xsl:text>
	</xsl:if>
	<xsl:if test="//engine='sqlite' or //engine='postgres'">
			<xsl:text></xsl:text>
	</xsl:if>
</xsl:variable>

<xsl:variable name="integer">
	<xsl:if test="//engine='sqlite' or //engine='mysqli'">
			<xsl:text>int(10)</xsl:text>
	</xsl:if>
	<xsl:if test="//engine='postgres'">
			<xsl:text>integer</xsl:text>
	</xsl:if>
</xsl:variable>


CREATE TABLE IF NOT EXISTS `pb_accounts` (
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
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=1050 ;

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
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=5 ;

-- --------------------------------------------------------

-- 
-- Table structure for table `pb_account_groups`
-- 

CREATE TABLE IF NOT EXISTS `pb_account_groups` (
  `ID` smallint(8) NOT NULL auto_increment,
  `name` varchar(255) NOT NULL default 'Undefined',
  `description` varchar(255) NOT NULL default ' ',
  PRIMARY KEY  (`ID`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=10 ;

-- --------------------------------------------------------

-- 
-- Table structure for table `pb_account_group_parents`
-- 

CREATE TABLE IF NOT EXISTS `pb_account_group_parents` (
  `account_group_id` smallint(8) NOT NULL default '0',
  `parent_group_id` smallint(8) NOT NULL default '0',
  UNIQUE KEY `account_group_id` (`account_group_id`,`parent_group_id`),
  KEY `pb_account_group_parents_ibfk_1` (`parent_group_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


-- --------------------------------------------------------

-- 
-- Table structure for table `pb_entries`
-- 

CREATE TABLE IF NOT EXISTS `pb_entries` (
  `entry_id` int(11) NOT NULL auto_increment,
  `entry_datetime` timestamp NOT NULL default CURRENT_TIMESTAMP,
  `memorandum` text,
  `entry_type` enum('adjusting','budget','comparative','external-accountant','standard','passed-adjusting','eliminating','proposed','recurring','reclassifying','simulated','tax','other') NOT NULL default 'standard',
  `status` tinyint(2) default 2,
  `fiscal_period_id` int(20) NOT NULL default '0',
  PRIMARY KEY  (`entry_id`),
  KEY `entry_datetime` (`entry_datetime`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=1350 ;

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
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=3736 ;

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
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=2 ;

-- --------------------------------------------------------

-- 
-- Table structure for table `pb_general_ledger`
-- 

CREATE TABLE IF NOT EXISTS `pb_general_ledger` (
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
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=2176 ;

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
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=594 ;

INSERT INTO `pb_options` (`option_key`,`option_value`,`option_type`) VALUES ('pbooks_database_version','e','other');

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

	</xsl:template>
</xsl:stylesheet>