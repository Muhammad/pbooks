<!--
Program: PBooks
Component: html_shell.xsl
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
  <xsl:output method="xml" indent="yes" omit-xml-declaration="no"
  doctype-public="-//W3C//DTD XHTML 1.1//EN" encoding="UTF-8"
  doctype-system="http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd" />
  <xsl:strip-space elements="*"/>
  <xsl:template match="/">
    <html>
      <xsl:variable name="link_prefix" select="/_R_/runtime/link_prefix"/>
      <xsl:variable name="path_prefix" select="/_R_/runtime/path_prefix"/>
      <xsl:variable name="my18n"
        select="document('../../i18n/en_US/pbooks.xml')/i18n"/>

      <xsl:call-template name="head">
        <xsl:with-param name="link_prefix" select="$link_prefix"/>
        <xsl:with-param name="path_prefix" select="$path_prefix"/>
      </xsl:call-template>
      <body>
				<xsl:for-each select="//pre_body_content">
					<xsl:sort select="priority" order="ascending"/>
					<xsl:apply-templates select="nodes/*"/>
				</xsl:for-each>

        <xsl:call-template name="main">
          <xsl:with-param name="link_prefix" select="$link_prefix"/>
          <xsl:with-param name="path_prefix" select="$path_prefix"/>
          <xsl:with-param name="i18n" select="$my18n"/>
        </xsl:call-template>

        <xsl:for-each select="//footer_nodes">
          <xsl:sort select="priority" order="ascending"/>
          <xsl:apply-templates select="nodes/*"/>
        </xsl:for-each>
      </body>
    </html>
  </xsl:template>


	<xsl:template name="head">
		<xsl:param name="link_prefix"/>
		<xsl:param name="path_prefix"/>
		<head>
			<title>
				<xsl:value-of select="/_R_/i18n/default_page_title"/>: 
        <xsl:value-of select="/_R_/i18n/*[name()=/_R_/_get/nid]"/>
			</title>
      <link rel="stylesheet" type="text/css" href="http://yui.yahooapis.com/combo?2.7.0/build/reset/reset-min.css"/>
			<link rel="stylesheet" type="text/css" href="{$link_prefix}x-dynamic-css"></link>
			<script type="text/javascript" src="{$path_prefix}s/js/jquery/jquery-1.3.2.js"/>
			<script type="text/javascript" src="{$path_prefix}s/js/jquery/plugins/jquery.cookiejar.js"/>
			<script type="text/javascript" src="{$path_prefix}s/js/jquery/plugins/jquery.accordion.js"/>
			<script type="text/javascript" src="{$path_prefix}s/pkgs/tablesorter/jquery.tablesorter.min.js"/>
			<script type="text/javascript" src="{$path_prefix}s/pkgs/tablesorter/jquery.metadata.js"/>
			<script type="text/javascript" src="{$path_prefix}s/pkgs/tablesorter/addons/pager/jquery.tablesorter.pager.js"/>
			<script type="text/javascript" src="{$path_prefix}s/js/jquery/plugins/jquery.dimensions.js"/>
			<script type="text/javascript" src="{$path_prefix}s/js/jquery/plugins/jquery.date_input.js"/>
			<script type="text/javascript" src="{$path_prefix}s/js/jquery/plugins/jquery.cookie.js"/>
			<script type="text/javascript" src="{$path_prefix}s/js/jquery/plugins/jquery.json.js"/>
			<script type="text/javascript" src="{$path_prefix}s/js/jquery/plugins/jquery.tablesorter.cookie.js"/>
			<script type="text/javascript" src="{$path_prefix}s/js/jquery/plugins/thickbox.js"/>
			<script type="text/javascript" src="{$path_prefix}s/js/jquery/plugins/jquery.calculation.min.js"/>
			<script type="text/javascript" src="{$path_prefix}s/js/time/relative_time.js"/>
			<link rel="stylesheet" type="text/css" href="{$path_prefix}s/js/blue/style.css" />
			<link rel="stylesheet" type="text/css" href="{$path_prefix}s/css/thickbox.css"></link>
			<link rel="stylesheet" type="text/css" href="{$path_prefix}s/css/date_input.css"></link>
			<script type="text/javascript" src="{$path_prefix}s/js/jsval.js"/>
			<script type="text/javascript" src="{$link_prefix}x-common-js"/>
			<script type="text/javascript" src="{$link_prefix}x-xhtml2dom-js"/>
			<script type="text/javascript" src="{$path_prefix}s/js/document_ready.js"/>
      <xsl:for-each select="//head_nodes">
				<xsl:sort select="priority" order="ascending"/>
				<xsl:apply-templates select="nodes/*"/>
			</xsl:for-each>
		</head>
	</xsl:template>

  <xsl:template name="header">
    <xsl:param name="link_prefix"/>
    <xsl:param name="i18n"/>
    <xsl:call-template name="source_spacer">
      <xsl:with-param name="section_start">header</xsl:with-param>
    </xsl:call-template>
    <div id="header">
      <div style="float:right;margin: 4px;">
        <form action="index.php" method="get">
          <input type="hidden" name="nid" value="journal-search" />
          <input type="text" name="entry_search" />
          <input type="submit" />
        </form>
      </div>
    	<span id="company-name">
        <xsl:value-of select="//runtime/company_name"/>
      </span>
      <h1 class="page-title">
        <xsl:value-of select="/_R_/i18n/*[name()=/_R_/_get/nid]"/>
      </h1>
    </div>

    <xsl:call-template name="source_spacer">
      <xsl:with-param name="section_end">header</xsl:with-param>
    </xsl:call-template>
  </xsl:template>

	<xsl:template name="body">
		<xsl:param name="link_prefix"/>
		<xsl:param name="path_prefix"/>
		<xsl:param name="i18n"/>

		<xsl:if test="not(/_R_/_get/print='true') and not(/_R_/got_print='true')">
			<xsl:call-template name="source_spacer">
				<xsl:with-param name="section_start">main</xsl:with-param>
			</xsl:call-template>
			<div id="main">
				<div id="leftcol">
					<div id="primary_logo">
						<div id="primary_logo_span">
							<a href="{$link_prefix}index">
								<img src="{/_R_/runtime/top_left_logo}" alt="PBooks Logo"/>
							</a>
						</div>
					</div>
					<xsl:if test="not(/_R_/_get/nid='login') and not(/_R_/_get/nid='logout') and not(/_R_/_get/nid='development-data-generator') and not(contains(/_R_/_get/nid,'user')) and not(/_R_/_get/nid='group') and not(/_R_/_get/nid='group/edit') and not(contains(/_R_/_get/nid,'role'))">
						<xsl:call-template name="main-menu"/>
					</xsl:if>
				</div>

				<xsl:call-template name="header">
					<xsl:with-param name="i18n" select="$i18n"/>
					<xsl:with-param name="link_prefix" select="$link_prefix"/>
				</xsl:call-template>
				<div id="content">
					<div id="notitle"/>
          <div id="date_controls">
            <span id="dc1" onclick="$('#date_controller').hide();">Hide</span>
            <span id="dc2" onclick="$('#date_controller').show();
            $('input[name=nid]').val('{/_R_/_get/nid}');
            $('#dc25').attr('href','{$link_prefix}{/_R_/_get/nid}'+$('#dc25').attr('href'));
            $('#dc29').attr('href','{$link_prefix}{/_R_/_get/nid}'+$('#dc29').attr('href'));
            init_date_input();">Show</span>
            <span id="dc3">
              <xsl:value-of select="substring(/_R_/runtime/from_date,0,11)"/>
            </span>- 
            <span id="dc3b">
              <xsl:value-of select="substring(/_R_/runtime/to_date,0,11)"/>
            </span>
            <div id="nodate"/>
          </div>
					<xsl:call-template name="content">
						<xsl:with-param name="link_prefix" select="$link_prefix"/>
						<xsl:with-param name="path_prefix" select="$path_prefix"/>
						<xsl:with-param name="i18n" select="$i18n"/>
					</xsl:call-template>
				</div>
        <div id="nofooter"/>
			</div>
			<xsl:call-template name="source_spacer">
				<xsl:with-param name="section_end">main</xsl:with-param>
			</xsl:call-template>
		</xsl:if>

		<xsl:if test="/_R_/_get/print='true' or /_R_/got_print='true'">
			<div style="padding: 20px; width: 600px;">
				<xsl:call-template name="content">
					<xsl:with-param name="link_prefix" select="$link_prefix"/>
					<xsl:with-param name="path_prefix" select="$path_prefix"/>
					<xsl:with-param name="i18n" select="$i18n"/>
				</xsl:call-template>
			</div>
		</xsl:if>
	</xsl:template>



  <xsl:template name="main-menu">
		<xsl:param name="link_prefix"/>
		<xsl:param name="path_prefix"/>
		<xsl:param name="i18n"/>
    <xsl:call-template name="source_spacer">
      <xsl:with-param name="section_start">table-menu</xsl:with-param>
    </xsl:call-template>
    <xsl:call-template name="accordian-menu">
		</xsl:call-template>
    <xsl:call-template name="source_spacer">
      <xsl:with-param name="section_end">table-menu</xsl:with-param>
    </xsl:call-template>
  </xsl:template>

