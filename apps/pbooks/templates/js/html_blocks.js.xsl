<!--
Program: PBooks
Component: html_blocks.js.xsl
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
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns="http://www.w3.org/1999/xhtml">
	<xsl:output method="text" indent="yes" encoding="UTF-8" omit-xml-declaration="yes"/>
	<xsl:template match="/">
			<![CDATA[
			var myfooter = '\
				<div id="brdfooter"> \
					<p style="text-align: right;"> \
						Powered by <a href="http://www.phunkybb.com/blog/" title="Open Source Forums XSL Software">PhunkyBB</a>. \
					</p> \
				</div>';

			var mytitle = '<div id="brdtitle" class="inbox" style="min-height:6em;padding:10px;"><h1><a href="/a/dev/phunkybb/index.php?nid=index">Another Forums</a></h1><span style="line-height:1.9em;">Nothing exciting.</span></div>';

			var mypostbutton = '<div class="button-basic-blue" style="float: right;" onclick="location.href=\'/a/dev/phunkybb/index.php?nid=post&amp;fid=4\';"><a href="/a/dev/phunkybb/index.php?nid=post&amp;fid=4"><img src="/a/dev/phunkybb/s/img/icons/famfamfam/add.png"/>Post new topic</a></div>';


// e4x
var x = new XML();
x=<note>
<date>2002-08-01</date>
</note>;


			$(document).ready(function() {
					$("#notitle").replaceWith(mytitle);
					//$("#nofooter").replaceWith("<span>"+x.date+"</span>");
					$("#nofooter").replaceWith(myfooter);
					$(".nobutton").appendChild(mypostbutton);
			});


			]]>
	</xsl:template>
</xsl:stylesheet>
