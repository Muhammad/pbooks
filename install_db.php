<?php

/* Use this file to create the initial database, eventually this will move to 
a web based installer.

This script is not used with Windows or SQLite. */

/* Copy config/my_db_admin_settings.php.dist to my_db_admin_settings.php and change to your info */
if(!is_file('config/my_db_admin_settings.php')) { 
    echo "Copy config/my_db_admin_settings.php.dist to config/my_db_admin_settings.php and change to your info.\n";
    exit;
} else {  
    include('config/my_db_admin_settings.php');
}

`$MYSQLADMIN -u $ADMIN_USER -p$ADMIN_PASS CREATE $DATABASE`;

`$MYSQLBIN -u $ADMIN_USER -p$ADMIN_PASS $DATABASE < ./apps/pbooks/data/model/pbooks_data_model.sql`;
`$MYSQLBIN -u $ADMIN_USER -p$ADMIN_PASS $DATABASE < ./apps/pbooks/data/sample_data/auth_pbooks_data.sql`;

`echo "GRANT ALL PRIVILEGES ON $DATABASE.* TO '$PBOOKS_USER'@'%' IDENTIFIED BY '$PBOOKS_PASS';" | $MYSQLBIN -u $ADMIN_USER -p$ADMIN_PASS $DATABASE`;


?>

