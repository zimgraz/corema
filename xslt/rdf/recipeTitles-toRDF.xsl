<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:t="http://www.tei-c.org/ns/1.0" xmlns:dct="http://purl.org/dc/terms/"
    xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#" xmlns:rdfs="http://www.w3.org/2000/01/rdf-schema#"
    xmlns:schema="http://schema.org/" xmlns:gams="https://gams.uni-graz.at/o:gams-ontology#" xmlns:corema="https://gams.uni-graz.at/o:corema.ontology#" xmlns:functx="http://www.functx.com" exclude-result-prefixes="xs xsl" version="2.0">
    <!--
    Workflow für den Import der Titel in die TEIs:
    
    1) Google Spreadsheet als csv exportieren und speichern unter /lists/recipeTitles/recipeTitles.csv
    2) Dieses csv in Oxygen importieren
        2.1) Datei -> Importieren -> Textdatei
        2.2) URL: /lists/recipeTitles/recipeTitles.csv Kodierung: UTF-8
        2.3) Erste Zeile enthält Feldnamen anhaken
        2.5) Speichern unter /lists/recipeTitles/recipeTitles.xml
        2.6) Example Output:
       
              <row>
                 <xml-id>bs1.2</xml-id>
                 <title-deu-enh>Ain mandel muosz machen</title-deu-enh>
                 <title-english>Almond puree</title-english>
                 <dish_category_preparation>puree</dish_category_preparation>
                 <dish_category_ingredient>nuts</dish_category_ingredient>
                 <dish_category_interpretation>sweet</dish_category_interpretation>
             </row>

    3) Dieses Stylesheet auf recipeTitles.xml ausführen 
    4) Das Ergebnis in cirilo in den Ontology Datenstrom von o:corema.dishcategories kopieren
-->    
    <xsl:strip-space elements="*" />
    <xsl:output method="xml" encoding="UTF-8" indent="yes"/>

    <xsl:function name="functx:capitalize-first" as="xs:string?"
        xmlns:functx="http://www.functx.com">
        <xsl:param name="arg" as="xs:string?"/>
        
        <xsl:sequence select="
            concat(upper-case(substring($arg,1,1)),
            substring($arg,2))
            "/>
        
    </xsl:function>
    
    <xsl:template match="/">
        <xsl:result-document href="dishCategories.rdf">
        <rdf:RDF>
            <!--<xsl:apply-templates select="//row[title-english/following-sibling::*!='']"/>-->
            <xsl:apply-templates select="//xml-id[following-sibling::title-english/following-sibling::*!='']"/>
            
            <xsl:for-each-group select="//dish_category_preparation" group-by=".">
                <xsl:if test="current()!=''">
                <rdf:Description rdf:about="{concat('https://gams.uni-graz.at/o:corema.ontology#DishCategoryPreparation_',translate(.,' ',''))}">
                    <rdfs:label xml:lang='en'><xsl:value-of select="./normalize-space()"/></rdfs:label>
                </rdf:Description>
                </xsl:if>
            </xsl:for-each-group>
            <xsl:for-each-group select="//dish_category_ingredient" group-by=".">
                <xsl:if test="current()!=''">
                    <rdf:Description rdf:about="{concat('https://gams.uni-graz.at/o:corema.ontology#DishCategoryIngredient_',translate(.,' ',''))}">
                        <rdfs:label xml:lang='en'><xsl:value-of select="./normalize-space()"/></rdfs:label>
                    </rdf:Description>
                </xsl:if>
            </xsl:for-each-group>
            <xsl:for-each-group select="//dish_category_interpretation" group-by=".">
                <xsl:if test="current()!=''">
                    <rdf:Description rdf:about="{concat('https://gams.uni-graz.at/o:corema.ontology#DishCategoryInterpretation_',translate(.,' ',''))}">
                        <rdfs:label xml:lang='en'><xsl:value-of select="./normalize-space()"/></rdfs:label>
                    </rdf:Description>
                </xsl:if>
            </xsl:for-each-group>
            
        </rdf:RDF>
        </xsl:result-document>
    </xsl:template>
    
    
    <xsl:template match="xml-id">
        <rdf:Description rdf:about="{concat('https://gams.uni-graz.at/o:corema.',.)}">
            <xsl:call-template name="create_triples"/>
        </rdf:Description>
    </xsl:template>


    <xsl:template name="create_triples">
        <xsl:if test="following-sibling::dish_category_preparation!=''">
            <corema:dishCategoryPreparation rdf:resource="https://gams.uni-graz.at/o:corema.ontology#DishCategoryPreparation_{translate(following-sibling::dish_category_preparation,' ','')}"/>
        </xsl:if>
        <xsl:if test="following-sibling::dish_category_ingredient!=''">
            <corema:dishCategoryIngredient rdf:resource="https://gams.uni-graz.at/o:corema.ontology#DishCategoryIngredient_{translate(following-sibling::dish_category_ingredient,' ','')}"/>
        </xsl:if>
        <xsl:if test="following-sibling::dish_category_interpretation!=''">   
            <corema:dishCategoryInterpretation rdf:resource="https://gams.uni-graz.at/o:corema.ontology#DishCategoryInterpretation_{translate(following-sibling::dish_category_interpretation,' ','')}"/>
        </xsl:if>
       
    </xsl:template>

</xsl:stylesheet>