<!--
Program: PBooks
Component: deposit_form.xsl
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

    <xsl:variable
      name   = "account_business_objects"
      select = "/_R_/account_business_objects/account_business_objects"
    />

    <xsl:variable
      name   = "get_journal_entry"
      select = "/_R_/get_journal_entry/get_journal_entry"
    />

    <xsl:variable
      name   = "business_object_get_metadata"
      select = "/_R_/business_object_get_metadata/business_object_get_metadata"
    />

    <script type="text/javascript">
    <!--
    function journal_entry_amount_delete(entry_amount_id) {
      $.post("<xsl:value-of select="$link_prefix"/>journal-entry-amount-
      ",
      {
        'entry_amount_id': entry_amount_id
      },
      function (data){
        $("d_"+entry_amount_id).remove();
      });
    }
    -->
    function journal_entry_amount_create(entry_type_id,entry_id) {
      var this_entry_date = $("#invoice_date").val();
      $.post("<xsl:value-of select="$link_prefix"/>journal-entry-new-"+entry_type_id+"&amp;entry_id="+entry_id,
      {
        'entry_id': entry_id,
        'entry_datetime': this_entry_date
      },
      function (data){
        setTimeout('window.location.reload()',200);
      });
    }
    </script>
    <h2>
      <xsl:value-of select="$i18n/make_deposits"/>
    </h2>

    <form action="{$link_prefix}deposit-submit&amp;entry_id={/_R_/_get/entry_id}"
			method="post" onSubmit="return validateStandard(this, 'myerror');
      alert(sum(debit_amount_1[]));">
			<!-- If there is more than one deposit account, the user needs to select
	which one the deposit is being made into -->
      <xsl:if test="count($account_business_objects) &gt; 1">
        <select name="debit_account_1[]" required="1" exclude="-1"
            err="{/_R_/i18n/error_select_debit}">
          <option value="-1">
            <xsl:value-of select="$i18n/deposit_account"/>
          </option>
          <xsl:for-each select="$account_business_objects">
            <option value="{id}">
              <xsl:if test="id=$get_journal_entry[entry_type_id='Debit']/account_id">
                <xsl:attribute name="selected">selected</xsl:attribute>
              </xsl:if>
              <xsl:value-of select="name"/>
            </option>
          </xsl:for-each>
        </select>
      </xsl:if>
      <!-- If there is only one deposit account, just use that id -->
      <xsl:if test="count($account_business_objects) = 1">
        <input type="hidden" name="debit_account_1[]"
          value="{$account_business_objects/id}"/>
      </xsl:if>
      <input type="hidden" name="entry_id" value="{/_R_/_get/entry_id}"/>
      <input type="hidden" name="fiscal_period_id" value="{/_R_/runtime/current_fiscal_period_id}"/>
      <div id="business_object_slip">
        <div id="my_deposit_account_id"></div>
        <div id="deposit_date">
          <xsl:value-of select="$i18n/date"/>:
          <input type="text" name="entry_datetime"
            value="{$get_journal_entry/entry_date}"
          />
        </div>
        <div id="deposit_memo">
          <xsl:value-of select="$i18n/memo"/>:
          <input type="text" name="memorandum"
            value="{$get_journal_entry/memorandum}"
          />
        </div>
        <div id="deposit_payee">
          <table border="0" id="deposit_form_table">
            <xsl:if test="//deposits_cash='yes'">
              <tr>
                <td>
                  <xsl:value-of select="$i18n/cash"/>
                </td>
                <td>
                  <xsl:value-of select="$i18n/amount"/>
                </td>
                <td>
									<xsl:value-of select="$i18n/invoice"/>
								</td>
                <td>
                  <xsl:value-of select="$i18n/source"/>
                </td>
              </tr>
              <tr>
                <!-- Here the check number is the equivalent of a journal entry memorandum -->
                <td>
                  <input type="text" name="check_number[]" style="width: 40px;"
                    value="{$get_journal_entry/entry_amount_memorandum}"/>
                </td>
                <td>
                  <input type="text" name="entry_amount[]" style="width: 60px;"
                    value="{$get_journal_entry/entry_amount}"/>
                </td>
                <td>
								<!-- only one cash entry is allowed -->
								</td>
                <td>
                  <select name="invoice_id" required="0" exclude="-1"
                  err="{/_R_/i18n/error_select_credit}">
                    <option value="-1">
                      <xsl:value-of select="$i18n/outstanding_invoices"/>
                    </option>
                    <option value="0">
                      <xsl:value-of select="$i18n/not_applicable"/>
                    </option>
                    <xsl:for-each select="/_R_/get_some_business_objects/get_some_business_objects">
                      <xsl:variable name="my_new_entry_id" select="entry_id"/>
                      <xsl:variable name="my_client_id"
                        select="$business_object_get_metadata[meta_key='client_id' and entry_id=$my_new_entry_id]/meta_value"/>

                      <option value="{id}">
                        <xsl:if test="id=//metadata/account_id and not(/_R_/_get/transaction_id)">
                          <xsl:attribute name="selected">selected</xsl:attribute>
                        </xsl:if>
                        <xsl:value-of select="$business_object_get_metadata[meta_key='invoice_number' and entry_id=$my_new_entry_id]/meta_value"/> - 
                        <xsl:value-of select="//clients/clients/client[client_id=$my_client_id]/client_name"/>

                        <xsl:value-of select="name"/>
                      </option>
                    </xsl:for-each>
                  </select>
                </td>
              </tr>
            </xsl:if>
            <tr>
              <td>
                <xsl:value-of select="$i18n/checks"/>
              </td>
              <td>
                <xsl:value-of select="$i18n/amount"/>
              </td>
              <td>
								<xsl:value-of select="$i18n/invoice"/>
							</td>
              <td>
                <xsl:value-of select="$i18n/source"/>
              </td>
            </tr>
            <xsl:for-each select="$get_journal_entry[entry_type_id='Credit']">
              <xsl:variable name="my_entry_amount_id" select="entry_amount_id"/>
              <tr id="d_{$my_entry_amount_id}">
                <!-- Here the check number is the equivalent of a journal entry memorandum -->
                <td>
                  <input type="text" name="check_number[]" style="width: 40px;"
                  value="{$get_journal_entry[entry_amount_id=$my_entry_amount_id]/entry_amount_memorandum}"/>
                </td>
                <td>
                  <input type="text" name="credit_amount_1[]" style="width: 60px;" id="credit_amount_{position()}"
                    value="{$get_journal_entry[entry_amount_id=$my_entry_amount_id]/entry_amount}"
                    onkeyup="copyValue('credit_amount_{position()}','debit_amount_{position()}');"
                    />
                  <input type="hidden" name="debit_amount_1[]" id="debit_amount_{position()}" />
                </td>
                <!-- Additional deposit line items. -->
                <td>
                  <xsl:if test="position() &gt; 1">
                    <a href="{$link_prefix}journal_entry_amount_delete&amp;entry_amount_id={entry_amount_id}"
                        onclick="journal_entry_amount_delete({entry_amount_id}); return false;">
                      <img src="{$path_prefix}{/_R_/runtime/icon_set}delete.png" />
                    </a>
                  </xsl:if>
                </td>
                <!-- OUTSTANDING INVOICES DROP DOWN LIST HERE -->
                <td>
                  <select name="invoice_id" required="0"
										exclude="-1" err="{/_R_/i18n/error_select_credit}">
                    <option value="-1">
                      <xsl:value-of select="$i18n/outstanding_invoices"/>
                    </option>
                    <option value="0">
                      <xsl:value-of select="$i18n/not_applicable"/>
                    </option>
                    <xsl:for-each select="/_R_/get_some_business_objects/get_some_business_objects">
                      <xsl:variable name="my_new_entry_id" select="entry_id"/>
                      <xsl:variable name="my_customer_id" select="customer_id"/>

                      <option value="{id}">
                        <xsl:if test="id=//metadata/metadata/account_id and not(/_R_/_get/transaction_id)">
                          <xsl:attribute name="selected">selected</xsl:attribute>
                        </xsl:if>
                        <xsl:value-of select="$business_object_get_metadata[meta_key='invoice_number' and entry_id=$my_new_entry_id]/meta_value"/>, 
                        <xsl:value-of select="substring(/_R_/get_all_accounts/get_all_accounts[id=$my_customer_id]/name,0,12)"/>

                        <xsl:value-of select="name"/>
                      </option>
                    </xsl:for-each>
                  </select>
                </td>
                <td>
                  <!-- need to select where the money is coming from - or is it accounts receivable? -->
                  <select name="credit_account_1[]" required="1" exclude="-1"
                    err="{$i18n/error_select_credit}">
                    <option value="-1">
                      <xsl:value-of select="$i18n/credit_account"/>
                    </option>
                    <xsl:for-each select="/_R_/get_all_accounts/get_all_accounts">
                      <xsl:variable name="my_account_id" select="id"/>
                      <option value="{$my_account_id}">
                        <xsl:if test="($my_account_id=$get_journal_entry[entry_type_id='Credit']/account_id) and not(/_R_/_get/transaction_id)">
                          <xsl:attribute name="selected">selected</xsl:attribute>
                        </xsl:if>
                        <xsl:value-of select="substring(name,0,16)"/>
                      </option>
                    </xsl:for-each>
                  </select>
                </td>
              </tr>
            </xsl:for-each>

            <tr>
              <td colspan="2" />
              <td>
                <a href="{$link_prefix}journal-entry-new-credit&amp;entry_id={/_R_/_get/entry_id}">
                  <img onclick="journal_entry_amount_create('credit',{/_R_/_get/entry_id}); return false;"
                  src="{$path_prefix}{/_R_/runtime/icon_set}add.png" border="0"/>
                </a>
              </td>
              <td colspan="2" />
            </tr>
          </table>

					<!-- Link to journal entry form. -->
          <div style="float: right">
            <a href="{$link_prefix}journal-entry&amp;entry_id={/_R_/_get/entry_id}">
              <xsl:value-of select="$i18n/edit_journal_entry"/>
            </a>
          </div>
        </div>
      </div>
      <input type="submit" id="submit-me"/>
    </form>

  </xsl:template>
</xsl:stylesheet>
