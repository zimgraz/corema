<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:t="http://www.tei-c.org/ns/1.0" xmlns:dct="http://purl.org/dc/terms/"
    xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#" xmlns:rdfs="http://www.w3.org/2000/01/rdf-schema#"
    xmlns:schema="http://schema.org/" xmlns:gams="https://gams.uni-graz.at/o:gams-ontology#" xmlns:corema="https://gams.uni-graz.at/o:corema.ontology#" xmlns:functx="http://www.functx.com" exclude-result-prefixes="xs xsl" version="2.0">
    
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
            <xsl:apply-templates select="//t:body/t:div[@xml:id][@type] | //t:ab[@subtype='subrecipe'] | //t:ingredient | //t:dish | //t:tool | //t:alternative"/>
        </rdf:RDF>
    </xsl:template>
    
    <xsl:template match="t:teiHeader"/>
    <xsl:template match="t:facsimile"/>
    
    <xsl:template match="t:body/t:div[@xml:id][@type]">
        <rdf:Description rdf:about="https://gams.uni-graz.at/o:corema.{@xml:id}">
            <xsl:call-template name="createRecipeData"/>
            <xsl:call-template name="createEntities"/>
        </rdf:Description>
    </xsl:template>

    <xsl:template match="t:ab[@subtype='subrecipe']">
        <rdf:Description rdf:about="https://gams.uni-graz.at/o:corema.{ancestor::t:div[@xml:id]/@xml:id}#sub{@n}">
            <rdf:type rdf:resource="https://gams.uni-graz.at/o:corema.ontology#Subrecipe"/>
            <xsl:call-template name="createRecipeData"/>
            <xsl:call-template name="createEntities"/>
        </rdf:Description>
    </xsl:template>
      
    <xsl:template match="t:alternative">
        <xsl:variable name="num">
            <xsl:number level="any" format="1" count="t:alternative"/>
        </xsl:variable>
        <rdf:Description rdf:about="https://gams.uni-graz.at/o:corema.{ancestor::t:div[@xml:id]/@xml:id}#Alt_{@reason}_{$num}">
            <rdf:type rdf:resource="https://gams.uni-graz.at/o:corema.ontology#Alternative"/>
            <corema:reasonForAlt><xsl:value-of select="@reason"/></corema:reasonForAlt>
            <xsl:call-template name="createEntities"/>
        </rdf:Description>     
    </xsl:template>
        
    <xsl:template match="t:ingredient[@commodity!='Q0'][not(@ana)]">
        <rdf:Description rdf:about="{concat('http://www.wikidata.org/entity/',@commodity)}">
            <rdf:type rdf:resource="https://gams.uni-graz.at/o:corema.ontology#Ingredient"></rdf:type>
            <rdf:type rdf:resource="http://purl.org/ontology/fo/Ingredient"></rdf:type>
            <rdf:type rdf:resource="http://www.wikidata.org/entity/Q25403900"></rdf:type>
            <rdfs:label xml:lang="en"><xsl:value-of select="@en"/></rdfs:label>
            <rdfs:label xml:lang="de-x-enh"><xsl:value-of select="normalize-space(.)"/></rdfs:label>
        </rdf:Description>
    </xsl:template>
    <xsl:template match="t:ingredient[@commodity!='Q0'][@ana]">
        <rdf:Description rdf:about="{concat('http://www.wikidata.org/entity/',@commodity)}">
            <rdf:type rdf:resource="https://gams.uni-graz.at/o:corema.ontology#Ingredient_{@ana}"></rdf:type>
            <rdfs:label xml:lang="en"><xsl:value-of select="@en"/></rdfs:label>
            <rdfs:label xml:lang="de-x-enh"><xsl:value-of select="normalize-space(.)"/></rdfs:label>
        </rdf:Description>
    </xsl:template>
    
    <!-- !!!Plan B!!!-->
    <!--<xsl:template match="t:ingredient[@commodity='Q0']">
        <rdf:Description rdf:about="{concat('https://gams.uni-graz.at/o:corema.ontology#',functx:capitalize-first(translate(normalize-space(@en),' ','')))}">
            <rdf:type rdf:resource="https://gams.uni-graz.at/o:corema.ontology#Ingredient"></rdf:type>
            <rdf:type rdf:resource="http://purl.org/ontology/fo/Ingredient"></rdf:type>
            <rdf:type rdf:resource="http://www.wikidata.org/entity/Q25403900"></rdf:type>
            <rdfs:label xml:lang="en"><xsl:value-of select="@en"/></rdfs:label>
            <rdfs:label xml:lang="de-x-enh"><xsl:value-of select="normalize-space(.)"/></rdfs:label>
        </rdf:Description>
    </xsl:template>-->
    
    <xsl:template match="t:dish[@commodity!='Q0'][not(@ana)]">
        <rdf:Description rdf:about="{concat('http://www.wikidata.org/entity/',@commodity)}">
            <rdf:type rdf:resource="https://gams.uni-graz.at/o:corema.ontology#Dish"></rdf:type>
            <rdf:type rdf:resource="http://www.wikidata.org/entity/Q746549"></rdf:type>
            <rdfs:label xml:lang="en"><xsl:value-of select="@en"/></rdfs:label> 
            <rdfs:label xml:lang="de-x-enh"><xsl:value-of select="normalize-space(.)"/></rdfs:label>
        </rdf:Description>
    </xsl:template>
    <xsl:template match="t:dish[@commodity!='Q0'][@ana]">
        <rdf:Description rdf:about="{concat('http://www.wikidata.org/entity/',@commodity)}">
            <rdf:type rdf:resource="https://gams.uni-graz.at/o:corema.ontology#Dish_{@ana}"></rdf:type>
            <rdfs:label xml:lang="en"><xsl:value-of select="@en"/></rdfs:label>
            <rdfs:label xml:lang="de-x-enh"><xsl:value-of select="normalize-space(.)"/></rdfs:label>
        </rdf:Description>
    </xsl:template>
    <xsl:template match="t:tool[@commodity!='Q0'][not(@ana)]">
        <rdf:Description rdf:about="{concat('http://www.wikidata.org/entity/',@commodity)}">
            <rdf:type rdf:resource="https://gams.uni-graz.at/o:corema.ontology#Tool"></rdf:type>
            <rdf:type rdf:resource="http://www.wikidata.org/entity/Q26037047"></rdf:type>
            <rdfs:label xml:lang="en"><xsl:value-of select="@en"/></rdfs:label>  
            <rdfs:label xml:lang="de-x-enh"><xsl:value-of select="normalize-space(.)"/></rdfs:label>
        </rdf:Description>
    </xsl:template>
    <xsl:template match="t:tool[@commodity!='Q0'][@ana]">
        <rdf:Description rdf:about="{concat('http://www.wikidata.org/entity/',@commodity)}">
            <rdf:type rdf:resource="https://gams.uni-graz.at/o:corema.ontology#Tool_{@ana}"></rdf:type>
            <rdfs:label xml:lang="en"><xsl:value-of select="@en"/></rdfs:label>
            <rdfs:label xml:lang="de-x-enh"><xsl:value-of select="normalize-space(.)"/></rdfs:label>
        </rdf:Description>
    </xsl:template>
    
    

    
    <xsl:template name="createEntities">
        <xsl:for-each select=".//t:date">
            <corema:containsDate><xsl:value-of select="./normalize-space()"/></corema:containsDate>
        </xsl:for-each>
        <xsl:for-each select=".//t:instruction">
            <corema:containsInstruction><xsl:value-of select="./normalize-space()"/></corema:containsInstruction>
        </xsl:for-each>
        <xsl:for-each select=".//t:kitchenTip">
            <corema:containsKitchenTip><xsl:value-of select="./normalize-space()"/></corema:containsKitchenTip>
        </xsl:for-each>
        <xsl:for-each select=".//t:householdTip">
            <corema:containsHouseholdTip><xsl:value-of select="./normalize-space()"/></corema:containsHouseholdTip>
        </xsl:for-each>
        <xsl:for-each select=".//t:name">
            <corema:containsProperName><xsl:value-of select="./normalize-space()"/></corema:containsProperName>
        </xsl:for-each>
        <xsl:for-each select=".//t:opener">
            <corema:containsOpener><xsl:value-of select="./normalize-space()"/></corema:containsOpener>
        </xsl:for-each>
        <xsl:for-each select=".//t:closer">
            <corema:containsCloser><xsl:value-of select="./normalize-space()"/></corema:containsCloser>
        </xsl:for-each>
        <xsl:for-each select=".//t:time">
            <corema:containsTime><xsl:value-of select="./normalize-space()"/></corema:containsTime>
        </xsl:for-each>
        <xsl:for-each select=".//t:ref">
            <corema:containsReference><xsl:value-of select="./normalize-space()"/></corema:containsReference>
        </xsl:for-each>
        <xsl:for-each select=".//t:servingTip">
            <corema:containsServingTip><xsl:value-of select="./normalize-space()"/></corema:containsServingTip>
        </xsl:for-each>
        <xsl:for-each select=".//t:sp">
            <corema:containsOriginalComment><xsl:value-of select="./normalize-space()"/></corema:containsOriginalComment>
        </xsl:for-each>
        <xsl:for-each select=".//t:unclear">
            <corema:containsUnclearText><xsl:value-of select="./normalize-space()"/></corema:containsUnclearText>
        </xsl:for-each>
        <xsl:for-each select=".//t:religion">
            <corema:containsReligion><xsl:value-of select="./normalize-space()"/></corema:containsReligion>
        </xsl:for-each>
        <xsl:for-each select=".//t:dietetics">
            <corema:containsDietetics><xsl:value-of select="./normalize-space()"/></corema:containsDietetics>
        </xsl:for-each>
        <xsl:for-each select=".//t:foreign">
            <corema:containsForeignPhrase><xsl:value-of select="./normalize-space()"/></corema:containsForeignPhrase>
        </xsl:for-each>
        <xsl:for-each select=".//t:dish[@commodity!='Q0'][not(@ana)]">
            <corema:containsDish rdf:resource="{concat('http://www.wikidata.org/entity/',@commodity)}"/>
        </xsl:for-each>
        <xsl:for-each select=".//t:tool[@commodity!='Q0'][not(@ana)]">
            <schema:tool rdf:resource="{concat('http://www.wikidata.org/entity/',@commodity)}"/>
        </xsl:for-each>
        <xsl:for-each select=".//t:ingredient[@commodity!='Q0'][not(@ana)]">
            <schema:recipeIngredient rdf:resource="{concat('http://www.wikidata.org/entity/',@commodity)}"/>
        </xsl:for-each>
        <xsl:for-each select=".//t:ingredient[@commodity!='Q0'][@ana]">
            <xsl:element name="corema:{@ana}">
                <xsl:attribute name="rdf:resource">
                    <xsl:value-of select="concat('http://www.wikidata.org/entity/',@commodity)"/>
                </xsl:attribute>
            </xsl:element>
        </xsl:for-each>
        <xsl:for-each select=".//t:dish[@commodity!='Q0'][@ana]">
            <xsl:element name="corema:{@ana}">
                <xsl:attribute name="rdf:resource">
                    <xsl:value-of select="concat('http://www.wikidata.org/entity/',@commodity)"/>
                </xsl:attribute>
            </xsl:element>
        </xsl:for-each>
        <xsl:for-each select=".//t:tool[@commodity!='Q0'][@ana]">
            <xsl:element name="corema:{@ana}">
                <xsl:attribute name="rdf:resource">
                    <xsl:value-of select="concat('http://www.wikidata.org/entity/',@commodity)"/>
                </xsl:attribute>
            </xsl:element>
        </xsl:for-each>
        
       <!-- !!!Plan B!!!-->
        <!--<xsl:for-each select=".//t:ingredient[@commodity='Q0']">
            <schema:recipeIngredient rdf:resource="{concat('https://gams.uni-graz.at/o:corema.ontology#',functx:capitalize-first(translate(normalize-space(@en),' ','')))}"/>
        </xsl:for-each>-->
        
    </xsl:template>
    <xsl:template name="createRecipeData">
        <gams:isMemberOfCollection rdf:resource="https://gams.uni-graz.at/corema"/>        
        <rdf:type rdf:resource="http://www.wikidata.org/entity/Q219239"/>
        <rdf:type rdf:resource="http://schema.org/Recipe"/>
        <rdf:type rdf:resource="http://purl.org/ontology/fo/Recipe"/>
        <schema:recipeCategory rdf:resource="https://gams.uni-graz.at/o:corema.ontology#{concat(upper-case(substring(@type,1,1)),substring(@type, 2))}"/> 
        <dct:isPartOf rdf:resource="https://gams.uni-graz.at/o:corema.{substring-before(@xml:id,'.')}"/>
        <dct:isPartOf rdf:resource="https://gams.uni-graz.at/o:corema.{normalize-space(lower-case(//t:altIdentifier[@type='abbr']/t:idno))}"/>
        <dct:isPartOf rdf:resource="https://gams.uni-graz.at/o:corema.{normalize-space(lower-case(//t:altIdentifier[@type='abbr']/t:idno))}.recipes"/>
        <xsl:if test="@subtype='subrecipe'">
            <dct:isPartOf rdf:resource="https://gams.uni-graz.at/o:corema.{ancestor::t:div[@type]/@xml:id}"/>
            <corema:isSubrecipeOf rdf:resource="https://gams.uni-graz.at/o:corema.{ancestor::t:div[@type]/@xml:id}"/>
        </xsl:if>
        <corema:isPartOfMS rdf:resource="https://gams.uni-graz.at/o:corema.{normalize-space(lower-case(//t:altIdentifier[@type='abbr']/t:idno))}"/>
        <corema:isPartOfSemanticMS rdf:resource="https://gams.uni-graz.at/o:corema.{normalize-space(lower-case(//t:altIdentifier[@type='abbr']/t:idno))}.recipes"/>
        <xsl:if test="@subtype='subrecipe'">
            <corema:isPartOfRecipe rdf:resource="https://gams.uni-graz.at/o:corema.{ancestor::t:div[@type]/@xml:id}"/>
        </xsl:if>
        <corema:isPartOfCollection rdf:resource="https://gams.uni-graz.at/o:corema.{substring-before(@xml:id,'.')}"/>
        <corema:recipeNumber>
            <xsl:choose>
                <xsl:when test="@subtype='subrecipe'"><xsl:value-of select="substring-after(@xml:id,'.')"/></xsl:when>
                <xsl:otherwise><xsl:value-of select="@n"/></xsl:otherwise>
            </xsl:choose>
        </corema:recipeNumber>
        <dct:source rdf:resource="{//t:bibl[@type='manuscript_page']/t:ref/@target}"/>
        <dct:title xml:lang="en"><xsl:value-of select="(.//t:title)[1]/@key/normalize-space()"/></dct:title>
        <xsl:choose>
            <xsl:when test="(.//t:title)[1][@type='none']"></xsl:when>
            <xsl:otherwise><dct:title xml:lang="{@xml:lang}"><xsl:value-of select="(.//t:title)[1]/normalize-space()"/></dct:title></xsl:otherwise>
        </xsl:choose>
        <corema:titleEn><xsl:value-of select="(.//t:title)[1]/@key/normalize-space()"/></corema:titleEn>
        <xsl:choose>
            <xsl:when test="(.//t:title)[1][@type='none']"></xsl:when>
            <xsl:otherwise>
                <corema:titleOrig><xsl:value-of select="(.//t:title)[1]/normalize-space()"/></corema:titleOrig>
                <corema:titleLang><xsl:value-of select="@xml:lang"/></corema:titleLang>
            </xsl:otherwise>
        </xsl:choose>
        
        <dct:language><xsl:value-of select="//t:language/normalize-space()"/></dct:language>
        <dct:coverage>
            <xsl:value-of select="normalize-space(//t:settlement[1])"></xsl:value-of>
        </dct:coverage>
        <dct:spatial><xsl:value-of select="//t:placeName[@xml:lang='en']/normalize-space()"/></dct:spatial>
        <dct:temporal>
            <xsl:variable name="from" select="//t:origDate/t:date[1]/@notBefore"></xsl:variable>
            <xsl:variable name="to" select="//t:origDate/t:date[1]/@notAfter"></xsl:variable>
            <xsl:variable name="when" select="//t:origDate/t:date[1]/@when"></xsl:variable>
            <xsl:choose>
                <xsl:when test="$when">
                    <xsl:value-of select="normalize-space($when)"></xsl:value-of>
                </xsl:when>
                <xsl:when test="$from=$to">
                    <xsl:value-of select="normalize-space($from)"></xsl:value-of>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="normalize-space($from)"></xsl:value-of>
                    <xsl:text>/</xsl:text>
                    <xsl:value-of select="normalize-space($to)"></xsl:value-of>
                </xsl:otherwise>
            </xsl:choose>
        </dct:temporal>
        <corema:dating><xsl:value-of select="//t:origDate/t:date[@xml:lang='en']/text()/normalize-space()"/></corema:dating>
        <corema:msID><xsl:value-of select="//t:altIdentifier[@type='abbr']/t:idno"/></corema:msID>
        <corema:collectionID><xsl:value-of select="//t:altIdentifier[@type='collection']/t:idno"/></corema:collectionID>
        <corema:msSigle>
            <xsl:variable name="msSigle">
                <xsl:value-of select="normalize-space(//t:msIdentifier[1]/t:settlement)"></xsl:value-of>
                <xsl:text>, </xsl:text>
                <xsl:value-of select="normalize-space(//t:msIdentifier[1]/t:institution)"></xsl:value-of>
                <xsl:if test="//t:msIdentifier[1]/t:repository">
                    <xsl:text>, </xsl:text>
                    <xsl:value-of select="normalize-space(//t:msIdentifier[1]/t:repository)"></xsl:value-of>
                </xsl:if>
                <xsl:text>, </xsl:text>
                <xsl:value-of select="normalize-space(//t:msIdentifier[1]/t:idno)"></xsl:value-of>
            </xsl:variable>
            <xsl:value-of select="$msSigle"/>
        </corema:msSigle>
        <dct:identifier>https://gams.uni-graz.at/o:corema.<xsl:value-of select="@xml:id"/></dct:identifier>
        
        <xsl:for-each select="t:ab[@subtype='subrecipe']">
            <corema:hasSubrecipe rdf:resource="https://gams.uni-graz.at/o:corema.{ancestor::t:div[@xml:id]/@xml:id}#sub{@n}"/>
        </xsl:for-each>        
        <xsl:for-each select=".//t:alternative">
            <xsl:variable name="num">
                <xsl:number level="any" format="1" count="t:alternative"/>
            </xsl:variable>
            <corema:containsAlternative rdf:resource="https://gams.uni-graz.at/o:corema.{ancestor::t:div[@xml:id]/@xml:id}#Alt_{@reason}_{$num}"/>
        </xsl:for-each> 
        <corema:ingredientString>
            <xsl:for-each-group select=".//t:ingredient[@commodity!='Q0'][not(@ana)]" group-by="@commodity">
                <xsl:sort select="current-grouping-key()"></xsl:sort>
                <xsl:value-of select="current-grouping-key()"/><xsl:if test="position()!=last()"><xsl:text>,</xsl:text></xsl:if>
            </xsl:for-each-group>
        </corema:ingredientString>
        <corema:ingredientStringOriginalOrder>
            <xsl:for-each select=".//t:ingredient[@commodity!='Q0'][not(@ana)]">
                <xsl:value-of select="@commodity"/><xsl:if test="position()!=last()"><xsl:text>,</xsl:text></xsl:if>
            </xsl:for-each>
        </corema:ingredientStringOriginalOrder>
        <corema:toolString>
            <xsl:for-each-group select=".//t:tool[@commodity!='Q0'][not(@ana)]" group-by="@commodity">
                <xsl:sort select="current-grouping-key()"></xsl:sort>
                <xsl:value-of select="current-grouping-key()"/><xsl:if test="position()!=last()"><xsl:text>,</xsl:text></xsl:if>
            </xsl:for-each-group>
        </corema:toolString>
        <corema:toolStringOriginalOrder>
            <xsl:for-each select=".//t:tool[@commodity!='Q0'][not(@ana)]">
                <xsl:value-of select="@commodity"/><xsl:if test="position()!=last()"><xsl:text>,</xsl:text></xsl:if>
            </xsl:for-each>
        </corema:toolStringOriginalOrder>
        <corema:dishString>
            <xsl:for-each-group select=".//t:dish[@commodity!='Q0'][not(@ana)]" group-by="@commodity">
                <xsl:sort select="current-grouping-key()"></xsl:sort>
                <xsl:value-of select="current-grouping-key()"/><xsl:if test="position()!=last()"><xsl:text>,</xsl:text></xsl:if>
            </xsl:for-each-group>
        </corema:dishString>
        <corema:dishStringOriginalOrder>
            <xsl:for-each select=".//t:dish[@commodity!='Q0'][not(@ana)]">
                <xsl:value-of select="@commodity"/><xsl:if test="position()!=last()"><xsl:text>,</xsl:text></xsl:if>
            </xsl:for-each>
        </corema:dishStringOriginalOrder>
    </xsl:template>
    
    
    
</xsl:stylesheet>