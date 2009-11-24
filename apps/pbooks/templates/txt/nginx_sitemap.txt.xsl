<!--
Program: PBooks
Component: sitetest.txt.xsl
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
  xmlns:map="http://www.nexista.org/sitemap">
  <xsl:output method="html" encoding="UTF-8" omit-xml-declaration="yes" />
  <xsl:template match="/">
    <xsl:if test="//_get/type='nginx'">
      <xsl:call-template name="nginx"/>
    </xsl:if>
    <xsl:if test="//_get/type='sinatra'">
      <xsl:call-template name="nginx"/>
    </xsl:if>
  </xsl:template>
  
  
  
  <xsl:template name="nginx">
    <xsl:variable name="proxyhost">192.168.8.48</xsl:variable>
    <xsl:variable name="app_root">/var/www/dev/pbooks/apps/pbooks</xsl:variable>
      <xsl:for-each select="//*[name()='map:gate']">
location /<xsl:value-of select="@name"/> {
  proxy_pass  http://<xsl:value-of select="$proxyhost"/>
  xslt_stylesheet <xsl:value-of select="$app_root"/>/<xsl:value-of select="map:xsl/@src"/>;
}
      </xsl:for-each>
  </xsl:template>
  
  <xsl:template name="sinatra">
require 'xml/libxml'
require 'xml/libxslt'
    <xsl:variable name="proxyhost">192.168.8.48</xsl:variable>
    <xsl:variable name="app_root">/var/www/dev/pbooks/apps/pbooks</xsl:variable>
      <xsl:for-each select="//*[name()='map:gate']">
get /<xsl:value-of select="@name"/> {
  # <xsl:value-of select="map:xml/@src"/>
  xslt_stylesheet <xsl:value-of select="$app_root"/>/<xsl:value-of select="map:xsl/@src"/>;
end
      </xsl:for-each>
  </xsl:template>
  
</xsl:stylesheet>
