<!--
Program: PBooks
Component: invoices.xsl
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
    <xsl:variable name="business_objects"
    select="/_R_/get_some_business_objects/get_some_business_objects" />
    <xsl:variable name="all_accounts"
    select="/_R_/get_all_accounts/get_all_accounts" />


<script type="text/javascript"
src="{$link_prefix}x-tablesorter-setup-js&amp;selector=my_invoices" />

<script type="text/javascript"
src="{$link_prefix}x-page-js&amp;selector=%23my_invoices%20tbody%20tr&amp;function=setup_rows" />

<div class="generic-button" style="float: right;">
  <a href="{$link_prefix}invoice-create" id="invoice-create">
    <img src="{$path_prefix}{/_R_/runtime/icon_set}/page_edit.gif"/>
    <span id="i18n-new_invoice">New Invoice</span>
  </a>
  &#160;
  <a href="{$link_prefix}x-invoices-export" id="invoices-export">
    <span id="i18n-export_invoices">Export Invoices</span>
  </a>
</div>

<div class="tableframe">
  <table class="tablesorter" id="my_invoices">
    <thead>
      <tr>
        <th>
          <span id="i18n-date">Date</span>
        </th>
        <th>
          <span id="i18n-invoice_number">Invoice Number</span>
        </th>
        <th>
          <span id="i18n-client">Client</span>
        </th>
        <th>
          <span id="i18n-memorandum">Memorandum</span>
        </th>
        <th>
          <span id="i18n-amount">Amount</span>
        </th>
        <th class="{{sorter: false}}">
          <span id="i18n-paid">Paid</span>
        </th>
        <th class="{{sorter: false}}">
          <span id="i18n-print">Print</span>
        </th>
      </tr>
    </thead>
    <tbody>
      <!-- LOOP -->
      <xsl:for-each
      select="/_R_/get_some_business_objects/get_some_business_objects[business_object_type='invoices']">
        <xsl:variable name="my_customer_id" select="customer_id"/>
        <tr>
          <td>
            <xsl:value-of select="entry_datetime"/>
          </td>
          <td id="{entry_id}">
            <a rel="{invoice_number}" href="{$link_prefix}invoice-edit&amp;entry_id={entry_id}">
              <xsl:value-of select="invoice_number"/>
            </a>
          </td>
          <td>
            <a href="#">
              <xsl:value-of
              select="substring($all_accounts[id=$my_customer_id]/name,0,24)"/>
            </a>
          </td>
          <td>
            <a href="{$link_prefix}invoice-edit&amp;entry_id={entry_id}"
              title="{memorandum}">
              <xsl:value-of select="substring(memorandum,0,12)"/>
            </a>
          </td>
          <td>
            <xsl:value-of select="invoice_total"/>
          </td>
          <td>
            <span id="p_{invoice_number}">
            <xsl:if test="paid_status='paid_in_full'">
              <span id="i18n-paid">Paid</span>
              <a onclick="invoice_unpaid({invoice_number},{entry_id});"
              title="Entry ID: {entry_id}; Invoice #: {invoice_number}"
              href="#invoice_entry_id={entry_id}">x</a>
            </xsl:if>
            <xsl:if test="not(paid_status='paid_in_full')">
              <a onclick="invoice_paid({invoice_number},{entry_id});"
              title="Entry ID: {entry_id}; Invoice #: {invoice_number}"
              href="#invoice_entry_id={entry_id}">
                <span id="i18n-unpaid">Unpaid</span>
              </a>
            </xsl:if>
            </span>
          </td>
          <td>
            <a href="{$link_prefix}invoice-print&amp;entry_id={entry_id}">
              <span id="i18n-print">Print</span>
            </a>
          </td>
        </tr>
      </xsl:for-each>
      <!-- END LOOP -->
    </tbody>
  </table>
</div>
<div class="table_meta">
  <span id="i18n-total_invoices">Total outstanding invoices</span>
  <b>
    <xsl:value-of select="sum($business_objects/invoice_total) -
    sum($business_objects[paid_status='paid_in_full']/invoice_total)"/>
  </b>
</div>
<div class="table_controls">
  <xsl:call-template name="pager">
    <xsl:with-param name="my-table">my_invoices</xsl:with-param>
  </xsl:call-template>
</div>


  </xsl:template>
</xsl:stylesheet>