<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:t="http://www.tei-c.org/ns/1.0" xmlns:dct="http://purl.org/dc/terms/"
    xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#" xmlns:rdfs="http://www.w3.org/2000/01/rdf-schema#"
    xmlns:schema="http://schema.org/" xmlns:gams="https://gams.uni-graz.at/o:gams-ontology#" xmlns:corema="https://gams.uni-graz.at/o:corema.ontology#" xmlns:functx="http://www.functx.com" exclude-result-prefixes="xs xsl" version="2.0">
    <!--
    Workflow für den ingest der all-ingredient Daten:
    
    1) Google Spreadsheet als csv exportieren und speichern unter /lists/ingredients/all-ingredient-in-corema-to-RDF.csv
    2) Dieses csv in Oxygen importieren
        2.1) Datei -> Importieren -> Textdatei
        2.2) URL: /lists/recipeTitles/recipeTitles.csv Kodierung: UTF-8
        2.3) Erste Zeile enthält Feldnamen anhaken
        2.5) Speichern unter /lists/ingredients/all-ingredient-in-corema-to-RDF.xml
        2.6) Example Output:
       
              <row>
        <deu-enh>#unknown</deu-enh>
        <deu>Rheum palmatum</deu>
        <eng>Rheum palmatum</eng>
        <lat></lat>
        <warning></warning>
        <FAO_categories></FAO_categories>
        <ingredient_general></ingredient_general>
        <Qid_general></Qid_general>
        <ingredient_detail></ingredient_detail>
        <Lde_detail></Lde_detail>
        <Len_detail></Len_detail>
        <Qid_detail>Q1109580</Qid_detail>
        <Qid_of_product_1></Qid_of_product_1>
        <Qid_of_product_2></Qid_of_product_2>
        <Qid_of_product_3></Qid_of_product_3>
        <Qid_of_product_4></Qid_of_product_4>
        <subclass_of_1></subclass_of_1>
        <subclass_of_2></subclass_of_2>
        <subclass_of_3></subclass_of_3>
        <subclass_of_4></subclass_of_4>
        <subclass_of_5></subclass_of_5>
        <subclass_of_6></subclass_of_6>
        <subclass_of_7></subclass_of_7>
        <subclass_of_8></subclass_of_8>
        <subclass_of_9></subclass_of_9>
        <instance_of_1></instance_of_1>
        <instance_of_2></instance_of_2>
        <instance_of_3></instance_of_3>
        <instance_of_4></instance_of_4>
        <foodon></foodon>
        <foodon_id></foodon_id>
        <taxon></taxon>
        <humoral_quality>w2/t2</humoral_quality>
        <combined>2,2,0,0</combined>
        <dry>2</dry>
        <warm>2</warm>
        <moist>0</moist>
        <cold>0</cold>
    </row>

    3) Dieses Stylesheet auf all-ingredient-in-corema-to-RDF.xml ausführen 
    4) Das Ergebnis in cirilo in den Ontology Datenstrom von o:corema.all-ingredients kopieren
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
        <rdf:RDF>
            <xsl:apply-templates select="//Qid_detail | //Qid_general"/>
        </rdf:RDF>
    </xsl:template>
    
    
    <xsl:template match="Qid_detail[text()!='Q0']">
        <rdf:Description rdf:about="{concat('http://www.wikidata.org/entity/',.)}">
            <xsl:call-template name="create_triples"/>
        </rdf:Description>
    </xsl:template>
    <xsl:template match="Qid_detail[text()='Q0']">
        <rdf:Description rdf:about="{concat('https://gams.uni-graz.at/o:corema.ontology#',functx:capitalize-first(translate(normalize-space(preceding-sibling::eng),' ','')))}">
            <xsl:call-template name="create_triples"/>
        </rdf:Description>
    </xsl:template>
   <!-- <xsl:template match="Qid_general[text()!=''][text()!='Q0']">
        <rdf:Description rdf:about="{concat('http://www.wikidata.org/entity/',.)}">
            <xsl:if test="preceding-sibling::ingredient_general!=''"><rdfs:label xml:lang='en'><xsl:value-of select="preceding-sibling::ingredient_general"/></rdfs:label></xsl:if>
        </rdf:Description>
    </xsl:template>-->
    <xsl:template match="Qid_general[text()='Q0']"/>
       
    
    
    <xsl:template name="create_triples">
        <rdf:type rdf:resource="https://gams.uni-graz.at/o:corema.ontology#Ingredient"></rdf:type>
        <rdf:type rdf:resource="http://purl.org/ontology/fo/Ingredient"></rdf:type>
        <rdf:type rdf:resource="http://www.wikidata.org/entity/Q25403900"></rdf:type>
        <xsl:if test="preceding-sibling::eng!=''"><rdfs:label xml:lang='en'><xsl:value-of select="preceding-sibling::eng"/></rdfs:label></xsl:if>
        <xsl:if test="preceding-sibling::deu!=''"><rdfs:label xml:lang='de'><xsl:value-of select="preceding-sibling::deu"/></rdfs:label></xsl:if>
        <xsl:if test="preceding-sibling::lat!=''"><rdfs:label xml:lang='la'><xsl:value-of select="preceding-sibling::lat"/></rdfs:label></xsl:if>
        <xsl:if test="preceding-sibling::deu-enh!=''"><rdfs:label xml:lang='de-x-enh'><xsl:value-of select="preceding-sibling::deu-enh"/></rdfs:label></xsl:if>
        <corema:faoCategory>
            <xsl:attribute name="rdf:resource">
                <xsl:text>https://gams.uni-graz.at/o:corema.ontology#FAO_</xsl:text><xsl:choose><xsl:when test="preceding-sibling::FAO_categories!=''"><xsl:value-of select="preceding-sibling::FAO_categories"/></xsl:when><xsl:otherwise>undefined</xsl:otherwise></xsl:choose>
            </xsl:attribute>
        </corema:faoCategory>
        <rdfs:subClassOf>
            <xsl:attribute name="rdf:resource">
                <xsl:text>http://www.wikidata.org/entity/</xsl:text><xsl:choose><xsl:when test="preceding-sibling::Qid_general=''">undefined</xsl:when><xsl:when test="preceding-sibling::Qid_general!=current()/text()"><xsl:value-of select="preceding-sibling::Qid_general"/></xsl:when><xsl:otherwise>undefined</xsl:otherwise></xsl:choose>
            </xsl:attribute>
        </rdfs:subClassOf>
        <xsl:if test="following-sibling::foodon_id!=''"><corema:foodon_id rdf:resource="{following-sibling::foodon_id}"/></xsl:if>
        <xsl:if test="following-sibling::humoral_quality!=''"><corema:humoral_quality_dwmc><xsl:value-of select="following-sibling::combined"/></corema:humoral_quality_dwmc></xsl:if>
    </xsl:template>

</xsl:stylesheet>