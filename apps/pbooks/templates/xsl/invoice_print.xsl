<!--
Program: PBooks
Component: invoice_print.xsl
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
		<xsl:variable name="all_accounts"
		select="/_R_/get_all_accounts/get_all_accounts" />
		<xsl:variable name="journal_entry"
		select="/_R_/get_journal_entry/get_journal_entry" />
		<xsl:variable name="invoice_amts"
		select="/_R_/invoices_get_amounts/invoices_get_amounts" />
		<xsl:variable name="business_objects"
		select="/_R_/get_some_business_objects/get_some_business_objects" />
		<xsl:variable name="account_meta"
		select="/_R_/account_meta_get/account_meta_get" />
		<xsl:variable name="option_get" select="/_R_/option_get/option_get" />


<div style="font-size:14px;margin-top:{//default_invoice_print_vertical}px;
margin-left:{//default_invoice_print_horiz}px;">
  <table style="float: right;">
    <tbody>
      <tr>
        <th>
          <span id="i18n-date">Date</span>
        </th>
        <td>
          <xsl:value-of select="$journal_entry/entry_datetime"/>
        </td>
      </tr>
      <tr>
        <th>
          <span id="i18n-invoice_number">Invoice Number</span>
        </th>
        <td>
          <xsl:value-of select="$business_objects/invoice_number"/>
        </td>
      </tr>
      <tr>
        <th>
          <span id="i18n-due_date">Due Date</span>
        </th>
        <td>
          <xsl:value-of select="$business_objects/due_date"/>
        </td>
      </tr>
    </tbody>
  </table>

  <table id="return-address">
    <tbody>
      <tr>
        <td>
          <xsl:value-of select="/_R_/runtime/company_name"/>
        </td>
      </tr>
      <tr>
        <td>
          <xsl:value-of select="$option_get/company_address_1"/>
        </td>
      </tr>
      <tr>
        <td>
          <xsl:value-of select="$option_get/company_city"/>, 
          <xsl:value-of select="$option_get/company_state"/>&#160;
          <xsl:value-of select="$option_get/company_zip"/>
        </td>
      </tr>
    </tbody>
  </table>

  <table id="client-address" style="margin-top:100px;margin-bottom:40px;">
    <tbody>
      <tr>
        <td>
          <xsl:value-of select="$all_accounts[id=/_R_/got_account_id]/name"/>
        </td>
      </tr>
      <tr>
        <td>
          <xsl:value-of select="$account_meta[meta_key='address_1']/meta_value"/>
        </td>
      </tr>
      <xsl:if test="not($account_meta[meta_key='address_2']/meta_value='')">
        <tr>
          <td>
            <xsl:value-of select="$account_meta[meta_key='address_2']/meta_value"/>
          </td>
        </tr>
      </xsl:if>
      <tr>
        <td>
          <xsl:value-of select="$account_meta[meta_key='city']/meta_value"/>, 
          <xsl:value-of select="$account_meta[meta_key='state']/meta_value"/>&#160;
          <xsl:value-of select="$account_meta[meta_key='zip']/meta_value"/>
        </td>
      </tr>
    </tbody>
  </table>
  <div id="invoice_print">
    <table class="simpletable" style="width: 600px;">
      <thead>
        <tr>
          <th colspan="2">
            <span id="i18n-billable_items">Billable Items</span>
          </th>
        </tr>
      </thead>
      <tbody>
        <tr>
          <th style="width:360px;">
            <span id="i18n-desc">Description</span>
          </th>
          <th style="width:360px;">
            <span id="i18n-total">Total</span>
          </th>
        </tr>

        <!-- INVOICE LINE ITEM ROWS -->
        <xsl:for-each select="$journal_entry[entry_type_id='Credit']">
          <xsl:variable name="this_eaid" select="entry_amount_id"/>
          <xsl:variable name="this_entry_amount"
          select="$invoice_amts[entry_amount_id=$this_eaid]"/>
          <tr>
            <td>
              <xsl:value-of select="$this_entry_amount/memorandum"/>
            </td>
            <td>
              <xsl:value-of select="$this_entry_amount/entry_amount"/>
            </td>
          </tr>
        </xsl:for-each>
        <!-- END LINE ITEMS -->

        <tr>
          <th style="text-align: right;">
            <span id="i18n-grand_total">Grand total</span>
          </th>
          <td>
            <strong>
              <xsl:value-of
              select="sum($invoice_amts[entry_type_id='Credit']/entry_amount)"/>
            </strong>
          </td>
        </tr>

      </tbody>
    </table>
  </div>
  <center><xsl:value-of select="$i18n/thank_you_for_biz"/></center>
</div>


	</xsl:template>
</xsl:stylesheet>
