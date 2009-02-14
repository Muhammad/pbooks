<!--
Program: PBooks
Component: ledger_export.xsl
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
	<xsl:include href="main.xsl"/>
	<xsl:template name="content">
		<xsl:param name="link_prefix"/>
		<xsl:param name="path_prefix"/>
	    <div class="generic-button" style="float: right;">
				<a>
					<xsl:attribute name="href">
						<xsl:if test="//_get/from_date">
							<xsl:value-of select="$link_prefix"/>x--ledger-export-dl&amp;account_id=<xsl:value-of select="//_get/account_id"/>&amp;from_date=<xsl:value-of select="//_get/from_date"/>&amp;to_date=<xsl:value-of select="//_get/to_date"/>
						</xsl:if>
						<xsl:if test="not(//_get/from_date)">
							<xsl:value-of select="$link_prefix"/>x--ledger-export-dl&amp;account_id=<xsl:value-of select="//_get/account_id"/>
						</xsl:if>
					</xsl:attribute>
					CSV
				</a>
				<a>
					<xsl:attribute name="href">
						<xsl:if test="//_get/from_date">
							<xsl:value-of select="$link_prefix"/>x--ods-export&amp;account_id=<xsl:value-of select="//_get/account_id"/>&amp;from_date=<xsl:value-of select="//_get/from_date"/>&amp;to_date=<xsl:value-of select="//_get/to_date"/>
						</xsl:if>
						<xsl:if test="not(//_get/from_date)">
							<xsl:value-of select="$link_prefix"/>x--ods-export&amp;account_id=<xsl:value-of select="//_get/account_id"/>
						</xsl:if>
					</xsl:attribute>
					ODS
				</a>
			</div>
			<iframe style="width:600px;height:500px;">
					<xsl:attribute name="src">
						<xsl:if test="//_get/from_date">
							<xsl:value-of select="$link_prefix"/>x--ledger-export&amp;account_id=<xsl:value-of select="//_get/account_id"/>&amp;from_date=<xsl:value-of select="//_get/from_date"/>&amp;to_date=<xsl:value-of select="//_get/to_date"/>
						</xsl:if>
						<xsl:if test="not(//_get/from_date)">
							<xsl:value-of select="$link_prefix"/>x--ledger-export&amp;account_id=<xsl:value-of select="//_get/account_id"/>
						</xsl:if>
					</xsl:attribute>
			</iframe>
	</xsl:template>
</xsl:stylesheet>
