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
or write to the Free Software Foundation,Inc., 51 Franklin Street,
Fifth Floor, Boston, MA 02110-1301  USA
-->
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:include href="main.xsl"/>
  <xsl:include href="date_select.xsl"/>
  <xsl:include href="prev_next.xsl"/>
  <xsl:template name="content">
<!-- POST JOURNAL ENTRY TO LEDGER -->
    <script type="text/javascript" src="{/_R_/runtime/path_prefix}s/js/jquery.js">&#160;</script>
    <script type="text/javascript">
    function post_entry(entry_id,account_id,entry_type_id,entry_amount_id,account_type_id) {
        $.post("<xsl:value-of select="/_R_/runtime/link_prefix"/>ledger-create",
        {
          'entry_id': entry_id,
          'account_id': account_id,
          'type': entry_type_id,
          'entry_amount_id': entry_amount_id,
          'account_type_id': account_type_id
        },
        function (data){
          document.getElementById(entry_amount_id).innerHTML="";
        });
        document.getElementById(entry_amount_id).innerHTML="";
    }
    </script>
    <table width="100%">
      <tr>
        <td>
          <form action="{/_R_/runtime/link_prefix}journal" method="get">
            <input type="hidden" name="nid" value="{/_R_/_get/nid}"/>
            <xsl:call-template name="date_select"/>
            <input type="submit"/>
          </form>
        </td>
        <td align="right">
          <xsl:call-template name="previous_next"/>
        </td>
      </tr>
    </table>
    <form action="{_R_/runtime/link_prefix}journal-delete" method="post">
