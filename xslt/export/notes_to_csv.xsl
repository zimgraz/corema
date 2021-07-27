<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:t="http://www.tei-c.org/ns/1.0"
    exclude-result-prefixes="xs" version="2.0">
    <xsl:output method="text" omit-xml-declaration="yes" indent="no" encoding="UTF-8"/>
    <xsl:strip-space elements="*"/>
    <xsl:variable name="all_current_teis"
        select="collection('file:///C:\Users\ch11\Desktop\ingest?select=*.xml;recurse=yes')"/>

    <xsl:template match="/">

        <xsl:text>ms,folio,lb,note_de,note_en&#13;&#10;</xsl:text>
        <xsl:for-each select="$all_current_teis">
            <xsl:apply-templates select="//t:body//t:note"/>
        </xsl:for-each>

    </xsl:template>


    <xsl:template match="t:note">

        <xsl:value-of select="normalize-space(//t:altIdentifier[@type = 'abbr']/t:idno)"/>
        <xsl:text>,</xsl:text>
        <xsl:value-of select="preceding::t:pb[1]/@n"/>
        <xsl:text>,</xsl:text>
        <xsl:value-of select="preceding::t:lb[1]/@n"/>
        <xsl:text>,"</xsl:text>
        <xsl:choose>
            <xsl:when test="@xml:lang">
                <xsl:value-of select="normalize-space(.[@xml:lang='de'])"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="normalize-space(.)"/>
            </xsl:otherwise>
        </xsl:choose>
        <xsl:text>","</xsl:text> 
        <xsl:value-of select="normalize-space(.[@xml:lang='en'])"/>    
        <xsl:text>"&#13;&#10;</xsl:text>

    </xsl:template>

</xsl:stylesheet>
