<!--
Program: PBooks
Component: open_spreadsheet.xml.xsl
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
  <xsl:output method="xml" indent="yes" encoding="UTF-8" omit-xml-declaration="no" />
  <xsl:template match="/">
<office:document-content xmlns:office="urn:oasis:names:tc:opendocument:xmlns:office:1.0" xmlns:style="urn:oasis:names:tc:opendocument:xmlns:style:1.0" xmlns:text="urn:oasis:names:tc:opendocument:xmlns:text:1.0" xmlns:table="urn:oasis:names:tc:opendocument:xmlns:table:1.0" xmlns:meta="urn:oasis:names:tc:opendocument:xmlns:meta:1.0" xmlns:number="urn:oasis:names:tc:opendocument:xmlns:datastyle:1.0" office:version="1.1">
  <office:body>
    <office:spreadsheet>
      <table:table table:name="Sheet1">
        <table:table-row table:style-name="ro1">
          <table:table-cell office:value-type="string">
            <text:p>Date</text:p>
          </table:table-cell>
          <table:table-cell office:value-type="string">
            <text:p>Amount</text:p>
          </table:table-cell>
          <table:table-cell office:value-type="string">
            <text:p>Balance</text:p>
          </table:table-cell>
          <table:table-cell office:value-type="string">
            <text:p>Memo</text:p>
          </table:table-cell>
          <table:table-cell office:value-type="string">
            <text:p>Entry ID</text:p>
          </table:table-cell>
          <table:table-cell office:value-type="string">
            <text:p>Corresponding Account(s)</text:p>
          </table:table-cell>
        </table:table-row>
				<xsl:for-each select="/_R_/get_all_transactions/get_all_transactions">
				<xsl:sort select="entry_datetime"/>
					<table:table-row table:style-name="ro1">
						<table:table-cell office:value-type="string">
							<text:p><xsl:value-of select="entry_datetime"/></text:p>
						</table:table-cell>
						<table:table-cell office:value-type="string">
							<text:p><xsl:value-of select="entry_amount"/></text:p>
						</table:table-cell>
						<table:table-cell office:value-type="string">
							<text:p><xsl:value-of select="balance"/></text:p>
						</table:table-cell>
						<table:table-cell office:value-type="string">
							<text:p><xsl:value-of select="substring(memorandum,0,42)"/></text:p>
						</table:table-cell>
						<table:table-cell office:value-type="string">
							<text:p><xsl:value-of select="entry_id"/></text:p>
						</table:table-cell>
						<table:table-cell office:value-type="string">
							<text:p><xsl:value-of select="corresponding_accounts"/></text:p>
						</table:table-cell>
					</table:table-row>
				</xsl:for-each>
      </table:table>
			<!--
      <table:table table:name="Sheet2">
        <table:table-row table:style-name="ro1">
          <table:table-cell office:value-type="string">
            <text:p>abc222</text:p>
          </table:table-cell>
        </table:table-row>
      </table:table>
			-->
    </office:spreadsheet>
  </office:body>
</office:document-content>
  </xsl:template>
</xsl:stylesheet>
