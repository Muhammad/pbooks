<!--
Program: PBooks
Component: accounts_import.xsl
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
  <xsl:include href="html_main.xsl"/>
  <xsl:template name="content">
    <xsl:param name="link_prefix"/>
    <xsl:param name="path_prefix"/>
    <xsl:param name="i18n"/>

    <h2>
      <xsl:value-of select="$i18n/import_csv_accounts"/>
    </h2>

    <xsl:if test="/_R_/_get/error">
      <div class="error" id="function-error">
        <img src="{$path_prefix}{/_R_/runtime/icon_set}/exclamation.png"/>
        <xsl:value-of select="//errors/error[key='general_error']/value"/>
      </div>
      <br/>
    </xsl:if>

    <form method="post"
        onsubmit="return validateStandard(this, 'error');">
      <textarea id="csv_import" name="csv_accounts_import" rows="14" cols="80">
			<xsl:text>10000,1234,"testing","this is a test account"
			10000,4567,"testing 2","this is another test account"</xsl:text>
			</textarea>
      <br/>
      <input type="submit"/>
    </form>

  </xsl:template>
</xsl:stylesheet>