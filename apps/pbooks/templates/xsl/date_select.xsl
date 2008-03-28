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
<xsl:param name="my_from_date"><xsl:value-of select="//from_date"/></xsl:param>
<xsl:call-template name="calendar-inc"/>
<xsl:variable name="my_uri">
<xsl:if test="__ROOT__/_get/from_date">
<xsl:value-of select="substring-before(__ROOT__/request_uri,'&amp;from_date')"/>
</xsl:if>
<xsl:if test="not(__ROOT__/_get/from_date)">
<xsl:value-of select="//__ROOT__/request_uri"/>
</xsl:if>
</xsl:variable>

<a href="{$my_uri}&amp;from_date={//prev_from_date}&amp;to_date={//prev_to_date}"><img style="padding-right: 5px;" src="images/buttons/out.gif"/></a>
From <input type="text" name="from_date" id="f_date_a" value="{$my_from_date}"/>
To <input type="text" name="to_date" id="f_calcdate" value="{//to_date}"/>&#160;
<a href="{$my_uri}&amp;from_date={//next_from_date}&amp;to_date={//next_to_date}"><img style="padding-right: 5px;" src="images/buttons/in.gif"/></a>
		

<script type="text/javascript">

    Calendar.setup({
        inputField     :    "f_date_a",   // id of the input field
        ifFormat       :    "%Y-%m-%d",       // format of the input field
        showsTime      :    false
    });
    Calendar.setup({
        inputField     :    "f_calcdate",
        ifFormat       :    "%Y-%m-%d",
        showsTime      :    false
    });
</script>

</xsl:template>


<xsl:template name="calendar-inc">
<!-- calendar stylesheet -->
<link rel="stylesheet" type="text/css" media="all" href="{/__ROOT__/runtime/path_prefix}/s/css/calendar-system.css" title="win2k-cold-1" />
<script type="text/javascript" src="{/__ROOT__/runtime/path_prefix}/s/js/calendar.js"></script>
<script type="text/javascript" src="{/__ROOT__/runtime/path_prefix}/s/js/lang/calendar-en.js"></script>
<script type="text/javascript" src="{/__ROOT__/runtime/path_prefix}/s/js/calendar-setup.js"></script>
</xsl:template>
</xsl:stylesheet>