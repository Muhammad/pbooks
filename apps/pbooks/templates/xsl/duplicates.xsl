<!--
Program: PBooks
Component: duplicates.xsl
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
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:include href="main.xsl"/>
<xsl:include href="pager.xsl"/>
<xsl:template name="content">
<xsl:call-template name="jquery-setup">
    <xsl:with-param name="my-table">myDups</xsl:with-param>
</xsl:call-template>

<xsl:value-of select="/_R_/i18n/label[key='duplicates_info']/value"/>
<xsl:variable name="my_link_prefix">
    <xsl:value-of select="/_R_/runtime/link_prefix"/>
</xsl:variable>
<br/><br/>
<table class="tablesorter" id="myDups">
    <thead>
    <tr>
        <th>
            <xsl:value-of select="/_R_/i18n/label[key='post']/value"/>
        </th>
        <th>
            <xsl:value-of select="/_R_/i18n/label[key='date']/value"/>:
        </th>
        <th>
            Memo.
        </th>
        <xsl:if test="(/_R_/_get/account_id='%' or not(/_R_/_get/account_id))">
            <th>
                <xsl:value-of select="/_R_/i18n/label[key='account']/value"/>
            </th>
        </xsl:if>
        <th>
            <xsl:value-of select="/_R_/i18n/label[key='amount']/value"/>
        </th>
        <xsl:if test="(not(/_R_/_get/account_id='%') and _R_/_get/account_id)">
            <th>
                Balance
            </th>
        </xsl:if>
    </tr>
    </thead>

    <!-- ROWS OF POTENTIALLY DUPLICATE ENTRIES -->
    <tbody>
        <xsl:for-each select="/_R_/get_all_transactions|/_R_/get_all_entry_amounts">
        <xsl:sort select="entry_datetime"/>
        <xsl:variable name="this_entry_id"><xsl:value-of select="entry_id"/></xsl:variable>
        <xsl:variable name="my_entry_datetime"><xsl:value-of select="entry_datetime"/></xsl:variable>

        <!-- THIS IS THE MOST IMPORTANT PART OF THIS FILE -->
        <!-- only show the similar ones - first check if there is an unmatched transaction and an existing entry on the same day, then check for equal amounts (and abs val)-->
        <xsl:if test="
        (transaction_id and (entry_amount=/_R_/get_all_entry_amounts[entry_datetime=$my_entry_datetime]/entry_amount or entry_amount=0-/_R_/get_all_entry_amounts[entry_datetime=$my_entry_datetime]/entry_amount)) 
        
        or (not(transaction_id) and (entry_amount=/_R_/get_all_transactions[entry_datetime=$my_entry_datetime]/entry_amount or
        entry_amount=0-/_R_/get_all_transactions[entry_datetime=$my_entry_datetime]/entry_amount))
        ">
        <!-- END MOST IMPORTANT PART -->
        <tr>
            <td></td>
            <td>
                <a href="{$my_link_prefix}journal&amp;from_date={entry_datetime}">
                    <xsl:value-of select="entry_datetime"/>
                </a>
            </td>
            <td>
                <xsl:value-of select="substring(memorandum[not(.='NULL')],0,20)"/>
            </td>
            <td>
                <a href="{$my_link_prefix}ledger&amp;account_id={account_id}">
                    <xsl:value-of select="name"/>
                </a>
            </td>
            <td colspan="3">
                <xsl:value-of select="entry_amount"/>
            </td>
        </tr>
        </xsl:if>
        </xsl:for-each>
    </tbody>
</table>
<xsl:call-template name="pager"/>
</xsl:template>
</xsl:stylesheet>