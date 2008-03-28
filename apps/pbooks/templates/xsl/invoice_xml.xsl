<!--
Program: PBooks
Component: invoice_xml.xsl
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
<xsl:output method="xml" indent="yes" encoding="UTF-8" 
	omit-xml-declaration="yes"/>
<xsl:template match="/">
<invoices>
    <xsl:for-each select="/__ROOT__/get_some_business_objects">
    <xsl:variable name="my_entry_id"><xsl:value-of select="entry_id"/></xsl:variable>
    <invoice>
        <xsl:for-each select="/__ROOT__/entry_meta/meta">
            <xsl:variable name="my_meta_key"><xsl:value-of select="meta_key"/></xsl:variable>
            <key name="{$my_meta_key}"><xsl:value-of select="/__ROOT__/business_object_get_metadata[entry_id=$my_entry_id][meta_key=$my_meta_key]/meta_value"/></key>
        </xsl:for-each>
            <key name="invoice_amount"><xsl:value-of select="/__ROOT__/business_object_get_metadata[account_id=/__ROOT__/accounts_receivable_id]/entry_amount"/></key>
    </invoice>
    </xsl:for-each>
</invoices>
</xsl:template>
</xsl:stylesheet>