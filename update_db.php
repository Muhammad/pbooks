<?php

/* Use this file to create the initial database, eventually this will move to 
a web based installer.  */

$db_version="0.04";

/* Copy config/my_db_admin_settings.php.dist to my_db_admin_settings.php and change to your info */
if(!is_file('config/my_db_admin_settings.php')) { 
    echo "Copy config/my_db_admin_settings.php.dist to config/my_db_settings.php and change to your info.\n";
    exit;
} else {  
    include('config/my_db_admin_settings.php');
}

// should get db version first... 

if ($db_version == "0.00") {
    `echo "ALTER TABLE pb_accounts ADD COLUMN hide enum('off','on') default NULL;" | mysql -u $USER -p$PASS $DATABASE`;

    `echo "ALTER TABLE pb_entries ADD COLUMN status tinyint(2) default 2;" | mysql -u $USER -p$PASS $DATABASE`;
}

if($db_version == "0.03") { 
    `echo "ALTER TABLE pb_accounts ADD COLUMN group_id tinyint(2) default NULL;" | mysql -u $USER -p$PASS $DATABASE`;
    fwrite(STDOUT,"Database update successful");
}

?>

