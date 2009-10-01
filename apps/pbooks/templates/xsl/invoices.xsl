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
  <xsl:include href="pager.xsl"/>
  <xsl:template name="content">
    <xsl:param name="link_prefix"/>
    <xsl:param name="path_prefix"/>
    <xsl:param name="i18n"/>
    <xsl:variable name="business_objects"
    select="/_R_/get_some_business_objects/get_some_business_objects" />

<script type="text/javascript"
src="{$link_prefix}x-tablesorter-setup-js&amp;selector=my_invoices" />


<div class="generic-button" style="float: right;">
  <a href="{$link_prefix}invoice-create" id="invoice-create">
    <img src="{$path_prefix}{/_R_/runtime/icon_set}/page_edit.gif"/>
    <xsl:value-of select="$i18n/new_invoice"/>
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
          <span id="i18n-id">ID</span>
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
        <!--
        <th><xsl:value-of select="$i18n/due_date"/></th>
        -->
        <th>
          <span id="i18n-paid">Paid</span>
        <!--<sup>[<a onclick="alert('')">?</a>]</sup>-->
        </th>
        <th>
          <span id="i18n-print">Print</span>
        </th>
      </tr>
    </thead>
    <tbody>
      <!-- LOOP -->
      <xsl:for-each
      select="/_R_/get_some_business_objects/get_some_business_objects">
        <xsl:variable name="my_customer_id" select="customer_id"/>
        <tr onmouseover="oldClass=this.className; this.className='active'"
          onmouseout="this.className=oldClass">
          <td>
            <xsl:value-of select="entry_datetime"/>
          </td>
          <td id="{entry_id}">
            <a href="{$link_prefix}invoice-edit&amp;entry_id={entry_id}&amp;invoice_entry_id={entry_id}">
              <xsl:value-of select="invoice_number"/>
            </a>
          </td>
          <td>
            <a href="#">
              <xsl:value-of select="substring(/_R_/get_all_accounts/get_all_accounts[id=$my_customer_id]/name,0,24)"/>
            </a>
          </td>
          <td>
            <a href="{$link_prefix}invoice-edit&amp;entry_id={entry_id}&amp;invoice_entry_id={entry_id}"
              title="{memorandum}">
              <xsl:value-of select="substring(memorandum,0,12)"/>
            </a>
          </td>
          <td>
            <xsl:value-of select="invoice_total"/>
          </td>
          <!--
          <td><xsl:value-of select="due_date"/></td>
          -->
          <td>
            <span id="p_{invoice_number}">
            <xsl:if test="paid_status='paid_in_full'">
              <span id="i18n-paid">Paid</span>
            </xsl:if>
            <xsl:if test="not(paid_status='paid_in_full')">
            <a onclick="invoice_paid({invoice_number},{entry_id}); return false;"
            href="#x-invoice-paid&amp;invoice_number={invoice_number}&amp;invoice_entry_id={entry_id}">
              <span id="i18n-unpaid">Unpaid</span>
            </a>
            </xsl:if>
            </span>
          </td>
          <td>
            <a href="{$link_prefix}invoice-print&amp;entry_id={entry_id}&amp;invoice_entry_id={entry_id}&amp;account_id={customer_id}&amp;print=true">
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
    <xsl:value-of
    select="sum($business_objects/invoice_total) -
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