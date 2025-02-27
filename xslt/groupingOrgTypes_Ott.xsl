<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:t="http://www.tei-c.org/ns/1.0"
    xmlns="http://www.tei-c.org/ns/1.0" exclude-result-prefixes="xs" version="3.0"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0">
    <xsl:output indent="yes"/>
    
    
    <!-- Root template -->
    <xsl:template match="/" name="xsl:initial-template">
        <!-- make the articles folder into a variable, it selectes all xml files in the same folder, consider only the ones with the cleared status -->
        <xsl:variable name="articlesOta" select="collection('../articles/ottoman?select=*.xml')[TEI/teiHeader/revisionDesc[@status='cleared']]"/>
        
        <!-- to add Ottoman files 
        <xsl:variable name="articlesOtt" select="collection('../articles/ottoman?select=*.xml')[TEI/teiHeader/revisionDesc[@status='cleared']]"/> 
        
        <xsl:variable name="articles" select="$articlesAr | $articlesOtt"/>
       
       -->
        
        <TEI>
            <teiHeader>
                <fileDesc>
                    <titleStmt>
                        <title>Orgname Types in the Dataset - "Urbanism News In The Official Egyptian Gazette (al-Waqāʾiʿ
                            al-Miṣrīyah), 1828-1914 - An Ottoman Arabic Digital Humanities
                            Project"</title>
                        <editor xml:id="eHC" ref="https://orcid.org/0000-0003-0060-9396">Hugh
                            Cayless</editor>
                        <editor xml:id="eNK" ref="https://orcid.org/0009-0008-0409-7328">Nour
                            Kanaan</editor>
                        <editor xml:id="eAM" ref="https://orcid.org/0000-0002-5945-6147">Adam
                            Mestyan</editor>
                        <editor xml:id="eDY">Danah Younis</editor>
                        <editor xml:id="eSG" ref="https://orcid.org/0000-0002-1977-5530">Sarah
                            Fathallah Gaara</editor>
                        <editor xml:id="eAE" ref="https://orcid.org/0000-0001-9369-3034">Arif
                            Erbil</editor>
                        <editor xml:id="eAK" ref="https://orcid.org/0000-0003-1721-1050">Ahmed
                            Kamal</editor>
                        <editor xml:id="eAS" ref="https://orcid.org/0009-0004-9778-6632">Abram
                            Smith</editor>
                        <editor xml:id="eCH">Clara Harms</editor>
                        <editor xml:id="eHS" ref="https://orcid.org/0000-0003-3003-1986">Hüseyin
                            Sağlam</editor>
                        <editor xml:id="eAT" ref="https://orcid.org/0009-0002-2083-9199">Abdulrahman
                            El-Taliawi</editor>
                        <editor xml:id="eHL">Hiba Laabadli</editor>
                        <editor xml:id="eOE" ref="https://orcid.org/0009-0002-9543-2617">Othmane
                            Echchabi</editor>
                        <editor xml:id="eFA">Fatemah Almahana</editor>
                        <editor xml:id="eMZ">Mahmoud Zaki</editor>
                        <editor xml:id="eNS" ref="https://orcid.org/0009-0006-8785-0228">Nehal
                            al-Shamy</editor>
                        <editor xml:id="eVJ" ref="https://orcid.org/0009-0004-4472-4120">Vishal
                            Jammulapati</editor>
                        <respStmt>
                            <resp>Project co-director</resp>
                            <name>Hugh Cayless</name>
                        </respStmt>
                        <respStmt>
                            <resp>Primary Investigator</resp>
                            <name>Adam Mestyan</name>
                        </respStmt>
                        <respStmt>
                            <resp ref="https://orcid.org/0000-0001-5239-7909">Project
                                co-director</resp>
                            <name>Mercedes Volait</name>
                        </respStmt>
                        <respStmt>
                            <resp>Research Assistant</resp>
                            <name>Sarah Fathallah Gaara</name>
                        </respStmt>
                        <respStmt>
                            <resp ref="https://orcid.org/0000-0003-1216-3686">Research
                                Assistant</resp>
                            <name>Karima Nasr</name>
                        </respStmt>
                        <respStmt>
                            <resp>Research Assistant</resp>
                            <name>Rezk Nori</name>
                        </respStmt>
                        <respStmt>
                            <resp>Research Assistant</resp>
                            <name>Arif Erbil</name>
                        </respStmt>
                        <respStmt>
                            <resp>Research Assistant</resp>
                            <name>Ahmed Kamal</name>
                        </respStmt>
                        <respStmt>
                            <resp>Research Assistant</resp>
                            <name>Abram Smith</name>
                        </respStmt>
                        <respStmt>
                            <resp>Research Assistant</resp>
                            <name>Clara Harms</name>
                        </respStmt>
                        <respStmt>
                            <resp>Research Assistant</resp>
                            <name>Hüseyin Sağlam</name>
                        </respStmt>
                        <respStmt>
                            <resp>Research Assistant</resp>
                            <name>Abdulrahman El-Taliawi</name>
                        </respStmt>
                        <respStmt>
                            <resp>Research Assistant</resp>
                            <name>Hiba Laabadli</name>
                        </respStmt>
                        <respStmt>
                            <resp>Research Assistant</resp>
                            <name>Othmane Echchabi</name>
                        </respStmt>
                        <respStmt>
                            <resp>Research Assistant</resp>
                            <name>Fatemah Almahana</name>
                        </respStmt>
                        <respStmt>
                            <resp>Research Assistant</resp>
                            <name>Mahmoud Zaki</name>
                        </respStmt>
                        <respStmt>
                            <resp>Research Assistant</resp>
                            <name>Nehal al-Shamy</name>
                        </respStmt>
                        <respStmt>
                            <resp>Research Assistant</resp>
                            <name>Vishal Jammulapati</name>
                        </respStmt>
                        <sponsor>
                            <orgName>National Endowment for the Humanities</orgName>,
                            <orgName>Institut français d’archéologie orientale</orgName> (Ifao,
                            Cairo); <orgName>Franklin Humanities Institute and the Office of Global
                                Affairs / Andrew W. Mellon Endowment for Global Studies, Duke
                                University</orgName>; <orgName>Duke University Libraries</orgName>;
                            <orgName>Centre national de la recherche scientifique</orgName>;
                            <orgName>the Office of the Hungarian Cultural Counsellor in
                                Cairo</orgName>.</sponsor>
                    </titleStmt>
                    <publicationStmt>
                        <p>"A TEI Edition of Urbanism News in al-Waqāʾiʿ al-Miṣrīyah, 1828-1914"</p>
                        <p> Created by the "Digital Cairo" project (Duke University - Ifao),
                            sponsored by the National Endowment for the Humanities.</p>
                        <p>
                            <ref target="https://sites.duke.edu/cairemoderne/">Website</ref>
                        </p>
                        <p>Project directors: <persName>Adam Mestyan</persName>, <persName>Mercedes
                            Volait</persName>, <persName>Hugh Cayless</persName></p>
                    </publicationStmt>
                    <sourceDesc>
                        <p>Al-Waqāʾiʿ al-Miṣrīyah (Egyptian Affairs) newspaper, 1828–1914.</p>
                        <p>born digital document</p>
                    </sourceDesc>
                </fileDesc>
                <encodingDesc>
                    <projectDesc>
                        <p>This is a file in the "XMl TEI Edition of Urbanism News in al-Waqāʾiʿ
                            al-Miṣrīyah" in the project "La fabrique du Caire moderne, 2018-2021"
                            (Ifao-InVisu-Duke University).</p>
                        <p>The "Digital Cairo" project is sponsored by the National Endowment for
                            the Humanities.</p>
                    </projectDesc>
                    <editorialDecl>
                        <p>Rules of TEI XML MarkUp in This Project</p>
                        <p>We use the Arabic script but transliteration into Latin characters
                            follows the Library of Congress (LOC) <ref
                                target="https://www.loc.gov/catdir/cpso/romanization/arabic.pdf"
                                >Arabic transliteration chart</ref>.</p>
                        <p>Each individual article has an individual xml:id number starting with
                            "w1"</p>
                        <p>We only use persName, orgName, placeName elements, apart from
                            bibliographical elements and notes.</p>
                        <p>If the location or organization of responsibility is known from the text,
                            it can be added in an attribute to a persName.</p>
                        <p>"Mashaykhah" and "thumn" are orgNames and placeNames.</p>
                        <p>This project's schema considers Till Grallert's work in his <ref
                            target="https://github.com/OpenArabicPE/OpenArabicPE_ODD">Open
                            Arabic Periodical Editions</ref>.</p>
                    </editorialDecl>
                </encodingDesc>
            </teiHeader>
            
            <text xml:lang="ota" resp="#eAM">
                <body>
                    
                    <list>
                        <!-- Extract unique type attributes, sort them alphabetically, replace hyphens in role attribute values with spaces  -->
                        <xsl:for-each-group select="$articlesOta//orgName[@type]" group-by="@type">
                            
                            <xsl:sort select="translate(current-grouping-key(), '-', ' ')"
                                collation="http://www.w3.org/2013/collation/UCA/ar"/>
                            
                            <xsl:variable name="currentType" select="current-grouping-key()"/>
                            
                            <!-- create item elements with a unique id -->
                            <item xml:lang="ota" xml:id="{concat('orgType_', generate-id())}">
                                <!-- Replace hyphens in role attribute values with spaces -->
                                <xsl:value-of
                                    select="translate(current-grouping-key(), '-', ' ')"/>
                                
                                
                                <!-- Find and list the contents of date elements with when-custom -->
                                
                                <note>
                                    <xsl:for-each select="$articlesOta//div[.//orgName[@type = current-grouping-key()]]/date[@when-custom]">
                                        <date when-custom="{@when-custom}">
                                            <xsl:value-of select="."/>
                                            
                                            <!-- Extract xml:id from the parent div and add it in an idno element -->
                                            <xsl:variable name="parentDiv" select="ancestor::div[@xml:id][1]"/>
                                            <xsl:if test="$parentDiv">
                                                <idno source="div">
                                                    <xsl:value-of select="$parentDiv/@xml:id"/>
                                                </idno>
                                            </xsl:if>
                                            
                                            
                                            
                                        </date>
                                    </xsl:for-each>
                                    
                                    <xsl:for-each select="$articlesOta//div[.//orgName[@type = current-grouping-key()]]/head/date[@when-custom]">
                                        <date when-custom="{@when-custom}">
                                            <xsl:value-of select="."/>
                                            
                                            <!-- Extract xml:id from the parent div and add it in an idno element -->
                                            <xsl:variable name="parentDiv" select="ancestor::div[@xml:id][1]"/>
                                            <xsl:if test="$parentDiv">
                                                <idno source="div">
                                                    <xsl:value-of select="$parentDiv/@xml:id"/>
                                                </idno>
                                            </xsl:if>
                                            
                                            
                                            
                                        </date>
                                    </xsl:for-each>
                                </note>
                                
                                
                            </item>
                            
                        </xsl:for-each-group>
                    </list>
                    
                </body>
            </text>
        </TEI>
    </xsl:template>
</xsl:stylesheet>
