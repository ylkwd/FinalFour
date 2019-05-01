<?xml version="1.0" encoding="UTF-8"?>
<?altova_samplexml Ncaa.xml?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:template match="/">

	<head>
		<link rel="stylesheet" href="tgelogo.css" type="text/css"/>
	</head>
	<body style="background-color: bule">
	<h1><img src="ncaa.png"/></h1>
	<h2>NCAA</h2>
		<table class="customers">
			<xsl:for-each select="ncaa/team">
			<tr><td>
				<br>
				<xsl:value-of select="teamname"/>
				</br>
				<br>Coach:
				<xsl:value-of select="coach"/>
				</br>
				<br>Intro:
				<xsl:value-of select="intro"/>
				</br>
			</td></tr>
		</xsl:for-each>
		</table>
	</body>

</xsl:template>
</xsl:stylesheet>