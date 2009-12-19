<!--
Program: PBooks
Component: transfer_form.xsl
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
		<xsl:param name="path_prefix"/>


<form action="{$link_prefix}transfer-submit&amp;entry_id={/_R_/_get/entry_id}"
  method="post"
  onSubmit="return validateStandard(this, 'myerror');">
  <input type="hidden" name="entry_id" value="{/_R_/_get/entry_id}"/>
  <table>
    <tr>
      <td>
        <span class="i18n-date">Date</span>:
      </td>
      <td>
        <input type="text" name="entry_datetime"
        value="{//get_journal_entry/get_journal_entry/entry_datetime}"/>
      </td>
    </tr>
    <tr>
      <td>
        <span class="i18n-memo">Memorandum</span>:
      </td>
      <td>
        <input type="text" name="memorandum" value="{//get_some_business_objects/memorandum}"/>
      </td>
    </tr>
    <tr>
      <td>
        <span class="i18n-amount">Amount</span>:
      </td>
      <td>
        <input type="text" name="credit_amount_1[]" id="credit_amount"
          onkeyup="copyValue('credit_amount','debit_amount')"
           value="{//get_some_business_objects/entry_amount}"/>

        <input type="hidden" name="debit_amount_1[]" id="debit_amount" />
      </td>
    </tr>
    <tr>
      <td>
        <span class="i18n-from">From</span>:
      </td>
      <td>
        <select name="credit_account_1[]" required="1" exclude="-1"
          err="{//i18n/error_select_credit}">
          <option value="-1">
            <span class="i18n-from_account">From Account</span>
          </option>
          <xsl:for-each select="//get_all_accounts/get_all_accounts">
            <xsl:variable name="my_account_id" select="id"/>
            <option value="{id}">
              <xsl:if test="//get_journal_entry/get_journal_entry[entry_type_id='Credit']/account_id=$my_account_id">
                <xsl:attribute name="selected">selected</xsl:attribute>
              </xsl:if>
              <xsl:value-of select="name"/>
            </option>
          </xsl:for-each>
        </select>
      </td>
    </tr>
    <tr>
      <td>
        <span class="i18n-to">To</span>:
      </td>
      <td>
        <select name="debit_account_1[]" required="1" exclude="-1"
          err="{//i18n/error_select_credit}">
          <option value="-1">
            <span class="i18n-to_account">To Account</span>
          </option>
          <xsl:for-each select="//get_all_accounts/get_all_accounts">
            <xsl:variable name="my_d_account_id" select="id"/>
            <option value="{$my_d_account_id}">
              <xsl:if test="//get_journal_entry/get_journal_entry[entry_type_id='Debit']/account_id=$my_d_account_id">
                <xsl:attribute name="selected">selected</xsl:attribute>
              </xsl:if>
              <xsl:value-of select="name"/>
            </option>
          </xsl:for-each>
        </select>
      </td>
    </tr>
    <input type="hidden" name="transfer_id" value="{/_R_/_get/entry_id}"/>
    <input type="hidden" name="fiscal_period_id" value="{/_R_/runtime/current_fiscal_period_id}"/>
    <tr>
      <td>
        <span class="i18n-method">Method</span>:
      </td>
      <td>
        <select name="method">
          <option value="check">
            <span class="i18n-by_check">By Check</span>
          </option>
          <option value="electronic">
            <span class="i18n-electronic">Electronic</span>
          </option>
        </select>
      </td>
    </tr>
  </table>
  <input type="submit" id="submit-transfer"/>
</form>


  </xsl:template>
</xsl:stylesheet>