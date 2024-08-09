<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
    xmlns:owl="http://www.w3.org/2002/07/owl#" xmlns:dc="http://purl.org/dc/elements/1.1/"
    xmlns:skos="http://www.w3.org/2004/02/skos/core#"
    xmlns:bk="http://gams.uni-graz.at/rem/bookkeeping/" xmlns:t="http://www.tei-c.org/ns/1.0/"
    xmlns:void="http://rdfs.org/ns/void#" xmlns:dcterms="http://purl.org/dc/terms/"
    xmlns:g2o="http://gams.uni-graz.at/ontology/#"
    xmlns:ooa="http://gams.uni-graz.at/o:ooa.ontology/#"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs" version="2.0">

    <xsl:variable name="archive_entry" select="//ENTRY[1]/ARCHIVEENTRY"/>
    <xsl:variable name="archive_ref" select="//ENTRY[1]/ARCHIVEREF"/>
    <xsl:variable name="msRef"
        select="concat(replace($archive_ref, '/', ''), replace($archive_entry, '[a-z]', ''))"/>
    <xsl:template match="XML">
        <rdf:RDF xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
            xmlns:owl="http://www.w3.org/2002/07/owl#" xmlns:dc="http://purl.org/dc/elements/1.1/"
            xmlns:skos="http://www.w3.org/2004/02/skos/core#"
            xmlns:bk="http://gams.uni-graz.at/rem/bookkeeping/"
            xmlns:t="http://www.tei-c.org/ns/1.0/" xmlns:void="http://rdfs.org/ns/void#"
            xmlns:dcterms="http://purl.org/dc/terms/" xmlns:g2o="http://gams.uni-graz.at/ontology/#"
            xmlns:ooa="http://gams.uni-graz.at/o:ooa.ontology/#">
            <void:Dataset rdf:about="http://gams.uni-graz.at/o:ooa.{$archive_entry}">
                <dc:title>
                    <xsl:value-of select="concat($archive_ref, '/', $archive_entry)"/>
                </dc:title>
                <dc:relation>
                    <xsl:text>1723 Oaths of Allegiance - London</xsl:text>
                </dc:relation>
                <dc:relation>
                    <xsl:text>http://gams.uni-graz.at/ooa</xsl:text>
                </dc:relation>
                <dc:creator>
                    <xsl:text>Sonnberger, Jakob</xsl:text>
                </dc:creator>
                <dc:publisher>
                    <xsl:text>ZIM - Austrian Centre for Digital Humanities, University of Graz</xsl:text>
                </dc:publisher>
                <dc:contributor>
                    <xsl:text>Craven, Alex</xsl:text>
                </dc:contributor>
                <dc:date>
                    <xsl:text>2021</xsl:text>
                </dc:date>
                <dc:format>
                    <xsl:text>rdf+xml</xsl:text>
                </dc:format>
                <dc:identifier>
                    <xsl:value-of select="concat('o:ooa.', $archive_entry)"/>
                </dc:identifier>
                <dc:source>
                    <xsl:text>City of London Corporation, London Metropolitan Archives</xsl:text>
                </dc:source>
                <dc:language>
                    <xsl:text>en</xsl:text>
                </dc:language>
                <dc:coverage>
                    <xsl:text>United Kingdom</xsl:text>
                </dc:coverage>
                <dc:coverage>
                    <xsl:text>18th century</xsl:text>
                </dc:coverage>
                <dc:rights>
                    <xsl:text>Creative Commons BY 4.0</xsl:text>
                </dc:rights>
                <dc:rights>
                    <xsl:text>https://creativecommons.org/licenses/by/4.0</xsl:text>
                </dc:rights>
            </void:Dataset>
            <ooa:Oathroll rdf:about="http://gams.uni-graz.at/o:ooa.{$archive_entry}">
                <dc:title>
                    <xsl:value-of select="concat($archive_ref, '/', $archive_entry)"/>
                </dc:title>
                <dc:relation>
                    <xsl:text>1723 Oaths of Allegiance - London</xsl:text>
                </dc:relation>
                <dc:relation>
                    <xsl:text>http://gams.uni-graz.at/ooa</xsl:text>
                </dc:relation>
                <dc:creator>
                    <xsl:text>Sonnberger, Jakob</xsl:text>
                </dc:creator>
                <dc:publisher>
                    <xsl:text>ZIM - Austrian Centre for Digital Humanities, University of Graz</xsl:text>
                </dc:publisher>
                <dc:contributor>
                    <xsl:text>Craven, Alex</xsl:text>
                </dc:contributor>
                <dc:date>
                    <xsl:text>2021</xsl:text>
                </dc:date>
                <dc:format>
                    <xsl:text>rdf+xml</xsl:text>
                </dc:format>
                <dc:identifier>
                    <xsl:value-of select="concat('o:ooa.', $archive_entry)"/>
                </dc:identifier>
                <dc:source>
                    <xsl:text>City of London Corporation, London Metropolitan Archives</xsl:text>
                </dc:source>
                <dc:language>
                    <xsl:text>en</xsl:text>
                </dc:language>
                <dc:coverage>
                    <xsl:text>United Kingdom</xsl:text>
                </dc:coverage>
                <dc:coverage>
                    <xsl:text>18th century</xsl:text>
                </dc:coverage>
                <dc:rights>
                    <xsl:text>Creative Commons BY 4.0</xsl:text>
                </dc:rights>
                <dc:rights>
                    <xsl:text>https://creativecommons.org/licenses/by/4.0</xsl:text>
                </dc:rights>
                <t:msRef rdf:resource="http://gams.uni-graz.at/context:ooa/{$msRef}"/>
                <skos:prefLabel>
                    <xsl:value-of select="concat($archive_ref, '/', $archive_entry)"/>
                </skos:prefLabel>
            </ooa:Oathroll>
            <xsl:apply-templates select="HEAD"/>
            <xsl:apply-templates select="ENTRY"/>
        </rdf:RDF>
    </xsl:template>
    <xsl:template match="HEAD">
        <ooa:ExtranuousDataTo
            rdf:about="http://gams.uni-graz.at/o:ooa.{$archive_entry}#ex_{count(preceding::HEAD)+1}">
            <bk:isPartOf rdf:resource="http://gams.uni-graz.at/o:ooa.{$archive_entry}"/>
            <t:p>
                <xsl:value-of select="."/>
            </t:p>
        </ooa:ExtranuousDataTo>
    </xsl:template>
    <xsl:template match="ENTRY">
        <ooa:OathRollEntry
            rdf:about="http://gams.uni-graz.at/o:ooa.{concat($archive_entry, '#e_', ORDER)}">
            <bk:isPartOf rdf:resource="http://gams.uni-graz.at/o:ooa.{$archive_entry}"/>
            <g2o:sequence rdf:datatype="http://www.w3.org/2001/XMLSchema#integer">
                <xsl:value-of select="ORDER"/>
            </g2o:sequence>
            <g2o:text>
                <xsl:value-of
                    select="SURNAME | FORENAME | ADDRESS | PARISH | STATUS | RELIGION | MARGIN | NOTES"
                />
            </g2o:text>
            <xsl:apply-templates select="MARGIN | DEL | NOTES"/>
            <ooa:documents>
                <ooa:OathSwearing
                    rdf:about="http://gams.uni-graz.at/o:ooa.{concat($archive_entry, '#s_', ORDER)}">
                    <bk:when>
                        <xsl:value-of select="DATE"/>
                    </bk:when>
                    <ooa:by>
                        <ooa:OathSwearer
                            rdf:about="http://gams.uni-graz.at/o:ooa.{concat($archive_entry, '#p_', ORDER)}">
                            <t:persName>
                                <xsl:value-of select="SURNAME | FORENAME"/>
                            </t:persName>
                            <xsl:apply-templates
                                select="SURNAME | FORENAME | ADDRESS | PARISH | STATUS | OCCUPATION | SEX | RELIGION"
                            />
                        </ooa:OathSwearer>
                    </ooa:by>
                </ooa:OathSwearing>
            </ooa:documents>
        </ooa:OathRollEntry>
    </xsl:template>
    <xsl:template match="SURNAME">
        <t:surname>
            <xsl:value-of select="normalize-space(.)"/>
        </t:surname>
    </xsl:template>
    <xsl:template match="FORENAME">
        <t:forename>
            <xsl:value-of select="normalize-space(.)"/>
        </t:forename>
    </xsl:template>
    <xsl:template match="ADDRESS">
        <ooa:isLocatedIn>
            <xsl:value-of select="normalize-space(.)"/>
        </ooa:isLocatedIn>
    </xsl:template>
    <xsl:template match="PARISH">
        <ooa:isLocatedInParish>
            <xsl:value-of select="normalize-space(.)"/>
        </ooa:isLocatedInParish>
    </xsl:template>
    <xsl:template match="STATUS">
        <t:socecStatus>
            <xsl:value-of select="normalize-space(.)"/>
        </t:socecStatus>
    </xsl:template>
    <xsl:template match="OCCUPATION">
        <ooa:occupation
            rdf:resource="http://gams.uni-graz.at/o:ooa.occupations-ontology#{replace(normalize-space(.), ' ', '_')}"
        />
    </xsl:template>
    <xsl:template match="SEX">
        <t:sex>
            <xsl:value-of select="normalize-space(.)"/>
        </t:sex>
    </xsl:template>
    <xsl:template match="RELIGION">
        <t:faith>
            <xsl:value-of select="normalize-space(.)"/>
        </t:faith>
    </xsl:template>
    <xsl:template match="MARGIN">
        <t:add>
            <xsl:value-of select="normalize-space(.)"/>
        </t:add>
    </xsl:template>
    <xsl:template match="DEL">
        <t:del>
            <xsl:value-of select="normalize-space(.)"/>
        </t:del>
    </xsl:template>
    <xsl:template match="NOTES">
        <t:note>
            <xsl:value-of select="normalize-space(.)"/>
        </t:note>
    </xsl:template>

</xsl:stylesheet>
