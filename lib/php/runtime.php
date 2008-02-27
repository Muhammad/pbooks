<?php
/*
Program: Nexista Example Site
Component: runtime.php
Copyright 2003-2007, Albert L. Lash, IV
Savonix Corporation
License: LGPL
*/
    
//This is different depending on which web/file.php is called. 
$app_runtime=PROJECT_ROOT.DIRECTORY_SEPARATOR.'apps'.DIRECTORY_SEPARATOR.APP_NAME.DIRECTORY_SEPARATOR.'lib/php'.DIRECTORY_SEPARATOR.'runtime.php';

if(is_file($app_runtime)) { 
    require($app_runtime);
}


// This file can probably be removed at some point. 
