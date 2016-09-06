<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:sdk="http://schemas.android.com/sdk/android/sys-img/3">

	<!-- https://dl-ssl.google.com/android/repository/extra/intel/addon.xml -->

	<xsl:strip-space elements="*" />
	<xsl:output indent="yes" method="text" />

	<xsl:template match="/sdk:sdk-sys-img">
		<!-- <xsl:text>name,version,api-level,revision,description,obsolete,windowsSize,windowsSHA1,windowsURL,macosxSize,macosxSHA1,macosxURL,linuxSize,linuxSHA1,linuxURL&#xa;</xsl:text> -->
		<xsl:for-each select="sdk:system-image">
			<!-- name -->
			<xsl:choose>
				<xsl:when test="sdk:abi/text() = 'x86'">
					<xsl:variable name="name"
						select="'Google APIs Intel x86 Atom System Image'" />

					<xsl:value-of select="$name" />

					<xsl:call-template name="package">
						<xsl:with-param name="name" select="$name" />
					</xsl:call-template>
				</xsl:when>
				<xsl:when test="sdk:abi/text() = 'x86_64'">
					<xsl:variable name="name"
						select="'Google APIs Intel x86 Atom_64 System Image'" />

					<xsl:value-of select="$name" />

					<xsl:call-template name="package">
						<xsl:with-param name="name" select="$name" />
					</xsl:call-template>
				</xsl:when>
				<xsl:when test="sdk:abi/text() = 'armeabi-v7a'">
					<xsl:variable name="name"
						select="'Google APIs ARM EABI v7a System Image'" />

					<xsl:value-of select="$name" />

					<xsl:call-template name="package">
						<xsl:with-param name="name" select="$name" />
					</xsl:call-template>
				</xsl:when>
			</xsl:choose>

			<!-- http://stackoverflow.com/questions/723226/producing-a-new-line-in-xslt -->
			<xsl:text>&#xa;</xsl:text>

		</xsl:for-each>

	</xsl:template>
	<xsl:template match="sdk:archive">
		<xsl:value-of select="concat(',', sdk:size/text())" />
		<xsl:value-of select="concat(',', sdk:checksum[@type='sha1']/text())" />
		<xsl:variable name="url" select="sdk:url/text()" />
		<xsl:choose>
			<xsl:when test="starts-with($url, 'https://')">
				<xsl:value-of select="concat(',', $url)" />
			</xsl:when>
			<xsl:when test="starts-with($url, 'http://')">
				<xsl:value-of select="concat(',', $url)" />
			</xsl:when>
			<xsl:when test="starts-with($url, '/')">
				<xsl:value-of select="concat(',https://dl-ssl.google.com', $url)" />
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of
					select="concat(',https://dl-ssl.google.com/android/repository/sys-img/google_apis/', $url)" />
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template name="csvEscape">
		<xsl:param name="value" />
		<xsl:choose>
			<xsl:when test="contains($value, ',')">
				<xsl:text>"</xsl:text>
				<xsl:value-of select="$value" />
				<xsl:text>"</xsl:text>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="$value" />
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template name="package">
		<xsl:param name="name" />
		<!-- version -->
		<xsl:value-of select="concat(',', sdk:version/text())" />
		<!-- api-level -->
		<xsl:variable name="apiLevel" select="sdk:api-level/text()" />
		<xsl:value-of select="concat(',', $apiLevel)" />
		<!-- revision -->
		<xsl:variable name="revision" select="number(sdk:revision/text())" />
		<xsl:choose>
			<xsl:when test="$revision">
				<xsl:value-of select="concat(',', $revision)" />
			</xsl:when>
			<xsl:otherwise>
				<xsl:variable name="major" select="sdk:revision/sdk:major/text()" />
				<xsl:variable name="minor" select="sdk:revision/sdk:minor/text()" />
				<xsl:variable name="micro" select="sdk:revision/sdk:micro/text()" />
				<xsl:choose>
					<xsl:when test="$micro > 0">
						<xsl:value-of select="concat(',', $major, '.', $minor, '.', $micro)" />
					</xsl:when>
					<xsl:otherwise>
						<xsl:choose>
							<xsl:when test="$minor > 0">
								<xsl:value-of select="concat(',', $major, '.', $minor)" />
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="concat(',', $major)" />
							</xsl:otherwise>
						</xsl:choose>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:otherwise>
		</xsl:choose>
		<!-- description -->
		<xsl:text>,</xsl:text>
		<xsl:variable name="description" select="normalize-space(sdk:description/text())" />
		<xsl:choose>
			<xsl:when test="$description">
				<xsl:call-template name="csvEscape">
					<xsl:with-param name="value" select="$description" />
				</xsl:call-template>
			</xsl:when>
			<xsl:otherwise>
				<!-- TODO revision, see above -->
				<xsl:choose>
					<xsl:when test="$revision">
						<xsl:call-template name="description">
							<xsl:with-param name="name" select="$name" />
							<xsl:with-param name="apiLevel" select="$apiLevel" />
							<xsl:with-param name="revision" select="$revision" />
						</xsl:call-template>
					</xsl:when>
					<xsl:otherwise>
						<xsl:variable name="major" select="sdk:revision/sdk:major/text()" />
						<xsl:variable name="minor" select="sdk:revision/sdk:minor/text()" />
						<xsl:variable name="micro" select="sdk:revision/sdk:micro/text()" />
						<xsl:choose>
							<xsl:when test="$micro > 0">
								<xsl:variable name="revision2"
									select="concat($major, '.', $minor, '.', $micro)" />
								<xsl:call-template name="description">
									<xsl:with-param name="name" select="$name" />
									<xsl:with-param name="apiLevel" select="$apiLevel" />
									<xsl:with-param name="revision" select="$revision2" />
								</xsl:call-template>
							</xsl:when>
							<xsl:otherwise>
								<xsl:choose>
									<xsl:when test="$minor > 0">
										<xsl:variable name="revision2" select="concat($major, '.', $minor)" />
										<xsl:call-template name="description">
											<xsl:with-param name="name" select="$name" />
											<xsl:with-param name="apiLevel" select="$apiLevel" />
											<xsl:with-param name="revision" select="$revision2" />
										</xsl:call-template>
									</xsl:when>
									<xsl:otherwise>
										<xsl:variable name="revision2" select="$major" />
										<xsl:call-template name="description">
											<xsl:with-param name="name" select="$name" />
											<xsl:with-param name="apiLevel" select="$apiLevel" />
											<xsl:with-param name="revision" select="$revision2" />
										</xsl:call-template>
									</xsl:otherwise>
								</xsl:choose>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:otherwise>
		</xsl:choose>
		<!-- obsolete -->
		<xsl:choose>
			<xsl:when test="sdk:obsolete">
				<xsl:text>,true</xsl:text>
			</xsl:when>
			<xsl:otherwise>
				<xsl:text>,false</xsl:text>
			</xsl:otherwise>
		</xsl:choose>
		<!-- windowsSize,windowsSHA1,windowsURL -->
		<xsl:variable name="windows"
			select="sdk:archives/sdk:archive[sdk:host-os/text()='windows']" />
		<xsl:choose>
			<xsl:when test="$windows">
				<xsl:apply-templates select="$windows" />
			</xsl:when>
			<xsl:otherwise>
				<xsl:variable name="windows2"
					select="sdk:archives/sdk:archive[contains(sdk:url/text(),'windows')]" />
				<xsl:choose>
					<xsl:when test="$windows2">
						<xsl:apply-templates select="$windows2" />
					</xsl:when>
					<xsl:otherwise>
						<xsl:variable name="windows3"
							select="sdk:archives/sdk:archive[count(sdk:host-os) = 0]" />
						<xsl:choose>
							<xsl:when test="$windows3">
								<xsl:apply-templates select="$windows3" />
							</xsl:when>
							<xsl:otherwise>
								<xsl:text>,,,</xsl:text>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:otherwise>
		</xsl:choose>
		<!-- macosxSize,macosxSHA1,macosxURL -->
		<xsl:variable name="macosx"
			select="sdk:archives/sdk:archive[sdk:host-os/text()='macosx']" />
		<xsl:choose>
			<xsl:when test="$macosx">
				<xsl:apply-templates select="$macosx" />
			</xsl:when>
			<xsl:otherwise>
				<xsl:variable name="macosx2"
					select="sdk:archives/sdk:archive[contains(sdk:url/text(),'macosx')]" />
				<xsl:choose>
					<xsl:when test="$macosx2">
						<xsl:apply-templates select="$macosx2" />
					</xsl:when>
					<xsl:otherwise>
						<xsl:variable name="macosx3"
							select="sdk:archives/sdk:archive[count(sdk:host-os) = 0]" />
						<xsl:choose>
							<xsl:when test="$macosx3">
								<xsl:apply-templates select="$macosx3" />
							</xsl:when>
							<xsl:otherwise>
								<xsl:text>,,,</xsl:text>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:otherwise>
		</xsl:choose>
		<!-- linuxSize,linuxSHA1,linuxURL -->
		<xsl:variable name="linux"
			select="sdk:archives/sdk:archive[sdk:host-os/text()='linux']" />
		<xsl:choose>
			<xsl:when test="$linux">
				<xsl:apply-templates select="$linux" />
			</xsl:when>
			<xsl:otherwise>
				<xsl:variable name="linux2"
					select="sdk:archives/sdk:archive[contains(sdk:url/text(),'linux')]" />
				<xsl:choose>
					<xsl:when test="$linux2">
						<xsl:apply-templates select="$linux2" />
					</xsl:when>
					<xsl:otherwise>
						<xsl:variable name="linux3"
							select="sdk:archives/sdk:archive[count(sdk:host-os) = 0]" />
						<xsl:choose>
							<xsl:when test="$linux3">
								<xsl:apply-templates select="$linux3" />
							</xsl:when>
							<xsl:otherwise>
								<xsl:text>,,,</xsl:text>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template name="description">
		<xsl:param name="name" />
		<xsl:param name="apiLevel" />
		<xsl:param name="revision" />
		<xsl:choose>
			<xsl:when test="$apiLevel">
				<xsl:call-template name="csvEscape">
					<xsl:with-param name="value"
						select="concat($name, ', ', 'API ', $apiLevel, ', revision ', $revision)" />
				</xsl:call-template>
			</xsl:when>
			<xsl:otherwise>
				<xsl:call-template name="csvEscape">
					<xsl:with-param name="value"
						select="concat($name, ', revision ', $revision)" />
				</xsl:call-template>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
</xsl:stylesheet>