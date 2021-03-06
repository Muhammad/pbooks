<!--
Program: PBooks
Component: journal_entry.xsl
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

<!--
This template requires explanation. The form contains at least two entry
amounts - one credit and one debit. These are created by templates located
further down the page ( I may separate them into separate files ). If there is
more than one debit or credit, there can only be one of the other type.
-->

  <xsl:template name="content">
    <xsl:param name="link_prefix"/>
    <xsl:param name="path_prefix"/>
    <xsl:variable name="get_journal_entry"
    select="/_R_/get_journal_entry/get_journal_entry" />


<script type="text/javascript"
src="{$link_prefix}x-tablesorter-setup-js&amp;simple=true" />

<script type="text/javascript">
function journal_entry_amount_create(entry_type_id) {
  $.post("<xsl:value-of select="$link_prefix"/>x-journal-entry-new-"+entry_type_id+"&amp;entry_id=<xsl:value-of select="//_get/entry_id"/>",
  {
      'entry_id': <xsl:value-of select="//_get/entry_id"/>,
      'entry_datetime': document.getElementById("entry_datetime").value,
      'memorandum': document.getElementById("memorandum").value
  },
  function (data){
      setTimeout('window.location.reload()',200);
  });
}
</script>

<a class="generic-button" style="float: right;" href="{$link_prefix}journal">
  <img style="margin-bottom: 0px;" src="{$path_prefix}s/images/buttons/in.gif"/>
  Go to Journal
</a>

<!-- Non existent entry_id error -->
<xsl:if test="not($get_journal_entry)">
  <div class="error">
    <xsl:value-of select="//errors/error[key='non_existent_entry_id']/value"/>
  </div>

  <table cellpadding="5">
    <tr>
      <td>
        <a href="{$link_prefix}{//_get/nid}&amp;entry_id={/_R_/_get/entry_id - 1}">
          <img src="{$path_prefix}s/images/buttons/out.gif"/>
        </a>
      </td>
      <td>
        <input type="button" value="Go Back" onclick="history.go(-1)"/>
      </td>
      <td>
        <a href="{$link_prefix}{//_get/nid}&amp;entry_id={/_R_/_get/entry_id + 1}">
          <img src="{$path_prefix}s/images/buttons/in.gif"/>
        </a>
      </td>
    </tr>
  </table>
</xsl:if>
<!-- End error message -->

<!-- Check to make sure entry_id exists -->
<xsl:if test="$get_journal_entry">

