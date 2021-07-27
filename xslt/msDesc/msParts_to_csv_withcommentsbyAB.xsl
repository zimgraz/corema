<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:t="http://www.tei-c.org/ns/1.0"
    exclude-result-prefixes="xs" version="2.0">
    <xsl:output method="text" omit-xml-declaration="yes" indent="no" encoding="UTF-8"/>
    <xsl:strip-space elements="*"/>
    <xsl:variable name="all_current_teis"
        select="collection('file:///Volumes/Data/Dropbox/ASTRID/_glyph_Auswertung?select=*.xml;recurse=yes')"/>
    
    <!-- alle glyph, die ich ausgewertet haben will,  müssen in einem Ordner liegen, dementsprechend Pfad angeben 
    alles was vor dem Fragezeichen steht selbst anpassen - dateipfad-->

    <xsl:template match="/">

        <xsl:text>ID, MS, Folio, Sice, Main Lang, Other Lang, Date, Title, Category&#13;&#10;</xsl:text><!-- Überschriften, die im Exel erscheinen (das letzte ist der Zeilenumbruch) -->
        <xsl:for-each select="$all_current_teis"><!--  Befehl: nimm alle dateien-->
            <xsl:apply-templates select="//t:msItem"/><!-- hängt mit der Anwendung unten zusammen, 
                wenn nur das t: davor steht dann werden die Abfragen unten nur auf  msItem angewendet -->
        </xsl:for-each>

    </xsl:template>


    <xsl:template match="t:msItem">
        <xsl:value-of select="@xml:id"/>
        <xsl:text>,</xsl:text> <!-- mit dem Komma werden die Einträge getrennt, später wird das im Exel als Trennstelle gewertet -->
        <xsl:value-of select="normalize-space(//t:altIdentifier[@type = 'abbr']/t:idno)"/><!-- x-path bezieht sich auf das ganze xml, weil Doppelstrich ... -->
        <xsl:text>,"</xsl:text><!-- Anführungszeichen verhindern, dass irgendwelche Sonderzeichen Schwierigkeiten machen -> nimm alles wörtlich -->
        <xsl:value-of select="normalize-space(t:locus)"/><!-- x-path bezieht sich auf msItems, weil direkt das t da steht -->
        <xsl:text>","</xsl:text>
        <xsl:value-of select="normalize-space(//t:measure)"/>
        <xsl:text>","</xsl:text>
        <xsl:value-of select="normalize-space(preceding-sibling::t:textLang/t:lang[1])"/>
        <xsl:text>","</xsl:text> 
        <xsl:value-of select="normalize-space(preceding-sibling::t:textLang/t:lang[2])"/>    
        <xsl:text>","</xsl:text>
        <xsl:value-of select="normalize-space(//t:origDate/t:date[@xml:lang='de'])"/>
        <!--<xsl:text>","</xsl:text>
        <xsl:value-of select="normalize-space(//msPart[@ana='cooking_recipes']/t:head)"/>--><!--wirft problem warum?  -->
        <xsl:text>","</xsl:text>
        <xsl:value-of select="normalize-space(t:title)"/><!-- x-path bezieht sich auf msItems, weil direkt das t da steht -->
        <xsl:text>",</xsl:text>
        <xsl:value-of select="@corresp"/>
        <xsl:text>&#13;&#10;</xsl:text> <!-- Zeilenumbruch -->

    </xsl:template>

</xsl:stylesheet>
