<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="html" indent="yes" encoding="UTF-8" omit-xml-declaration="no" doctype-public="-//W3C//DTD HTML 4.01 Transitional//EN"
doctype-system="http://www.w3.org/TR/html4/loose.dtd"/>
<xsl:template match="/">
<html>
<head>
	 <title><xsl:value-of select="/__ROOT__/i18n/titles/title[key='default_page_title']/value"/></title>
     <meta name="generator" content="Nexista 1.1" /> 
     <link rel="stylesheet" type="text/css" href="css/pbooks-1.css" ></link>
     <!-- xsl:value-of select="/__ROOT__/runtime/head_includes"/> -->
</head>
<body>
<div id="container">
<div id="capsule">
<div id="leftcol">
    <a href="index.php?nid=welcome"><img src="{/__ROOT__/runtime/top_left_logo}" border="0" alt="PBooks Logo"/></a>
    <xsl:if test="not(//_get/nid='login') 
    and not(//_get/nid='logout') 
    and not(//_get/nid='development-data-generator') 
    and not(contains(//_get/nid,'user'))
    and not(//_get/nid='group')
    and not(//_get/nid='group/edit')
    and not(contains(//_get/nid,'role'))">
    <xsl:call-template name="accounting-menu"/>
    </xsl:if>
</div>
<div id="header">
    <div id="top-block">&#160;
    
        <div id="company-name"><xsl:value-of select="//company_name"/></div>
        
        <h1 class="page-title"><xsl:value-of select="/__ROOT__/i18n/titles/title[key=//_get/nid]/value"/></h1>
    
    </div>
    <!-- This is where the page content appears -->
    <xsl:comment>page content</xsl:comment>
    <div id="content">
    <xsl:call-template name="content"/>
    </div>
    <xsl:comment>end page content</xsl:comment>
</div>
</div>
<div id="foot">
<xsl:comment>You must keep this copyright notice intact.</xsl:comment>
    <a href="http://www.pbooks.org/" target="_blank" style="color: #FFF;">PBooks</a> version <xsl:value-of select="//pbooks_code_version"/>, DB Version: <xsl:value-of select="/__ROOT__/runtime/db_version"/>, Copyright <a href="http://www.savonix.com" target="_blank" style="color: #FFF;">Savonix</a>, all rights reserved. License: <a style="color: #FFF;" href="{/__ROOT__/runtime/link_prefix}license">AGPL v3</a>. <a style="color: #FFF;" href="http://www.pbooks.org/blog/download/">Download source</a>.
    <!-- Link to download source, as required by AGPL --></div>
</div>
<script  type="text/javascript" src="js/make_request.js"> &#160; </script>
<xsl:value-of select="/__ROOT__/runtime/footer_includes" disable-output-escaping="yes"/>
</body>
</html>
</xsl:template>
</xsl:stylesheet>