<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:t="http://www.tei-c.org/ns/1.0"
    xmlns="http://www.tei-c.org/ns/1.0"
    exclude-result-prefixes="xs"
    version="3.0">
    <xsl:output indent="yes"/>
        
        <!-- Root template -->
        <xsl:template match="/">
            <roles>
                <!-- Extract unique role attributes, sort them alphabetically -->
                <xsl:for-each select="distinct-values(//persName/@role)">
                    <xsl:sort select="." collation="http://www.w3.org/2013/collation/UCA/ar" />
                    <role>
                        <xsl:value-of select="." />
                    </role>
                </xsl:for-each>
            </roles>
        </xsl:template>
    </xsl:stylesheet>
    
