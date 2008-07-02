<!--
Program: PBooks
Component: journal_entry.xsl
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
<xsl:include href="pager.xsl"/>

<!-- This template requires explanation. The form contains at least two entry
amounts - one credit and one debit. These are created by templates located
further down the page ( I may separate them into separate files ). If there is 
more than one debit or credit, there can only be one of the other type. 

Sorry for all the white space! Hard to navigate without.
-->

<xsl:template name="content">
<xsl:call-template name="jquery-setup-simple"/>
<script type="text/javascript">
    function journal_entry_amount_delete(entry_amount_id,row) {
            $.post("<xsl:value-of select="/_R_/runtime/link_prefix"/>journal-entry-amount-delete", 
            {
                'entry_amount_id': entry_amount_id
            }, 
            function (data){
            });
            myTable = document.getElementById("entry_form_table");
            if(myTable.getElementsByTagName('tr').length > 4) { 
                myTable.deleteRow(row);
            } else {
                setTimeout('window.location.reload()',200);
            }
    }
    function journal_entry_amount_create(entry_type_id,entry_id,entry_date) {
            $.post("<xsl:value-of select="/_R_/runtime/link_prefix"/>journal-entry-new-"+entry_type_id+"&amp;entry_id="+entry_id, 
            {
                'entry_id': entry_id,
                'entry_datetime': entry_date
            }, 
            function (data){
                setTimeout('window.location.reload()',200);
            });
    }
    
    function debits_summarize() {
        mysum = "";
        for (i=0; i &lt; document.forms[0].length; i++) {
            if(document.forms[0].elements[i].name == "debit_amount_1[]") { 
                mysum = (mysum * 1) + (1 * document.forms[0].elements[i].value);
            } else if (document.forms[0].elements[i].name == "credit_amount_1[]") {
                mytarget = document.forms[0].elements[i];
            } else { 
            }
        }
        mytarget.value = mysum;
    }
</script>

<!-- Non existent entry_id error -->
<xsl:if test="not(/_R_/get_journal_entry/get_journal_entry)">
<div class="error"><xsl:value-of select="//errors/error[key='non_existent_entry_id']/value"/></div>

<table cellpadding="5" align="center">
	<tr>
        <td><a href="{_R_/runtime/link_prefix}{//nid}&amp;entry_id={/_R_/_get/entry_id - 1}">
            <img src="{_R_/runtime/path_prefix}s/images/buttons/out.gif"/>
            </a>
        </td>
        <td>
        <input type="button" style="padding: 5px;" value="Go Back"  onclick="history.go(-1)"/>
        </td>
        <td><a href="{_R_/runtime/link_prefix}{//nid}&amp;entry_id={/_R_/_get/entry_id + 1}">
            <img src="{_R_/runtime/path_prefix}s/images/buttons/in.gif"/>
            </a>
        </td>
	</tr>
</table>
</xsl:if>
<!-- End error message -->





<!-- Check to make sure entry_id exists -->
<xsl:if test="/_R_/get_journal_entry/get_journal_entry">
<!-- The journal entry form -->
<xsl:comment>
    start journal entry form table
</xsl:comment>
<form name="myform" method="post" 
    onSubmit="return validateStandard(this, 'error');" 
    action="{_R_/runtime/link_prefix}journal-edit-submit&amp;entry_id={/_R_/_get/entry_id}">
<xsl:if test="/_R_/_get/entry_id">
    <input type="hidden" name="entry_id" value="{/_R_/_get/entry_id}"/>
