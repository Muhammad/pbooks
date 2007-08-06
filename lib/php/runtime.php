<?php


//This is different depending on which web/file.php is called. 
$app_runtime=PROJECT_ROOT.DIRECTORY_SEPARATOR.'apps'.DIRECTORY_SEPARATOR.APP_NAME.DIRECTORY_SEPARATOR.'lib/php'.DIRECTORY_SEPARATOR.'runtime.php';

if(is_file($app_runtime)) { 
    require_once($app_runtime);
}

$path = $_SERVER['SCRIPT_NAME'];
$path_prefix = dirname($_SERVER['SCRIPT_NAME']);
//$app_prefix = "acc/".APP_NAME."/";
$link_prefix = $path."?nid=".$app_prefix;

$right_now = date('Y-m-d H:i:s');
$current_user_id = $_SESSION['NX_AUTH']['user_id'];


$runtime = array('path_prefix'=>$path_prefix,
                'link_prefix'=>$link_prefix,
                'right_now'=>$right_now,
                'current_user_id'=>$current_user_id);



Flow::add("runtime",$runtime,false);