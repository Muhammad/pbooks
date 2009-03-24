<!--
Program: PBooks
Component: html_footer.xsl
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
	<xsl:template name="footer">
    <xsl:param name="link_prefix"/>
		<xsl:call-template name="source_spacer">
			<xsl:with-param name="section_start">footer</xsl:with-param>
		</xsl:call-template>
		<div id="footer">
			<footer>
				<xsl:comment>You must keep this copyright notice intact.</xsl:comment>
				<a href="http://www.pbooks.org/" target="_blank">
        PBooks</a> version
        <xsl:value-of select="//pbooks_code_version"/>,
        DB Version: <xsl:value-of select="/_R_/runtime/db_version"/>,
        Copyright 
        <a href="http://www.savonix.com" target="_blank">
            Savonix</a>, all rights reserved. License:
        <a href="{$link_prefix}license">
            AGPL v3
        </a>.
        <a href="http://www.pbooks.org/pub/">
            Download source
        </a>.
				<!-- Link to download source, as required by AGPL -->
			</footer>
		</div>
		<div id="test-token" style="display:none;"></div>
		<xsl:call-template name="source_spacer">
			<xsl:with-param name="section_end">footer</xsl:with-param>
		</xsl:call-template>
	</xsl:template>
</xsl:stylesheet>