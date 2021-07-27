<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:t="http://www.tei-c.org/ns/1.0"
    exclude-result-prefixes="xs" version="2.0">
    
    <xsl:variable name="charDecl" select="document('characterDecl_corema.xml')/t:TEI/t:teiHeader/t:encodingDesc/t:charDecl"/>
   
    <xsl:template match="/t:TEI">

        <html>
            <head>
                <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
                
                <title/>
                <style>
                  /*@font-face {
                    font-family: 'Cardo';
                    src: url('https://gams.uni-graz.at/fonts/Cardo/Cardo.eot');
                    src: url('https://gams.uni-graz.at/fonts/Cardo/Cardo.eot?#iefix') format('embedded-opentype'),
                    url('https://gams.uni-graz.at/fonts/Cardo/Cardo.woff2') format('woff2'),
                    url('https://gams.uni-graz.at/fonts/Cardo/Cardo.woff') format('woff'),
                    url('https://gams.uni-graz.at/fonts/Cardo/Cardo.ttf') format('truetype'),
                    url('https://gams.uni-graz.at/fonts/Cardo/Cardo.svg#Cardo') format('svg');
                    font-weight: normal;
                    font-style: normal;
                    }*/
                    
                    body {
                    font-family: 'Cardo';
                    line-height: 1.5;
                    font-size: 2em;
                    }
                    div {
                    padding-left: 50px;        
                    }
                    td {
                    vertical-align: top;
                    }
                    .red {
                    color: #B40404;
                    }
                    .underline {
                    /*text-decoration: underline;
                    color: #DF7401; */
                    border-bottom: 2px solid #B40404;
                    }
                    /* Hier werden noch nicht alle Instanzen angezeigt */
                    .vertical {
                    border-right: 2px solid #B40404;
                    }
                    .kuerzg {
                    font-family: sans-serif;
                    font-size: 0.9em;
                    color: #848484;
                    font-style: italic;
                    }
                    .supplied {
                    color: #009933;
                    }
                    .note {
                    font-family: sans-serif;
                    font-size: 0.9em;
                    color: #F5D0A9;
                    }
                    .bold {
                    font-weight: 900;
                    padding-right: 30px;    
                    }
                    .del                {
                    text-decoration: line-through;
                    }
                </style>
            </head>
            
            <body>
               
                <xsl:apply-templates select="t:text/t:body" />

            </body>
        </html>

    </xsl:template>





    <!-- Seitenumbruch kennzeichnen, Seitenzahl auslesen, Folio auslesen -->
    <!-- ACHTUNG: Funktioniert wohl nicht einheitlich, weil sich der Dateiname des Bildes duch die Sigle immer ändern wird: "substring" muss anders ausgelesen werden -->
    <xsl:template match="t:pb"> 
        <xsl:variable name="vglID" select="substring(@facs, 2)"/><!--  -->
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
    
    <!-- Rubrizierungen -->
    <!--<xsl:template match="*[@rend ='red']">
        <span class="red">
            <xsl:value-of select="."/>
        </span> --> 
        
    <!--</xsl:template>-->
    
    
<!--        <xsl:template match="t:hi[@rend ='vertical_dash:red']">
        <span class="vertical">
            <xsl:value-of select="."/>
        </span>  
    </xsl:template>-->
    
 
   <xsl:template match="t:hi[@rend ='underlined;']">
        <span class="underline">
            <xsl:apply-templates/>
        </span>  
       
    </xsl:template> 
    
    <!-- Highlight <supplied> text -->
    <xsl:template match="t:supplied">
        <span class="supplied">
            <xsl:text>{</xsl:text><xsl:value-of select="."/><xsl:text>}</xsl:text>
        </span>
    </xsl:template>
    
    <xsl:template match="t:del">
        <span class="del">
            <xsl:value-of select="."/>
        </span>
    </xsl:template>
    
    <!-- Heading blod -->
    <xsl:template match="t:hi[@style='heading']">
        <span class="bold">
            <!--<xsl:value-of select="."/>--><xsl:apply-templates/>
        </span>  
    </xsl:template> 
    
    <!-- Farbige Textbereiche -->
    <xsl:template match="t:hi[contains(@rend,':RED')]">
        <!--<xsl:if test="string-length()>0">-->
            <span style="color: red;">
                <xsl:apply-templates/>
            </span>  
        <!--</xsl:if>-->
    </xsl:template> 
    
    <!-- Farbige Zeichen -->
    <xsl:template match="t:g[contains(@rend,':RED')]">
         <xsl:param name="url"><xsl:text></xsl:text></xsl:param>
        
        <!--<xsl:if test="string-length()>0">-->
        <span style="color: red;">
           
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
        </span>  
        <!--</xsl:if>-->
    </xsl:template> 
    
    <xsl:template match="t:hi[not(@*)]">
        <span class="initiale" title="Initiale" style="font-size:40px;">
            <xsl:apply-templates/>
        </span>      
    </xsl:template>
    

    
    <xsl:template match="t:add">
        <span style="color: blue;" title="add">
            <xsl:apply-templates/>
        </span>        
    </xsl:template>
    
    
    <xsl:template match="t:abbr">
        <xsl:apply-templates/>
    </xsl:template>
    
    <xsl:template match="t:foreign">
        <span style="color:magenta;"><xsl:apply-templates/></span>
    </xsl:template>

    
    
    <xsl:template match="t:ex">
        <span class="kuerzg">
            <xsl:text>/</xsl:text><xsl:value-of select="."/>
        </span>
        
    </xsl:template>
    
  

    <xsl:template match="t:note">
        <span class="note">
            <xsl:text>[</xsl:text><xsl:value-of select="."/><xsl:text>]</xsl:text>
        </span>  
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
