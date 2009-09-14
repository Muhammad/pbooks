<!--
Program: PBooks
Component: preferences.xsl
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
	<xsl:include href="html_main.xsl"/>
	<xsl:template name="content">
		<div style="padding: 30px;">
			<form method="post">
				<table>
					<xsl:for-each select="/_R_/user_options/option">
						<xsl:call-template name="option_row">
              <xsl:with-param
                name   = "option_get"
                select = "/_R_/option_get/option_get"
              />
            </xsl:call-template>
					</xsl:for-each>
				</table>
				<br/>
				<input type="submit" name="submit" value="Submit" id="mysubmit"/>
			</form>
		</div>

	</xsl:template>
	<xsl:template name="option_row">
    <xsl:param name="option_get"/>
		<xsl:variable name="my_option" select="option_key"/>
		<tr>
			<td>
				<xsl:value-of select="title"/>:
			</td>
			<td>
				<xsl:if test="option_type='text'">
					<input type="{option_type}" name="{option_key}">
						<xsl:attribute name="value">
							<xsl:if test="
              $option_get[option_key=$my_option]/option_value='NULL' or
              $option_get[option_key=$my_option]/option_value=''
              ">
								<xsl:value-of select="default"/>
							</xsl:if>

							<xsl:if test="
              not($option_get[option_key=$my_option]/option_value='NULL' or $option_get[option_key=$my_option]/option_value='')
              ">
								<xsl:value-of select="$option_get[option_key=$my_option]/option_value"/>
							</xsl:if>

						</xsl:attribute>
					</input>
				</xsl:if>
				<xsl:if test="option_type='checkbox'">
					<input type="{option_type}" name="{option_key}">
						<xsl:if test="$option_get[option_key=$my_option]/option_value='on'">
							<xsl:attribute name="checked">checked</xsl:attribute>
						</xsl:if>
					</input>
				</xsl:if>
			</td>
		</tr>
	</xsl:template>
</xsl:stylesheet>
