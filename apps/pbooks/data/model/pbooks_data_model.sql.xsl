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

CREATE TABLE <xsl:value-of select="//dbe/if_not_exists"/> <xsl:value-of select="//_get/table_prefix"/>pb_accounts (
  id <xsl:value-of select="//dbe/engine_auto_increment"/>,
  name <xsl:value-of select="//dbe/varchar"/>,
  account_type_id <xsl:value-of select="//dbe/integer"/>,
  description <xsl:value-of select="//dbe/varchar"/>,
  creation_datetime timestamp NOT NULL default CURRENT_TIMESTAMP,
  account_number <xsl:value-of select="//dbe/integer"/>,
  parent_account_id <xsl:value-of select="//dbe/integer"/>,
  <xsl:if test="//engine='mysql'">
  hide enum('yes','no') default 'no',
  </xsl:if>
  <xsl:if test="//engine='sqlite'">
  hide text,
  </xsl:if>
  group_id tinyint(2) default NULL
  <xsl:if test="//engine='mysql'">,
  PRIMARY KEY  (id),
  UNIQUE KEY account_number (account_number)
  </xsl:if>
) <xsl:value-of select="//dbe/innodb_engine"/> <xsl:value-of select="//dbe/engine_increment_start"/> ;


CREATE TABLE <xsl:value-of select="//dbe/if_not_exists"/> <xsl:value-of select="//_get/table_prefix"/>pb_accounts_metadata (
  meta_id <xsl:value-of select="//dbe/engine_auto_increment"/>,
  account_id <xsl:value-of select="//dbe/integer"/>,
  meta_key <xsl:value-of select="//dbe/integer"/>,
  meta_value <xsl:value-of select="//dbe/integer"/>
  <xsl:if test="//engine='mysql'">,
  PRIMARY KEY  (meta_id),
  KEY account_id (account_id)
  </xsl:if>
) <xsl:value-of select="//dbe/innodb_engine"/> <xsl:value-of select="//dbe/engine_increment_start"/> ;


CREATE TABLE <xsl:value-of select="//dbe/if_not_exists"/> <xsl:value-of select="//_get/table_prefix"/>pb_account_groups (
  ID <xsl:value-of select="//dbe/engine_auto_increment"/>,
  name <xsl:value-of select="//dbe/varchar"/> default 'Undefined',
  description <xsl:value-of select="//dbe/varchar"/>
  <xsl:if test="//engine='mysql'">,
  PRIMARY KEY  (ID)
  </xsl:if>
) <xsl:value-of select="//dbe/innodb_engine"/> <xsl:value-of select="//dbe/engine_increment_start"/> ;


CREATE TABLE <xsl:value-of select="//dbe/if_not_exists"/> <xsl:value-of select="//_get/table_prefix"/>pb_account_group_parents (
  account_group_id <xsl:value-of select="//dbe/integer"/>,
  parent_group_id <xsl:value-of select="//dbe/integer"/>
  <xsl:if test="//engine='mysql'">,
  UNIQUE KEY account_group_id (account_group_id,parent_group_id)
  </xsl:if>
) <xsl:value-of select="//dbe/innodb_engine"/> <xsl:value-of select="//dbe/engine_increment_start"/> ;


CREATE TABLE <xsl:value-of select="//dbe/if_not_exists"/> <xsl:value-of select="//_get/table_prefix"/>pb_entries (
  entry_id <xsl:value-of select="//dbe/engine_auto_increment"/>,
  entry_datetime timestamp NOT NULL default CURRENT_TIMESTAMP,
  memorandum <xsl:value-of select="//dbe/varchar"/>,
  <xsl:if test="//engine='mysql'">
  entry_type enum('adjusting','budget','comparative','external-accountant','standard','passed-adjusting','eliminating','proposed','recurring','reclassifying','simulated','tax','other') NOT NULL default 'standard',
  </xsl:if>
  <xsl:if test="//engine='sqlite'">
  entry_type text,
  </xsl:if>
  status tinyint(2) default 2,
  fiscal_period_id <xsl:value-of select="//dbe/integer"/>
  <xsl:if test="//engine='mysql'">,
  PRIMARY KEY  (entry_id),
  KEY entry_datetime (entry_datetime)
  </xsl:if>
) <xsl:value-of select="//dbe/innodb_engine"/> <xsl:value-of select="//dbe/engine_increment_start"/> ;

