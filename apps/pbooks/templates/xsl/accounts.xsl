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
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:include href="html_main.xsl"/>
	<xsl:include href="pager.xsl"/>
	<xsl:include href="account_row.xsl"/>
	<xsl:template name="content">
		<xsl:param name="link_prefix"/>
		<xsl:param name="path_prefix"/>
		<xsl:param name="i18n"/>
		<xsl:call-template name="jquery-setup-simple">
			<xsl:with-param name="my-table">accounts_table</xsl:with-param>
			<xsl:with-param name="no-sort-column">
        , headers: { 4: {sorter: false}, 5: {sorter: false} }
    </xsl:with-param>
		</xsl:call-template>
		<!-- PAGE CONTENT -->

		<!-- Confirm account deletion -->
		<script type="text/javascript">
    var question = '<xsl:value-of select="$i18n/delete_account"/>?';
    function account_delete(account_id,row) {
        if(confirm(question)) {
            $.post("<xsl:value-of select="$link_prefix"/>accounts-delete", {'account_id': account_id},
            function (data){
                myTable = document.getElementById("accounts_table");
                myTable.deleteRow(row);
            });
        }
    }
		</script>
		<xsl:variable name="all_accounts"
			select="/_R_/get_all_accounts/get_all_accounts"/>

		<!-- buttons on the right hand side -->
		<div class="generic-button" style="float: right;">
			<xsl:if test="/_R_/runtime/show_all_accounts='on'">
				<a href="{$link_prefix}accounts&amp;show_all_accounts=off">
					<xsl:value-of select="$i18n/hide_accounts"/>
				</a>
			</xsl:if>

			<xsl:if test="not(/_R_/runtime/show_all_accounts) or /_R_/runtime/show_all_accounts='off'">
				<a href="{$link_prefix}accounts&amp;show_all_accounts=on">
					<xsl:value-of select="$i18n/show_accounts"/>
				</a>
			</xsl:if>

			<a href="{$link_prefix}accounts-edit" class="generic-button" id="new_account">
				<img src="{$path_prefix}{/_R_/runtime/icon_set}/folder_new.gif"/>
				<xsl:value-of select="$i18n/new_account"/>
			</a>
		</div>

		<!-- drop down menu for the account selection -->
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
						<option value="{account_type_id}">
							<xsl:if test="account_type_id=/_R_/_get/account_type_id">
								<xsl:attribute name="selected">selected</xsl:attribute>
							</xsl:if>
							<xsl:value-of select="name"/>
						</option>
					</xsl:for-each>
				</select>
			</form>
		</div>

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
							<xsl:value-of select="$i18n/number"/>
						</th>
						<th>
							<xsl:value-of select="$i18n/account_name"/>
						</th>
						<th>
							<xsl:value-of select="$i18n/type"/>
						</th>
						<th>
							<xsl:value-of select="$i18n/balance"/>
						</th>
						<th>
							<xsl:value-of select="$i18n/edit"/>
						</th>
						<th>
							<xsl:value-of select="$i18n/delete"/>
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
						<xsl:if test="not(/_R_/_get/nid='account-balances')">
							<xsl:for-each select="$all_accounts">
								<xsl:sort select="account_number"/>
								<xsl:call-template name="account-row">
									<xsl:with-param name="link_prefix" select="$link_prefix"/>
									<xsl:with-param name="i18n" select="$i18n"/>
								</xsl:call-template>
							</xsl:for-each>
						</xsl:if>


						<xsl:if test="/_R_/_get/nid='account-balances'">
							<xsl:for-each select="$all_accounts">
								<xsl:sort select="account_number"/>
								<xsl:if test="running_balance &gt; 0">
									<xsl:call-template name="account-row"/>
								</xsl:if>
							</xsl:for-each>
						</xsl:if>
					</xsl:if>

					<!-- Specific account type selected, only show that one -->
					<xsl:if test="/_R_/_get/account_type_id">
						<xsl:if test="not(/_R_/_get/nid='account-balances')">
							<xsl:for-each select="$all_accounts[account_type_id=/_R_/_get/account_type_id]">
								<xsl:sort select="account_number"/>
								<xsl:call-template name="account-row"/>
							</xsl:for-each>
						</xsl:if>
						<xsl:if test="/_R_/_get/nid='account-balances'">
							<xsl:for-each select="$all_accounts">
								<xsl:sort select="account_number"/>
								<xsl:if test="running_balance &gt; 0">
									<xsl:call-template name="account-row"/>
								</xsl:if>
							</xsl:for-each>
						</xsl:if>
					</xsl:if>
				</tbody>
			</table>
			<xsl:if test="/_R_/_get/show_all_accounts='on'">
				<input type="submit" name="submit" value="Submit"/>
			</xsl:if>
		</form>
		<br/>
		<!-- Display the text that explains when accounts can be deleted 
		"An account can only be deleted when there are no journal transactions in that 
		account. If you would like to hide the account, click edit and select the hide option."
		-->
		<xsl:value-of select="$i18n/account_deletion_requirement"/>

	</xsl:template>

	<!-- SEE FILE "account_row.xsl" for the actual table contents -->

</xsl:stylesheet>
