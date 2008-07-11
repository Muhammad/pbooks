<!--
Program: PBooks
Component: customer_accounts.xsl
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
  <xsl:include href="pager.xsl"/>
  <xsl:include href="account_row.xsl"/>
  <xsl:template name="content">
  <xsl:param name="link_prefix"/>
    <xsl:call-template name="jquery-setup-simple">
      <xsl:with-param name="my-table">accounts_table</xsl:with-param>
      <xsl:with-param name="no-sort-column">
        , headers: { 3: {sorter: false}, 4: {sorter: false} }
    </xsl:with-param>
    </xsl:call-template>

<!-- Confirm account deletion -->
    <script type="text/javascript">
    var question = '<xsl:value-of select="/_R_/i18n/delete_account"/>?';
    function account_delete(id,row) {
        if(confirm(question)) { 
            $.post("<xsl:value-of select="$link_prefix"/>accounts-delete", {'id': id}, 
            function (data){
                myTable = document.getElementById("accounts_table");
                myTable.deleteRow(row);
            });
        }
    }
</script>

<!-- Confirm account deletion -->
    <script type="text/javascript">
    var question = '<xsl:value-of select="/_R_/i18n/delete_account"/>?';
</script>

<!-- buttons on the right hand side -->
    <div class="generic-button" style="float: right;">
      <xsl:if test="/_R_/show_all_accounts">
        <a href="{$link_prefix}customer-accounts&amp;show_all_accounts=off">
          <xsl:value-of select="/_R_/i18n/hide_accounts"/>
        </a>
      </xsl:if>

      <xsl:if test="not(/_R_/show_all_accounts)">
        <a href="{$link_prefix}customer-accounts&amp;show_all_accounts=on">
          <xsl:value-of select="/_R_/i18n/show_accounts"/>
        </a>
      </xsl:if>

      <a href="{$link_prefix}customer-edit" class="generic-button">
        <img src="{/_R_/runtime/path_prefix}{/_R_/runtime/icon_set}/folder_new.gif"/>
        <xsl:value-of select="/_R_/i18n/new_customer"/>
      </a>
    </div>


    <br/>
    <br/>

    <form method="post">
      <table class="tablesorter" id="accounts_table">
        <thead>
          <tr>
            <xsl:if test="/_R_/_get/show_all_accounts='on'">
              <th>
                <input type="checkbox"/>
              </th>
            </xsl:if>
            <th>
              <xsl:value-of select="/_R_/i18n/number"/>
            </th>
            <th>
              <xsl:value-of select="/_R_/i18n/customer_name"/>
            </th>
            <th>
              <xsl:value-of select="/_R_/i18n/balance"/>
            </th>
            <th>
              <xsl:value-of select="/_R_/i18n/edit"/>
            </th>
            <th>
              <xsl:value-of select="/_R_/i18n/delete"/>
            </th>
          </tr>
        </thead>
        <tbody>

<!-- These are the account table rows.
    The tests are to decide how the table should be displayed,
    i.e. whether or not an account type is selected, or whether
    the account balance should be displayed.
    See account_row.xsl for the actual row data. -->

          <xsl:for-each select="/_R_/get_all_accounts/get_all_accounts[accounts_receivable_account='on']">
            <xsl:sort select="account_number"/>
            <xsl:call-template name="account-row"/>
          </xsl:for-each>

        </tbody>
      </table>
      <xsl:if test="/_R_/_get/show_all_accounts='on'">
        <input type="submit" name="submit" value="Submit"/>
      </xsl:if>
    </form>
    <br/>


  </xsl:template>
</xsl:stylesheet>
