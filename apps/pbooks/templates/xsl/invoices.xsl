<!--
Program: PBooks
Component: invoices.xsl
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
    <xsl:param name="link_prefix"/>
    <xsl:param name="path_prefix"/>
    <xsl:param name="i18n"/>
    <xsl:call-template name="jquery-setup">
      <xsl:with-param name="my-table">myInvoices</xsl:with-param>
      <xsl:with-param name="my-table-div">myInvoicesDiv</xsl:with-param>
      <xsl:with-param name="no-sort-column">, headers: { 6: {sorter: false} }</xsl:with-param>
    </xsl:call-template>

		<!-- INVOICE PAID -->
    <script type="text/javascript">
    function invoice_paid(invoice_number, entry_id) {
        $.post("<xsl:value-of select="$link_prefix"/>x--invoice-paid",
        {
          'invoice_number': invoice_number,
					'entry_id': entry_id
        },
        function (data){
          document.getElementById(invoice_number).innerHTML="Paid";
        });
        //document.getElementById(invoice_id).innerHTML="";
    }
    </script>

    <div class="generic-button" style="float: right;">
      <a href="{$link_prefix}invoice-create" id="invoice-create">
        <img src="{$path_prefix}{/_R_/runtime/icon_set}/page_edit.gif"/>
        <xsl:value-of select="$i18n/new_invoice"/>
      </a>
    </div>

    <strong>
      <xsl:value-of select="$i18n/recent_invoices"/>:</strong>
    <div id="myInvoicesDiv" style="min-height: 400px">
      <script type="text/javascript">
        document.getElementById('myInvoicesDiv').style.visibility = 'hidden';
      </script>

      <table class="tablesorter" id="myInvoices">
        <thead>
          <tr>
            <th>
              <xsl:value-of select="$i18n/date"/>
            </th>
            <th>
              <xsl:value-of select="$i18n/id"/>
            </th>
            <th>
              <xsl:value-of select="$i18n/client"/>
            </th>
            <th>
              <xsl:value-of select="$i18n/memo"/>
            </th>
            <th>
              <xsl:value-of select="$i18n/amount"/>
            </th>
        <!--
        <th><xsl:value-of select="$i18n/due_date"/></th>
        -->
            <th>
              <xsl:value-of select="$i18n/paid"/>&#160;
            <!--<sup>[<a onclick="alert('')">?</a>]</sup>-->
            </th>
            <th>
              <xsl:value-of select="$i18n/print"/>
            </th>
          </tr>
        </thead>
        <tbody>
          <!-- LOOP -->
          <xsl:for-each select="/_R_/get_some_business_objects/get_some_business_objects">
            <xsl:variable name="my_entry_id">
              <xsl:value-of select="entry_id"/>
            </xsl:variable>
            <xsl:variable name="my_customer_id">
              <xsl:value-of select="customer_id"/>
            </xsl:variable>
            <tr onmouseover="oldClass=this.className; this.className='active'"
              onmouseout="this.className=oldClass">
              <td>
                <xsl:value-of select="entry_datetime"/>
              </td>
              <td id="{$my_entry_id}">
                <a href="{$link_prefix}invoice-edit&amp;entry_id={entry_id}&amp;invoice_id={$my_entry_id}">
                  <xsl:value-of select="invoice_number"/>
                </a>
              </td>
              <td>
                <a href="#">
                  <xsl:value-of select="substring(/_R_/get_all_accounts/get_all_accounts[id=$my_customer_id]/name,0,24)"/>
                </a>
              </td>
              <td>
                <a href="{$link_prefix}invoice-edit&amp;entry_id={entry_id}&amp;invoice_id={$my_entry_id}">
                  <xsl:value-of select="substring(memorandum,0,12)"/>
                </a>
              </td>
              <td>
                <xsl:value-of select="invoice_total"/>
              </td>
              <!--
              <td><xsl:value-of select="due_date"/></td>
              -->
              <!-- TODO - Use AJAX to quickly convert paid status - triggering db update and entries -->
              <td id="{invoice_number}">
                <xsl:if test="paid_status='paid_in_full'">
                  Paid
                </xsl:if>
                <xsl:if test="not(paid_status='paid_in_full')">
                <a onclick="invoice_paid({invoice_number},{entry_id}); return false;"
								href="{$link_prefix}invoice-paid&amp;invoice_number={invoice_number}&amp;entry_id={$my_entry_id}">
								  Unpaid
                </a>
                </xsl:if>
              </td>
              <td>
                <a href="{$link_prefix}invoice-print&amp;entry_id={$my_entry_id}&amp;invoice_id={$my_entry_id}&amp;account_id={$my_customer_id}&amp;print=true">
                  <xsl:value-of select="$i18n/print"/>
                </a>
              </td>
            </tr>
          </xsl:for-each>
          <!-- END LOOP -->
        </tbody>
      </table>
    </div>
    <xsl:call-template name="pager">
      <xsl:with-param name="my-table">myInvoices</xsl:with-param>
    </xsl:call-template>
  </xsl:template>
</xsl:stylesheet>