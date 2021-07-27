<schema xmlns="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt2">
    <title>Schematron for Corema recipe TEI/XML version</title>
    <ns prefix="t" uri="http://www.tei-c.org/ns/1.0"/>
    <pattern>
        <rule context="//t:text//@corresp">
            <report test="if (contains(.,' ')) then (not(starts-with(substring-after(.,' '),'#'))) else (not(starts-with(.,'#')))">
                <name/> has to start with #
            </report>
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
            <!--<let name="filename" value="lower-case(substring-before(substring-after(//t:surface[1]/@start,'#'),'_'))"/>-->
            <let name="filename" value="lower-case(substring-before(tokenize(base-uri(.), '/')[last()],'_'))"/>
            <assert test="text()=concat('o:corema.',$filename,'.recipes')">
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
            <assert test="@target='context:corema.recipes'">
                second context has to be 'context:corema.recipes'!
            </assert>
        </rule>
        <rule context="t:msDesc/t:msContents">
            <assert test="t:textLang[@ana='manuscript']">
                There has to be a @ana attribute with the value 'manuscript'!
            </assert>
        </rule>
        <rule context="t:body//t:ab[@type]">
            <assert test="descendant::t:title">A recipe has to have a title somewhere!</assert>
        </rule>
        <rule context="t:title[not(descendant::text())]">
            <assert test="@type='none'">An empty title has to have @type='none'</assert>
        </rule>
        <rule context="@commodity">
            <assert test="starts-with(.,'Q')">A commodity has to be a valid Wikidata Q number</assert>
        </rule>
        <rule context="t:pb">
            <assert test="string-length(substring-after(@xml:id,'_'))=4">
                @xml:id and @n must have three-digit numbers!
            </assert>
            <assert test="string-length(@n)=4">
                @xml:id and @n must have three-digit numbers!
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
        <rule context="t:origin/t:origDate[1]">
            <assert test="t:date[@xml:lang='en']">
                at least an english date has to be present in first origdate
            </assert>
        </rule>
        <!--<rule context="* except (t:g | t:pb | t:lb | t:anchor | t:graphic | t:ptr | t:handShift |t:cb | t:mod | t:ref | t:date |t:locus)">
            <report test="not(node())">
                <name/> cannot be empty!
            </report>
        </rule>-->
    </pattern>
</schema>
