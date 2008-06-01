<!--
Program: PBooks
Component: report_profit_loss.xsl
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

<xsl:template name="content">
<!-- Set some variables -->
<xsl:variable name="monthnum">
    <xsl:value-of select="number(substring(/_R_/runtime/to_date,6,2) - substring(/_R_/runtime/from_date,6,2) + 1)"/>
</xsl:variable>
<xsl:variable name="from_month">
    <xsl:value-of select="substring(/_R_/runtime/from_date,6,2)"/>
</xsl:variable>
<xsl:variable name="to_month">
    <xsl:value-of select="substring(/_R_/runtime/to_date,6,2)"/>
</xsl:variable>
<!-- end variables -->


<div style="text-align: center;">
    <h2><xsl:value-of select="//company_name"/></h2>
</div>
<table class="data-table" width="740" align="center">
	<tr>
		<td align="center">
        <xsl:value-of select="/_R_/i18n/label[key='income_statement']/value"/>&#160;
        <xsl:value-of select="/_R_/runtime/from_date"/>
		<xsl:value-of select="/_R_/i18n/label[key='through']/value"/> <xsl:value-of select="/_R_/runtime/to_date"/>
    </td>
	</tr>
	<tr>
		<td>
		<table width="100%" class="matrix-table" cellspacing="1" cellpadding="0" border="0" bgcolor="gray">
			<tr>
				<td class="matrix-data"> </td>
				<xsl:for-each select="//months/option">
					<xsl:if test="@id &gt;= $from_month and @id &lt;= $to_month">
						<td class="matrix-data"><xsl:value-of select="@shortname"/></td>
					</xsl:if>
				</xsl:for-each>
				<td class="matrix-data"><xsl:value-of select="/_R_/i18n/label[key='total']/value"/></td>
			</tr>
			<!--  REVENUE -->
			<tr>
				<td class="matrix-data"><xsl:value-of select="/_R_/i18n/label[key='revenue']/value"/></td>
				 <xsl:call-template name="empty_cell">
					  <xsl:with-param name="repeat" select="$monthnum + 1"/>
				 </xsl:call-template>
			</tr>
			<xsl:variable name="rev">40000</xsl:variable>
			<xsl:for-each select="/_R_/get_all_accounts/get_all_accounts[account_type_id=$rev]">
			<xsl:variable name="this_r_account_id"><xsl:value-of select="id"/></xsl:variable>
			<tr class="row{position() mod 2}">
				<td class="matrix-data" style="text-indent: 16px;">
                    <a href="{/_R_/runtime/link_prefix}ledger&amp;account_id={id}">
                        <xsl:value-of select="name"/>
                    </a>
                </td>
				 <xsl:call-template name="revenue_cell">
					  <xsl:with-param name="repeat" select="$monthnum"/>
					  <xsl:with-param name="mn" select="$from_month"/>
					  <xsl:with-param name="this_r_account_id" select="$this_r_account_id"/>
					  <xsl:with-param name="rev" select="$rev"/>
				 </xsl:call-template>

				<td class="matrix-data">
