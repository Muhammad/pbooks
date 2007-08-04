<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="html" indent="yes" encoding="UTF-8" 
	omit-xml-declaration="yes" 
	doctype-public="-//W3C//DTD HTML 4.01 Transitional//EN"
    doctype-system="http://www.w3.org/TR/html4/loose.dtd"/>
<xsl:template match="/">
<html>
<head>
	<title>PBooks Accounting and Bookkeeping System</title>
     <link rel="stylesheet" type="text/css" href="css/pbooks-1.css" ></link>
</head>
<body>
<div style="padding: 10px;">
<table width="768" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td valign="top" style="background: #AAA; width: 120px; height: 640px;">
            <table cellspacing="0" cellpadding="0"><tr>
            <td valign="top" bgcolor="#FFF">
            <a href="{//link_prefix}welcome"><img src="images/pbooks-logo_120x60.png" border="0"/></a>
            </td></tr>
            <tr>
            <td valign="top">
            <!-- why not admin? -->
            <xsl:if test="not(//_get/nid='login') and not(//_get/nid='logout') and not(//_get/nid='admin')">
            <xsl:call-template name="accounting-menu"/>
            </xsl:if></td></tr>
            </table>
        </td>
        <td valign="top">
            <div style="height: 60px; background: #777; letter-spacing: 1px; display: block;">&#160;
            <div style="float: right; padding-right: 10px; color: #EEE;"><xsl:value-of select="//company_name"/></div>
            <h1 style="padding-left: 10px; padding-top: 10px; color: #EEE; font-size: 18px;"><xsl:value-of select="//titles[@lang=//selected_lang]/title[key=//_get/nid]/value"/></h1>
            </div>
            <xsl:if test="not(//_get/test_db_performance='true')">
            <div style="padding: 10px;">
			<xsl:call-template name="content"/>
            </div>
            </xsl:if>
		</td>
	</tr>
    <tr><td colspan="2" align="center" style="background: #333; color: #EEE; padding: 5px;">
    <xsl:comment>You must keep this copyright notice intact</xsl:comment>
    <a href="http://www.pbooks.org/" target="_blank" style="color: #FFF;">PBooks</a> version <xsl:value-of select="//pbooks_version"/>, Copyright <a href="http://www.savonix.com" target="_blank" style="color: #FFF;">Savonix</a>, all rights reserved. <!-- Link to download source, as required by AGPL -->
    </td></tr>
</table>
</div>
</body>
</html>
</xsl:template>
</xsl:stylesheet>