CREATE TABLE <xsl:value-of select="//dbe/if_not_exists"/> <xsl:value-of select="//_get/table_prefix"/>pb_entry_amounts (
  entry_amount_id <xsl:value-of select="//dbe/engine_auto_increment"/>,
  entry_id <xsl:value-of select="//dbe/integer"/>,
  <xsl:if test="//engine='mysql'">
  entry_type_id enum('Credit','Debit') default NULL,
  </xsl:if>
  <xsl:if test="//engine='sqlite'">
  entry_type_id text,
  </xsl:if>
  entry_amount decimal(10,2) default NULL,
  account_id <xsl:value-of select="//dbe/integer"/>,
  memorandum <xsl:value-of select="//dbe/varchar"/>
  <xsl:if test="//engine='mysql'">,
  PRIMARY KEY  (entry_amount_id),
  KEY pb_entry_amounts_ibfk_1 (account_id),
  KEY entry_index (entry_id)
  </xsl:if>
) <xsl:value-of select="//dbe/innodb_engine"/> <xsl:value-of select="//dbe/engine_increment_start"/> ;

CREATE TABLE <xsl:value-of select="//dbe/if_not_exists"/> <xsl:value-of select="//_get/table_prefix"/>pb_entry_metadata (
  meta_id <xsl:value-of select="//dbe/engine_auto_increment"/>,
  entry_id <xsl:value-of select="//dbe/integer"/>,
  meta_key <xsl:value-of select="//dbe/varchar"/>,
  meta_value <xsl:value-of select="//dbe/varchar"/>
  <xsl:if test="//engine='mysql'">,
  PRIMARY KEY  (meta_id),
  KEY entry_id (entry_id)
  </xsl:if>
) <xsl:value-of select="//dbe/innodb_engine"/> <xsl:value-of select="//dbe/engine_increment_start"/> ;


CREATE TABLE <xsl:value-of select="//dbe/if_not_exists"/> <xsl:value-of select="//_get/table_prefix"/>pb_general_ledger (
  transaction_id <xsl:value-of select="//dbe/engine_auto_increment"/>,
  entry_datetime timestamp NOT NULL default CURRENT_TIMESTAMP,
  memorandum <xsl:value-of select="//dbe/varchar"/>,
  entry_amount decimal(10,2) default NULL,
  account_id <xsl:value-of select="//dbe/integer"/> default '1002',
  entry_id <xsl:value-of select="//dbe/integer"/>,
  entry_amount_id <xsl:value-of select="//dbe/integer"/>,
  fiscal_period_id <xsl:value-of select="//dbe/integer"/>
  <xsl:if test="//engine='mysql'">,
  PRIMARY KEY  (transaction_id),
  KEY pb_general_ledger_ibfk_1 (account_id),
  KEY pb_general_ledger_ibfk_2 (entry_id),
  KEY entry_amount_id (entry_amount_id)</xsl:if>
)<xsl:value-of select="//dbe/innodb_engine"/> <xsl:value-of select="//dbe/engine_increment_start"/> ;


CREATE TABLE <xsl:value-of select="//dbe/if_not_exists"/> <xsl:value-of select="//_get/table_prefix"/>pb_options (
  option_id <xsl:value-of select="//dbe/engine_auto_increment"/>,
  option_key <xsl:value-of select="//dbe/varchar"/> default 'untitled',
  option_value <xsl:value-of select="//dbe/varchar"/>,
  <xsl:if test="//engine='mysql'">
  option_type enum('text','textarea','option','select','checkbox','other') NOT NULL default 'other'
  </xsl:if>
  <xsl:if test="//engine='sqlite'">
  option_type text
  </xsl:if>
  <xsl:if test="//engine='mysql'">,PRIMARY KEY  (option_id)</xsl:if>
) <xsl:value-of select="//dbe/myisam_engine"/>;

INSERT INTO <xsl:value-of select="//_get/table_prefix"/>pb_options (option_key,option_value,option_type) VALUES ('pbooks_database_version','e','other');


