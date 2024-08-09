<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
    xmlns:owl="http://www.w3.org/2002/07/owl#" xmlns:dc="http://purl.org/dc/elements/1.1/"
    xmlns:skos="http://www.w3.org/2004/02/skos/core#"
    xmlns:bk="http://gams.uni-graz.at/rem/bookkeeping/" xmlns:t="http://www.tei-c.org/ns/1.0/"
    xmlns:void="http://rdfs.org/ns/void#" xmlns:dcterms="http://purl.org/dc/terms/"
    xmlns:g2o="http://gams.uni-graz.at/ontology/#"
    xmlns:ooa="http://gams.uni-graz.at/o:ooa.ontology/#"
    xmlns:occ="http://gams.uni-graz.at/o:ooa.occupations-ontology#"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs" version="2.0">
    <xsl:output method="xml" indent="yes"/>

    <!--    <HISCO_Unit_Nr>01210</HISCO_Unit_Nr>
    <HISCO_Unit_Name>Physicist, General</HISCO_Unit_Name>
    <HISCO_Unit_group_Nr>012</HISCO_Unit_group_Nr>
    <HISCO_Unit_group_Name>Physicists</HISCO_Unit_group_Name>
    <HISCO_Minor_group_Nr>01</HISCO_Minor_group_Nr>
    <HISCO_Minor_group_Name>Physical Scientists and Related
        Technicians</HISCO_Minor_group_Name>
    <HISCO_Major_group_Nr>0</HISCO_Major_group_Nr>
    <HISCO_Major_group_Name>Professional, technical and related
        workers</HISCO_Major_group_Name>
    <OOA_Occupation>Doctor of Physics</OOA_Occupation>-->

    <xsl:template match="XML">
        <rdf:RDF>
            <void:Dataset rdf:about="http://gams.uni-graz.at/o:ooa.occupations-ontology">
                <dc:title>Oaths Of Allegiance - Occupations Ontology</dc:title>
                <dc:relation>1723 Oaths of Allegiance - London</dc:relation>
                <dc:relation>http://gams.uni-graz.at/ooa</dc:relation>
                <dc:creator>Sonnberger, Jakob</dc:creator>
                <dc:publisher>ZIM - Austrian Centre for Digital Humanities, University of Graz</dc:publisher>
                <dc:date>2021</dc:date>
                <dc:format>rdf+xml</dc:format>
                <dc:identifier>o:ooa.occupations-ontology</dc:identifier>
                <dc:language>en</dc:language>
                <dc:rights>Creative Commons BY 4.0</dc:rights>
                <dc:rights>https://creativecommons.org/licenses/by/4.0</dc:rights>
            </void:Dataset>

            <xsl:for-each select="//OOA_Occupation">
                <xsl:variable name="broader"
                    select="concat('http://gams.uni-graz.at/o:ooa.occupations-ontology#', preceding-sibling::HISCO_Unit_Nr)"/>
                <xsl:for-each select="tokenize(., ';')">
                    <occ:OOA_Occupation
                        rdf:about="http://gams.uni-graz.at/o:ooa.occupations-ontology#{replace(normalize-space(.), ' ', '_')}">
                        <skos:prefLabel>
                            <xsl:value-of select="normalize-space(.)"/>
                        </skos:prefLabel>
                        <skos:broader rdf:resource="{$broader}"/>
                    </occ:OOA_Occupation>
                </xsl:for-each>
            </xsl:for-each>

            <xsl:for-each select="//HISCO_Unit_Nr">
                <occ:HISCO_Unit rdf:about="http://gams.uni-graz.at/o:ooa.occupations-ontology#{.}">
                    <skos:prefLabel>
                        <xsl:value-of select="normalize-space(following-sibling::HISCO_Unit_Name)"/>
                    </skos:prefLabel>
                    <skos:broader
                        rdf:resource="http://gams.uni-graz.at/o:ooa.occupations-ontology#{following-sibling::HISCO_Unit_group_Nr}"
                    />
                </occ:HISCO_Unit>
            </xsl:for-each>

            <xsl:for-each-group select="entry" group-by="HISCO_Unit_group_Nr">
                <occ:HISCO_Unit_group
                    rdf:about="http://gams.uni-graz.at/o:ooa.occupations-ontology#{current-grouping-key()}">
                    <skos:prefLabel>
                        <xsl:value-of select="normalize-space(HISCO_Unit_group_Name[1])"/>
                    </skos:prefLabel>
                    <skos:broader
                        rdf:resource="http://gams.uni-graz.at/o:ooa.occupations-ontology#{HISCO_Minor_group_Nr[1]}"
                    />
                </occ:HISCO_Unit_group>
            </xsl:for-each-group>

            <xsl:for-each-group select="entry" group-by="HISCO_Minor_group_Nr">
                <rdf:Description
                    rdf:about="http://gams.uni-graz.at/o:ooa.occupations-ontology#{current-grouping-key()}">
                    <rdf:type
                        rdf:resource="http://gams.uni-graz.at/o:ooa.occupations-ontology#HISCO_Minor_group"/>
                    <skos:prefLabel>
                        <xsl:value-of select="normalize-space(HISCO_Minor_group_Name[1])"/>
                    </skos:prefLabel>
                    <skos:broader
                        rdf:resource="http://gams.uni-graz.at/o:ooa.occupations-ontology#{HISCO_Major_group_Nr[1]}"
                    />
                </rdf:Description>
            </xsl:for-each-group>

            <xsl:for-each-group select="entry" group-by="HISCO_Major_group_Nr">
                <occ:HISCO_Major_group
                    rdf:about="http://gams.uni-graz.at/o:ooa.occupations-ontology#{current-grouping-key()}">
                    <skos:prefLabel>
                        <xsl:value-of select="normalize-space(HISCO_Major_group_Name[1])"/>
                    </skos:prefLabel>
                </occ:HISCO_Major_group>
            </xsl:for-each-group>

        </rdf:RDF>
    </xsl:template>

</xsl:stylesheet>
