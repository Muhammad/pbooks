<!--
Program: PBooks
Component: report_simple_cash_flow.xsl
Copyright 2003-2007, Albert L. Lash, IV
Savonix Corporation
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
<xsl:include href="pager.xsl"/>
<xsl:template name="content">
<xsl:call-template name="jquery-setup">
    <xsl:with-param name="my-table">myLedger</xsl:with-param>
</xsl:call-template>

<!-- Net change -->
<div class="generic-button" style="float: right;">
<xsl:value-of select="/__ROOT__/i18n/labels/label[key='net_change']/value"/>: <xsl:value-of select="format-number(sum(__ROOT__/get_all_transactions/entry_amount),'#########.##')"/>
</div>




<form method="get">
<table>

    <tr>
	<td><xsl:if test="/__ROOT__/_get/month >= 1"><a><xsl:attribute name="href"><xsl:value-of select="//link_prefix"/>reports-simple-cash-flow&amp;month=<xsl:if test="//_get/month &lt;= 10">0</xsl:if><xsl:value-of select="/__ROOT__/_get/month - 1"/></xsl:attribute>
	<img src="{//path_prefix}/images/buttons/out.gif"/></a></xsl:if>
    <xsl:if test="not(/__ROOT__/_get/month >= 1)"><img src="{//path_prefix}/images/buttons/out_d.gif"/></xsl:if></td>

        <td><xsl:value-of select="//label[key='month']/value"/>:</td>
        <td>
        <select name="month"  onchange="this.form.submit();">
            <option value="%">All</option>
            <xsl:for-each select="//months/option">
            <option value="{@id}"><xsl:if test="@id=/__ROOT__/_get/month"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if>
			<xsl:value-of select="@fullname"/></option>
            </xsl:for-each>
			</select></td>
	<td>
    <xsl:if test="/__ROOT__/_get/month &gt;= 12"><img src="{//path_prefix}/images/buttons/in_d.gif"/></xsl:if>
	<xsl:if test="not(//_get/month)"><a href="{//link_prefix}reports-simple-cash-flow&amp;month=01">
	<img src="{//path_prefix}/images/buttons/in.gif"/></a></xsl:if>
	<xsl:if test="(/__ROOT__/_get/month &lt; 12)"><a><xsl:attribute name="href"><xsl:value-of select="//link_prefix"/>reports-simple-cash-flow&amp;month=<xsl:if test="//_get/month &lt; 9">0</xsl:if>
	<xsl:value-of select="/__ROOT__/_get/month + 1"/></xsl:attribute>
	<img src="{//path_prefix}/images/buttons/in.gif"/></a></xsl:if>
	</td>
	

    </tr>
</table>

 <table id="myLedger" class="tablesorter">
        <thead>	
        <tr>
		 <input type="hidden" name="nid" value="{__ROOT__/_get/nid}"/>
			<th><xsl:value-of select="__ROOT__/i18n/labels/label[key='post']/value"/></th>
			<th><xsl:value-of select="__ROOT__/i18n/labels/label[key='date']/value"/>:</th>
			<th>Memo.</th>
            <th>Account</th>
                
            <th><xsl:value-of select="__ROOT__/i18n/labels/label[key='amount']/value"/></th>
            
            <xsl:if test="(not(__ROOT__/_get/account_id='%') and __ROOT__/_get/account_id)"><th>Balance</th></xsl:if>
        </tr>
        </thead>
        
    <xsl:variable name="my_link_prefix"><xsl:value-of select="__ROOT__/runtime/link_prefix"/></xsl:variable>
    
    <!-- General ledger -->
    <tbody>
    <xsl:for-each select="__ROOT__/get_all_transactions">
    <tr onmouseover="oldClass=this.className; this.className='active'" onmouseout="this.className=oldClass">
            <td>
            <xsl:choose>
                <xsl:when test="not(entry_id='0')">
                    <a href="{$my_link_prefix}journal-entry&amp;entry_id={entry_id}"><xsl:value-of select="entry_id"/></a>
                </xsl:when>
                <xsl:otherwise>
                    <a href="{$my_link_prefix}ledger-delete&amp;transaction_id={transaction_id}"  onclick="return confirm('Are you sure you want to delete this ledger 
        transaction?')"><img src="{//path_prefix}{//icon_set}delete.png" alt="x" border="0"/></a>
                    &#160;
                    <!-- create new matching entry -->
                    <a href="{$my_link_prefix}journal-new-from-transaction&amp;transaction_id={transaction_id}"><xsl:if test="/__ROOT__/show_tool_tips='yes'">
        <xsl:attribute name="title"><xsl:value-of select="/__ROOT__/tool_tips[@lang=/__ROOT__/selected_lang]/tip[key='create_entry']/value" />
        </xsl:attribute></xsl:if><img src="{//path_prefix}{//icon_set}add.png" alt="+" border="0"/></a>
                </xsl:otherwise>
            </xsl:choose>
            </td>
            
            <td><a href="{$my_link_prefix}journal&amp;from_date={entry_datetime}"><xsl:value-of select="entry_datetime"/></a></td>
            
            <td><xsl:value-of select="memorandum[not(.='NULL')]"/></td>
            
             <td><a href="{$my_link_prefix}ledger&amp;account_id={account_id}"><xsl:value-of select="name"/></a></td>
             
             <td><xsl:value-of select="entry_amount"/></td>
    </tr>
    </xsl:for-each>
    </tbody>
    

        

</table>
<xsl:call-template name="pager"/>
<br/>


</form>
</xsl:template>
</xsl:stylesheet>