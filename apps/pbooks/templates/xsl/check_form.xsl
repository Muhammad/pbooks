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
or write to the Free Software Foundation, Inc., 51 Franklin Street,
Fifth Floor, Boston, MA 02110-1301 USA
-->
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
xmlns="http://www.w3.org/1999/xhtml">
  <xsl:include href="html_main.xsl"/>
  <xsl:template name="content">
    <xsl:param name="link_prefix"/>
    <xsl:variable name="get_journal_entry"
		select="/_R_/get_journal_entry/get_journal_entry" />


<!--
This template references data from the business_object_get_metadata nodes
which stem from a generic query called business_object_get_metadata.xml.
It is used to gather entry metadata for all business objects: checks, bills.
-->
<h2>
  <span id="i18n-write_check">Write Check</span>
</h2>

<form action="{$link_prefix}check-submit&amp;entry_id={/_R_/_get/entry_id}"
  method="post" onSubmit="return validateStandard(this, 'myerror');">
  <input type="hidden" name="entry_id" value="{/_R_/_get/entry_id}"/>
  <input type="hidden" name="fiscal_period_id" value="{/_R_/runtime/current_fiscal_period_id}"/>
  <div id="business_object_slip">
    <div id="check_account_id"/>
    <div id="check_date">
      <span class="i18n-date">Date</span>:
    <input type="text" name="entry_datetime" class="seven"
      value="{substring($get_journal_entry/entry_date,0,11)}"/>
    </div>
    <div id="check_number">
      <span class="i18n-check_number">Check Number</span>:
    <input type="text" name="check_number" class="five"
      value="{//get_some_business_objects/get_some_business_objects/check_number}"/>
    </div>
    <div id="check_payee">
      <span class="i18n-check_payee">Check Payee</span>:
    <input type="text" name="check_payee"
      value="{//get_some_business_objects/get_some_business_objects/check_payee}"/>
    $<input type="text" name="credit_amount_1[]" id="credit_amount" class="seven"
      value="{$get_journal_entry/entry_amount}"
      onkeyup="copyValue('credit_amount','debit_amount')" />


    <input type="hidden" name="debit_amount_1[]" id="debit_amount" />
    </div>
    <div id="check_memo">
      <span class="i18n-memo">Memorandum</span>: 
      <input type="text" name="memorandum">
        <xsl:if test="not(contains($get_journal_entry/memorandum,'__'))">
            <xsl:attribute name="value" select="$get_journal_entry/memorandum"/>
        </xsl:if>
      </input>
    </div>
    <!-- Link to journal entry form. -->
    <div style="float: right">
      <a href="{$link_prefix}journal-entry&amp;entry_id={/_R_/_get/entry_id}">
        <span class="i18n-edit_journal_entry">Edit Journal Entry</span>
      </a>
    </div>

    <!-- Select a checking account, if more than one exists. -->
    <xsl:if test="count(/_R_/account_business_objects/account_business_objects/account_id) &gt; 1">
      <select name="credit_account_1[]" required="1" exclude="-1"
        err="Please select a checking account.">
        <option value="-1">
          <span class="i18n-checking_account">Checking Account</span>
        </option>
        <xsl:for-each select="/_R_/account_business_objects/account_business_objects">
          <xsl:variable name="my_account_id" select="account_id"/>
          <option value="{id}">
            <xsl:if test="$get_journal_entry[account_id=$my_account_id]/entry_type_id='Credit'">
              <xsl:attribute name="selected">selected</xsl:attribute>
            </xsl:if>
            <xsl:value-of select="name"/>
          </option>
        </xsl:for-each>
      </select>
    </xsl:if>
    <!-- Only one checking account. -->
    <xsl:if test="count(/_R_/account_get_checking_accounts/account_get_checking_accounts/account_id)=1">
      <input type="hidden" name="checking_account_id"
      value="{/_R_/account_get_checking_accounts/account_get_checking_accounts/account_id}"/>
    </xsl:if>
  </div>

  <!-- Select the expense account. -->
  <select name="debit_account_1[]" required="1" exclude="-1"
    err="Please select a debit account.">
    <option value="-1">
      <span class="i18n-debit_account">Debit Account</span>
    </option>

    <xsl:for-each select="/_R_/get_all_accounts/get_all_accounts">
      <xsl:variable name="my_account_id" select="id"/>
      <option value="{id}">
        <xsl:if
        test="$get_journal_entry[entry_type_id='Debit']/account_id=$my_account_id">
          <xsl:attribute name="selected">selected</xsl:attribute>
        </xsl:if>
        <xsl:value-of select="name"/>
      </option>
    </xsl:for-each>
    <xsl:if
      test="
      not($get_journal_entry[entry_type_id='Debit']/account_id=//get_all_accounts/get_all_accounts/id) and
      not($get_journal_entry/status=9)">
      <option value="{/_R_/get_journal_entry/get_journal_entry[entry_type_id='Debit']/account_id}">
        <span class="i18n-account_hidden">Account Hidden</span>
      </option>
    </xsl:if>
  </select>

  <br/>
  <br/>
  <input type="submit"/>
</form>


  </xsl:template>
</xsl:stylesheet>
