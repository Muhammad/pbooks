<?php
/* <!--
Program: PBooks
Component: export_ods.php
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
Fifth Floor, Boston, MA 02110-1301  USA -->
*/

$sh_content = Nexista_Path::get('//my_ledger','flow');


$manifest = <<<EOF
<?xml version='1.0' encoding='UTF-8'?>
<manifest:manifest xmlns:manifest='urn:oasis:names:tc:opendocument:xmlns:manifest:1.0'>
 <manifest:file-entry manifest:media-type='application/vnd.oasis.opendocument.spreadsheet' manifest:full-path='/'/>
 <manifest:file-entry manifest:media-type='text/xml' manifest:full-path='content.xml'/>
</manifest:manifest>
EOF;

$tmpzip = '/tmp/test.ods';

$zip = new ZipArchive;
$res = $zip->open($tmpzip, ZipArchive::CREATE);
if ($res === TRUE) {
    $zip->addFromString('content.xml', $sh_content);
    $zip->addEmptyDir('META-INF');
    $zip->addFromString('META-INF/manifest.xml', $manifest);
    $zip->close();
}


if (file_exists($tmpzip)) {
    header('Content-Length: ' . filesize($tmpzip));
    ob_clean();
    flush();
    readfile($tmpzip);
    unlink($tmpzip);
    exit;
}




?>
