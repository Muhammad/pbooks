<!--
Program: PBooks
Component: layout.css.xsl
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
Fifth Floor, Boston, MA 02110-1301 USA
-->
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" >
<xsl:output method="text" indent="yes" encoding="UTF-8" omit-xml-declaration="yes"/>
<xsl:template name="layout">
body, div, dl, dt, dd, ul, ol, li, h1, h2, h3, h4, h5, h6, pre, form, fieldset, input, p, blockquote, th, td {
  margin: 0;
  padding: 0;
}

#main {
  width: 100%;
  text-align: left;
  margin-left: auto;
  margin-right: auto;
}

#primary_logo {
  height: <xsl:value-of select="//header/height"/>;
  text-align: center;
  background-color: white;
  display: block;
}
#primary_logo_span {
  padding: 12px;
}
#company-name {
  float: right;
  margin-right: .4em;
}

#header {
  height: <xsl:value-of select="//header/height"/>;
  letter-spacing: 1px;
  display: block;
  margin-left: <xsl:value-of select="//left_column/width"/>;
}
#leftcol {
  float: left;
  width: <xsl:value-of select="//left_column/width"/>;
  margin: 0;
  min-height: 600px;
}

#content:after{
  clear: both;
  content: ".";
  display: block;
  font-size: 0;
  height: 0;
  line-height: 0.0;
  overflow:hidden;
  visibility: hidden;
}
#content {
  padding: 12px;
  margin-left: <xsl:value-of select="//left_column/width"/>;
}


#company-name {
  text-align: right;
  padding-right: 10px;
  color: #EEE;
  position: relative;
}

#print-button {
  float: right;
  padding: 20px;
  padding-top: 50px;
  color: red;
  position: relative;
}

#footer {
  display: block;
  margin-bottom: 2em;
}

.form-table tr td {
	padding: 5px;
	border-width: 0;
  border-bottom-width: 1px;
  border-style: solid;
}

.generic-button {
  text-align: center;
  margin-left: 5px;
}

.generic-button a {
  padding: 2px 5px 2px 5px;
  border: 2px;
  border-style: solid;
  text-align: center;
}

.generic-button img {
  margin-bottom: -4px;
  margin-right: 6px;
}

a.generic-button {
  padding: 2px 5px 2px 5px;
  border: 2px;
  border-style: solid;
  text-align: center;
}

.menu-sub, .menu-sub-selected {
  align: left;
  padding: 5px;
}



/* tables */

.journal-table tbody tr td {
  height: 24px;
  border-style: solid;
  border-width: 0;
  border-top-width: 1px;
  padding: 2px;
  vertical-align: middle;
}

.simpletable {
  background-color: #222;
  border-collapse: collapse;
}

table.simpletable thead th, table.simpletable tbody tr td {
	background-color: #FFF;
  text-align: left;
  padding: 4px;
  margin: 0px;
  border: 1px;
  border-color: #555;
  border-style: solid;
}

/* Business Objects */
#business_object_slip {
  width: 500px;
  height: 200px;
  border: 1px;
  border-style: solid;
  padding: 5px;
}

/* Check form */
#check_date {
  float: left;
}
#check_number {
  float: right;
}
#check_payee {
  margin-top: 60px;
}
#check_memo {
  margin-top: 80px;
}

/* Deposit slip */
#deposit_date {
  float: left;
}
#deposit_number {
  float: right;
}
#deposit_payee {
  margin-top: 40px;
  float:right;
}
#deposit_memo {
  float:right;
}


/* Payment form */
#payment_date {
  float: right;
}

#payment_payee {
  margin-top: 10px;
}

#payment_memo {
  margin-top: 10px;
}




#journal-entry-form table {
  width: 100%;
  text-align: center;
}

#journal-entry-form tr td {
  text-align: left;
  padding: 5px;
}




#accordion-menu {
	margin:0px;
	padding:0px;
	text-indent:0px;
	background-color:#AAA;
	width:<xsl:value-of select="//left_column/width"/>;
}
#accordion-menu a.head {
	cursor:pointer;
	background: #AAA;
	color:#FFFFFF;
	display:block;
	font-weight:bold;
	margin:0px;
  padding: 5px;
	text-decoration: none;
}
#accordion-menu a.head:hover {
	color: #7D0000;
}
#accordion-menu a.current {
	background-color: #F7F7F7;
}
#accordion-menu ul {
	border-width: 0px;
	margin: 0px;
	padding: 0px;
	text-indent: 0px;
}
#accordion-menu li {
	list-style: none outside none;
  display: inline;
}
#accordion-menu li li a {
	color: #000000;
  background-color: #C4C4C4;
	display: block;
	text-decoration: none;
  padding: 5px;
}
#accordion-menu li li a:hover {
	background-color:#F7F7F7;
}
@media print {
	#accordion-menu ul{
		display: block!important;
		height: auto!important
	}
}
#date_controls {
	position: absolute;
  top: 80px;
  left: 160px;
}
#date_controller {
	position: absolute;
	z-index: 10;
	background-color: white;
	border-style: solid;
	border-width: 1px;
	border-color: #ddd;
	display: none;
	padding: 10px;
}
.tablesorter {
	margin: 0 !important;
}
.tableframe
{
  position: absolute;
  top: 120px;
  left: 160px;
  right: 160px;
  bottom: 120px;
  border: 1px solid #999999;
  background-color: #F9F9F9;
  overflow: auto;
  width: expression((parseInt(document.documentElement.clientWidth)-230)+'px');
  height: expression((parseInt(document.documentElement.clientHeight)-125)+'px');
}
.table_controls
{
  position: absolute;
  bottom: 95px;
}
.table_meta
{
  position: absolute;
  bottom: 80px;
}
#accounting_equation
{
  position: absolute;
  bottom: 20px;
}
</xsl:template>
</xsl:stylesheet>