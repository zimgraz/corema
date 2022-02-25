<schema xmlns="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt2">
  <title>Schematron for Corema gylph TEI/XML version</title>
  <ns prefix="t" uri="http://www.tei-c.org/ns/1.0"/>
  <pattern>
    <rule context="t:body">
      <assert test="@xml:space = 'preserve'">
        Space in body has to be preserved
      </assert>
    </rule>
    <rule context="t:facsimile" role="warning">
      <assert test="t:surface/t:graphic[@xml:id='CUTOUT']">
        There should be a cutout
      </assert>
    </rule>
    <rule context="t:surface">
      <assert test="string-length(substring-after(@start,'_'))=4 or @start='#'">
        @start within surface must have three-digit numbers!
      </assert>
    </rule>
    <rule context="t:surface/t:graphic">
      <assert test="string-length(substring-after(@xml:id,'.'))=4 or @xml:id='CUTOUT'">
        @xml:id within graphic must have three-digit numbers!
      </assert>
      <assert test="substring-after(@url,'.')='jpg'">
        only jpg images allowed for upload
      </assert>
    </rule>
    
    <rule context="t:msDesc/t:msIdentifier">
      <assert test="t:altIdentifier[@type='abbr']">
        Abbreviation of manuscript is mandatory!
      </assert>
    </rule>
    <rule context="t:altIdentifier[@type='abbr']">
      <let name="filename" value="substring-before(tokenize(base-uri(.), '/')[last()],'_')"/>
      <assert test="t:idno = $filename">
        Abbreviation of manuscript has to match filename!
      </assert>
    </rule>
    <rule context="t:sourceDesc">
      <assert test="descendant::t:settlement">
        There has to be a settlement of the manuscript! 
      </assert>
    </rule>

    <rule context="t:idno[@type='PID']">
      <let name="filename" value="lower-case(substring-before(tokenize(base-uri(.), '/')[last()],'_'))"/>
      <assert test="text()=concat('o:corema.',$filename)">
        PID has to match filename!
      </assert>
    </rule>
    <rule context="t:publicationStmt">
      <assert test="t:idno[@type='PID']">
        There has to be a PID!
      </assert>
      <assert test="t:ref[@type='context'][2]">
        There have to be two contexts!
      </assert>
    </rule>
    <rule context="t:ref[@type='context'][1]">
      <assert test="@target='context:corema'">
        context has to be 'context:corema'!
      </assert>
    </rule>
    <rule context="t:ref[@type='context'][2]">
      <assert test="@target='context:corema.glyph'">
        second context has to be 'context:corema.glyph'!
      </assert>
    </rule>
    <rule context="t:msDesc/t:msContents">
      <assert test="t:textLang[@ana='manuscript']">
        There has to be a @ana attribute with the value 'manuscript'!
      </assert>
    </rule>
    <rule context="t:seg[not(@xml:id)]">
      <let name="lbORpb" value="following-sibling::*[position()=1][name()=('lb','pb')]"/>
      <let name="seg" value="following-sibling::*[position()=1][not(name()='seg')]"/>
      <report test="if ($lbORpb) then ($lbORpb/following-sibling::*[position()=2][not(name()=('seg'))]) else ($seg)" role="warning">
        Recipes have to be followed by another recipe!
      </report>
    </rule>
    <rule context="t:hi[@style='heading']">
      <report test="child::node()[1][name() = 'lb']">
        A line beginning can't be within a heading!
      </report>
    </rule>
    <rule context="t:foreign">
       <assert test="@xml:lang">
         Foreign needs a language!
       </assert>
    </rule>
    <rule context="t:hi">
      <assert test="not(@*) or @style or @rend">
        <name/> elements have to have a @style and/or @rend attribute 
      </assert>
     
      <report test="@rend != 'textColour:RED;' and @rend != 'underlined;' and @rend != 'italic' and @rend != 'sup' and @rend != 'underlined; textColour:RED;' and @rend != 'textColour:BLUE;'">
        the @rend attribute can only be 'textColour:RED;', 'underlined;' or 'underlined; textColour:RED;' or "italic" or "sup"
      </report>
    </rule>
    <rule context="t:supplied">
      <report test="not(@reason)">
        <name/> elements have to have a @reason
      </report>
      <report test="@reason != 'missing' and @reason != 'list' and @reason != 'illegible' and @reason != 'overbinding' and @reason != 'damaged'">
        @reason has to be either "missing", "list", "illegible", "overbinding", "damaged"
      </report>
    </rule>
    <rule context="t:anchor">
      <assert test="@type='hyph' or @type='heading'">
        anchor has to have a @type attribute with the values "hyph", "heading"!
      </assert>
    </rule>
    <rule context="t:ptr/@target | t:mod/@corresp | t:anchor/@corresp">
      <report test="if (contains(.,' ')) then (not(starts-with(substring-after(.,' '),'#'))) else (not(starts-with(.,'#')))">
        <name/> has to start with #
      </report>
    </rule>
    <rule context="t:seg/@corresp">
      <report test=".">
        <name path=".."/> cannot have a @corresp attribute
      </report>
    </rule>
    <rule context="t:g[@ref='#dbloblhyph'][not(ancestor::t:seg[@type='hyph'])]">
      <assert test="ancestor::t:w">
        &lt;g ref="#dbloblhyph"&gt; has to have a &lt;w&gt; element as parent
      </assert>
    </rule>
    <rule context="t:pb">
      <assert test="string-length(substring-after(@xml:id,'_'))=4">
        @xml:id and @n must have three-digit numbers!
      </assert>
      <assert test="string-length(@n)=4">
        @xml:id and @n must have three-digit numbers!
      </assert>
    </rule>
    <rule context="t:origin/t:origDate[1]">
      <assert test="t:date[@xml:lang='en']">
        at least an english date has to be present in first origdate
      </assert>
    </rule>
    <rule context="t:abbr" role="warning">
      <report test="text()[contains(.,' ')]">
        whitespace in <name/>
      </report>
    </rule>
    <rule context="* except (t:g | t:pb | t:lb | t:anchor | t:graphic | t:ptr | t:handShift |t:cb | t:mod | t:ref | t:date | t:locus | t:milestone)">
      <report test="not(node())">
        <name/> cannot be empty!
      </report>
    </rule>
    
    
    
    <!-- <report test="t:hi">
        <name/> elements shouldn't be nested
      </report>-->
    <!--<rule context="t:settlement">
      <let name="city_name" value="lower-case(.//text()[matches(.,'\S')])"/>
      <assert test="t:ref[@type='context'][@target=concat('context:corema.',$city_name)]">
        The context has to be given and has to match settlement name! 
      </assert>
    </rule>-->
  </pattern>
</schema>
