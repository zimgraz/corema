<?xml version="1.0" encoding="UTF-8"?>
<!--
    Workflow für den Import der neu erstellten QIds in die TEIs:
    
    1) Google Spreadsheet als csv exportieren und speichern unter /lists/Q0/Q0.csv
    2) Dieses csv in Oxygen importieren
        2.1) Datei -> Importieren -> Textdatei
        2.2) URL: /lists/Q0/Q0.csv Kodierung: UTF-8
        2.3) alles entfernen außer eng und Qid_new (x)
        2.4) Erste Zeile enthält Feldnamen anhaken
        2.5) Speichern unter /lists/Q0/Q0.xml
        2.6) Example Output:
       
             <row>
                 <deu-enh>a1.2r.2</ID>
                 <Qid_new>#cooking</Kategorie>
             </row>

    3) Dieses Stylesheet auf das gewünschte TEI Dokument (glyph) ausführen 
-->
<xsl:stylesheet version="3.0" xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:t="http://www.tei-c.org/ns/1.0"
    xmlns="http://www.tei-c.org/ns/1.0" exclude-result-prefixes="xs t">
    <xsl:mode on-no-match="shallow-copy"/>
    <xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes"/>
    <xsl:strip-space elements="*"/>
    
    <!--Hier liegen die tabellarischen Daten die dem TEI/XML Dokument hinzugefügt werden sollen:-->
    <xsl:param name="ids" select="document('../lists/Q0/Q0.xml')"/>
    
    <!--Dieser Key legt fest was verglichen werden soll (in diesem Fall der Inhalt des Elements <deu-enh> mit dem inhalt von t:ingredient und t:tool) und bezieht sich auf die tabellarischen Daten -->
    <xsl:key name="ref" match="row" use="eng"/>
    
    
    <!--Kopiere alles-->
    <xsl:template match="@* | node()">
        <xsl:copy>
            <xsl:apply-templates select="@* | node()"/>
        </xsl:copy>
    </xsl:template>
    <!--Hier wird das Element t:title ausgewählt da auch dort der Inhalt der tabellarischen Daten eingefügt werden soll.
        Danach wird die @xml:id von seinem ancestor t:ab verglichen mit dem key von den tab. Daten und von dort der Inhalt des Elements <title-english> eingefügt
    -->
    <xsl:template match="t:body//*[@commodity='Q0']">
        <xsl:copy>
            
                <xsl:attribute name="commodity">
                    <xsl:choose>
                        <xsl:when test="normalize-space(key('ref', @en, $ids)/Qid_new)">
                            <xsl:value-of select="normalize-space(key('ref', @en, $ids)/Qid_new)"/>
                        </xsl:when>
                        <xsl:otherwise>Q0</xsl:otherwise>
                    </xsl:choose>
                    
                </xsl:attribute>
            
            <xsl:apply-templates select="@* except @commodity| node()"/>
        </xsl:copy>
    </xsl:template>
</xsl:stylesheet>