CREATE TABLE <xsl:value-of select="//dbe/if_not_exists"/> <xsl:value-of select="//_get/table_prefix"/>pb_notes (
  note_id <xsl:value-of select="//dbe/engine_auto_increment"/>,
  user_id <xsl:value-of select="//dbe/integer"/>,
  note_status_id <xsl:value-of select="//dbe/integer"/>,
  note_datetime timestamp NOT NULL default CURRENT_TIMESTAMP,
  note <xsl:value-of select="//dbe/varchar"/>
  <xsl:if test="//engine='mysql'">,PRIMARY KEY  (note_id)</xsl:if>
) <xsl:value-of select="//dbe/myisam_engine"/>;

CREATE TABLE <xsl:value-of select="//dbe/if_not_exists"/> <xsl:value-of select="//_get/table_prefix"/>pb_logs (
  log_id <xsl:value-of select="//dbe/engine_auto_increment"/>,
  user_id <xsl:value-of select="//dbe/integer"/>,
  log_datetime <xsl:value-of select="//dbe/engine_default_timestamp"/>,
  log <xsl:value-of select="//dbe/varchar"/>
  <xsl:if test="//engine='mysql'">,PRIMARY KEY  (log_id)</xsl:if>
) <xsl:value-of select="//dbe/myisam_engine"/>;

INSERT INTO <xsl:value-of select="//_get/table_prefix"/>pb_entries (entry_id, entry_datetime, memorandum, entry_type, status, fiscal_period_id) VALUES
(-1, '2008-12-17 18:05:33', 'PLACEHOLDER', 'standard', 2, 0);

INSERT INTO <xsl:value-of select="//_get/table_prefix"/>pb_entries (entry_id, entry_datetime, memorandum, entry_type, status, fiscal_period_id) VALUES
(0, '2008-12-17 18:05:33', 'PLACEHOLDER', 'standard', 2, 0);

<xsl:if test="//engine='mysql'">
ALTER TABLE <xsl:value-of select="//_get/table_prefix"/>pb_accounts_metadata
  ADD CONSTRAINT pb_accounts_metadata_ibfk_1 FOREIGN KEY (account_id) REFERENCES <xsl:value-of select="//_get/table_prefix"/>pb_accounts (id) ON DELETE CASCADE;

ALTER TABLE <xsl:value-of select="//_get/table_prefix"/>pb_account_group_parents
  ADD CONSTRAINT pb_account_group_parents_ibfk_1 FOREIGN KEY (parent_group_id) REFERENCES <xsl:value-of select="//_get/table_prefix"/>pb_account_groups (ID) ON DELETE CASCADE ON UPDATE NO ACTION,
  ADD CONSTRAINT pb_account_group_parents_ibfk_2 FOREIGN KEY (account_group_id) REFERENCES <xsl:value-of select="//_get/table_prefix"/>pb_account_groups (ID) ON DELETE CASCADE ON UPDATE NO ACTION;

ALTER TABLE <xsl:value-of select="//_get/table_prefix"/>pb_entry_amounts
  ADD CONSTRAINT pb_entry_amounts_ibfk_1 FOREIGN KEY (account_id) REFERENCES <xsl:value-of select="//_get/table_prefix"/>pb_accounts (id),
  ADD CONSTRAINT pb_entry_amounts_ibfk_2 FOREIGN KEY (entry_id) REFERENCES <xsl:value-of select="//_get/table_prefix"/>pb_entries (entry_id) ON DELETE CASCADE;

ALTER TABLE <xsl:value-of select="//_get/table_prefix"/>pb_entry_metadata
  ADD CONSTRAINT pb_entry_metadata_ibfk_1 FOREIGN KEY (entry_id) REFERENCES <xsl:value-of select="//_get/table_prefix"/>pb_entries (entry_id) ON DELETE CASCADE ON UPDATE NO ACTION;

ALTER TABLE <xsl:value-of select="//_get/table_prefix"/>pb_general_ledger
  ADD CONSTRAINT pb_general_ledger_ibfk_1 FOREIGN KEY (account_id) REFERENCES <xsl:value-of select="//_get/table_prefix"/>pb_accounts (id),
  ADD CONSTRAINT pb_general_ledger_ibfk_2 FOREIGN KEY (entry_id) REFERENCES <xsl:value-of select="//_get/table_prefix"/>pb_entries (entry_id) ON DELETE CASCADE;
</xsl:if>
</xsl:template>
</xsl:stylesheet>