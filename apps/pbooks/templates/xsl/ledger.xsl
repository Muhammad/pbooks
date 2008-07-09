<!--
Program: PBooks
Component: ledger.xsl
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
  <xsl:include href="pager.xsl"/>
  <xsl:template name="content">
  <xsl:param name="link_prefix"/>
    <xsl:call-template name="jquery-setup">
      <xsl:with-param name="my-table">myLedger</xsl:with-param>
      <xsl:with-param name="my-table-div">myLedgerDiv</xsl:with-param>
      <xsl:with-param name="my-sort-column">
        ,widthFixed: true
        <xsl:if test="/_R_/_get/account_id">,sortList: [[2,0],[3,1]]</xsl:if>
      </xsl:with-param>
    </xsl:call-template>
<!-- Need this action to retain any account selection -->
    <form method="get">
      <input type="hidden" name="nid" value="{_R_/_get/nid}"/>
      <xsl:if test="/_R_/_get/account_id">
        <input type="hidden" name="account_id" value="{/_R_/_get/account_id}"/>
      </xsl:if>
      <table>
        <tr>
          <td>
            <xsl:value-of select="/_R_/i18n/label[key='month']/value"/>:
        </td>
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
        </tr>
      </table>
    </form>
    <form method="get">
      <input type="hidden" name="nid" value="{_R_/_get/nid}"/>
      <xsl:call-template name="date_select"/>
      <input type="submit"/>
    </form>
    <table>
      <form method="get">
        <tr>
          <input type="hidden" name="nid" value="{_R_/_get/nid}"/>
          <td>
            <xsl:value-of select="/_R_/i18n/label[key='select_one']/value"/>:</td>
          <td align="right">
            <select name="account_id" onchange="this.form.submit();">
              <option value="%">
                <xsl:value-of select="/_R_/i18n/titles/title[key='ledger']/value"/>
              </option>
			
              <xsl:for-each select="/_R_/get_all_accounts/get_all_accounts">
                <option value="{id}">
                  <xsl:if test="id=/_R_/_get/account_id">
                    <xsl:attribute name="selected">selected</xsl:attribute>
                  </xsl:if>
                  <xsl:value-of select="name"/>
                </option>
              </xsl:for-each>
            </select>
          </td>
          <td></td>
        </tr>
      </form>
    </table>
    <div style="min-height: 400px;" id="myLedgerDiv">
      <script type="text/javascript">
    document.getElementById('myLedgerDiv').style.visibility = 'hidden';
</script>
      <table id="myLedger" class="tablesorter">
        <thead>
          <tr>
        <!-- This cell will be used for a star or flag with notations -->
        <!--<th>FPO</th>-->
            <th>
              <xsl:value-of select="/_R_/i18n/label[key='post']/value"/>
            </th>
            <th>
              <xsl:value-of select="/_R_/i18n/label[key='memo']/value"/>
            </th>

        <!-- Exclude account column if only one account selected-->
            <xsl:if test="(/_R_/_get/account_id='%' or not(/_R_/_get/account_id))">
              <th>
                <xsl:value-of select="/_R_/i18n/label[key='account']/value"/>
              </th>
            </xsl:if>

            <th>
              <xsl:value-of select="/_R_/i18n/label[key='date']/value"/>:
        </th>
            <th>
              <xsl:value-of select="/_R_/i18n/label[key='amount']/value"/>
            </th>

            <xsl:if test="not(/_R_/_get/account_id='%') and /_R_/_get/account_id">
              <th>Balance</th>
            </xsl:if>
          </tr>
        </thead>


