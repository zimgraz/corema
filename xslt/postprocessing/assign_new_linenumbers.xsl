<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:t="http://www.tei-c.org/ns/1.0" xmlns="http://www.tei-c.org/ns/1.0"
    exclude-result-prefixes="t xs xsl" version="2.0">
    
   
    
    <xsl:template match="* | @* | text()">
        
        <!-- Alles kopieren -->
        <xsl:copy>
            <xsl:apply-templates select="* | @* | text()"/>
        </xsl:copy>
        
    </xsl:template>
    
    

    <!-- es werden die lb neu gezaehlt. die zeilennr wird im @n festgelegt-->
    <xsl:template match="t:add/t:lb/@n">
        <xsl:attribute name="n"><xsl:text>N</xsl:text><xsl:number level="single" format="001" count="t:lb"/>
        </xsl:attribute>
    </xsl:template>
    <xsl:template match="t:add">
        <xsl:apply-templates/>
    </xsl:template>
    
</xsl:stylesheet>


<!-- Titeltrennung durch lb xpath -->
<!--//hi[@style='heading'][following-sibling::lb[following-sibling::hi[@style='heading']]]-->