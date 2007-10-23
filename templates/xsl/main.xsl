<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="html" indent="yes" encoding="UTF-8" omit-xml-declaration="no" doctype-public="-//W3C//DTD HTML 4.01 Transitional//EN"
    doctype-system="http://www.w3.org/TR/html4/loose.dtd"/>
<xsl:template match="/">
<html>
<head>
	 <title>PBooks Accounting and Bookkeeping System</title>
     <link rel="stylesheet" type="text/css" href="css/pbooks-1.css" ></link>
</head>
<body>
<script language="JavaScript" src="js/make_request.js"> &#160; </script>
<div id="container">
<div id="capsule">
<div id="leftcol">
    <a href="index.php?nid=welcome"><img src="images/pbooks-logo_120x60.png" border="0"/></a>
    <xsl:if test="not(//_get/nid='login') 
    and not(//_get/nid='logout') 
    and not(//_get/nid='development-data-generator') 
    and not(contains(//_get/nid,'user'))
    and not(//_get/nid='group')
    and not(contains(//_get/nid,'role'))">
    <xsl:call-template name="accounting-menu"/>
    </xsl:if>
</div>
<div id="header">
    <div style="height: 60px; background: #777; letter-spacing: 1px; display: block;">&#160;
    <div style="float: right; padding-right: 10px; color: #EEE;"><xsl:value-of select="//company_name"/></div>
    <h1 style="padding: 10px; color: #EEE; font-size: 18px; margin-top: 8px;"><xsl:value-of select="//titles[@lang=//selected_lang]/title[key=//_get/nid]/value"/></h1>
    </div>
    <div style="padding: 10px; 784px;">
    <xsl:call-template name="content"/>
    </div>
</div>
    <!--
    <tr><td colspan="2" align="center" style="background: #333; color: #EEE; padding: 5px;">
     
    </td></tr> -->

</div>
<div id="foot">
<xsl:comment>You must keep this copyright notice intact.</xsl:comment>
    <a href="http://www.pbooks.org/" target="_blank" style="color: #FFF;">PBooks</a> version <xsl:value-of select="//pbooks_code_version"/>, Copyright <a href="http://www.savonix.com" target="_blank" style="color: #FFF;">Savonix</a>, all rights reserved. License: AGPL v3. Download source: <a style="color: #FFF;" href="http://www.pbooks.org/download/">Download source</a>.
    <!-- Link to download source, as required by AGPL --></div>
</div>
</body>
</html>
</xsl:template>
</xsl:stylesheet>