<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:t="http://www.tei-c.org/ns/1.0" exclude-result-prefixes="#all" version="3.0">
  
  <xsl:output encoding="UTF-8" method="text"/>
    <xsl:template match="/">
        <xsl:variable name="all_current_teis"
            select="collection('file:///C:\Users\ch11\Desktop\ingest_gams\glyph\clean?select=*.xml;recurse=yes')"/>
      
        { 
        "events": [
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
            {
            "media": {
                "url": "/corema/img/cutouts/<xsl:value-of select="substring-after($teipid,'corema.')"/>.jpg",
            "caption": "<xsl:value-of select="$abbr"/>",
            "credit": "<xsl:value-of select="$sigle"/>"
            },
            "start_date": {
            "year": "<xsl:choose>
                <xsl:when test="//t:history/t:origin/t:origDate/t:date[1][@when]"><xsl:apply-templates select="//t:history/t:origin/t:origDate/t:date[1][@when]/@when"/></xsl:when>
                <xsl:when test="//t:history/t:origin/t:origDate/t:date[1][@notBefore]"><xsl:apply-templates select="//t:history/t:origin/t:origDate/t:date[1][@notBefore]/@notBefore"/></xsl:when>
                <xsl:otherwise>ERROR!</xsl:otherwise>
            </xsl:choose>"
            },<xsl:if test="//t:history/t:origin/t:origDate/t:date[1][@notAfter]">
            "end_date": {
            "year": "<xsl:apply-templates select="//t:history/t:origin/t:origDate/t:date[1][@notAfter]/@notAfter"/>" 
            },</xsl:if>
            "text": {
            "headline": "&lt;a href='/<xsl:value-of select="$teipid"/>' title='Go to hyperdiplomatic transcription'&gt;<xsl:value-of select="$abbr"/>&lt;/a&gt;",
            "text": "<xsl:if test="//t:msDesc/t:msIdentifier/t:msName">&lt;p&gt;&lt;i &gt;Customary title: &lt;/i&gt;<xsl:apply-templates select="//t:msDesc/t:msIdentifier/t:msName/normalize-space()"/>&lt;/p&gt;</xsl:if><xsl:if test="//t:origDate/t:date[@xml:lang='en']">&lt;p&gt;&lt;i&gt;Dating:&lt;/i&gt; <xsl:apply-templates select="//t:origDate/t:date[@xml:lang='en']/normalize-space()"/>&lt;/p&gt;</xsl:if><xsl:if test="//t:supportDesc/t:condition/t:material">&lt;p&gt;&lt;i&gt;Material:&lt;/i&gt; <xsl:apply-templates select="//t:supportDesc/t:condition/t:material[@xml:lang='en']/normalize-space()"/>&lt;/p&gt;</xsl:if><xsl:if test="//t:supportDesc/t:extent/t:dimensions">&lt;p&gt;&lt;i&gt;Number of folios: &lt;/i&gt; <xsl:apply-templates select="//t:supportDesc/t:extent/t:measure/normalize-space()"/>&lt;/p&gt;</xsl:if><xsl:if test="//t:supportDesc/t:extent/t:dimensions">&lt;p&gt;&lt;i&gt;Dimensions: &lt;/i&gt; <xsl:apply-templates select="//t:supportDesc/t:extent/t:dimensions/t:height/normalize-space()"/><xsl:text>mm x </xsl:text><xsl:apply-templates select="//t:supportDesc/t:extent/t:dimensions/t:width/normalize-space()"/><xsl:text>mm</xsl:text>&lt;/p&gt;</xsl:if>&lt;p&gt;&lt;i&gt;Origin: &lt;/i&gt;<xsl:choose><xsl:when test="//t:history/t:origin/t:origPlace/t:placeName"><xsl:apply-templates select="//t:history/t:origin/t:origPlace/t:placeName[@xml:lang='en']/normalize-space()"/></xsl:when><xsl:otherwise><xsl:value-of select="//t:history/t:origin/t:origPlace/normalize-space()"/></xsl:otherwise></xsl:choose> &lt;/p&gt;&lt;p&gt;&lt;i&gt;Languages: &lt;/i&gt;<xsl:for-each select="//t:msPart[@ana='cooking_recipes']/t:msContents/t:textLang/t:lang"><xsl:apply-templates select="./normalize-space()"/><xsl:choose><xsl:when test="position() = last()"/><xsl:otherwise>, </xsl:otherwise></xsl:choose></xsl:for-each>&lt;/p&gt;&lt;p&gt;&lt;a title='Go to hyperdiplomatic transcription' href='/<xsl:value-of select="$teipid"/>'>&lt;span class='oi oi-image'><xsl:text> </xsl:text>&lt;/span&gt;&lt;/a&gt;<xsl:text> </xsl:text>&lt;a title='Go to semantic annotation' href='/<xsl:value-of select="$teipid"/>.recipes'>&lt;span class='oi oi-layers'><xsl:text> </xsl:text>&lt;/span&gt;&lt;/a&gt;&lt;/p&gt;"           
                }            
            }<xsl:if test="position()!=last()">,</xsl:if>
        </xsl:for-each>
         ]
        }
    </xsl:template>
  
    
</xsl:stylesheet>