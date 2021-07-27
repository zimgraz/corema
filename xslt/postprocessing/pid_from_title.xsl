<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:t="http://www.tei-c.org/ns/1.0" xmlns="http://www.tei-c.org/ns/1.0"
    exclude-result-prefixes="t xs xsl" version="2.0">
    
    
    
    <xsl:template match="* | @* | text()">
        
        <!-- Alles kopieren -->
        <xsl:copy>
            <xsl:apply-templates select="* | @* | text()"/>
        </xsl:copy>
        
    </xsl:template>
    
    
    
    
    <xsl:template match="t:publicationStmt">
        <publicationStmt>
        <xsl:apply-templates/>
        <idno type="PID">o:corema.<xsl:value-of select="lower-case(//t:title)"/></idno>
        </publicationStmt>
    </xsl:template>
    
</xsl:stylesheet>
