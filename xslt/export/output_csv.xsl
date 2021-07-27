<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:t="http://www.tei-c.org/ns/1.0"
    
    exclude-result-prefixes="xs xsl" version="2.0">
    
    <xsl:strip-space elements="*" />
    <xsl:output method="text"/>
    
    <xsl:template match="t:TEI">
        
        
        
       <xsl:apply-templates/>
        
        
    </xsl:template>
  
    <xsl:template match="t:teiHeader"/>
    <xsl:template match="t:faksimile"/>
    
    
    <xsl:template match="t:text/t:body">
        <xsl:variable name="title" select="parent::t:text/preceding-sibling::t:teiHeader/t:fileDesc/t:titleStmt/t:title"/>
        <!-- Speisen in CSV schreiben -->
        <xsl:result-document href="{$title}_dishes.csv" >
            <xsl:for-each select="//t:dish">
            
                <xsl:value-of select="normalize-space(.)"/>,<xsl:value-of select="@en"/>,<xsl:value-of select="@commodity"/><xsl:text>&#10;</xsl:text>
        </xsl:for-each>
    </xsl:result-document>
        
        <!-- Zutaten in CSV schreiben -->
        <xsl:result-document href="{$title}_ingredients.csv" >
            <xsl:for-each select="//t:ingredient">
                
                <xsl:value-of select="normalize-space(.)"/>,<xsl:value-of select="@en"/>,<xsl:value-of select="@commodity"/><xsl:text>&#10;</xsl:text>
            </xsl:for-each>
        </xsl:result-document>
        
        <!-- Gerätschaften in CSV schreiben -->
        <xsl:result-document href="{$title}_tools.csv" >
            <xsl:for-each select="//t:tool">
                
                <xsl:value-of select="normalize-space(.)"/>,<xsl:value-of select="@en"/>,<xsl:value-of select="@commodity"/><xsl:text>&#10;</xsl:text>
            </xsl:for-each>
        </xsl:result-document>
        
        <!-- Rezepttitel in CSV schreiben -->
        <xsl:result-document href="{$title}_recipes.csv" >
            <xsl:for-each select="//t:title/@ana">
                
                <xsl:value-of select="normalize-space(.)"/>,<xsl:text>&#10;</xsl:text>
            </xsl:for-each>
        </xsl:result-document>
        
        
        
        
        
        
    </xsl:template>
    
    
    
</xsl:stylesheet>