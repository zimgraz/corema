
<xsl:stylesheet xmlns="http://www.opengis.net/kml/2.2" xmlns:t="http://www.tei-c.org/ns/1.0" xmlns:xs="http://www.w3.org/2001/XMLSchema" 
  xmlns:xsd="http://www.w3.org/2001/XMLSchema#" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" exclude-result-prefixes="xs" version="2.0">
  <xsl:param name="context"></xsl:param>
  <xsl:param name="pid"></xsl:param>
  <xsl:param name="model"></xsl:param>    
  <xsl:template match="/">        
    <entry>      
      <xsl:if test="//t:msIdentifier/t:settlement!=''">
        <xsl:for-each-group select="//t:msIdentifier/t:settlement" group-by=".">
        <Placemark>
          <name>
            <xsl:value-of select="normalize-space(//t:altIdentifier[@type='abbr'])"/>
          </name>
          <address><xsl:value-of select="normalize-space(//t:msIdentifier/t:settlement)"/></address>
          <description><xsl:value-of select="normalize-space(//t:msIdentifier/t:msName)"/></description>
          <Point>
            <coordinates>                     
              <xsl:value-of select="//t:location/t:geo"/>
            </coordinates>
          </Point>
        </Placemark>
        </xsl:for-each-group> 
      </xsl:if> 
    </entry>
  </xsl:template> 
</xsl:stylesheet>