<xsl:value-of 
select="sum(/_R_/get_all_entry_amounts/get_all_entry_amounts[account_type_id=$rev][account_id=$this_r_account_id]/entry_amount)"/></td>
			</tr>
			</xsl:for-each>
			<tr>
				<td class="matrix-data" style="text-indent: 16px;">
                    <b><xsl:value-of select="/_R_/i18n/label[key='totalrevenue']/value"/></b>
                </td>
				
				 <xsl:call-template name="revenue_cell_total">
					  <xsl:with-param name="mn" select="$from_month"/>
					  <xsl:with-param name="repeat" select="$monthnum"/>
					  <xsl:with-param name="rev" select="$rev"/>
				 </xsl:call-template>
				<td class="matrix-data"><xsl:value-of select="format-number(sum(/_R_/get_all_entry_amounts/get_all_entry_amounts[account_type_id=$rev]/entry_amount),'#######')"/></td>
			</tr>
			<tr>
				<td class="matrix-data" colspan="{number($to_month - $from_month + 3)}">
				&#160;
                </td>
			</tr>
			<!--  Expenses -->
			<tr>
				<td class="matrix-data"><xsl:value-of select="/_R_/i18n/label[key='expenses']/value"/></td>
				 <xsl:call-template name="empty_cell">
					  <xsl:with-param name="repeat" select="$monthnum+1"/>
				 </xsl:call-template>
			</tr>
			<xsl:variable name="exp">50000</xsl:variable>
			<xsl:for-each select="/_R_/get_all_accounts/get_all_accounts[account_type_id=$exp]">
			<xsl:variable name="this_ex_account_id"><xsl:value-of select="id"/></xsl:variable>
			<tr class="row{position() mod 2}">
				<td class="matrix-data" style="text-indent: 16px;">
                    <a href="{/_R_/runtime/link_prefix}ledger&amp;account_id={id}">
                        <xsl:value-of select="name"/>
                    </a>
                </td>

				 <xsl:call-template name="expense_cell">
					  <xsl:with-param name="mn" select="$from_month"/>
					  <xsl:with-param name="repeat" select="$monthnum"/>
					  <xsl:with-param name="this_ex_account_id" select="$this_ex_account_id"/>
					  <xsl:with-param name="exp" select="$exp"/>
				 </xsl:call-template>
				<td class="matrix-data">
                    <xsl:value-of select="format-number(sum(/_R_/get_all_entry_amounts/get_all_entry_amounts[account_type_id=$exp][account_id=$this_ex_account_id]
				/entry_amount),'#####')"/></td>
			</tr>
			</xsl:for-each>
            
			<tr>
				<td class="matrix-data" style="text-indent: 16px;">
                    <b><xsl:value-of select="/_R_/i18n/label[key='total_expenses']/value"/></b>
                </td>
				 <xsl:call-template name="expense_cell_total">
					  <xsl:with-param name="mn" select="$from_month"/>
					  <xsl:with-param name="repeat" select="$monthnum"/>
					  <xsl:with-param name="exp" select="$exp"/>
				 </xsl:call-template>
				<td class="matrix-data"><xsl:value-of select="format-number(sum(/_R_/get_all_entry_amounts/get_all_entry_amounts[account_type_id=$exp]/entry_amount),'#######')"/></td>
			</tr>
			
			<tr>
				<td class="matrix-data" colspan="{number($to_month - $from_month + 3)}">
				&#160;
                </td>
			</tr>

			<!-- NET PROFIT -->
			<tr>
				<td class="matrix-data"><xsl:value-of select="/_R_/i18n/label[key='net_profit']/value"/></td>
				 <xsl:call-template name="net_profit">
					  <xsl:with-param name="mn" select="$from_month"/>
					  <xsl:with-param name="repeat" select="$monthnum"/>
					  <xsl:with-param name="exp" select="$exp"/>
					  <xsl:with-param name="rev" select="$rev"/>
				 </xsl:call-template>
				<td class="matrix-data">$<b><xsl:value-of select="format-number(sum(/_R_/get_all_entry_amounts/get_all_entry_amounts[account_type_id=$rev]/entry_amount)-sum
				(/_R_/get_all_entry_amounts/get_all_entry_amounts[account_type_id=$exp]/entry_amount),'#######')"/></b></td>
			</tr>
		</table>
		</td>
	</tr>
</table>
</xsl:template>

<xsl:template name="empty_cell">
<xsl:param name="repeat">0</xsl:param>
 <xsl:if test="number($repeat) >= 1">
	<td class="matrix-data"></td>
  <xsl:call-template name="empty_cell">
   <xsl:with-param name="repeat" select="$repeat - 1"/>
  </xsl:call-template>
 </xsl:if>
</xsl:template>

<!-- REVENUES -->
<xsl:template name="revenue_cell">
	<xsl:param name="repeat">0</xsl:param>
	<xsl:param name="rev">0</xsl:param>
	<xsl:param name="this_r_account_id">0</xsl:param>
	<xsl:param name="mn">0</xsl:param>
	<xsl:if test="number($repeat)>=1">
		<td class="matrix-data">
        <a href="{/_R_/runtime/link_prefix}ledger&amp;account_id={$this_r_account_id}&amp;from_date=2007-{$mn}-01&amp;to_date=2007-{$mn}-31">
<xsl:value-of select="format-number(sum(/_R_/get_all_entry_amounts/get_all_entry_amounts[account_type_id=$rev][account_id=$this_r_account_id][entry_month=$mn]/entry_amount),'#######')"/>
        </a>
		</td>
		<xsl:call-template name="revenue_cell">
			<xsl:with-param name="repeat" select="$repeat - 1"/>
			  <xsl:with-param name="this_r_account_id" select="$this_r_account_id"/>
			  <xsl:with-param name="rev" select="$rev"/>
			  <xsl:with-param name="mn" select="$mn + 1"/>
		</xsl:call-template>
	</xsl:if>
