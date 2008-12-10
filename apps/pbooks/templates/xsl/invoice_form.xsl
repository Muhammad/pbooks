<!--
Program: PBooks
Component: invoice_form.xsl
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
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:include href="main.xsl"/>
  <xsl:include href="date_select.xsl"/>
  <xsl:template name="content">
    <xsl:param name="link_prefix"/>
    <xsl:param name="path_prefix"/>
    <xsl:param name="i18n"/>

		<!-- Add / delete items -->
    <script type="text/javascript">
    function journal_entry_amount_delete(entry_amount_id,row) {
      $.post("<xsl:value-of select="$link_prefix"/>journal-entry-amount-delete",
      {
				'entry_amount_id': entry_amount_id
      },
      function (data){
      });
      myTable = document.getElementById("invoice_form_table");
      myTable.deleteRow(row);
    }
    function journal_entry_amount_create(entry_type_id,entry_id,entry_date) {
      $.post("<xsl:value-of select="$link_prefix"/>journal-entry-new-"+entry_type_id+"&amp;entry_id="+entry_id,
      {
				'entry_id': entry_id,
				'entry_datetime': entry_date
      },
      function (data){
				setTimeout('window.location.reload()',200);
      });
		}
		function add_line_item() {
		}
		</script>

    <h2>
      <xsl:value-of select="$i18n/new_invoice"/>:
    </h2>
    <form method="post" action="{$link_prefix}invoices-submit&amp;entry_id={/_R_/_get/entry_id}">
      <input type="hidden" name="entry_id" value="{/_R_/_get/entry_id}"/>
      <table border="0" id="invoice_form_table">
        <tbody>
          <tr>
            <td>
              <xsl:value-of select="$i18n/date"/>:
						</td>
            <td colspan="8">
              <input type="text" name="entry_datetime" id="invoice_date"
								value="{//get_journal_entry/get_journal_entry/entry_datetime}"/>
            </td>
          </tr>
          <tr>
            <td>
              <xsl:value-of select="$i18n/customer"/>:
						</td>
            <td colspan="7">
              <select name="debit_account_id">
                <xsl:for-each select="/_R_/get_all_accounts/get_all_accounts[accounts_receivable_account='on']">
                  <option value="{id}">
                    <xsl:if test="id=//get_some_business_objects/customer_id">
                      <xsl:attribute name="selected">selected</xsl:attribute>
                    </xsl:if>
                    <xsl:value-of select="name"/>
                  </option>
                </xsl:for-each>
              </select>&#160;
            <a href="{$link_prefix}customer-edit&amp;print=true&amp;keepThis=true&amp;TB_iframe=true&amp;height=300&amp;width=500" title="Add New Customer" class="thickbox">
            <img src="{$path_prefix}{/_R_/runtime/icon_set}add.png" border="0"/>
              </a>
            </td>
            <td></td>
          </tr>
          <tr>
            <td>
              <xsl:value-of select="$i18n/invoice_number"/>:
						</td>
            <td colspan="8">
              <input type="text" name="invoice_number">
                <xsl:attribute name="value">
                  <xsl:if test="//get_some_business_objects/get_some_business_objects/invoice_number">
                    <xsl:value-of select="//get_some_business_objects/get_some_business_objects/invoice_number"/>
                  </xsl:if>
                  <xsl:if test="not(//get_some_business_objects/get_some_business_objects/invoice_number)">
                    <xsl:value-of select="//get_last_meta_id/meta_value + 1"/>
                  </xsl:if>
                </xsl:attribute>
              </input>
            </td>
          </tr>
          <tr>
            <td>
              <xsl:value-of select="$i18n/due_date"/>:
						</td>
            <td colspan="8">
              <input type="text" name="due_date"
								value="{//get_some_business_objects/get_some_business_objects/due_date}">
                <xsl:if test="not(//get_some_business_objects/get_some_business_objects/due_date)">
                  <xsl:attribute name="value">On Receipt</xsl:attribute>
                </xsl:if>
              </input>
            </td>
          </tr>
          <tr>
            <td>
              <xsl:value-of select="$i18n/paid_status"/>:
						</td>
            <td colspan="8">
              <input type="radio" name="paid_status" value="paid_in_full">
                <xsl:if test="//business_object_get_metadata/business_object_get_metadata/paid_status='paid_in_full'">
                  <xsl:attribute name="checked">checked</xsl:attribute>
                </xsl:if>
              </input>
              <xsl:value-of select="$i18n/paid_in_full"/>
              <br/>
              <input type="radio" name="paid_status" value="partial_payment">
                <xsl:if test="//business_object_get_metadata/business_object_get_metadata/paid_status='partial_payment'">
                  <xsl:attribute name="checked">checked</xsl:attribute>
                </xsl:if>
              </input>
              <xsl:value-of select="$i18n/paid"/>
              <br/>
              <input type="radio" name="paid_status" value="unpaid">
                <xsl:if test="not(//business_object_get_metadata/paid_status) or //business_object_get_metadata/paid_status='unpaid'">
                  <xsl:attribute name="checked">checked</xsl:attribute>
                </xsl:if>
              </input>
              <xsl:value-of select="$i18n/unpaid"/>
              <br/>
            </td>
          </tr>
          <tr>
            <td>
              <xsl:value-of select="$i18n/paid_in_full_date"/>:
						</td>
            <td colspan="8">
              <input type="text" name="paid_in_full_date"
								value="{//business_object_get_metadata/business_object_get_metadata/paid_in_full_date}"/>
            </td>
          </tr>
        </tbody>
        <tbody>
          <tr>
            <td colspan="8">
              <xsl:value-of select="$i18n/billable_items"/>:
						</td>
          </tr>
          <tr>
            <td>ID
						</td>
            <td>
              <xsl:value-of select="$i18n/revenue"/>
            </td>
            <td>
              <xsl:value-of select="$i18n/desc"/>
            </td>
            <td width="240"></td>
            <td>
              <xsl:value-of select="$i18n/quantity"/>
            </td>
            <td>
              <xsl:value-of select="$i18n/price"/>
            </td>
            <td>
              <xsl:value-of select="$i18n/total"/>
            </td>
            <td>
              <xsl:value-of select="$i18n/edit"/>
            </td>
          </tr>

        <!-- INVOICE LINE ITEM ROWS -->
          <xsl:for-each select="//get_journal_entry/get_journal_entry[entry_type_id='Credit']">
            <xsl:variable name="my_entry_amount_id">
              <xsl:value-of select="entry_amount_id"/>
            </xsl:variable>
            <tr id="i-{entry_amount_id}">
              <td>
                <xsl:value-of select="entry_amount_id"/>
              </td>
              <td>
                <select name="credit_account_1[]">
                  <option>
                    <xsl:value-of select="$i18n/select_one"/>
                  </option>
                  <xsl:for-each select="/_R_/get_all_accounts/get_all_accounts[account_type_id=40000]">
                    <xsl:variable name="my_account_id">
                      <xsl:value-of select="id"/>
                    </xsl:variable>
                    <option value="{$my_account_id}">
                      <xsl:if test="/_R_/invoices_get_amounts/invoices_get_amounts[entry_amount_id=$my_entry_amount_id]/account_id=$my_account_id">
                        <xsl:attribute name="selected">selected</xsl:attribute>
                      </xsl:if>
                      <xsl:value-of select="name"/>
                    </option>
                  </xsl:for-each>
                </select>
              </td>
              <td colspan="2">
                <input type="text" name="memorandum[]" style="width: 20em;"
									value="{/_R_/invoices_get_amounts/invoices_get_amounts[entry_amount_id=$my_entry_amount_id]/memorandum}"/>
              </td>
              <td>
                <input type="text" name="quantity" size="4"/>
              </td>
              <td>
                <input type="text" name="price" size="4"/>
              </td>
              <td>
                <input type="text" name="credit_amount_1[]" size="6"
									value="{/_R_/invoices_get_amounts/invoices_get_amounts[entry_amount_id=$my_entry_amount_id]/entry_amount}"/>
              </td>
              <td>
                <xsl:if test="position() &gt; 1">
                  <a href="{$link_prefix}journal_entry_amount_delete&amp;entry_amount_id={entry_amount_id}"
                      onclick="journal_entry_amount_delete({entry_amount_id},this.parentNode.parentNode.rowIndex); return false;">
                    <img src="{$path_prefix}{/_R_/runtime/icon_set}delete.png" border="0" />
                  </a>
                </xsl:if>
              </td>
            </tr>
          </xsl:for-each>
          <!-- END LINE ITEMS -->
          <tr>
            <td colspan="7"></td>
            <td>
              <a href="{$link_prefix}journal-entry-new-credit&amp;entry_id={/_R_/_get/entry_id}">
                <img onclick="journal_entry_amount_create('credit',{/_R_/_get/entry_id}); return false;"
									src="{$path_prefix}{/_R_/runtime/icon_set}add.png" />
              </a>
            </td>
          </tr>
          <tr>
            <td colspan="7">
              <input type="submit"/>
            </td>
          </tr>
        </tbody>
      </table>
    </form>
  </xsl:template>
</xsl:stylesheet>
