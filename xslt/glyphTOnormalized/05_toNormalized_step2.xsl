<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:t="http://www.tei-c.org/ns/1.0" xmlns="http://www.tei-c.org/ns/1.0"
    exclude-result-prefixes="t xs xsl" version="2.0">
    
    <xsl:output method="xml" indent="yes"/>
    
    
    <xsl:template match="* | @* | text()">       
        <!-- Alles kopieren -->
        <xsl:copy>
            <xsl:apply-templates select="* | @* | text()"/>
        </xsl:copy>      
    </xsl:template>

    <xsl:template match="processing-instruction('xml-model')[1]">
        <xsl:processing-instruction name="xml-model">href="../corema_schema/corema_recipes.sch" type="application/xml" schematypens="http://purl.oclc.org/dsdl/schematron"</xsl:processing-instruction>
        <xsl:processing-instruction name="xml-model">href="../corema_schema/corema_recipes.rng" type="application/xml" schematypens="http://relaxng.org/ns/structure/1.0"</xsl:processing-instruction>
    </xsl:template>
    
    <!--inhalt wird gelöscht-->
    <xsl:template match="t:ab/t:d"/>
    <xsl:template match="t:d/t:d"/>
    
    <!--inhalt bleibt-->
    <xsl:template match="t:title/t:d">
        <xsl:apply-templates/>
    </xsl:template>
    <xsl:template match="t:w/t:d">
        <xsl:apply-templates/>
    </xsl:template>
    <xsl:template match="t:title//t:w">
        <xsl:apply-templates/>
    </xsl:template>
    <xsl:template match="t:title">
        <xsl:variable name="title"><xsl:apply-templates/></xsl:variable>
        <title><xsl:value-of select="replace($title/normalize-space(), 'veMAKEU', 'ue')"/></title>
    </xsl:template>
    <!--abgetrennte Wörter hier zusammenschreiben-->
    <xsl:template match="t:w">
        <xsl:apply-templates/>
    </xsl:template>
    <xsl:template match="t:w//text()">
        <xsl:value-of select="normalize-space(replace(., 'veMAKEU', 'ue'))"/>
    </xsl:template>
    <xsl:template match="t:ab/text()">
        <xsl:value-of select="replace(., 'veMAKEU', 'ue')"/>
    </xsl:template>
    <!--für später falls wir mal alles normalisieren müssen-->
   <!-- <xsl:template match="t:ab//text()">
        <xsl:value-of select="translate(normalize-space(.), '  ', ' ')"/>
    </xsl:template>-->
  
    
</xsl:stylesheet>
