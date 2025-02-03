<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:t="http://www.tei-c.org/ns/1.0"
    xmlns="http://www.tei-c.org/ns/1.0"
    exclude-result-prefixes="xs"
    version="3.0">
    <xsl:output indent="yes"/>
    

    <!-- make the articles folder into a variable, it selectes all xml files in the same folder -->

    <xsl:variable name="articles" select="collection('.?select=*.xml')"/>
    

      
  
    
    <!--  add years -->
    
    
        
        <!-- Root template -->
        <xsl:template match="/">
            <roles>
                <!-- Extract unique role attributes, sort them alphabetically -->
                <xsl:for-each select="distinct-values($articles//persname[@role])">
                    <xsl:sort select="." collation="http://www.w3.org/2013/collation/UCA/ar" />
                    <role>
                        <xsl:value-of select="." />
                        
                        <!-- Find and list the contents of date elements with when-custom -->
                        <dates>
                            <xsl:for-each select="$articles//div[persname[@role = current()]]/date[@when-custom]">
                                <date when-custom="{@when-custom}">
                                    <xsl:value-of select="." />
                                </date>
                            </xsl:for-each>
                        </dates>
                        
                    </role>
                </xsl:for-each>
            </roles>
        </xsl:template>
    </xsl:stylesheet>
    