<!-- General ledger -->
        <tbody>
          <xsl:for-each select="/_R_/get_all_transactions/get_all_transactions">
            <tr onmouseover="oldClass=this.className; this.className='active'" onmouseout="this.className=oldClass">
        <!-- This cell will be used for a star or flag with notations -->
        <!--<td>FPO</td>-->
              <td>
                <xsl:choose>
                  <xsl:when test="not(entry_id='0')">
                    <a href="{$link_prefix}journal-entry&amp;entry_id={entry_id}">
                      <xsl:value-of select="entry_id"/>
                    </a>
                  </xsl:when>
                  <xsl:otherwise>
                    <a href="{$link_prefix}ledger-delete&amp;transaction_id={transaction_id}"
                      onclick="return confirm('Are you sure you want to delete this ledger transaction?')">
                      <img src="{/_R_/runtime/path_prefix}{/_R_/runtime/icon_set}delete.png" alt="x" border="0"/>
                    </a>
                &#160;
                <!-- create new matching entry -->
                    <a href="{$link_prefix}journal-new-from-transaction&amp;transaction_id={transaction_id}">
                      <img src="{/_R_/runtime/path_prefix}{/_R_/runtime/icon_set}add.png" alt="+" border="0"/>
                    </a>
                  </xsl:otherwise>
                </xsl:choose>
              </td>

              <td nowrap="nowrap">
                <a href="{$link_prefix}journal-entry&amp;entry_id={entry_id}">
                  <xsl:value-of select="substring(memorandum,0,42)"/>
                </a>
              </td>

              <xsl:if test="/_R_/_get/account_id='%' or not(/_R_/_get/account_id)">
                <td>
                  <a href="{$link_prefix}ledger&amp;account_id={account_id}">
                    <xsl:value-of select="substring(name,0,20)"/>
                  </a>
                </td>
              </xsl:if>

              <td>
                <a href="{$link_prefix}journal&amp;from_date={entry_datetime}">
                  <xsl:value-of select="entry_datetime"/>
                </a>
              </td>

              <td>
                <xsl:value-of select="entry_amount"/>
              </td>

              <xsl:if test="not(/_R_/_get/account_id='%') and /_R_/_get/account_id">
                <td>
                  <xsl:value-of select="balance"/>
                </td>
              </xsl:if>
            </tr>
          </xsl:for-each>
        </tbody>
      </table>
      <xsl:call-template name="pager">
        <xsl:with-param name="my-table">myLedger</xsl:with-param>
      </xsl:call-template>
    </div>

<!-- If an account_id has been selected, only show how much it has changed.-->
    <xsl:if test="(/_R_/_get/account_id &gt; 0)">
<!-- Net change -->
      <div class="generic-box" style="font-size: 18px;">
    Net change:
    <xsl:value-of select="format-number(sum(/_R_/get_all_transactions/get_all_transactions/entry_amount),'#########.##')"/>
      </div>
      <br/>

<!--
    Provide some links to related pages: gl and account edit
-->
      <xsl:value-of select="/_R_/i18n/label[key='account_ledger_links']/value"/>
      <a href="{$link_prefix}ledger">
        <xsl:value-of select="/_R_/i18n/label[key='general_ledger']/value"/>
      </a>
      <a href="{$link_prefix}accounts-edit&amp;account_id={/_R_/_get/account_id}">
        <xsl:value-of select="/_R_/i18n/label[key='account_edit']/value"/>
      </a>
    </xsl:if>

<!--
    Show the accounting equation in no specific account is selected
-->
    <xsl:if test="(/_R_/_get/account_id='%' or not(/_R_/_get/account_id)) and not(contains(/_R_/_get/nid,'match') )">

      <table class="tablesorter">
        <thead>
          <tr>
            <th>
              <xsl:value-of select="/_R_/i18n/label[key='assets']/value"/> +</th>
            <th>
              <xsl:value-of select="/_R_/i18n/label[key='expenses']/value"/> =</th>
            <th>
              <xsl:value-of select="/_R_/i18n/label[key='sub_total']/value"/> =</th>
            <th>
              <xsl:value-of select="/_R_/i18n/label[key='liabilities']/value"/> +</th>
            <th>
              <xsl:value-of select="/_R_/i18n/label[key='equity']/value"/> +</th>
            <th>
              <xsl:value-of select="/_R_/i18n/label[key='revenue']/value"/> = </th>
            <th>
              <xsl:value-of select="/_R_/i18n/label[key='total']/value"/>
            </th>
          </tr>
        </thead>
        <tbody>
          <tr>
            <td>
              <xsl:value-of select="/_R_/get_equation/get_equation/asset_total"/> +</td>
            <td>
              <xsl:value-of select="/_R_/get_equation/get_equation/expenses_total"/> =</td>
            <td>
              <xsl:if test="/_R_/get_equation/get_equation/asset_total + /_R_/get_equation/get_equation/expenses_total">
                <xsl:value-of select="/_R_/get_equation/get_equation/asset_total + //get_equation/expenses_total"/>
              </xsl:if>
            </td>
            <td>
              <xsl:value-of select="/_R_/get_equation/get_equation/liabilities_total"/> +</td>
            <td>
              <xsl:value-of select="/_R_/get_equation/get_equation/equity_total"/> +</td>
            <td>
              <xsl:value-of select="/_R_/get_equation/get_equation/revenue_total"/>
            </td>
            <td>
              <xsl:if test="/_R_/get_equation/get_equation/liabilities_total + /_R_/get_equation/equity_total + /_R_/get_equation/revenue_total">
                <xsl:value-of select="/_R_/get_equation/get_equation/liabilities_total + /_R_/get_equation/equity_total + /_R_/get_equation/revenue_total"/>
              </xsl:if>
            </td>
          </tr>
        </tbody>
      </table>
    </xsl:if>
  </xsl:template>
</xsl:stylesheet>
