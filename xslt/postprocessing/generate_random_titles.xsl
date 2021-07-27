<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:t="http://www.tei-c.org/ns/1.0" xmlns="http://www.tei-c.org/ns/1.0"
    exclude-result-prefixes="t xs xsl" version="3.0">
    <xsl:mode on-no-match="shallow-copy"/>
    <xsl:strip-space elements="*"/>
    
    
    
    
    <xsl:template match="@* | node()">
        
        <!-- Alles kopieren -->
        <xsl:copy>
            <xsl:apply-templates select="@* | node()"/>
        </xsl:copy>
        
    </xsl:template>
    
    <xsl:template match="t:body//t:ab//t:title">
       <xsl:copy>
        <xsl:attribute name="key">
            <xsl:value-of select="generate-id()"/>
        </xsl:attribute>
           <xsl:apply-templates select="@* | node()"/>
       </xsl:copy>
            
        
    </xsl:template>
 
    
</xsl:stylesheet>