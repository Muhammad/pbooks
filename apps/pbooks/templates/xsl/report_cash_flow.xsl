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
or write to the Free Software Foundation, Inc., 51 Franklin Street,
Fifth Floor, Boston, MA 02110-1301 USA
-->
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns="http://www.w3.org/1999/xhtml">
  <xsl:include href="html_main.xsl"/>
  <xsl:template name="content">
    <xsl:param name="link_prefix"/>
    <xsl:param name="path_prefix"/>
    <xsl:param name="i18n"/>

		<!-- Just setting up some frequently used xpaths -->
    <xsl:variable name="from_month" select="substring(/_R_/_get/from_date,6,2)"/>
    <xsl:variable name="to_month"   select="substring(/_R_/_get/to_date,6,2)"/>
    <xsl:variable name="monthnum"   select="number($to_month - $from_month + 1)"/>


<div style="text-align: center;">
	<h2>
		<xsl:value-of select="//runtime/company_name"/>
	</h2>
	<xsl:value-of select="$i18n/cash_flow_statement"/>
	<xsl:value-of select="$i18n/from"/>
	<xsl:value-of select="/_R_/runtime/from_date"/>
	<xsl:value-of select="$i18n/through"/>
	<xsl:value-of select="/_R_/runtime/to_date"/>

</div>





<!--
This is the table structure only, the table cells are the templates at the
bottom of the file.
-->
<table width="100%" class="matrix-table">
	<tr>
		<td class="matrix-data" />
		<xsl:for-each select="//months/option">
			<xsl:if test="@id &gt;= $from_month and @id &lt;= $to_month">
				<td class="matrix-data">
					<xsl:value-of select="@shortname"/>
				</td>
			</xsl:if>
		</xsl:for-each>
	</tr>

	<!--  Cash Flow -->
	<tr>
		<td class="matrix-data">
			<xsl:value-of select="$i18n/incoming_cash_flow_deposit"/>
		</td>
		<xsl:call-template name="empty_cell">
			<xsl:with-param name="repeat" select="$monthnum"/>
			<xsl:with-param name="link_prefix" select="$link_prefix"/>
		</xsl:call-template>
	</tr>
	<tr>
		<td class="matrix-data" style="padding-left: 6px;">
			<xsl:value-of select="$i18n/beginning_balance"/>
		</td>
		<xsl:call-template name="empty_cell">
			<xsl:with-param name="repeat" select="$monthnum"/>
			<xsl:with-param name="link_prefix" select="$link_prefix"/>
		</xsl:call-template>
	</tr>
	<!-- Income / Deposits -->
	<xsl:for-each select="/_R_/get_all_accounts/get_all_accounts[account_type_id=10000][cash_account='on']">
		<xsl:variable name="this_i_account_id" select="id"/>
		<xsl:variable name="account_reconciled" select="reconciled"/>
		<tr class="row{position() mod 2}">
			<td class="matrix-data" style="text-indent: 6px;">
				<a href="{$link_prefix}ledger&amp;account_id={id}">
					<xsl:value-of select="substring(name,0,25)"/>
				</a>
			</td>
			<xsl:call-template name="income_cell">
				<xsl:with-param name="mn" select="$from_month"/>
				<xsl:with-param name="repeat" select="$monthnum"/>
				<xsl:with-param name="this_i_account_id" select="$this_i_account_id"/>
				<xsl:with-param name="reconciled" select="$account_reconciled"/>
				<xsl:with-param name="link_prefix" select="$link_prefix"/>
			</xsl:call-template>
		</tr>
	</xsl:for-each>
	<tr class="row{position() mod 2}">
		<td class="matrix-data">
			<xsl:value-of select="$i18n/total_cash_inflow"/>
		</td>
		<xsl:call-template name="income_total_cell">
			<xsl:with-param name="mn" select="$from_month"/>
			<xsl:with-param name="repeat" select="$monthnum"/>
			<xsl:with-param name="link_prefix" select="$link_prefix"/>
		</xsl:call-template>
	</tr>
	<tr>
		<td class="matrix-data" colspan="{number($to_month - $from_month + 3)}" />
	</tr>
