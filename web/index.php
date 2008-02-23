<?php

// Configuration 
// Where is nexista? This path should be to a folder which contains a folder called "nexista"
$nexista_path = "/usr/share/php/nexista2/";


$server_name = $_SERVER['SERVER_NAME'];
define('SERVER_NAME',$server_name);
$project_root = dirname(dirname(__FILE__));
define('PROJECT_ROOT',$project_root);
define('PROJECT_NAME','pbooks');
define('APP_NAME','pbooks');

$server_init = PROJECT_ROOT."/cache/".SERVER_NAME."/".APP_NAME."/".APP_NAME.".php";


    
    
    

if(!include(PROJECT_ROOT.'/lib/php/builder.php')) {
    echo "Error: Unable to load server loader or builder.";
    exit;
}




// Loader not there or manually getting rebuilt? Build it!
if(!file_exists($server_init) || isset($_GET['nxbin'])) {
    build_it_now();
} else { // Loader is there, check freshness, then either rebuild or include it.
    check_freshness();
        include($server_init);
        exit;
}

