<!--
Program: PBooks
Component: logs.xsl
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
    <xsl:param name="link_prefix"/>
    <xsl:param name="path_prefix"/>
    <xsl:param name="i18n"/>
		<!--
    <xsl:call-template name="jquery-setup-simple">
      <xsl:with-param name="my-table">logs_table</xsl:with-param>
    </xsl:call-template>
    <table class="tablesorter" id="logs_table">
      <thead>
        <tr>
          <th>
            <xsl:value-of select="$i18n/log_id"/>
          </th>
          <th>
            <xsl:value-of select="$i18n/log_value"/>
          </th>
        </tr>
      </thead>
      <tbody>
        <xsl:for-each select="/_R_/fiscal_logs/log">
          <tr>
            <td>
              <xsl:value-of select="log_id"/>
            </td>
            <td>
              <xsl:value-of select="log_value"/>
            </td>
          </tr>
        </xsl:for-each>
      </tbody>
    </table>
    <xsl:value-of select="$i18n/log_info"/>
-->

<iframe style="width:600px;height:300px;" src="{$link_prefix}x-log">
</iframe>
<br/>
<!--<xsl:if test="//runtime_mode='development'">-->
<a href="{$link_prefix}x-test-log">Test Log Function</a>



  </xsl:template>
</xsl:stylesheet>