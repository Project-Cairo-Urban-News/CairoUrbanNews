<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:t="http://www.tei-c.org/ns/1.0"
    xmlns:fn="digcai:functions"
    exclude-result-prefixes="xs"
    expand-text="yes"
    version="3.0">
    
    <xsl:mode on-no-match="shallow-copy"/>
    
    <!-- Suppress default attributes -->
    <xsl:template match="@anchored|@part|@default|@sample|@complete|@instant|@ordered|@org|@status|@full" mode="#all"/>
    
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
                <xsl:when test="matches(@xml:id, 'W\d{10}')">
                    <xsl:copy-of select="@*"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:attribute name="xml:id">W{substring(t:head/t:date[@when-custom]/@when-custom, 1, 4)}{normalize-space(fn:pad(fn:convert(t:head/t:bibl/t:biblScope[@unit='issue']), 4))}{fn:pad(string(count(preceding-sibling::t:div) + 1), 2)}</xsl:attribute>
                    <xsl:apply-templates select="@*[name() ne 'xml:id']"/>
                </xsl:otherwise>
            </xsl:choose>
            <xsl:apply-templates/>
        </xsl:copy>
    </xsl:template>
    
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
        <xsl:sequence select="replace(translate($num,'١٢٣٤٥٦٧٨٩٠','1234567890'),'\D','')"/>
    </xsl:function>
    
</xsl:stylesheet>