<!--
Program: PBooks
Component: transactions_import.xsl
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

<h2><xsl:value-of select="//label[key='import_csv']/value"/></h2>

<xsl:if test="/__ROOT__/_get/error">
<div class="error" id="function-error">
    <img src="{//path_prefix}{//icon_set}/exclamation.png"/>
    <xsl:value-of select="//errors/error[key='general_error']/value"/>
</div>
<br/>
</xsl:if>

<form method="post"
    onsubmit="return validateStandard(this, 'error');">
    <textarea id="csv_import" name="csv_import" rows="14" cols="80">
    <xsl:value-of select="//text[key='import_instructions']/value"/>
    </textarea>
    <br/>
    <select name="account_id" required="1" exclude="-1" 
        err="Please select an account to post your transactions to.">
        <option value="-1">
            <xsl:value-of select="/__ROOT__/i18n/labels/label[key='select_one']/value"/>
        </option>
        <xsl:for-each select="/__ROOT__/get_all_accounts">
        <option value="{id}">
            <xsl:if test="id=/__ROOT__/_get/account_id">
                <xsl:attribute name="selected">selected</xsl:attribute>
            </xsl:if>
            <xsl:value-of select="name"/>
        </option>
        </xsl:for-each>
        </select>
    <input type="submit"/>
</form>

</xsl:template> 
</xsl:stylesheet>