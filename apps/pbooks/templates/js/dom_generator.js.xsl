<!--
Program: PBooks
Component: html_blocks.js.xsl
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
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns="http://www.w3.org/1999/xhtml">
	<xsl:output method="text" indent="yes" encoding="UTF-8" omit-xml-declaration="yes"/>
	<xsl:template match="/">

var html2dom_root_0 = document.createElement("div");
<xsl:apply-templates select="//footer">
	<xsl:with-param name="mynode">html2dom_root</xsl:with-param>
	<xsl:with-param name="id">0</xsl:with-param>
</xsl:apply-templates>
<![CDATA[

$(document).ready(function() {
		$("#nofooter").replaceWith(html2dom_root_0);
});

			]]>
	</xsl:template>

<xsl:template match="node()">
	<xsl:param name="mynode"/>
	<xsl:param name="id"/>
	var <xsl:value-of select="name()"/>_<xsl:value-of select="$id"/> = document.createElement("<xsl:value-of select="name()"/>");


	<xsl:value-of select="$mynode"/>_<xsl:value-of select="$id"/>.appendChild(<xsl:value-of select="name()"/>_<xsl:value-of select="$id"/>)
	<xsl:apply-templates select="@*|node()">
		<xsl:with-param name="mynode"><xsl:value-of select="name()"/></xsl:with-param>
		<xsl:with-param name="id" select="$id"/>
	</xsl:apply-templates>
</xsl:template>

<xsl:template match="@*">
	<xsl:param name="mynode"/>
	<xsl:param name="id"/>
	<xsl:value-of select="$mynode"/>_<xsl:value-of select="$id"/>.<xsl:value-of select="name()"/> = "<xsl:value-of select="."/>";
</xsl:template>

<xsl:template match="comment()">
</xsl:template>

<xsl:template match="text()">
<xsl:param name="mynode"/>
<xsl:param name="id"/>
<xsl:variable name="string" select="."/>
newtextnode = document.createTextNode('<xsl:value-of select="translate($string, '&#xa;', '')"/>');
<xsl:value-of select="$mynode"/>_<xsl:value-of select="$id"/>.appendChild(newtextnode);
</xsl:template>

</xsl:stylesheet>
