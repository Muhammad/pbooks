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
or write to the Free Software Foundation,Inc., 51 Franklin Street,
Fifth Floor, Boston, MA 02110-1301  USA
-->
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" >
<xsl:import href="main.xsl"/>
<xsl:include href="accounting_menu.xsl"/>
<xsl:template name="content">
<p><xsl:value-of select="/__ROOT__/i18n/labels/label[key='configure']/value"/>:</p>
<h2><xsl:value-of select="/__ROOT__/i18n/labels/label[key='options']/value"/></h2>
<h2><xsl:value-of select="/__ROOT__/i18n/labels/label[key='plugins']/value"/></h2>
<xsl:for-each select="//plugins_list">
    <xsl:value-of select="."/><br/>
</xsl:for-each>
<h2><xsl:value-of select="/__ROOT__/i18n/labels/label[key='themes']/value"/></h2>

<h2><xsl:value-of select="/__ROOT__/i18n/labels/label[key='user_admin']/value"/></h2>
<xsl:value-of select="/__ROOT__/i18n/labels/label[key='enter_user_manager']/value"/>, <a href="user.php?nid=user">
	<xsl:value-of select="/__ROOT__/i18n/labels/label[key='click_here']/value"/></a>. 
<br/><br/>
<xsl:value-of select="/__ROOT__/i18n/labels/label[key='return_user_admin']/value"/>. 
</xsl:template>
</xsl:stylesheet>
