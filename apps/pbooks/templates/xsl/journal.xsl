<!--
Program: PBooks
Component: journal.xsl
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
  <xsl:include href="prev_next.xsl"/>
  <xsl:template name="content">
    <xsl:param name="link_prefix"/>
    <xsl:param name="path_prefix"/>
    <xsl:variable name="get_all_entry_amounts"
    select="/_R_/get_all_entry_amounts/get_all_entry_amounts" />
    <xsl:variable name="get_all_debits"
    select="$get_all_entry_amounts[entry_type_id='Debit']" />
    <xsl:variable name="get_all_credits"
    select="$get_all_entry_amounts[entry_type_id='Credit']" />


<!-- buttons on the right hand side -->
<div class="generic-button table_meta" style="float: right;">
  <a href="{$link_prefix}journal-new" class="generic-button"
  id="new_journal_entry">
    <img src="{$path_prefix}{/_R_/runtime/icon_set}/folder_new.gif"/>
    <span id="i18n-new_entry">New Entry</span>
  </a>
</div>

<div class="tableframe">
<form action="{$link_prefix}journal-delete" method="post">
<!--
This is the table of journal entries. we don't use the tablesorter here
because of the dynamic number of rows per entry.
-->
  <table class="journal-table">
    <thead>
      <tr>
        <th>
          <span id="i18n-date">Date</span>
        </th>
        <th />
        <th width="200">
          <span id="i18n-memo">Memorandum</span>
        </th>
        <th width="15" />
        <th>
          <span id="i18n-accounts">Accounts</span>
        </th>
        <th>
          <span id="i18n-debit">Debit</span>
        </th>
        <th>
          <span id="i18n-credit">Credit</span>
        </th>
        <th>
          <span id="i18n-id">ID</span>
        </th>
        <th />
      </tr>
    </thead>
    <tbody>
    <!--
    Each journal entry is comprised of the entry itself, plus several entry
    amounts and accounts which are descendent from it. The outer loop goes
    through each entry, and the inner loop iterates through each entry amount.
    -->

    <!-- OUTER LOOP -->
      <xsl:for-each select="/_R_/get_all_entries/get_all_entries">
        <xsl:variable name="this_entry_id" select="entry_id"/>
        <xsl:variable name="posa" select="position() mod 2"/>
        <tr class="row2" onclick="journal_entry_location({entry_id});">
          <td valign="top" class="journal-data">
            <xsl:value-of select="entry_datetime"/>
          </td>
          <td />
          <td valign="top" class="journal-data" colspan="5" width="100%">
            <a href="{$link_prefix}journal-entry&amp;entry_id={entry_id}">
              <xsl:value-of select="substring(memorandum,0,60)"/>
              <xsl:if test="string-length(memorandum) &gt; 60">
                ...
              </xsl:if>
            </a>
          </td>
          <td valign="top" class="journal-data">
            <a href="{$link_prefix}journal-entry&amp;entry_id={entry_id}">
              <xsl:value-of select="entry_id"/>
            </a>
          </td>
          <td align="right" valign="top" class="journal-data">
            <input type="checkbox" name="entry_id[]" value="{entry_id}"/>
          </td>
        </tr>

        <!--
        These variables are used inside the loop to select specific nodes using
        xpath This should likely be moved to processing instruction or SQL.
        -->
        <xsl:variable name="this_entry_debit_total"
        select="sum($get_all_debits[entry_id=$this_entry_id]/entry_amount)"/>
        <xsl:variable name="this_entry_credit_total"
        select="sum($get_all_credits[entry_id=$this_entry_id]/entry_amount)"/>
        <xsl:variable name="balanced">
          <xsl:if test="$this_entry_debit_total=$this_entry_credit_total">
            <xsl:text>yes</xsl:text>
          </xsl:if>
        </xsl:variable>
        <xsl:variable name="my_color">
          <xsl:if test="not($this_entry_debit_total=$this_entry_credit_total)">
            <xsl:text>red</xsl:text>
          </xsl:if>
        </xsl:variable>

        <!--  INNER LOOP -->
        <xsl:if test="not($get_all_entry_amounts[entry_id=$this_entry_id]/entry_amount='0.00')">
        <xsl:for-each select="$get_all_entry_amounts[entry_id=$this_entry_id]">
          <xsl:variable name="posi" select="position()"/>
          <tr class="row{$posa}">
            <td colspan="3" class="journal-fill{$posa}" />

            <!--
            These table cells contain the account name and amount for each
            transaction in each entry. If the entry has not yet been posted to the
            general ledger, and the entry is in balance, then a "+" link will be
            displayed. Clicking on the + will make an ajax request to post the
            transaction to the ledger.
            -->
            <td>
            <!--
            All this for the plus sign! Only allow posting of balanced entries
            -->
              <xsl:if test="(not(posted_account_id) or posted_account_id='') and $balanced='yes'">
              <!--
              This make an AJAX request to post the entry to the ledger,
              and then removes the plus sign
              -->
                <div id="{entry_amount_id}" onclick="post_entry({entry_id},{account_id},'{entry_type_id}',{entry_amount_id},{account_type_id}); return false;">
                  <a href="#ledger-create&amp;entry_id={entry_id}&amp;account_id={account_id}&amp;type={entry_type_id}&amp;entry_amount_id={entry_amount_id}&amp;account_type_id={account_type_id}">
                    <div class="journal-post-plus"
                    style="background-image: url({$path_prefix}{/_R_/runtime/icon_set}add.png);"/>
                  </a>
                </div>
            </xsl:if>
            </td>
            <xsl:if test="entry_type_id='Credit'">
              <td align="right">
                <a href="{$link_prefix}ledger&amp;account_id={account_id}">
                  <xsl:value-of select="name"/>
                </a>
              </td>
              <td />
              <td style="color: {$my_color};">
                <xsl:value-of select="entry_amount"/>
              </td>
            </xsl:if>
            <xsl:if test="entry_type_id='Debit'">
              <td>
                <a href="{$link_prefix}ledger&amp;account_id={account_id}">
                  <xsl:value-of select="name"/>
                </a>
              </td>
              <td style="color: {$my_color};">
                <xsl:value-of select="entry_amount"/>
              </td>
              <td />
            </xsl:if>
            <td colspan="2" />

          </tr>
        </xsl:for-each>
        </xsl:if>
        <!-- END INNER LOOP -->
        <tr>
          <td colspan="9" class="separator" />
        </tr>
      </xsl:for-each>
      <!-- END OUTER LOOP -->
    </tbody>
    <xsl:variable name="total_debits"
    select="format-number(sum($get_all_debits/entry_amount),'#######.##')" />
    <xsl:variable name="total_credits"
    select="format-number(sum($get_all_credits/entry_amount),'#######.##')" />

    <!--
    This row shows the total of the credits and the debits, which should be equal.
    If they are unequal, PBooks will complain to the user.
    -->
    <tr>
      <td colspan="5" align="right">
        <xsl:if test="not($total_credits=$total_debits)">
          <div id="error_match">
            FIXME - better error reporting.:
          </div>
        </xsl:if>
      </td>
      <td>
        <xsl:value-of select="$total_debits"/>
      </td>
      <td>
        <xsl:value-of select="$total_credits"/>
      </td>
      <td colspan="2" />
    </tr>
  </table>
  <xsl:call-template name="previous_next"/>

</form>
</div>


  </xsl:template>
</xsl:stylesheet>