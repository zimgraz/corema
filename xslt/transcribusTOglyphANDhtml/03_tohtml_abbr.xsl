<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:t="http://www.tei-c.org/ns/1.0"
    exclude-result-prefixes="xs" version="2.0">
    <!--  xmlns="http://www.tei-c.org/ns/1.0" -->
    
    <xsl:variable name="charDecl" select="document('characterDecl_corema.xml')/t:TEI/t:teiHeader/t:encodingDesc/t:charDecl"/>
   
    <xsl:template match="/t:TEI">

        <html>
            <head>
                <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
                <link rel="stylesheet" type="text/css" href="../MS1609.css"/>
                <title/>

            </head>
            <body>
               
                <xsl:apply-templates select="t:text/t:body" />

            </body>
        </html>

    </xsl:template>





    <!-- Seitenumbruch kennzeichnen, Seitenzahl auslesen, Folio auslesen -->
    <!-- ACHTUNG: Funktioniert wohl nicht einheitlich, weil sich der Dateiname des Bildes duch die Sigle immer ändern wird: "substring" muss anders ausgelesen werden -->
    <xsl:template match="t:pb"> 
        <xsl:variable name="vglID" select="substring(@facs, 2)"/>
        <hr/>
        <h1><xsl:text>Seite: </xsl:text>
            <xsl:value-of select="@n"/>
            <xsl:text> (fol. </xsl:text>
            <xsl:value-of select="//ancestor::t:facsimile/@xml:id[. = $vglID]/parent::t:facsimile/descendant::t:graphic/substring(@url, 1, 5)"/>
            <xsl:text>)</xsl:text>
        </h1>
    </xsl:template>
    
    
    <!-- Seitenstruktur aufbauen: Seite als <div>, Line als <br>-->
    
    <xsl:template match="t:p">
        <div>
            <xsl:apply-templates/>
        </div>
    </xsl:template>
    
    <xsl:template match="t:lb">
        
         <!-- Zeilennummern schreiben  -->   
        <br/><span class="bold"><xsl:value-of select="@n"/><xsl:text>:    </xsl:text></span>
        <xsl:apply-templates/>
    </xsl:template>
    
   <!-- <!-\- Hochstellung -\->
    <xsl:template match="t:hi[@rend ='super']">
        <sup>
            <xsl:value-of select="."/>
        </sup>  
    </xsl:template>
    
    <!-\- Tiefstellung -\->
    <xsl:template match="t:hi[@rend ='sub']">
        <sub>
            <xsl:value-of select="."/>
        </sub>  
    </xsl:template>-->
    
  <!--   Rubrizierungen -->
  <!--  <xsl:template match="*[@rend ='red']">
        <span class="red">
            <xsl:value-of select="."/>
        </span>  
        -->
    <!--</xsl:template>-->
    
    <!--
        <xsl:template match="t:hi[@rend ='vertical_dash:red']">
        <span class="vertical">
            <xsl:value-of select="."/>
        </span>  
    </xsl:template>-->
    
 
   <!--<xsl:template match="t:hi[@rend ='underline:red']">
        <span class="underline">
            <xsl:value-of select="."/>
        </span>  
        <xsl:apply-templates/>
    </xsl:template> -->
    
    <!-- Deleted Passages -->
    <xsl:template match="t:del">
        <span class="del">
            <xsl:value-of select="."/>
        </span>
    </xsl:template>
    
    
    
    <xsl:template match="t:abbr">
        <xsl:apply-templates/>
    </xsl:template>

    
    
    <xsl:template match="t:ex">
       <!-- <span class="kuerzg">
            <xsl:text>/</xsl:text><xsl:value-of select="."/>
        </span>
        <xsl:apply-templates/>-->
    </xsl:template>
    
    <!-- Highlight <supplied> text -->
    <xsl:template match="t:supplied">
        <span class="supplied">
            <xsl:value-of select="."/>
        </span>
    </xsl:template>
   

    <xsl:template match="t:note">
        <span class="note">
            <xsl:text>[</xsl:text><xsl:value-of select="."/><xsl:text>]</xsl:text>
        </span>  
    </xsl:template>
    
    <xsl:template match="t:hi[@rend ='sub']">
        <sub>
            <xsl:apply-templates/>
        </sub>  
    </xsl:template>
    
    <xsl:template match="t:hi[@rend ='sup']">
        <sup>
            <xsl:apply-templates/>
        </sup>  
    </xsl:template>
    
    <!-- match only glyphs -->
    <xsl:template match="t:g">
        <xsl:param name="url"><xsl:text></xsl:text></xsl:param>
        <xsl:variable name="zeichenID">
            <xsl:value-of select="substring(@ref,2)"/>
        </xsl:variable>
        <xsl:choose>
            <xsl:when test="$url=''">
                <xsl:value-of select="$charDecl/t:glyph[@xml:id=$zeichenID]/child::t:mapping[@subtype='html_entity']"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="doc('http://ressource_url')//t:glyph[@xml:id=$zeichenID]/child::t:mapping[@subtype='html_entity']"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    
    
    
    
  
    
</xsl:stylesheet>
