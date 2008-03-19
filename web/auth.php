<?php

// Configuration
// Where is nexista? This path should be to a folder containing the nexista source
$nexista_path = "/usr/share/pbooks/nexista/";


$server_name = $_SERVER['SERVER_NAME'];
define('SERVER_NAME',$server_name);
$project_root = dirname(dirname(__FILE__));
$project_root = str_replace('\\','/',$project_root);
define('PROJECT_ROOT',$project_root);
define('PROJECT_NAME','pbooks');
define('APP_NAME','auth');

$server_init = PROJECT_ROOT."/cache/".SERVER_NAME."/".APP_NAME."/".APP_NAME.".php";


if(!include($nexista_path.'/plugins/builder.php')) {
    echo "Error: Unable to load server loader or builder.";
    exit;
}

// Loader not there or manually getting rebuilt? Build it!
if(!file_exists($server_init) || $_GET['nxbin']) {
    build_it_now();
} else { // Loader is there, check freshness, then either rebuild or include it.
    check_freshness();
        include($server_init);
        exit;
}
