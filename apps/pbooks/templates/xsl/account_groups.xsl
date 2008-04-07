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
or write to the Free Software Foundation,Inc., 51 Franklin Street,
Fifth Floor, Boston, MA 02110-1301  USA
-->
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" >
<xsl:include href="main.xsl"/>
<xsl:include href="accounting_menu.xsl"/>
<xsl:include href="pager.xsl"/>
<xsl:template name="content">
<xsl:call-template name="jquery-setup-simple"/>
<!-- This is the text for the deletion confirm -->
<script type="text/javascript">
    var question = '<xsl:value-of select="/__ROOT__/i18n/labels/label[key='delete_account_group']/value"/>?';
    function account_group_delete(group_id,row) {
        if(confirm(question)) { 
            $.post("<xsl:value-of select="//link_prefix"/>account-group-delete", {'group_id': group_id}, 
            function (data){
                myTable = document.getElementById("accounts_table");
                myTable.deleteRow(row);
            });
        }
    }
</script>

<div class="generic-button" style="text-align: right;">
    <a href="{/__ROOT__/runtime/link_prefix}account-group-edit"><img src="{//path_prefix}{//icon_set}/folder_new.gif"/>
        <xsl:value-of select="/__ROOT__/i18n/labels/label[key='new_account_group']/value"/>
    </a>
</div>

<table class="tablesorter" id="accounts_table">
    <thead>
	<tr>
		<th>ID</th>
		<th><xsl:value-of select="__ROOT__/i18n/labels/label[key='group_name']/value"/></th>
		<th><xsl:value-of select="__ROOT__/i18n/labels/label[key='desc']/value"/></th>
		<th><xsl:value-of select="__ROOT__/i18n/labels/label[key='edit']/value"/></th>
		<th><xsl:value-of select="__ROOT__/i18n/labels/label[key='delete']/value"/></th>
	</tr>
    </thead>
    <tbody>
    <xsl:apply-templates select="//groups/group"/>
    </tbody>
</table>
</xsl:template>

<xsl:template match="group">
    <xsl:param name="parent_gid">0</xsl:param>
    <xsl:param name="generation">0</xsl:param>
    <xsl:variable name="my_group_id"><xsl:value-of select="group_id"/></xsl:variable>
    <xsl:variable name="my_link_prefix"><xsl:value-of select="/__ROOT__/runtime/link_prefix"/></xsl:variable>
	<tr class="row2">
		<td><xsl:value-of select="group_id"/></td>
		<td>
        <xsl:if test="not($parent_gid='0')">
            <xsl:call-template name="generation_indent"><xsl:with-param name="iterator"><xsl:value-of select="$generation"/></xsl:with-param></xsl:call-template>\----
        </xsl:if>
        <a href="{$my_link_prefix}account-group-edit&amp;id={group_id}"><xsl:value-of select="name"/></a></td>
		<td><a href="{$my_link_prefix}account-group-edit&amp;id={group_id}"><xsl:value-of select="description"/></a></td>
		<td><a href="{$my_link_prefix}account-group-edit&amp;id={group_id}" id="{account_number}-e"><xsl:value-of select="/__ROOT__/i18n/labels/label[key='edit']/value"/></a></td>
		<td><a id="{account_group}-d" href="{//link_prefix}account-group-delete&amp;group_id={group_id}"
        onclick="account_group_delete({group_id},this.parentNode.parentNode.rowIndex); return false; "><xsl:value-of select="/__ROOT__/i18n/labels/label[key='delete']/value"/></a></td>
	</tr>    
    <xsl:apply-templates select="group">
    <xsl:with-param name="parent_gid"><xsl:value-of select="$my_group_id"/></xsl:with-param>
    <xsl:with-param name="generation"><xsl:value-of select="$generation+1"/></xsl:with-param></xsl:apply-templates>
</xsl:template>

<xsl:template name="generation_indent">
    <xsl:param name="iterator">0</xsl:param>
    <xsl:if test="$iterator &gt; '0'">
    <span style="margin-left: {20 * $iterator}px;"></span>
    <xsl:call-template name="generation_indent"><xsl:with-param name="iterator"><xsl:value-of select="$iterator - 1"/></xsl:with-param>
    </xsl:call-template>
    </xsl:if>
</xsl:template>
</xsl:stylesheet>