<!-- Original vertical table menu -->
<!-- Should work with all browsers -->
  <xsl:template name="table-menu">

    <table>
      <xsl:for-each select="/_R_/menu/item[not(@active=0)]">
        <xsl:call-template name="button">
          <xsl:with-param name="key" select="key"/>
          <xsl:with-param name="target" select="url"/>
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
      <xsl:variable name="my_key" select="key"/>
      <tr>
        <td class="menu-sub"
					onclick="window.location.href='{//runtime/link_prefix}{url}';">
          <a href="{/_R_/runtime/link_prefix}{url}" id="{key}">
            <xsl:if test="//show_tool_tips='yes'">
              <xsl:attribute name="title" select="/_R_/i18n/label[key=$key]/description"/>
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
    <ul id="accordion-menu">
      <xsl:for-each select="//menu/item[not(@active=0)]">
        <xsl:call-template name="list-button">
          <xsl:with-param name="key" select="key"/>
        </xsl:call-template>
      </xsl:for-each>
    </ul>

    <xsl:call-template name="source_spacer">
      <xsl:with-param name="section_end">accordian-menu</xsl:with-param>
    </xsl:call-template>
  </xsl:template>

	<!-- Alternative horizontal drop down menus -->
  <xsl:template name="horizontal-menu">
    <xsl:call-template name="source_spacer">
      <xsl:with-param name="section_start">main-menu</xsl:with-param>
    </xsl:call-template>
    <script type="text/javascript">
    $(document).ready(function()
    {
        $('#nav').droppy();
    });
    </script>
    <ul id="nav">
      <xsl:for-each select="//menu/item[not(@active=0)]">
        <xsl:call-template name="list-button">
          <xsl:with-param name="key" select="key"/>
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
        <xsl:value-of select="/_R_/i18n/*[name()=$key]"/>
      </a>
      <ul>
        <xsl:for-each select="//menu/item[key=$key]/item">
          <xsl:variable name="my_key" select="key"/>
          <li>
            <a href="{//runtime/link_prefix}{url}" id="{key}">
              <xsl:value-of select="/_R_/i18n/*[name()=$my_key]"/>
            </a>
          </li>
        </xsl:for-each>
      </ul>
    </li>
  </xsl:template>



</xsl:stylesheet>