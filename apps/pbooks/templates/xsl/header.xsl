<!--
Program: PBooks
Component: header.xsl
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
Fifth Floor, Boston, MA 02110-1301 USA
-->
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:template name="header">
    <xsl:call-template name="source_spacer">
      <xsl:with-param name="section_start">header</xsl:with-param>
    </xsl:call-template>
    <div id="header">&#160;
    <span id="company-name">
        <xsl:value-of select="//company_name"/>
      </span>
      <h1 class="page-title">
        <xsl:value-of select="/_R_/i18n/label[key=/_R_/_get/nid]/value"/>
      </h1>
    </div>
    <xsl:call-template name="source_spacer">
      <xsl:with-param name="section_end">header</xsl:with-param>
    </xsl:call-template>
  </xsl:template>
</xsl:stylesheet>