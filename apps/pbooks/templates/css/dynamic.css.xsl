<!--
Program: PBooks
Component: dynamic.css.xsl
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
<xsl:include href="base.css.xsl"/>
<xsl:include href="colors.css.xsl"/>
<xsl:include href="layout.css.xsl"/>
<xsl:include href="typography.css.xsl"/>
<xsl:template match="/">

<xsl:call-template name="base"/>
<xsl:call-template name="typography"/>
<xsl:call-template name="layout"/>
<xsl:call-template name="colors"/>

<xsl:if test="//path_prefix='/demo/'">
.webads iframe {
    overflow-x: hidden;
    overflow-y: hidden;
}
</xsl:if>

<xsl:call-template name="thematic-button">
    <xsl:with-param name="button-name">basic-blue</xsl:with-param>
    <xsl:with-param name="background-color">#F1F1F1</xsl:with-param>
    <xsl:with-param name="color">#0066B9</xsl:with-param>
</xsl:call-template>
<xsl:call-template name="thematic-button">
    <xsl:with-param name="button-name">basic-green</xsl:with-param>
    <xsl:with-param name="background-color">#66FF99</xsl:with-param>
    <xsl:with-param name="color">#009900</xsl:with-param>
</xsl:call-template>
<xsl:call-template name="thematic-button">
    <xsl:with-param name="button-name">basic-black</xsl:with-param>
    <xsl:with-param name="background-color">grey</xsl:with-param>
    <xsl:with-param name="color">black</xsl:with-param>
</xsl:call-template>



.journal-table tbody tr td {
    height: 24px;
	white-space: nowrap;
	border-style: solid;
	border-color: #CCCCCC;
    border-width: 0;
    border-top-width: 1px;
    padding: 2px;
    vertical-align: middle;
}

.journal-table tbody tr td.separator {
    height: 4px;
    background-color: #BBBBBB;
	border-color: #555555;
    border-bottom-width: 1px;
}








.basic-table-cell, .basic-table-cell-indent{
    align: left;
    color: black;
    font-style: normal;
	text-indent:2px;
	white-space: nowrap;
    padding: 2px;
}



.data-table td {
    border-bottom-width: 1px;
    border-bottom-color: white;
	border-bottom-style: solid;
}

.sm_indent {
    padding-left: 15px;
}

.error {
    font-size: 104%;
    color: red;
    border: 1px;
    border-color: #FF6699;
    border-style: solid;
    background: #FFCCFF;
    line-height: 32px;
    text-align: center;
}

.error img {
    margin-bottom: -3px;
    padding-right: 5px;
}

.myerror {
    border: 1px;
    border-color: #FF6699;
    border-style: solid;
}

.generic-box {
    border: 2px;
    border-color: #BBB;
    border-style: solid;
    text-align: center;
    margin-top: 20px;
    padding: 4px;
    display: table;
    margin-left: auto;
    margin-right: auto;
}


.journal-post-plus {
    height: 17px;
    width: 17px;
    text-align: center;
    color: white;
}

/* INCLUDED FROM jquery.date_input.js */
/* Some resets for compatibility with existing CSS */
.date_selector, .date_selector * {
    width: auto;
    height: auto;
    border: none;
    background: none;
    margin: 0;
    padding: 0;
    text-align: left;
    text-decoration: none;
}
.date_selector {
    background: #F2F2F2;
    border: 1px solid #bbb;
    padding: 5px;
    margin: -1px 0 0 0;
}
.date_selector .month_nav {
    margin: 0 0 5px 0;
    padding: 0;
    display: block;
}
.date_selector .month_name {
    font-weight: bold;
    line-height: 20px;
    display: block;
    text-align: center;
}
.date_selector .month_nav a {
    display: block;
    position: absolute;
    top: 5px;
    width: 20px;
    height: 20px;
    line-height: 17px;
    font-weight: bold;
    color: #003C78;
    text-align: center;
    font-size: 120%;
    overflow: hidden;
}
.date_selector .month_nav a:hover, .date_selector .month_nav a:focus {
    background: none;
    color: #003C78;
    text-decoration: none;
}
.date_selector .prev {
    left: 5px;
}
.date_selector .next {
    right: 5px;
}
.date_selector table {
    border-spacing: 0;
    border-collapse: collapse;
}
.date_selector th, .date_selector td {
    width: 2.5em;
    height: 2em;
    padding: 0;
    text-align: center;
}
.date_selector td {
    border: 1px solid #ccc;
    line-height: 2em;
    text-align: center;
    white-space: nowrap;
    background: white;
}
.date_selector td.today {
    background: #FFFED9;
}
.date_selector td.unselected_month {
    color: #ccc;
}
.date_selector td a {
    display: block;
    text-decoration: none !important;
    width: 100%;
    height: 100%;
    line-height: 2em;
    color: #003C78;
    text-align: center;
}
.date_selector td.today a {
    background: #FFFEB3;
}
.date_selector td.selected a {
    background: #D8DFE5;
    font-weight: bold;
}
.date_selector td a:hover {
    background: #003C78;
    color: white;
}
/* END INCLUDE FROM date_input.js */
/* END OLD CSS */


</xsl:template>



<xsl:template name="thematic-button">
<xsl:param name="button-name"/>
<xsl:param name="background-color"/>
<xsl:param name="color"/>
.button-<xsl:value-of select="$button-name"/>
{
    padding: .2em .4em;
    background-color: <xsl:value-of select="$background-color"/>;
    color: <xsl:value-of select="$color"/>;
    font-weight: bold;
    border-style: solid;
    border-width: 1px;
    border-color: <xsl:value-of select="$color"/>;
    margin: .5em;
    cursor: pointer;
}
</xsl:template>



</xsl:stylesheet>