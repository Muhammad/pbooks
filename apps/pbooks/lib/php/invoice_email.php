<?php
/* <!--
Program: PBooks
Component: invoice_email.php
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


include('Mail.php');
include('Mail/mime.php');

$html = file_get_contents('../../templates/xsl/invoice_print.xsl');

$text = file_get_contents('s/txt_header.txt');
$text .= strip_tags($html);

$crlf = '\n';
$hdrs = array(
          'From'    => '"PBooks Invoices" <invoices@pbooks.org>',
          'Subject' => 'Your Invoice'
      );

$mail_method = 'smtp';

if($mail_method=='smtp') {

    $params = array(
        'host' => '',
        'port' => ''
    );
    $mail =& Mail::factory('smtp',$params);

} elseif($mail_method=='dkimproxy132') {

    $params = array(
        'host' => '',
        'port' => '',
        'localhost' => '',
        'persist' => TRUE
    );
    $mail =& Mail::factory('smtp',$params);

} elseif($mail_method=='mail') {

    $mail =& Mail::factory('mail');

} elseif($mail_method=='sendmail') {

    $params = array(
        'sendmail_path' => '/usr/sbin/sendmail'
    );
    $mail =& Mail::factory('sendmail',$params);

}

$i = 0;
$mydate = date('Ymd');
$fhl = fopen('workfiles/'.$mydate.'_sent.log',"w+");
$start = time();

foreach ($sl as $fan) {

    $mime = new Mail_mime($crlf);

    $myhtml = str_replace('__customer_unsubscribe_key__',$fan['key'],$html);
    $text = strip_tags($myhtml);
    $mime->setTXTBody($text);
    $mime->setHTMLBody($myhtml);
    $body = $mime->get();
    $hdrs = $mime->headers($hdrsa);
    $hdrs['To'] = $fan['email'];
    $mail->send($fan['email'], $hdrs, $body);
    fwrite($fhl, $i.','.$fan['id'].','.time()."\n");
    $i++;
    // 10000 is .01 second
    // 1000000 is 1 second
    usleep(610000);
}
$stop = time();
$total = $stop - $start;
fwrite($fhl, 'Total duration: '.$total);
fclose($fhl);

?>