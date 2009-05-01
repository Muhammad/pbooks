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
<xsl:output method="text" indent="no" encoding="UTF-8" omit-xml-declaration="yes"/>
<xsl:include href="colors.css.xsl"/>
<xsl:include href="layout.css.xsl"/>
<xsl:include href="typography.css.xsl"/>
<xsl:strip-space elements="*"/>
<xsl:template match="/">

<xsl:call-template name="typography"/>
<xsl:call-template name="layout"/>
<xsl:call-template name="colors"/>



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


.faded {
  filter:alpha(opacity=25);
  -moz-opacity:.25;
  opacity:.25;
}

.separator {
  height: 4px !important;
  background-color: #BBBBBB;
  border-color: #555555 !important;
  border-bottom-width: 1px;
}



.basic-table-cell, .basic-table-cell-indent{
  color: black;
  font-style: normal;
	text-indent:2px;
	white-space: nowrap;
  padding: 2px;
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