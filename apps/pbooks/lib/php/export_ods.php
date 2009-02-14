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

$sh_content = <<<EOF
<?xml version="1.0" encoding="UTF-8"?>
<office:document-content xmlns:office="urn:oasis:names:tc:opendocument:xmlns:office:1.0" xmlns:style="urn:oasis:names:tc:opendocument:xmlns:style:1.0" xmlns:text="urn:oasis:names:tc:opendocument:xmlns:text:1.0" xmlns:table="urn:oasis:names:tc:opendocument:xmlns:table:1.0" xmlns:meta="urn:oasis:names:tc:opendocument:xmlns:meta:1.0" xmlns:number="urn:oasis:names:tc:opendocument:xmlns:datastyle:1.0" office:version="1.1">
  <office:body>
    <office:spreadsheet>
      <table:table table:name="Sheet1">
        <table:table-row table:style-name="ro1">
          <table:table-cell office:value-type="string">
            <text:p>zxs333</text:p>
          </table:table-cell>
        </table:table-row>
      </table:table>
      <table:table table:name="Sheet2">
        <table:table-row table:style-name="ro1">
          <table:table-cell office:value-type="string">
            <text:p>abc222</text:p>
          </table:table-cell>
        </table:table-row>
      </table:table>
    </office:spreadsheet>
  </office:body>
</office:document-content>
EOF;

$manifest = <<<EOF
<?xml version="1.0" encoding="UTF-8"?>
<manifest:manifest xmlns:manifest="urn:oasis:names:tc:opendocument:xmlns:manifest:1.0">
 <manifest:file-entry manifest:media-type="application/vnd.oasis.opendocument.spreadsheet" manifest:full-path="/"/>
 <manifest:file-entry manifest:media-type="text/xml" manifest:full-path="content.xml"/>
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
    header('Content-Description: File Download');
    header('Content-Type: application/octet-stream');
    header('Content-Disposition: attachment; filename='.basename($tmpzip));
    header('Content-Transfer-Encoding: binary');
    header('Expires: 0');
    header('Cache-Control: must-revalidate, post-check=0, pre-check=0');
    header('Pragma: public');
    header('Content-Length: ' . filesize($tmpzip));
    ob_clean();
    flush();
    readfile($tmpzip);
    unlink($tmpzip);
    exit;
}




?>