</xsl:if>
<div id="journal-entry-form">
<table class="form-table">
	<tr>
		<td>
        <xsl:value-of select="/_R_/i18n/label[key='entry']/value"/> :
        </td>
        <td>
            <xsl:value-of select="/_R_/_get/entry_id"/>
        </td>
	</tr>	
    <tr>
		<td>
            <xsl:value-of select="/_R_/i18n/label[key='date']/value"/> :
        </td>
		<td>
            <input type="text" name="entry_datetime"  id="entry_datetime"
                value="{/_R_/get_journal_entry/get_journal_entry/entry_datetime}"/>
        </td>
        <xsl:if test="/_R_/_get/transaction_id">
            <input type="hidden" name="transaction_id" value="{/_R_/_get/transaction_id}"/>
            <input type="hidden" name="transaction_amount" value="{//entry_amount}"/>
            <input type="hidden" name="transaction_account_id"
            value="{//get_journal_entry/get_journal_entry/account_id}"/>
        </xsl:if>
	</tr>
	<tr>
		<td colspan="2">
            <xsl:value-of select="/_R_/i18n/label[key='amount']/value"/> :
        </td>
    </tr>
    <tr>
		<td colspan="2">
		<table class="tablesorter" id="entry_form_table">
            <thead>
			<tr>
                <th></th>
                <th><xsl:value-of select="/_R_/i18n/label[key='type']/value"/> :</th>
				<th><xsl:value-of select="/_R_/i18n/label[key='accounts']/value"/> :</th>
				<th><xsl:value-of select="/_R_/i18n/label[key='debit']/value"/> :</th>
				<th><xsl:value-of select="/_R_/i18n/label[key='credit']/value"/> :</th>
                <th width="20"></th>
			</tr>
            </thead>
            <tbody>
            <!-- Recursive, aka looping, template for debits
                 calls the journal entry row templates, see below
                 -->
            <xsl:for-each select="/_R_/get_journal_entry/get_journal_entry[entry_type_id='Debit']">
            <xsl:variable name="my_account_id"><xsl:value-of select="account_id"/></xsl:variable>
			    <xsl:call-template name="debit"><xsl:with-param name="my_entry_id" value="{entry_id}"/></xsl:call-template>
            </xsl:for-each>
            <!-- for broken journal entries without a debit -->
            <xsl:if test="not(/_R_/get_journal_entry/get_journal_entry[entry_type_id='Debit'])">
			    <xsl:call-template name="debit"/>
            </xsl:if>

            <!-- Recursive, aka looping, template for credits -->
            <xsl:for-each select="/_R_/get_journal_entry/get_journal_entry[entry_type_id='Credit']">
            <xsl:variable name="my_account_id"><xsl:value-of select="account_id"/></xsl:variable>
			    <xsl:call-template name="credit"><xsl:with-param name="my_entry_id"><xsl:value-of select="entry_amount"/></xsl:with-param>
			    <xsl:with-param name="my_entry_amount_id"><xsl:value-of select="entry_amount_id"/></xsl:with-param></xsl:call-template>
            </xsl:for-each>
            
            <!-- for broken journal entries without a credit -->
            <xsl:if test="not(/_R_/get_journal_entry/get_journal_entry[entry_type_id='Credit'])">
			    <xsl:call-template name="credit"/>
            </xsl:if>
            </tbody>
		</table>
		</td>
	</tr>
	<tr>
		<td><xsl:value-of select="//i18n/label[key='memorandum']/value"/>:</td>
        <td>
            <textarea type="text" name="memorandum" rows="5" cols="35" required="1" err="Please enter a memo.">
            <!-- don't show placeholders -->
            <xsl:if test="
                not
                (
                    contains(/_R_/get_journal_entry/get_journal_entry/memorandum,'__')
                )
                and
                (
                    not(/_R_/get_journal_entry/get_journal_entry=9)
                )
                ">
                <xsl:value-of select="/_R_/get_journal_entry/get_journal_entry/memorandum"/>
            </xsl:if>
            </textarea>
        </td>
	</tr>
	<tr>
		<td colspan="2">


<table>
	<tr>
        <!-- this is an arrow which links to the previous entry_id in the journal -->
        <td>
            <a href="{/_R_/runtime/link_prefix}{//nid}&amp;entry_id={/_R_/_get/entry_id - 1}">
                <img src="{/_R_/runtime/path_prefix}s/images/buttons/out.gif"/>
            </a>
        </td>

        <!-- Submit the entry -->
		<td colspan="3" style="text-align: center">
            <input type="submit" name="submit" id="submit"
                value="Submit" class="generic-button"/>

            <!-- Cancel the entry, if this is from a transaction, 
                the entry must be deleted -->
            <input type="button" class="generic-button" value="Cancel">
                <xsl:if test="/_R_/_get/transaction_id">
                    <xsl:attribute
                    name="onclick">window.location.href='<xsl:value-of 
                    select="/_R_/runtime/link_prefix"/>journal-cancel&amp;transaction_id=<xsl:value-of 
                    select="/_R_/_get/transaction_id"/>'</xsl:attribute>
                </xsl:if>
                <xsl:if test="not(/_R_/_get/transaction_id)">
                    <xsl:attribute 
                    name="onclick">window.location.href='<xsl:value-of 
                    select="/_R_/runtime/link_prefix"/>journal"'</xsl:attribute>
                </xsl:if>
            </input>
            
            <!-- only display in training mode -->
            <xsl:if test="//books_mode='training' and //flip_entry_button='on'">
            <!-- The flip function should only be used in training mode. -->
            <script language="javascript">
            function confirmFlip () { 
                var flip=confirm('<xsl:value-of select="/_R_/i18n/label[key='confirm_flip']/value"/>.');
                if(flip)
                    window.location.href= location.href + '&amp;flip=true';
                else 
                    return false;
            }
            </script>
            <input type="button" class="generic-button" value="Flip" onclick="return confirmFlip();"/>
            </xsl:if>
            <!-- end flip comment -->
        </td>

        <!-- this is an arrow which links to the next entry_id in the journal -->
        <td>
            <a href="{_R_/runtime/link_prefix}{//nid}&amp;entry_id={/_R_/_get/entry_id + 1}">
                <img src="{_R_/runtime/path_prefix}s/images/buttons/in.gif"/>
            </a>
        </td>
	</tr>