<xsl:comment>
start journal entry form table
</xsl:comment>
  <form name="myform" method="post"
  onSubmit="return validateStandard(this, 'error');"
  action="{$link_prefix}journal-edit-submit&amp;entry_id={/_R_/_get/entry_id}">
    <xsl:if test="/_R_/_get/entry_id">
      <input type="hidden" name="entry_id" value="{/_R_/_get/entry_id}"/>
    </xsl:if>
    <div id="journal-entry-form">
      <table class="form-table">
        <tbody>
        <tr>
          <th>
            <span id="i18n-entry">Entry</span>
          </th>
          <td>
            <xsl:value-of select="/_R_/_get/entry_id"/>
          </td>
        </tr>
        <tr>
          <th>
            <span id="i18n-date">Date</span>
          </th>
          <td>
            <input type="text" name="entry_datetime" id="entry_datetime"
            value="{$get_journal_entry/entry_datetime}"/>
            <label for="fiscal_period_id">
              <span id="i18n-fiscal_period">Fiscal Period</span>
            </label>
            <input type="text" name="fiscal_period_id" id="fiscal_period_id"
            class="five">
              <xsl:attribute name="value">
                <xsl:if test="$get_journal_entry/fiscal_period_id">
                  <xsl:value-of select="$get_journal_entry/fiscal_period_id"/>
                </xsl:if>
                <xsl:if test="not($get_journal_entry/fiscal_period_id)">
                  <xsl:value-of select="/_R_/runtime/current_fiscal_period_id"/>
                </xsl:if>
              </xsl:attribute>
            </input>
          </td>
          <xsl:if test="/_R_/_get/transaction_id">
            <input type="hidden" name="transaction_id"
            value="{/_R_/_get/transaction_id}"/>
            <input type="hidden" name="transaction_amount"
            value="{//entry_amount}"/>
            <input type="hidden" name="transaction_account_id"
            value="{$get_journal_entry/account_id}"/>
          </xsl:if>
        </tr>
        <tr>
          <td colspan="2">
            <span class="i18n-amount">Amount</span> :
          </td>
        </tr>
        <tr>
          <td colspan="2">
            <table class="tablesorter" id="entry_form_table">
              <thead>
                <tr>
                  <th />
                  <th>
                    <span class="i18n-type">Type</span> :
                  </th>
                  <th>
                    <span class="i18n-accounts">Accounts</span> :
                  </th>
                  <th>
                    <span class="i18n-debit">Debit</span> :
                  </th>
                  <th>
                    <span class="i18n-credit">Credit</span> :
                  </th>
                  <th width="20" />
                </tr>
              </thead>
              <tbody>
              <!--
              Recursive, aka looping, template for debits
              calls the journal entry row templates, see below
              -->
                <xsl:for-each select="$get_journal_entry[entry_type_id='Debit']">
                  <xsl:variable name="my_account_id"  select="account_id"/>
                  <xsl:call-template name="debit">
                    <xsl:with-param name="my_entry_id" value="{entry_id}"/>
                    <xsl:with-param name="link_prefix" select="$link_prefix"/>
                    <xsl:with-param name="path_prefix" select="$path_prefix"/>
                    <xsl:with-param name="get_journal_entry" select="$get_journal_entry"/>
                  </xsl:call-template>
                </xsl:for-each>
                <!-- for broken journal entries without a debit -->
                <xsl:if test="not($get_journal_entry[entry_type_id='Debit'])">
                  <xsl:call-template name="debit">
                    <xsl:with-param name="link_prefix" select="$link_prefix"/>
                    <xsl:with-param name="path_prefix" select="$path_prefix"/>
                    <xsl:with-param name="get_journal_entry" select="$get_journal_entry"/>
                  </xsl:call-template>
                </xsl:if>

                <!-- Recursive, aka looping, template for credits -->
                <xsl:for-each select="$get_journal_entry[entry_type_id='Credit']">
                  <xsl:variable name="my_account_id" select="account_id"/>
                  <xsl:call-template name="credit">
                    <xsl:with-param name="my_entry_id" select="entry_amount"/>
                    <xsl:with-param name="my_entry_amount_id" select="entry_amount_id"/>
                    <xsl:with-param name="link_prefix" select="$link_prefix"/>
                    <xsl:with-param name="path_prefix" select="$path_prefix"/>
                    <xsl:with-param name="get_journal_entry" select="$get_journal_entry"/>
                  </xsl:call-template>
                </xsl:for-each>

                <!-- for broken journal entries without a credit -->
                <xsl:if test="not($get_journal_entry[entry_type_id='Credit'])">
                  <xsl:call-template name="credit">
                    <xsl:with-param name="link_prefix" select="$link_prefix"/>
                    <xsl:with-param name="path_prefix" select="$path_prefix"/>
                    <xsl:with-param name="get_journal_entry" select="$get_journal_entry"/>
                  </xsl:call-template>
                </xsl:if>
              </tbody>
            </table>
          </td>
        </tr>
        <tr>
          <td>
            <span class="i18n-memorandum">Memorandum</span>:
          </td>
          <td>
            <textarea type="text" name="memorandum" id="memorandum"
              rows="5" cols="35" required="1" err="Please enter a memo.">
            <!-- don't show placeholders -->
              <xsl:if test=" not ( contains($get_journal_entry/memorandum,'__') ) and
                ( not($get_journal_entry=9) ) ">
                <xsl:value-of select="$get_journal_entry/memorandum"/>
              </xsl:if>
            </textarea>
          </td>
        </tr>
        <tr>
          <td colspan="2">
            <table>
              <tr>
              <!-- this is an arrow which links to the previous entry_id in the journal -->
                <td>
                  <a href="{$link_prefix}{//_get/nid}&amp;entry_id={/_R_/_get/entry_id - 1}">
                    <img src="{$path_prefix}s/images/buttons/out.gif"/>
                  </a>
                </td>

                <!-- Submit the entry -->
                <td colspan="3">
                  <input type="submit" name="submit" id="submit"
                    value="Submit" class="generic-button"/>
                  <!--
                  Cancel the entry, if this is from a transaction,
                  the entry must be deleted
                  -->
                  <input type="button" class="generic-button" value="Cancel">
                    <xsl:if test="/_R_/_get/transaction_id">
                      <xsl:attribute name="onclick">
                        <xsl:text>window.location.href='</xsl:text>
                        <xsl:value-of select="$link_prefix"/>
                        <xsl:text>journal-cancel&amp;transaction_id=</xsl:text>
                        <xsl:value-of select="/_R_/_get/transaction_id"/>
                        <xsl:text>'</xsl:text>
                      </xsl:attribute>
                    </xsl:if>
                    <xsl:if test="not(/_R_/_get/transaction_id)">
                      <xsl:attribute name="onclick">
                        <xsl:text>window.location.href='</xsl:text>
                        <xsl:value-of select="$link_prefix"/>
                        <xsl:text>journal"'</xsl:text>
                      </xsl:attribute>
                    </xsl:if>
                  </input>
                </td>

                <!-- this is an arrow which links to the next entry_id in the journal -->
                <td>
                  <a href="{$link_prefix}{//_get/nid}&amp;entry_id={/_R_/_get/entry_id + 1}">
                    <img src="{$path_prefix}s/images/buttons/in.gif"/>
                  </a>
                </td>
              </tr>
            </table>

            <!-- Note about cancelled transaction entries-->
            <xsl:if test="/_R_/_get/transaction_id">
