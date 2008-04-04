<!--
Program: PBooks
Component: account_groups_xml.xsl
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
<xsl:output method="xml" indent="yes" encoding="UTF-8" 
	omit-xml-declaration="yes"/>
<xsl:template match="/">
    <groups>
    <xsl:if test="//_get/id">    
    <xsl:apply-templates mode="unique_only_id" select="/__ROOT__/get_account_groups"/>
    </xsl:if>
    
    <xsl:if test="not(//_get/id)">
    <xsl:apply-templates mode="normal" select="/__ROOT__/get_account_groups[not(id=//__ROOT__/get_account_group_family_tree/account_group_id)]"/>
    </xsl:if>
    
</groups> 

</xsl:template>

<xsl:template match="/__ROOT__/get_account_groups">
    <xsl:param name="parent_gid">0</xsl:param>
    <xsl:param name="generation">0</xsl:param>
    <xsl:variable name="my_group_id"><xsl:value-of select="id"/></xsl:variable>
    <xsl:variable name="my_link_prefix"><xsl:value-of select="/__ROOT__/runtime/link_prefix"/></xsl:variable>
	
		<group>
            <group_id><xsl:value-of select="id"/></group_id>
		    <name>
        <xsl:value-of select="name"/></name>
    <xsl:apply-templates select="/__ROOT__/get_account_groups[(id=/__ROOT__/get_account_group_family_tree[parent_group_id=$my_group_id]/account_group_id)]">
    <xsl:with-param name="parent_gid"><xsl:value-of select="$my_group_id"/></xsl:with-param>
    <xsl:with-param name="generation"><xsl:value-of select="$generation+1"/></xsl:with-param></xsl:apply-templates>
	</group>  
</xsl:template>

<xsl:template match="/__ROOT__/get_account_groups" mode="normal">
    <xsl:param name="parent_gid">0</xsl:param>
    <xsl:param name="generation">0</xsl:param>
    <xsl:variable name="my_group_id"><xsl:value-of select="id"/></xsl:variable>
    <xsl:variable name="my_link_prefix"><xsl:value-of select="/__ROOT__/runtime/link_prefix"/></xsl:variable>
	
		<group>
            <group_id><xsl:value-of select="id"/></group_id>
		    <name>
        <xsl:value-of select="name"/></name>
    <xsl:apply-templates mode="normal" select="/__ROOT__/get_account_groups[(id=/__ROOT__/get_account_group_family_tree[parent_group_id=$my_group_id]/account_group_id)]">
    <xsl:with-param name="parent_gid"><xsl:value-of select="$my_group_id"/></xsl:with-param>
    <xsl:with-param name="generation"><xsl:value-of select="$generation+1"/></xsl:with-param></xsl:apply-templates>
	</group>  
</xsl:template>





<xsl:template match="//get_account_groups" mode="unique_only_id">
    <xsl:param name="parent_gid">0</xsl:param>
    <xsl:variable name="my_group_id"><xsl:value-of select="id"/></xsl:variable>
    <xsl:choose>
    <xsl:when test="(id=//_get/id)">
        <group_id><xsl:value-of select="id"/></group_id>
    </xsl:when>
    <xsl:when test="(
    id=/__ROOT__/get_account_group_family_tree[parent_group_id=//_get/id]/account_group_id)">
        <group_id><xsl:value-of select="id"/></group_id></xsl:when>
    <xsl:when test="(
    id=/__ROOT__/get_account_group_family_tree[account_group_id=$parent_gid]/parent_group_id)">
        <group_id><xsl:value-of select="id"/></group_id></xsl:when>
    <xsl:otherwise>
    
    
    </xsl:otherwise>
    </xsl:choose>

</xsl:template>
</xsl:stylesheet>