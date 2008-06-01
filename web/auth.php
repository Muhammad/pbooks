<?php

// Configuration 
// Where is nexista? This path should be to a folder containing the nexista source 
$nexista_path = "/var/www/dev/nexista/";

// Bad hack
if(!strpos($_SERVER['REQUEST_URI'],'.php')) { 
    header("Location: ".$_SERVER['REQUEST_URI']."index.php");
    exit;
}
$server_name = $_SERVER['SERVER_NAME'];
define('SERVER_NAME',$server_name);
$project_root = dirname(dirname(__FILE__));
$project_root = str_replace('\\','/',$project_root);
define('PROJECT_ROOT',$project_root);
define('PROJECT_NAME','pbooks');
define('APP_NAME','auth');

$server_init = PROJECT_ROOT."/cache/".SERVER_NAME."/".APP_NAME."/".APP_NAME.".php";

if(!include($nexista_path.'/extensions/nexista_builder.php')) {
    echo "Error: Unable to load server loader or builder.";
    exit;
}
    




// Loader not there or manually getting rebuilt? Build it!
if(!file_exists($server_init) || isset($_POST['x--dev--rebuild'])) {
    nexista_build_it_now();
} else { // Loader is there, check freshness, then either rebuild or include it.
    nexista_check_freshness();
    include($server_init);
    exit;
}
