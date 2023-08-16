<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet 
    xmlns="http://www.tei-c.org/ns/1.0"
    xmlns:t="http://www.tei-c.org/ns/1.0"
    xmlns:fn="digicai:functions"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    expand-text="yes"
    exclude-result-prefixes="fn t xs"
    version="3.0">
    
    <xsl:output indent="yes"/>
    
    <xsl:template match="/">
        <TEI xmlns="http://www.tei-c.org/ns/1.0">
            <teiHeader>
                <fileDesc>
                    <titleStmt>
                        <title>Data from Cairo Gazetteer</title>
                                                  
                            <author>Emmanuelle?</author>
                            <author>Anita Conrade</author> 
                            <author>Antonio Mendes da Silva</author>
                            <author>Emmanuelle Perrin</author>
                            <author>Juliette Hueber</author>
                            <author>Pierre Mounier</author>
                            <author>Racha El-Sayed</author>
                            <author>Maryse Bideault</author>
                            <author>Bassam Ayoub</author>
                       
                            <author>Mercedes Volait</author>
                                                    
                    </titleStmt>
                    <publicationStmt>
                        <p>"XMl TEI Edition of Urbanism News in al-Waqāʾiʿ al-Miṣriyya" in the project "La fabrique
                            du Caire moderne, 2018-2021" (IFAO-InVisu-Duke University).</p>
                        <p><ref target="https://sites.duke.edu/cairemoderne/">Website</ref></p>
                        <p>Project directors: <persName>Adam Mestyan</persName>, <persName>Mercedes Volait</persName>, <persName>Hugh Cayless</persName></p>
                    </publicationStmt>
                    <sourceDesc>
                        <p>Data gathered by Cairo Gazetteer team</p>
                    </sourceDesc>
                </fileDesc>
                <profileDesc>
                    <calendarDesc>
                        <calendar xml:id="hijri">
                            <p>The Islamic (Hijri) calendar,ٱلتَّقْوِيم ٱلْهِجْرِيّ</p>
                        </calendar>
                    </calendarDesc>
                </profileDesc>
            </teiHeader>
            <standOff>
                <xsl:apply-templates select=".//t:table"/>
            </standOff>
        </TEI>
    </xsl:template>
    
    <xsl:template match="t:table">
        <listPlace>
            <xsl:apply-templates select="t:row[xs:int(@n) gt 3]">
                <xsl:sort select="@n"/>
            </xsl:apply-templates>
        </listPlace>
    </xsl:template>
    
    <xsl:template match="t:row">
        
        <place source="#CGDATA">
            <xsl:call-template name="numero"/>
       
            <xsl:call-template name="URI_Main"/>
             
        </place>
    </xsl:template>
    
    <!-- Named Templates -->
    <xsl:template name="numero">
        <xsl:variable name="val" select="fn:cell(parent::t:table, xs:int(@n), fn:col(parent::t:table, 'numéro du monument'))"/>
        <xsl:if test="fn:has_data($val)">
            <xsl:attribute name="xml:id">CG{$val}</xsl:attribute>
        </xsl:if>
    </xsl:template>
    
    
    
    <xsl:template name="URI_Main">
        <xsl:variable name="val" select="fn:cell(parent::t:table, xs:int(@n), fn:col(parent::t:table, 'URI_Main'))"/>
        <xsl:if test="not($val = ('', 'n/a', 'NULL'))">
            <idno type="URI">{$val}</idno>
        </xsl:if>
    </xsl:template>
    
    
    
    <xsl:template name="wm_idnews">
        <xsl:variable name="val" select="fn:cell(parent::t:table, xs:int(@n), fn:col(parent::t:table, 'WM_IDNews'))"/>
        <xsl:if test="not($val = ('', 'n/a', 'NULL'))">
            <idno type="OSM">{$val}</idno>
        </xsl:if>
    </xsl:template>
    
    <xsl:template name="wm_araltname">
        <xsl:variable name="val" select="fn:cell(parent::t:table, xs:int(@n), fn:col(parent::t:table, 'WM_ArAltName'))"/>
        <xsl:if test="not($val = ('', 'n/a', 'NULL'))">
            <placeName type="alternate" xml:lang="ar">{$val}</placeName>
        </xsl:if>
    </xsl:template>
    
    <xsl:template name="wm_altname"> 
        <xsl:variable name="val" select="fn:cell(parent::t:table, xs:int(@n), fn:col(parent::t:table, 'WM_AltName'))"/>
        <xsl:if test="not($val = ('', 'n/a', 'NULL'))">
            <placeName type="alternate" xml:lang="ar-Latn">{$val}</placeName>
        </xsl:if>
    </xsl:template>
    
    <xsl:template name="geonames">
        <xsl:variable name="val" select="fn:cell(parent::t:table, xs:int(@n), fn:col(parent::t:table, 'Geonames'))"/>
        <xsl:if test="not($val = ('', 'n/a', 'NULL'))">
            <ptr target="{$val}"/>
        </xsl:if>
    </xsl:template>
    
    <xsl:template name="osm_type">
        <xsl:variable name="val" select="fn:cell(parent::t:table, xs:int(@n), fn:col(parent::t:table, 'osm_type'))"/>
        <xsl:if test="not($val = ('', 'n/a', 'NULL'))">
            <idno type="OSM">{$val}</idno>
        </xsl:if>
    </xsl:template>
    
    <xsl:template name="gis_id">
        <xsl:variable name="val" select="fn:cell(parent::t:table, xs:int(@n), fn:col(parent::t:table, 'GIS_ID'))"/>
        <xsl:if test="not($val = ('', 'n/a', 'NULL'))">
            <idno type="OSM">{$val}</idno>
        </xsl:if>
    </xsl:template>
    
    <xsl:template name="wm_higyear">
        <xsl:variable name="val" select="fn:cell(parent::t:table, xs:int(@n), fn:col(parent::t:table, 'WM_HegYear'))"/>
        <xsl:if test="not($val = ('', 'n/a', 'NULL'))">
            <date when-custom="{$val}" datingMethod="#hijri"/>
        </xsl:if>
    </xsl:template>
    
    <xsl:template name="wm_year">
        <xsl:variable name="val" select="fn:cell(parent::t:table, xs:int(@n), fn:col(parent::t:table, 'WM_Year'))"/>
        <xsl:if test="not($val = ('', 'n/a', 'NULL'))">
            <date when="{$val}"/>
        </xsl:if>
    </xsl:template>
    
    <xsl:template name="osm_id">
        <xsl:variable name="val" select="fn:cell(parent::t:table, xs:int(@n), fn:col(parent::t:table, 'osm_id'))"/>
        <xsl:if test="fn:has_data($val)">
            <idno type="OSM">{$val}</idno>
        </xsl:if>
    </xsl:template>
    
    <xsl:template name="wm_enname">
        <xsl:variable name="val" select="fn:cell(parent::t:table, xs:int(@n), fn:col(parent::t:table, 'WM_EnName'))"/>
        <xsl:if test="fn:has_data($val)">
            <placeName xml:lang="en">{$val}</placeName>
        </xsl:if>
    </xsl:template>
    
    <xsl:template name="wm_name">
        <xsl:variable name="val" select="fn:cell(parent::t:table, xs:int(@n), fn:col(parent::t:table, 'WM_Name'))"/>
        <xsl:if test="fn:has_data($val)">
            <placeName xml:lang="ar-Latn">{$val}</placeName>
        </xsl:if>
    </xsl:template>
    
    <xsl:template name="wm_arname">
        <xsl:variable name="val" select="fn:cell(parent::t:table, xs:int(@n), fn:col(parent::t:table, 'WM_ArName'))"/>
        <xsl:if test="fn:has_data($val)">
            <placeName xml:lang="ar">{$val}</placeName>
        </xsl:if>
    </xsl:template>
    
    <xsl:template name="wm_class">
        <xsl:variable name="val" select="fn:cell(parent::t:table, xs:int(@n), fn:col(parent::t:table, 'WM_Class'))"/>
        <xsl:if test="fn:has_data($val)">
            <xsl:attribute name="type">{$val}</xsl:attribute>
        </xsl:if>
    </xsl:template>
    
    <xsl:template name="osm_name">
        <xsl:variable name="val" select="fn:cell(parent::t:table, xs:int(@n), fn:col(parent::t:table, 'osm_name'))"/>
        <xsl:if test="fn:has_data($val)">
            <placeName type="OSM">{$val}</placeName>
        </xsl:if>
    </xsl:template>
    
    <xsl:template name="geo">
        <xsl:variable name="geometry" select="fn:cell(parent::t:table, xs:int(@n), fn:col(parent::t:table, 'Geometry'))"/>
        <xsl:variable name="x" select="fn:cell(parent::t:table, xs:int(@n), fn:col(parent::t:table, 'X'))"/>
        <xsl:variable name="y" select="fn:cell(parent::t:table, xs:int(@n), fn:col(parent::t:table, 'Y'))"/>
        <xsl:if test="$geometry = 'Point' and fn:has_data($x) and fn:has_data($y)">
            <geo>{$x} {$y}</geo>
        </xsl:if>
    </xsl:template>
    
    <xsl:template name="wm_ref">
        <xsl:variable name="val" select="fn:cell(parent::t:table, xs:int(@n), fn:col(parent::t:table, 'WM_Ref'))"/>
        <xsl:if test="fn:has_data($val)">
            <bibl>{$val}</bibl>
        </xsl:if>
    </xsl:template>
    
    <xsl:template name="wm_object">
        <xsl:variable name="val" select="fn:cell(parent::t:table, xs:int(@n), fn:col(parent::t:table, 'WM_Object'))"/>
        <xsl:if test="fn:has_data($val)">
            <note type="object">{$val}</note>
        </xsl:if>
    </xsl:template>
    
    <xsl:template name="wm_desc">
        <xsl:variable name="val" select="fn:cell(parent::t:table, xs:int(@n), fn:col(parent::t:table, 'WM_Description'))"/>
        <xsl:if test="fn:has_data($val)">
            <note type="description">{$val}</note>
        </xsl:if>
    </xsl:template>
    
    <xsl:template name="remarques">
        <xsl:variable name="val" select="fn:cell(parent::t:table, xs:int(@n), fn:col(parent::t:table, 'Remarques'))"/>
        <xsl:if test="fn:has_data($val)">
            <note>{$val}</note>
        </xsl:if>
    </xsl:template>
    
    <!-- Functions -->
    <xsl:function name="fn:col">
        <xsl:param name="table"/>
        <xsl:param name="head"/>
        <xsl:sequence select="$table/t:row[position() lt 6]/t:cell[. = $head]/count(preceding-sibling::t:cell) + 1"/>
    </xsl:function>
    
    <xsl:function name="fn:cell">
        <xsl:param name="table"/>
        <xsl:param name="row"/>
        <xsl:param name="col"/>
        <xsl:sequence select="$table/t:row[@n = $row]/t:cell[count(preceding-sibling::t:cell) + 1 = $col]"/>
    </xsl:function>
    
    <xsl:function name="fn:has_data" as="xs:boolean">
        <xsl:param name="value"/>
        <xsl:sequence select="not($value = ('', ' ', 'n/a', 'NULL'))"/>
    </xsl:function>
    
</xsl:stylesheet>