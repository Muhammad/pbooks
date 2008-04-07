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
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" >
<xsl:include href="main.xsl"/>
<xsl:include href="accounting_menu.xsl"/>
<xsl:include href="pager.xsl"/>
<xsl:include href="account_row.xsl"/>
<xsl:template name="content">
<xsl:call-template name="jquery-setup-simple">
    <xsl:with-param name="my-table">accounts_table</xsl:with-param>
</xsl:call-template>

<!-- Confirm account deletion -->
<script type="text/javascript">
    var question = '<xsl:value-of select="/__ROOT__/i18n/labels/label[key='delete_account']/value"/>?';
    function account_delete(id,row) {
        if(confirm(question)) { 
            $.post("<xsl:value-of select="//link_prefix"/>accounts-delete", {'id': id}, 
            function (data){
                myTable = document.getElementById("accounts_table");
                myTable.deleteRow(row);
            });
        }
    }
</script>

<!-- Confirm account deletion -->
<script type="text/javascript">
    var question = '<xsl:value-of select="/__ROOT__/i18n/labels/label[key='delete_account']/value"/>?';
</script>

<!-- buttons on the right hand side -->
<div class="generic-button" style="float: right;">
<xsl:if test="/__ROOT__/show_all_accounts">
    <a href="{__ROOT__/runtime/link_prefix}accounts&amp;show_all_accounts=off">
        <xsl:value-of select="/__ROOT__/i18n/labels/label[key='hide_accounts']/value"/>
    </a>
</xsl:if>

<xsl:if test="not(__ROOT__/show_all_accounts)">
    <a href="{/__ROOT__/runtime/link_prefix}accounts&amp;show_all_accounts=on">
        <xsl:value-of
            select="/__ROOT__/i18n/labels/label[key='show_accounts']/value"/>
    </a>
</xsl:if>

<a href="{/__ROOT__/runtime/link_prefix}customer-edit" class="generic-button">
    <img src="{//path_prefix}{//icon_set}/folder_new.gif"/>
    <xsl:value-of select="/__ROOT__/i18n/labels/label[key='new_customer']/value"/>
</a>
</div>


<br/><br/>

<form method="post" action="{//request_uri}">
<table class="tablesorter" id="accounts_table">
<thead>
<tr>
	<xsl:if test="//_get/show_all_accounts='on'"><th><input type="checkbox"/></th></xsl:if>
    <th><xsl:value-of select="/__ROOT__/i18n/labels/label[key='number']/value"/></th>
    <th><xsl:value-of select="/__ROOT__/i18n/labels/label[key='customer_name']/value"/></th>
    <th><xsl:value-of select="/__ROOT__/i18n/labels/label[key='balance']/value"/></th>
    <th><xsl:value-of select="/__ROOT__/i18n/labels/label[key='edit']/value"/></th>
    <th><xsl:value-of select="/__ROOT__/i18n/labels/label[key='delete']/value"/></th>
</tr>
</thead>
<tbody>

<!-- These are the account table rows. The tests are to decide how the table should be displayed, i.e. whether or not an account 
type is selected, or whether the account balance should be displayed --> 

    <xsl:for-each select="__ROOT__/get_all_accounts[accounts_receivable_account='on']">
        <xsl:sort select="account_number"/>
        <xsl:call-template name="account-row"/>
    </xsl:for-each>

</tbody>
</table>
<xsl:if test="//_get/show_all_accounts='on'">
<input type="submit" name="submit" value="Submit"/>
</xsl:if>
</form>
<br/>
<!-- Display the text that explains when accounts can be deleted 
"An account can only be deleted when there are no journal transactions in that account. If you would like to hide the account, click edit and select the hide option."
-->
<xsl:value-of select="/__ROOT__/i18n/labels/label[key='account_deletion_requirement']/value"/>

</xsl:template>



</xsl:stylesheet>
