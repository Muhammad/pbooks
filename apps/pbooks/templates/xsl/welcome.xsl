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
or write to the Free Software Foundation,Inc., 51 Franklin Street,
Fifth Floor, Boston, MA 02110-1301  USA
-->
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:include href="main.xsl"/>
  <xsl:template name="content">
    <xsl:param name="link_prefix"/>
    <div style="padding: 25px;">

      <xsl:value-of select="/_R_/i18n/label[key='wicked_cool']/value"/>
      <br/>
      <br/>
      <b>
        <xsl:value-of select="/_R_/i18n/label[key='get_started']/value"/>
      </b>
      <br/>
      <br/>
      <ul>
        <xsl:for-each select="//quick_links/link">
          <li>
            <a href="{//runtime/link_prefix}{link}">
              <xsl:value-of select="label"/>
            </a>
          </li>
        </xsl:for-each>
      </ul>


<!-- strict layout table -->
      <table cellpadding="20">
        <tr>
          <td>

<!-- This table displays some basic information about the books -->
            <table class="simpletable" width="300">
              <thead>
                <tr>
                  <th colspan="2">
                    <b>
                      <xsl:value-of select="/_R_/i18n/label[key='quick_stats']/value"/>
                    </b>
                  </th>
                </tr>
              </thead>
              <tbody>
                <tr>
                  <td>
                    <a href="{$link_prefix}accounts">
                      <xsl:value-of select="/_R_/i18n/label[key='accounts']/value"/>
                    </a>
                  </td>
                  <td>
                    <xsl:value-of select="/_R_/select_account_stats/select_account_stats/account_stats"/>
                  </td>
                </tr>
                <tr>
                  <td>
                    <a href="{$link_prefix}ledger">
                      <xsl:value-of select="/_R_/i18n/label[key='ledger_transactions']/value"/>
                    </a>
                  </td>
                  <td>
                    <xsl:value-of select="/_R_/select_account_stats/select_account_stats/gl_stats"/>
                  </td>
                </tr>
                <tr>
                  <td>
                    <a href="{$link_prefix}journal">
                      <xsl:value-of select="/_R_/i18n/label[key='journal_entry_amounts']/value"/>
                    </a>
                  </td>
                  <td>
                    <xsl:value-of select="/_R_/select_account_stats/select_account_stats/entry_amounts_stats"/>
                  </td>
                </tr>
                <tr>
                  <td>
                    <a href="{$link_prefix}journal">
                      <xsl:value-of select="/_R_/i18n/label[key='journal_entries']/value"/>
                    </a>
                  </td>
                  <td>
                    <xsl:value-of select="/_R_/select_account_stats/select_account_stats/entry_stats"/>
                  </td>
                </tr>
              </tbody>
            </table>
          </td>
          <td>
<!-- This table displays some recent entries and transactions -->
            <table class="simpletable" width="300">
              <thead>
                <tr>
                  <th colspan="2">
                    <b>
                      <xsl:value-of select="/_R_/i18n/label[key='recent_activity']/value"/>
                    </b>
                  </th>
                </tr>
              </thead>
              <tbody>
                <tr>
                  <td>
                    <xsl:value-of select="/_R_/i18n/label[key='invoices']/value"/>
                  </td>
                  <td></td>
                </tr>
                <tr>
                  <td>
                    <xsl:value-of select="/_R_/i18n/label[key='checks']/value"/>
                  </td>
                  <td></td>
                </tr>
              </tbody>
            </table>
          </td>
        </tr>
      </table>

      <br/>
      <br/>
      <xsl:value-of select="/_R_/i18n/label[key='number_transactions']/value"/>
    </div>
  </xsl:template>
</xsl:stylesheet>
