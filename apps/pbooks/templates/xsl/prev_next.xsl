<!--
Program: PBooks
Component: previous_next.xsl
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
	<xsl:template name="previous_next">
		<xsl:variable name="my_uri">
			<xsl:if test="/_R_/_get/from_date">
				<xsl:value-of select="substring-before(/_R_/runtime/request_uri,'&amp;from_date')"/>
			</xsl:if>
			<xsl:if test="not(/_R_/_get/from_date)">
				<xsl:if test="/_R_/_get/start">
					<xsl:value-of select="substring-before(/_R_/runtime/request_uri,'&amp;start')"/>
				</xsl:if>
				<xsl:if test="not(/_R_/_get/start)">
					<xsl:value-of select="/_R_/runtime/request_uri"/>
				</xsl:if>
			</xsl:if>
		</xsl:variable>

		<xsl:variable name="incr">
			<xsl:if test="contains(/_R_/_get/nid,'ledger')">
				<xsl:value-of select="//option_get/display_num_trans"/>
			</xsl:if>
			<xsl:if test="not(contains(/_R_/_get/nid,'ledger'))">
				<xsl:value-of select="//option_get/display_num_entries"/>
			</xsl:if>
		</xsl:variable>
		<table cellpadding="0" align="right">
			<tr>
				<xsl:if test="(/_R_/_get/start!=0) and not(/_R_/_get/start='NaN')">
					<td>
						<input type="button" value="Previous">
							<xsl:attribute name="onclick">
								<xsl:text>document.location.href='</xsl:text>
								<xsl:value-of select="$my_uri"/>
								<xsl:text>&amp;start=</xsl:text>
								<xsl:value-of select="/_R_/_get/start - $incr + 1"/>'</xsl:attribute>
						</input>
					</td>

					<td>
						<input type="button" value="Next">
							<xsl:attribute name="onclick">
								<xsl:text>document.location.href='</xsl:text>
								<xsl:value-of select="$my_uri"/>
								<xsl:text>&amp;start=</xsl:text>
								<xsl:value-of select="/_R_/_get/start + $incr - 1"/>'</xsl:attribute>
						</input>
					</td>
				</xsl:if>

				<xsl:if test="(/_R_/_get/start=0) or not(/_R_/_get/start)">
					<td>
						<input type="button" value="Previous" disabled="disabled"></input>
					</td>

					<td>
						<input type="button" value="Next">
							<xsl:attribute name="onclick">
								<xsl:text>document.location.href='</xsl:text>
								<xsl:value-of select="$my_uri"/>
								<xsl:text>&amp;start=</xsl:text>
								<xsl:value-of select="$incr - 1"/>'</xsl:attribute>
						</input>
					</td>
				</xsl:if>
			</tr>
		</table>
	</xsl:template>
</xsl:stylesheet>