<!--  Disbursements -->
	<tr>
		<td class="matrix-data">
			<xsl:value-of select="$i18n/disbursements"/>
		</td>
		<xsl:call-template name="empty_cell">
			<xsl:with-param name="repeat" select="$monthnum"/>
			<xsl:with-param name="link_prefix" select="$link_prefix"/>
		</xsl:call-template>
	</tr>
<!-- Disb by account -->
	<xsl:for-each select="/_R_/get_all_accounts/get_all_accounts[account_type_id=10000][cash_account='on']">
		<xsl:variable name="this_d_account_id" select="id"/>
		<tr class="row{position() mod 2}">
			<td class="matrix-data" style="text-indent: 6px;">
				<a href="{$link_prefix}ledger&amp;account_id={id}">
					<xsl:value-of select="substring(name,0,25)"/>
				</a>
			</td>
			<xsl:call-template name="outgoing_cell">
				<xsl:with-param name="mn" select="$from_month"/>
				<xsl:with-param name="repeat" select="$monthnum"/>
				<xsl:with-param name="this_d_account_id" select="$this_d_account_id"/>
				<xsl:with-param name="link_prefix" select="$link_prefix"/>
			</xsl:call-template>
		</tr>
	</xsl:for-each>
<!-- Total disbursements -->
	<tr class="row{position() mod 2}">
		<td class="matrix-data">
			<xsl:value-of select="$i18n/total_cash_outflow"/>
		</td>
		<xsl:call-template name="outgoing_total_cell">
			<xsl:with-param name="mn" select="$from_month"/>
			<xsl:with-param name="repeat" select="$monthnum"/>
			<xsl:with-param name="link_prefix" select="$link_prefix"/>
		</xsl:call-template>
	</tr>
	<tr>
		<td class="matrix-data" colspan="{number($to_month - $from_month + 3)}" />
	</tr>
	<!-- Capital Investments -->
	<tr>
		<td class="matrix-data">
			<xsl:value-of select="$i18n/capital_investments"/>
		</td>
		<xsl:call-template name="empty_cell">
			<xsl:with-param name="repeat" select="$monthnum"/>
			<xsl:with-param name="link_prefix" select="$link_prefix"/>
		</xsl:call-template>
	</tr>

	<tr>
		<td class="matrix-data" colspan="{number($to_month - $from_month + 3)}">&#160;</td>
	</tr>
	<!-- Cash Flow -->
	<tr>
		<td class="matrix-data">
			<xsl:value-of select="$i18n/cash_flow"/>
		</td>
		<xsl:call-template name="total_cell">
			<xsl:with-param name="mn" select="$from_month"/>
			<xsl:with-param name="repeat" select="$monthnum"/>
			<xsl:with-param name="link_prefix" select="$link_prefix"/>
		</xsl:call-template>
	</tr>
</table>


  </xsl:template>
