<!--
Program: PBooks
Component: report_balance_sheet.xsl
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
<xsl:import href="main.xsl"/>
<xsl:include href="accounting_menu.xsl"/>
<xsl:template name="content">
<div style="text-align: center;">
    <h2><xsl:value-of select="//company_name"/></h2>
</div>
<table class="data-table" width="740" align="center">
	<tr>
		<td align="center">
            <xsl:value-of select="/__ROOT__/i18n/labels/label[key='balance_sheet']/value"/>
            &#160;
            <xsl:value-of select="//to_date"/>
        </td>
	</tr>
	<tr>
		<td>
			<table width="100%" cellpadding="0" cellspacing="0" border="0">
				<tr class="row1">
					<td><b><xsl:value-of select="/__ROOT__/i18n/labels/label[key='assetsb']/value"/></b></td>
					<td align="right"><b><xsl:value-of select="//to_date"/></b></td>
					<td align="right"><!--<b><xsl:value-of select="//_post/from_month"/>-<xsl:value-of select="//_post/from_day"/>-<xsl:value-of select="//_post/from_year"/></b>--></td>
				</tr>
				<xsl:for-each select="//get_all_accounts">
				<xsl:if test="account_type_id='10000'">
				<xsl:variable name="this_a_account_id"><xsl:value-of select="id"/></xsl:variable>
                <xsl:variable name="asset_value"><xsl:value-of select="format-number((sum(/__ROOT__/get_all_entry_amounts[entry_type_id='Debit'][account_id=$this_a_account_id]/entry_amount) - sum
		(/__ROOT__/get_all_entry_amounts[entry_type_id='Credit'][account_id=$this_a_account_id]/entry_amount)),'#,###,###.##')"/></xsl:variable>
				<xsl:if test="not($asset_value=0)">
                <tr>
					<td class="journal-data"><div class="sm_indent"><a href="{//link_prefix}ledger&amp;account_id={id}"><xsl:value-of select="name"/></a></div></td>
					<td align="right" class="journal-data"><xsl:value-of select="$asset_value"/></td>
					<td align="right"></td>
				</tr>
                </xsl:if>
				</xsl:if>
				</xsl:for-each>
				<tr>
					<td class="journal-data"><div class="sm_indent"><xsl:value-of select="/__ROOT__/i18n/labels/label[key='total_assets']/value"/></div></td>
					<td align="right" class="journal-data"><b><xsl:value-of select="format-number((sum(//get_all_entry_amounts[account_type_id=10000][entry_type_id='Debit']
					/entry_amount)-sum(/__ROOT__/get_all_entry_amounts[account_type_id=10000][entry_type_id='Credit']/entry_amount)),'#,###,###.##')"/></b></td>
					<td align="right"></td>
				</tr>
				<tr>
					<td>&#160;</td>
					<td align="right"></td>
					<td align="right"></td>
				</tr>
				
				
				<tr class="row1">
					<td><b><xsl:value-of select="/__ROOT__/i18n/labels/label[key='liabilities_equity']/value"/></b></td>
					<td align="right"><b><xsl:value-of select="//to_date"/></b></td>
					<td align="right"><!--<b><xsl:value-of select="//_post/from_month"/>-<xsl:value-of select="//_post/from_day"/>-<xsl:value-of select="//_post/
					from_year"/></b>--></td>
				</tr>
				<xsl:for-each select="//get_all_accounts">
				<xsl:if test="account_type_id='20000'">
				<xsl:variable name="this_l_account_id"><xsl:value-of select="id"/></xsl:variable>
                <xsl:variable name="liability_value"><xsl:value-of select="format-number((sum(//get_all_entry_amounts[entry_type_id='Credit'][account_id=$this_l_account_id]/entry_amount) - sum
		(/__ROOT__/get_all_entry_amounts[entry_type_id='Debit'][account_id=$this_l_account_id]/entry_amount)),'#,###,###')"/></xsl:variable>
				<xsl:if test="not($liability_value=0)">
                <tr>
					<td class="journal-data"><div class="sm_indent"><a href="{//link_prefix}ledger&amp;account_id={id}"><xsl:value-of select="name"/></a></div></td>
					<td align="right" class="journal-data"><xsl:value-of select="$liability_value"/></td>
					<td align="right"></td>
				</tr>
                </xsl:if>
				</xsl:if>
				</xsl:for-each>
				<tr>
					<td class="journal-data"><div class="sm_indent"><xsl:value-of select="/__ROOT__/i18n/labels/label[key='total_liabilities']/value"/></div></td>
					<td align="right" class="journal-data"><xsl:value-of select="format-number((sum(/__ROOT__/get_all_entry_amounts[account_type_id=20000][entry_type_id=
					'Credit']/entry_amount)-sum(/__ROOT__/get_all_entry_amounts[account_type_id=20000][entry_type_id='Debit']/entry_amount)),'#,###,###.##')"/></td>
					<td align="right"></td>
				</tr>
				<tr>
					<td>&#160;</td>
					<td align="right"></td>
					<td align="right"></td>
				</tr>
				<xsl:for-each select="/__ROOT__/get_all_accounts">
				<xsl:if test="account_type_id='30000'">
				<xsl:variable name="this_e_account_id"><xsl:value-of select="id"/></xsl:variable>
				<tr>
					<td class="journal-data"><div class="sm_indent"><a href="{//link_prefix}ledger&amp;account_id={id}"><xsl:value-of select="name"/></a></div></td>
					<td align="right" class="journal-data"><xsl:if test="name='Retained Earnings'"><xsl:value-of select="format-number(
                    
                    sum(/__ROOT__/get_all_entry_amounts[entry_type_id='Debit'][account_type_id=40000]/entry_amount)-
                    sum(/__ROOT__/get_all_entry_amounts[entry_type_id='Credit'][account_type_id=40000]/entry_amount)+
                    sum(/__ROOT__/get_all_entry_amounts[entry_type_id='Debit'][account_type_id=50000]/entry_amount)-
                    sum(/__ROOT__/get_all_entry_amounts[entry_type_id='Credit'][account_type_id=50000]/entry_amount)
                    
                    ,'####,###.##')"/></xsl:if>
					
					<xsl:if test="not(name='Retained Earnings')">
					<xsl:value-of select="format-number((sum(/__ROOT__/get_all_entry_amounts[entry_type_id='Credit'][account_id=$this_e_account_id]/entry_amount) - sum
					(/__ROOT__/get_all_entry_amounts[entry_type_id='Debit'][account_id=$this_e_account_id]/entry_amount)),'#,###,###.##')"/>
										</xsl:if></td>
					<td align="right"></td>
				</tr>
				</xsl:if>
				</xsl:for-each>
				<tr>
					<td class="journal-data"><div class="sm_indent"><xsl:value-of select="/__ROOT__/i18n/labels/label[key='total_equity']/value"/></div></td>
					<td align="right" class="journal-data"></td>
					<td align="right"></td>
				</tr>
				<tr>
					<td>&#160;</td>
					<td align="right"></td>
					<td align="right"></td>
				</tr>
				<tr>
					<td class="journal-data"><div class="sm_indent"><xsl:value-of select="/__ROOT__/i18n/labels/label[key='total_liabilities_equity']/value"/>
					</div></td>
                    
                    <!-- This is really obtuse for testing purposes, and so developers can understand what's going on. 
                    Will be cleaned up in the near future.-->
					<td align="right" class="journal-data"><b><xsl:value-of select="format-number((
                    
                    sum(/__ROOT__/get_all_entry_amounts[account_type_id=20000][entry_type_id='Credit']/entry_amount)-
                    sum(/__ROOT__/get_all_entry_amounts[account_type_id=20000][entry_type_id='Debit']/entry_amount) - 
                    (
                    sum(/__ROOT__/get_all_entry_amounts[entry_type_id='Debit'][account_type_id=40000]/entry_amount)-
                    sum(/__ROOT__/get_all_entry_amounts[entry_type_id='Credit'][account_type_id=40000]/entry_amount)+
                    sum(/__ROOT__/get_all_entry_amounts[entry_type_id='Debit'][account_type_id=50000]/entry_amount)-
                    sum(/__ROOT__/get_all_entry_amounts[entry_type_id='Credit'][account_type_id=50000]/entry_amount)
                    ) +
					(sum(/__ROOT__/get_all_entry_amounts[entry_type_id='Credit'][account_type_id=30000]/entry_amount) - sum
					(/__ROOT__/get_all_entry_amounts[entry_type_id='Debit'][account_type_id=30000]/entry_amount))
                    ),'#,###,###.##')"/></b></td>
					<td align="right"></td>
				</tr>
			</table>
		</td>
	</tr>
</table>

</xsl:template>
</xsl:stylesheet>