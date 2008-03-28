
CREATE TABLE pb_accounts (
  id INTEGER PRIMARY KEY,
  name text,
  account_type_id INTEGER,
  description text,
  creation_datetime text,
  account_number INTEGER,
  parent_account_id INTEGER,
  hide text,
  group_id INTEGER
) 

CREATE TABLE pb_accounts_metadata (
  meta_id INTEGER PRIMARY KEY,
  account_id INTEGER,
  meta_key text,
  meta_value text
) ;


CREATE TABLE pb_account_groups (
  ID INTEGER auto_increment,
  name text,
  description text,
  PRIMARY KEY  (ID)
) ;


CREATE TABLE pb_account_group_parents (
  account_group_id INTEGER,
  parent_group_id INTEGER
) ;



CREATE TABLE pb_entries (
  entry_id INTEGER PRIMARY KEY,
  entry_datetime text,
  memorandum text,
  entry_type text,
  status INTEGER,
  fiscal_period_id INTEGER
) ;

CREATE TABLE pb_entry_amounts (
  entry_amount_id INTEGER PRIMARY KEY,
  entry_id INTEGER,
  entry_type_id text,
  entry_amount text,
  account_id INTEGER,
  memorandum text
) ;


CREATE TABLE pb_entry_metadata (
  meta_id INTEGER PRIMARY KEY,
  entry_id INTEGER,
  meta_key text,
  meta_value text
) ;


CREATE TABLE pb_general_ledger (
  transaction_id INTEGER PRIMARY KEY,
  entry_datetime text,
  memorandum text,
  entry_amount text,
  account_id INTEGER,
  entry_id INTEGER,
  entry_amount_id INTEGER,
  fiscal_period_id INTEGER
) ;


CREATE TABLE pb_options (
  option_id INTEGER PRIMARY KEY,
  option_key text,
  option_value text,
  option_type  text
) ;