<!-- These are the individual cells -->
  <xsl:template name="empty_cell">
    <xsl:param name="link_prefix"/>
    <xsl:param name="repeat">0</xsl:param>
    <xsl:if test="number($repeat) >= 1">
      <td class="matrix-data"></td>
      <xsl:call-template name="empty_cell">
        <xsl:with-param name="repeat" select="$repeat - 1"/>
      </xsl:call-template>
    </xsl:if>
  </xsl:template>

  <xsl:template name="income_cell">
    <xsl:param name="reconciled"/>
    <xsl:param name="link_prefix"/>
    <xsl:param name="repeat">0</xsl:param>
    <xsl:param name="mn">0</xsl:param>
    <xsl:param name="this_i_account_id">0</xsl:param>
    <xsl:if test="number($repeat)>=1">
      <td class="matrix-data">
				<xsl:if test="
					substring(//from_date,1,4) &lt;= substring($reconciled,1,4) and
					$mn &lt;= substring($reconciled,6,2)">
					<xsl:attribute name="class">
						matrix-data reconciled
					</xsl:attribute>
				</xsl:if>
				<xsl:if test="debug='true'">
					<span style="color:yellow;"><xsl:value-of select="substring(//from_date,1,4)"/>-<xsl:value-of select="substring($reconciled,1,4)"/>-31</span>
				</xsl:if>
        <a href="{$link_prefix}ledger&amp;from_date={substring(//from_date,1,4)}-{$mn}-01&amp;to_date={substring(//from_date,1,4)}-{$mn}-31&amp;account_id={$this_i_account_id}">
          <xsl:value-of select=" sum( //get_all_transactions/get_all_transactions[entry_month=$mn][entry_amount &gt; 0][account_id=$this_i_account_id]/entry_amount ) "/>
        </a>
      </td>
      <xsl:call-template name="income_cell">
        <xsl:with-param name="reconciled" select="$reconciled"/>
        <xsl:with-param name="repeat" select="$repeat - 1"/>
        <xsl:with-param name="mn" select="$mn + 1"/>
        <xsl:with-param name="this_i_account_id" select="$this_i_account_id"/>
      </xsl:call-template>
    </xsl:if>
  </xsl:template>
  <xsl:template name="income_total_cell">
    <xsl:param name="link_prefix"/>
    <xsl:param name="repeat">0</xsl:param>
    <xsl:param name="mn">0</xsl:param>
    <xsl:if test="number($repeat)>=1">
      <td class="matrix-data">
        <xsl:value-of select=" sum( //get_all_transactions/get_all_transactions[entry_amount &gt; 0][entry_month=$mn]/entry_amount )"/>
      </td>
      <xsl:call-template name="income_total_cell">
        <xsl:with-param name="repeat" select="$repeat - 1"/>
        <xsl:with-param name="mn" select="$mn + 1"/>
      </xsl:call-template>
    </xsl:if>
  </xsl:template>





<!-- DISBURSEMENTS -->
  <xsl:template name="outgoing_cell">
    <xsl:param name="link_prefix"/>
    <xsl:param name="repeat">0</xsl:param>
    <xsl:param name="this_d_account_id">0</xsl:param>
    <xsl:param name="mn">0</xsl:param>
    <xsl:if test="number($repeat)>=1">
      <td class="matrix-data">
        <a href="{$link_prefix}ledger&amp;from_date={substring(//from_date,1,4)}-{$mn}-01&amp;to_date={substring(//from_date,1,4)}-{$mn}-31&amp;account_id={$this_d_account_id}">
          <xsl:value-of select=" format-number( sum( //get_all_transactions/get_all_transactions[entry_month=$mn][entry_amount &lt; 0][account_id=$this_d_account_id]/entry_amount ), '######') "/>
        </a>
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
    <xsl:param name="link_prefix"/>
    <xsl:param name="repeat">0</xsl:param>
    <xsl:param name="mn">0</xsl:param>
    <xsl:if test="number($repeat)>=1">
      <td class="matrix-data">
        <xsl:value-of select=" format-number( sum( //get_all_transactions/get_all_transactions[entry_month=$mn][entry_amount &lt; 0]/entry_amount), '######' ) "/>
      </td>
      <xsl:call-template name="outgoing_total_cell">
        <xsl:with-param name="repeat" select="$repeat - 1"/>
        <xsl:with-param name="mn" select="$mn + 1"/>
      </xsl:call-template>
    </xsl:if>
  </xsl:template>



	<!-- TOTAL -->
  <xsl:template name="total_cell">
    <xsl:param name="link_prefix"/>
    <xsl:param name="repeat">0</xsl:param>
    <xsl:param name="disb">0</xsl:param>
    <xsl:param name="rev">0</xsl:param>
    <xsl:param name="mn">0</xsl:param>
    <xsl:if test="number($repeat)>=1">
      <td class="matrix-data">
        <xsl:value-of select="sum(//get_all_transactions/get_all_transactions[entry_month=$mn]/entry_amount)"/>
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