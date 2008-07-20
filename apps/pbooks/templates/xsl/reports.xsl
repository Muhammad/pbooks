<!--
Program: PBooks
Component: reports.xsl
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
  <xsl:include href="main.xsl"/>
  <xsl:include href="date_select.xsl"/>
  <xsl:template name="content">
<!-- Main reports -->
    <h2>
      <xsl:value-of select="/_R_/i18n/report_type"/>
    </h2>
    <form method="get">
      <input type="hidden" name="nid" value="{/_R_/_get/nid}-build"/>
      <table>
        <tr>
          <td>
            <xsl:value-of select="/_R_/i18n/report_type"/>:
          </td>
          <td>
            <select name="report_type_id">
              <xsl:for-each select="//report_types/report_type">
                <xsl:variable name="mykey">
                  <xsl:value-of select="@key"/>
                </xsl:variable>
                <option value="{@id}">
                  <xsl:value-of select="/_R_/i18n/label[key=$mykey]/value"/>
                </option>
              </xsl:for-each>
            </select>
          </td>
        </tr>
        <tr>
          <td valign="top">
            <xsl:value-of select="/_R_/i18n/period"/>:
          </td>
          <td>
            <xsl:call-template name="date_select">
              <xsl:with-param name="my_from_date">
                <xsl:value-of select="//fiscal_start"/>
              </xsl:with-param>
            </xsl:call-template>
          </td>
        </tr>
      </table>
      <div style="text-align: center; margin-top: 20px;">
        <input type="submit" value="{/_R_/i18n/build_report}" name="submit" />
      </div>

      <!-- Saved reports -->
      <h2>
        <xsl:value-of select="/_R_/i18n/saved_reports"/>
      </h2>
      <ul style="big">
        <xsl:for-each select="//reports_saved/report">
          <li>
            <a href="{/_R_/runtime/link_prefix}reports-build&amp;{link}">
              <xsl:value-of select="label"/>
            </a>
          </li>
        </xsl:for-each>
      </ul>

      <!-- Additional reports -->
      <h2>
        <xsl:value-of select="/_R_/i18n/additional_reports"/>
      </h2>
      <ul style="big">
        <li>
          <a href="{/_R_/runtime/link_prefix}reports-simple-cash-flow">
            <xsl:value-of select="/_R_/i18n/simple_monthly_cash_flow"/>
          </a>
        </li>
        <li>
          <a href="{/_R_/runtime/link_prefix}reports-group-cash-flow">
            <xsl:value-of select="/_R_/i18n/group_monthly_cash_flow"/>
          </a>
        </li>
        <li>
          <a href="{/_R_/runtime/link_prefix}reports-invoices">
            <xsl:value-of select="/_R_/i18n/report_invoices"/>
          </a>
        </li>
      </ul>
    </form>
  </xsl:template>
</xsl:stylesheet>