</table>

<!-- Note about cancelled transaction entries-->
<xsl:if test="/_R_/_get/transaction_id">
You are creating a journal entry from a transaction. This is good! However, if you plan to abort this process, please use the cancel button. Otherwise the transaction will be associated with an unfinished journal entry. This can be recovered, but it will be much easier if you click the cancel button instead of simply navigating away.

If you want to complete this process, continue as usual. For more information, see <a href="http://www.pbooks.org/trac/ticket/91" target="_blank">http://www.pbooks.org/trac/ticket/91</a>.
</xsl:if>
<!-- end note -->


        </td>
	</tr>
</table> 
</div>
<xsl:comment>end entry form table </xsl:comment>
</form>

<!-- only display in training mode -->
<xsl:if test="//books_mode='training'">
<hr/>
<div  class="generic-button">
<form method="post" action="{/_R_/runtime/link_prefix}journal-delete">
<input type="hidden" name="entry_id" value="{/_R_/_get/entry_id}"/>
<input type="submit" value="Delete this entry" 
    onclick="return confirm('{/_R_/i18n/label[key='confirm_flip']/value}');"/>
</form>
</div>
</xsl:if>
<!-- end training mode -->
</xsl:if>


<script type="text/javascript">
function get_entry_date() 
{
    return document.getElementById("entry_datetime").value;
}
</script>    
</xsl:template>
<!-- end form template -->














<!--
    These are the journal entry row templates. They are fairly complex and somewhat messy. 
    TODO: Clean these up!
    -->

<!-- CREDIT -->
<xsl:template name="credit">
<xsl:variable name="my_account_id"><xsl:value-of select="account_id"/></xsl:variable>
<xsl:variable name="my_entry_amount_id"><xsl:value-of select="entry_amount_id"/></xsl:variable>
<tr class="odd">
    <td>
    <xsl:if test="count(//get_journal_entry/get_journal_entry[entry_type_id='Debit'])&lt;2 and (entry_amount=0 or /_R_/_get/transaction_id or not(entry_amount) or not(//get_journal_entry/get_journal_entry[entry_type_id='Debit']))">
    <a onclick="journal_entry_amount_create('credit',{/_R_/_get/entry_id},get_entry_date()); return false;">
        <img src="{/_R_/runtime/path_prefix}{/_R_/runtime/icon_set}add.png"/>
    </a>
    </xsl:if>
    </td>
    <td>
        <xsl:value-of select="/_R_/i18n/label[key='credit']/value"/>:
    </td>
    <td>
    <div style="padding-left: 40px;">
    <select name="credit_account_1[]" required="1" exclude="-1" err="Please select a credit account.">
        <option value="-1"><xsl:value-of select="/_R_/i18n/label[key='credit_account']/value"/></option>
        <xsl:for-each select="//get_all_accounts">
            <option value="{id}"><xsl:if test="id=//get_journal_entry/get_journal_entry[entry_amount_id=$my_entry_amount_id]/account_id and not(/_R_/_get/transaction_id)"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if>

