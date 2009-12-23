<!--
Program: PBooks
Component: account_groups.xsl
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
		<xsl:param name="link_prefix"/>
		<xsl:param name="path_prefix"/>


<script type="text/javascript"
src="{$link_prefix}x-tablesorter-setup-js&amp;selector=accounts_table&amp;simple=true" />

<div class="generic-button" style="text-align: right;">
  <a href="{$link_prefix}account-group-edit">
    <img src="{$path_prefix}{/_R_/runtime/icon_set}/folder_new.gif"/>
    <span id="i18n-new_account_group">New Account Group</span>
  </a>
</div>

<table class="tablesorter" id="accounts_table">
  <thead>
    <tr>
      <th>ID</th>
      <th>
        <span id="i18n-group_name">Group Name</span>
      </th>
      <th>
        <span id="i18n-desc">Description</span>
      </th>
      <th>
        <span id="i18n-edit">Edit</span>
      </th>
      <th>
        <span id="i18n-delete">Delete</span>
      </th>
    </tr>
  </thead>
  <tbody>
    <xsl:apply-templates select="//groups/group">
      <xsl:with-param name="link_prefix" select="$link_prefix"/>
    </xsl:apply-templates>
  </tbody>
</table>
</xsl:template>

<xsl:template match="group">
<xsl:param name="parent_gid">0</xsl:param>
<xsl:param name="generation">0</xsl:param>
<xsl:param name="link_prefix"/>
<xsl:variable name="my_group_id" select="group_id"/>

<tr class="row2" id="g_{group_id}">
  <td>
    <xsl:value-of select="group_id"/>
  </td>
  <td>
    <xsl:if test="not($parent_gid='0')">
      <xsl:call-template name="generation_indent">
        <xsl:with-param name="iterator" select="$generation"/>
      </xsl:call-template>
            +----
        </xsl:if>
    <a href="{$link_prefix}account-group-edit&amp;group_id={group_id}">
      <xsl:value-of select="name"/>
    </a>
  </td>
  <td>
    <a href="{$link_prefix}account-group-edit&amp;group_id={group_id}">
      <xsl:value-of select="description"/>
    </a>
  </td>
  <td>
    <a href="{$link_prefix}account-group-edit&amp;group_id={group_id}"
    id="{account_number}-e">
      <span id="i18n-edit">Edit</span>
    </a>
  </td>
  <td>
    <a href="{$link_prefix}account-group-delete&amp;group_id={group_id}"
   id="{account_group}-d"
   onclick="account_group_delete({group_id}); return false;">
      <span id="i18n-delete">Delete</span>
    </a>
  </td>
</tr>
<xsl:apply-templates select="group">
  <xsl:with-param name="link_prefix" select="$link_prefix"/>
  <xsl:with-param name="parent_gid" select="$my_group_id"/>
  <xsl:with-param name="generation" select="$generation+1"/>
</xsl:apply-templates>


	</xsl:template>

	<xsl:template name="generation_indent">
		<xsl:param name="iterator">0</xsl:param>
		<xsl:if test="$iterator &gt; '0'">
			<span style="margin-left: {20 * $iterator}px;"></span>
			<xsl:call-template name="generation_indent">
				<xsl:with-param name="iterator" select="$iterator - 1"/>
			</xsl:call-template>
		</xsl:if>
	</xsl:template>
</xsl:stylesheet>