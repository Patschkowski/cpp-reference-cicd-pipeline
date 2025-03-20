<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="xml" indent="yes"/>

	<!-- Template to match the root element -->
	<xsl:template match="/">
		<testExecutions version="1">
			<xsl:apply-templates select="//testsuite"/>
		</testExecutions>
	</xsl:template>

	<!-- Template to match each testsuite -->
	<xsl:template match="testsuite">
		<file path="{@name}">
			<xsl:apply-templates select="testcase"/>
		</file>
	</xsl:template>

	<!-- Template to match each testcase -->
	<xsl:template match="testcase">
		<testCase name="{@name}" duration="{@time * 1000}">
			<xsl:apply-templates select="failure"/>
		</testCase>
	</xsl:template>

	<!-- Template to match failure elements -->
	<xsl:template match="failure">
		<failure message="{@message}">
			<xsl:value-of select="."/>
		</failure>
	</xsl:template>
</xsl:stylesheet>
