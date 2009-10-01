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
  <xsl:output method="xml" indent="yes" encoding="UTF-8"
    omit-xml-declaration="no"
		doctype-system="http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd"
		doctype-public="-//W3C//DTD XHTML 1.1//EN"/>
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
    <xsl:param name="i18n"/>
    <xsl:call-template name="source_spacer">
      <xsl:with-param name="section_start">header</xsl:with-param>
    </xsl:call-template>
    <div id="header">&#160;
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
						<xsl:call-template name="accounting-menu"/>
					</xsl:if>
				</div>

				<xsl:call-template name="header">
					<xsl:with-param name="i18n" select="$i18n"/>
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

  <xsl:template match="node()">
    <xsl:element name="{name()}">
      <xsl:apply-templates select="@*|node()"/>
    </xsl:element>
  </xsl:template>
  
  <xsl:template match="@*|text()|comment()|processing-instruction()">
    <xsl:copy/>
  </xsl:template>

</xsl:stylesheet>