You are creating a journal entry from a transaction. This is good! However, if you plan to abort this process, please use the cancel button. Otherwise the transaction will be associated with an unfinished journal entry. This can be recovered, but it will be much easier if you click the cancel button instead of simply navigating away.

If you want to complete this process, continue as usual. For more information, see <a href="http://www.pbooks.org/trac/ticket/91" target="_blank">http://www.pbooks.org/trac/ticket/91</a>.
            </xsl:if>
            <!-- end note -->

          </td>
        </tr>
        </tbody>
      </table>
    </div>
    <xsl:comment>end entry form table </xsl:comment>
  </form>

  <!-- only display in training mode -->
  <xsl:if test="/_R_/runtime/books_mode='training'">
    <div class="generic-button" id="delete-journal-entry-button">
      <form method="post" action="{$link_prefix}journal-delete">
        <input type="hidden" name="entry_id" value="{/_R_/_get/entry_id}"/>
        <input type="submit" value="Delete this entry" onclick="return confirm('Are you sure?');"/>
      </form>
    </div>
  </xsl:if>
  <!-- end training mode -->
</xsl:if>
</xsl:template>
<!-- end form template -->



<!--
These are the journal entry row templates. They are fairly complex and somewhat messy. 
TODO: Clean these up!
-->

<!-- CREDIT -->
<xsl:template name="credit">
<xsl:param name="link_prefix"/>
<xsl:param name="path_prefix"/>
<xsl:param name="get_journal_entry"/>
<xsl:param name="get_journal_entry"/>
<xsl:variable name="my_account_id" select="account_id"/>
<xsl:variable name="my_entry_amount_id" select="entry_amount_id"/>
<tr class="odd">
  <td>
    <xsl:if test="count($get_journal_entry[entry_type_id='Debit'])&lt;2 and (entry_amount=0 or /_R_/_get/transaction_id or not(entry_amount) or not($get_journal_entry[entry_type_id='Debit']))">
      <a onclick="journal_entry_amount_create('credit'); return false;" href="">
        <img src="{$path_prefix}{/_R_/runtime/icon_set}add.png"/>
      </a>
    </xsl:if>
  </td>
  <td>
    <span class="i18n-credit">Credit</span>:
</td>
  <td>
    <div class="credit_div">
      <select name="credit_account_1[]" required="1" exclude="-1"
        err="Please select a credit account.">
        <option value="-1">
          <span class="i18n-credit_account">Credit Account</span>
        </option>
        <xsl:for-each select="/_R_/get_all_accounts/get_all_accounts">
          <option value="{id}">
            <xsl:if test="id=$get_journal_entry[entry_amount_id=$my_entry_amount_id]/account_id and not(/_R_/_get/transaction_id)">
              <xsl:attribute name="selected">selected</xsl:attribute>
            </xsl:if>

            <xsl:if test="/_R_/_get/transaction_id">
              <xsl:if test="($get_journal_entry/entry_amount &gt;0 and ($get_journal_entry/account_type_id=20000 or $get_journal_entry/account_type_id=30000 or $get_journal_entry/account_type_id=40000)) or ($get_journal_entry/entry_amount &lt; 0 and ($get_journal_entry/account_type_id=10000 or $get_journal_entry/account_type_id=50000))">
                <xsl:if test="id=$get_journal_entry/account_id">
                  <xsl:attribute name="selected">selected</xsl:attribute>
                </xsl:if>
                <xsl:if test="not(id=$get_journal_entry/account_id)">
                  <xsl:attribute name="disabled">disabled</xsl:attribute>
                </xsl:if>
              </xsl:if>
            <!-- If not, does the memo match up with an account's metadata? -->
            <xsl:if test="($get_journal_entry/entry_amount &lt;0 and ($get_journal_entry/account_type_id=20000 or $get_journal_entry/account_type_id=30000 or $get_journal_entry/account_type_id=40000)) or ($get_journal_entry/entry_amount &gt;0 and ($get_journal_entry/account_type_id=10000 or $get_journal_entry/account_type_id=50000))">
              <xsl:if test="not(description='' or description=' ') and (contains(description,substring($get_journal_entry/memorandum,1,7)) or contains(description,$get_journal_entry/entry_amount)
