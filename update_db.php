<?php

/* Use this file to create the initial database, eventually this will move to 
a web based installer.  */

$db_version = rtrim(file_get_contents('config/db_version.txt'));

fwrite(STDOUT,"Current database version is ".$db_version."\n");

/* Copy config/my_db_admin_settings.php.dist to my_db_admin_settings.php and change to your info */
if(!is_file('config/my_db_admin_settings.php')) { 
    echo "Copy config/my_db_admin_settings.php.dist to config/my_db_admin_settings.php and change to your info.\n";
    exit;
} else {  
    include('config/my_db_admin_settings.php');
}

$db_versions_to_update = array('a','b','c','d');

// should get db version first... 

if ($db_version == "a") {
    `echo "ALTER TABLE pb_accounts ADD COLUMN hide enum('off','on') default NULL;" | mysql -u $USER -p$PASS $DATABASE`;
    `echo "ALTER TABLE pb_entries ADD COLUMN status tinyint(2) default 2;" | mysql -u $USER -p$PASS $DATABASE`;
    // UPDATE to "c"
}

if($db_version == "b") { 
    `echo "ALTER TABLE pb_accounts ADD COLUMN group_id tinyint(2) default NULL;" | mysql -u $USER -p$PASS $DATABASE`;
    fwrite(STDOUT,"Database update successful");
}

if($db_version == "c") { 
    fwrite(STDOUT,"Dropping pb_account_parent_groups...\n");
    `echo "DROP TABLE pb_account_parent_groups;" | mysql -u $USER -p$PASS $DATABASE`;
    `echo "DELETE FROM pb_options WHERE option_key='pbooks_database_version';" | mysql -u $USER -p$PASS $DATABASE`; 
    `echo "DELETE FROM pb_accounts WHERE name='PLACEHOLDER';" | mysql -u $USER -p$PASS $DATABASE`; 
    `echo "insert into pb_options ( option_key,option_value) VALUES ('pbooks_database_version','c');" | mysql -u $USER -p$PASS $DATABASE`;
    `echo "d" > config/db_version.txt`;
    fwrite(STDOUT,"Database update successful.\n");
}

if($db_version == "d") {
    fwrite(STDOUT,"Adding fiscal_period_id...\n");
    `echo "ALTER TABLE pb_entries ADD COLUMN fiscal_period_id int(11) default 0;" | mysql -u $USER -p$PASS $DATABASE`;
    `echo "ALTER TABLE pb_general_ledger ADD COLUMN fiscal_period_id int(11) default 0;" | mysql -u $USER -p$PASS $DATABASE`;
    `echo "e" > config/db_version.txt`;
    fwrite(STDOUT,"Database update successful.\n");
}

if(!in_array($db_version,$db_versions_to_update)) { 
    fwrite(STDOUT,"No update required.\n");
}
?>
