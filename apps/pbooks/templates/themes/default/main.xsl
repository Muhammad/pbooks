<!--
Program: PBooks
Component: main.xsl
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
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:include href="html_shell.xsl"/>
<xsl:include href="accounting_menu.xsl"/>
<xsl:template name="main">
<xsl:if test="/__ROOT__/_get/print='true'">
    <div onclick="window.location.href='{substring-before(//request_uri,'&amp;print=true')}';" 
    style="padding: 20px; width: 600px;">
    <xsl:call-template name="content"/>
    </div>
</xsl:if>
<xsl:if test="not(/__ROOT__/_get/print='true')">
    <xsl:call-template name="default"/>
</xsl:if>
</xsl:template>

</xsl:stylesheet>