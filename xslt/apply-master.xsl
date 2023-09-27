<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
  xmlns="http://www.tei-c.org/ns/1.0"
  xmlns:t="http://www.tei-c.org/ns/1.0"
  exclude-result-prefixes="#all"
  version="3.0">
  
  <xsl:variable name="text">
    <xsl:sequence select="//t:text"/>
  </xsl:variable>
  
  <xsl:variable name="standOff">
    <xsl:sequence select="//t:standOff"/>
  </xsl:variable>

  <xsl:variable name="revisionDesc">
    <xsl:sequence select="//t:revisionDesc"/>
  </xsl:variable>
  
  <xsl:template match="/">
    <xsl:variable name="wrapper" select="doc('../master_CairoUrbanNews.xml')"/>
    <xsl:apply-templates select="$wrapper" mode="wrap"/>
  </xsl:template>
  
  <!-- Suppress default attributes -->
  <xsl:template match="@part|@default|@sample|@complete|@instant|@org|@status|@full" mode="#all"/>
  
  <xsl:template match="t:change/@status">
    <xsl:copy-of select="."/>
  </xsl:template>
  
  <xsl:template match="node()|@*" mode="#all">
    <xsl:copy>
      <xsl:apply-templates select="node()|@*" mode="#current"/>
    </xsl:copy>
  </xsl:template>

  <xsl:template match="t:revisionDesc" mode="wrap">
    <xsl:apply-templates select="$revisionDesc/t:revisionDesc"/>
  </xsl:template>
  
  <xsl:template match="t:text" mode="wrap">
    <xsl:apply-templates select="$standOff/t:standOff"/><xsl:text>
  </xsl:text>
    <xsl:apply-templates select="$text/t:text"/>
  </xsl:template>
  
</xsl:stylesheet>