<!--
Program: PBooks
Component: report_invoices.xsl
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
Fifth Floor, Boston, MA 02110-1301 USA
-->
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" >
<xsl:import href="main.xsl"/>
<xsl:include href="accounting_menu.xsl"/>
<xsl:include href="pager.xsl"/>
<xsl:template name="content">
<xsl:call-template name="jquery-setup">
    <xsl:with-param name="my-table">myLedger</xsl:with-param>
</xsl:call-template>

<!-- Net change -->
<div class="generic-button" style="float: right;">
    <b><xsl:value-of select="/__ROOT__/i18n/labels/label[key='net_change']/value"/></b>: 
    <xsl:value-of select="
        format-number(
            sum(
                /__ROOT__/get_some_business_objects/invoice_total
                ),'#########.##')
                "/>
</div>


<form method="get">
<input type="hidden" name="nid" value="reports-invoices"/>
<table>

    <tr>
	<td><xsl:if test="/__ROOT__/_get/month >= 1"><a><xsl:attribute name="href"><xsl:value-of select="//link_prefix"/>reports-invoices&amp;month=<xsl:if test="//_get/month &lt;= 10">0</xsl:if><xsl:value-of select="/__ROOT__/_get/month - 1"/></xsl:attribute>
	<img src="{//path_prefix}/images/buttons/out.gif"/></a></xsl:if>
    <xsl:if test="not(/__ROOT__/_get/month >= 1)"><img src="{//path_prefix}/images/buttons/out_d.gif"/></xsl:if></td>

        <td><xsl:value-of select="//label[key='month']/value"/>:</td>
        <td>
            <select name="month"  onchange="this.form.submit();">
            <option value="%">All</option>
            <xsl:for-each select="//months/option">
                <option value="{@id}">
                    <xsl:if test="@id=/__ROOT__/_get/month">
                        <xsl:attribute name="selected">selected</xsl:attribute>
                    </xsl:if>
                    <xsl:value-of select="@fullname"/>
                </option>
            </xsl:for-each>
			</select>
        </td>
	<td>
    <xsl:if test="/__ROOT__/_get/month &gt;= 12"><img src="{//path_prefix}/images/buttons/in_d.gif"/></xsl:if>
	<xsl:if test="not(//_get/month)"><a href="{//link_prefix}reports-invoices&amp;month=01">
	<img src="{//path_prefix}/images/buttons/in.gif"/></a></xsl:if>
	<xsl:if test="(/__ROOT__/_get/month &lt; 12)"><a><xsl:attribute name="href"><xsl:value-of select="//link_prefix"/>reports-invoices&amp;month=<xsl:if test="//_get/month &lt; 9">0</xsl:if>
	<xsl:value-of select="/__ROOT__/_get/month + 1"/></xsl:attribute>
	<img src="{//path_prefix}/images/buttons/in.gif"/></a></xsl:if>
	</td>

    </tr>
</table>

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
<br/>
</form>
</xsl:template>
</xsl:stylesheet>