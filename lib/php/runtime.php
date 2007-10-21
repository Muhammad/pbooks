<?php

/*
<!-- *************************************************  -->
<!--	Program: Nexista Example Site  					-->
<!--	Component: runtime.php							-->	
<!--    Copyright 2003-2007, Albert L. Lash, IV         -->
<!--    Savonix Corporation                             -->
<!--    License: LGPL  -->
<!--                                                    -->
<!-- *************************************************  -->
*/

//This is different depending on which web/file.php is called. 
$app_runtime=PROJECT_ROOT.DIRECTORY_SEPARATOR.'apps'.DIRECTORY_SEPARATOR.APP_NAME.DIRECTORY_SEPARATOR.'lib/php'.DIRECTORY_SEPARATOR.'runtime.php';

if(is_file($app_runtime)) { 
    require($app_runtime);
}

//$path = $_SERVER['SCRIPT_NAME'];
$path = "index.php";
$path_prefix = dirname($_SERVER['SCRIPT_NAME']);
//$app_prefix = "acc/".APP_NAME."/";
//$link_prefix = $path."?nid=".$app_prefix;
$link_prefix = $path."?nid=";
$right_now = date('Y-m-d H:i:s');

//$current_user_id = $_SESSION['NX_AUTH']['user_id'];
$current_user_id = 100;
$debug = Config::get('./runtime/debug');

$runtime = array('path_prefix'=>$path_prefix,
                'link_prefix'=>$link_prefix,
                'right_now'=>$right_now,
                'current_user_id'=>$current_user_id,
                'debug'=>$debug);

Flow::add("runtime",$runtime,false);
