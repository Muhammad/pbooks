<!--
Program: PBooks
Component: welcome.xsl
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


<div style="padding: 25px;">

  <xsl:value-of select="$i18n/wicked_cool"/>
  <br/>
  <br/>
  <b>
    <xsl:value-of select="$i18n/get_started"/>
  </b>
  <br/>
  <br/>
  <ul>
    <xsl:for-each select="//quick_links/link">
      <li>
        <a href="{$link_prefix}{link}">
          <xsl:value-of select="label"/>
        </a>
      </li>
    </xsl:for-each>
  </ul>
  <br/><br/>

  <!-- strict layout table -->
  <table>
    <tr>
      <td style="padding-right: 20px;" valign="top">

      <div class="block">
        <div class="hd">
          <span class="i18n-quick_stats">Quick Stats</span>
        </div>
        <div class="bd">
        <table class="zebra" width="300">
          <tbody>
            <tr>
              <td>
                <a href="{$link_prefix}accounts">
                  <span class="i18n-accounts">Accounts</span>
                </a>
              </td>
              <td>
                <xsl:value-of select="/_R_/select_account_stats/select_account_stats/account_stats"/>
              </td>
            </tr>
            <tr>
              <td>
                <a href="{$link_prefix}journal">
                  <span class="i18n-journal_entries">Journal Entries</span>
                </a>
              </td>
              <td>
                <xsl:value-of select="/_R_/select_account_stats/select_account_stats/entry_stats"/>
              </td>
            </tr>
            <tr>
              <td>
                <a href="{$link_prefix}journal">
                  <span class="i18n-journal_entry_amounts">Journal Entry Amounts</span>
                </a>
              </td>
              <td>
                <xsl:value-of select="/_R_/select_account_stats/select_account_stats/entry_amounts_stats"/>
              </td>
            </tr>
            <tr>
              <td>
                <a href="{$link_prefix}ledger">
                  <span class="i18n-ledger_transactions">Ledger Transactions</span>
                </a>
              </td>
              <td>
                <xsl:value-of select="/_R_/select_account_stats/select_account_stats/gl_stats"/>
              </td>
            </tr>
          </tbody>
        </table>
        </div></div>
      </td>
      <td valign="top">
      <!-- This table displays some recent entries and transactions -->
        <div class="block">
          <div class="hd">
            <span class="i18n-recent_activity">Recent Activity</span>
          </div>
          <div class="bd">
          <table class="zebra">
          <tbody>
            <tr>
              <td>
                <a href="{//link_prefix}invoices"><span class="i18n-invoices">Invoices</span></a>
              </td>
              <td><xsl:value-of select="//outstanding_invoice_total"/></td>
            </tr>
            <tr>
              <td>
                <span class="i18n-checks">Checks</span>
              </td>
              <td></td>
            </tr>
          </tbody>
        </table>
        </div></div>
      </td>
    </tr>
  </table>

  <br/>
  <br/>
  <xsl:value-of select="$i18n/number_transactions"/>
</div>


  </xsl:template>
</xsl:stylesheet>
