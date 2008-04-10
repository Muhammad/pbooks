<?php
/*
Program: PBooks
Component: invoice_pdf.php
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

$domain = Nexista_Path::get("//domain","flow");
$invoice_id = Nexista_Path::get("//_get/invoice_id","flow");
$invoice_date = Nexista_Path::get("//get_invoice/invoice_issue_date","flow");
$due_date = Nexista_Path::get("//get_invoice/invoice_due_date","flow");
$client = Nexista_Path::get("//get_invoice/name","flow");
$description = Nexista_Path::get("//get_invoice/description","flow");
$price = Nexista_Path::get("//get_invoice/entry_amount","flow");
$project = Nexista_Path::get("//get_invoice/project","flow");


// Switch to using PEAR's File_PDF

require('File/PDF.php');




$pdf = File_PDF::factory(array('orientation' => 'P',
                                'unit' => 'mm',
                                'format' => 'A4'));
$pdf->SetFont('Courier');
$pdf->AddPage();
$pdf->text(180,80,'Invoice');

$invoice_name="invoice_.pdf";
$pdf->Output("/tmp/".$invoice_name);



exit;





?>