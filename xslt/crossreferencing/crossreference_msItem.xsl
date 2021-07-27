<?xml version="1.0" encoding="UTF-8"?>
<!--
    Workflow für den Import der msItem Kategorien in die TEIs:
    
    1) Google Spreadsheet als csv exportieren und speichern unter /lists/msItem/msItem.csv
    2) Dieses csv in Oxygen importieren
        2.1) Datei -> Importieren -> Textdatei
        2.2) URL: /lists/msItem/msItem.csv Kodierung: UTF-8
        2.3) title-deu-enh und dish entfernen (x)
        2.4) Erste Zeile enthält Feldnamen anhaken
        2.5) Speichern unter /lists/recipeTitles/recipeTitles.xml
        2.6) Example Output:
       
             <row>
                 <ID>a1.2r.2</ID>
                 <Kategorie>#cooking</Kategorie>
             </row>

    3) Dieses Stylesheet auf das gewünschte TEI Dokument (glyph) ausführen 
-->
<xsl:stylesheet version="2.0" xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:t="http://www.tei-c.org/ns/1.0"
    xmlns="http://www.tei-c.org/ns/1.0" exclude-result-prefixes="xs t">
    <xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes"/>
    <xsl:strip-space elements="*"/>
    
    <!--Hier liegen die tabellarischen Daten die dem TEI/XML Dokument hinzugefügt werden sollen:-->
    <xsl:param name="ids" select="document('../lists/msItem/msItem.xml')"/>
    
    <!--Dieser Key legt fest was verglichen werden soll (in diesem Fall der Inhalt des Elements <xml-id></xml-id> mit @xml:id von t:ab) und bezieht sich auf die tabellarischen Daten -->
    <xsl:key name="ref" match="row" use="ID"/>
    
    
    <!--Kopiere alles-->
    <xsl:template match="@* | node()">
        <xsl:copy>
            <xsl:apply-templates select="@* | node()"/>
        </xsl:copy>
    </xsl:template>
    <!--Hier wird das Element t:title ausgewählt da auch dort der Inhalt der tabellarischen Daten eingefügt werden soll.
        Danach wird die @xml:id von seinem ancestor t:ab verglichen mit dem key von den tab. Daten und von dort der Inhalt des Elements <title-english> eingefügt
    -->
    <xsl:template match="t:teiHeader//t:msPart/t:msContents/t:msItem">
        <xsl:copy>
            
                <xsl:attribute name="corresp">
                    <xsl:value-of select="normalize-space(key('ref', @xml:id, $ids)/Kategorie)"/>
                </xsl:attribute>
            
            <xsl:apply-templates select="@* | node()"/>
        </xsl:copy>
    </xsl:template>
</xsl:stylesheet>
