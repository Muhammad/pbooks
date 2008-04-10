<?php
/*
Program: PBooks
Component: runtime.php
Copyright: Savonix Corporation
Author: Albert L. Lash, IV
License: Gnu Affero Public License version 3
http://www.gnu.org/licenses

This program is free software; you can redistribute it and/or modify
it under the terms of the GNU Affero General Public License as published by
the Free Software Foundation; either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License
along with this program; if not, see http://www.gnu.org/licenses
or write to the Free Software Foundation,Inc., 51 Franklin Street,
Fifth Floor, Boston, MA 02110-1301  USA

*/

// this is just a quick patch to do a best effort to
// set the page when it is unset

if(isset($_GET['page'])) { 
    if(!$_GET['page'] && !$_POST['page']) { 
        $page_title = Path::get("//_get/params","flow");
        $page_title = str_replace("/","",$page_title);
        Nexista_Flow::add("page",$page_title);
    }
}

/* Default fiscal start */
$default_fiscal_start = Nexista_Config::get("./default_fiscal_start");
if(empty($default_fiscal_start)) { 
    $default_fiscal_start = "01-01";
}
Nexista_Flow::add("fiscal_start",$default_fiscal_start);



// Moved from other runtime: 
$debug = Nexista_Config::get('./runtime/debug');
$top_left_logo = "s/images/pbooks-logo_120x60.png";

# This wacky path builder is required due to mod_rewrite situations
$path = $_SERVER['REQUEST_URI'];
Nexista_Flow::add("request_uri",$path);
$path = dirname($path)."/".basename($_SERVER['SCRIPT_NAME']);
$path_prefix = dirname($path)."/";
$link_prefix = $path."?nid=";
$utcdate = gmdate('Y-m-d H:i:s');


$db_version = rtrim(file_get_contents(PROJECT_ROOT.DIRECTORY_SEPARATOR.'config/db_version.txt'));

$runtime = array('host_name' => $_SERVER['SERVER_NAME'],
                'path_prefix' => $path_prefix,
                'link_prefix' => $link_prefix,
                'right_now' => $utcdate,
                'utcdate' => $utcdate,
                'current_user_id' => $current_user_id,
                'debug' => $debug,
                'top_left_logo' => $top_left_logo,
                'db_version' => $db_version);

Nexista_Flow::add("runtime",$runtime,false);


$default_selected_lang = Nexista_Config::get("./defaults/default_selected_lang");
if(empty($default_selected_lang)) { 
    $default_selected_lang = "en_US";
}
Nexista_Flow::add("selected_lang",$default_selected_lang);

$default_theme = Nexista_Config::get("./defaults/default_theme");
if(empty($default_theme)) { 
    $default_theme = "default";
}
Nexista_Flow::add("theme",$default_theme);

$default_icon_set = Nexista_Config::get("./defaults/default_icon_set");
if(empty($default_icon_set)) { 
    $default_icon_set = "images/icons/famfamfam/";
}
Nexista_Flow::add("icon_set",$default_icon_set);




/* 
 * TODO What follows needs a major cleanup! Low priority though.
 * Not posting anymore dates. Only using POST method for updating data.
 */
if(isset($_GET['month'])) {
    $from_date = date('Y-m-d',mktime(date('H'), date('i'), date('s'), $_GET['month'], 01, date('Y')));
    $_SESSION['from_date'] = $from_date;
} elseif(isset($_GET['from_date'])) {
    $_SESSION['from_date'] = $_GET['from_date'];
    $from_date = $_GET['from_date'];
} elseif (isset($_SESSION['from_date'])) { 
    $from_date = $_SESSION['from_date'];
} else { 
    $from_date = date('Y-m-d',mktime(date('H'), date('i'), date('s'), date('m')-2, date('d'), date('Y')));
}

Nexista_Flow::add("from_date",$from_date,false);

/*
 * Which date span source should I use? 
 */

if(isset($_GET['month'])) {
    $to_date = date('Y-m-d',mktime(date('H'), date('i'), date('s'), $_GET['month'], 31, date('Y')));
    $_SESSION['to_date'] = $to_date;
} elseif(isset($_GET['to_date'])) {                       // if there is a get date, use it and save it no matter, unless its redoing balances.
    $_SESSION['to_date'] = $_GET['to_date'];
    $to_date = $_GET['to_date'];
} elseif (isset($_SESSION['to_date'])) {            // session date, use it
    $to_date = $_SESSION['to_date'];
} else {                                            // default
    $to_date = date('Y-m-d',mktime(date('H'), date('i'), date('s'), date('m'), date('d')+1, date('Y')));
}

Nexista_Flow::add("to_date",$to_date,false);






$prev_to_date = date('Y-m-d',mktime(0,0,0,date("m",strtotime($to_date)),date('d',strtotime($to_date))-7, date('Y',strtotime($to_date))));

$prev_from_date = date('Y-m-d',mktime(0,0,0,date("m",strtotime($from_date)),date('d',strtotime($from_date))-7, date('Y',strtotime($from_date))));

$next_to_date = date('Y-m-d',mktime(0,0,0,date("m",strtotime($to_date)),date('d',strtotime($to_date))+7, date('Y',strtotime($to_date))));

$next_from_date = date('Y-m-d',mktime(0,0,0,date("m",strtotime($from_date)),date('d',strtotime($from_date))+7, date('Y',strtotime($from_date))));

Nexista_Flow::add("prev_to_date",$prev_to_date,false);
Nexista_Flow::add("prev_from_date",$prev_from_date,false);
Nexista_Flow::add("next_to_date",$next_to_date,false);
Nexista_Flow::add("next_from_date",$next_from_date,false);

Nexista_Flow::add("sorting","ASC",false);


if(isset($_GET['show_all_accounts'])) {
    if($_GET['show_all_accounts']=="on") { 
        $_SESSION['show_all_accounts']="on";
    } else {
        unset($_SESSION['show_all_accounts']);
    }
}

if(isset($_SESSION['show_all_accounts'])) { 
    if($_SESSION['show_all_accounts']=="on") { 
        Nexista_Flow::add("show_all_accounts","on",false);
    }
}



?>
