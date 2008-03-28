<!--
Program: PBooks
Component: welcome.xsl
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
<xsl:template name="content">
<div style="padding: 25px;">

<xsl:value-of select="/__ROOT__/i18n/labels/label[key='wicked_cool']/value"/>
<br/><br/>
<b><xsl:value-of select="/__ROOT__/i18n/labels/label[key='get_started']/value"/></b>
<br/><br/>
<ul>
    <li>
        <a href="{__ROOT__/runtime/link_prefix}ledger"><xsl:value-of select="/__ROOT__/i18n/labels/label[key='view_the_ledger']/value"/></a>
    </li>
    <li>
        <a href="{__ROOT__/runtime/link_prefix}journal-new"><xsl:value-of select="/__ROOT__/i18n/labels/label[key='make']/value"/></a>
    </li>
    <li><a href="{__ROOT__/runtime/link_prefix}journal"><xsl:value-of select="/__ROOT__/i18n/labels/label[key='view']/value"/></a></li>
</ul>



<b><xsl:value-of select="__ROOT__/i18n/labels/label[key='quick_stats']/value"/></b>
<br/><br/>
    
<!-- This table displays some basic information about the books -->
<table cellpadding="5" cellspacing="0" width="300">
    <tr class="row1">
        <td>
            <a href="{/__ROOT__/runtime/link_prefix}accounts">
            <xsl:value-of select="/__ROOT__/i18n/labels/label[key='accounts']/value"/></a>
        </td>
        <td>
            <xsl:value-of select="//select_account_stats/account_stats"/>
        </td>
    </tr>
    <tr class="row1">
        <td>
            <a href="{/__ROOT__/runtime/link_prefix}ledger">
            <xsl:value-of select="/__ROOT__/i18n/labels/label[key='ledger_transactions']/value"/></a>
        </td>
        <td>
            <xsl:value-of select="//select_account_stats/gl_stats"/>
        </td>
    </tr>
    <tr class="row1">
        <td>
            <a href="{/__ROOT__/runtime/link_prefix}journal">
            <xsl:value-of select="/__ROOT__/i18n/labels/label[key='journal_entry_amounts']/value"/></a>
        </td>
        <td>
            <xsl:value-of  select="//select_account_stats/entry_amounts_stats"/>
        </td>
    </tr>
    <tr class="row1">
        <td>
            <a href="{/__ROOT__/runtime/link_prefix}journal">
            <xsl:value-of  select="/__ROOT__/i18n/labels/label[key='journal_entries']/value"/></a>
        </td>
        <td>
            <xsl:value-of  select="//select_account_stats/entry_stats"/>
        </td>
    </tr>
</table>
<br/><br/>
<xsl:value-of select="/__ROOT__/i18n/labels/label[key='number_transactions']/value"/>
</div>
</xsl:template>
</xsl:stylesheet>
