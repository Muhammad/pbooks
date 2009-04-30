<!--
Program: PBooks
Component: colors.css.xsl
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
<xsl:template name="colors">
body {
  background: #7B8F8F;
}
#footer {
  border-color: #7D0000;
  border-style: solid;
  background: #142738;
  color: #C4C4C4;
}
#footer a {
  color: #C4C4C4;
}
#main {
  background: #C4C4C4;
}
#header {
  background-color: #142738;
}
#content {
  background: #FFF;
}

#company-name {
  color: #FFC508;
}
.page-title {
  color: #FFC508; /* #D6B28D; */
}

.reconciled {
	background-color: #9AD698 !important;
}

.row0 td {
	background-color: #FFFFFF;
}

.row1 td {
	background-color: #EEEEEE;
}

.row2 td {
	background-color: #DDDDEE;
  margin: 1px;
}
.row2:hover td {
  background-color: #CCFFFF;
  cursor: pointer;
}

.row3 td {
	background-color: #f0f0f0;
}

.row4 td {
	background-color: #CCC;
}

.journal-table tbody tr td.row0 {
	border-color: #FFFFFF;
}

.journal-table tbody tr td.row1 {
	border-color: #EEEEEE;
}

.menu-sub-selected {
  background-color: #AAA;
  color: #FFF;
}
.menu-sub {
	background: #C4C4C4;
}
.menu-sub:hover {
  background: #F7F7F7; /* 7D0000 */
}
a {
  color: #222222;
}

a:visited {
  color: #222222;
}

a:hover {
  color: #7D0000;
}


.generic-button a {
  border-color: #BBB;
}
.form-table tr td {
  border-color: #CCC;
}

a.generic-button {
  border-color: #BBB;
}


.journal-table tbody tr td {
  border-color: #CCC;
}

#error_match {
  color: #FF6666;
  background: #AC2F1B;
}

.active td, .active td a{
  color: #fff !important;
  background-color: #AC2F1B !important;
}

</xsl:template>
</xsl:stylesheet>