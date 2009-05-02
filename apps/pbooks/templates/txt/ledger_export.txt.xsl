<!--
Program: PBooks
Component: ledger_export.txt.xsl
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
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="text" indent="yes" encoding="UTF-8"
	omit-xml-declaration="yes"/>
<xsl:template match="/">

<xsl:variable
  name   = "get_all_entry_amounts"
  select = "/_R_/get_all_entry_amounts/get_all_entry_amounts"
/>

<xsl:for-each select="/_R_/get_all_entries/get_all_entries">
  <xsl:variable name="this_entry_id" select="entry_id"/>
<xsl:value-of select="entry_datetime"/>&#160;'<xsl:value-of select="substring(memorandum,0,42)"/>'&#x2028;
<xsl:for-each select="$get_all_entry_amounts[entry_id=$this_entry_id]">
<xsl:variable name="my_account_type_id" select="account_type_id"/>
<xsl:text>&#x0009;</xsl:text>'<xsl:value-of select="//account_type[account_type_id=$my_account_type_id]/name"/>':'<xsl:value-of select="name"/>'<xsl:text>&#x0009;&#x0009;</xsl:text>
<xsl:if test="entry_type_id='Credit'">
  <xsl:text>&#x0009;&#x0009;-</xsl:text>
</xsl:if>
<xsl:if test="entry_type_id='Debit'">
</xsl:if>
<xsl:value-of select="entry_amount"/>
<xsl:text>
</xsl:text></xsl:for-each>
<xsl:text>
</xsl:text></xsl:for-each>
</xsl:template>

</xsl:stylesheet>
