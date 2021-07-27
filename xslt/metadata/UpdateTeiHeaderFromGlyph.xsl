<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:t="http://www.tei-c.org/ns/1.0" xmlns="http://www.tei-c.org/ns/1.0" xmlns:cs='http://www.chrissteinermachtfunktionenweilesnervtdasseskeinesubstrinbetweenfunktiongibt.com'
    exclude-result-prefixes="#all" version="2.0">
    
    <xsl:output method="xml" indent="yes"/>
    
    
    <xsl:function name="cs:substring-between">
        <xsl:param name="string"/>
        <xsl:param name="start-string"/>
        <xsl:param name="end-string"/>
        <xsl:sequence select="substring-before(substring-after($string, $start-string),$end-string)"/>
    </xsl:function>
<!--    this is the revDesc from the actual document that is tranformed -->    
    <xsl:variable name="revDesc" select="//t:revisionDesc"/>
    <xsl:variable name="filename" select="substring-before(tokenize(base-uri(.), '/')[last()],'_')"/>

   <!-- identity transform -->
    <xsl:template match="@*|node()">
        <xsl:copy> 
            <xsl:apply-templates select="@*|node()"/>
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="t:teiHeader">
        <xsl:copy><xsl:apply-templates select="document(concat('../Handschriften/',$filename,'/',$filename,'_glyph.xml'))//t:teiHeader/(@*|node())"/></xsl:copy>
    </xsl:template>

    <xsl:template match="t:revisionDesc">
        <xsl:copy-of select="$revDesc"/>
    </xsl:template>
    
    <xsl:template match="t:publicationStmt/t:ref[@target='context:corema.glyph']">
        <ref target="context:corema.recipes" type="context"/>
    </xsl:template>
    
    <xsl:template match="t:publicationStmt/t:idno[@type='PID']">
        <idno type="PID"><xsl:value-of select="concat(.,'.recipes')"/></idno>
    </xsl:template>
    
    <xsl:template match="t:publicationStmt/t:date">
        <date when="{format-date(current-date(), '[Y0001]-[M01]-[D01]')}"/>
    </xsl:template>
    
    <xsl:template match="t:editionStmt/t:edition">
        <edition>Semantic annotation of the manuscript <xsl:value-of select="substring-after(//t:titleStmt/t:title,'transcription of ')"/></edition>
    </xsl:template>
    
    <xsl:template match="t:titleStmt/t:title">
        <title>Semantic annotation of the manuscript <xsl:value-of select="substring-after(//t:titleStmt/t:title,'transcription of ')"/></title>
    </xsl:template>
    
</xsl:stylesheet>
