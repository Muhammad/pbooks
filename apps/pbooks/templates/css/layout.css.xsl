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
#main {
    width: 980px;
    text-align: left;
    margin-left: auto;
    margin-right: auto;
}

#header {
    width: 74em;
    border: 0px;
    margin-left: 10.5em;
    background: #FFF;
    min-height: 65em;
}

#top-block {
    height: 5.4em;
    background: #777;
    letter-spacing: 1px;
    display: block;
}
#leftcol {
    float: left;
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
    width: 100%;
    display: block;
    text-align: center;
    line-height: 20px;
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
	text-indent:0px;
	white-space: nowrap;
    padding: 5px;
}


/* tables */
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

/* Check form */
#check {
    width: 500px;
    height: 200px;
    border: 1px;
    border-style: solid;
    padding: 5px;
}

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
#deposit {
    width: 500px;
    height: 200px;
    border: 1px;
    border-style: solid;
    padding: 5px;
}

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

/* Bill form */
#bill {
    width: 500px;
    height: 200px;
    border: 1px;
    border-style: solid;
    padding: 5px;
}
#bill_date {
    float: left;
}
#bill_number {
    float: right;
}
#bill_payee {
    margin-top: 60px;
    float:right;
}
#bill_memo {
    margin-top: 120px;
}




#journal-entry-form table {
     width: 100%;
     text-align: center;
}

#journal-entry-form tr td {
     text-align: left;
     padding: 5px;
}

.page-title {
    padding: 10px;
    margin-top: -8px;
}
</xsl:template>
</xsl:stylesheet>