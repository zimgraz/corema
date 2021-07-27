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
       <!-- Ingredient: Q0 und en auslesen title auslesen -->  
        <xsl:for-each-group select="//t:ingredient[@commodity='Q0']" group-by="@en">
            
            <xsl:value-of select="normalize-space(.)"/>,<xsl:value-of select="current-grouping-key()"/><xsl:text>&#10;</xsl:text>
            
        </xsl:for-each-group>
        
        
        <!-- Dish: Q0 und en auslesen title auslesen -->   
        <xsl:for-each-group select="//t:dish[@commodity='Q0']" group-by="@en">
            
            <xsl:value-of select="normalize-space(.)"/>,<xsl:value-of select="current-grouping-key()"/>,<xsl:text>&#10;</xsl:text>
            
        </xsl:for-each-group>
        
    
        <!-- Tool: Q0 und en auslesen title auslesen -->   
        <xsl:for-each-group select="//t:tool[@commodity='Q0']" group-by="@en">
            
            <xsl:value-of select="normalize-space(.)"/>,<xsl:value-of select="current-grouping-key()"/><xsl:text>&#10;</xsl:text>
            
        </xsl:for-each-group>

    </xsl:template>
    
</xsl:stylesheet>