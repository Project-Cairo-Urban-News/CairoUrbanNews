<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="xml" indent="yes" encoding="UTF-8"/>
                
                <!-- Load both XML files from the "indexes" directory -->
                <xsl:variable name="arFile" select="document('indexes/rolesAr.xml')"/>
                <xsl:variable name="otaFile" select="document('indexes/rolesOta.xml')"/>
                
                <xsl:template match="/">
                    <mergedRoles>
                        <!-- Merge role elements from both datasets -->
                        <xsl:apply-templates select="$arFile/castItem/role | $otaFile/castItem/role">
                            <!-- Sort roles alphabetically according to Arabic script -->
                            <xsl:sort select="." lang="ar"/>
                        </xsl:apply-templates>
                    </mergedRoles>
                </xsl:template>
                
                <xsl:template match="role">
                    <role xml:lang="{@xml:lang}">
                        <xsl:value-of select="."/>
                    </role>
                </xsl:template>
            </xsl:stylesheet>