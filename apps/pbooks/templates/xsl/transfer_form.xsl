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
or write to the Free Software Foundation,Inc., 51 Franklin Street,
Fifth Floor, Boston, MA 02110-1301  USA
-->
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" >
<xsl:include href="main.xsl"/>
<xsl:template name="content">
<form action="{/__ROOT__/runtime/link_prefix}transfer-submit&amp;entry_id={/__ROOT__/_get/entry_id}" method="post" 
onSubmit="return validateStandard(this, 'myerror');">
<input type="hidden" name="entry_id" value="{/__ROOT__/_get/entry_id}"/>
<table>
    <tr>
        <td>
 <xsl:value-of select="/__ROOT__/i18n/labels/label[key='date']/value"/>: 
        </td>
        <td>
        <input type="text" name="entry_datetime" value="{//get_journal_entry/entry_datetime}"/>
        </td>
    </tr>
    <tr>
        <td><xsl:value-of select="/__ROOT__/i18n/labels/label[key='memo']/value"/>:</td>
        <td>
            <input type="text" name="memorandum"/>
        </td>
    </tr>
    <tr>
        <td><xsl:value-of select="/__ROOT__/i18n/labels/label[key='amount']/value"/>:</td>
        <td>
            <input type="text" name="transfer_amount"/>
        </td>
    </tr>
    <tr>
        <td><xsl:value-of select="/__ROOT__/i18n/labels/label[key='from']/value"/>:</td>
        <td>
<select name="from_account_id" required="1" exclude="-1" err="{/__ROOT__/i18n/labels/label[key='error_select_credit']/value}">
    <option value="-1"><xsl:value-of select="/__ROOT__/i18n/labels/label[key='from_account']/value"/></option>
    <xsl:for-each select="//get_all_accounts">
        <option value="{id}"><xsl:if test="id=//get_journal_entry/account_id and not(//_get/transaction_id)">
		<xsl:attribute name="selected">selected</xsl:attribute></xsl:if>
        <xsl:value-of select="name"/></option>
    </xsl:for-each>
</select>
        </td>
    </tr>
    <tr>
        <td><xsl:value-of select="/__ROOT__/i18n/labels/label[key='to']/value"/>:</td>
        <td>
<select name="to_account_id" required="1" exclude="-1" err="{/__ROOT__/i18n/labels/label[key='error_select_credit']/value}">
    <option value="-1"><xsl:value-of select="/__ROOT__/i18n/labels/label[key='to_account']/value"/></option>
    <xsl:for-each select="//get_all_accounts">
        <option value="{id}"><xsl:if test="id=//get_journal_entry/account_id and not(//_get/transaction_id)">
		<xsl:attribute name="selected">selected</xsl:attribute></xsl:if>
        <xsl:value-of select="name"/></option>
    </xsl:for-each>
</select>
        </td>
    </tr>
    <input type="hidden" name="transfer_id" value="{/__ROOT__/_get/entry_id}"/>
    <tr>
        <td><xsl:value-of select="/__ROOT__/i18n/labels/label[key='method']/value"/>:</td>
        <td>
        <select name="method">
            <option value="check">
                <xsl:value-of select="//label[key='by_check']/value"/>
            </option>
            <option value="electronic">
                <xsl:value-of select="//label[key='electronic']/value"/>
            </option>
        </select>
        </td>
    </tr>
</table>
<input type="submit" id="submit-transfer"/>
</form>
</xsl:template> 
</xsl:stylesheet>