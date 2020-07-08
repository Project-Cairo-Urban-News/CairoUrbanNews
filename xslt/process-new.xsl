<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
  xmlns="http://www.tei-c.org/ns/1.0"
  xmlns:t="http://www.tei-c.org/ns/1.0"
  exclude-result-prefixes="#all"
  version="3.0">
  
  <xsl:output indent="yes"/>
  
  <xsl:template match="/">
    <xsl:apply-templates select="node()"/>
  </xsl:template>
  
  <xsl:template match="@part|@default"/>
  
  <xsl:template match="node()|@*">
    <xsl:copy>
      <xsl:apply-templates select="node()|@*"/>
    </xsl:copy>
  </xsl:template>
  
  <xsl:template match="t:p[ancestor::t:teiHeader]" priority="2">
    <xsl:copy>
      <xsl:apply-templates select="node()|@*"/>
    </xsl:copy>
  </xsl:template>
  
  <xsl:template match="t:body">
    <xsl:variable name="pass1">
      <div>
        <xsl:apply-templates select="(t:p|t:list)" mode="pass1"/>
      </div>
    </xsl:variable>
    <xsl:copy>
      <xsl:apply-templates select="$pass1//t:p[@type='head']" mode="pass2"/>
    </xsl:copy>
  </xsl:template>
  
  <!-- Pass 1: remove empty <p> tags and mark <p> types -->
  
  <xsl:template match="t:p[normalize-space(.) != '' and not(contains(., '&#x000A;'))]" mode="pass1">
    <p type="head"><xsl:apply-templates/></p>
  </xsl:template>
  
  <xsl:template match="t:p[normalize-space(.) = '']" mode="pass1"/>
  
  <xsl:template match="t:p[t:hi]" mode="pass1" priority="2">
    <p type="head"><xsl:apply-templates/></p>
  </xsl:template>
  
  <xsl:template match="t:p[contains(substring-after(.,'&#x000A;'),'&#x000A;')]" mode="pass1">
    <p type="body"><xsl:apply-templates/></p>
  </xsl:template>
  
  <xsl:template match="t:list[count(t:item) = 1][not(ancestor::t:list)]" mode="pass1">
    <p type="head"><xsl:value-of select="t:item"/></p>
  </xsl:template>
  
  <xsl:template match="t:list|t:item|@*" mode="pass1">
    <xsl:copy>
      <xsl:apply-templates select="node()|@*" mode="pass1"/>
    </xsl:copy>
  </xsl:template>
  
  <xsl:template match="t:item[normalize-space(.) = '']" mode="pass1"/>
  
  <!-- Pass 2 -->
      
  <xsl:template match="t:p[@type='head']" mode="pass2">
    <div>
      <head><xsl:value-of select="normalize-space(.)"/></head>
      <xsl:apply-templates select="./following-sibling::t:*[1]" mode="head"/>
    </div>
  </xsl:template>
  
  <xsl:template match="t:p[@type='head']" mode="body"/>
  
  <xsl:template match="t:p[@type='head']" mode="head" priority="2">
    <head><xsl:value-of select="normalize-space(.)"/></head>
    <xsl:apply-templates select="./following-sibling::t:*[1]" mode="head"/>
  </xsl:template>
  
  <xsl:template match="t:p[@type='head'][preceding-sibling::t:p[1]/@type='head']" mode="pass2" priority="2"/>
        
  <xsl:template match="t:p[@type='body']" mode="head body">
    <p><xsl:apply-templates/></p>
    <xsl:apply-templates select="./following-sibling::t:*[1]" mode="body"/>
  </xsl:template>
  
  <xsl:template match="t:p[@type='body']" mode="pass2"/>
  
  <xsl:template match="t:list[not(ancestor::t:list)]" mode="pass2 head">
    <head>
       <xsl:copy>
        <xsl:apply-templates select="node()|@*"/>
      </xsl:copy>
    </head>
    <xsl:apply-templates select="following-sibling::t:*[1]" mode="#current"/>
  </xsl:template>
  
  <xsl:template match="t:list[normalize-space(.) = '']" mode="pass2 head" priority="2"/>
  
  <xsl:template match="node()|@*" mode="pass2 head">
    <xsl:copy>
      <xsl:apply-templates select="node()|@*" mode="#current"/>
    </xsl:copy>
  </xsl:template>
  
</xsl:stylesheet>