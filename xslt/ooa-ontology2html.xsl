<?xml version="1.0" encoding="UTF-8"?>
<!--
    Project: Oath of Allegiance
    Author: Jakob Sonnberger
    Company: ZIM-ACDH (Zentrum für Informationsmodellierung - Austrian Centre for Digital Humanities)
    /////////////////////////////////////////////////////////////////////////////////////////////////
    Stylesheet Information: HTML representation of Ontology Objects
 -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
    xmlns:owl="http://www.w3.org/2002/07/owl#" xmlns:dc="http://purl.org/dc/elements/1.1/"
    xmlns:skos="http://www.w3.org/2004/02/skos/core#"
    xmlns:bk="http://gams.uni-graz.at/rem/bookkeeping/" xmlns:t="http://www.tei-c.org/ns/1.0/"
    xmlns:void="http://rdfs.org/ns/void#" xmlns:dcterms="http://purl.org/dc/terms/"
    xmlns:g2o="http://gams.uni-graz.at/ontology/#"
    xmlns:ooa="http://gams.uni-graz.at/o:ooa.ontology/#"
    xmlns:sr="http://www.w3.org/2001/sw/DataAccess/rf1/result" version="2.0">
    <xsl:include href="ooa-static.xsl"/>

    <xsl:template name="content">
        <xsl:apply-templates/>
    </xsl:template>

    <!--Basic Site Structure-->
    <xsl:template match="rdf:RDF">
        <section class="row">
            <article class="col-md-12" id="ontology">
                <div class="card">
                    <div class="card-body">
                        <h3>
                            <xsl:value-of select="//ooa:Oathroll/skos:prefLabel"/>
                            <!--<a id="exportHSSF" href="{concat('/archive/objects/query:ooa.search-bydocument/methods/sdef:Query/getHSSF?params=$1|', $server, '/', $teipid)}">
                                <span class="oi oi-data-transfer-download"
                                    data-toggle="tooltip" data-placement="top"
                                    title="Download XLS"/>-->
                            <!--</a>-->
                        </h3>
                        <!--Head Text-->
                        <xsl:for-each select="ooa:ExtranuousDataTo/t:p">
                            <p>
                                <xsl:apply-templates/>
                            </p>
                        </xsl:for-each>
                        <table class="table table-borderless table-hover">
                            <thead>
                                <tr>
                                    <th>order</th>
                                    <th>date</th>
                                    <th>surname</th>
                                    <th>name</th>
                                    <th>address</th>
                                    <th>parish</th>
                                    <th>status</th>
                                    <th>gender</th>
                                    <th>religion</th>
                                    <th>marginalia</th>
                                    <th>del.</th>
                                    <th>note</th>
                                    <th id="cb"><!--Checkbox--></th>
                                </tr>
                            </thead>
                            <xsl:apply-templates select="ooa:OathRollEntry"/>
                        </table>
                    </div>
                </div>
            </article>
        </section>
    </xsl:template>

    <!--Entries-->
    <xsl:template match="ooa:OathRollEntry">
        <xsl:param name="oathswearer" select="ooa:documents/ooa:OathSwearing/ooa:by/ooa:OathSwearer"/>
        <tr id="{substring-after(@rdf:about, '#')}" xml:id="{substring-after(@rdf:about, 'o:ooa.')}">
            <td id="order">
                <xsl:value-of select="substring-after(@rdf:about, '_')"/>
            </td>
            <td id="date">
                <xsl:value-of select="ooa:documents/ooa:OathSwearing/bk:when"/>
            </td>
            <td id="surname">
                <xsl:value-of select="$oathswearer/t:surname"/>
            </td>
            <td id="name">
                <xsl:value-of select="$oathswearer/t:forename"/>
            </td>
            <td id="address">
                <xsl:value-of select="$oathswearer/ooa:isLocatedIn"/>
            </td>
            <td id="parish">
                <xsl:value-of select="$oathswearer/ooa:isLocatedInParish"/>
            </td>
            <td id="status">
                <xsl:value-of select="$oathswearer/t:socecStatus"/>
            </td>
            <td id="gender">
                <xsl:value-of select="$oathswearer/t:sex"/>
            </td>
            <td id="religion">
                <xsl:value-of select="$oathswearer/t:faith"/>
            </td>
            <td id="marginalia">
                <xsl:value-of select="t:add"/>
            </td>
            <td id="del">
                <xsl:value-of select="t:del"/>
            </td>
            <td id="note">
                <xsl:value-of select="t:note"/>
            </td>
            <!--Checkbox-->
            <td id="cb">
                <input class="cb form-check-input" type="checkbox"/>
            </td>
        </tr>
    </xsl:template>


</xsl:stylesheet>
