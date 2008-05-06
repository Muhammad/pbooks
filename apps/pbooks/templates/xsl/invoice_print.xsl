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
or write to the Free Software Foundation,Inc., 51 Franklin Street,
Fifth Floor, Boston, MA 02110-1301  USA
-->
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" >
<xsl:import href="main.xsl"/>
<xsl:template name="content">

<div style="font-size: 14px; margin-top: {//runtime/default_invoice_print_vertical}px;">
<table border="0" style="float: right;">
    <tbody>
        <tr>
            <td><xsl:value-of select="//label[key='date']/value"/>:</td>
            <td colspan="8"><xsl:value-of select="//get_journal_entry/entry_datetime"/></td>
        </tr>
        <tr>
            <td><xsl:value-of select="__ROOT__/i18n/labels/label[key='invoice_number']/value"/>:</td>
            <td colspan="8"><xsl:value-of select="//get_some_business_objects/invoice_number"/></td>
        </tr>
        <tr>
            <td><xsl:value-of select="//label[key='due_date']/value"/>:</td>
            <td colspan="8"><xsl:value-of select="//get_some_business_objects/due_date"/></td>
        </tr>
    </tbody>
</table>

<table border="0" id="return-address">
    <tbody>
    <tr>
        <td>
            <xsl:value-of select="//company_name"/>
        </td>
    </tr>
    <tr>
        <td>
            <xsl:value-of select="//company_address_1"/>
        </td>
    </tr>
    <tr>
        <td>
        <xsl:value-of select="//company_city"/>, <xsl:value-of select="//company_state"/>&#160;<xsl:value-of select="//company_zip"/>
        </td>
    </tr>
    </tbody>
</table>

<xsl:variable name="my_client_id"><xsl:value-of select="/__ROOT__/business_object_get_metadata[meta_key='client_id']/meta_value"/></xsl:variable>
<table border="0" id="client-address" style="margin-top: 100px; margin-bottom:40px;">
    <tbody>
        <tr>
            <td>
    <xsl:value-of select="//get_all_accounts[id=//_get/account_id]/name"/>
            </td>
        </tr>
        <tr>
            <td>
    <xsl:value-of select="//account_meta_get[meta_key='address_1']/meta_value"/>
            </td>
        </tr>
    <xsl:if test="not(//account_meta_get[meta_key='address_2']/meta_value='')">
    <tr>
        <td>
            <xsl:value-of select="//account_meta_get[meta_key='address_2']/meta_value"/>
        </td>
    </tr>
    </xsl:if>
        <tr>
            <td>
    <xsl:value-of select="//account_meta_get[meta_key='city']/meta_value"/>, 
    <xsl:value-of select="//account_meta_get[meta_key='state']/meta_value"/>&#160;
    <xsl:value-of select="//account_meta_get[meta_key='zip']/meta_value"/> 
            </td>
        </tr>
    </tbody>
</table>
<div style="height: 500px; margin-top: 10px;">
<table class="simpletable" style="width: 600px;">
    <thead>
        <tr>
            <th colspan="2">
                <xsl:value-of select="/__ROOT__/i18n/labels/label[key='billable_items']/value"/>:
            </th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td width="360">
                <xsl:value-of select="/__ROOT__/i18n/labels/label[key='desc']/value"/>
            </td>
            <td>
                <xsl:value-of select="__ROOT__/i18n/labels/label[key='total']/value"/>
            </td>
        </tr>
        
        <!-- INVOICE LINE ITEM ROWS -->
        <xsl:for-each select="//get_journal_entry[entry_type_id='Credit']">
        <xsl:variable name="my_entry_amount_id"><xsl:value-of select="entry_amount_id"/></xsl:variable>
        <tr>
            <td><xsl:value-of select="/__ROOT__/invoices_get_amounts[entry_amount_id=$my_entry_amount_id]/memorandum"/></td>
            <td><xsl:value-of select="/__ROOT__/invoices_get_amounts[entry_amount_id=$my_entry_amount_id]/entry_amount"/></td>
        </tr>
        </xsl:for-each>
        <!-- END LINE ITEMS -->

        <!-- TODO: i18n -->
        <tr>
            <td style="text-align: right;">Grand total:</td>
            <td><strong><xsl:value-of select="sum(/__ROOT__/invoices_get_amounts[entry_type_id='Credit']/entry_amount)"/></strong></td>
        </tr>
        
    </tbody>
</table>
</div>
<center>Thank you for your business!</center>
</div>
</xsl:template> 
</xsl:stylesheet>