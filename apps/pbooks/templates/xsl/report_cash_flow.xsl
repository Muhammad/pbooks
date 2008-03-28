<!--
Program: PBooks
Component: report_cash_flow.xsl
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

<!-- Just setting up some frequently used xpaths -->

<xsl:variable name="from_month">
    <xsl:value-of select="substring(/__ROOT__/_get/from_date,6,2)"/>
</xsl:variable>
<xsl:variable name="to_month">
    <xsl:value-of select="substring(/__ROOT__/_get/to_date,6,2)"/>
</xsl:variable>
<xsl:variable name="monthnum">
    <xsl:value-of select="number($to_month - $from_month + 1)"/>
</xsl:variable>

<div style="text-align: center;">
    <h2><xsl:value-of select="//company_name"/></h2>
</div>




<table class="data-table" width="740" align="center">
	<tr>
		<td align="center"><xsl:value-of select="__ROOT__/i18n/labels/label[key='cash_flow_statement']/value"/> <xsl:value-of select="__ROOT__/i18n/labels/label
		[key='from']/value"/> 
			<xsl:value-of select="//from_date"/> <xsl:value-of select="__ROOT__/i18n/labels/label[key='through']/value"/> <xsl:value-of select="//to_date"/></td>
	</tr>
	<tr>
		<td>
        <!-- This is the table structure only, the table cells are 
            the templates at the bottom of the file -->
		<table width="100%" class="matrix-table" cellspacing="1" cellpadding="2" border="0" bgcolor="gray">
			<tr bgcolor="white">
				<td class="matrix-data"> </td>
				<xsl:for-each select="//months/option">
					<xsl:if test="@id &gt;= $from_month and @id &lt;= $to_month">
						<td class="matrix-data"><xsl:value-of select="@shortname"/></td>
					</xsl:if>
				</xsl:for-each>
			</tr>

			<!--  Cash Flow -->
			<tr bgcolor="white">
				<td class="matrix-data"><xsl:value-of select="__ROOT__/i18n/labels/label[key='incoming_cash_flow_deposit']/value"/></td>				 
                <xsl:call-template name="empty_cell">
					  <xsl:with-param name="repeat" select="$monthnum"/>
				 </xsl:call-template>

	
			</tr>
            <tr bgcolor="white">
                <td class="matrix-data" style="padding-left: 20px;"><xsl:value-of select="__ROOT__/i18n/labels/label[key='beginning_balance']/value"/></td>				 
                <xsl:call-template name="empty_cell">
					  <xsl:with-param name="repeat" select="$monthnum"/>
				 </xsl:call-template>
            </tr>
            <!-- Income / Deposits -->
			<xsl:for-each select="//get_all_accounts[account_type_id=10000]">
			<xsl:variable name="this_i_account_id"><xsl:value-of select="id"/></xsl:variable>
                <tr class="row{position() mod 2}">
                <td class="matrix-data" style="padding-left: 20px;"><xsl:value-of select="name"/></td>
                     <xsl:call-template name="income_cell">
                          <xsl:with-param name="mn" select="$from_month"/>
                          <xsl:with-param name="repeat" select="$monthnum"/>
                          <xsl:with-param name="this_i_account_id" select="$this_i_account_id"/>
                     </xsl:call-template>
                </tr>
            </xsl:for-each>
			<tr class="row{position() mod 2}">
				<td class="matrix-data"><xsl:value-of select="/__ROOT__/i18n/labels/label[key='total_cash_inflow']/value"/></td>
				 <xsl:call-template name="income_total_cell">
					  <xsl:with-param name="mn" select="$from_month"/>
					  <xsl:with-param name="repeat" select="$monthnum"/>
				 </xsl:call-template>
			</tr>
			<tr bgcolor="white">
				<td class="matrix-data"><xsl:attribute name="colspan"><xsl:value-of select="number($to_month - $from_month + 3)"/></xsl:attribute>&#160;</td>
			</tr>
			<!--  Disbursements -->
			<tr bgcolor="white">
				<td class="matrix-data"><xsl:value-of select="__ROOT__/i18n/labels/label[key='disbursements']/value"/></td>
				 <xsl:call-template name="empty_cell">
					  <xsl:with-param name="repeat" select="$monthnum"/>
				 </xsl:call-template>
			</tr>
            <!-- Disb by account -->
			<xsl:for-each select="//get_all_accounts[account_type_id=10000]">
			<xsl:variable name="this_d_account_id"><xsl:value-of select="id"/></xsl:variable>
                <tr class="row{position() mod 2}">
                <td class="matrix-data" style="padding-left: 20px;"><xsl:value-of select="name"/></td>
                     <xsl:call-template name="outgoing_cell">
                          <xsl:with-param name="mn" select="$from_month"/>
                          <xsl:with-param name="repeat" select="$monthnum"/>
                          <xsl:with-param name="this_d_account_id" select="$this_d_account_id"/>
                     </xsl:call-template>
                </tr>
            </xsl:for-each>
            <!-- Total disbursements -->
			<tr class="row{position() mod 2}">
				<td class="matrix-data"><xsl:value-of select="__ROOT__/i18n/labels/label[key='total_cash_outflow']/value"/></td>
				 <xsl:call-template name="outgoing_total_cell">
					  <xsl:with-param name="mn" select="$from_month"/>
					  <xsl:with-param name="repeat" select="$monthnum"/>
				 </xsl:call-template>
            </tr>
			<tr bgcolor="white">
				<td class="matrix-data"><xsl:attribute name="colspan"><xsl:value-of select="number($to_month - $from_month + 3)"/></xsl:attribute>&#160;</td>
			</tr>
			<!-- Capital Investments -->
			<tr bgcolor="white">
				<td class="matrix-data"><xsl:value-of select="__ROOT__/i18n/labels/label[key='capital_investments']/value"/></td>
				 <xsl:call-template name="empty_cell">
					  <xsl:with-param name="repeat" select="$monthnum"/>
				 </xsl:call-template>
			</tr>

			<tr bgcolor="white">
				<td class="matrix-data"><xsl:attribute name="colspan"><xsl:value-of select="number($to_month - $from_month + 3)"/></xsl:attribute>&#160;</td>
			</tr>
			<!-- Cash Flow -->
			<tr bgcolor="white">
				<td class="matrix-data"><xsl:value-of select="__ROOT__/i18n/labels/label[key='cash_flow']/value"/></td>
				 <xsl:call-template name="total_cell">
					  <xsl:with-param name="mn" select="$from_month"/>
					  <xsl:with-param name="repeat" select="$monthnum"/>
				 </xsl:call-template>
			</tr>
		</table>
		</td>
	</tr>
