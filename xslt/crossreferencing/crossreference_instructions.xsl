<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:t="http://www.tei-c.org/ns/1.0"
    xmlns="http://www.tei-c.org/ns/1.0" exclude-result-prefixes="xs t">
    <xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes"/>
    <xsl:strip-space elements="*"/>

    <xsl:param name="ids" select="document('instructions.xml')"/>
    
    <!-- Input Example
    <row>
        <elem name="instruction">pour out</elem>
        <elem name="norm">p1</elem>
    </row>
    -->

    <xsl:template match="@* | node()">
        <xsl:copy>
            <xsl:apply-templates select="@* | node()"/>
        </xsl:copy>
    </xsl:template>

    <xsl:template match="instruction">
        <xsl:variable name="words" select="tokenize(normalize-space(.), ' ')" />
        <xsl:variable name="row" as="element()*">
            <xsl:perform-sort select="$ids//row[every $i in tokenize(normalize-space(elem[@name='Instruction']), ' ') satisfies $i = $words]">
                <xsl:sort select="count(tokenize(normalize-space(elem[@name='Instruction']), ' '))" order="descending" />
            </xsl:perform-sort>
        </xsl:variable>
        <xsl:copy>
            <xsl:if test="$row">
                <xsl:attribute name="norm" select="$row[1]/elem[@name='Norm']" />    
            </xsl:if>
            <xsl:apply-templates select="@* | node()"/>
        </xsl:copy>
    </xsl:template>
</xsl:stylesheet>
