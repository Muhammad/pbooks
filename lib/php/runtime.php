<?php

//This is different depending on which web/file.php is called. 
require_once(PROJECT_ROOT.DIRECTORY_SEPARATOR.'apps'.DIRECTORY_SEPARATOR.APP_NAME.DIRECTORY_SEPARATOR.'config'.DIRECTORY_SEPARATOR.'config.php');


$path = $_SERVER['SCRIPT_NAME'];
$path_prefix = dirname($_SERVER['SCRIPT_NAME']);
$app_prefix = "acc/".APP_NAME."/";
$link_prefix = $path."?nid=".$app_prefix;
// URL settings
Flow::add("path_prefix",$path_prefix,false);
Flow::add("link_prefix",$link_prefix,false);



// Date Stuff
Flow::add("right_now",date('Y-m-d H:i:s'),false);
Flow::add("right_then",date('Y-m-d H:i:s', mktime(date('H'), date('i'), date('s')-1, date('m'), date('d'), date('Y'))),false);

// User Stuff
$current_user_id = $_SESSION['NX_AUTH']['user_id'];
Flow::add("current_user_id",$current_user_id,false);





