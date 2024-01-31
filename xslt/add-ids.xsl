<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:t="http://www.tei-c.org/ns/1.0"
    xmlns:fn="digcai:functions"
    exclude-result-prefixes="xs"
    expand-text="yes"
    version="3.0">
    
    <xsl:mode on-no-match="shallow-copy"/>
    
    <xsl:variable name="lang" select="//t:text/@xml:lang"/>
    
    <!-- Suppress default attributes -->
    <xsl:template match="@anchored|@part|@default|@sample|@complete|@instant|@ordered|@org|@status|@full"/>
    
    <xsl:template match="@rows[.='1']"/>
    
    <xsl:template match="@cols[.='1']"/>
    
    <xsl:template match="t:revisionDesc/@status[. = 'cleared']">
        <xsl:copy>
            <xsl:apply-templates/>
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="t:change/@status[. = 'cleared']">
        <xsl:copy>
            <xsl:apply-templates/>
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="@role[.='data']"/>
    
    <xsl:template match="t:div[t:head[t:date/@when-custom]][//t:revisionDesc[@status='cleared']]">
        <xsl:copy>
            <xsl:choose>
                <xsl:when test="matches(@xml:id, 'W[AO][0-9]{11}')">
                    <xsl:copy-of select="@*"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:attribute name="xml:id">{fn:div-id(.)}</xsl:attribute>
                    <xsl:apply-templates select="@*[name() ne 'xml:id']"/>
                </xsl:otherwise>
            </xsl:choose>
            <xsl:apply-templates/>
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="t:placeName[not(matches(@xml:id,'^place-W[AO][0-9]{11}_\d{2}$'))][//t:revisionDesc[@status='cleared']]">
        <xsl:variable name="article" select="ancestor::t:div[t:head/t:date/@when-custom][1]"/>
        <xsl:variable name="i" select="count(preceding::t:placeName[ancestor::t:div = $article]) + count(ancestor::t:placeName) + 1"/>
        <xsl:copy>
            <xsl:attribute name="xml:id">place-{fn:div-id($article)}_{fn:pad(xs:string($i), 2)}</xsl:attribute>
            <xsl:apply-templates select="@*[name() != 'xml:id']"/>
            <xsl:apply-templates/>
        </xsl:copy>
    </xsl:template>
    
    <xsl:function name="fn:div-id">
        <xsl:param name="div"/>
        <xsl:variable name="issue" select="fn:convert(normalize-space($div/t:head/t:bibl/t:biblScope[@unit='issue']))"/>
        <xsl:sequence>W{upper-case(substring($lang,1,1))}{substring($div/t:head[1]/t:date[@when-custom]/@when-custom, 1, 4)}{normalize-space(fn:pad($issue, 4))}{fn:pad(string(count($div/preceding-sibling::t:div[fn:convert(t:head/t:bibl/t:biblScope[@unit='issue']) = $issue]) + 1), 2)}</xsl:sequence>
    </xsl:function>
    
    <xsl:function name="fn:pad">
        <xsl:param name="in" as="xs:string"/>
        <xsl:param name="pad"/>
        <xsl:choose>
            <xsl:when test="string-length($in) lt $pad">
                <xsl:sequence select="fn:pad(0 || $in, $pad)"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:sequence select="$in"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:function>
    
    <xsl:function name="fn:convert">
        <xsl:param name="num"/>
        <xsl:sequence select="normalize-space(replace(translate($num,'١٢٣٤٥٦٧٨٩٠۱۲۳۴۵۶۷۸۹۰','12345678901234567890'),'\D',''))"/>
    </xsl:function>
    
</xsl:stylesheet>