<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<!-- https://dl-ssl.google.com/android/repository/extras/intel/addon2-1.xml -->

	<xsl:strip-space elements="*"/>
	<xsl:output indent="yes" method="text"/>

	<xsl:template match="/*">
		<xsl:for-each select="*[not(@obsolete) or @obsolete!='true']/archives/archive/complete/url">

			<xsl:variable name="url" select="text()"></xsl:variable>

			<xsl:choose>
				<xsl:when test="starts-with($url, 'https://dl-ssl.google.com/android/repository/extras/intel/')">
					<xsl:value-of select="$url"/>
				</xsl:when>
				<xsl:when test="starts-with($url, 'https://')"><!-- ignores --></xsl:when>
				<xsl:when test="starts-with($url, 'http://')"><!-- ignores --></xsl:when>
				<xsl:when test="starts-with($url, '/android/repository/extras/intel/')">
					<xsl:text>https://dl-ssl.google.com</xsl:text>
					<xsl:value-of select="$url"/>
				</xsl:when>
				<xsl:when test="starts-with($url, '/')"><!-- ignores --></xsl:when>
				<xsl:otherwise>
					<xsl:text>https://dl-ssl.google.com/android/repository/extras/intel/</xsl:text>
					<xsl:value-of select="$url"/>
				</xsl:otherwise>
			</xsl:choose>

			<!-- http://stackoverflow.com/questions/723226/producing-a-new-line-in-xslt -->
			<xsl:text>&#xa;</xsl:text>

		</xsl:for-each>
	</xsl:template>
</xsl:stylesheet>
