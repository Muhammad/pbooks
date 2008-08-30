<!--
Program: PBooks
Component: xml-sitemap.xml
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
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:map="http://www.nexista.com/sitemap">
  <xsl:output method="xml" indent="yes" encoding="UTF-8" omit-xml-declaration="no" />
  <xsl:template match="/">
    <urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">
      <xsl:for-each select="//map:gate">
        <url>
          <loc>http://<xsl:value-of select="//runtime/host_name"/>
            <xsl:value-of select="//runtime/link_prefix"/>
            <xsl:value-of select="@name"/>
          </loc>
          <lastmod>
            <xsl:value-of select="substring(//last_db_update,0,11)"/>
          </lastmod>
          <changefreq>daily</changefreq>
        </url>
      </xsl:for-each>
    </urlset>
  </xsl:template>
</xsl:stylesheet>
