<!--
Program: PBooks
Component: deposit_form.xsl
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
<xsl:import href="main.xsl"/>
<xsl:template name="content">
<script type="text/javascript" src="{__ROOT__/runtime/path_prefix}/s/js/jquery.js">&#160;</script>
<script type="text/javascript">
    function journal_entry_amount_delete(entry_amount_id,row) {
            $.post("<xsl:value-of select="//link_prefix"/>journal-entry-amount-delete", 
            {
                'entry_amount_id': entry_amount_id
            }, 
            function (data){
            });
            myTable = document.getElementById("deposit_form_table");
            myTable.deleteRow(row);
    }
    function journal_entry_amount_create(entry_type_id,entry_id,entry_date) {
            $.post("<xsl:value-of select="//link_prefix"/>journal-entry-new-"+entry_type_id+"&amp;entry_id="+entry_id, 
            {
                'entry_id': entry_id,
                'entry_datetime': entry_date
            }, 
            function (data){
                setTimeout('window.location.reload()',200);
            });
    }
</script>
<h2><xsl:value-of select="/__ROOT__/i18n/labels/label[key='make_deposits']/value"/></h2>

<form action="{/__ROOT__/runtime/link_prefix}deposit-submit&amp;entry_id={/__ROOT__/_get/entry_id}" 
method="post" onSubmit="return validateStandard(this, 'myerror');">
<!-- If there is more than one deposit account, the user needs to select which one the deposit is being made into -->
<xsl:if test="count(//account_business_objects) &gt; 1">
<select name="deposit_account_id" required="1" exclude="-1" 
    err="{/__ROOT__/i18n/labels/label[key='error_select_debit']/value}">
    <option value="-1">
        <xsl:value-of select="/__ROOT__/i18n/labels/label[key='deposit_account']/value"/>
    </option>
    <xsl:for-each select="//account_business_objects">
        <option value="{id}">
            <xsl:if test="id=//get_journal_entry/account_id 
                and //get_journal_entry/entry_type_id='Debit'">
                <xsl:attribute name="selected">selected</xsl:attribute>
            </xsl:if>
            <xsl:value-of select="name"/>
        </option>
    </xsl:for-each>
