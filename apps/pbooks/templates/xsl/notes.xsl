<!--
Program: PBooks
Component: notes.xsl
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
src="{$link_prefix}x-tablesorter-setup-js&amp;selector=notes_table&amp;simple=true" />

<xsl:value-of select="$i18n/note_info"/>
<table class="tablesorter" id="notes_table">
  <thead>
    <tr>
      <th>
        <span id="i18n-note_id">ID</span>
      </th>
      <th>
        <span id="i18n-notes">Notes</span>
      </th>
      <th>
        <span id="i18n-date">Date</span>
      </th>
      <th class="{{sorter: false}}">
      </th>
    </tr>
  </thead>
  <tbody>
    <xsl:for-each select="/_R_/notes_get_all/notes_get_all">
      <tr id="n_{note_id}">
        <td>
          <xsl:value-of select="note_id"/>
        </td>
        <td>
          <xsl:value-of select="note"/>
        </td>
        <td>
          <span class="reldate"><xsl:value-of select="note_rfc_time"/></span>
        </td>
        <td>
          <a href="{$link_prefix}note-edit&amp;note_id={note_id}">Edit</a> / 
          <a href="{$link_prefix}x-note-delete&amp;note_id={note_id}"
          onclick="note_delete({note_id}); return false;">Delete</a> / 
          <a href="#x-note-archive&amp;note_id={note_id}"
          onclick="note_archive({note_id}); return false;">Archive</a>
        </td>
      </tr>
    </xsl:for-each>
  </tbody>
</table>
<br/><br/>
<form method="post">
<input type="text" name="note" id="note_field"/>
<input type="submit"/>
</form>


  </xsl:template>
</xsl:stylesheet>