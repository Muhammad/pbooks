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
or write to the Free Software Foundation,Inc., 51 Franklin Street,
Fifth Floor, Boston, MA 02110-1301  USA
-->
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:include href="main.xsl"/>
<xsl:include href="pager.xsl"/>

<xsl:template name="content">
<xsl:call-template name="jquery-setup">
    <xsl:with-param name="my-table">myChecks</xsl:with-param>
    <xsl:with-param name="my-table-div">myChecksDiv</xsl:with-param>
</xsl:call-template>
<div class="generic-button" style="float: right;">
    <a href="{/_R_/runtime/link_prefix}check-create">
    <img style="" src="{/_R_/runtime/path_prefix}{/_R_/runtime/icon_set}/page_edit.gif"/>
    <xsl:value-of select="/_R_/i18n/label[key='write_check']/value"/>
    </a>
</div>

<strong>
    <xsl:value-of select="/_R_/i18n/label[key='recent_checks']/value"/>:
</strong>
<div style="min-height: 400px;" id="myChecksDiv">
<script type="text/javascript">
document.getElementById('myChecksDiv').style.visibility = 'hidden';
</script>
<table id="myChecks" class="tablesorter">
    <thead>
    <tr>
        <th>
            <xsl:value-of select="/_R_/i18n/label[key='id']/value"/>
        </th>
        <th>
            <xsl:value-of select="/_R_/i18n/label[key='check_number']/value"/>
        </th>
        <th>
            <xsl:value-of select="/_R_/i18n/label[key='payee']/value"/>
        </th>
        <th>
            <xsl:value-of select="/_R_/i18n/label[key='memo']/value"/>
        </th>
        <th>
            <xsl:value-of select="/_R_/i18n/label[key='amount']/value"/>
        </th>
        <th>
            <xsl:value-of select="/_R_/i18n/label[key='date']/value"/>
        </th>
    </tr>
    </thead>
    <tbody>
    <!-- Start LOOP -->
    <xsl:for-each select="/_R_/get_some_business_objects/get_some_business_objects">
    <xsl:variable name="my_entry_id"><xsl:value-of select="entry_id"/></xsl:variable>
    <tr onmouseover="oldClass=this.className; this.className='active'" onmouseout="this.className=oldClass">
        <td>
            <a href="{/_R_/runtime/link_prefix}check-edit&amp;entry_id={entry_id}">
            <xsl:value-of select="entry_id"/>
            </a>
        </td>
        <td>
            <xsl:value-of select="check_number"/>
        </td>
        <td>
            <a href="#">
                <xsl:value-of select="check_payee"/>
            </a>
        </td>
        <td>
            <xsl:value-of select="memorandum"/>
        </td>
        <td>
            <xsl:value-of select="entry_amount"/>
        </td>
        <td>
            <xsl:value-of select="entry_datetime"/>
        </td>
    </tr>
    </xsl:for-each>
    <!-- END LOOP -->
    </tbody>
</table>
<xsl:call-template name="pager">
    <xsl:with-param name="my-table">myChecks</xsl:with-param>
</xsl:call-template>
</div>

</xsl:template> 
</xsl:stylesheet>
