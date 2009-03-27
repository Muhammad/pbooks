<!--
Program: PBooks
Component: html_head.xsl
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
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns="http://www.w3.org/1999/xhtml">
	<xsl:template name="head">
		<xsl:param name="link_prefix"/>
		<xsl:param name="path_prefix"/>
		<head>
			<title>
				<xsl:value-of select="/_R_/i18n/default_page_title"/>: 
        <xsl:value-of select="/_R_/i18n/*[name()=/_R_/_get/nid]"/>
			</title>
			<link rel="stylesheet" type="text/css" href="{$link_prefix}x-dynamic-css"></link>
			<script type="text/javascript" src="{$path_prefix}s/js/jquery/jquery-1.3.2.js"/>
			<script type="text/javascript" src="{$path_prefix}s/js/jquery/plugins/jquery.cookiejar.js"/>
			<script type="text/javascript" src="{$path_prefix}s/js/jquery/plugins/jquery.accordion.js"/>
			<script type="text/javascript" src="{$path_prefix}s/pkgs/tablesorter/jquery.tablesorter.min.js"/>
			<script type="text/javascript" src="{$path_prefix}s/pkgs/tablesorter/jquery.metadata.js"/>
			<script type="text/javascript" src="{$path_prefix}s/pkgs/tablesorter/addons/pager/jquery.tablesorter.pager.js"/>
			<script type="text/javascript" src="{$path_prefix}s/js/jquery/plugins/jquery.dimensions.js"/>
			<script type="text/javascript" src="{$path_prefix}s/js/jquery/plugins/jquery.date_input.js"/>
			<script type="text/javascript" src="{$path_prefix}s/js/jquery/plugins/jquery.cookie.js"/>
			<script type="text/javascript" src="{$path_prefix}s/js/jquery/plugins/jquery.json.js"/>
			<script type="text/javascript" src="{$path_prefix}s/js/jquery/plugins/jquery.tablesorter.cookie.js"/>
			<script type="text/javascript" src="{$path_prefix}s/js/jquery/plugins/thickbox.js"/>
			<link rel="stylesheet" type="text/css" href="{$path_prefix}s/css/thickbox.css"></link>
			<link rel="stylesheet" type="text/css" href="{$path_prefix}s/css/date_input.css"></link>
			<script type="text/javascript" src="{$path_prefix}s/js/jsval.js"/>
			<script type="text/javascript" src="{$link_prefix}x-xhtml2dom-js"/>
      <xsl:for-each select="//head_nodes">
				<xsl:sort select="priority" order="ascending"/>
				<xsl:apply-templates select="nodes/*"/>
			</xsl:for-each>
		</head>
	</xsl:template>
</xsl:stylesheet>
