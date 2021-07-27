<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:functx="http://www.functx.com" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:t="http://www.tei-c.org/ns/1.0" xmlns="http://www.tei-c.org/ns/1.0" exclude-result-prefixes="t xs xsl" version="2.0">
    <xsl:function name="functx:capitalize-first" as="xs:string?"
        xmlns:functx="http://www.functx.com">
        <xsl:param name="arg" as="xs:string?"/>
        
        <xsl:sequence select="
            concat(upper-case(substring($arg,1,1)),
            substring($arg,2))
            "/>
        
    </xsl:function>
    

 
    <xsl:template match="t:body/t:div/t:ab[@type][not(@subtype)]">
        <xsl:result-document href="./split_{substring-before(@xml:id,'.')}/{@xml:id}.xml">
            <xsl:processing-instruction name="xml-model">href="../../corema_schema/corema_single_recipe.sch" type="application/xml" schematypens="http://purl.oclc.org/dsdl/schematron"</xsl:processing-instruction>
            <xsl:processing-instruction name="xml-model">href="../../corema_schema/corema_single_recipe.rng" type="application/xml" schematypens="http://relaxng.org/ns/structure/1.0"</xsl:processing-instruction>
            <xsl:variable name="MSabbr">
                <xsl:choose>
                    <xsl:when test="contains(@xml:id,'m2') or contains(@xml:id,'m3') or contains(@xml:id,'h2') or contains(@xml:id,'ha1') or contains(@xml:id,'m5') or contains(@xml:id,'m13') or contains(@xml:id,'pa1') or contains(@xml:id,'sb2') or contains(@xml:id,'st1') or contains(@xml:id,'wo1') or contains(@xml:id,'wo3') or contains(@xml:id,'wo7') or contains(@xml:id,'wo9') or contains(@xml:id,'wo10') or contains(@xml:id,'wo11')">
                        <xsl:value-of select="replace(substring-before(@xml:id,'.'),'a\b|b\b|c\b','','!')"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="substring-before(@xml:id,'.')"/>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:variable>
            <xsl:variable name="Collabbr">
                   <xsl:value-of select="substring-before(@xml:id,'.')"/>
            </xsl:variable>
            <xsl:variable name="title" select="(.//t:title)[1]/@key/normalize-space()"/>
            
            <TEI xmlns="http://www.tei-c.org/ns/1.0">
                <teiHeader>
                    <fileDesc>
                        <titleStmt>
                            <title xml:lang="en"><xsl:value-of select="$title"/></title>
                            <xsl:choose>
                                <xsl:when test="(.//t:title)[1][@type='none']"></xsl:when>
                                <xsl:otherwise><title xml:lang="{@xml:lang}"><xsl:value-of select="(.//t:title)[1]/normalize-space()"/></title></xsl:otherwise>
                            </xsl:choose>
                        </titleStmt>
                        <editionStmt>
                            <edition>Semantic annotation of the recipe "<xsl:value-of select="$title"/>" (<xsl:value-of select="@xml:id"/>)</edition>
                            <respStmt>
                                <resp>edition</resp>
                                <xsl:choose>
                                    <xsl:when test="//t:editor/t:forename='Barbara'">
                                        <persName>Barbara Denicolò</persName>
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <persName>Julia Eibinger</persName>
                                        <persName>Helmut W. Klug</persName>
                                    </xsl:otherwise>
                                </xsl:choose>
                            </respStmt>
                            <respStmt>
                                <resp>transcription</resp>
                                <persName>Astrid Böhm</persName>
                            </respStmt>
                            <respStmt>
                                <resp>digital processing</resp>
                                <persName>Christian Steiner</persName>
                            </respStmt>
                            <principal>
                                <persName>Helmut W. Klug</persName>
                            </principal>
                            <funder ref="https://www.fwf.ac.at/">FWF I 3614</funder>
                        </editionStmt>
                        <publicationStmt>
                            <publisher>
                                <ref target="https://informationsmodellierung.uni-graz.at"/>
                                <orgName ref="http://d-nb.info/gnd/1137284463">ZIM-ACDH, University of Graz</orgName>
                            </publisher>
                            <authority>
                                <ref target="https://informationsmodellierung.uni-graz.at"/>
                                <orgName ref="http://d-nb.info/gnd/1137284463">ZIM-ACDH, University of Graz</orgName>
                            </authority>
                            <distributor>
                                <ref target="https://gams.uni-graz.at"/>
                                <orgName>GAMS - Geisteswissenschaftliches Asset Management System</orgName>
                            </distributor>
                            <xsl:copy-of select="//t:availability"/>
                            <date when="{format-date(current-date(), '[Y0001]-[M01]-[D01]')}"/>
                            <pubPlace>Graz</pubPlace>
                            <idno type="PID">o:corema.<xsl:value-of select="@xml:id"/></idno>
                        </publicationStmt>
                        <seriesStmt>
                            <ab>
                                <title ref="http://gams.uni-graz.at/corema">CoReMA - Cooking Recipes of the Middle Ages: Corpus, Analysis, Visualisation</title>
                                <ref target="http://gams.uni-graz.at/o:corema.about/TEI_SOURCE">About the project "CoReMA"</ref>
                                <ref target="http://gams.uni-graz.at/o:corema.imprint/TEI_SOURCE">Imprint of the project "CoReMA"</ref>
                            </ab>
                        </seriesStmt>
                        <sourceDesc>
                            <bibl type="corresponding_manuscript">
                                <xsl:copy-of select="//t:sourceDesc/t:msDesc/t:msIdentifier"/>
                            </bibl>
                            <bibl type="corresponding_collection">
                                <msIdentifier>
                                    <altIdentifier type="collection">
                                        <idno>
                                            <xsl:choose>
                                                <xsl:when test="preceding-sibling::t:milestone[@unit='collection']">
                                                    <xsl:value-of select="preceding-sibling::t:milestone[1][@unit='collection']/@n"/>
                                                </xsl:when>
                                                <xsl:otherwise>
                                                    <xsl:value-of select="//t:sourceDesc/t:msDesc/t:msIdentifier/t:altIdentifier[@type='abbr']/t:idno"/>
                                                </xsl:otherwise>
                                            </xsl:choose>
                                        </idno>
                                    </altIdentifier>
                                </msIdentifier>
                            </bibl>
                            <bibl type="manuscript_page">
                                <title>page in corresponding manuscript</title>
                                <ref type="uri" target="https://gams.uni-graz.at/o:corema.{$MSabbr}#{preceding::t:pb[1]/@xml:id}"/>
                            </bibl>
                            <bibl type="manuscript_tei_source">
                                <title>TEI source of corresponding manuscript</title>
                                <ref type="uri" target="https://gams.uni-graz.at/o:corema.{$MSabbr}/TEI_SOURCE"/>
                            </bibl>
                            <bibl type="manuscript_context">
                                <title>context of corresponding manuscript/collection</title>
                                <ref type="context" target="context:corema.{$Collabbr}"><xsl:text>Context for all recipes in manuscript "</xsl:text><xsl:value-of select="functx:capitalize-first($MSabbr)"/><xsl:text>"</xsl:text></ref>
                            </bibl>
                        </sourceDesc>
                    </fileDesc>
                    <encodingDesc>
                        <ab>
                            <desc>References to the editorial principles and practices for this TEI file and the project CoReMA</desc>
                            <ref target="https://gams.uni-graz.at/o:corema.semanticdec/TEI_SOURCE">details of editorial principles and practices for the semantic annotation</ref>
                        </ab>
                    </encodingDesc>
                    <profileDesc>
                        <textClass ana="#{@xml:id}">
                            <keywords>                
                                <term><xsl:value-of select="@type"/></term>
                            </keywords>
                        </textClass>
                        <creation>
                            <xsl:copy-of select="//t:history/t:origin/t:origDate"></xsl:copy-of>
                            <xsl:copy-of select="//t:history/t:origin/t:origPlace"></xsl:copy-of>
                        </creation>
                        <langUsage>
                            <language ident="{@xml:lang}" source="http://medieval-plants.org/mps-daten/inhalt/">
                                <xsl:for-each select="//t:msPart[@ana]//t:lang[@ana='main']">
                                    <xsl:value-of select="."/>
                                    <xsl:choose>
                                        <xsl:when test="position() = last()"></xsl:when>
                                        <xsl:otherwise>, </xsl:otherwise>
                                    </xsl:choose>
                                </xsl:for-each>
                          </language>
                        </langUsage>
                    </profileDesc>
                </teiHeader>
                <text>
                    <body>
                        <xsl:attribute name="xml:space">preserve</xsl:attribute>
                        <xsl:element name="div">
                           
                            <xsl:apply-templates select="@*|node()"/>
                           
                        </xsl:element>
                    </body>
                </text>
            </TEI>
        </xsl:result-document>
    </xsl:template>
    
    <xsl:template match="@* | node()">
        
        <!-- Alles kopieren -->
        <xsl:copy>
            <xsl:apply-templates select="@* | node()"/>
        </xsl:copy>
        
    </xsl:template>
    
    <!--macro structure kill-->
    
<!--    <xsl:template match="t:instruction">
        <xsl:apply-templates/>
    </xsl:template>
    <xsl:template match="t:opener">
        <xsl:apply-templates/>
    </xsl:template>
    <xsl:template match="t:closer">
        <xsl:apply-templates/>
    </xsl:template>
    <xsl:template match="t:kitchenTip">
        <xsl:apply-templates/>
    </xsl:template>
    <xsl:template match="t:householdTip">
        <xsl:apply-templates/>
    </xsl:template>
    <xsl:template match="t:servingTip">
        <xsl:apply-templates/>
    </xsl:template>-->
</xsl:stylesheet>