or contains($get_journal_entry/memorandum,description)) ">
                <xsl:attribute name="selected">selected</xsl:attribute>
              </xsl:if>
            </xsl:if>
            </xsl:if>

            <xsl:value-of select="name"/>
          </option>
        </xsl:for-each>

        <!-- HIDDEN ACCOUNT -->
        <xsl:if test="not($get_journal_entry[entry_amount_id=$my_entry_amount_id]/account_id=//get_all_accounts/get_all_accounts/id) and not($get_journal_entry/status=9) and not(/_R_/_get/transaction_id)">
          <option value="{$get_journal_entry/account_id}" selected="selected">
            <span class="i18n-account_hidden">Account Hidden</span>
          </option>
        </xsl:if>
      </select>
    </div>
  </td>
  <td></td>
  <td class="dontwrap">
    <xsl:value-of select="//runtime/default_currency_unit"/>
    <input name="credit_amount_1[]" type="text" size="6" required="1"
      equals="sum(debit_amount_1)" err="Credit and Debit amounts must be equal.">
      <xsl:attribute name="value">
        <xsl:if test="not(/_R_/_get/transaction_id)">
          <xsl:value-of select="entry_amount"/>
        </xsl:if>
        <xsl:if test="/_R_/_get/transaction_id">
          <xsl:call-template name="abs-amount">
            <xsl:with-param name="get_journal_entry" select="$get_journal_entry"/>
          </xsl:call-template>
          <!--
          <xsl:value-of select="math:abs($get_journal_entry/entry_amount)"/>
          -->
        </xsl:if>
      </xsl:attribute>
      <xsl:if test=" (
        $get_journal_entry/entry_amount &gt; 0 and (
          $get_journal_entry/account_type_id=20000 or
          $get_journal_entry/account_type_id=30000 or
          $get_journal_entry/account_type_id=40000 )
        ) or (
          $get_journal_entry/entry_amount &lt;0 and
            ( $get_journal_entry/account_type_id=10000 or
              $get_journal_entry/account_type_id=50000
            )
        )">
        <xsl:if test="not(id=$get_journal_entry/account_id)">
          <xsl:attribute name="readonly">readonly</xsl:attribute>
        </xsl:if>
      </xsl:if>
    </input>
  </td>

  <td>
    <xsl:if test="count($get_journal_entry[entry_type_id='Credit']) &gt; 1">
      <a href="{$link_prefix}journal_entry_amount_delete&amp;entry_amount_id={entry_amount_id}"
        onclick="journal_entry_amount_delete({entry_amount_id},this.parentNode.parentNode.rowIndex); return false;">
        <img src="{$path_prefix}{/_R_/runtime/icon_set}delete.png"/>
      </a>
    </xsl:if>
    <xsl:if test="count($get_journal_entry[entry_type_id='Debit']) &gt; 1">
      <a href="" onclick="debits_summarize(); return false;">
        <img src="{$path_prefix}{/_R_/runtime/icon_set}icon_accept.gif"/>
      </a>
    </xsl:if>
  </td>
</tr>
</xsl:template>


