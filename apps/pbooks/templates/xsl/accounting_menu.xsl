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
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" >
<xsl:template name="accounting-menu">
  <table cellpadding="0" cellspacing="0" border="0" width="120">
        <tr>
            <td class="menu-sub-sub-selected">
            <a href="{/__ROOT__/runtime/link_prefix}welcome"><xsl:value-of select="/__ROOT__/i18n/labels/label[key='main_menu']/value"/></a>
            </td>
        </tr>
        <!--  MAIN -->
        <xsl:for-each select="//navigation/main_menu/button[@status='active']">
            <xsl:call-template name="button">
                <xsl:with-param name="key"><xsl:value-of select="."/></xsl:with-param>
                <xsl:with-param name="target"><xsl:value-of select="@target"/></xsl:with-param>
            </xsl:call-template>
        </xsl:for-each>


        <!-- ACTIVITIES -->
        <tr><td class="menu-sub-sub-selected"><xsl:value-of select="/__ROOT__/i18n/labels/label[key='activities']/value"/></td></tr>
        <xsl:for-each select="//navigation/activities/button[@status='active']">
            <xsl:call-template name="button">
                <xsl:with-param name="key"><xsl:value-of select="."/></xsl:with-param>
                <xsl:with-param name="target"><xsl:value-of select="@target"/></xsl:with-param>
            </xsl:call-template>
        </xsl:for-each>


        <!-- BUSINESS PROCESS SUB-MENU -->
        <tr><td class="menu-sub-sub-selected"><xsl:value-of select="/__ROOT__/i18n/labels/label[key='business']/value"/></td></tr>
        <xsl:for-each select="//navigation/business/button[@status='active']">
            <xsl:call-template name="button">
                <xsl:with-param name="key"><xsl:value-of select="."/></xsl:with-param>
                <xsl:with-param name="target"><xsl:value-of select="@target"/></xsl:with-param>
            </xsl:call-template>
        </xsl:for-each>


        <!-- SETUP -->
        <tr><td class="menu-sub-sub-selected"><xsl:value-of select="/__ROOT__/i18n/labels/label[key='setup']/value"/></td></tr>
        <xsl:for-each select="//navigation/setup/button[@status='active']">
            <xsl:call-template name="button">
                <xsl:with-param name="key"><xsl:value-of select="."/></xsl:with-param>
                <xsl:with-param name="target"><xsl:value-of select="@target"/></xsl:with-param>
            </xsl:call-template>
        </xsl:for-each>
        
        <tr><td class="menu-sub-sub-selected">Sessions</td></tr>
        <tr><td class="menu-sub"><a href="{/__ROOT__/runtime/link_prefix}logout">Logout</a></td></tr>
    </table>
</xsl:template>

<xsl:template name="button">
    <xsl:param name="key"/> 
    <xsl:param name="target"/> 
    <tr>
        <td class="menu-sub">
            <a href="{/__ROOT__/runtime/link_prefix}{$target}" id="{$key}">
            <xsl:if test="//show_tool_tips='yes'"><xsl:attribute name="title"><xsl:value-of select="/__ROOT__/i18n/labels/label[key=$key]/description" /></xsl:attribute></xsl:if>
            <xsl:value-of select="/__ROOT__/i18n/labels/label[key=$key]/value"/>
            </a>
        </td>
    </tr>
</xsl:template>
</xsl:stylesheet>