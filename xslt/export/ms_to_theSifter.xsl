<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:t="http://www.tei-c.org/ns/1.0"
    exclude-result-prefixes="xs"
    version="2.0">
    <xsl:output method="text" omit-xml-declaration="yes" indent="no" encoding="UTF-8"/>
    <xsl:strip-space elements="*" />
    <xsl:variable name="all_current_teis"
        select="collection('file:///C:\Users\ch11\Desktop\ingest?select=*.xml;recurse=yes')"/>
    
    <xsl:template match="/">
        
        <xsl:text>Row,Detail ID,Author,Work,Pub Year,Section Type,Section Title,Item Type,Item Cat,Item Sub Cat,Item,Quantity,Notes&#13;&#10;</xsl:text>
        <xsl:for-each select="$all_current_teis">
            <xsl:apply-templates select="//t:text/t:body/t:div"/>
        </xsl:for-each>
        
    </xsl:template>
    

    <xsl:template match="t:text/t:body/t:div">
        
        <xsl:for-each select="t:ab[@type][not(@subtype)]//t:ingredient">
                    
            
            <xsl:text>,,CoReMA,</xsl:text>
                <xsl:text>"MS </xsl:text>
                <xsl:value-of select="normalize-space(//t:msDesc/t:msIdentifier[1]/t:settlement)"></xsl:value-of>
                <xsl:text>, </xsl:text>
                <xsl:value-of select="normalize-space(//t:msDesc/t:msIdentifier[1]/t:institution)"></xsl:value-of>
                <xsl:if test="//t:msDesc/t:msIdentifier[1]/t:repository">
                    <xsl:text>, </xsl:text>
                    <xsl:value-of select="normalize-space(//t:msDesc/t:msIdentifier[1]/t:repository)"></xsl:value-of>
                </xsl:if>
                <xsl:text>, </xsl:text>
                <xsl:value-of select="normalize-space(//t:msDesc/t:msIdentifier[1]/t:idno)"></xsl:value-of>
                <xsl:text> (</xsl:text>
                <xsl:value-of select="normalize-space(//t:msDesc/t:msIdentifier[1]/t:altIdentifier[@type=&apos;abbr&apos;]/t:idno)"></xsl:value-of>
                <xsl:text>)"</xsl:text>,<xsl:variable name="from" select="//t:origDate/t:date[1]/@notBefore"></xsl:variable>
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
            </xsl:choose>,Recipe,"<xsl:value-of select="(ancestor::t:ab//t:title)[1]/@key/normalize-space()"/><xsl:text>"</xsl:text>,Ingredient,,,<xsl:value-of select="@en"/>,,<xsl:text>Wikidata: </xsl:text><xsl:value-of select="@commodity"/><xsl:text>&#13;&#10;</xsl:text>
            
        </xsl:for-each>
        <xsl:for-each select="t:ab[@type][not(@subtype)]//t:tool">
            
            
            <xsl:text>,,CoReMA,</xsl:text>
            <xsl:text>"MS </xsl:text>
            <xsl:value-of select="normalize-space(//t:msDesc/t:msIdentifier[1]/t:settlement)"></xsl:value-of>
            <xsl:text>, </xsl:text>
            <xsl:value-of select="normalize-space(//t:msDesc/t:msIdentifier[1]/t:institution)"></xsl:value-of>
            <xsl:if test="//t:msDesc/t:msIdentifier[1]/t:repository">
                <xsl:text>, </xsl:text>
                <xsl:value-of select="normalize-space(//t:msDesc/t:msIdentifier[1]/t:repository)"></xsl:value-of>
            </xsl:if>
            <xsl:text>, </xsl:text>
            <xsl:value-of select="normalize-space(//t:msDesc/t:msIdentifier[1]/t:idno)"></xsl:value-of>
            <xsl:text> (</xsl:text>
            <xsl:value-of select="normalize-space(//t:msDesc/t:msIdentifier[1]/t:altIdentifier[@type=&apos;abbr&apos;]/t:idno)"></xsl:value-of>
            <xsl:text>)"</xsl:text>,<xsl:variable name="from" select="//t:origDate/t:date[1]/@notBefore"></xsl:variable>
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
            </xsl:choose>,Recipe,"<xsl:value-of select="(ancestor::t:ab//t:title)[1]/@key/normalize-space()"/><xsl:text>"</xsl:text>,Tool,,,<xsl:value-of select="@en"/>,,<xsl:text>Wikidata: </xsl:text><xsl:value-of select="@commodity"/><xsl:text>&#13;&#10;</xsl:text>
            
        </xsl:for-each>
        <xsl:for-each select="t:ab[@type][not(@subtype)]//t:dish">
            
            
            <xsl:text>,,CoReMA,</xsl:text>
            <xsl:text>"MS </xsl:text>
            <xsl:value-of select="normalize-space(//t:msDesc/t:msIdentifier[1]/t:settlement)"></xsl:value-of>
            <xsl:text>, </xsl:text>
            <xsl:value-of select="normalize-space(//t:msDesc/t:msIdentifier[1]/t:institution)"></xsl:value-of>
            <xsl:if test="//t:msDesc/t:msIdentifier[1]/t:repository">
                <xsl:text>, </xsl:text>
                <xsl:value-of select="normalize-space(//t:msDesc/t:msIdentifier[1]/t:repository)"></xsl:value-of>
            </xsl:if>
            <xsl:text>, </xsl:text>
            <xsl:value-of select="normalize-space(//t:msDesc/t:msIdentifier[1]/t:idno)"></xsl:value-of>
            <xsl:text> (</xsl:text>
            <xsl:value-of select="normalize-space(//t:msDesc/t:msIdentifier[1]/t:altIdentifier[@type=&apos;abbr&apos;]/t:idno)"></xsl:value-of>
            <xsl:text>)"</xsl:text>,<xsl:variable name="from" select="//t:origDate/t:date[1]/@notBefore"></xsl:variable>
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
            </xsl:choose>,Recipe,"<xsl:value-of select="(ancestor::t:ab//t:title)[1]/@key/normalize-space()"/><xsl:text>"</xsl:text>,Dish,,,<xsl:value-of select="@en"/>,,<xsl:text>Wikidata: </xsl:text><xsl:value-of select="@commodity"/><xsl:text>&#13;&#10;</xsl:text>
            
        </xsl:for-each>
 
    </xsl:template>
    
</xsl:stylesheet>