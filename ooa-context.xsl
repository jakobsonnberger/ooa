<?xml version="1.0" encoding="UTF-8"?>
<!-- 
    Project: Oath of Allegiance
    Author: Jakob Sonnberger
    Company: ZIM-ACDH (Zentrum für Informationsmodellierung - Austrian Centre for Digital Humanities)
    /////////////////////////////////////////////////////////////////////////////////////////////////
    Stylesheet Information: Indexing ontology-objects, RDF and Spreadsheet functions
 -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0"
    xmlns:i18n="http://apache.org/cocoon/i18n/2.1"
    xmlns:s="http://www.w3.org/2001/sw/DataAccess/rf1/result" xmlns="http://www.w3.org/1999/xhtml"
    xmlns:t="http://www.tei-c.org/ns/1.0" xmlns:oai_dc="http://www.openarchives.org/OAI/2.0/oai_dc/"
    xmlns:dc="http://purl.org/dc/elements/1.1/" exclude-result-prefixes="#all">
    <!--<xsl:output method="xml" doctype-system="about:legacy-compat" encoding="UTF-8" indent="no"/>-->
    <xsl:include href="ooa-static.xsl"/>
    <xsl:template name="content">
        <section class="row">
            <article class="col-md-12" id="oathRolls">
                <div class="card">
                    <div class="card-body">

                        <!--Ontology objects-->

                        <h3>Oath Rolls</h3>
                        <ul class="list-group">
                            <xsl:for-each
                                select="s:sparql/s:results/s:result[s:model/@uri = 'info:fedora/cm:Ontology'][not(contains(s:identifier, 'ontology'))]">
                                <xsl:sort select="s:title"/>
                                <li class="list-group-item">
                                    <span class="results">
                                        <a href="{concat('/',s:identifier)}">
                                            <xsl:value-of select="./s:title"/>
                                        </a>
                                    </span>

                                    <!--Icons-->
                                    <span class="icon-span">
                                        <!--RDF-->
                                        <a target="_blank" class="icons"
                                            href="{concat('/', ./s:identifier, '/ONTOLOGY')}">
                                            <img src="/templates/img/RDF_icon.png" height="18"
                                                alt="RDF" title="RDF"/>
                                        </a>
                                        <!--Excel-->
                                        <a class="icons"
                                            href="{concat('/archive/objects/query:ooa.search-bydocument/methods/sdef:Query/getHSSF?params=$1|', encode-for-uri(concat($server, '/', ./s:identifier)))}"
                                            download="{substring-after(./s:identifier, 'o:ooa.')}">
                                            <img
                                                src="{concat($gamsdev, '/ooa/img/excel_icon.png')}"
                                                height="18" alt="Download Spreadsheet" title="Download Spreadsheet"
                                            />
                                        </a>
                                    </span>
                                </li>
                            </xsl:for-each>
                        </ul>
                    </div>
                </div>
            </article>
        </section>
    </xsl:template>


</xsl:stylesheet>
