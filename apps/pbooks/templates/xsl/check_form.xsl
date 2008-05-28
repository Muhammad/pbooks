<!--
Program: PBooks
Component: check_form.xsl
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
<xsl:template name="content">

<!-- This template references data from the business_object_get_metadata nodes
which stem from a generic query called business_object_get_metadata.xml.
It is used to gather entry metadata for all business objects: checks, bills.. -->
<h2><xsl:value-of select="/_R_/i18n/label[key='write_check']/value"/></h2>

<form
    action="{//runtime/link_prefix}check-submit&amp;entry_id={/_R_/_get/entry_id}"
    method="post" onSubmit="return validateStandard(this, 'myerror');">
<input type="hidden" name="entry_id" value="{/_R_/_get/entry_id}"/>
<div id="check">
    <div id="check_account_id">
    </div>
    <div id="check_date">
        <xsl:value-of select="//i18n/label[key='date']/value"/>:
        <input type="text" name="entry_datetime" 
            value="{substring(/_R_/get_journal_entry/entry_date,0,11)}"/>
    </div>
    <div id="check_number">
        <xsl:value-of select="/_R_/i18n/label[key='check_number']/value"/>:
        <input type="text" name="check_number"
            value="{//get_some_business_objects/check_number}"/>
    </div>
    <div id="check_payee">
        <xsl:value-of select="/_R_/i18n/label[key='check_payee']/value"/>:
        <input type="text" name="check_payee" value="{//get_some_business_objects/check_payee}"/> 
        $<input type="text" name="entry_amount" 
            length="6" value="{/_R_/get_journal_entry/entry_amount}"/>
    </div>
    <div id="check_memo">
        <xsl:value-of select="/_R_/i18n/label[key='memo']/value"/>: 
        <input type="text" name="memorandum">
            <xsl:if test="not(contains(/_R_/get_journal_entry/memorandum,'__'))">
                <xsl:attribute name="value">
                    <xsl:value-of select="/_R_/get_journal_entry/memorandum"/>
                </xsl:attribute>
            </xsl:if>
        </input>
    </div>
    <!-- Link to journal entry form. -->
    <div style="float: right">
        <a href="{/_R_/runtime/link_prefix}journal-entry&amp;entry_id={/_R_/_get/entry_id}">
            <xsl:value-of select="/_R_/i18n/label[key='edit_journal_entry']/value"/>
        </a>
    </div>

    <!-- 
        Select a checking account, if more than one exists.
        -->
    <xsl:if test="count(/_R_/account_business_objects/account_id) &gt; 1">
    <select name="checking_account_id" required="1" exclude="-1" err="Please select a checking account.">
        <option value="-1"><xsl:value-of select="/_R_/i18n/label[key='checking_account']/value"/></option>
        <xsl:for-each select="//account_business_objects">
        <xsl:variable name="my_account_id"><xsl:value-of select="account_id"/></xsl:variable>
            <option value="{id}">
                <xsl:if test="id=//get_journal_entry/account_id 
                    and //get_journal_entry[account_id=$my_account_id]/entry_type_id='Debit'">
                    <xsl:attribute name="selected">selected</xsl:attribute></xsl:if>
            <xsl:value-of select="name"/></option>
        </xsl:for-each>
    </select>
    </xsl:if>
    <!-- Only one checking account. -->
    <xsl:if test="count(/_R_/account_get_checking_accounts/account_id)=1">
    <input type="hidden" name="checking_account_id" 
        value="{/_R_/account_get_checking_accounts/account_id}"/>
    </xsl:if>
</div>


<!--
    Select the expense account.
    -->
<select name="expense_account_id" required="1" 
    exclude="-1" err="Please select a credit account.">
    <option value="-1">
        <xsl:value-of select="/_R_/i18n/label[key='credit_account']/value"/>
    </option>

    <xsl:for-each select="//get_all_accounts">
        <xsl:variable name="my_account_id"><xsl:value-of select="account_id"/></xsl:variable>
        <option value="{id}">
            <xsl:if test="id=//get_journal_entry/account_id 
                and //get_journal_entry[account_id=$my_account_id]/entry_type_id='Credit'">
            <xsl:attribute name="selected">selected</xsl:attribute></xsl:if>
        <xsl:value-of select="name"/></option>
    </xsl:for-each>

    <xsl:if test="not(//get_journal_entry/account_id=//get_all_accounts/account_id) and not(//get_journal_entry/status=9)">
        <option value="{//get_journal_entry/account_id}">
            <xsl:value-of select="/_R_/i18n/label[key='account_hidden']/value"/>
        </option>
    </xsl:if>
</select>


<input type="submit"/>
</form>

</xsl:template>
</xsl:stylesheet>
