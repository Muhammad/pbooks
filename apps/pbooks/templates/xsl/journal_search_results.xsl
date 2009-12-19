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
  <xsl:template name="content">
    <xsl:param name="link_prefix"/>
    <xsl:param name="path_prefix"/>


<table class="tablesorter" id="notes_table">
  <thead>
    <tr>
      <th>
      </th>
      <th>
      </th>
      <th>
      </th>
      <th>
      </th>
    </tr>
  </thead>
  <tbody>
    <xsl:for-each select="/_R_/get_journal_entry/get_journal_entry">
      <tr id="e_{entry_id}"
      onclick="location.href='{$link_prefix}journal-entry&amp;entry_id={entry_id}'">
        <td>
          <xsl:value-of select="entry_id"/>
        </td>
        <td>
          <xsl:value-of select="memorandum"/>
        </td>
        <td>
          <xsl:value-of select="entry_datetime"/>
        </td>
        <td>
          <a href="{$link_prefix}journal-entry&amp;entry_id={entry_id}">View</a>
        </td>
      </tr>
    </xsl:for-each>
  </tbody>
</table>


  </xsl:template>
</xsl:stylesheet>