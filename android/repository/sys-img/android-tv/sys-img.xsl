<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:sdk="http://schemas.android.com/sdk/android/sys-img/3">

	<!-- https://dl-ssl.google.com/android/repository/addon.xml -->

	<xsl:strip-space elements="*" />
	<xsl:output indent="yes" method="text" />

	<xsl:template match="/sdk:*">
		<xsl:for-each select="sdk:*/sdk:archives/sdk:archive/sdk:url">

			<xsl:variable name="url" select="text()"></xsl:variable>

			<xsl:choose>
				<xsl:when
					test="not(starts-with($url, 'https://dl-ssl.google.com/android/repository/sys-img/android-tv/'))">
					<xsl:text>https://dl-ssl.google.com/android/repository/sys-img/android-tv/</xsl:text>
				</xsl:when>
			</xsl:choose>

			<xsl:value-of select="$url" />

			<!-- http://stackoverflow.com/questions/723226/producing-a-new-line-in-xslt -->
			<xsl:text>&#xa;</xsl:text>

		</xsl:for-each>
	</xsl:template>
</xsl:stylesheet>