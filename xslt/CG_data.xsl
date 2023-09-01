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
                        <title>Selected Data from Cairo Gazetteer</title>
                                                  
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
                        <p>XSLT transformation and selection by Adam Mestyan</p>
                    </sourceDesc>
                </fileDesc>
                <profileDesc>
                    <calendarDesc>
                        <calendar xml:id="hijri">
                            <p>The Islamic (Hijri) calendar,ٱلتَّقْوِيم ٱلْهِجْرِيّ</p>
                        </calendar>
                        <calendar xml:id="gregorian">
                            <p>The Gregorian calendar</p>
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
                        <xsl:call-template name="pref_arabname"/>
            <xsl:call-template name="alt_arabname"/>
            <xsl:call-template name="ISO_translitname"/>
            <xsl:call-template name="ALA-LC_translitname"/>
          
            <xsl:call-template name="altname_Fachinelli"/>
            <xsl:call-template name="altname_GrandBeyMap"/>
                    
            <xsl:call-template name="type_inarabic"/>
            <xsl:call-template name="neighbourhood_inarabic"/>
            <xsl:call-template name="neighbourhood_geocoordinates"/>
            
            <xsl:call-template name="foundationyear"/>
            
                                   <xsl:call-template name="type_number"/>
            <xsl:call-template name="URI_Fachinelli"/>
            <xsl:call-template name="URI_Main"/> 
            <xsl:call-template name="notice_francais"/>
            <xsl:call-template name="notice_anglais"/>
            <xsl:call-template name="notice_arabe"/>
            
            
            <!--some data - for instance notices - are not coming through properly in some cases, also let's discuss coordinates -->
            
            
            <xsl:call-template name="neighbourhood_geonameslink"/> 
            <!--
            <xsl:call-template name="geonamesLink"/>
            -->
           
            

        </place>
    </xsl:template>
    
    <!-- Named Templates -->
    
    <xsl:template name="numero">
        <xsl:variable name="val" select="fn:cell(parent::t:table, xs:int(@n), fn:col(parent::t:table, 'numéro du monument'))"/>
        <xsl:if test="fn:has_data($val)">
            <xsl:attribute name="xml:id">CG{$val}</xsl:attribute>
        </xsl:if>
    </xsl:template>
 
   
    
    <xsl:template name="pref_arabname">
        <xsl:variable name="val" select="fn:cell(parent::t:table, xs:int(@n), fn:col(parent::t:table, 'skos:prefLabel@ar'))"/>
        <xsl:if test="not($val = ('', 'n/a', 'NULL'))">
            <placeName xml:lang="ar">{$val}</placeName>
        </xsl:if>
    </xsl:template>
    
    <xsl:template name="alt_arabname">
        <xsl:variable name="val" select="fn:cell(parent::t:table, xs:int(@n), fn:col(parent::t:table, 'skos:altLabel@ar'))"/>
        <xsl:if test="not($val = ('', 'n/a', 'NULL'))">
            <placeName type="alternate" xml:lang="ar">{$val}</placeName>
        </xsl:if>
    </xsl:template>
    
    <xsl:template name="ISO_translitname"> 
        <xsl:variable name="val" select="fn:cell(parent::t:table, xs:int(@n), fn:col(parent::t:table, 'skos:prefLabel@ISO'))"/>
        <xsl:if test="not($val = ('', 'n/a', 'NULL'))">
            <placeName type="alternate_ISO" xml:lang="ar-Latn">{$val}</placeName>
        </xsl:if>
    </xsl:template>
    
    
    <xsl:template name="ALA-LC_translitname"> 
        <xsl:variable name="val" select="fn:cell(parent::t:table, xs:int(@n), fn:col(parent::t:table, 'skos:preflabel@ALA'))"/>
        <xsl:if test="not($val = ('', 'n/a', 'NULL'))">
            <placeName type="alternate_ALA-LC" xml:lang="ar-Latn">{$val}</placeName>
        </xsl:if>
    </xsl:template>
    
    <xsl:template name="type_number">
        <xsl:variable name="val" select="fn:cell(parent::t:table, xs:int(@n), fn:col(parent::t:table, 'skos:broader'))"/>
        <xsl:if test="not($val = ('', 'n/a', 'NULL'))">
            <idno type="URI">{$val}</idno>
        </xsl:if>
    </xsl:template>
    
    <xsl:template name="URI_Main">
        <xsl:variable name="val" select="fn:cell(parent::t:table, xs:int(@n), fn:col(parent::t:table, 'URI_Main'))"/>
        <xsl:if test="not($val = ('', 'n/a', 'NULL'))">
            <idno type="URI">{$val}</idno>
        </xsl:if>
    </xsl:template>
    
    <!-- I have no better idea to express a type of building in an element (in TEI it is an attribute) -->
    <xsl:template name="type_inarabic"> 
        <xsl:variable name="val" select="fn:cell(parent::t:table, xs:int(@n), fn:col(parent::t:table, 'libellé arabe_type'))"/>
        <xsl:if test="not($val = ('', 'n/a', 'NULL'))">
            <label xml:lang="ar">{$val}</label>
        </xsl:if>
    </xsl:template>
    
    <xsl:template name="neighbourhood_inarabic">
        <xsl:variable name="val" select="fn:cell(parent::t:table, xs:int(@n), fn:col(parent::t:table, 'libellé arabe'))"/>
        <xsl:if test="not($val = ('', 'n/a', 'NULL'))">
            <placeName type="neighbourhood" xml:lang="ar">{$val}</placeName>
        </xsl:if>
    </xsl:template>
    
   
    <xsl:template name="neighbourhood_geonameslink">
        <xsl:variable name="val" select="fn:cell(parent::t:table, xs:int(@n), fn:col(parent::t:table, 'skos:relatedMatch_URI'))"/>
        <xsl:if test="not($val = ('', 'n/a', 'NULL'))">
          <xsl:copy-of select="$val"/>
        </xsl:if>
    </xsl:template>
   
    
    <xsl:template name=" neighbourhood_geocoordinates">
        <xsl:variable name="val" select="fn:cell(parent::t:table, xs:int(@n), fn:col(parent::t:table, 'coordonnées géographiques'))"/>
        <xsl:if test="not($val = ('', 'n/a', 'NULL'))">
           <location> <geo corresp="neighbourhood">{$val}</geo> </location>
        </xsl:if>
    </xsl:template>
    
    <xsl:template name="foundationyear_hijri">
        <xsl:variable name="val" select="fn:cell(parent::t:table, xs:int(@n), fn:col(parent::t:table, 'anno hegirae'))"/>
        <xsl:if test="not($val = ('', 'n/a', 'NULL'))">
            <date datingMethod="#hijri">{$val}</date>       </xsl:if>
    </xsl:template>
    
    <xsl:template name="foundationyear">
        <xsl:variable name="val" select="fn:cell(parent::t:table, xs:int(@n), fn:col(parent::t:table, 'anno domini'))"/>
        <xsl:if test="not($val = ('', 'n/a', 'NULL'))">
            <note type="foundationdates">
                <date datingMethod="#gregorian">{$val}</date>
                <xsl:call-template name="foundationyear_hijri"/>
            </note>
            
        </xsl:if>
    </xsl:template>
    
   
    <xsl:template name="altname_GrandBeyMap">
        <xsl:variable name="val" select="fn:cell(parent::t:table, xs:int(@n), fn:col(parent::t:table, 'libellé-Plan-Grand-bey-1874'))"/>
        <xsl:if test="not($val = ('', 'n/a', 'NULL'))">
            <placeName type="GrandBeyMap">{$val}</placeName>
        </xsl:if>
    </xsl:template>
    
    <xsl:template name="altname_Fachinelli">
        <xsl:variable name="val" select="fn:cell(parent::t:table, xs:int(@n), fn:col(parent::t:table, 'libellé-Facchinelli'))"/>
        <xsl:if test="not($val = ('', 'n/a', 'NULL'))">
            <placeName type="Fachinelli">{$val}</placeName>
        </xsl:if>
    </xsl:template>
    
    
    <xsl:template name="URI_Fachinelli">
        <xsl:variable name="val" select="fn:cell(parent::t:table, xs:int(@n), fn:col(parent::t:table, 'URI Facchinelli'))"/>
        <xsl:if test="not($val = ('', 'n/a', 'NULL'))">
            <idno type="URI_Fachinelli">{$val}</idno>
        </xsl:if>
    </xsl:template>
    
