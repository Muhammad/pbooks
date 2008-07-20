<!--
Program: PBooks
Component: report_invoices.xsl
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
  <xsl:include href="main.xsl"/>
  <xsl:include href="pager.xsl"/>
  <xsl:template name="content">
    <xsl:param name="link_prefix"/>
    <xsl:call-template name="jquery-setup">
      <xsl:with-param name="my-table"></xsl:with-param>
    </xsl:call-template>

    <!-- Net change -->
    <div class="generic-button" style="float: right;">
      <b>
        <xsl:value-of select="/_R_/i18n/net_change"/>
      </b>: 
    <xsl:value-of
      select=" format-number( sum( /_R_/get_some_business_objects/invoice_total ),'#########.##') "/>
    </div>


    <form method="get">
      <input type="hidden" name="nid" value="reports-invoices"/>
      <table>

        <tr>
          <td>
            <xsl:if test="/_R_/_get/month >= 1">
              <a>
                <xsl:attribute name="href">
                  <xsl:value-of select="$link_prefix"/>reports-invoices&amp;month=<xsl:if test="/_R_/_get/month &lt;= 10">0</xsl:if>
                  <xsl:value-of select="/_R_/_get/month - 1"/>
                </xsl:attribute>
                <img src="{/_R_/runtime/path_prefix}/images/buttons/out.gif"/>
              </a>
            </xsl:if>
            <xsl:if test="not(/_R_/_get/month >= 1)">
              <img src="{/_R_/runtime/path_prefix}/images/buttons/out_d.gif"/>
            </xsl:if>
          </td>

          <td>
            <xsl:value-of select="/_R_/i18n/month"/>:</td>
          <td>
            <select name="month" onchange="this.form.submit();">
              <option value="%">All</option>
              <xsl:for-each select="//months/option">
                <option value="{@id}">
                  <xsl:if test="@id=/_R_/_get/month">
                    <xsl:attribute name="selected">selected</xsl:attribute>
                  </xsl:if>
                  <xsl:value-of select="@fullname"/>
                </option>
              </xsl:for-each>
            </select>
          </td>
          <td>
            <xsl:if test="/_R_/_get/month &gt;= 12">
              <img src="{/_R_/runtime/path_prefix}/images/buttons/in_d.gif"/>
            </xsl:if>
            <xsl:if test="not(/_R_/_get/month)">
              <a href="{$link_prefix}reports-invoices&amp;month=01">
                <img src="{/_R_/runtime/path_prefix}/images/buttons/in.gif"/>
              </a>
            </xsl:if>
            <xsl:if test="(/_R_/_get/month &lt; 12)">
              <a>
                <xsl:attribute name="href">
                  <xsl:value-of select="$link_prefix"/>reports-invoices&amp;month=<xsl:if test="/_R_/_get/month &lt; 9">0</xsl:if>
                  <xsl:value-of select="/_R_/_get/month + 1"/>
                </xsl:attribute>
                <img src="{/_R_/runtime/path_prefix}/images/buttons/in.gif"/>
              </a>
            </xsl:if>
          </td>
        </tr>
      </table>

      <table class="tablesorter" id="myInvoices">
        <thead>
          <tr>
            <th>
              <xsl:value-of select="/_R_/i18n/id"/>
            </th>
            <th>
              <xsl:value-of select="/_R_/i18n/client"/>
            </th>
            <th>
              <xsl:value-of select="/_R_/i18n/memo"/>
            </th>
            <th>
              <xsl:value-of select="/_R_/i18n/amount"/>
            </th>
            <th>
              <xsl:value-of select="/_R_/i18n/date"/>
            </th>
          </tr>
        </thead>
        <tbody>
    <!-- LOOP -->
          <xsl:for-each select="/_R_/get_some_business_objects">
            <xsl:variable name="my_entry_id">
              <xsl:value-of select="entry_id"/>
            </xsl:variable>
            <xsl:variable name="my_customer_id">
              <xsl:value-of select="customer_id"/>
            </xsl:variable>
            <tr onmouseover="oldClass=this.className; this.className='active'" onmouseout="this.className=oldClass">
              <td id="{$my_entry_id}">
                <a href="{$link_prefix}invoice-edit&amp;entry_id={entry_id}&amp;invoice_id={$my_entry_id}">
                  <xsl:value-of select="invoice_number"/>
                </a>
              </td>
              <td>
                <a href="#">
                  <xsl:value-of select="/_R_/get_all_accounts/get_all_accounts[id=$my_customer_id]/name"/>
                </a>
              </td>
              <td>
                <a href="{$link_prefix}invoice-edit&amp;entry_id={entry_id}&amp;invoice_id={$my_entry_id}">
                  <xsl:value-of select="memorandum"/>
                </a>
              </td>
              <td>
                <xsl:value-of select="invoice_total"/>
              </td>
              <td>
                <xsl:value-of select="entry_datetime"/>
              </td>
            </tr>
          </xsl:for-each>
          <!-- END LOOP -->
        </tbody>
        <tfoot>
          <tr>
            <td colspan="3" style="text-align: right;">Total:</td>
            <td>
              <xsl:value-of
                select=" format-number( sum( /_R_/get_some_business_objects/invoice_total ),'#########.##') "/>
            </td>
            <td></td>
          </tr>
        </tfoot>
      </table>
      <br/>
    </form>
  </xsl:template>
</xsl:stylesheet>