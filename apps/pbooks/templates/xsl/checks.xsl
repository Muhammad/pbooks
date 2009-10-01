<!--
Program: PBooks
Component: checks.xsl
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
  <xsl:include href="pager.xsl"/>
  <xsl:template name="content">
    <xsl:param name="link_prefix"/>
    <xsl:param name="path_prefix"/>
    <xsl:param name="i18n"/>


<script type="text/javascript"
src="{$link_prefix}x-tablesorter-setup-js&amp;selector=my_checks" />

<div class="generic-button" style="float: right;">
  <a href="{$link_prefix}check-create">
    <img alt="" src="{$path_prefix}{/_R_/runtime/icon_set}/page_edit.gif"/>
    <span if="i18n-write_check">Write Check</span>
  </a>
</div>

<div class="tableframe">
  <table id="my_checks" class="tablesorter">
    <thead>
      <tr class="i18n">
        <th>
          <span id="i18n-date">Date</span>
        </th>
        <th>
          <span id="i18n-check_number">Check Number</span>
        </th>
        <th>
          <span id="i18n-payee">Payee</span>
        </th>
        <th>
          <span id="i18n-memo">Memorandum</span>
        </th>
        <th>
          <span id="i18n-amount">Amount</span>
        </th>
        <th>
          <span id="i18n-id">ID</span>
        </th>
      </tr>
    </thead>
    <tbody>
      <!-- Start LOOP -->
      <xsl:for-each
      select="/_R_/get_some_business_objects/get_some_business_objects">
        <tr onmouseover="oldClass=this.className; this.className='active'"
        onmouseout="this.className=oldClass">
          <td>
            <xsl:value-of select="entry_datetime"/>
          </td>
          <td>
            <a href="{$link_prefix}check-edit&amp;entry_id={entry_id}">
              <xsl:value-of select="check_number"/>
            </a>
          </td>
          <td>
            <a href="{$link_prefix}check-edit&amp;entry_id={entry_id}">
              <xsl:value-of select="check_payee"/>
            </a>
          </td>
          <td>
            <a href="{$link_prefix}check-edit&amp;entry_id={entry_id}">
              <xsl:value-of select="memorandum"/>
            </a>
          </td>
          <td>
            <a href="{$link_prefix}check-edit&amp;entry_id={entry_id}">
              <xsl:value-of select="entry_amount"/>
            </a>
          </td>
          <td>
            <a href="{$link_prefix}check-edit&amp;entry_id={entry_id}">
              <xsl:value-of select="entry_id"/>
            </a>
          </td>
        </tr>
      </xsl:for-each>
      <!-- END LOOP -->
    </tbody>
  </table>
</div>
<div class="table_controls">
  <xsl:call-template name="pager">
    <xsl:with-param name="my-table">my_checks</xsl:with-param>
  </xsl:call-template>
</div>


  </xsl:template>
</xsl:stylesheet>