</xsl:template>
<xsl:template name="revenue_cell_total">
	<xsl:param name="repeat">0</xsl:param>
	<xsl:param name="rev">0</xsl:param>
	<xsl:param name="this_r_account_id">0</xsl:param>
	<xsl:param name="mn">0</xsl:param>
	<xsl:if test="number($repeat)>=1">
		<td class="matrix-data">
	<xsl:value-of select="format-number(sum(/_R_/get_all_entry_amounts/get_all_entry_amounts[account_type_id=$rev][entry_month=$mn]/entry_amount),'######')"/>
		</td>
		<xsl:call-template name="revenue_cell_total">
			<xsl:with-param name="repeat" select="$repeat - 1"/>
			  <xsl:with-param name="rev" select="$rev"/>
			  <xsl:with-param name="mn" select="$mn + 1"/>
		</xsl:call-template>
	</xsl:if>
</xsl:template>



<!-- EXPENSES -->
<xsl:template name="expense_cell">
	<xsl:param name="repeat">0</xsl:param>
	<xsl:param name="exp">0</xsl:param>
	<xsl:param name="this_ex_account_id">0</xsl:param>
	<xsl:param name="mn">0</xsl:param>
	<xsl:if test="number($repeat)>=1">
		<td class="matrix-data">
        <a href="{/_R_/runtime/link_prefix}ledger&amp;account_id={$this_ex_account_id}&amp;from_date=2007-{$mn}-01&amp;to_date=2007-{$mn}-31">
		<xsl:value-of select="format-number(sum(/_R_/get_all_entry_amounts/get_all_entry_amounts[account_type_id=$exp][account_id=$this_ex_account_id][entry_month=$mn]/entry_amount),'#######')"/>
		</a>
        </td>
		<xsl:call-template name="expense_cell">
			<xsl:with-param name="repeat" select="$repeat - 1"/>
			  <xsl:with-param name="this_ex_account_id" select="$this_ex_account_id"/>
			  <xsl:with-param name="exp" select="$exp"/>
			  <xsl:with-param name="mn" select="$mn + 1"/>
		</xsl:call-template>
	</xsl:if>
</xsl:template>
<xsl:template name="expense_cell_total">
	<xsl:param name="repeat">0</xsl:param>
	<xsl:param name="exp">0</xsl:param>
	<xsl:param name="this_ex_account_id">0</xsl:param>
	<xsl:param name="mn">0</xsl:param>
	<xsl:if test="number($repeat)>=1">
		<td class="matrix-data">
		<xsl:value-of select="format-number(sum(/_R_/get_all_entry_amounts/get_all_entry_amounts[account_type_id=$exp][entry_month=$mn]/entry_amount),'#######')"/>
		</td>
		<xsl:call-template name="expense_cell_total">
			<xsl:with-param name="repeat" select="$repeat - 1"/>
			  <xsl:with-param name="exp" select="$exp"/>
			  <xsl:with-param name="mn" select="$mn + 1"/>
		</xsl:call-template>
	</xsl:if>
</xsl:template>

<!-- NET PROFIT -->
<xsl:template name="net_profit">
	<xsl:param name="repeat">0</xsl:param>
	<xsl:param name="rev">0</xsl:param>
	<xsl:param name="exp">0</xsl:param>
	<xsl:param name="this_ex_account_id">0</xsl:param>
	<xsl:param name="mn">0</xsl:param>
	<xsl:if test="number($repeat)>=1">
		<td class="matrix-data">
<xsl:value-of select="format-number(sum(/_R_/get_all_entry_amounts/get_all_entry_amounts[account_type_id=$rev][entry_month=$mn]/entry_amount)
	- sum(/_R_/get_all_entry_amounts/get_all_entry_amounts[account_type_id=$exp][entry_month=$mn]/entry_amount),'#######')"/>
		</td>
		<xsl:call-template name="net_profit">
			<xsl:with-param name="repeat" select="$repeat - 1"/>
			  <xsl:with-param name="exp" select="$exp"/>
			  <xsl:with-param name="rev" select="$rev"/>
			  <xsl:with-param name="mn" select="$mn + 1"/>
		</xsl:call-template>
	</xsl:if>
</xsl:template>
</xsl:stylesheet>