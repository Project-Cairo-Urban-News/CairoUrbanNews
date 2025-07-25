<xsl:stylesheet version="2.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:tei="http://www.tei-c.org/ns/1.0"
  exclude-result-prefixes="tei">
  
  <xsl:output method="text"/>
  
  <xsl:template match="/">
    <xsl:text>Total divs: </xsl:text>
    <xsl:value-of select="count(//tei:div)"/>
    <xsl:text>&#10;</xsl:text>
  </xsl:template>
</xsl:stylesheet>