<?php



/* Use this file to create the initial database, eventually this will move to 
a web based installer.  */

/* Copy config/my_db_admin_settings.php.dist to my_db_admin_settings.php and change to your info */
if(!is_file('config/my_db_settings.php')) { 
    echo "Copy config/my_db_admin_settings.php.dist to config/my_db_settings.php and change to your info.\n";
    exit;
} else {  
    include('config/my_db_admin_settings.php');
}

// should get db version first... 

`echo "ALTER TABLE pb_accounts ADD COLUMN hide enum('off','on') default NULL;" | mysql -u $USER -p$PASS $DATABASE`;


?>

