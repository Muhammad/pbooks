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
<xsl:output method="text" indent="yes" encoding="UTF-8" omit-xml-declaration="yes"/>
<xsl:template name="colors">

#footer {
    background: #555;
    color: #FFF;
}
#main {
    background: #CCC;
}

#content {
    background: #FFF;
}
#loftcol {
    background-color: #CCC;
}

.page-title {
    color: #EEE;
}

.row0 td {
	background-color: #FFFFFF;
}

.row1 td {
	background-color: #EEEEEE;
}

.row2 td {
	background-color: #DDDDDD;
    margin: 1px;
}
.row2:hover td {
    background-color: #CCFFFF;
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
}
.menu-sub {
	background: #CCC;
}
a {
    color: #222222;
}

a:visited {
    color: #222222;
}

a:hover {
    color: #44BBDD;
}


.generic-button a {
    border-color: #BBB;
}

a.generic-button {
    border-color: #BBB;
}


</xsl:template>
</xsl:stylesheet>