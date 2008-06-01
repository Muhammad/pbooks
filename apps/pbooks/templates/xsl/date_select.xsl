<!--
Program: PBooks
Component: date_select.xsl
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
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" >
<xsl:template name="date_select">
<xsl:param name="my_from_date"><xsl:value-of select="/_R_/runtime/from_date"/></xsl:param>
<xsl:variable name="my_uri">
<xsl:if test="/_R_/_get/from_date">
    <xsl:value-of select="substring-before(/_R_/_server/REQUEST_URI,'&amp;from_date')"/>
</xsl:if>
<xsl:if test="not(/_R_/_get/from_date)">
    <xsl:value-of select="/_R_/_server/REQUEST_URI"/>
</xsl:if>
</xsl:variable>
<a href="{$my_uri}&amp;from_date={/_R_/runtime/prev_from_date}&amp;to_date={/_R_/runtime/prev_to_date}">
    <img style="padding-right: 5px;" src="{/_R_/runtime/path_prefix}s/images/buttons/out.gif"/>
</a>

From <input type="text" name="from_date" class="date_input" value="{$my_from_date}"/>

To <input type="text" name="to_date" class="date_input" value="{/_R_/runtime/to_date}"/>

<a href="{$my_uri}&amp;from_date={/_R_/runtime/next_from_date}&amp;to_date={/_R_/runtime/next_to_date}">
    <img style="padding-right: 5px;" src="{/_R_/runtime/path_prefix}s/images/buttons/in.gif"/>
</a>


<script type="text/javascript">

$($.date_input.initialize);

$.extend(DateInput.DEFAULT_OPTS, {
  stringToDate: function(string) {
    var matches;
    if (matches = string.match(/^(\d{4,4})-(\d{2,2})-(\d{2,2})$/)) {
      return new Date(matches[1], matches[2] - 1, matches[3]);
    } else {
      return null;
    };
  },

  dateToString: function(date) {
    var month = (date.getMonth() + 1).toString();
    var dom = date.getDate().toString();
    if (month.length == 1) month = "0" + month;
    if (dom.length == 1) dom = "0" + dom;
    return date.getFullYear() + "-" + month + "-" + dom;
  }
});
</script>

</xsl:template>
</xsl:stylesheet>