<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="xml" indent="yes"/>

	<!-- Template to match the root element -->
	<xsl:template match="/testsuite">
		<TestRun>
			<FailedTests>
				<xsl:for-each select="testcase[failure]">
					<Test id="{position()}">
						<Name>
							<xsl:value-of select="@name"/>
						</Name>
						<FailureType>Assertion</FailureType>
						<Message>
							<xsl:value-of select="failure/@message"/>
						</Message>
						<Location>
							<File>
								<xsl:value-of select="@classname"/>
							</File>
							<Line>0</Line>
						</Location>
					</Test>
				</xsl:for-each>
			</FailedTests>
			<SuccessfulTests>
				<xsl:for-each select="testcase[not(failure)]">
					<Test id="{position() + count(../testcase[failure])}">
						<Name>
							<xsl:value-of select="@name"/>
						</Name>
						<Location>
							<File>
								<xsl:value-of select="@classname"/>
							</File>
							<Line>0</Line>
						</Location>
					</Test>
				</xsl:for-each>
			</SuccessfulTests>
			<Statistics>
				<Tests>
					<xsl:value-of select="@tests"/>
				</Tests>
				<FailuresTotal>
					<xsl:value-of select="@failures"/>
				</FailuresTotal>
				<Errors>
					0
				</Errors>
				<Failures>
					<xsl:value-of select="@failures"/>
				</Failures>
			</Statistics>
		</TestRun>
	</xsl:template>
</xsl:stylesheet>