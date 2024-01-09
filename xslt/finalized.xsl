<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xs="http://www.w3.org/2001/XMLSchema"
  xmlns:t="http://www.tei-c.org/ns/1.0"
  xmlns:eg="http://www.tei-c.org/ns/Examples"
  exclude-result-prefixes="t eg xs"
  version="3.0" expand-text="yes">
  
  <xsl:output method="html" version="5" indent="no"/>

  <xsl:template name="start">
    <html lang="en">
      <head>
        <meta charset="UTF-8"/>
        <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
        <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
        <title>Cleared Documents</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous"/>
        <link rel="stylesheet" href="css/finalized.css"/>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4" crossorigin="anonymous"></script>
      </head>
      <body>
        <div id="list">
          <h1>الوقائع المصريّة</h1>
          <div class="columns">
            <h2 id="arabic">العربية</h2>
            <ul id="arabic_files">
              <xsl:for-each select="uri-collection('../articles/arabic/?select=*.xml')">
                <xsl:sort select="."/>
                <xsl:variable name="vol" select="doc(.)"/>
                <xsl:variable name="out" select="replace(., '.*/(.+)\.xml', 'articles/arabic/$1.html')"/>
                <xsl:variable name="name" select="replace(., '.*/(.+)\.xml', '$1')"/>
                <xsl:if test="$vol//t:revisionDesc[@status='cleared']">
                  <li><a href="{$out}">{$name}</a></li>
                  <xsl:result-document href="../docs/{$out}" method="html">
                    <xsl:apply-templates select="$vol" mode="template"/>
                  </xsl:result-document>
                </xsl:if>
              </xsl:for-each>
            </ul>
            <h2 id="ottoman">Osmanlı</h2>
            <ul id="ottoman_files">
              <xsl:for-each select="uri-collection('../articles/ottoman/?select=*.xml')">
                <xsl:sort select="."/>
                <xsl:variable name="vol" select="doc(.)"/>
                <xsl:variable name="out" select="replace(., '.*/(.+)\.xml', 'articles/ottoman/$1.html')"/>
                <xsl:variable name="name" select="replace(., '.*/(.+)\.xml', '$1')"/>
                <xsl:if test="$vol//t:revisionDesc[@status='cleared']">
                  <li><a href="{$out}">{$name}</a></li>
                  <xsl:result-document href="../docs/{$out}" method="html">
                    <xsl:apply-templates select="$vol" mode="template"/>
                  </xsl:result-document>
                </xsl:if>
              </xsl:for-each>
            </ul>
          </div>
        </div>
      </body>
    </html>
  </xsl:template>
  
  <xsl:template match="/" mode="template">
    <html>
      <head> 
        <meta charset="UTF-8"/>
        <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
        <meta http-equiv="X-UA-Compatible" content="ie=edge"/>
        <title></title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous"/>
        <link rel="stylesheet" href="../../css/finalized.css"/>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4" crossorigin="anonymous"></script>
        <script src="../../js/CETEI.js"></script>
        <script src="../../js/behaviors-finalized.js">></script>
      </head>
      <body>
        <div><xsl:text>
</xsl:text>
          <xsl:apply-templates select="node()|comment()"/><xsl:text>
</xsl:text>
          <script type="text/javascript">
            const c = new CETEI();
            c.addBehaviors(behaviors);
            c.processPage();
            const tooltipTriggerList = document.querySelectorAll('[data-bs-toggle="tooltip"]');
            const tooltipList = [...tooltipTriggerList].map(tooltipTriggerEl => new bootstrap.Tooltip(tooltipTriggerEl));
          </script>
        </div>
      </body>
    </html>
  </xsl:template>
  
  <xsl:template match="@*|comment()">
    <xsl:copy><xsl:apply-templates select="node()|@*|comment()"/></xsl:copy>
  </xsl:template>
  
  <xsl:template match="*[namespace-uri(.) = 'http://www.tei-c.org/ns/1.0']">
    <xsl:element name="tei-{lower-case(local-name(.))}" >
      <xsl:if test="namespace-uri(parent::*) != namespace-uri(.)"><xsl:attribute name="data-xmlns"><xsl:value-of select="namespace-uri(.)"/></xsl:attribute></xsl:if>
      <xsl:if test="@xml:id">
        <xsl:attribute name="id"><xsl:value-of select="@xml:id"/></xsl:attribute>
      </xsl:if>
      <xsl:if test="@xml:lang">
        <xsl:attribute name="lang"><xsl:value-of select="@xml:lang"/></xsl:attribute>
      </xsl:if>
      <xsl:attribute name="data-origname"><xsl:value-of select="local-name(.)"/></xsl:attribute>
      <xsl:if test="@*">
        <xsl:attribute name="data-origatts">
          <xsl:for-each select="@*">
            <xsl:value-of select="name(.)"/>
            <xsl:if test="not(position() = last())"><xsl:text> </xsl:text></xsl:if>
          </xsl:for-each>
        </xsl:attribute>
      </xsl:if>
      <xsl:for-each select="@*[namespace-uri() = '']">
        <xsl:copy-of select="."/>
      </xsl:for-each>
      <xsl:apply-templates select="node()|comment()|processing-instruction()"/>
    </xsl:element>
  </xsl:template>
  
  <xsl:function name="t:elementList">
    <xsl:param name="doc"/>
    <xsl:for-each select="distinct-values($doc//*[namespace-uri(.) = 'http://www.tei-c.org/ns/1.0']/local-name())">"<xsl:value-of select="."/>"<xsl:if test="position() != last()">,</xsl:if></xsl:for-each>
  </xsl:function>
  
</xsl:stylesheet>