<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:t="http://www.tei-c.org/ns/1.0" xmlns:dct="http://purl.org/dc/terms/"
    xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#" xmlns:rdfs="http://www.w3.org/2000/01/rdf-schema#"
    xmlns:schema="http://schema.org/" xmlns:gams="https://gams.uni-graz.at/o:gams-ontology#" xmlns:corema="https://gams.uni-graz.at/o:corema.ontology#" xmlns:functx="http://www.functx.com" exclude-result-prefixes="xs xsl" version="2.0">
    
    <xsl:strip-space elements="*" />
    <xsl:output method="text" encoding="UTF-8" />
    
    <xsl:function name="functx:capitalize-first" as="xs:string?"
        xmlns:functx="http://www.functx.com">
        <xsl:param name="arg" as="xs:string?"/>
        
        <xsl:sequence select="
            concat(upper-case(substring($arg,1,1)),
            substring($arg,2))
            "/>
        
    </xsl:function>
    <xsl:variable name="all_current_teis"
        select="collection('file:///C:\Users\ch11\Desktop\ingest?select=*.xml;recurse=yes')"/>
    <xsl:template match="/">
        
        
        <xsl:text>const facetConstraintMap: FacetConstraintMap = {
        "Ingredients": [</xsl:text>
        <xsl:for-each select="$all_current_teis">
            <xsl:for-each-group select="//t:ingredient" group-by="@en"><xsl:text>"</xsl:text><xsl:value-of select="current-grouping-key()"/><xsl:text>",</xsl:text></xsl:for-each-group>
        </xsl:for-each>
        <xsl:text>]
            "Dishes": [</xsl:text>
        <xsl:for-each select="$all_current_teis">
            <xsl:for-each-group select="//t:dish" group-by="@en"><xsl:text>"</xsl:text><xsl:value-of select="current-grouping-key()"/><xsl:text>",</xsl:text></xsl:for-each-group>
        </xsl:for-each>
        <xsl:text>]
            "Tools": [</xsl:text>
        <xsl:for-each select="$all_current_teis">
            <xsl:for-each-group select="//t:tool" group-by="@en"><xsl:text>"</xsl:text><xsl:value-of select="current-grouping-key()"/><xsl:text>",</xsl:text></xsl:for-each-group>
        </xsl:for-each>
        <xsl:text>]
         }</xsl:text>
    </xsl:template>
    
    
    <xsl:template match="text()">
        <xsl:variable name="strings">.,;+#'"/()&#10;</xsl:variable>
        <xsl:value-of select="replace(translate(lower-case(.),$strings,'           '),'\s{1,200}',' ')"/>
    </xsl:template>
    
    <xsl:template match="t:note"/>
    
    
    
    <xsl:template match="t:body/t:div">
        
    </xsl:template>
    
    
    
    
    
</xsl:stylesheet>