<xsl:if test="/_R_/_get/transaction_id">
<xsl:if test="(//get_journal_entry/get_journal_entry/entry_amount &gt;0 and (//get_journal_entry/get_journal_entry/account_type_id=20000 or //get_journal_entry/get_journal_entry/account_type_id=30000 or //get_journal_entry/get_journal_entry/account_type_id=40000)) or (//get_journal_entry/get_journal_entry/entry_amount &lt; 0 and (//get_journal_entry/get_journal_entry/account_type_id=10000 or //get_journal_entry/get_journal_entry/account_type_id=50000))"><xsl:if test="id=//get_journal_entry/get_journal_entry/account_id"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if><xsl:if test="not(id=//get_journal_entry/get_journal_entry/account_id)"><xsl:attribute name="disabled">disabled</xsl:attribute></xsl:if></xsl:if>
</xsl:if>

            <xsl:value-of select="name"/>
        </option>
        </xsl:for-each>

        <!-- HIDDEN ACCOUNT -->
        <xsl:if test="not(//get_journal_entry/get_journal_entry[entry_amount_id=$my_entry_amount_id]/account_id=//get_all_accounts/get_all_accounts/id) 
        and not(//get_journal_entry/get_journal_entry/status=9)
        and not(/_R_/_get/transaction_id)">
            <option value="{//get_journal_entry/get_journal_entry/account_id}" selected="selected">
                <xsl:value-of select="/_R_/i18n/label[key='account_hidden']/value"/>
            </option>
        </xsl:if>
    </select></div>
    </td>
    <td></td>
    <td style="white-space: nowrap;">
        <xsl:value-of select="//runtime/default_currency_unit"/>
        <input name="credit_amount_1[]" 
        type="text" size="6" required="1"  equals="sum(debit_amount_1)" 
        err="Credit and Debit amounts must be equal. ">
        <xsl:attribute name="value">
            <xsl:if test="not(/_R_/_get/transaction_id)">
                <xsl:value-of select="entry_amount"/>
            </xsl:if>
            <xsl:if test="/_R_/_get/transaction_id">
                <xsl:call-template name="abs-amount"/>
            </xsl:if>
        </xsl:attribute>
        <xsl:if test="
            (
                //get_journal_entry/get_journal_entry/entry_amount &gt;0 
                and 
                (
                //get_journal_entry/get_journal_entry/account_type_id=20000 
                or //get_journal_entry/get_journal_entry/account_type_id=30000 
                or //get_journal_entry/get_journal_entry/account_type_id=40000
                )
            )
            or
            (
                //get_journal_entry/get_journal_entry/entry_amount &lt;0 
                and 
                (
                //get_journal_entry/get_journal_entry/account_type_id=10000 
                or //get_journal_entry/get_journal_entry/account_type_id=50000
                )
            )
            ">
                <xsl:if test="not(id=//get_journal_entry/get_journal_entry/account_id)">
                    <xsl:attribute name="readonly">readonly</xsl:attribute>
                </xsl:if>
            </xsl:if>
        </input>
    </td>

    <td>
    <xsl:if test="count(//get_journal_entry/get_journal_entry[entry_type_id='Credit']) &gt; 1">
        <a href="{/_R_/runtime/link_prefix}journal_entry_amount_delete&amp;entry_amount_id={entry_amount_id}" 
        onclick="journal_entry_amount_delete({entry_amount_id},this.parentNode.parentNode.rowIndex); return false;">
        <img src="{/_R_/runtime/path_prefix}{/_R_/runtime/icon_set}delete.png"/></a>
    </xsl:if>
    <xsl:if test="count(//get_journal_entry/get_journal_entry[entry_type_id='Debit']) &gt; 1">
        <a href=""
        onclick="debits_summarize(); return false;">
        <img src="{/_R_/runtime/path_prefix}{/_R_/runtime/icon_set}icon_accept.gif"/></a>
    </xsl:if>
    </td>
</tr>
</xsl:template>






<!-- DEBIT -->
<xsl:template name="debit">
<xsl:variable name="my_entry_amount"><xsl:value-of select="entry_amount"/></xsl:variable>
<tr>
    <td>
    <xsl:if test="count(//get_journal_entry/get_journal_entry[entry_type_id='Credit'])&lt;2 and (entry_amount=0.00 or not(entry_amount) or /_R_/_get/transaction_id or not(//get_journal_entry/get_journal_entry[entry_type_id='Credit']))">
    <a onclick="journal_entry_amount_create('debit',{/_R_/_get/entry_id},get_entry_date()); return false;">
        <img src="{/_R_/runtime/path_prefix}{/_R_/runtime/icon_set}add.png"/>
    </a>
    </xsl:if>
    </td>
    <td><xsl:value-of select="/_R_/i18n/label[key='debit']/value"/>:</td>
    <td><select name="debit_account_1[]" required="1" exclude="-1" err="Please select a debit account.">
            <option value="-1"><xsl:value-of select="/_R_/i18n/label[key='debit_account']/value"/></option>
            <xsl:for-each select="//get_all_accounts">
                <option value="{id}">
                <!-- Existing entry? -->
                <xsl:if test="id=//get_journal_entry/get_journal_entry[entry_type_id='Debit'][entry_amount=$my_entry_amount]/account_id and not(/_R_/_get/transaction_id)"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if>
                <!-- Existing transaction? -->
                <xsl:if test="/_R_/_get/transaction_id">
                <!-- Is the transaction a debit? -->
                <xsl:if test="(//get_journal_entry/get_journal_entry/entry_amount &lt;0 and (//get_journal_entry/get_journal_entry/account_type_id=20000 or //get_journal_entry/get_journal_entry/account_type_id=30000 or //get_journal_entry/get_journal_entry/account_type_id=40000)) or (//get_journal_entry/get_journal_entry/entry_amount &gt;0 and (//get_journal_entry/get_journal_entry/account_type_id=10000 or //get_journal_entry/get_journal_entry/account_type_id=50000))"><xsl:if test="id=//get_journal_entry/get_journal_entry/account_id"><xsl:attribute name="selected">selected="selected"</xsl:attribute></xsl:if><xsl:if test="not(id=//get_journal_entry/get_journal_entry/account_id)"><xsl:attribute name="disabled">disabled</xsl:attribute></xsl:if></xsl:if>
                <!-- If not, does the memo match up with an account's metadata? -->
                <xsl:if test="(//get_journal_entry/get_journal_entry/entry_amount &gt;0 and 
                (//get_journal_entry/get_journal_entry/account_type_id=20000 or //get_journal_entry/get_journal_entry/account_type_id=30000 or //get_journal_entry/get_journal_entry/account_type_id=40000)) or (//get_journal_entry/get_journal_entry/entry_amount &lt;0 and (//get_journal_entry/get_journal_entry/account_type_id=10000 or //get_journal_entry/get_journal_entry/account_type_id=50000))"><xsl:if test="contains(description,substring(//get_journal_entry/get_journal_entry/memorandum,1,7)) or contains(description,//get_journal_entry/get_journal_entry/entry_amount)"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if></xsl:if>

                </xsl:if>
                <!--<xsl:value-of select="account_type_id"/> -->
                <xsl:value-of select="name"/>
                </option>
            </xsl:for-each>
            
            <!-- HIDDEN ACCOUNT -->
            <xsl:if test="not(//get_journal_entry/get_journal_entry[entry_type_id='Debit'][entry_amount=$my_entry_amount]/account_id=//get_all_accounts//id) and not(//get_journal_entry/get_journal_entry/status=9)
            and not(/_R_/_get/transaction_id)">
                <option value="{//get_journal_entry/get_journal_entry/account_id}" selected="selected">
                    <xsl:value-of select="/_R_/i18n/label[key='account_hidden']/value"/>
                </option>
            </xsl:if>
        </select>
    </td>
    <td style="white-space: nowrap;">
        <xsl:value-of select="//runtime/default_currency_unit"/>
        <input name="debit_amount_1[]"  type="text" size="6" required="1" regexp="/^\d+([\.]\d\d)?$/" 
        err="Please enter a monetary value for the debit and credit. Do not include $ signs.">
        <xsl:attribute name="value">
            <xsl:if test="not(/_R_/_get/transaction_id)">
                <xsl:value-of select="entry_amount"/>
            </xsl:if>
            <xsl:if test="/_R_/_get/transaction_id">
                <xsl:call-template name="abs-amount"/>
            </xsl:if>
        </xsl:attribute>
        </input>
    </td>
    <td></td>
    
    <td>
    <xsl:if test="count(//get_journal_entry/get_journal_entry[entry_type_id='Debit']) &gt; 1">
        <a href="{/_R_/runtime/link_prefix}journal_entry_amount_delete&amp;entry_amount_id={entry_amount_id}" 
        onclick="journal_entry_amount_delete({entry_amount_id},this.parentNode.parentNode.rowIndex); return false;">
            <img src="{/_R_/runtime/path_prefix}{/_R_/runtime/icon_set}delete.png" />
        </a>
    </xsl:if>
    </td>
</tr>
</xsl:template>



<xsl:template name="abs-amount">
    <xsl:if test="//get_journal_entry/get_journal_entry/entry_amount &lt;0">
        <xsl:value-of select="0 - //get_journal_entry/get_journal_entry/entry_amount"/>
    </xsl:if>
    <xsl:if test="//get_journal_entry/get_journal_entry/entry_amount &gt;0">
        <xsl:value-of select="//get_journal_entry/get_journal_entry/entry_amount"/>
    </xsl:if>
</xsl:template>
</xsl:stylesheet>
