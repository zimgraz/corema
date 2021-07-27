<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:t="http://www.tei-c.org/ns/1.0" xmlns="http://www.tei-c.org/ns/1.0"
    exclude-result-prefixes="t xs xsl" version="2.0">
    
    <xsl:output method="xml" indent="yes"/>
    
    <xsl:strip-space elements="t:surface"/>
    
    <xsl:template match="* | @* | text()">
        
        <!-- Alles kopieren -->
        <xsl:copy>
            <xsl:apply-templates select="* | @* | text()"/>
        </xsl:copy>
        
    </xsl:template>          
    
    <xsl:template match="t:teiHeader">       
            <teiHeader>
                <fileDesc>
                    <titleStmt>
                        <title>Electronic transcription of "Signatur"</title>
                    </titleStmt>
                    <editionStmt>
                        <edition>Hyperdiplomatische Basistranskription der Handschrift ...</edition>
                        <editor>
                            <forename>Astrid</forename>
                            <surname>Böhm</surname>
                        </editor> 
                        <principal>
                            <forename>Helmut W.</forename>
                            <surname>Klug</surname>
                        </principal>
                        <funder></funder>
                    </editionStmt>
                    <publicationStmt>
                        <publisher>
                            <ref target="https://informationsmodellierung.uni-graz.at"></ref>
                            <orgName ref="http://d-nb.info/gnd/1137284463">ZIM-ACDH, Universität Graz</orgName>
                        </publisher>
                        <authority>
                            <ref target="https://informationsmodellierung.uni-graz.at"></ref>
                            <orgName ref="http://d-nb.info/gnd/1137284463">Zentrum für Informationsmodellierung -
                                Austrian Centre for Digital Humanities, Karl-Franzens-Universität Graz</orgName>
                        </authority>
                        <distributor>
                            <ref target="https://gams.uni-graz.at"></ref>
                            <orgName>GAMS - Geisteswissenschaftliches Asset Management System</orgName>
                        </distributor>
                        <availability>
                            <licence n="text" target="https://creativecommons.org/licenses/by/4.0">Creative Commons BY
                                4.0</licence>
                            <licence n="manuscript facsimiles" target="https://creativecommons.org/licenses/by-nc-sa/3.0/at/">Creative Commons BY-NC-SA 3.0
                            </licence>
                        </availability>
                        <date when="2020"></date>
                        <pubPlace>Graz</pubPlace>
                        <idno type="PID">o:corema.<xsl:value-of select="lower-case(substring-before(substring-after(//t:surface[1]/@start,'#'),'_'))"/></idno>
                    </publicationStmt>
                    <sourceDesc>
                        <msDesc>
                            <msIdentifier>
                                <country></country>
                                <region></region>
                                <settlement></settlement>
                                <institution></institution>
                                <repository></repository>
                                <idno></idno>
                                <msName></msName>
                                <altIdentifier type="abbr">
                                    <idno><xsl:value-of select="substring-before(substring-after(//t:surface[1]/@start,'#'),'_')"/></idno>
                                </altIdentifier>
                            </msIdentifier>
                            <head>
                                <title></title>
                                <note></note>
                                <origPlace></origPlace>
                                <origDate></origDate>
                            </head>
                            <msContents>
                            </msContents>
                            <physDesc>
                                <objectDesc form="composite-Manuscript">
                                    <supportDesc material="">
                                        <support>
                                            <graphic url=".jpg" corresp="#Spiegelvorne"/>
                                            <graphic url="1r.jpg" corresp="#L1leer"/>
                                            <graphic url="1v.jpg" corresp="#L1leer"/>
                                        </support> 
                                        <extent>
                                            <measure unit="leaf" type="leavesCount"></measure>
                                            <dimensions type="block" unit="mm">
                                                <height></height>
                                                <width></width>
                                            </dimensions> 
                                        </extent>
                                        <foliation>
                                            <ab type="completeness"></ab>
                                        </foliation>
                                        <collation>
                                            <formula style="chroust"></formula>
                                            <catchwords></catchwords>
                                            <locusGrp xml:id="E">
                                                <locus n="layernm" xml:id="layerid">Einband</locus>
                                                <locus n="layernm" xml:id="layerid2">Einband</locus>
                                            </locusGrp>
                                            
                                        </collation>
                                        <condition>
                                            <desc></desc>
                                            <material></material>
                                            <watermark xml:id="" >
                                                <!-- text -->
                                                <supplied></supplied>
                                                <locusGrp>
                                                    <locus></locus>
                                                    
                                                </locusGrp>
                                            </watermark>
                                            
                                            
                                        </condition>
                                    </supportDesc>
                                    <layoutDesc>
                                        <layout columns=""> 
                                            <p style="meassure"></p>
                                            <p style="Schriftraum"></p>
                                            <p style="Zeilen"></p>
                                        </layout>
                                    </layoutDesc>
                                </objectDesc>
                                <handDesc><ab></ab></handDesc>
                                <scriptDesc><ab></ab></scriptDesc>
                                <bindingDesc>
                                    <binding corresp="#Einband">  
                                        <decoNote type="decoPlaceDate">
                                            <origPlace></origPlace>
                                            <origDate>1510</origDate>
                                        </decoNote>
                                        <decoNote type="bindingMaterial">
                                            <material></material>
                                            <material></material> 
                                        </decoNote>
                                        <decoNote type="decoration"></decoNote>
                                        
                                        <decoNote type="decoration">
                                            <note> </note>
                                        </decoNote>
                                        <decoNote type="metal"></decoNote>
                                        <decoNote type="clasps"></decoNote>
                                        <decoNote type="spine"></decoNote>
                                        <decoNote type="added"></decoNote>
                                        <decoNote type="wastepaper">Makulatur <!-- wenn vorhanden -->
                                            
                                        </decoNote>
                                    </binding>
                                </bindingDesc>
                            </physDesc>
                            <history>
                                <origin notBefore="" notAfter="">
                                    <origDate></origDate>
                                    <note></note>
                                    <origPlace cert="high"></origPlace>
                                    <orgName role="scriptorium"></orgName>
                                    <note type="purpose"></note> 
                                    <note type="binding"></note>
                                    <note type="part"></note> </origin> 
                                <provenance></provenance> 
                                <acquisition>
                                    <!-- text -->
                                    <signatures>
                                        <!-- text -->
                                    </signatures>
                                </acquisition>
                            </history>
                            <additional> 
                                <listBibl>
                                    <head></head>
                                    <bibl></bibl>  
                                </listBibl>
                            </additional>
                            <!-- for composite Manuscripts: -->
                            <msPart xml:id="">
                                <msIdentifier>
                                    <idno></idno>
                                </msIdentifier>
                                <head></head>
                                <msContents>
                                    <summary></summary>
                                    <msItem>
                                        <locus></locus> 
                                        <title></title>
                                        <author xml:lang=""></author>
                                        <textLang></textLang>
                                        <textLang></textLang>
                                        <filiation></filiation> 
                                        
                                        <incipit><locus></locus> </incipit> 
                                        
                                    </msItem>
                                </msContents>
                                
                                <physDesc>
                                    <objectDesc>
                                        <supportDesc> <support><!-- text -->
                                            <formula></formula> <formula></formula>
                                            <!-- text --></support>
                                        </supportDesc>
                                    </objectDesc>
                                    
                                </physDesc>
                                <history>
                                    <summary></summary>
                                </history>
                                <additional>
                                    <listBibl> <bibl></bibl></listBibl>
                                </additional>
                            </msPart>
                            
                            <msPart xml:id="">
                                <msIdentifier>
                                    <idno></idno>
                                </msIdentifier>
                                <head>älterer Eintragskalender und Erstes Speisenbuch</head>
                                <msContents>
                                    <summary></summary>
                                    <msItem xml:id=""> 
                                        <locus></locus> 
                                        <title></title>
                                        <author xml:lang=""></author>
                                        <textLang></textLang>
                                        <rubric></rubric>
                                        <incipit></incipit>
                                        <incipit><locus></locus></incipit> 
                                    </msItem>
                                    
                                    <msItem xml:id=""> 
                                        <locus></locus> <title></title>
                                        <author xml:lang=""></author>
                                        <textLang></textLang>
                                        <rubric>V</rubric> 
                                        <incipit><locus></locus> 
                                            <!-- text -->
                                        </incipit>
                                    </msItem>
                                </msContents>
                                <physDesc>
                                    <objectDesc>
                                        <supportDesc>
                                            <support><!-- text -->
                                                <formula></formula>
                                                <!-- text -->
                                            </support> 
                                        </supportDesc>
                                    </objectDesc>
                                    <handDesc>
                                        <ab/>
                                    </handDesc>
                                </physDesc>
                                <history>
                                    <summary></summary>    
                                </history>
                                <additional>
                                    <listBibl>
                                        <bibl></bibl>  
                                    </listBibl>
                                </additional>
                            </msPart>
                            
                            
                        </msDesc>
                        
                    </sourceDesc>
                </fileDesc>
            </teiHeader>
           
        
        
    </xsl:template>
    
    
</xsl:stylesheet>
