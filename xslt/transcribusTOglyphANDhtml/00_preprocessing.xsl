<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:t="http://www.tei-c.org/ns/1.0" xmlns="http://www.tei-c.org/ns/1.0"
    exclude-result-prefixes="t xs xsl" version="2.0">
    
    <xsl:output method="xml" indent="yes"/>
    
    <xsl:strip-space elements="t:surface"/>
    
    <xsl:template match="* | @* | text()">
        
        <!-- Alles kopieren -->
        <xsl:copy>
            <xsl:apply-templates select="* | @* | text()"/>
        </xsl:copy>
        
    </xsl:template>
    
    
        
        
    <xsl:template match="t:body">
        <xsl:copy>
            <xsl:attribute name="xml:space"><xsl:text>preserve</xsl:text></xsl:attribute>
            <ab><xsl:apply-templates select="*|@*|text()"/></ab>
        </xsl:copy>
       
    </xsl:template>
    
    <xsl:template match="t:p">
        <xsl:apply-templates/>
    </xsl:template>
    
    <xsl:template match="t:pb/@xml:id">
       
        <xsl:attribute name="xml:id">
            <xsl:value-of select="//t:title"/><xsl:text>_</xsl:text>
            <xsl:choose>
                <xsl:when test="starts-with(../@xml:id,'0') and contains(../@xml:id,'.')">
                    <xsl:value-of select="substring-before(substring-after(../@xml:id,'0'),'.')"/>
                </xsl:when>
                <xsl:when test="starts-with(../@xml:id,'0')">
                    <xsl:value-of select="substring-after(../@xml:id,'0')"/>
                </xsl:when>
                <xsl:when test="contains(../@xml:id,'.') and string-length(substring-before(../@xml:id,'.'))>4">
                    <xsl:value-of select="substring(substring-before(../@xml:id,'.'), string-length(substring-before(../@xml:id,'.')) -3)"/>
                </xsl:when>
                <xsl:when test="contains(../@xml:id,'.') and string-length(substring-before(../@xml:id,'.'))&lt;=4">
                    <xsl:value-of select="substring-before(../@xml:id,'.')"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="../@xml:id"/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:attribute>
           
    </xsl:template>
    
    <xsl:template match="t:pb/@n">
        
        <xsl:attribute name="n">
            <xsl:choose>
                <xsl:when test="starts-with(../@xml:id,'0') and contains(../@xml:id,'.')">
                    <xsl:value-of select="substring-before(substring-after(../@xml:id,'0'),'.')"/>
                </xsl:when>
                <xsl:when test="starts-with(../@xml:id,'0')">
                    <xsl:value-of select="substring-after(../@xml:id,'0')"/>
                </xsl:when>
                <xsl:when test="contains(../@xml:id,'.') and string-length(substring-before(../@xml:id,'.'))>4">
                    <xsl:value-of select="substring(substring-before(../@xml:id,'.'), string-length(substring-before(../@xml:id,'.')) -3)"/>
                </xsl:when>
                <xsl:when test="contains(../@xml:id,'.') and string-length(substring-before(../@xml:id,'.'))&lt;=4">
                    <xsl:value-of select="substring-before(../@xml:id,'.')"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="../@xml:id"/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:attribute>
        
    </xsl:template>
    
    <xsl:template match="t:surface/@corresp">
        
        <xsl:attribute name="start">
            <xsl:text>#</xsl:text><xsl:value-of select="//t:title"/><xsl:text>_</xsl:text>
            <xsl:choose>
                <xsl:when test="starts-with(.,'0') and contains(.,'.')">
                    <xsl:value-of select="substring-before(substring-after(.,'0'),'.')"/>
                </xsl:when>
                <xsl:when test="starts-with(.,'0')">
                    <xsl:value-of select="substring-after(.,'0')"/>
                </xsl:when>
                <xsl:when test="contains(.,'.') and string-length(substring-before(.,'.'))>4">
                    <xsl:value-of select="substring(substring-before(.,'.'), string-length(substring-before(.,'.')) -3)"/>
                </xsl:when>
                <xsl:when test="contains(.,'.') and string-length(substring-before(.,'.'))&lt;=4">
                    <xsl:value-of select="substring-before(.,'.')"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="."/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:attribute>
        
    </xsl:template>
    <xsl:template match="t:surface/@ulx"></xsl:template>
    <xsl:template match="t:surface/@uly"></xsl:template>
    <xsl:template match="t:surface/@lrx"></xsl:template>
    <xsl:template match="t:surface/@lry"></xsl:template>
    
    <xsl:template match="t:hi[@rend='textColour:RED; fontSize:0.0; kerning:0;']">
        <hi rend="textColour:RED;"><xsl:apply-templates/></hi>
    </xsl:template>
    
    <xsl:template match="t:hi[@rend='underlined:true; fontSize:0.0; kerning:0;']">
        <hi rend="underlined;"><xsl:apply-templates/></hi>
    </xsl:template>
    
    <xsl:template match="@facs"/>
    
    <xsl:template match="t:supplied">
        <xsl:copy>
            <xsl:apply-templates select="*|@*|text()"/>
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="t:TEI">
        <xsl:copy>
            <xsl:apply-templates select="t:teiHeader"/>
        <facsimile>
            <xsl:apply-templates select="t:facsimile/t:surface"/>
        </facsimile> 
            <xsl:apply-templates select="*[name()!='facsimile']except t:teiHeader"/>
        </xsl:copy>
    </xsl:template>
    <xsl:template match="t:zone"></xsl:template>
    <xsl:template match="t:graphic">
        <xsl:copy>
        <xsl:attribute name="xml:id">
            <xsl:text>IMG.</xsl:text>
            <xsl:choose>
                <xsl:when test="starts-with(@url,'0') and contains(@url,'.')">
                    <xsl:value-of select="substring-before(substring-after(@url,'0'),'.')"/>
                </xsl:when>
                <xsl:when test="starts-with(@url,'0')">
                    <xsl:value-of select="substring-after(@url,'0')"/>
                </xsl:when>
                <xsl:when test="contains(@url,'.') and string-length(substring-before(@url,'.'))>4">
                    <xsl:value-of select="substring(substring-before(@url,'.'), string-length(substring-before(@url,'.')) -3)"/>
                </xsl:when>
                <xsl:when test="contains(@url,'.') and string-length(substring-before(@url,'.'))&lt;=4">
                    <xsl:value-of select="substring-before(@url,'.')"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="."/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:attribute>
            <xsl:apply-templates select="*|@*|text()"/>
        </xsl:copy>
    </xsl:template>
    <xsl:template match="t:graphic/@url">    
       <xsl:attribute name="url"><xsl:value-of select="replace(.,'\.tiff|\.tif','.jpg')"/></xsl:attribute>          
    </xsl:template>
    <xsl:template match="t:graphic/@width"></xsl:template>
    <xsl:template match="t:graphic/@height"></xsl:template>
    
    <!--<xsl:template match="t:p//text()">
      
        <xsl:analyze-string select="." regex="!(.*?)!">
            <xsl:matching-substring>
                <hi rend="sup"><xsl:value-of select="regex-group(1)"/></hi>
            </xsl:matching-substring>
            <xsl:non-matching-substring>
                <xsl:value-of select="."/>
            </xsl:non-matching-substring>
        </xsl:analyze-string>
        
    </xsl:template>-->
</xsl:stylesheet>
