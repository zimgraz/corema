
<xsl:stylesheet xmlns:mets="http://www.loc.gov/METS/" xmlns:t="http://www.tei-c.org/ns/1.0" xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl" xmlns:xlink="http://www.w3.org/1999/xlink" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0">
    <xsl:output indent="yes"></xsl:output>
    <xd:doc>
        <xd:desc> Strategie:
            * es muß eine logische Struktur geben
            * Die logische Struktur kann sein
            * minimal: tei:text/tei:body
            * eine Aggregation von Texten: teiCorpus oder tei:group
            * ein Text mit Titelei, Textkörper und Anhang
            * Abschnitte im Text (div oder div1/div2) in beliebiger Verschachtelung (bis zu einer maximalen Tiefe von $maxDepth
            * Die logische Struktur wird identifiziert über LOG.x.x.x
            * wenn es Bilder gibt, muß es auch eine physikalische Struktur und die Bilddateien geben
            * Die Bilddateien stehen in t:surface/t:graphic[1]/@url
            * Die Bilddateien werden identifiziert über t:graphic[1]/@xml:id
            * ihre Reihenfolge ergibt sich aus der Reihenfolge der @facs im Dokument? Aus der Reihenfolge der pb? Aus der Reihenfolge der surface-Elemente? Aus einem @n-Attribut von dem Zeug?
            * pragmatische Entscheidung: primär wird pb verwendet. 
            * Wenn es keine pb gibt, wird die Reihenfolge der t:surface verwendet
            * Die physikalische Struktur wird identifiziert über &quot;PHYS.x&quot;
            * surface/@xml:id enthält das beste Label? Oder kann ich das Label woanders herholen?
            * und die müssen alle verknüpft werden: 
            * filePtr in der physikalischen Struktur 
            * smLinks zwischen logischer und physikalischer Struktur
            * beruht auf preceeing::pb[1]/@facs oder wenn es das nicht gibt auf
            * ancestor-or-self::*/@fasc[1]
            * es  muß deskriptive und administrative Metadaten geben
            * Deskriptive Metadaten sind primär der teiHeader (kann der auch verwendet werden, wenn es kein msDesc gibt?
            * administrative Metadaten sind aus dem teiHeader ermittelbar oder gehören zu einem allgemeinen Projektkontext: context:{$projekt-id}/rights etc.
        </xd:desc>
    </xd:doc>
    <xsl:variable name="maxDepth" select="number(&apos;2&apos;)"></xsl:variable>
    <xsl:variable name="pid" select="/t:TEI/t:teiHeader/t:fileDesc/t:publicationStmt/t:idno[@type = &apos;PID&apos;]"></xsl:variable>
    <xsl:variable name="projekt" select="replace($pid, &apos;^.*?o:([^.])\..*?$&apos;, &apos;$1&apos;)"></xsl:variable>
    <xsl:variable name="server" select="&apos;https://glossa.uni-graz.at/&apos;"></xsl:variable>
    <xsl:template match="/">
        <xsl:apply-templates mode="mets"></xsl:apply-templates>
    </xsl:template>
    <xsl:template match="t:TEI" mode="mets">
        <mets:mets>
            <mets:dmdSec ID="DMD.1">
                <mets:mdWrap MDTYPE="TEIHDR" MIMETYPE="text/xml">
                    <mets:xmlData>
                        <xsl:apply-templates mode="copyTeiHeader" select="//t:teiHeader"></xsl:apply-templates>
                    </mets:xmlData>
                </mets:mdWrap>
            </mets:dmdSec>
            <mets:amdSec ID="AMD.1">
                <mets:rightsMD ID="RMD.1">
                    <mets:mdWrap MDTYPE="OTHER" MIMETYPE="text/xml" OTHERMDTYPE="DVRIGHTS">
                        <mets:xmlData>
                            <dv:rights xmlns:dv="http://dfg-viewer.de/">
                                
                                <dv:owner>Centre for Information Modelling, Graz, Austria</dv:owner>
                            </dv:rights>
                        </mets:xmlData>
                    </mets:mdWrap>
                </mets:rightsMD>
                <mets:digiprovMD ID="PMD.1">
                    <mets:mdWrap MDTYPE="OTHER" MIMETYPE="text/xml" OTHERMDTYPE="DVLINKS">
                        <mets:xmlData>
                            <dv:links xmlns:dv="http://dfg-viewer.de/">
                                <dv:reference></dv:reference>
                                <dv:presentation></dv:presentation>
                            </dv:links>
                        </mets:xmlData>
                    </mets:mdWrap>
                </mets:digiprovMD>
            </mets:amdSec>
            <mets:fileSec>
                <mets:fileGrp USE="DEFAULT">   
                    <xsl:for-each select="//t:surface">
                        <mets:file ID="{t:graphic[1]/@xml:id}" MIMETYPE="image/jpeg">
                            <mets:FLocat LOCTYPE="URL" xlink:href="{$server}{$pid}/{t:graphic[1]/@xml:id}"></mets:FLocat>
                        </mets:file>
                    </xsl:for-each>
                </mets:fileGrp>
            </mets:fileSec>
            <mets:structMap TYPE="PHYSICAL">
                <mets:div ID="PHYS.0" TYPE="physSequence">
                    <xsl:for-each select="//t:surface">
                        <xsl:call-template name="physstruct">
                            <xsl:with-param name="graphic" select="t:graphic[1]/@xml:id"></xsl:with-param>
                            <xsl:with-param name="position" select="position()"></xsl:with-param>
                        </xsl:call-template>
                    </xsl:for-each>
                </mets:div>
            </mets:structMap>
            <mets:structMap TYPE="LOGICAL">
                <mets:div ADMID="AMD.1" DMDID="DMD.1" ID="LOG.0" TYPE="monograph">
                    <xsl:variable name="dependent-root">
                        <xsl:choose>
                            <xsl:when test="//t:text/t:front | //t:text/t:back">
                                <xsl:copy-of select="//t:text/t:*"></xsl:copy-of>
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:copy-of select="//t:body/t:div"></xsl:copy-of>
                            </xsl:otherwise>
                        </xsl:choose>
                    </xsl:variable>
                    <xsl:for-each select="$dependent-root/t:*">
                        <xsl:variable name="logical">
                            <xsl:call-template name="id"></xsl:call-template>
                        </xsl:variable>
                        <xsl:apply-templates select="."></xsl:apply-templates>
                    </xsl:for-each>
                </mets:div>
            </mets:structMap>
            <mets:structLink>
                <mets:smLink xlink:from="LOG.0" xlink:to="PHYS.0"></mets:smLink>
                <xsl:for-each select="//t:front|//t:back|//t:body|//t:div[count(ancestor::t:div) lt ($maxDepth + 1)]">
                    <xsl:variable name="logical">
                        <xsl:call-template name="id"></xsl:call-template>
                    </xsl:variable>
                    <xsl:variable name="physical">
                        <xsl:apply-templates mode="id" select="current()/preceding::t:pb[1]"></xsl:apply-templates>
                    </xsl:variable>
                    <mets:smLink xlink:from="LOG.{$logical}" xlink:to="{$physical}"></mets:smLink>
                </xsl:for-each>
            </mets:structLink>
        </mets:mets>
    </xsl:template>
    <xsl:template match="t:pb" mode="id">
        <xsl:call-template name="id"></xsl:call-template>
    </xsl:template>
    <xsl:template name="physstruct">
        <xsl:param name="graphic"></xsl:param>
        <xsl:param name="position"></xsl:param>
        <mets:div ID="{substring-after(@start,&apos;#&apos;)}" LABEL="{substring-after(@start, &apos;.&apos;)}" ORDER="{$position}" TYPE="page">
            <mets:fptr FILEID="{$graphic}"></mets:fptr>
        </mets:div>
    </xsl:template>
    <xsl:template match="t:front | t:back">
        <xsl:variable name="id">
            <xsl:call-template name="id"></xsl:call-template>
        </xsl:variable>
        <xsl:variable name="label">
            <xsl:choose>
                <xsl:when test="t:head">
                    <xsl:value-of select="t:head"></xsl:value-of>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:choose>
                        <xsl:when test="name() = &apos;front&apos;">Titelei</xsl:when>
                        <xsl:otherwise>Anhang</xsl:otherwise>
                    </xsl:choose>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        <mets:div ID="{concat(&apos;LOG.&apos;, $id)}">
            <xsl:attribute name="LABEL">
                <xsl:value-of select="$label"></xsl:value-of>
            </xsl:attribute>
        </mets:div>
    </xsl:template>
    <xsl:template match="t:div">
        <xsl:param name="logical"></xsl:param>
        <xsl:variable name="id">
            <xsl:call-template name="id"></xsl:call-template>
        </xsl:variable>
        <xsl:variable name="label">
            <xsl:choose>
                <xsl:when test="t:head">
                    <xsl:value-of select="t:head/normalize-space(.)"></xsl:value-of>
                </xsl:when>
                <xsl:when test="t:ab[1]/t:label">
                    <xsl:value-of select="t:ab[1]/t:label/normalize-space(.)"></xsl:value-of>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:text>Abschnitt</xsl:text>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        <mets:div ID="LOG.{$id}">
            <xsl:attribute name="LABEL">
                <xsl:value-of select="$label"></xsl:value-of>
            </xsl:attribute>
            <xsl:if test="count(ancestor::t:div) lt ($maxDepth)">
                <xsl:apply-templates select="t:div"></xsl:apply-templates>
            </xsl:if>
        </mets:div>
    </xsl:template>
    <xsl:template name="id">
        <xsl:choose>
            <xsl:when test="@xml:id">
                <xsl:value-of select="@xml:id"></xsl:value-of>
            </xsl:when>
            <xsl:when test="t:head/@xml:id">
                <xsl:value-of select="t:head/@xml:id"></xsl:value-of>
            </xsl:when>
            <xsl:when test="t:ab[1]/t:label/@xml:id">
                <xsl:value-of select="t:ab[1]/t:label/@xml:id"></xsl:value-of>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="generate-id()"></xsl:value-of>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <xsl:template match="t:teiHeader" mode="copyTeiHeader">
        <teiHeader xmlns="http://www.tei-c.org/ns/1.0">
            <fileDesc>
                <titleStmt>
                    <xsl:copy-of copy-namespaces="no" select=".//t:title[3]"></xsl:copy-of>
                </titleStmt>
                <xsl:copy-of copy-namespaces="no" select=".//t:publicationStmt"></xsl:copy-of>
                <xsl:copy-of copy-namespaces="no" select=".//t:seriesStmt"></xsl:copy-of>
                <sourceDesc>
                    <msDesc>
                        <msIdentifier>
                            <placeName>
                                <xsl:value-of select=".//t:altIdentifier/t:placeName/text()[1]/normalize-space()"></xsl:value-of>
                            </placeName>
                            <date>
                                <xsl:value-of select=".//t:altIdentifier/t:placeName/t:date/text()/normalize-space()"></xsl:value-of>
                            </date>
                            <idno>
                                <xsl:value-of select=".//t:altIdentifier/t:idno/text()/normalize-space()"></xsl:value-of>
                            </idno>
                        </msIdentifier>
                    </msDesc>
                </sourceDesc>
                <xsl:copy-of copy-namespaces="no" select="./t:encodingDesc"></xsl:copy-of>
                <xsl:copy-of copy-namespaces="no" select="./t:profileDesc"></xsl:copy-of>
                <xsl:copy-of copy-namespaces="no" select="./t:revisionDesc"></xsl:copy-of>
            </fileDesc>
        </teiHeader>
    </xsl:template>
</xsl:stylesheet>