</select>
</xsl:if>
<!-- If there is only one deposit account, just use that id -->
<xsl:if test="count(//account_business_objects) = 1">
<xsl:value-of select="//account_business_objects/name"/>
<input type="hidden" name="deposit_account_id" value="{//account_business_objects/id}"/>
</xsl:if>
<input type="hidden" name="entry_id" value="{/__ROOT__/_get/entry_id}"/>
<div id="deposit">
    <div id="my_deposit_account_id">
    </div>
    <div id="deposit_date">
        <xsl:value-of select="/__ROOT__/i18n/labels/label[key='date']/value"/>: 
		<input type="text" name="entry_datetime" value="{/__ROOT__/get_journal_entry/entry_date}"/>
    </div>
    <div id="deposit_memo">
        <xsl:value-of select="/__ROOT__/i18n/labels/label[key='memo']/value"/>: 
		<input type="text" name="memorandum" value="{/__ROOT__/get_journal_entry/memorandum}"/>
    </div>
    <div id="deposit_payee">
        <table border="0" id="deposit_form_table">
            <xsl:if test="//deposits_cash='yes'">
            <tr>
                <td><xsl:value-of select="/__ROOT__/i18n/labels/label[key='cash']/value"/></td>
				<td><xsl:value-of select="/__ROOT__/i18n/labels/label[key='amount']/value"/></td>
                <td></td>
                <td><xsl:value-of select="/__ROOT__/i18n/labels/label[key='source']/value"/></td>
			</tr>
            <tr>
                <!-- Here the check number is the equivalent of a journal entry memorandum -->
                <td><input type="text" name="check_number[]" style="width: 50px;" value="{/__ROOT__/get_journal_entry/entry_amount_memorandum}"/>
				</td>
                <td>$<input type="text" name="entry_amount[]"  style="width: 100px;" value="{/__ROOT__/get_journal_entry/entry_amount}"/>
				</td>
                <td>
					<!-- only one cash entry is allowed -->
				</td>
                <td>
					<select name="from_account_id" required="0" exclude="-1" err="{/__ROOT__/i18n/labels/label[key='error_select_credit']/value}">
						<option value="-1">
							<xsl:value-of select="/__ROOT__/i18n/labels/label[key='outstanding_invoices']/value"/>
						</option>
                        <option value="0">
							<xsl:value-of select="/__ROOT__/i18n/labels/label[key='not_applicable']/value"/>
						</option>
					<xsl:for-each select="//get_some_business_objects">
						<xsl:variable name="my_new_entry_id">
							<xsl:value-of select="entry_id"/>
						</xsl:variable>
						<xsl:variable name="my_client_id">
							<xsl:value-of select="//business_object_get_metadata[meta_key='client_id' and entry_id=$my_new_entry_id]/meta_value"/>
						</xsl:variable>

						<option value="{id}"><xsl:if test="id=//metadata/account_id and not(//_get/transaction_id)">
							<xsl:attribute name="selected">selected</xsl:attribute></xsl:if>
						<xsl:value-of select="//business_object_get_metadata[meta_key='invoice_number' and entry_id=$my_new_entry_id]/meta_value"/> - 
						<xsl:value-of select="//clients/clients/client[client_id=$my_client_id]/client_name"/>
						
							<xsl:value-of select="name"/>
						</option>
					</xsl:for-each>
					</select>
                </td>
            </tr>
            </xsl:if>
            <tr>
                <td><xsl:value-of select="/__ROOT__/i18n/labels/label[key='checks']/value"/></td>
				<td>Amount</td>
                <td></td>
                <td></td>
			</tr>
            <xsl:for-each select="//get_journal_entry[entry_type_id='Credit']">
            <xsl:variable name="my_entry_amount_id"><xsl:value-of select="entry_amount_id"/></xsl:variable>
			<xsl:variable name="my_entry_id"><xsl:value-of select="entry_id"/></xsl:variable>
            <tr>
                <!-- Here the check number is the equivalent of a journal entry memorandum -->
                <td><input type="text" name="check_number[]" style="width: 50px;" value="{/__ROOT__/get_journal_entry[entry_amount_id=$my_entry_amount_id]/entry_amount_memorandum}"/>
				</td>
                <td>$<input type="text" name="entry_amount[]"  style="width: 100px;" value="{/__ROOT__/get_journal_entry[entry_amount_id=$my_entry_amount_id]/entry_amount}"/>
				</td>
                <!-- Additional deposit line items. -->
                <td>
                    <xsl:if test="position() &gt; 1">
                    <a href="{//link_prefix}journal_entry_amount_delete&amp;entry_amount_id={entry_amount_id}" 
                    onclick="journal_entry_amount_delete({entry_amount_id},this.parentNode.parentNode.rowIndex); return false;">
                    <img src="{//path_prefix}{//icon_set}delete.png" border="0" /></a>
                    </xsl:if>
                </td>
                <!-- OUTSTANDING INVOICES DROP DOWN LIST HERE -->
                <td>
					<select name="from_account_id" required="0" exclude="-1" err="{/__ROOT__/i18n/labels/label[key='error_select_credit']/value}">
						<option value="-1">
							<xsl:value-of select="/__ROOT__/i18n/labels/label[key='outstanding_invoices']/value"/>
						</option>
                        <option value="0">
							<xsl:value-of select="/__ROOT__/i18n/labels/label[key='not_applicable']/value"/>
						</option>
					<xsl:for-each select="//get_some_business_objects">
						<xsl:variable name="my_new_entry_id">
							<xsl:value-of select="entry_id"/>
						</xsl:variable>
						<xsl:variable name="my_client_id">
							<xsl:value-of select="//business_object_get_metadata[meta_key='client_id' and entry_id=$my_new_entry_id]/meta_value"/>
						</xsl:variable>

						<option value="{id}"><xsl:if test="id=//metadata/account_id and not(//_get/transaction_id)">
							<xsl:attribute name="selected">selected</xsl:attribute></xsl:if>
						<xsl:value-of select="//business_object_get_metadata[meta_key='invoice_number' and entry_id=$my_new_entry_id]/meta_value"/> - 
						<xsl:value-of select="//clients/clients/client[client_id=$my_client_id]/client_name"/>

							<xsl:value-of select="name"/>
						</option>
					</xsl:for-each>
					</select>
                </td>
			</tr>
            </xsl:for-each>

            <tr>
                <td colspan="2"></td>
                <td><a href="{//link_prefix}journal-entry-new-credit&amp;entry_id={//_get/entry_id}">
        <img onclick="journal_entry_amount_create('credit',{//_get/entry_id}); return false;" src="{//path_prefix}{//icon_set}add.png" border="0"/></a></td>
                <td></td>
            </tr>
        </table>

        <!-- Link to journal entry form. -->
        <div style="float: right">
            <a href="{/__ROOT__/runtime/link_prefix}journal-entry&amp;entry_id={/__ROOT__/_get/entry_id}">
                <xsl:value-of select="/__ROOT__/i18n/labels/label[key='edit_journal_entry']/value"/>
            </a>
        </div>
	</div>

</div>



<!-- need to select where the money is coming from - or is it accounts receivable? -->
<select name="revenue_account_id" required="1" exclude="-1" err="{/__ROOT__/i18n/labels/label[key='error_select_credit']/value}">
    <option value="-1"><xsl:value-of select="/__ROOT__/i18n/labels/label[key='credit_account']/value"/></option>
    <xsl:for-each select="//get_all_accounts">
        <option value="{id}"><xsl:if test="id=//get_journal_entry/account_id and not(//_get/transaction_id)"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if>
        <xsl:value-of select="name"/></option>
    </xsl:for-each>
</select>
        
        
<input type="submit" id="submit-me"/>
</form>

</xsl:template> 
</xsl:stylesheet>
