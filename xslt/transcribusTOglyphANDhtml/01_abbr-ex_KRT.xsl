<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:t="http://www.tei-c.org/ns/1.0" xmlns:functx="http://www.functx.com" xmlns="http://www.tei-c.org/ns/1.0"
    exclude-result-prefixes="t xs xsl functx" version="2.0">
    <!-- xmlns="http://www.tei-c.org/ns/1.0"-->
    
    <xsl:variable name="charDecl" select="document('characterDecl_corema.xml')/t:TEI/t:teiHeader/t:encodingDesc/t:charDecl"/>
    
    <xsl:function name="functx:escape-for-regex" as="xs:string"
        xmlns:functx="http://www.functx.com">
        <xsl:param name="arg" as="xs:string?"/>
        
        <xsl:sequence select="
            replace($arg,'(\.|\[|\]|\\|\||\-|\^|\$|\?|\*|\+|\{|\}|\(|\))','\\$1')"/>
        
    </xsl:function>
    
    <xsl:template match="* except t:choice | @* | text()">
        
        <!-- Alles kopieren -->
        <xsl:copy>
            <xsl:apply-templates select="* | @* | text()"/>
        </xsl:copy>
    </xsl:template>
    
    <!-- Text schreiben -->
    
    <xsl:template match="t:p">
        
        <p>
            <xsl:apply-templates/>
        </p>
        
    </xsl:template>
       
    <!-- Variable wird mit string-join() und dem 'oder' für die regex-Syntax vorbereitet  -->
    
    <!-- Glyphe innerhalb der abbr ersetzen: t:glyph[@n = 'abbr']  --> 
    
    <xsl:template match="t:TEI/t:text//t:choice//text()">
        <xsl:variable name="search-string" select="$charDecl//t:glyph[@n = 'abbr']/t:mapping[@type = 'transcription']"/>
        <xsl:variable name="glyph_id"
            select="$search-string/parent::t:glyph/@xml:id"/>
        <xsl:variable name="replace-regex" as="xs:string" select="string-join($search-string, '|')"/>
        <xsl:variable name="context" select="."/>
               
                   <xsl:analyze-string select="." regex="{$replace-regex}">
                       <xsl:matching-substring>
                           <xsl:variable name="transcription" as="xs:string" select="functx:escape-for-regex(.)"/>
                           
                           <xsl:variable name="glyph_id" as="xs:string"
                               select="$search-string[. = $transcription]/parent::t:glyph/@xml:id"/>
                           <xsl:variable name="normalized" as="xs:string"
                               select="$search-string[. = $transcription]/preceding-sibling::t:mapping[@type = 'normalized']"/>
                           <ex>
                               <xsl:value-of select="$normalized"/>
                           </ex>
                           <am>
                               <g ref="#{$glyph_id}"/>
                           </am>     
                       </xsl:matching-substring>
                       <xsl:non-matching-substring>
                           <xsl:value-of select="."/>
                       </xsl:non-matching-substring>
                   </xsl:analyze-string>
                      
    </xsl:template>
    <xsl:template match="t:TEI/t:text//t:choice/t:expan"/>

</xsl:stylesheet>
