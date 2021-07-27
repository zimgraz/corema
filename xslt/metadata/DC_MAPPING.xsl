
<xsl:stylesheet xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" exclude-result-prefixes="xs" version="2.0">
    <xsl:template match="/">
        <oai_dc:dc xmlns:dc="http://purl.org/dc/elements/1.1/" xmlns:oai_dc="http://www.openarchives.org/OAI/2.0/oai_dc/" xmlns:t="http://www.tei-c.org/ns/1.0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
            <xsl:choose>
                <xsl:when test="contains(//t:idno[@type=&apos;PID&apos;],'todos') or contains(//t:idno[@type=&apos;PID&apos;],'about') or contains(//t:idno[@type=&apos;PID&apos;],'imprint') or contains(//t:idno[@type=&apos;PID&apos;],'chardec') or contains(//t:idno[@type=&apos;PID&apos;],'editorialdec') or contains(//t:idno[@type=&apos;PID&apos;],'semanticdec')">
                    <dc:title><xsl:value-of select="//t:titleStmt/t:title"/></dc:title>
                </xsl:when>
                <xsl:when test="//t:bibl[@type='corresponding_manuscript']">
                    <dc:title><xsl:text>Cooking Recipe for </xsl:text><xsl:value-of select="//t:titleStmt/t:title[@xml:lang='en']"/></dc:title>
                </xsl:when>
                <xsl:when test="contains(//t:idno[@type=&apos;PID&apos;],'recipes')">
                    <dc:title>
                        <xsl:text>Semantic Annotation of </xsl:text>
                        <xsl:value-of select="normalize-space(//t:msDesc/t:msIdentifier[1]/t:altIdentifier[@type=&apos;abbr&apos;]/t:idno)"></xsl:value-of>
                    </dc:title>
                </xsl:when>
                <xsl:otherwise>
                <dc:title>
                    <xsl:text>MS </xsl:text>
                    <xsl:value-of select="normalize-space(//t:msDesc/t:msIdentifier[1]/t:settlement)"></xsl:value-of>
                    <xsl:text>, </xsl:text>
                    <xsl:value-of select="normalize-space(//t:msDesc/t:msIdentifier[1]/t:institution)"></xsl:value-of>
                    <xsl:if test="//t:msDesc/t:msIdentifier[1]/t:repository">
                        <xsl:text>, </xsl:text>
                        <xsl:value-of select="normalize-space(//t:msDesc/t:msIdentifier[1]/t:repository)"></xsl:value-of>
                    </xsl:if>
                    <xsl:text>, </xsl:text>
                    <xsl:value-of select="normalize-space(//t:msDesc/t:msIdentifier[1]/t:idno)"></xsl:value-of>
                    <xsl:text> (</xsl:text>
                    <xsl:value-of select="normalize-space(//t:msDesc/t:msIdentifier[1]/t:altIdentifier[@type=&apos;abbr&apos;]/t:idno)"></xsl:value-of>
                    <xsl:text>)</xsl:text>
                </dc:title>
                </xsl:otherwise>
            </xsl:choose>
            <dc:subject>Cooking Recipes of the Middle Ages</dc:subject>
            <dc:relation>Cooking Recipes of the Middle Ages</dc:relation>
            <dc:relation>https://gams.uni-graz.at/corema</dc:relation>
            <xsl:if test="//t:ref[@type='context']/@target,'glyph'">
            <dc:relation>Character Declaration at: https://gams.uni-graz.at/o:corema.chardec/TEI_SOURCE</dc:relation>
            </xsl:if>
            <dc:creator>Helmut W. Klug</dc:creator>
            <dc:creator>Christian Steiner</dc:creator>
            <dc:creator>Astrid Böhm</dc:creator>
            <dc:creator>Julia Eibinger</dc:creator>
            <dc:contributor>Elisabeth Raunig</dc:contributor>
            <dc:publisher>Institut &quot;Zentrum für Informationsmodellierung&quot;, Uni Graz</dc:publisher>
            <dc:language>
                <xsl:choose>
                    <xsl:when test="//t:msContents/t:textLang[@ana=&apos;manuscript&apos;]/t:lang">
                        <xsl:for-each select="//t:msContents/t:textLang[@ana=&apos;manuscript&apos;]/t:lang">
                            <xsl:value-of select="."></xsl:value-of>
                            <xsl:choose>
                                <xsl:when test="position() = last()"></xsl:when>
                                <xsl:otherwise>, </xsl:otherwise>
                            </xsl:choose>
                        </xsl:for-each>
                    </xsl:when>
                    <xsl:when test="//t:profileDesc/t:langUsage/t:language">
                        <xsl:for-each select="//t:profileDesc/t:langUsage/t:language">
                            <xsl:value-of select="normalize-space(.)"/>
                        </xsl:for-each>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="//t:msContents/t:textLang[@ana=&apos;manuscript&apos;]"></xsl:value-of>
                    </xsl:otherwise>
                </xsl:choose>
            </dc:language>
            <dc:date>
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
            </dc:date>
            <dc:description>
                <xsl:choose>
                    <xsl:when test="//t:bibl[@type='corresponding_manuscript']">
                        <xsl:text>Cooking Recipe for </xsl:text><xsl:value-of select="//t:titleStmt/t:title[@xml:lang='en']"/><xsl:text> in the project https://gams.uni-graz.at/corema</xsl:text>
                    </xsl:when>
                    <xsl:when test="contains(//t:idno[@type=&apos;PID&apos;],'recipes')">
                        <xsl:text>Semantic Annotation of the cooking recipes in the project https://gams.uni-graz.at/corema</xsl:text>
                    </xsl:when>
                    <xsl:otherwise><xsl:text>Manuscript in the project https://gams.uni-graz.at/corema</xsl:text></xsl:otherwise>
                </xsl:choose>
            </dc:description>
            <dc:coverage>
                <xsl:value-of select="normalize-space(//t:settlement[1])"></xsl:value-of>
            </dc:coverage>
            <dc:type>
                <xsl:choose>
                <xsl:when test="//t:bibl[@type='corresponding_manuscript']">
                    <xsl:text>Cooking Recipe</xsl:text>
                </xsl:when>
                <xsl:otherwise><xsl:text>Manuscript</xsl:text></xsl:otherwise>
            </xsl:choose></dc:type>
            <xsl:for-each select="//t:availability/t:licence">
                <dc:rights><xsl:value-of select="./normalize-space()"/><xsl:text> for </xsl:text><xsl:value-of select="./@n"/></dc:rights>
            </xsl:for-each> 
            <dc:source>
                <xsl:choose>
                    <xsl:when test="//t:bibl[@type='corresponding_manuscript']">
                        <xsl:value-of select="//t:body/t:div/@n"/>
                    </xsl:when>
                    <xsl:otherwise><xsl:value-of select="normalize-space(//t:msIdentifier[1]/t:altIdentifier[@type=&apos;abbr&apos;]/t:idno)"/></xsl:otherwise>
                </xsl:choose>
            </dc:source>
            <dc:format>tei+xml</dc:format>
            <dc:format>rdf+xml</dc:format>
            <dc:format>plain</dc:format>
            <dc:identifier>
                <xsl:value-of select="//t:idno[@type=&apos;PID&apos;]"></xsl:value-of>
            </dc:identifier>
        </oai_dc:dc>
    </xsl:template>
</xsl:stylesheet>
