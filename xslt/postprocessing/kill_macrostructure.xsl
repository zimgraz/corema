<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:t="http://www.tei-c.org/ns/1.0" xmlns="http://www.tei-c.org/ns/1.0"
    exclude-result-prefixes="t xs xsl" version="2.0">
    <xsl:strip-space elements="*"/>
    
    
   
    
    <xsl:template match="@* | node()">
        
        <!-- Alles kopieren -->
        <xsl:copy>
            <xsl:apply-templates select="@* | node()"/>
        </xsl:copy>
        
    </xsl:template>
    
    <xsl:template match="t:instruction">
        <xsl:apply-templates/>
    </xsl:template>
    <xsl:template match="t:opener">
        <xsl:apply-templates/>
    </xsl:template>
    <xsl:template match="t:closer">
        <xsl:apply-templates/>
    </xsl:template>
    <xsl:template match="t:kitchenTip">
        <xsl:apply-templates/>
    </xsl:template>
    <xsl:template match="t:householdTip">
        <xsl:apply-templates/>
    </xsl:template>
    <xsl:template match="t:servingTip">
        <xsl:apply-templates/>
    </xsl:template>
    
</xsl:stylesheet>