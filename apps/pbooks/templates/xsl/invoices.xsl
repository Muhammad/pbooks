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
or write to the Free Software Foundation,Inc., 51 Franklin Street,
Fifth Floor, Boston, MA 02110-1301  USA
-->
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" >
<xsl:import href="main.xsl"/>
<xsl:include href="accounting_menu.xsl"/>
<xsl:include href="pager.xsl"/>
<xsl:template name="content">
<xsl:call-template name="jquery-setup">
    <xsl:with-param name="my-table">myInvoices</xsl:with-param>
    <xsl:with-param name="my-table-div">myInvoicesDiv</xsl:with-param>
<xsl:with-param name="no-sort-column">, headers: { 6: {sorter: false} }</xsl:with-param>
</xsl:call-template>
<div class="generic-button" style="float: right;">
    <a href="{/__ROOT__/runtime/link_prefix}invoice-create" id="invoice-create">
        <img src="{//path_prefix}{//icon_set}/page_edit.gif"/>
        <xsl:value-of select="//labels/label[key='new_invoice']/value"/>
    </a>
</div>

<strong><xsl:value-of select="//labels/label[key='recent_invoices']/value"/>:</strong> 
<div id="myInvoicesDiv" style="min-height: 400px">
<script type="text/javascript">
document.getElementById('myInvoicesDiv').style.visibility = 'hidden';
</script>

<table class="tablesorter" id="myInvoices">
    <thead>
    <tr>
        <th><xsl:value-of select="/__ROOT__/i18n/labels/label[key='id']/value"/></th>
        <th><xsl:value-of select="/__ROOT__/i18n/labels/label[key='client']/value"/></th>
        <th><xsl:value-of select="/__ROOT__/i18n/labels/label[key='memo']/value"/></th>
        <th><xsl:value-of select="/__ROOT__/i18n/labels/label[key='amount']/value"/></th>
        <th><xsl:value-of select="/__ROOT__/i18n/labels/label[key='date']/value"/></th>
        <!--
        <th><xsl:value-of select="/__ROOT__/i18n/labels/label[key='due_date']/value"/></th>
        -->
        <th><xsl:value-of select="/__ROOT__/i18n/labels/label[key='paid']/value"/>&#160;
            <!--<sup>[<a onclick="alert('')">?</a>]</sup>--></th>
        <th><xsl:value-of select="/__ROOT__/i18n/labels/label[key='print']/value"/></th>
    </tr>
    </thead>
    <tbody>
    <!-- LOOP -->
    <xsl:for-each select="/__ROOT__/get_some_business_objects">
    <xsl:variable name="my_entry_id"><xsl:value-of select="entry_id"/></xsl:variable>
    <xsl:variable name="my_customer_id"><xsl:value-of select="customer_id"/></xsl:variable>
    <tr onmouseover="oldClass=this.className; this.className='active'" onmouseout="this.className=oldClass">
        <td id="{$my_entry_id}">
            <a href="{/__ROOT__/runtime/link_prefix}invoice-edit&amp;entry_id={entry_id}&amp;invoice_id={$my_entry_id}">
            <xsl:value-of select="invoice_number"/></a>
            </td>
        <td><a href="#">
        <xsl:value-of select="/__ROOT__/get_all_accounts[id=$my_customer_id]/name"/></a></td>
        <td><a href="{/__ROOT__/runtime/link_prefix}invoice-edit&amp;entry_id={entry_id}&amp;invoice_id={$my_entry_id}"><xsl:value-of select="memorandum"/></a></td>
        <td><xsl:value-of select="invoice_total"/></td>
        <td><xsl:value-of select="entry_datetime"/></td>
        <!--
        <td><xsl:value-of select="due_date"/></td>
        -->
        <!-- TODO - Use AJAX to quickly convert paid status - triggering db update and entries -->
        <td><a href="#"><xsl:value-of select="paid"/></a></td>
        <td><a href="{//link_prefix}invoice-print&amp;entry_id={$my_entry_id}&amp;invoice_id={$my_entry_id}&amp;account_id={$my_customer_id}&amp;print=true"><xsl:value-of select="/__ROOT__/i18n/labels/label[key='print']/value"/></a></td>
    </tr>
    </xsl:for-each>
    <!-- END LOOP -->
    </tbody>
</table>
</div>
<xsl:call-template name="pager">
    <xsl:with-param name="my-table">myInvoices</xsl:with-param>
</xsl:call-template>
</xsl:template>
</xsl:stylesheet>