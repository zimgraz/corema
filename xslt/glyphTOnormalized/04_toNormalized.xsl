<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:t="http://www.tei-c.org/ns/1.0" xmlns="http://www.tei-c.org/ns/1.0" xmlns:cs='http://www.chrissteinermachtfunktionenweilesnervtdasseskeinesubstrinbetweenfunktiongibt.com'
    exclude-result-prefixes="#all" version="2.0">
    
    <xsl:output method="xml" indent="yes"/>
    
    
    <xsl:function name="cs:substring-between">
        <xsl:param name="string"/>
        <xsl:param name="start-string"/>
        <xsl:param name="end-string"/>
        <xsl:sequence select="substring-before(substring-after($string, $start-string),$end-string)"/>
    </xsl:function>
    
    <!-- identity transform -->
    <xsl:template match="@*|node()">
        
        <xsl:copy> 
            <xsl:apply-templates select="@*|node()"/>
        </xsl:copy>
    </xsl:template>
    
  
    <xsl:template match="t:publicationStmt/t:ref[@target='context:corema.glyph']">
        <ref target="context:corema.recipes" type="context"/>
    </xsl:template>
    
    <xsl:template match="t:publicationStmt/t:idno[@type='PID']">
        <idno type="PID"><xsl:value-of select="concat(.,'.recipes')"/></idno>
    </xsl:template>
    
    <xsl:template match="t:publicationStmt/t:date">
        <date when="{format-date(current-date(), '[Y0001]-[M01]-[D01]')}"/>
    </xsl:template>
    
    <xsl:template match="t:editionStmt/t:edition">
        <edition>Semantic annotation of the manuscript "<xsl:value-of select="substring-after(//t:titleStmt/t:title,'transcription of ')"/>"</edition>
    </xsl:template>
    
    <xsl:template match="t:body">
        <body><xsl:apply-templates/></body>
    </xsl:template>
    
    <xsl:template match="t:milestone">
        <xsl:copy>
            <xsl:apply-templates select="@*|node()"/>
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="t:body//t:ab">
        <div><xsl:apply-templates/></div>
    </xsl:template>
    
    <xsl:template match="t:body//t:date">
        <dateline><xsl:apply-templates/></dateline>
    </xsl:template>
    
    <xsl:template match="t:seg[not(@xml:id)]">
         <xsl:variable name="num">
             <xsl:number level="single" format="1" count="t:seg[not(@xml:id)]"/>
         </xsl:variable>
        <xsl:variable name="numcollection">
            
                <xsl:number from="t:milestone" level="any"/>
            
        </xsl:variable>
        <xsl:choose>
            <xsl:when test="preceding-sibling::t:milestone[@unit='collection']">
                <ab type="recipe" xml:lang="de-x-enh" n="{$numcollection}" xml:id="{concat(lower-case(preceding-sibling::t:milestone[1][@unit='collection']/@n),'.',$numcollection)}"><xsl:text disable-output-escaping="yes">&#xD;</xsl:text>
                 <xsl:apply-templates/>
                </ab>
            </xsl:when>
            <xsl:otherwise>
                <ab type="recipe" xml:lang="de-x-enh" n="{$num}" xml:id="{concat(substring-after(//t:idno[@type='PID'],'corema.'),'.',$num)}"><xsl:text disable-output-escaping="yes">&#xD;</xsl:text>
                    <xsl:apply-templates/>
                </ab>
            </xsl:otherwise>
        </xsl:choose>
        <xsl:text disable-output-escaping="yes">&#xD;</xsl:text>
        <xsl:text disable-output-escaping="yes">&#xD;</xsl:text>
        <xsl:text disable-output-escaping="yes">&#xD;</xsl:text>
        <xsl:text disable-output-escaping="yes">&#xD;</xsl:text>
    </xsl:template>   
    
   
    <xsl:template match="t:body//t:forgein">
        <foreign xml:lang="{@xml:lang}">
            <xsl:apply-templates/>
        </foreign>        
    </xsl:template>
    
    <!--abgetrennte Wörter hier zusammenschreiben-->
    <xsl:template match="t:w">
       <xsl:apply-templates/>
    </xsl:template>
    <xsl:template match="t:w[not(t:anchor[@type='hyph'])]//text()">
        <xsl:value-of select="normalize-space()"/>
    </xsl:template>
    
    <!--text sequence umschichtungen-->
    <xsl:template match="t:ptr">
        <xsl:value-of select="//t:seg[@xml:id=current()/substring-after(@target,'#')]"/>
    </xsl:template>
    
    <xsl:template match="t:mod[@corresp]">
        <xsl:value-of select="//t:seg[@xml:id=current()/substring-after(@corresp,'#')]"/>
    </xsl:template>
    
    <xsl:template match="t:anchor[@type='heading']">
        <xsl:variable name="ids" select="substring-after(@corresp,'#')"/>
        <xsl:variable name="first_id" select="substring-before($ids,' ')"/>
        <xsl:variable name="second_id" select="substring-after($ids,' #')"/>
        <xsl:variable name="second_id_of_three" select="cs:substring-between($ids,' #',' #')"/>
        <xsl:variable name="third_id" select="substring-after($second_id,' #')"/>
        <xsl:variable name="first_part" select="//t:seg[@xml:id=$first_id]"/>
        <xsl:variable name="second_part" select="//t:seg[@xml:id=$second_id]"/>
        <xsl:variable name="second_part_of_three" select="//t:seg[@xml:id=$second_id_of_three]"/>
        <xsl:variable name="third_part" select="//t:seg[@xml:id=$third_id]"/>
        <xsl:variable name="only_part" select="//t:seg[@xml:id=$ids]"/>
        <xsl:choose> <!-- Helmut: Habe beim Zusammensetzen des Titels Leerzeichen eingefügt, da die beiden <seg> sonst ohne aneinandergereiht werden. -->
            <xsl:when test="matches($ids,'^\S*?\s\S*?$')"><title><xsl:apply-templates select="$first_part"/><xsl:text> </xsl:text><xsl:apply-templates select="$second_part"/></title><xsl:text> </xsl:text></xsl:when>
            <xsl:when test="matches($ids,'^\S*?\s\S*?\s\S*?$')"><title><xsl:apply-templates select="$first_part"/><xsl:text> </xsl:text><xsl:apply-templates select="$second_part_of_three"/><xsl:text> </xsl:text><xsl:apply-templates select="$third_part"/></title><xsl:text> </xsl:text></xsl:when>
            <xsl:otherwise><title><xsl:apply-templates select="$only_part"/></title><xsl:text> </xsl:text></xsl:otherwise>
        </xsl:choose>
        
    </xsl:template>
    
    <xsl:template match="t:w/t:anchor[@type='hyph']">
        <xsl:variable name="ids" select="substring-after(@corresp,'#')"/>
        <xsl:variable name="first_id" select="substring-before($ids,' ')"/>
        <xsl:variable name="second_id" select="substring-after($ids,' #')"/>
        <xsl:variable name="first_part" select="//t:seg[@xml:id=$first_id]"/>
        <xsl:variable name="second_part" select="//t:seg[@xml:id=$second_id]"/>
        <xsl:variable name="only_part" select="//t:seg[@xml:id=$ids]"/>
        <w><xsl:apply-templates select="$first_part"/><xsl:apply-templates select="$second_part"/></w><xsl:text> </xsl:text>
    </xsl:template> 
    
    <xsl:template match="t:body//t:hi[@style='heading']">
        <xsl:choose>
            <xsl:when test="parent::t:seg[@xml:id]"><xsl:apply-templates/></xsl:when>
            <xsl:otherwise><title><xsl:apply-templates/></title></xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <xsl:template match="t:body//t:seg[@xml:id]">
        <d><xsl:apply-templates/></d>
    </xsl:template>

    
    <!--Inhalte werden übernommen-->
    <xsl:template match="t:body//t:abbr">       
       <xsl:apply-templates/>        
    </xsl:template>
    <xsl:template match="t:body//t:metamark">
       <xsl:apply-templates/> 
    </xsl:template>
    <xsl:template match="t:body//t:ex">       
        <xsl:apply-templates/>        
    </xsl:template>
    <xsl:template match="t:body//t:am">       
        <xsl:apply-templates/>        
    </xsl:template>
    <xsl:template match="t:g[@ref='#combuml']">
        <xsl:variable name="last_letter_before_combuml" select="substring(preceding-sibling::text()[1], string-length(preceding-sibling::text()[1]), 1)"/>
        <xsl:if test="$last_letter_before_combuml='a' or $last_letter_before_combuml='o' or $last_letter_before_combuml='u' or $last_letter_before_combuml='w'">
            <xsl:text>e</xsl:text>
        </xsl:if>
        <xsl:if test="$last_letter_before_combuml='v'">
            <xsl:text>eMAKEU</xsl:text>
        </xsl:if>
    </xsl:template>
    
    <xsl:template match="t:g">
        <xsl:apply-templates/>        
    </xsl:template>
    <xsl:template match="t:body//t:hi[not(@style)]">       
        <xsl:apply-templates/>        
    </xsl:template>
    <xsl:template match="t:body//t:supplied">       
        <xsl:apply-templates/>        
    </xsl:template> 
    <xsl:template match="t:body//t:add">       
        <xsl:apply-templates/>        
    </xsl:template>
    <xsl:template match="t:body//t:mod">
        <xsl:apply-templates/>
    </xsl:template>
    <xsl:template match="t:body//t:mod[@ana='TR.DL.WR.ST.TR.DL.WR.EP']">
        <xsl:value-of select="."/>
    </xsl:template>
    <xsl:template match="t:body//t:listTranspose">
        <xsl:apply-templates/>
    </xsl:template>
    <xsl:template match="t:body//t:transpose">
        <xsl:apply-templates/>
    </xsl:template>
    <xsl:template match="t:body//t:expan">
        <xsl:apply-templates/>
    </xsl:template>
    
    
    <xsl:template match="t:body//text()[starts-with(., 'Tem ')]">
        <xsl:value-of select="lower-case(.)"/>
    </xsl:template>
    
    <!--Auch inhalt wird gelöscht-->
    <xsl:template match="t:body//t:lb"/>
    <xsl:template match="t:body//t:cb"/>
    <xsl:template match="t:body//t:note"/> 
    <xsl:template match="t:body//t:del"/>
    <xsl:template match="t:body//t:sic"/>
    <xsl:template match="t:body//t:fw"/>
    <xsl:template match="t:body//t:handShift"/>
    <xsl:template match="t:g[@ref='#dbloblhyph']"/>
    <xsl:template match="t:g[@ref='#fracsol']"/>
    <xsl:template match="t:g[@ref='#dblsol']"/>
    <xsl:template match="t:g[@ref='#tridotright']"/> 
   
</xsl:stylesheet>