<!-- this is the table of journal entries. we don't use the tablesorter here 
because of the dynamic number of rows per entry. -->
      <table class="journal-table">
        <thead>
          <tr>
            <th></th>
            <th>
              <xsl:value-of select="/_R_/i18n/label[key='id']/value"/>
            </th>
            <th>
              <xsl:value-of select="/_R_/i18n/label[key='date']/value"/>
            </th>
            <th></th>
            <th width="200">
              <xsl:value-of select="/_R_/i18n/label[key='memo']/value"/>.</th>
            <th width="15"></th>
            <th>
              <xsl:value-of select="/_R_/i18n/label[key='accounts']/value"/>
            </th>
            <th>
              <xsl:value-of select="/_R_/i18n/label[key='debit']/value"/>
            </th>
            <th>
              <xsl:value-of select="/_R_/i18n/label[key='credit']/value"/>
            </th>
          </tr>
        </thead>
        <tbody>
    <!-- each journal entry is comprised of the entry itself, plus several entry amounts and accounts which are descendent from it. 
    The outer loop goes through each entry, and the inner loop iterates through each entry amount. -->
          <xsl:variable name="my_link_prefix">
            <xsl:value-of select="/_R_/runtime/link_prefix"/>
          </xsl:variable>

    <!-- OUTER LOOP -->
          <xsl:for-each select="/_R_/get_all_entries/get_all_entries">
            <xsl:variable name="this_entry_id">
              <xsl:value-of select="entry_id"/>
            </xsl:variable>
            <xsl:variable name="posa">
              <xsl:value-of select="position() mod 2"/>
            </xsl:variable>
            <tr class="row2">
              <td valign="top" class="journal-data">
                <input type="checkbox" name="entry_id[]" value="{entry_id}"/>
              </td>
				
              <td valign="top" class="journal-data">
                <a href="{$my_link_prefix}journal-entry&amp;entry_id={entry_id}">
                  <xsl:value-of select="entry_id"/>
                </a>
              </td>

              <td valign="top" class="journal-data">
                <xsl:value-of select="entry_datetime"/>
              </td>

              <td class="journal-data"></td>
              <td valign="top" class="journal-data" colspan="5" width="100%">
                <a href="{$my_link_prefix}journal-entry&amp;entry_id={entry_id}">
                  <xsl:value-of select="memorandum"/>
                </a>
              </td>
            </tr>

     <!-- These variables are used inside the loop to select specific nodes using xpath -->
            <xsl:variable name="this_entry_debit_total">
              <xsl:value-of select="sum(//get_all_entry_amounts/get_all_entry_amounts[entry_id=$this_entry_id][entry_type_id='Debit']/entry_amount)"/>
            </xsl:variable>
            <xsl:variable name="this_entry_credit_total">
              <xsl:value-of select="sum(//get_all_entry_amounts/get_all_entry_amounts[entry_id=$this_entry_id][entry_type_id='Credit']/entry_amount)"/>
            </xsl:variable>
            <xsl:variable name="balanced">
              <xsl:if test="$this_entry_debit_total=$this_entry_credit_total">yes</xsl:if>
            </xsl:variable>
            <xsl:variable name="my_color">
              <xsl:if test="not($this_entry_debit_total=$this_entry_credit_total)">red</xsl:if>
            </xsl:variable>
   <!--  INNER LOOP -->
            <xsl:for-each select="/_R_/get_all_entry_amounts/get_all_entry_amounts[entry_id=$this_entry_id]">
              <xsl:variable name="posi">
                <xsl:value-of select="position()"/>
              </xsl:variable>
              <tr class="row{$posa}">
                <td colspan="5" class="row{$posa}"></td>

 <!-- 
     These table cells contain the account name and amount for each 
     transaction in each entry. If the entry has not yet been posted to the 
     general ledger, and the entry is in balance, then a "+" link will be 
     displayed. Clicking on the + will make an ajax request to post the 
     transaction to the ledger.
    -->
                <td>
        <!-- All this for the plus sign! -->
                  <xsl:if test="not(posted_account_id) or posted_account_id=''">
            <!-- Only allow posting of balanced entries-->
                    <xsl:if test="$balanced='yes'">
            <!-- This make an AJAX request to post the entry to the ledger, and then removes the plus sign -->
                      <div id="{entry_amount_id}">
                        <a
                            href="{$my_link_prefix}ledger-post&amp;entry_id={entry_id}&amp;account_id={account_id}&amp;type={entry_type_id}&amp;entry_amount_id={entry_amount_id}&amp;account_type_id={account_type_id}"
                            onclick="post_entry({entry_id},{account_id},'{entry_type_id}',{entry_amount_id},{account_type_id}); return false;">
                          <div class="journal-post-plus" style="background-image: url({/_R_/runtime/path_prefix}{/_R_/runtime/icon_set}add.png);">&#160;</div>
                        </a>
                      </div>
                    </xsl:if>
                  </xsl:if>
                </td>
                <xsl:if test="entry_type_id='Credit'">
                  <td class="journal-data">
                    <xsl:attribute name="align">right</xsl:attribute>
                    <a href="{$my_link_prefix}ledger&amp;account_id={account_id}">
                      <xsl:value-of select="name"/>
                    </a>
                  </td>
                  <td class="journal-data"></td>
                  <td class="journal-data" style="color: {$my_color};">
                    <xsl:value-of select="entry_amount"/>
                  </td>
                </xsl:if>
                <xsl:if test="entry_type_id='Debit'">
                  <td class="journal-data">
                    <a href="{$my_link_prefix}ledger&amp;account_id={account_id}">
                      <xsl:value-of select="name"/>
                    </a>
                  </td>
                  <td class="journal-data">
                    <xsl:attribute name="style">color: <xsl:value-of select="$my_color"/>;</xsl:attribute>
                    <xsl:value-of select="entry_amount"/>
                  </td>
                  <td class="journal-data">&#160;</td>
                </xsl:if>
		
              </tr>
            </xsl:for-each>
    <!-- END INNER LOOP -->
            <tr>
              <td colspan="9" class="separator"></td>
            </tr>
          </xsl:for-each>
     <!-- END OUTER LOOP -->
        </tbody>
        <xsl:variable name="total_debits">
          <xsl:value-of
              select="format-number(sum(/_R_/get_all_entry_amounts[entry_type_id='Debit']/entry_amount),'#######.##')"/>
        </xsl:variable>
        <xsl:variable name="total_credits">
          <xsl:value-of
              select="format-number(sum(/_R_/get_all_entry_amounts[entry_type_id='Credit']/entry_amount),'#######.##')"/>
        </xsl:variable>
        <tr>
          <td colspan="9">
            <hr/>
          </td>
        </tr>

    <!-- This row shows the total of the credits and the debits, which should be equal. If they are unequal, PBooks will complain to the user. -->
        <tr>
          <td colspan="7" align="right">
            <xsl:if test="not($total_credits=$total_debits)">
              <div style="color: red;" id="error_match">
                <xsl:value-of select="/_R_/i18n/label[key='error_match']/value"/>:
                </div>
            </xsl:if>
          </td>
          <td class="journal-data">
            <xsl:value-of select="$total_debits"/>
          </td>
          <td class="journal-data">
            <xsl:value-of select="$total_credits"/>
          </td>
        </tr>
      </table>
      <xsl:call-template name="previous_next"/>

<!-- only display the form controls for the journal, not other pages which use this template -->
      <xsl:if test="/_R_/_get/nid='journal'">
        <input type="button" id="new_entry_button" value="{/_R_/i18n/label[key='new_entry']/value}"
            onclick="document.location.href='{/_R_/runtime/link_prefix}journal-new'"/>
    <!-- Delete selected entries 
    TODO - only display this function in training mode -->
        <input type="submit" value="{/_R_/i18n/label[key='delete_entries']/value}"
            onclick="return confirm('Are you sure you want to delete these entries?')"/>
      </xsl:if>
    </form>
  </xsl:template>
</xsl:stylesheet>