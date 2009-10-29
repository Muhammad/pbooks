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


<!-- MONTH BY MONTH -->
<div id="date_controller">
<form method="get" id="dc4">
	<input id="dc5" type="hidden" name="nid" value="{/_R_/_get/nid}"/>
	<xsl:if test="/_R_/_get/account_id">
		<input  id="dc6" type="hidden" name="account_id" value="{/_R_/_get/account_id}"/>
	</xsl:if>
	<table id="dc7">
		<tr id="dc8">
			<td id="dc9">
				<xsl:value-of select="$i18n/month"/>:
			</td>
			<td id="dc10">
				<select id="dc11" name="month" onchange="this.form.submit();">
					<option id="dc12" value="%">All</option>
					<xsl:for-each select="//months/option">
						<option  id="dc13_{@id}" value="{@id}">
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
<form method="get" id="dc14">
	<input id="dc15" type="hidden" name="nid" value="{/_R_/_get/nid}"/>
	<xsl:call-template name="date_select"/>
	<br/>
	<select name="account_id" onchange="this.form.submit();" id="dc23">
		<option value="%" id="dc24">
			<xsl:value-of select="$i18n/ledger"/>
		</option>

		<xsl:for-each select="/_R_/get_all_accounts/get_all_accounts">
			<option value="{id}" id="dc24_{id}">
				<!-- RETAIN SUPPORT FOR NON-JAVASCRIPT CLIENTS? -->
				<xsl:if test="id=/_R_/_get/account_id">
					<xsl:attribute name="selected">selected</xsl:attribute>
				</xsl:if>
				<xsl:value-of select="name"/>
			</option>
		</xsl:for-each>
	</select>
	<br/>
	<input id="dc16" type="submit"/>
</form>

<!-- SELECT BY ACCOUNT -->
<!--
<table id="dc17">
	<form method="get" id="dc18">
		<tr id="dc19">
			<input id="dc20" type="hidden" name="nid" value="{/_R_/_get/nid}"/>
			<td id="dc21">
				<xsl:value-of select="$i18n/select_one"/>:
			</td>
			<td align="right" id="dc22">
				<select name="account_id" onchange="this.form.submit();" id="dc23">
					<option value="%" id="dc24">
						<xsl:value-of select="$i18n/ledger"/>
					</option>

					<xsl:for-each select="/_R_/get_all_accounts/get_all_accounts">
						<option value="{id}" id="dc24_{id}">
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
-->
</div>


	</xsl:template>
	<xsl:template name="date_select">
		<xsl:param name="link_prefix"/>
		<xsl:param name="path_prefix"/>
		<xsl:param name="i18n"/>
		<xsl:param name="my_from_date" select="/_R_/runtime/from_date"/>

<!-- DATES -->
<a title="Previous Period" id="dc25">
	<xsl:attribute name="href">
		<xsl:text>&amp;from_date=</xsl:text>
		<xsl:value-of select="/_R_/runtime/prev_from_date"/>
		<xsl:text>&amp;to_date=</xsl:text>
		<xsl:value-of select="/_R_/runtime/prev_to_date"/>
		<xsl:if test="//_get/account_id">
			<xsl:text>&amp;account_id=</xsl:text>
			<xsl:value-of select="//_get/account_id"/>
		</xsl:if>
	</xsl:attribute>
	<img src="{$path_prefix}s/images/buttons/out.gif" id="dc26"/>
</a>

From <input type="text" name="from_date" size="12" value="{substring($my_from_date,0,11)}" id="dc27"/>

To <input type="text" name="to_date"  size="12" value="{substring(/_R_/runtime/to_date,0,11)}" id="dc28"/>

<a title="Next Period" id="dc29">
	<xsl:attribute name="href">
		<xsl:text>&amp;from_date=</xsl:text>
		<xsl:value-of select="/_R_/runtime/next_from_date"/>
		<xsl:text>&amp;to_date=</xsl:text>
		<xsl:value-of select="/_R_/runtime/next_to_date"/>
		<xsl:if test="//_get/account_id">
			<xsl:text>&amp;account_id=</xsl:text>
			<xsl:value-of select="//_get/account_id"/>
		</xsl:if>
	</xsl:attribute>
	<img
		src="{$path_prefix}s/images/buttons/in.gif" id="dc30"/>
</a>


	</xsl:template>
</xsl:stylesheet>