<!-- DEBIT -->
<xsl:template name="debit">
<xsl:param name="link_prefix"/>
<xsl:param name="path_prefix"/>
<xsl:param name="get_journal_entry"/>
<xsl:variable name="my_entry_amount" select="entry_amount"/>
<tr>
  <td>
    <xsl:if test="count($get_journal_entry[entry_type_id='Credit'])&lt;2 and (entry_amount=0.00 or not(entry_amount) or /_R_/_get/transaction_id or not($get_journal_entry[entry_type_id='Credit']))">
      <a href="" onclick="journal_entry_amount_create('debit'); return false;">
        <img src="{$path_prefix}{/_R_/runtime/icon_set}add.png"/>
      </a>
    </xsl:if>
  </td>
  <td>
    <span class="i18n-debit">Debit</span>:
  </td>
  <td>
    <select name="debit_account_1[]" required="1" exclude="-1"
      err="Please select a debit account.">
      <option value="-1">
        <span class="i18n-debit_account">Debit Account</span>
      </option>
      <xsl:for-each select="/_R_/get_all_accounts/get_all_accounts">
        <option value="{id}">
            <!-- Existing entry? -->
          <xsl:if test="id=$get_journal_entry[entry_type_id='Debit'][entry_amount=$my_entry_amount]/account_id and not(/_R_/_get/transaction_id)">
            <xsl:attribute name="selected">selected</xsl:attribute>
          </xsl:if>
            <!-- Existing transaction? -->
          <xsl:if test="/_R_/_get/transaction_id">
            <!-- Is the transaction a debit? -->
            <xsl:if test="($get_journal_entry/entry_amount &lt;0 and ($get_journal_entry/account_type_id=20000 or $get_journal_entry/account_type_id=30000 or $get_journal_entry/account_type_id=40000)) or ($get_journal_entry/entry_amount &gt;0 and ($get_journal_entry/account_type_id=10000 or $get_journal_entry/account_type_id=50000))">
              <xsl:if test="id=$get_journal_entry/account_id">
                <xsl:attribute name="selected">selected</xsl:attribute>
              </xsl:if>
              <xsl:if test="not(id=$get_journal_entry/account_id)">
                <xsl:attribute name="disabled">disabled</xsl:attribute>
              </xsl:if>
            </xsl:if>
            <!-- If not, does the memo match up with an account's metadata? -->
            <xsl:if test="($get_journal_entry/entry_amount &gt;0 and ($get_journal_entry/account_type_id=20000 or $get_journal_entry/account_type_id=30000 or $get_journal_entry/account_type_id=40000)) or ($get_journal_entry/entry_amount &lt;0 and ($get_journal_entry/account_type_id=10000 or $get_journal_entry/account_type_id=50000))">
              <xsl:if test="not(description='' or description=' ') and (contains(description,substring($get_journal_entry/memorandum,1,7)) or contains(description,$get_journal_entry/entry_amount)
or contains($get_journal_entry/memorandum,description))">
                <xsl:attribute name="selected">selected</xsl:attribute>
              </xsl:if>
            </xsl:if>

          </xsl:if>
          <xsl:value-of select="name"/>
        </option>
      </xsl:for-each>

      <!-- HIDDEN ACCOUNT -->
      <xsl:if test="not($get_journal_entry[entry_type_id='Debit'][entry_amount=$my_entry_amount]/account_id=//get_all_accounts/get_all_accounts/id) and not($get_journal_entry/status=9) and not(/_R_/_get/transaction_id)">
        <option value="{$get_journal_entry/account_id}" selected="selected">
          <span class="i18n-account_hidden">Account Hidden</span>
        </option>
      </xsl:if>
    </select>
  </td>
  <td class="dontwrap">
    <xsl:value-of select="//runtime/default_currency_unit"/>
    <input name="debit_amount_1[]" type="text" size="6" required="1" regexp="/^\d+([\.]\d\d)?$/"
    err="Please enter a monetary value for the debit and credit. Do not include $ signs.">
      <xsl:attribute name="value">
        <xsl:if test="not(/_R_/_get/transaction_id)">
          <xsl:value-of select="entry_amount"/>
        </xsl:if>
        <xsl:if test="/_R_/_get/transaction_id">
          <xsl:call-template name="abs-amount">
            <xsl:with-param name="get_journal_entry" select="$get_journal_entry"/>
          </xsl:call-template>
        </xsl:if>
      </xsl:attribute>
    </input>
  </td>
  <td></td>

  <td>
    <xsl:if test="count($get_journal_entry[entry_type_id='Debit']) &gt; 1">
      <a href="{$link_prefix}journal_entry_amount_delete&amp;entry_amount_id={entry_amount_id}"
      onclick="journal_entry_amount_delete({entry_amount_id},this.parentNode.parentNode.rowIndex); return false;">
        <img src="{$path_prefix}{/_R_/runtime/icon_set}delete.png" />
      </a>
    </xsl:if>
  </td>
</tr>


  </xsl:template>

  <xsl:template name="abs-amount">
    <xsl:param name="get_journal_entry"/>
    <xsl:if test="$get_journal_entry/entry_amount &lt;0">
      <xsl:value-of select="0 - $get_journal_entry/entry_amount"/>
    </xsl:if>
    <xsl:if test="$get_journal_entry/entry_amount &gt;0">
      <xsl:value-of select="$get_journal_entry/entry_amount"/>
    </xsl:if>
  </xsl:template>
</xsl:stylesheet>
