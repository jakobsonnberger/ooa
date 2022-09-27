<?xml version="1.0" encoding="UTF-8"?>
<!-- 
    Project: Oath Of Allegiance
    Author: Jakob Sonnberger
    Company: ZIM-ACDH (Zentrum für Informationsmodellierung - Austrian Centre for Digital Humanities)
    /////////////////////////////////////////////////////////////////////////////////////////////////
    Stylesheet Information: Exporting queried document to Spreadsheet
 -->
<xsl:stylesheet xmlns:gmr="http://www.gnome.org/gnumeric/v7"
    xmlns:s="http://www.w3.org/2001/sw/DataAccess/rf1/result" xmlns:t="http://www.tei-c.org/ns/1.0"
    xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl" xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:bk="http://gams.uni-graz.at/rem/bookkeeping/" xmlns:dc="http://purl.org/dc/elements/1.1/"
    xmlns:dcterms="http://purl.org/dc/terms/"
    xmlns:f="info:fedora/fedora-system:def/relations-external#"
    xmlns:g2o="http://gams.uni-graz.at/ontology/#" xmlns:owl="http://www.w3.org/2002/07/owl#"
    xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
    xmlns:skos="http://www.w3.org/2004/02/skos/core#"
    xmlns:ooa="http://gams.uni-graz.at/o:ooa.ontology/#" xmlns:void="http://rdfs.org/ns/void#"
    exclude-result-prefixes="xs" version="2.0">

    <xsl:output encoding="UTF-8" indent="yes" method="xml"/>

    <!--defining table style, creating table head-->
    <xsl:template match="/">
        <gmr:Workbook>
            <gmr:Sheets>
                <gmr:Sheet>
                    <gmr:Name>records</gmr:Name>
                    <gmr:MaxCol>10</gmr:MaxCol>
                    <gmr:MaxRow>10000</gmr:MaxRow>
                    <gmr:PrintInformation>
                        <gmr:Cols DefaultSizePts="100">
                            <!--order-->
                            <gmr:ColInfo No="0" Unit="50"/>
                            <!--date-->
                            <gmr:ColInfo No="1" Unit="100"/>
                            <!--surname-->
                            <gmr:ColInfo No="2" Unit="100"/>
                            <!--name-->
                            <gmr:ColInfo No="3" Unit="100"/>
                            <!--address-->
                            <gmr:ColInfo No="4" Unit="200"/>
                            <!--parish-->
                            <gmr:ColInfo No="5" Unit="200"/>
                            <!--status-->
                            <gmr:ColInfo No="6" Unit="200"/>
                            <!--gender-->
                            <gmr:ColInfo No="7" Unit="50"/>
                            <!--religion-->
                            <gmr:ColInfo No="8" Unit="100"/>
                            <!--marginalia-->
                            <gmr:ColInfo No="9" Unit="100"/>
                            <!--del.-->
                            <gmr:ColInfo No="10" Unit="50"/>
                            <!--note-->
                            <gmr:ColInfo No="11" Unit="200"/>
                        </gmr:Cols>
                    </gmr:PrintInformation>
                    <gmr:Cells>
                        <gmr:Cell Col="0" Row="0" ValueType="60">
                            <gmr:Content>
                                <xsl:text>order</xsl:text>
                            </gmr:Content>
                        </gmr:Cell>
                        <gmr:Cell Col="1" Row="0" ValueType="60">
                            <gmr:Content>
                                <xsl:text>date</xsl:text>
                            </gmr:Content>
                        </gmr:Cell>
                        <gmr:Cell Col="2" Row="0" ValueType="60">
                            <gmr:Content>
                                <xsl:text>surname</xsl:text>
                            </gmr:Content>
                        </gmr:Cell>
                        <gmr:Cell Col="3" Row="0" ValueType="60">
                            <gmr:Content>
                                <xsl:text>name</xsl:text>
                            </gmr:Content>
                        </gmr:Cell>
                        <gmr:Cell Col="4" Row="0" ValueType="60">
                            <gmr:Content>
                                <xsl:text>address</xsl:text>
                            </gmr:Content>
                        </gmr:Cell>
                        <gmr:Cell Col="5" Row="0" ValueType="60">
                            <gmr:Content>
                                <xsl:text>parish</xsl:text>
                            </gmr:Content>
                        </gmr:Cell>
                        <gmr:Cell Col="6" Row="0" ValueType="60">
                            <gmr:Content>
                                <xsl:text>status</xsl:text>
                            </gmr:Content>
                        </gmr:Cell>
                        <gmr:Cell Col="7" Row="0" ValueType="60">
                            <gmr:Content>
                                <xsl:text>gender</xsl:text>
                            </gmr:Content>
                        </gmr:Cell>
                        <gmr:Cell Col="8" Row="0" ValueType="60">
                            <gmr:Content>
                                <xsl:text>religion</xsl:text>
                            </gmr:Content>
                        </gmr:Cell>
                        <gmr:Cell Col="9" Row="0" ValueType="60">
                            <gmr:Content>
                                <xsl:text>marginalia</xsl:text>
                            </gmr:Content>
                        </gmr:Cell>
                        <gmr:Cell Col="10" Row="0" ValueType="60">
                            <gmr:Content>
                                <xsl:text>del.</xsl:text>
                            </gmr:Content>
                        </gmr:Cell>
                        <gmr:Cell Col="11" Row="0" ValueType="60">
                            <gmr:Content>
                                <xsl:text>note</xsl:text>
                            </gmr:Content>
                        </gmr:Cell>

                        <xsl:apply-templates
                            select="//s:result[s:type/@uri = 'http://gams.uni-graz.at/o:ooa.ontology/#OathRollEntry']"/>

                    </gmr:Cells>
                </gmr:Sheet>
            </gmr:Sheets>
        </gmr:Workbook>
    </xsl:template>

    <!--template for entries-->
    <xsl:template
        match="//s:result[s:type/@uri = 'http://gams.uni-graz.at/o:ooa.ontology/#OathRollEntry']">
        <xsl:variable name="row">
            <xsl:number
                count="//s:result[s:type/@uri = 'http://gams.uni-graz.at/o:ooa.ontology/#OathRollEntry']"
            />
        </xsl:variable>

        <!-- Col.0: order -->
        <gmr:Cell Col="0" Row="{$row}" ValueType="60">
            <xsl:choose>
                <!--   ValueType MUST BE 10 if Cells are empty!!! -->
                <xsl:when test="s:order">
                    <xsl:attribute name="ValueType" select="60"/>
                    <gmr:Content>
                        <xsl:value-of select="s:order"/>
                    </gmr:Content>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:attribute name="ValueType" select="10"/>
                </xsl:otherwise>
            </xsl:choose>
        </gmr:Cell>

        <!-- Col.1: date -->
        <gmr:Cell Col="1" Row="{$row}" ValueType="60">
            <xsl:choose>
                <xsl:when test="s:date">
                    <xsl:attribute name="ValueType" select="60"/>
                    <gmr:Content>
                        <xsl:value-of select="s:date"/>
                    </gmr:Content>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:attribute name="ValueType" select="10"/>
                </xsl:otherwise>
            </xsl:choose>
        </gmr:Cell>

        <!-- Col.2: surname -->
        <gmr:Cell Col="2" Row="{$row}" ValueType="60">
            <xsl:choose>
                <xsl:when test="s:surname">
                    <xsl:attribute name="ValueType" select="60"/>
                    <gmr:Content>
                        <xsl:value-of select="s:surname"/>
                    </gmr:Content>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:attribute name="ValueType" select="10"/>
                </xsl:otherwise>
            </xsl:choose>
        </gmr:Cell>

        <!-- Col.3: name -->
        <gmr:Cell Col="3" Row="{$row}" ValueType="60">
            <xsl:choose>
                <xsl:when test="s:forename">
                    <xsl:attribute name="ValueType" select="60"/>
                    <gmr:Content>
                        <xsl:value-of select="s:forename"/>
                    </gmr:Content>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:attribute name="ValueType" select="10"/>
                </xsl:otherwise>
            </xsl:choose>
        </gmr:Cell>

        <!-- Col.4: address -->
        <gmr:Cell Col="4" Row="{$row}" ValueType="60">
            <xsl:choose>
                <xsl:when test="s:address">
                    <xsl:attribute name="ValueType" select="60"/>
                    <gmr:Content>
                        <xsl:value-of select="s:address"/>
                    </gmr:Content>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:attribute name="ValueType" select="10"/>
                </xsl:otherwise>
            </xsl:choose>
        </gmr:Cell>

        <!-- Col.5: parish -->
        <gmr:Cell Col="5" Row="{$row}" ValueType="60">
            <xsl:choose>
                <xsl:when test="s:parish">
                    <xsl:attribute name="ValueType" select="60"/>
                    <gmr:Content>
                        <xsl:value-of select="s:parish"/>
                    </gmr:Content>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:attribute name="ValueType" select="10"/>
                </xsl:otherwise>
            </xsl:choose>
        </gmr:Cell>

        <!-- Col.6: status -->
        <gmr:Cell Col="6" Row="{$row}" ValueType="60">
            <xsl:choose>
                <xsl:when test="s:status">
                    <xsl:attribute name="ValueType" select="60"/>
                    <gmr:Content>
                        <xsl:value-of select="s:status"/>
                    </gmr:Content>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:attribute name="ValueType" select="10"/>
                </xsl:otherwise>
            </xsl:choose>
        </gmr:Cell>

        <!-- Col.7: gender -->
        <gmr:Cell Col="7" Row="{$row}" ValueType="60">
            <xsl:choose>
                <xsl:when test="s:sex">
                    <xsl:attribute name="ValueType" select="60"/>
                    <gmr:Content>
                        <xsl:value-of select="s:sex"/>
                    </gmr:Content>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:attribute name="ValueType" select="10"/>
                </xsl:otherwise>
            </xsl:choose>
        </gmr:Cell>

        <!-- Col.8: religion -->
        <gmr:Cell Col="8" Row="{$row}" ValueType="60">
            <xsl:choose>
                <xsl:when test="s:religion">
                    <xsl:attribute name="ValueType" select="60"/>
                    <gmr:Content>
                        <xsl:value-of select="s:religion"/>
                    </gmr:Content>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:attribute name="ValueType" select="10"/>
                </xsl:otherwise>
            </xsl:choose>
        </gmr:Cell>

        <!-- Col.9: marginalia -->
        <gmr:Cell Col="9" Row="{$row}" ValueType="60">
            <xsl:choose>
                <xsl:when test="s:margin">
                    <xsl:attribute name="ValueType" select="60"/>
                    <gmr:Content>
                        <xsl:value-of select="s:margin"/>
                    </gmr:Content>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:attribute name="ValueType" select="10"/>
                </xsl:otherwise>
            </xsl:choose>
        </gmr:Cell>

        <!-- Col.10: del. -->
        <gmr:Cell Col="10" Row="{$row}" ValueType="60">
            <xsl:choose>
                <xsl:when test="s:del">
                    <xsl:attribute name="ValueType" select="60"/>
                    <gmr:Content>
                        <xsl:value-of select="s:del"/>
                    </gmr:Content>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:attribute name="ValueType" select="10"/>
                </xsl:otherwise>
            </xsl:choose>
        </gmr:Cell>

        <!-- Col.11: note -->
        <gmr:Cell Col="11" Row="{$row}" ValueType="60">
            <xsl:choose>
                <xsl:when test="s:note">
                    <xsl:attribute name="ValueType" select="60"/>
                    <gmr:Content>
                        <xsl:value-of select="s:note"/>
                    </gmr:Content>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:attribute name="ValueType" select="10"/>
                </xsl:otherwise>
            </xsl:choose>
        </gmr:Cell>
    </xsl:template>


</xsl:stylesheet>
