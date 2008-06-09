<!--
Program: PBooks
Component: accounting_menu.xsl
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





  <xsl:template name="accounting-menu">
    <xsl:call-template name="source_spacer">
      <xsl:with-param name="section_start">table-menu</xsl:with-param>
    </xsl:call-template>
    <xsl:call-template name="accordian-menu"/>
    <xsl:call-template name="source_spacer">
      <xsl:with-param name="section_end">table-menu</xsl:with-param>
    </xsl:call-template>
  </xsl:template>


<!-- Original vertical table menu -->
<!-- Should work with all browsers -->
  <xsl:template name="table-menu">


    <table cellpadding="0" cellspacing="0" border="0" width="{//left_column/width}">


      <xsl:for-each select="/_R_/menu/item[not(@active=0)]">
        <xsl:call-template name="button">
          <xsl:with-param name="key">
            <xsl:value-of select="key"/>
          </xsl:with-param>
          <xsl:with-param name="target">
            <xsl:value-of select="url"/>
          </xsl:with-param>
        </xsl:call-template>
      </xsl:for-each>


    </table>
  </xsl:template>
<!-- table menu buttons -->
  <xsl:template name="button">
    <xsl:param name="key"/>
    <tr>
      <td class="menu-sub-selected">
        <xsl:value-of select="/_R_/i18n/label[key=$key]/value"/>
      </td>
    </tr>
    <xsl:for-each select="//menu/item[key=$key]/item">
      <xsl:variable name="my_key">
        <xsl:value-of select="key"/>
      </xsl:variable>
      <tr>
        <td class="menu-sub" onclick="window.location.href='{//runtime/link_prefix}{url}';">
          <a href="{/_R_/runtime/link_prefix}{url}" id="{key}">
            <xsl:if test="//show_tool_tips='yes'">
              <xsl:attribute name="title">
                <xsl:value-of select="/_R_/i18n/label[key=$key]/description"/>
              </xsl:attribute>
            </xsl:if>
            <xsl:value-of select="/_R_/i18n/label[key=$my_key]/value"/>
          </a>
        </td>
      </tr>
    </xsl:for-each>
  </xsl:template>

<!-- Alternative vertical accordian menus -->
  <xsl:template name="accordian-menu">
    <xsl:call-template name="source_spacer">
      <xsl:with-param name="section_start">accordian-menu</xsl:with-param>
    </xsl:call-template>
    <script type="text/javascript">
    $().ready(function(){
      $('#accordion-menu').accordion({
          active: false,
          header: '.head',
          navigation: true,
          autoheight: false
      });
    });
    </script>
    <ul id="accordion-menu">
      <xsl:for-each select="//menu/item[not(@active=0)]">
        <xsl:call-template name="list-button">
          <xsl:with-param name="key">
            <xsl:value-of select="key"/>
          </xsl:with-param>
        </xsl:call-template>
      </xsl:for-each>
    </ul>

    <xsl:call-template name="source_spacer">
      <xsl:with-param name="section_end">accordian-menu</xsl:with-param>
    </xsl:call-template>
  </xsl:template>




<!-- Alternative horizontal drop down menus -->
  <xsl:template name="main-menu">
    <xsl:call-template name="source_spacer">
      <xsl:with-param name="section_start">main-menu</xsl:with-param>
    </xsl:call-template>
    <script type="text/javascript">
    $(document).ready(function()
    {
        $('#top-main-menu').clickMenu();
    });
    </script>
    <ul id="top-main-menu">
      <xsl:for-each select="//menu/item[not(@active=0)]">
        <xsl:call-template name="list-button">
          <xsl:with-param name="key">
            <xsl:value-of select="key"/>
          </xsl:with-param>
        </xsl:call-template>
      </xsl:for-each>
    </ul>

    <xsl:call-template name="source_spacer">
      <xsl:with-param name="section_end">main-menu</xsl:with-param>
    </xsl:call-template>
  </xsl:template>

  <xsl:template name="list-button">
    <xsl:param name="key"/>
    <li>
      <a href="#" class="head">
        <xsl:value-of select="/_R_/i18n/label[key=$key]/value"/>
      </a>
      <ul>
        <xsl:for-each select="//menu/item[key=$key]/item">
          <xsl:variable name="my_key">
            <xsl:value-of select="key"/>
          </xsl:variable>
          <li>
            <a href="{//runtime/link_prefix}{url}" id="{key}">
              <xsl:value-of select="/_R_/i18n/label[key=$my_key]/value"/>
            </a>
          </li>
        </xsl:for-each>
      </ul>
    </li>
  </xsl:template>
</xsl:stylesheet>