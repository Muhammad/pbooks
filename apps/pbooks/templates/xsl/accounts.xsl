<!--
Program: PBooks
Component: accounts.xsl
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
	<xsl:include href="pager.xsl"/>
	<xsl:include href="account_row.xsl"/>
	<xsl:template name="content">
		<xsl:param name="link_prefix"/>
		<xsl:param name="path_prefix"/>
		<xsl:param name="i18n"/>
		<xsl:variable name="all_accounts"
		select="/_R_/get_all_accounts/get_all_accounts" />


<script type="text/javascript"
src="{$link_prefix}x-tablesorter-setup-js&amp;selector=accounts_table&amp;simple=true" />


<!-- buttons on the right hand side -->
<div class="generic-button" style="float: right;">
  <xsl:if test="/_R_/runtime/show_all_accounts='on'">
    <a href="{$link_prefix}accounts&amp;show_all_accounts=off">
      <xsl:value-of select="$i18n/hide_accounts"/>
    </a>
  </xsl:if>

  <xsl:if test="not(/_R_/runtime/show_all_accounts) or
  /_R_/runtime/show_all_accounts='off'">
    <a href="{$link_prefix}accounts&amp;show_all_accounts=on">
      <span id="i18n-show_accounts">Show Accounts</span>
    </a>
  </xsl:if>

  <a href="{$link_prefix}accounts-edit" class="generic-button" id="new_account">
    <img src="{$path_prefix}{/_R_/runtime/icon_set}/folder_new.gif"/>
    <xsl:value-of select="$i18n/new_account"/>
  </a>
</div>

<!-- drop down menu for the account type selection -->
<div style="float: top;">
  <form method="get" action="{$link_prefix}">
    <input type="hidden" name="nid" value="{/_R_/_get/nid}"/>
    <!-- Select one type of account -->
    <select name="account_type_id" onchange="this.form.submit();">
      <option value="%">
        <xsl:value-of select="$i18n/all"/>
      </option>
      <!-- Special Case -->
      <xsl:for-each select="/_R_/account_types/account_type">
        <option value="{account_type_id}" id="at_{account_type_id}">
          <xsl:value-of select="name"/>
        </option>
      </xsl:for-each>
    </select>
  </form>
</div>

<form method="post">
<div class="tableframe">
  <table class="tablesorter" id="accounts_table">
    <thead>
      <tr>
        <xsl:if test="/_R_/_get/show_all_accounts='on'">
          <th>
            <input type="checkbox"/>
          </th>
        </xsl:if>
        <th>
          <span id="i18n-number">Number</span>
        </th>
        <th>
          <span id="i18n-account_name">Account Name</span>
        </th>
        <th>
          <span id="i18n-type">Type</span>
        </th>
        <th>
          <span id="i18n-balance">Balance</span>
        </th>
        <th class="{{sorter: false}}">
          <span id="i18n-edit">Edit</span>
        </th>
        <th class="{{sorter: false}}">
          <span id="i18n-delete">Delete</span>
        </th>
      </tr>
    </thead>
    <tbody>

    <!--
    These are the account table rows. The tests are to decide how the table
    should be displayed, i.e. whether or not an account type is selected,
    or whether the account balance should be displayed
    -->

      <!-- No specific account type selected, show all -->
      <xsl:if test="not(/_R_/_get/account_type_id) or /_R_/_get/account_type_id='%'">
        <xsl:for-each select="$all_accounts">
          <xsl:sort select="account_number"/>
          <xsl:call-template name="account-row">
            <xsl:with-param name="link_prefix" select="$link_prefix"/>
            <xsl:with-param name="i18n" select="$i18n"/>
          </xsl:call-template>
        </xsl:for-each>
      </xsl:if>

      <!-- Specific account type selected, only show that one -->
      <xsl:if test="/_R_/_get/account_type_id">
        <xsl:for-each select="$all_accounts[account_type_id=/_R_/_get/account_type_id]">
          <xsl:sort select="account_number"/>
          <xsl:call-template name="account-row">
            <xsl:with-param name="link_prefix" select="$link_prefix"/>
            <xsl:with-param name="i18n" select="$i18n"/>
          </xsl:call-template>
        </xsl:for-each>
      </xsl:if>
    </tbody>
  </table>
  </div>
  <xsl:if test="/_R_/_get/show_all_accounts='on'">
    <input type="submit" name="submit" value="Submit"/>
  </xsl:if>
</form>
<br/>
<!-- 
Display the text that explains when accounts can be deleted
"An account can only be deleted when there are no journal transactions in that
account. If you would like to hide the account, click edit and select the hide option." -->
<div class="table_meta">
<xsl:value-of select="$i18n/account_deletion_requirement"/>
</div>
<xsl:if test="/_R_/_get/account_type_id">
<script type="text/javascript">
  $("#at_"+<xsl:value-of select="/_R_/_get/account_type_id"/>).attr("selected","selected");
</script>
</xsl:if>
</xsl:template>

<!-- SEE FILE "account_row.xsl" for the actual table contents -->

</xsl:stylesheet>
