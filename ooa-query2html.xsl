<?xml version="1.0" encoding="UTF-8"?>
<!-- 
    Project: Oath of Allegiance
    Author: Jakob Sonnberger
    Company: ZIM-ACDH (Zentrum für Informationsmodellierung - Austrian Centre for Digital Humanities)
    /////////////////////////////////////////////////////////////////////////////////////////////////
    Stylesheet Information: Query Results to HTML
 -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:s="http://www.w3.org/2001/sw/DataAccess/rf1/result" version="2.0">
    <xsl:include href="ooa-static.xsl"/>

    <!--Number of results-->
    <xsl:variable name="countResults" select="count(s:sparql/s:results/s:result)"/>

    <xsl:template name="content">
        <xsl:apply-templates/>
    </xsl:template>

    <!--Basic Site Structure-->
    <xsl:template match="s:sparql">
        <section class="row">
            <article class="col-md-12" id="searchResults">
                <div class="card">
                    <div class="card-body">
                        <!--Number of results-->
                        <div class="alert alert-success" role="alert"><button type="button"
                                class="close" data-dismiss="alert" aria-label="Close">
                                <span aria-hidden="true">x</span>
                            </button>Your search returned <strong><xsl:value-of
                                    select="$countResults"/></strong> results.</div>
                        <xsl:apply-templates/>
                    </div>
                </div>
            </article>
        </section>
    </xsl:template>

    <xsl:template match="s:head"/>

    <!--resultS-->
    <xsl:template match="s:results">
        <table class="table table-borderless table-hover">
            <thead>
                <tr>
                    <th>entry</th>
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
                    <th id="cb"><!--Checkbox--><input class="cbHead form-check-input" type="checkbox"/></th>
                </tr>
            </thead>
            <xsl:apply-templates/>
        </table>
    </xsl:template>

    <!--results within entries-->
    <xsl:template match="s:result[s:entryURI]">
        <tr xml:id="{substring-after(s:entryURI/@uri, 'o:ooa.')}">
            <td id="entry">
                <a href="{s:entryURI/@uri}">
                    <xsl:value-of select="substring-after(s:entryURI/@uri, 'o:ooa.')"/>
                </a>
            </td>
            <td id="date">
                <xsl:value-of select="s:date"/>
            </td>
            <td id="surname">
                <xsl:value-of select="s:surname"/>
            </td>
            <td id="name">
                <xsl:value-of select="s:forename"/>
            </td>
            <td id="address">
                <xsl:value-of select="s:address"/>
            </td>
            <td id="parish">
                <xsl:value-of select="s:parish"/>
            </td>
            <td id="status">
                <xsl:value-of select="s:status"/>
            </td>
            <td id="gender">
                <xsl:value-of select="s:sex"/>
            </td>
            <td id="religion">
                <xsl:value-of select="s:religion"/>
            </td>
            <td id="marginalia">
                <xsl:value-of select="s:margin"/>
            </td>
            <td id="del">
                <xsl:value-of select="s:del"/>
            </td>
            <td id="note">
                <xsl:value-of select="s:note"/>
            </td>
            <!--Checkbox-->
            <td id="cb">
                <input class="cb form-check-input" type="checkbox"/>
            </td>
        </tr>
    </xsl:template>

    <!--results within extranuous Data-->
    <xsl:template match="s:result[s:oathrollURI]">
        <tr id="extranuousData">
            <td id="entry">
                <a href="{s:oathrollURI/@uri}">
                    <xsl:value-of select="substring-after(s:oathrollURI/@uri, 'o:ooa.')"/>
                </a>
            </td>
            <td id="text" colspan="10">
                <xsl:value-of select="s:text"/>
            </td>
            <td colspan="2">
                <strong>Extranuous Data</strong>
            </td>
        </tr>
    </xsl:template>

</xsl:stylesheet>
