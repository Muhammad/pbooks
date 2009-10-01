<!--
Program: PBooks
Component: invoice_form.xsl
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
    <xsl:param name="i18n"/>
    <xsl:variable name="business_objects"
    select="/_R_/get_some_business_objects/get_some_business_objects" />
    <xsl:variable name="invoice_amounts"
    select="/_R_/invoices_get_amounts/invoices_get_amounts" />
    <xsl:variable name="business_object_metadata"
    select="/_R_/get_some_business_objects/get_some_business_objects" />
    <xsl:variable name="all_accounts"
    select="/_R_/get_all_accounts/get_all_accounts" />


<h2>
  <span id="i18n-new_invoice">New Invoice</span>
</h2>
<form method="post"
action="{$link_prefix}invoices-submit&amp;entry_id={/_R_/_get/entry_id}">
  <input type="hidden" name="entry_id" value="{/_R_/_get/entry_id}"/>
  <input type="hidden" name="fiscal_period_id"
  value="{/_R_/runtime/current_fiscal_period_id}"/>
  <table class="simpletable invoice_form_table">
    <tbody>
      <tr>
        <th>
          <span id="i18n-date">Date</span>
        </th>
        <td>
          <input type="text" name="entry_datetime" id="invoice_date"
          value="{/_R_/get_journal_entry/get_journal_entry/entry_datetime}"/>
        </td>
      </tr>
      <tr>
        <th>
          <span id="i18n-customer">Customer</span>
        </th>
        <td>
          <select name="debit_account_1[]">
            <xsl:for-each
            select="$all_accounts[accounts_receivable_account='on']">
              <option value="{id}">
                <xsl:if test="id=//get_some_business_objects/customer_id">
                  <xsl:attribute name="selected">selected</xsl:attribute>
                </xsl:if>
                <xsl:value-of select="name"/>
              </option>
            </xsl:for-each>
          </select>
        </td>
      </tr>
      <tr>
        <th>
          <xsl:value-of select="$i18n/invoice_number"/>:
        </th>
        <td>
          <input type="text" name="invoice_number">
            <xsl:attribute name="value">
              <xsl:if test="$business_objects/invoice_number">
                <xsl:value-of select="$business_objects/invoice_number"/>
              </xsl:if>
              <xsl:if test="not($business_objects/invoice_number)">
                <xsl:value-of select="//get_last_meta_id/meta_value + 1"/>
              </xsl:if>
            </xsl:attribute>
          </input>
        </td>
      </tr>
      <tr>
        <th>
          <label for="due_date">
            <span id="i18n-due_date">Due Date</span>
          </label>
        </th>
        <td>
          <input type="text" name="due_date" id="due_date"
          value="{$business_objects/due_date}">
            <xsl:if test="not($business_objects/due_date)">
              <xsl:attribute name="value">On Receipt</xsl:attribute>
            </xsl:if>
          </input>
        </td>
      </tr>
      <tr>
        <th>
          <span id="i18n-paid_status">Paid Status</span>
        </th>
        <td>
          <input type="radio" name="paid_status" value="paid_in_full">
            <xsl:if test="$business_object_metadata/paid_status='paid_in_full'">
              <xsl:attribute name="checked">checked</xsl:attribute>
            </xsl:if>
          </input>
          <xsl:value-of select="$i18n/paid_in_full"/>
          <br/>
          <input type="radio" name="paid_status" value="partial_payment">
            <xsl:if test="$business_object_metadata/paid_status='partial'">
              <xsl:attribute name="checked">checked</xsl:attribute>
            </xsl:if>
          </input>
          <xsl:value-of select="$i18n/paid"/>
          <br/>
          <input type="radio" name="paid_status" value="unpaid">
            <xsl:if test="not($business_object_metadata/paid_status) or
            $business_object_metadata/paid_status='unpaid'">
              <xsl:attribute name="checked">checked</xsl:attribute>
            </xsl:if>
          </input>
          <xsl:value-of select="$i18n/unpaid"/>
          <br/>
        </td>
      </tr>
      <tr>
        <th>
          <label for="paid_in_full_date">
            <span id="i18n-paid_in_full_date">Paid in full date</span>
          </label>
        </th>
        <td>
          <input type="text" name="paid_in_full_date" id="paid_in_full_date"
          value="{$business_object_metadata/paid_in_full_date}"/>
        </td>
      </tr>
    </tbody>
  </table>
  <br />
  <table class="simpletable invoice_form_table">
    <thead>
      <tr>
        <th colspan="8">
          <span id="i18n-billable_items">Billable Items</span>
        </th>
      </tr>
      <tr>
        <th>
          <span id="i18n-id">ID</span>
        </th>
        <th>
          <span id="i18n-revenue">Revenue</span>
        </th>
        <th width="240">
          <span id="i18n-desc">Description</span>
        </th>
        <th>
          <span id="i18n-quantity">Quantity</span>
        </th>
        <th>
          <span id="i18n-price">Price</span>
        </th>
        <th>
          <span id="i18n-total">Total</span>
        </th>
        <th>
          <span id="i18n-edit">Edit</span>
        </th>
      </tr>
    </thead>
    <tbody>
      <!-- INVOICE LINE ITEM ROWS -->
      <xsl:for-each select="//get_journal_entry[entry_type_id='Credit']">
        <xsl:variable name="my_entry_amount_id" select="entry_amount_id"/>
        <xsl:variable name="invoice_amount"
        select="$invoice_amounts[entry_amount_id=$my_entry_amount_id]"/>
        <tr id="ea_{entry_amount_id}">
          <td>
            <xsl:value-of select="entry_amount_id"/>
          </td>
          <td>
            <select name="credit_account_1[]">
              <option>
                <xsl:value-of select="$i18n/select_one"/>
              </option>
              <xsl:for-each select="$all_accounts[account_type_id=40000]">
                <xsl:variable name="my_account_id" select="id"/>
                <option value="{$my_account_id}">
                  <xsl:if test="$invoice_amount/account_id=$my_account_id">
                    <xsl:attribute name="selected">selected</xsl:attribute>
                  </xsl:if>
                  <xsl:value-of select="name"/>
                </option>
              </xsl:for-each>
            </select>
          </td>
          <td>
            <input type="text" name="memorandum[]" style="width: 20em;"
            value="{$invoice_amount/memorandum}"/>
          </td>
          <td>
            <input type="text" name="quantity" id="quantity" class="five"/>
          </td>
          <td>
            <input type="text" name="price" id="price" class="five"/>
          </td>
          <td>
            <input type="text" name="credit_amount_1[]" style="width: 5em;"
            class="credit_amounts"
            value="{$invoice_amount/entry_amount}"
            onkeyup="$('#my_debit_amount').val($('.credit_amounts').sum());"/>
          </td>
          <td>
            <xsl:if test="position() &gt; 1">
              <a href="#entry_amount_id={entry_amount_id}"
              onclick="journal_entry_amount_delete({entry_amount_id});">
                <img src="{$path_prefix}{/_R_/runtime/icon_set}delete.png" />
              </a>
            </xsl:if>
          </td>
        </tr>
      </xsl:for-each>
      <input type="hidden" name="debit_amount_1[]" id="my_debit_amount" />
      <!-- END LINE ITEMS -->
      <tr>
        <td colspan="6" />
        <td>
          <a href="#journal-entry-new-credit&amp;entry_id={//_get/entry_id}">
            <img src="{$path_prefix}{/_R_/runtime/icon_set}add.png"
            onclick="journal_entry_amount_create('credit',{//_get/entry_id});"/>
          </a>
        </td>
      </tr>
      <tr>
        <td colspan="7">
          <input type="submit"/>
        </td>
      </tr>
    </tbody>
  </table>
</form>
<!-- Link to journal entry form. -->
<div style="float: right">
  <a href="{$link_prefix}journal-entry&amp;entry_id={/_R_/_get/entry_id}">
    <xsl:value-of select="$i18n/edit_journal_entry"/>
  </a>
</div>


  </xsl:template>
</xsl:stylesheet>
