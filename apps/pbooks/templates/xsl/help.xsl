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
or write to the Free Software Foundation, Inc., 51 Franklin Street,
Fifth Floor, Boston, MA 02110-1301 USA
-->
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns="http://www.w3.org/1999/xhtml">
  <xsl:include href="html_main.xsl"/>
  <xsl:template name="content">
  <xsl:param name="i18n"/>
  <h2 style="margin-top: 10px;">
    <xsl:value-of select="$i18n/pbooks_manual"/>
  </h2>
  <a href="http://www.pbooks.org/wiki/PBooks_User_Manual" target="_blank">
			<xsl:value-of select="$i18n/pbooks_user_manual"/>
  </a>

  <h2 style="margin-top: 10px;">
    <xsl:value-of select="$i18n/resource_links"/>
  </h2>
  <ul>
    <li>
    <a href="http://www.pbooks.org/" target="_blank">
      <xsl:value-of select="$i18n/pbooks_homepage"/>
    </a>
    </li>
    <li>
    <a href="http://www.informedbanking.com/index.html" target="_blank">
      <xsl:value-of select="$i18n/informed"/>
    </a>
    </li>
    <li>
    <a href="http://www.sb-info.com/wiki/Main_Page" target="_blank">
      <xsl:value-of select="$i18n/small_business_info"/>
    </a>
    </li>
  </ul>

  <h2 style="margin-top: 10px;">
    <xsl:value-of select="$i18n/pbooks_consulting"/>
  </h2>

  <xsl:value-of select="$i18n/written"/>

  <a href="http://www.savonix.com" target="_blank">
    <xsl:value-of select="$i18n/savonix"/>
  </a>.

		<xsl:value-of select="$i18n/consulting_services"/>

  <a href="mailto:support@savonix.com">
    <xsl:value-of select="$i18n/support"/>
  </a>.
	</xsl:template>
</xsl:stylesheet>