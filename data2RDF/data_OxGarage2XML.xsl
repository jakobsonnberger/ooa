<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs" version="2.0">

    <xsl:template match="XML">
        <!--
    <1>REF
    <2>SHEET (added)
    <3>DATE
    <4>SURNAME
    <5>FORENAME
    <6>ADDRESS
    <7>PARISH
    <8>STATUS
    <9>SEX
    <10>RELIGION
    <11>MARGIN
    <12>DELETED
    <13>NOTES
    <14>ORDER
    -->
        <XML>
            <xsl:apply-templates/>
        </XML>
    </xsl:template>

    <xsl:template match="head">
        <HEAD>
            <xsl:value-of select="normalize-space(.)"/>
        </HEAD>
    </xsl:template>

    <xsl:template match="row">
        <ENTRY>
            <xsl:apply-templates/>
        </ENTRY>
    </xsl:template>

    <xsl:template match="row/cell[1]">
        <ARCHIVEREF>
            <xsl:apply-templates/>
        </ARCHIVEREF>
    </xsl:template>

    <xsl:template match="row/cell[2]">
        <ARCHIVEENTRY>
            <xsl:value-of select="normalize-space(.)"/>
        </ARCHIVEENTRY>
    </xsl:template>

    <xsl:template match="row/cell[3]">
        <DATE>
            <xsl:value-of select="normalize-space(.)"/>
        </DATE>
    </xsl:template>

    <xsl:template match="row/cell[4]">
        <xsl:if test="text() != ''">
            <SURNAME>
                <xsl:value-of select="normalize-space(.)"/>
            </SURNAME>
        </xsl:if>
    </xsl:template>

    <xsl:template match="row/cell[5]">
        <xsl:if test="text() != ''">
            <FORENAME>
                <xsl:value-of select="normalize-space(.)"/>
            </FORENAME>
        </xsl:if>
    </xsl:template>

    <xsl:template match="row/cell[6]">
        <xsl:if test="text() != ''">
            <ADDRESS>
                <xsl:value-of select="normalize-space(.)"/>
            </ADDRESS>
        </xsl:if>
    </xsl:template>

    <xsl:template match="row/cell[7]">
        <xsl:if test="text() != ''">
            <PARISH>
                <xsl:value-of select="normalize-space(.)"/>
            </PARISH>
        </xsl:if>
    </xsl:template>

    <xsl:template match="row/cell[8]">
        <xsl:if test="text() != ''">
            <STATUS>
                <xsl:value-of select="normalize-space(.)"/>
            </STATUS>
        </xsl:if>
    </xsl:template>
    <xsl:template match="row/cell[9]">
        <xsl:if test="text() != ''">
            <OCCUPATION>
                <xsl:value-of select="normalize-space(.)"/>
            </OCCUPATION>
        </xsl:if>
    </xsl:template>
    <xsl:template match="row/cell[10]">
        <xsl:if test="text() != ''">
            <SEX>
                <xsl:value-of select="normalize-space(.)"/>
            </SEX>
        </xsl:if>
    </xsl:template>

    <xsl:template match="row/cell[11]">
        <xsl:if test="text() != ''">
            <RELIGION>
                <xsl:value-of select="normalize-space(.)"/>
            </RELIGION>
        </xsl:if>
    </xsl:template>

    <xsl:template match="row/cell[12]">
        <xsl:if test="text() != ''">
            <MARGIN>
                <xsl:value-of select="normalize-space(.)"/>
            </MARGIN>
        </xsl:if>
    </xsl:template>

    <xsl:template match="row/cell[13]">
        <xsl:if test="text() != ''">
            <DEL>
                <xsl:value-of select="normalize-space(.)"/>
            </DEL>
        </xsl:if>
    </xsl:template>

    <xsl:template match="row/cell[14]">
        <xsl:if test="text() != ''">
            <NOTES>
                <xsl:value-of select="normalize-space(.)"/>
            </NOTES>
        </xsl:if>
    </xsl:template>

    <xsl:template match="row/cell[15]">
        <ORDER>
            <xsl:value-of select="normalize-space(.)"/>
        </ORDER>
    </xsl:template>

</xsl:stylesheet>
