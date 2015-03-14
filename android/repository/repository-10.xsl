<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:sdk="http://schemas.android.com/sdk/android/repository/10">

	<!-- https://dl-ssl.google.com/android/repository/repository-10.xml -->

	<xsl:strip-space elements="*" />
	<xsl:output indent="yes" method="text" />

	<xsl:template match="/sdk:*">
		<xsl:for-each select="sdk:*/sdk:archives/sdk:archive/sdk:url">

			<xsl:variable name="url" select="text()"></xsl:variable>

			<xsl:choose>
				<xsl:when
					test="starts-with($url, 'https://dl-ssl.google.com/android/repository/')">
					<xsl:value-of select="$url" />
				</xsl:when>
				<xsl:when
					test="starts-with($url, 'https://')">
					<!-- ignores -->
				</xsl:when>
				<xsl:when
					test="starts-with($url, 'http://')">
					<!-- ignores -->
				</xsl:when>
				<xsl:when
					test="starts-with($url, '/android/repository/')">
					<xsl:text>https://dl-ssl.google.com</xsl:text>
					<xsl:value-of select="$url" />
				</xsl:when>
				<xsl:when
					test="starts-with($url, '/')">
					<!-- ignores -->
				</xsl:when>
				<xsl:otherwise>
					<xsl:text>https://dl-ssl.google.com/android/repository/</xsl:text>
					<xsl:value-of select="$url" />
				</xsl:otherwise>
			</xsl:choose>

			<!-- http://stackoverflow.com/questions/723226/producing-a-new-line-in-xslt -->
			<xsl:text>&#xa;</xsl:text>

		</xsl:for-each>
	</xsl:template>
</xsl:stylesheet>