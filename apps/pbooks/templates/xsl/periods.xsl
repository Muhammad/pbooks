<!--
Program: PBooks
Component: periods.xsl
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
  <xsl:include href="pager.xsl"/>
  <xsl:template name="content">
    <xsl:param name="link_prefix"/>
    <xsl:param name="i18n"/>


<script type="text/javascript"
src="{$link_prefix}x-tablesorter-setup-js&amp;selector=periods_table&amp;simple=true" />

<xsl:value-of select="$i18n/period_info"/>
<table class="tablesorter" id="periods_table">
	<thead>
		<tr>
			<th>
				<span id="i18n-period_id">Period ID</span>
			</th>
			<th>
				<span id="i18n-period_value">Period Value</span>
			</th>
		</tr>
	</thead>
	<tbody>
		<xsl:for-each select="/_R_/fiscal_periods/period">
			<tr>
				<td>
					<xsl:value-of select="period_id"/>
				</td>
				<td>
					<xsl:value-of select="period_value"/>
				</td>
			</tr>
		</xsl:for-each>
	</tbody>
</table>
<br/>
<p>
To add a new period, edit the data/xml/fiscal_periods.xml file.
</p>
<!-- TODO: THIS IS DONE IN AN XML FILE -->
<!--
<form method="post">
	Create new period:
	<br/>
	<table>
		<tr>
			<td>From date:</td>
			<td><input type="text" name="from_date"/></td>
		</tr>
		<tr>
			<td>To date:</td>
			<td><input type="text" name="to_date"/></td>
		</tr>
	</table>
	<input type="submit"/>
</form>
-->

  </xsl:template>
</xsl:stylesheet>