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
    <xsl:call-template name="content"/>
</body>
</html>
</xsl:template>

</xsl:stylesheet>