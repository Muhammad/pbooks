<!--
Program: PBooks
Component: help.xsl
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
<xsl:include href="main.xsl"/>
<xsl:template name="content">
<h2><xsl:value-of select="/_R_/i18n/label[key='pbooks_manual']/value"/></h2>
<a href="http://www.pbooks.org/wiki/PBooks_User_Manual" target="_blank">
    <xsl:value-of select="/_R_/i18n/label[key='pbooks_user_manual']/value"/> ->
</a>

<h2><xsl:value-of select="/_R_/i18n/label[key='resource_links']/value"/></h2>
<ul>
    <li>
        <a href="http://www.pbooks.org/" target="_blank">
            <xsl:value-of select="/_R_/i18n/label[key='pbooks_homepage']/value"/>
        </a>
    </li>
    <li>
        <a href="http://www.informedbanking.com/index.html" target="_blank">
            <xsl:value-of select="/_R_/i18n/label[key='informed']/value"/>
        </a>
    </li>
    <li>
        <a href="http://www.sb-info.com/wiki/Main_Page" target="_blank">
            <xsl:value-of select="/_R_/i18n/label[key='small_business_info']/value"/>
        </a>
    </li>
</ul>

<h2><xsl:value-of select="/_R_/i18n/label[key='pbooks_consulting']/value"/></h2>

<xsl:value-of select="/_R_/i18n/label[key='written']/value"/>

<a href="http://www.savonix.com" target="_blank">
    <xsl:value-of select="/_R_/i18n/label[key='savonix']/value"/>
</a>.

<xsl:value-of select="/_R_/i18n/label[key='consulting_services']/value"/>

<a href="mailto:support@savonix.com">
    <xsl:value-of select="/_R_/i18n/label[key='support']/value"/>
</a>.
</xsl:template>
</xsl:stylesheet>