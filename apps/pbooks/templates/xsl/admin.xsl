<!--
Program: PBooks
Component: admin.xsl
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
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:include href="main.xsl"/>
  <xsl:template name="content">
    <xsl:param name="link_prefix"/>
    <xsl:param name="path_prefix"/>
    <xsl:param name="i18n"/>
		<p>
			<xsl:value-of select="$i18n/configure"/>:</p>
		<h2 style="margin-top: 10px;">
			<xsl:value-of select="$i18n/options"/>
		</h2>
		<h2 style="margin-top: 10px;">
			<xsl:value-of select="$i18n/plugins"/>
		</h2>
		<xsl:for-each select="//plugins_list">
			<xsl:value-of select="."/>
			<br/>
		</xsl:for-each>
		<h2 style="margin-top: 10px;">
			<xsl:value-of select="$i18n/themes"/>
		</h2>

		<!-- User Admin Link -->
		<h2 style="margin-top: 10px;">
			<xsl:value-of select="$i18n/user_admin"/>
		</h2>
		<xsl:value-of select="$i18n/enter_user_manager"/>, 
		<a href="user.php?nid=user">
			<xsl:value-of select="$i18n/click_here"/>
		</a>.
		<xsl:value-of select="$i18n/return_user_admin"/>.
  </xsl:template>
</xsl:stylesheet>
