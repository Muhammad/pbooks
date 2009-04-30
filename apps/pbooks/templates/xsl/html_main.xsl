<!--
Program: PBooks
Component: main.xsl
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
	<xsl:include href="html_shell.xsl"/>
	<xsl:include href="html_head.xsl"/>
	<xsl:include href="html_header.xsl"/>
	<xsl:include href="html_menu.xsl"/>
	<xsl:include href="date_select_new.xsl"/>
	<xsl:include href="source_spacer.xsl"/>
	<xsl:template name="main">
		<xsl:param name="link_prefix"/>
		<xsl:param name="path_prefix"/>
		<xsl:param name="i18n"/>

		<xsl:if test="not(/_R_/_get/print='true')">
			<xsl:call-template name="source_spacer">
				<xsl:with-param name="section_start">main</xsl:with-param>
			</xsl:call-template>
			<div id="main">
				<div id="leftcol">
					<div id="primary_logo">
						<div id="primary_logo_span">
							<a href="{$link_prefix}welcome">
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
          <div id="nodate"/>
					<xsl:call-template name="date_select_new">
						<xsl:with-param name="link_prefix" select="$link_prefix"/>
						<xsl:with-param name="path_prefix" select="$path_prefix"/>
						<xsl:with-param name="i18n" select="$i18n"/>
					</xsl:call-template>
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

		<xsl:if test="/_R_/_get/print='true'">
			<div style="padding: 20px; width: 600px;">
				<xsl:call-template name="content">
					<xsl:with-param name="link_prefix" select="$link_prefix"/>
					<xsl:with-param name="path_prefix" select="$path_prefix"/>
					<xsl:with-param name="i18n" select="$i18n"/>
				</xsl:call-template>
			</div>
		</xsl:if>
	</xsl:template>
</xsl:stylesheet>