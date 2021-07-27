<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:t="http://www.tei-c.org/ns/1.0"
    exclude-result-prefixes="xs t" version="3.0">
    <xsl:output encoding="UTF-8" indent="yes"/> 

   <xsl:template name="step1">
       <root>
          
       <xsl:for-each-group select="//t:ingredient[@commodity!='Q0']" group-by="@commodity">
           <!-- step1-->
           <ing>
               <xsl:for-each-group select="current-group()" group-by="@en">
                   <en><xsl:value-of select="current-grouping-key()"/></en>
               </xsl:for-each-group>
               <Q><xsl:value-of select="current-grouping-key()"/></Q>
           </ing>
       </xsl:for-each-group>
       </root>
   </xsl:template>
    
    <xsl:variable name="output">
        <xsl:call-template name="step1"/>
    </xsl:variable>
    
    <xsl:template match="/">
       <!-- step2-->
        <root>
            <xsl:copy-of select="$output//ing[en[2]]"/>
        </root>
    </xsl:template>
    
    
    
</xsl:stylesheet>
