<?php
/* <!--
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
or write to the Free Software Foundation, Inc., 51 Franklin Street,
Fifth Floor, Boston, MA 02110-1301 USA
-->
*/


// Default fiscal start
$default_fiscal_start = Nexista_Config::get('./defaults/default_fiscal_start');
if(empty($default_fiscal_start)) {
    $default_fiscal_start = '01-01';
}

// Moved from other runtime:
$debug   = Nexista_Config::get('./runtime/debug');
$logging = Nexista_Config::get('./runtime/logging');
$logfile = Nexista_Config::get('./runtime/logfile');

$top_left_logo = Nexista_Config::get('./defaults/top_left_logo');;

// This wacky path builder is required due to mod_rewrite situations
$path        = $_SERVER['SCRIPT_NAME'];
$path_prefix = dirname($path).'/';
$link_prefix = $path.'?nid=';


// Deprecate this
$utcdate = gmdate('Y-m-d H:i:s');

$db_version = rtrim(file_get_contents(PROJECT_ROOT.'/config/db_version.txt'));

$default_selected_lang = Nexista_Config::get('./defaults/default_selected_lang');
if(empty($default_selected_lang)) {
    $default_selected_lang = 'en_US';
}

$default_theme = Nexista_Config::get('./defaults/default_theme');
if(empty($default_theme)) {
    $default_theme = 'default';
}
$default_icon_set = Nexista_Config::get('./defaults/default_icon_set');
if(empty($default_icon_set)) {
    $default_icon_set = 's/images/icons/famfamfam/';
}
$default_currency_unit = Nexista_Config::get('./defaults/default_currency_unit');
if(empty($default_currency_unit)) {
    $default_currency_unit = '$';
}

$payment_account_id = Nexista_Config::get('./defaults/payment_account_id');
if(empty($payment_account_id)) {
    $payment_account_id = 0;
}

$default_invoice_print_vertical = Nexista_Config::get('./defaults/default_invoice_print_vertical');
if(empty($default_invoice_print_vertical)) {
    // $default_invoice_print_vertical = '-22'; // Firefox?
    $default_invoice_print_vertical = '6'; // Google Chrome
}

$default_invoice_print_horiz = Nexista_Config::get('./defaults/default_invoice_print_horiz');
if(empty($default_invoice_print_horiz)) {
    // $default_invoice_print_horiz = '0'; // Firefox
    $default_invoice_print_horiz = '10'; // Google Chrome
}


/*
 * TODO What follows needs a major cleanup! Low priority though.
 * Not posting anymore dates. Only using POST method for updating data.
 */

$working_year = date('Y');

if(isset($_GET['month'])) {
    $from_date = date('Y-m-d H:i:s',mktime(0,0,0, $_GET['month'], 01, $working_year));
    $_SESSION['from_date'] = $from_date;
} elseif(isset($_GET['from_date'])) {
    $_SESSION['from_date'] = $_GET['from_date'];
    $from_date = $_GET['from_date'];
} elseif (isset($_SESSION['from_date'])) {
    $from_date = $_SESSION['from_date'];
} else {
    $from_date = date('Y-m-d H:i:s',mktime(0,0,0, date('m')-2, date('d'), date('Y')));
}

/*
 * Which date span source should I use?
 */

if(isset($_GET['month'])) {
    $to_date = date('Y-m-d H:i:s',mktime(23, 59, 59, $_GET['month'], 31, $working_year));
    $_SESSION['to_date'] = $to_date.' 23:59:59';
} elseif(isset($_GET['to_date'])) {                       // if there is a get date, use it and save it no matter, unless its redoing balances.
    $_SESSION['to_date'] = $_GET['to_date'].' 23:59:59';
    $to_date = $_GET['to_date'].' 23:59:59';
} elseif (isset($_SESSION['to_date'])) {            // session date, use it
    $to_date = $_SESSION['to_date'].' 23:59:59';
} else {                                            // default
    $to_date = date('Y-m-d H:i:s',mktime(23, 59, 59, date('m'), date('d')+1, date('Y')));
}


$prev_to_date = date('Y-m-d H:i:s',mktime(23, 59, 59,date("m",strtotime($to_date)),date('d',strtotime($to_date))-7, date('Y',strtotime($to_date))));

$prev_from_date = date('Y-m-d H:i:s',mktime(0,0,0,date("m",strtotime($from_date)),date('d',strtotime($from_date))-7, date('Y',strtotime($from_date))));

$next_to_date = date('Y-m-d H:i:s',mktime(23, 59, 59,date("m",strtotime($to_date)),date('d',strtotime($to_date))+7, date('Y',strtotime($to_date))));

$next_from_date = date('Y-m-d H:i:s',mktime(0,0,0,date("m",strtotime($from_date)),date('d',strtotime($from_date))+7, date('Y',strtotime($from_date))));


if($_GET['nid']=='x-ledger-export-txt') {
    $from_date = '2007-01-01 00:00:01';
    $to_date   = '2007-12-31 23:59:59';
}

if(isset($_GET['show_all_accounts'])) {
    if($_GET['show_all_accounts']=='on') {
        $_SESSION['show_all_accounts']='on';
    } else {
        unset($_SESSION['show_all_accounts']);
    }
}

// TODO - FIX THIS AT LEAST SO IT DOESN'T USE "nid"
if(isset($_SESSION['show_all_accounts']) || $_GET['nid']=='reports-build') {
    if($_SESSION['show_all_accounts']=='on' || $_GET['nid']=='reports-build') {
        $show_all_accounts = 'on';
    }
}

if(!$_SESSION['company_name'] || $_SESSION['company_name'] == '') {
    $_SESSION['company_name'] = '_';
}

$current_fiscal_period_id = 3;

$auth = &new Nexista_Auth();
$uid = $auth->getSessionData('uid');

$runtime = array(
    'host_name' => $_SERVER['SERVER_NAME'],
    'path_prefix' => $path_prefix,
    'link_prefix' => $link_prefix,
    'utcdate' => $utcdate,
    'uid' => $uid,
    'default_currency_unit' => $default_currency_unit,
    'default_invoice_print_vertical' => $default_invoice_print_vertical,
    'default_invoice_print_horiz' => $default_invoice_print_horiz,
    'debug' => $debug,
    'top_left_logo' => $top_left_logo,
    'db_version' => $db_version,
    'from_date' => $from_date,
    'to_date' => $to_date,
    'prev_to_date' => $prev_to_date,
    'prev_from_date' => $prev_from_date,
    'next_to_date' => $next_to_date,
    'next_from_date' => $next_from_date,
    'sorting' => 'ASC',
    'show_all_accounts' => $show_all_accounts,
    'selected_lang' => $default_selected_lang,
    'theme' => $theme,
    'logging' => $logging,
    'logfile' => $logfile,
    'icon_set' => $default_icon_set,
    'fiscal_start' => $default_fiscal_start,
    'selected_fiscal_period_id' => $_SESSION['fiscal_period_id'],
    'current_fiscal_period_id' => $current_fiscal_period_id, // for invoices, etc.
    'company_name' => $_SESSION['company_name'],
    'books_mode' => $_SESSION['books_mode'],
    'request_uri' => $_SERVER['REQUEST_URI'],
    'payment_account_id' => $payment_account_id,
    );

Nexista_Flow::add('runtime',$runtime,false);


?>
