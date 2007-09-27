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

`mysqladmin -u $USER -p$PASS CREATE $DATABASE`;

`mysql -u $USER -p$PASS $DATABASE < ./apps/pbooks/data/model/pbooks_data_model.sql`;
`mysql -u $USER -p$PASS $DATABASE < ./apps/pbooks/data/sample_data/auth_pbooks_data.sql`;

`echo "GRANT ALL PRIVILEGES ON pbooks.* TO 'pbooks'@'%' IDENTIFIED BY 'pbooks';" | mysql -u $USER -p$PASS $DATABASE`;


?>

