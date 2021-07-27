<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:t="http://www.tei-c.org/ns/1.0" exclude-result-prefixes="#all" version="3.0">
  
  <xsl:output encoding="UTF-8" method="text"/>
    <xsl:template match="/">
        <xsl:variable name="all_current_teis"
            select="collection('file:///C:\Users\steinerc\Desktop\ingest\glyph?select=*.xml;recurse=yes')"/>
      
         [
        <xsl:for-each select="$all_current_teis">
            <xsl:variable name="teipid">
                <xsl:value-of select="//t:idno[@type = 'PID']"/>
            </xsl:variable>
            <xsl:variable name="abbr">
                <xsl:apply-templates select="//t:msDesc/t:msIdentifier/t:altIdentifier[@type='abbr']/t:idno/normalize-space()"/>
            </xsl:variable>
            <xsl:variable name="sigle">
                <xsl:apply-templates select="//t:msDesc/t:msIdentifier/t:settlement/normalize-space()"/><xsl:text>, </xsl:text><xsl:value-of select="//t:msDesc/t:msIdentifier/t:institution/normalize-space()"/><xsl:if test="//t:msDesc/t:msIdentifier/t:repository"><xsl:text>, </xsl:text><xsl:value-of select="//t:msDesc/t:msIdentifier/t:repository/normalize-space()"/></xsl:if><xsl:text>, </xsl:text><xsl:value-of select="//t:msDesc/t:msIdentifier/t:idno/normalize-space()"/>
            </xsl:variable>
            <xsl:variable name="lang">
                <xsl:for-each select="//t:msPart[@ana='cooking_recipes']/t:msContents/t:textLang/t:lang"><xsl:apply-templates select="./normalize-space()"/><xsl:choose><xsl:when test="position() = last()"/><xsl:otherwise>, </xsl:otherwise></xsl:choose></xsl:for-each>
            </xsl:variable>
            <xsl:variable name="coverage">
                <xsl:value-of select="normalize-space(//t:settlement[1])"/>
            </xsl:variable>
            <xsl:variable name="dating">
                <xsl:apply-templates select="//t:origDate/t:date[@xml:lang='en']/normalize-space()"/>
            </xsl:variable>
            <xsl:variable name="dating_norm">
                <xsl:variable name="from" select="//t:origDate/t:date[1]/@notBefore"></xsl:variable>
                <xsl:variable name="to" select="//t:origDate/t:date[1]/@notAfter"></xsl:variable>
                <xsl:variable name="when" select="//t:origDate/t:date[1]/@when"></xsl:variable>
                <xsl:choose>
                    <xsl:when test="$when">
                        <xsl:value-of select="normalize-space($when)"></xsl:value-of>
                    </xsl:when>
                    <xsl:when test="$from=$to">
                        <xsl:value-of select="normalize-space($from)"></xsl:value-of>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="normalize-space($from)"></xsl:value-of>
                        <xsl:text>/</xsl:text>
                        <xsl:value-of select="normalize-space($to)"></xsl:value-of>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:variable>
            <xsl:variable name="origin">
                <xsl:choose>
                    <xsl:when test="//t:history/t:origin/t:origPlace/t:placeName">
                        <xsl:apply-templates select="//t:history/t:origin/t:origPlace/t:placeName[@xml:lang='en']/normalize-space()"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="//t:history/t:origin/t:origPlace/normalize-space()"/>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:variable>
            <xsl:variable name="recipesC">
                <xsl:choose>
                    <xsl:when test="count(//t:seg[not(@*)])!=0">
                        <xsl:value-of select="count(//t:seg[not(@*)])"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:text>no recipes yet</xsl:text>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:variable>
            
            {
            "source_collection": "<xsl:value-of select="$abbr"/>",
            "source": "<xsl:value-of select="$abbr"/>",
            "source_ms_sigle": "<xsl:value-of select="$sigle"/>",
            "coverage": "<xsl:value-of select="$coverage"/>",
            "lang": "<xsl:value-of select="$lang"/>",
            "dating": "<xsl:value-of select="$dating"/>",
            "dating_norm": "<xsl:value-of select="$dating_norm"/>",
            "origin": "<xsl:value-of select="$origin"/>",
            "recipesC": "<xsl:value-of select="$recipesC"/>"
            }<xsl:if test="position()!=last()">,</xsl:if>
        </xsl:for-each>
         ]
        
    </xsl:template>
  
    
</xsl:stylesheet>