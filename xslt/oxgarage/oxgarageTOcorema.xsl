<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:t="http://www.tei-c.org/ns/1.0" xmlns="http://www.tei-c.org/ns/1.0"
    exclude-result-prefixes="t xs xsl" version="2.0">
    
    <xsl:output method="xml" encoding="UTF-8" indent="no"/>
    
    
    <xsl:template match="* | @* | text()">     
        <!-- Alles kopieren -->
        <xsl:copy>
            <xsl:apply-templates select="* | @* | text()"/>
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="/">
        
            <xsl:apply-templates/>
       
    </xsl:template>
    
   
   <xsl:template match="t:body">
       
       <body><div><xsl:apply-templates/></div></body>
       
   </xsl:template>
    <xsl:template match="t:body/t:p[not(t:hi)]">
        <xsl:variable name="num">
            <xsl:number level="single" format="1" count="t:p[not(t:hi)]"/>
        </xsl:variable>
        <ab type="recipe" n="{$num}" xml:id="{concat('insert_abbr','.',$num)}" xml:lang="insert_lang"><xsl:apply-templates/></ab>
    </xsl:template>
    
    <xsl:template match="t:hi">
        <xsl:apply-templates/>
    </xsl:template>
    
   
</xsl:stylesheet>