<!--  I do not know why but it's not working either - it's already a ptr element and we should get the full element
        
    <xsl:template name="geonamesLink">
        <xsl:variable name="val" select="fn:cell(parent::t:table, xs:int(@n), fn:col(parent::t:table, 'alignement_GEO'))"/>
        <xsl:if test="not($val = ('', 'n/a', 'NULL'))">
            {$val}
        </xsl:if>
    </xsl:template> 
    
    -->
    
    <xsl:template name="notice_francais">
        <xsl:variable name="val" select="fn:cell(parent::t:table, xs:int(@n), fn:col(parent::t:table, 'Notice en français'))"/>
        <xsl:if test="not($val = ('', 'n/a', 'NULL'))">
            <note xml:lang="fr">{$val}</note>
        </xsl:if>
    </xsl:template>
    
    <xsl:template name="notice_anglais">
        <xsl:variable name="val" select="fn:cell(parent::t:table, xs:int(@n), fn:col(parent::t:table, 'Notices en anglais'))"/>
        <xsl:if test="not($val = ('', 'n/a', 'NULL'))">
            <note xml:lang="en">{$val}</note>
        </xsl:if>
    </xsl:template>
        
    <xsl:template name="notice_arabe">
        <xsl:variable name="val" select="fn:cell(parent::t:table, xs:int(@n), fn:col(parent::t:table, 'Notices en arabe'))"/>
        <xsl:if test="not($val = ('', 'n/a', 'NULL'))">
            <note xml:lang="ar">{$val}</note>
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