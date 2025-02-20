<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:t="http://www.tei-c.org/ns/1.0"
    xmlns="http://www.tei-c.org/ns/1.0" exclude-result-prefixes="xs" version="3.0"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0">
    <xsl:output indent="yes"/>
    
    

    
    <xsl:template match="/" name="xsl:initial-template">>
        <!-- Load all XML files from the "indexes" directory -->
        <xsl:variable name="files" select="collection('indexes?select=*.xml')"/>
        
        <xsl:for-each-group select="$files//castItem/role" group-by="role">
            <xsl:sort select="translate(current-grouping-key(), '-', ' ')"
                collation="http://www.w3.org/2013/collation/UCA/ar"/>
            
   <!-- innentol nem tudom       !!!!! -->  
        <mergedRoles>
            <!-- Apply templates to all role elements from all files -->
            <xsl:apply-templates select="$files//role">
                <!-- Sort them according to Arabic alphabetical order -->
                <xsl:sort select="." lang="ar"/>
            </xsl:apply-templates>
        </mergedRoles>
        </xsl:for-each-group>
    </xsl:template>
    
    <!-- Template to copy role elements as they are -->
    <xsl:template match="role">
        <role>
            <!-- Copy all attributes -->
            <xsl:copy-of select="@*"/>
            <!-- Copy the text value -->
            <xsl:value-of select="."/>
        </role>
       
    </xsl:template>
   </xsl:stylesheet>