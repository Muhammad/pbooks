<?php
/* <!--
Program: PBooks
Component: import_accounts_into_pbooks.php
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
Fifth Floor, Boston, MA 02110-1301 USA -->
*/

/* Import accounts into pbooks

For each line of the csv file, a sql statement is made.

*/

$debug='false';
$csv_string = Nexista_Path::get('//_post/csv_accounts_import','flow');
$link_prefix = Nexista_Path::get('//link_prefix','flow');


if(empty($csv_string) || $csv_string=='') {
    header('Location: '.$link_prefix.'accounts-import&error=import-empty');
    exit;
}


if($debug=='true') {
echo '<pre>';
echo $csv_string;
echo '</pre>';
}


// Test these line feeds on different platforms (windows, mac os x, linux)
$data_array = explode('\r\n',$csv_string);
//$data_array = explode('\n',$csv_string);

if($debug=='true') {
echo '<pre>';
print_r($data_array);
echo '</pre>';
}
$i=0;
foreach($data_array as $value) {
    // avoiding errors due to trailing garbage ( like linefeeds )
    if($value!="" && strlen($value) > 5) { 

        // Remove non-delineating commas
        $value = preg_replace('/\"(.+)(,)(.+)\"!\n/', '${1}${3}', $value);
        $csv_row = explode(",",$value);

        if($debug=='true') {
            echo '=====<pre>';
            print_r($cvs_row);
            echo '</pre>';
        }

        if(count($csv_row)=="4") {

            // 4 columns of data - entry_datetime, memorandum, entry_amount, balance
            $final_data_array[] = Array('account_type_id' => $csv_row[0],
                                'account_number' => $csv_row[1],
                                'account_name' => $csv_row[2],
                                'account_description' => $csv_row[3]);

        } else {
            header('Location: '.$link_prefix.
                'accounts-import&error=import-wrong-number-of-rows,'.count($csv_row).','.$csv_row[4]);
            exit;
        }

    }
    $i++;
}
    Nexista_Flow::add('import_csv',$final_data_array);


if($debug=='true') {
echo '<pre>';
print_r($final_data_array);
echo '</pre>';
exit;
}


?>
