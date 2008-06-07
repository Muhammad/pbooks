<!--
Program: PBooks
Component: head.xsl
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
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:template name="head">
<head>
    <title><xsl:value-of select="/_R_/i18n/label[key='default_page_title']/value"/></title>
    <link rel="stylesheet" type="text/css" href="{/_R_/runtime/link_prefix}dynamic-css" ></link>
    <script type="text/javascript" src="{/_R_/runtime/path_prefix}/s/js/jquery/jquery.js"></script>
    <script type="text/javascript" src="{/_R_/runtime/path_prefix}/s/js/jquery/plugins/jquery.cookiejar.js"></script>
    <script type="text/javascript" src="{/_R_/runtime/path_prefix}/s/js/jquery/plugins/jquery.accordion.js"></script>
    <script type="text/javascript" src="{/_R_/runtime/path_prefix}/s/js/jquery/plugins/jquery.tablesorter.min.js"></script>
    <script type="text/javascript" src="{/_R_/runtime/path_prefix}/s/js/jquery/plugins/jquery.tablesorter.pager.js"></script>
    <script type="text/javascript" src="{/_R_/runtime/path_prefix}/s/js/jquery/plugins/jquery.dimensions.js"></script>
    <script type="text/javascript" src="{/_R_/runtime/path_prefix}/s/js/jquery/plugins/jquery.date_input.js"></script>
    <script type="text/javascript" src="{/_R_/runtime/path_prefix}/s/js/jquery/plugins/jquery.cookie.js"></script>
    <script type="text/javascript" src="{/_R_/runtime/path_prefix}/s/js/jquery/plugins/jquery.json.js"></script>
    <script type="text/javascript" src="{/_R_/runtime/path_prefix}/s/js/jquery/plugins/jquery.tablesorter.cookie.js"></script>
    <script type="text/javascript" src="{/_R_/runtime/path_prefix}/s/js/jsval.js"></script>
<xsl:for-each select="//in_head">
    <xsl:sort select="priority"/>
    <xsl:value-of select="string" disable-output-escaping="yes"/>
</xsl:for-each>
</head>
</xsl:template>
</xsl:stylesheet>