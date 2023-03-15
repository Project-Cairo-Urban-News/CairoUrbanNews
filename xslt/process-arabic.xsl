<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
  xmlns="http://www.tei-c.org/ns/1.0"
  xmlns:t="http://www.tei-c.org/ns/1.0"
  exclude-result-prefixes="#all"
  version="3.0">
  <xsl:mode on-no-match="shallow-copy"/>
  
  <xsl:output indent="yes"/>
  
  <xsl:variable name="output">
    <xsl:apply-templates select="//t:body" mode="output"/>
  </xsl:variable>
  
  <xsl:template match="/">
    <xsl:variable name="wrapper" select="doc('../master_CairoUrbanNews.xml')"/>
    <xsl:apply-templates select="$wrapper" mode="wrap"/>
  </xsl:template>
  
  <xsl:template match="@part|@default"/>
  
  <xsl:template match="node()|@*" mode="#all">
    <xsl:copy>
      <xsl:apply-templates select="node()|@*" mode="#current"/>
    </xsl:copy>
  </xsl:template>
  
  <xsl:template match="text()[ancestor::t:text]" mode="#all" priority="2">
    <xsl:value-of select="translate(.,'1234567890','١٢٣٤٥٦٧٨٩٠')"/>
  </xsl:template>
  
  <xsl:template match="t:body" mode="wrap">
    <xsl:copy-of select="$output"/>
  </xsl:template>
  
  <xsl:template match="t:p[ancestor::t:teiHeader]" priority="2">
    <xsl:copy>
      <xsl:apply-templates select="node()|@*"/>
    </xsl:copy>
  </xsl:template>
  
  <xsl:template match="t:body" mode="output">
    <xsl:variable name="pass1">
      <xsl:apply-templates select="(t:p|t:list|t:table)" mode="pass1"/>
    </xsl:variable>
    <xsl:copy>
      <xsl:apply-templates select="$pass1//t:p[@type='head']" mode="pass2"/>
    </xsl:copy>
  </xsl:template>
  
  <!-- Pass 1: remove empty <p> tags and mark <p> types -->
  
  <xsl:template match="t:p[normalize-space(.) != '' and t:hi[contains(@rend,'color(')]]" mode="pass1">
    <p type="head"><xsl:apply-templates mode="none"/></p>
  </xsl:template>
  
  <xsl:template match="t:p[normalize-space(.) != '' and @style='text-align: center;']" mode="pass1">
    <p type="head"><xsl:apply-templates mode="none"/></p>
  </xsl:template>
  
  <!--<xsl:template match="t:p[normalize-space(.) != '' and t:hi[matches(., '\s*ص\s?\d.*\s*عمود\s*\d.*')]]" mode="pass1" priority="1">
    <milestone n="{normalize-space(.)}"/>
  </xsl:template>-->
  
  <xsl:template match="t:p[normalize-space(.) = '']" mode="pass1"/>
  
  <xsl:template match="t:p" mode="pass1">
    <p type="body"><xsl:apply-templates mode="none"/></p>
  </xsl:template>
  
  <xsl:template match="t:list[count(t:item) = 1][not(ancestor::t:list)]" mode="pass1">
    <p type="head"><xsl:value-of select="t:item"/></p>
  </xsl:template>
  
  <xsl:template match="t:list|t:item" mode="pass1">
    <xsl:copy>
      <xsl:apply-templates select="node()|@*" mode="pass1"/>
    </xsl:copy>
  </xsl:template>
  
  <xsl:template match="t:item[normalize-space(.) = '']" mode="pass1"/>
  
  <xsl:template match="t:table" mode="pass1">
    <xsl:copy>
      <xsl:apply-templates mode="table"/>
    </xsl:copy>
  </xsl:template>
  
  <!-- Tables -->
  
  <xsl:template match="t:row" mode="table">
    <xsl:copy>
      <xsl:apply-templates mode="#current"/>
    </xsl:copy>
  </xsl:template>
  
  <xsl:template match="t:cell" mode="table">
    <xsl:copy>
      <xsl:choose>
        <xsl:when test="t:p"><xsl:apply-templates mode="table"/></xsl:when>
        <xsl:otherwise><xsl:value-of select="normalize-space(translate(.,'1234567890','١٢٣٤٥٦٧٨٩٠'))"/></xsl:otherwise>
      </xsl:choose>
    </xsl:copy>
  </xsl:template>
  
  <xsl:template match="t:hi" mode="table">
    <xsl:apply-templates/>
  </xsl:template>
  
  <xsl:template match="t:p" mode="table">
    <xsl:copy>
      <xsl:value-of select="normalize-space(translate(.,'1234567890','١٢٣٤٥٦٧٨٩٠'))"/>
    </xsl:copy>
  </xsl:template>
  
  
  <!-- Pass 2 -->
      
  <xsl:template match="t:p[@type='head']" mode="pass2">
    <div>
      <head><xsl:value-of select="normalize-space(translate(.,'1234567890','١٢٣٤٥٦٧٨٩٠'))"/></head>
      <xsl:apply-templates select="./following-sibling::t:*[1]" mode="head"/>
    </div>
  </xsl:template>
  
  <xsl:template match="t:p[@type='head']" mode="body"/>
  
  <xsl:template match="t:p[@type='head']" mode="head" priority="2">
    <head><xsl:value-of select="normalize-space(translate(.,'1234567890','١٢٣٤٥٦٧٨٩٠'))"/></head>
    <xsl:apply-templates select="./following-sibling::t:*[1]" mode="head"/>
  </xsl:template>
  
  <xsl:template match="t:p[@type='head'][preceding-sibling::t:p[1]/@type='head']" mode="pass2" priority="2"/>
        
  <xsl:template match="t:p[@type='body']" mode="head body">
    <p><xsl:apply-templates/></p>
    <xsl:apply-templates select="./following-sibling::t:*[1]" mode="body"/>
  </xsl:template>
  
  <xsl:template match="t:milestone" mode="head body">
    <xsl:copy-of select="."/>
    <xsl:apply-templates select="./following-sibling::t:*[1]" mode="#current"/>
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
  
  <xsl:template match="t:table" mode="pass2 body">
    <xsl:copy>
      <xsl:apply-templates select="node()|@*"/>
    </xsl:copy>
    <xsl:apply-templates select="following-sibling::t:*[1]" mode="#current"/>
  </xsl:template>
  
  <xsl:template match="t:hi[contains(@rend,'background(yellow)')]">
    <sic><xsl:apply-templates/></sic>
  </xsl:template>

  <xsl:template match="t:hi[not(@rend)]">
    <xsl:apply-templates/>
  </xsl:template>
  
  <xsl:template match="@dir" mode="#all"/>
  
  <xsl:template match="@style"/>
  
</xsl:stylesheet>