<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:t="http://www.tei-c.org/ns/1.0"
    exclude-result-prefixes="xs"
    version="2.0">
    <xsl:output method="text" omit-xml-declaration="yes" indent="no"/>
    <xsl:strip-space elements="*" />
    <xsl:output method="text"/>
    
    <xsl:template match="t:TEI">
        
        
        
        <xsl:apply-templates/>
        
        
    </xsl:template>
    
    <xsl:template match="t:teiHeader"/>
  
   
    <xsl:template match="t:text/t:body/t:div">
       <!-- Recipe title auslesen -->  
        <xsl:for-each select="t:ab">
            
            <xsl:value-of select="@xml:id"/>,<xsl:value-of select="normalize-space(descendant::t:title[1])"/><xsl:text>&#10;</xsl:text>
            
        </xsl:for-each>
      <!-- Subrecipe title auslesen -->   
        <xsl:for-each select="t:ab/t:ab">
            
            <xsl:value-of select="@xml:id"/>,<xsl:value-of select="normalize-space(descendant::t:title[1])"/><xsl:text>&#10;</xsl:text>
            
        </xsl:for-each>

    </xsl:template>
    
</xsl:stylesheet>