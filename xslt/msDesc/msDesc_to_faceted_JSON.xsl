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
        select="collection('file:///C:\Users\steinerc\Desktop\ingest\gamsglyph?select=*.xml;recurse=yes')"/>
    <xsl:template match="/">
        
        <xsl:text>{
            "data":[</xsl:text>
        
        <xsl:for-each select="$all_current_teis">
            <xsl:apply-templates select="//t:msDesc"/>
        </xsl:for-each>
        <xsl:text>]
        }</xsl:text>
    </xsl:template>
    
    
    <xsl:template match="text()">
        <xsl:variable name="strings">.,;+#'"/()&#10;</xsl:variable>
        <xsl:value-of select="replace(translate(lower-case(.),$strings,'           '),'\s{1,200}',' ')"/><xsl:text> </xsl:text>
    </xsl:template>
    
    
    
    <xsl:template match="t:msDesc">
        <xsl:text>{
"label": "</xsl:text><xsl:text>MS </xsl:text>
        <xsl:value-of select="normalize-space(./t:msIdentifier[1]/t:settlement)"></xsl:value-of>
        <xsl:text>, </xsl:text>
        <xsl:value-of select="normalize-space(./t:msIdentifier[1]/t:institution)"></xsl:value-of>
        <xsl:if test="./t:msIdentifier[1]/t:repository">
            <xsl:text>, </xsl:text>
            <xsl:value-of select="normalize-space(./t:msIdentifier[1]/t:repository)"></xsl:value-of>
        </xsl:if>
        <xsl:text>, </xsl:text>
        <xsl:value-of select="normalize-space(./t:msIdentifier[1]/t:idno)"></xsl:value-of>
        <xsl:text> (</xsl:text>
        <xsl:value-of select="normalize-space(./t:msIdentifier[1]/t:altIdentifier[@type=&apos;abbr&apos;]/t:idno)"></xsl:value-of>
        <xsl:text>)</xsl:text><xsl:text>",&#10;</xsl:text>
        <xsl:text>"txt": "</xsl:text><xsl:apply-templates/><xsl:text>",&#10;</xsl:text> 
        <xsl:text>"value": "https://gams.uni-graz.at/</xsl:text><xsl:value-of select="//t:idno[@type='PID']"/><xsl:text>/sdef:TEI/get?mode=view:msdesc",&#10;</xsl:text>
        <xsl:text>"tags": [</xsl:text><xsl:for-each select="//t:msContents/t:textLang[@ana=&apos;manuscript&apos;]/t:lang">
            <xsl:text>"</xsl:text><xsl:value-of select="."></xsl:value-of><xsl:text>"</xsl:text>
            <xsl:if test="position() != last()"><xsl:text>, </xsl:text></xsl:if>
        </xsl:for-each><xsl:text>, </xsl:text>
        <xsl:variable name="from" select="//t:origDate/t:date[1]/@notBefore"></xsl:variable>
        <xsl:variable name="to" select="//t:origDate/t:date[1]/@notAfter"></xsl:variable>
        <xsl:variable name="when" select="//t:origDate/t:date[1]/@when"></xsl:variable>
        <xsl:choose>
            <xsl:when test="$when">
                <xsl:text>"</xsl:text><xsl:value-of select="normalize-space($when)"></xsl:value-of><xsl:text>"</xsl:text>
            </xsl:when>
            <xsl:when test="$from=$to">
                <xsl:text>"</xsl:text><xsl:value-of select="normalize-space($from)"></xsl:value-of><xsl:text>"</xsl:text>
            </xsl:when>
            <xsl:otherwise>
                <xsl:text>"</xsl:text><xsl:value-of select="normalize-space($from)"></xsl:value-of>
                <xsl:text>/</xsl:text>
                <xsl:value-of select="normalize-space($to)"></xsl:value-of><xsl:text>"</xsl:text>
            </xsl:otherwise>
        </xsl:choose><xsl:text>, </xsl:text>
        <xsl:text>"</xsl:text><xsl:value-of select="normalize-space(//t:settlement[1])"></xsl:value-of><xsl:text>"</xsl:text><xsl:text>, </xsl:text>
        <xsl:text>"</xsl:text><xsl:value-of select="normalize-space(//t:msIdentifier[1]/t:altIdentifier[@type=&apos;abbr&apos;]/t:idno)"/><xsl:text>"</xsl:text><xsl:text>]&#10;</xsl:text>
        
        <xsl:text>},</xsl:text>
        
    </xsl:template>
    
    
    
    
    
</xsl:stylesheet>