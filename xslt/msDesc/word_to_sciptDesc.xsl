<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:t="http://www.tei-c.org/ns/1.0"
    exclude-result-prefixes="xs t"
    version="2.0">
    
    <xsl:template match="/">
        <scriptDesc facs="{//t:p[@rend='Folio']}">
            <xsl:for-each select="//t:table/t:row/t:cell[1]">
                <xsl:if test="not(@rend='Hand')">
                <scriptNote>
                    <xsl:if test="preceding::t:cell[@rend='Hand'][1]">
                        <xsl:attribute name="source">
                            <xsl:value-of select="preceding::t:cell[@rend='Hand'][1]"/>
                        </xsl:attribute>
                    </xsl:if>
                    <desc><xsl:value-of select="."/></desc>
                    <xsl:if test="following-sibling::t:cell[1]!=''">
                    <p><xsl:value-of select="following-sibling::t:cell[1]"/></p>
                    </xsl:if>
                    <xsl:if test="following-sibling::t:cell[2]!=''">
                        <p>
                       <xsl:choose> <xsl:when test="following-sibling::t:cell[2]//t:graphic">
                            <xsl:for-each select="following-sibling::t:cell[2]//t:graphic">
                                <graphic url="{normalize-space(following::text()[1])}.jpg" facs="{normalize-space(following::text()[1])}" xml:id="{upper-case(concat(//t:p[@rend='abbr'],'_',normalize-space(following::text()[1])))}">
                                <xsl:if test="matches(preceding-sibling::text()[1],'\w')">
                                   <xsl:attribute name="ana">
                                       <xsl:value-of select="normalize-space(preceding-sibling::text()[1])"/>
                                   </xsl:attribute>
                                </xsl:if>
                                </graphic>
                            </xsl:for-each>
                        </xsl:when>
                            <xsl:otherwise>
                            <xsl:value-of select="following-sibling::t:cell[2]"/>
                            </xsl:otherwise></xsl:choose>
                        </p>
                    </xsl:if>
                </scriptNote>
                </xsl:if>
            </xsl:for-each>
        </scriptDesc>
    </xsl:template>
    
    
</xsl:stylesheet>