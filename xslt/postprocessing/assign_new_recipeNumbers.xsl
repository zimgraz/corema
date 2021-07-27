<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:t="http://www.tei-c.org/ns/1.0" xmlns="http://www.tei-c.org/ns/1.0" exclude-result-prefixes="t xs xsl" version="3.0">
    <xsl:output indent="yes"/>
    <xsl:mode on-no-match="shallow-copy"/>
    <xsl:template match="node() | @*">
        <xsl:copy>
            <xsl:apply-templates select="node() | @*"/>
        </xsl:copy>
    </xsl:template>
    <xsl:template match="t:body//t:ab[not(@subtype)]">
        <xsl:variable name="counter">
            <xsl:number level="any" count="t:body//t:ab[not(@subtype)]"/>
        </xsl:variable>
        <xsl:copy>
            <xsl:attribute name="n">
                <xsl:value-of select="$counter"/>
            </xsl:attribute>
            <xsl:attribute name="xml:id">
                <xsl:value-of select="concat(lower-case(//t:altIdentifier[@type='abbr']/t:idno),'.',$counter)"/>
            </xsl:attribute>
            <xsl:apply-templates select="node() | @* except (@xml:id,@n)"/>
        </xsl:copy>
    </xsl:template>
</xsl:stylesheet>