</table>
</xsl:template>
<!-- These are the individual cells -->
<xsl:template name="empty_cell">
<xsl:param name="repeat">0</xsl:param>
 <xsl:if test="number($repeat) >= 1">
	<td class="matrix-data"></td>
  <xsl:call-template name="empty_cell">
   <xsl:with-param name="repeat" select="$repeat - 1"/>
  </xsl:call-template>
 </xsl:if>
</xsl:template>

<xsl:template name="income_cell">
	<xsl:param name="repeat">0</xsl:param>
	<xsl:param name="mn">0</xsl:param>
	<xsl:param name="this_i_account_id">0</xsl:param>
	<xsl:if test="number($repeat)>=1">
		<td class="matrix-data">
        <a href="{//link_prefix}ledger&amp;from_date={substring(//from_date,1,4)}-{$mn}-01&amp;to_date={substring(//from_date,1,4)}-{$mn}-31&amp;account_id={$this_i_account_id}">
		<xsl:value-of select="sum(//get_all_transactions[entry_month=$mn][entry_amount &gt; 0][account_id=$this_i_account_id]/entry_amount)"/>
		</a>
		</td>
		<xsl:call-template name="income_cell">
			<xsl:with-param name="repeat" select="$repeat - 1"/>
			  <xsl:with-param name="mn" select="$mn + 1"/>
              <xsl:with-param name="this_i_account_id" select="$this_i_account_id"/>
		</xsl:call-template>
	</xsl:if>
</xsl:template>
<xsl:template name="income_total_cell">
	<xsl:param name="repeat">0</xsl:param>
	<xsl:param name="mn">0</xsl:param>
	<xsl:if test="number($repeat)>=1">
		<td class="matrix-data">
        <xsl:value-of select="sum(//get_all_transactions[entry_amount &gt; 0][entry_month=$mn]/entry_amount)"/>
		</td>
		<xsl:call-template name="income_total_cell">
			<xsl:with-param name="repeat" select="$repeat - 1"/>
			  <xsl:with-param name="mn" select="$mn + 1"/>
		</xsl:call-template>
	</xsl:if>
</xsl:template>





<!-- DISBURSEMENTS -->
<xsl:template name="outgoing_cell">
	<xsl:param name="repeat">0</xsl:param>
	<xsl:param name="this_d_account_id">0</xsl:param>
    <xsl:param name="mn">0</xsl:param>
	<xsl:if test="number($repeat)>=1">    
		<td class="matrix-data">
		 <a href="{//link_prefix}ledger&amp;from_date={substring(//from_date,1,4)}-{$mn}-01&amp;to_date={substring(//from_date,1,4)}-{$mn}-31&amp;account_id={$this_d_account_id}">
		 <xsl:value-of select="sum(//get_all_transactions[entry_month=$mn][entry_amount &lt; 0][account_id=$this_d_account_id]/entry_amount)"/></a>
		</td>
		<xsl:call-template name="outgoing_cell">
			<xsl:with-param name="repeat" select="$repeat - 1"/>
            <xsl:with-param name="mn" select="$mn + 1"/>
            <xsl:with-param name="this_d_account_id" select="$this_d_account_id"/>
        </xsl:call-template>
	</xsl:if>
</xsl:template>
<!-- TOTAL DISBURSEMENTS -->
<xsl:template name="outgoing_total_cell">
	<xsl:param name="repeat">0</xsl:param>
    <xsl:param name="mn">0</xsl:param>
	<xsl:if test="number($repeat)>=1">    
		<td class="matrix-data">
		 <xsl:value-of select="sum(//get_all_transactions[entry_month=$mn][entry_amount &lt; 0]/entry_amount)"/>
		</td>
		<xsl:call-template name="outgoing_total_cell">
			<xsl:with-param name="repeat" select="$repeat - 1"/>
            <xsl:with-param name="mn" select="$mn + 1"/>
        </xsl:call-template>
	</xsl:if>
</xsl:template>



<!-- TOTAL -->
<xsl:template name="total_cell">
	<xsl:param name="repeat">0</xsl:param>
	<xsl:param name="disb">0</xsl:param>
	<xsl:param name="rev">0</xsl:param>
    <xsl:param name="mn">0</xsl:param>
	<xsl:if test="number($repeat)>=1">    
		<td class="matrix-data">
		<xsl:value-of select="format-number(sum(//get_all_transactions[entry_month=$mn]/entry_amount),'######')"/>
		</td>
		<xsl:call-template name="total_cell">
			<xsl:with-param name="repeat" select="$repeat - 1"/>
            <xsl:with-param name="disb" select="$disb"/>
            <xsl:with-param name="rev" select="$rev"/>
            <xsl:with-param name="mn" select="$mn + 1"/>
		</xsl:call-template>
	</xsl:if>
</xsl:template>

</xsl:stylesheet>