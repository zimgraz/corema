<schema xmlns="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt2">
    <title>Schematron for Corema recipe TEI/XML version</title>
    <ns prefix="t" uri="http://www.tei-c.org/ns/1.0"/>
    <pattern>
        <rule context="t:msDesc/t:msIdentifier">
            <assert test="t:altIdentifier[@type='abbr']">
                Abbreviation of manuscript is mandatory!
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
        <rule context="t:idno[@type='PID']">
            <let name="filename" value="//t:text/t:body/t:div[1]/@xml:id"/>
            <assert test="text()=concat('o:corema.',$filename)">
                PID has to match filename!
            </assert>
        </rule>
        <rule context="t:sourceDesc">
            <assert test="descendant::t:settlement">
                There has to be a settlement of the manuscript! 
            </assert>
        </rule> 
        
        <rule context="t:publicationStmt">
            <assert test="t:idno[@type='PID']">
                There has to be a PID!
            </assert>
        </rule>
        
        <rule context="t:text/t:body/t:div[@type]">
            <assert test="descendant::t:title">A recipe has to have a title somewhere!</assert>
        </rule>
        <rule context="t:title[not(descendant::text())]">
            <assert test="@type='none'">An empty title has to have @type='none'</assert>
        </rule>
        <rule context="@commodity">
            <assert test="starts-with(.,'Q')">A commodity has to be a valid Wikidata Q number</assert>
        </rule>
        <!--<rule context="* except (t:g | t:pb | t:lb | t:anchor | t:graphic | t:ptr | t:handShift |t:cb | t:mod | t:ref | t:date |t:locus)">
            <report test="not(node())">
                <name/> cannot be empty!
            </report>
        </rule>-->
    </pattern>
</schema>
