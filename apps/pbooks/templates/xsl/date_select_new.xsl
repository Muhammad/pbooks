<!--
Program: PBooks
Component: date_select_new.xsl
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
	<xsl:template name="date_select_new">
		<xsl:param name="link_prefix"/>
		<xsl:param name="path_prefix"/>
		<xsl:param name="i18n"/>
		<xsl:param name="my_from_date" select="/_R_/runtime/from_date"/>

    <!-- Need this action to retain any account selection -->
		<div id="date_controls">
		<div>
			<span onclick="$('#date_controller').hide();">Hide</span>
			<span onclick="$('#date_controller').show();">Show</span>
			<span><xsl:value-of select="substring($my_from_date,0,11)"/> - 
      <xsl:value-of select="substring(/_R_/runtime/to_date,0,11)"/></span>
		</div>
		<div id="date_controller" style="width: 500px;">
		<form method="get">
			<input type="hidden" name="nid" value="{/_R_/_get/nid}"/>
			<xsl:if test="/_R_/_get/account_id">
				<input type="hidden" name="account_id" value="{/_R_/_get/account_id}"/>
			</xsl:if>
			<table>
				<tr>
					<td>
						<xsl:value-of select="$i18n/month"/>:
          </td>
					<td>
						<select name="month" onchange="this.form.submit();">
							<option value="%">All</option>
							<xsl:for-each select="//months/option">
								<option value="{@id}">
									<xsl:if test="@id=/_R_/_get/month">
										<xsl:attribute name="selected">selected</xsl:attribute>
									</xsl:if>
									<xsl:value-of select="@fullname"/>
								</option>
							</xsl:for-each>
						</select>
					</td>
				</tr>
			</table>
		</form>
		<form method="get">
			<xsl:if test="/_R_/_get/account_id">
				<input type="hidden" name="account_id" value="{/_R_/_get/account_id}"/>
			</xsl:if>
			<input type="hidden" name="nid" value="{/_R_/_get/nid}"/>
			<xsl:call-template name="date_select"/>
			<input type="submit"/>
		</form>
		<table>
			<form method="get">
				<tr>
					<input type="hidden" name="nid" value="{/_R_/_get/nid}"/>
					<td>
						<xsl:value-of select="$i18n/select_one"/>:
          </td>
					<td align="right">
						<select name="account_id" onchange="this.form.submit();">
							<option value="%">
								<xsl:value-of select="$i18n/ledger"/>
							</option>

							<xsl:for-each select="/_R_/get_all_accounts/get_all_accounts">
								<option value="{id}">
									<xsl:if test="id=/_R_/_get/account_id">
										<xsl:attribute name="selected">selected</xsl:attribute>
									</xsl:if>
									<xsl:value-of select="name"/>
								</option>
							</xsl:for-each>
						</select>
					</td>
					<td/>
				</tr>
			</form>
		</table>
		</div>
		</div>


	</xsl:template>
	<xsl:template name="date_select">
		<xsl:param name="link_prefix"/>
		<xsl:param name="path_prefix"/>
		<xsl:param name="i18n"/>
		<xsl:param name="my_from_date" select="/_R_/runtime/from_date"/>

		<a title="Previous Period">
			<xsl:attribute name="href">
				<xsl:value-of select="$link_prefix"/>
				<xsl:value-of select="/_R_/_get/nid"/>
				<xsl:text>&amp;from_date=</xsl:text>
				<xsl:value-of select="/_R_/runtime/prev_from_date"/>
				<xsl:text>&amp;to_date=</xsl:text>
				<xsl:value-of select="/_R_/runtime/prev_to_date"/>
				<xsl:if test="//_get/account_id">
					<xsl:text>&amp;account_id=</xsl:text>
					<xsl:value-of select="//_get/account_id"/>
				</xsl:if>
			</xsl:attribute>
			<img style="padding-right: 5px;" src="{$path_prefix}s/images/buttons/out.gif"/>
		</a>

		From <input type="text" name="from_date" size="12" class="date_input" value="{substring($my_from_date,0,11)}"/>

		To <input type="text" name="to_date"  size="12" class="date_input" value="{substring(/_R_/runtime/to_date,0,11)}"/>

		<a title="Next Period">
			<xsl:attribute name="href">
				<xsl:value-of select="$link_prefix"/>
				<xsl:value-of select="/_R_/_get/nid"/>
				<xsl:text>&amp;from_date=</xsl:text>
				<xsl:value-of select="/_R_/runtime/next_from_date"/>
				<xsl:text>&amp;to_date=</xsl:text>
				<xsl:value-of select="/_R_/runtime/next_to_date"/>
				<xsl:if test="//_get/account_id">
					<xsl:text>&amp;account_id=</xsl:text>
					<xsl:value-of select="//_get/account_id"/>
				</xsl:if>
			</xsl:attribute>
			<img style="padding-right: 5px;"
				src="{$path_prefix}s/images/buttons/in.gif"/>
		</a>


		<script type="text/javascript">
		$($.date_input.initialize);

		$.extend(DateInput.DEFAULT_OPTS, {
			stringToDate: function(string) {
				var matches;
				if (matches = string.match(/^(\d{4,4})-(\d{2,2})-(\d{2,2})$/)) {
					return new Date(matches[1], matches[2] - 1, matches[3]);
				} else {
					return null;
				};
			},

			dateToString: function(date) {
				var month = (date.getMonth() + 1).toString();
				var dom = date.getDate().toString();
				if (month.length == 1) month = "0" + month;
				if (dom.length == 1) dom = "0" + dom;
				return date.getFullYear() + "-" + month + "-" + dom;
			}
		});
		</script>

	</xsl:template>
</xsl:stylesheet>