<?xml version="1.0" encoding="UTF-8"?>
<!-- 
    Project: Oaths of Allegiance
    Author: Jakob Sonnberger
    Company: ZIM-ACDH (Zentrum für Informationsmodellierung - Austrian Centre for Digital Humanities)
    Last Update: 12/2021
    /////////////////////////////////////////////////////////////////////////////////////////////////
    Stylesheet Information: HTML Transformation of Basic Site Structure
 -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0"
	xmlns:i18n="http://apache.org/cocoon/i18n/2.1"
	xmlns:s="http://www.w3.org/2001/sw/DataAccess/rf1/result" xmlns="http://www.w3.org/1999/xhtml"
	xmlns:t="http://www.tei-c.org/ns/1.0" xmlns:oai_dc="http://www.openarchives.org/OAI/2.0/oai_dc/"
	xmlns:dc="http://purl.org/dc/elements/1.1/" xmlns:lido="http://www.lido-schema.org"
	xmlns:bibtex="http://bibtexml.sf.net/" exclude-result-prefixes="#all">
	<xsl:output method="xml" doctype-system="about:legacy-compat" encoding="UTF-8" indent="no"/>
	<!-- häufig verwendete variablen... -->
	<xsl:param name="mode"/>
	<xsl:param name="search"/>
	<xsl:variable name="model"
		select="substring-after(/s:sparql/s:results/s:result/s:model/@uri, '/')"/>
	<xsl:variable name="cid">
		<!-- das ist der pid des contextes, kommt aus dem sparql (ggfs. query anpassen) - wenn keine objekte zugeordnet sind, gibt es ihn nicht! -->
		<xsl:value-of select="/s:sparql/s:results/s:result[1]/s:cid"/>
	</xsl:variable>
	<xsl:variable name="teipid">
		<xsl:value-of select="//t:idno[@type = 'PID']"/>
	</xsl:variable>
	<xsl:variable name="querypid" select="//s:result[1]/s:query"/>
	<xsl:variable name="lidopid">
		<xsl:value-of select="//lido:lidoRecID"/>
	</xsl:variable>
	<!--variablen für Suchergebnisse-->
	<xsl:variable name="query" select="sparql/head/query"/>
	<xsl:variable name="hitTotal" select="/sparql/head/hitTotal"/>
	<xsl:variable name="hitPageStart" select="/sparql/head/hitPageStart"/>
	<xsl:variable name="hitPageSize" select="/sparql/head/hitPageSize"/>
	<xsl:variable name="hitsFrom" select="sparql/navigation/hits/from"/>
	<xsl:variable name="hitsTo" select="sparql/navigation/hits/to"/>
	<!-- GAMS global variables -->
	<xsl:variable name="zim">Zentrum für Informationsmodellierung - Austrian Centre for Digital
		Humanities</xsl:variable>
	<xsl:variable name="zim-acdh">ZIM-ACDH</xsl:variable>
	<xsl:variable name="gams">Geisteswissenschaftliches Asset Management System</xsl:variable>
	<xsl:variable name="uniGraz">Universität Graz</xsl:variable>
	<!-- project-specific variables -->
	<xsl:variable name="server">http://glossa.uni-graz.at</xsl:variable>
	<xsl:variable name="gamsdev">/gamsdev/sonnberger</xsl:variable>
	<xsl:variable name="projectTitle">
		<xsl:text>1723 Oaths of Allegiance</xsl:text>
	</xsl:variable>
	<xsl:variable name="subTitle">
		<xsl:text>London</xsl:text>
	</xsl:variable>
	<!-- gesamtes css ist in dieser Datei zusammengefasst mit Ausnahme der Navigation -->
	<xsl:variable name="projectCss">
		<xsl:value-of select="concat($gamsdev, '/ooa/css/ooa.css')"/>
	</xsl:variable>
	<!--css für die navigation-->
	<xsl:variable name="projectNav">
		<xsl:value-of select="concat($gamsdev, '/ooa/css/ooa-navbar.css')"/>
	</xsl:variable>
	<xsl:template match="/">
		<html lang="en">
			<head>
				<meta charset="utf-8"/>
				<meta name="viewport" content="width=device-width, initial-scale=1"/>
				<meta name="keywords"
					content="oaths of allegiance, GAMS, repository, digital, archive, edition"/>
				<meta name="description"
					content="Oaths of Allegiance - Geisteswissenschaftliches Asset Management System"/>
				<meta name="publisher"
					content="Zentrum für Informationsmodellierung - Austrian Centre for Digital Humanities"/>
				<meta name="content-language" content="en"/>
				<title>1723 Oaths of Allegiance London</title>
				<!-- Bootstrap core CSS ======================================================== -->
				<link href="/lib/2.0/bootstrap-4.1.0-dist/css/bootstrap.min.css" rel="stylesheet"
					type="text/css"/>
				<!-- Custom styles for ooa CSS =========================================== -->
				<link href="{$projectCss}" rel="stylesheet" type="text/css"/>
				<link href="{$projectNav}" rel="stylesheet" type="text/css"/>
				<!-- Icons CSS-->
				<link href="/lib/2.0/open-iconic/font/css/open-iconic-bootstrap.css"
					rel="stylesheet" type="text/css"/>
				<!-- jQuery core JavaScript ================================================= -->
				<script type="text/javascript" src="/lib/2.0/jquery-3.3.1.min.js"><xsl:text>//  </xsl:text></script>
				<!-- Bootstrap core JavaScript ============================================== -->
				<script type="text/javascript" src="/lib/2.0/bootstrap-4.1.0-dist/js/bootstrap.bundle.min.js"><xsl:text>//  </xsl:text></script>
			</head>
			<!-- Header ====================================== -->
			<body>
				<header>
					<div class="container">
						<div class="row flex">
							<div class="col-6">
								<h1>
									<xsl:value-of select="$projectTitle"/>
								</h1>
								<h2>
									<xsl:value-of select="$subTitle"/>
								</h2>
							</div>
							<div class="col-6">
								<div class="unilogo d-flex">
									<a
										href="https://www.cityoflondon.gov.uk/things-to-do/history-and-heritage/london-metropolitan-archives"
										target="_blank">
										<img class="logoUni img-fluid"
											src="{concat($gamsdev, '/ooa/img/LMA_logo.png')}"
											title="London Metropolitan Archives"
											alt="London Metropolitan Archives"/>
									</a>
									<a href="https://www.roehampton.ac.uk" target="_blank">
										<img class="logoUni img-fluid"
											src="{concat($gamsdev, '/ooa/img/roehampton_logo.png')}"
											title="University of Roehampton"
											alt="University of Roehampton"/>
									</a>
									<a
										href="https://www.roehampton.ac.uk/research-centres/centre-for-hearth-tax-research/"
										target="_blank">
										<img class="logoUni img-fluid"
											src="{concat($gamsdev, '/ooa/img/chtr_logo.jpg')}"
											title="Centre for Hearth Tax Research"
											alt="Centre for Hearth Tax Research"/>
									</a>
									<a href="http://www.uni-graz.at" target="_blank">
										<img class="logoUni img-fluid"
											src="/templates/img/logo_uni_graz_4c.jpg"
											title="University of Graz" alt="University of Graz"/>
									</a>
								</div>
							</div>
						</div>
					</div>
				</header>
				<!-- Navbar ====================================== -->
				<nav class="hearthtax navbar navbar-expand-md navbar-dark sticky-top">
					<div class="container">
						<a class="navbar-brand d-md-none" href="#">Navigation</a>
						<button class="navbar-toggler" type="button" data-toggle="collapse"
							data-target="#navbarCollapse" aria-controls="navbarCollapse"
							aria-expanded="false" aria-label="Toggle navigation">
							<span class="navbar-toggler-icon"/>
						</button>
						<div id="navbarCollapse" class="collapse navbar-collapse">
							<ul class="hearthtax navbar-nav mr-auto">
								<li class="nav-item">
									<xsl:if test="$mode = '' and $cid = 'context:ooa'">
										<xsl:attribute name="class">nav-item active</xsl:attribute>
									</xsl:if>
									<a class="nav-link" href="/context:ooa">home</a>
								</li>
								<li class="nav-item">
									<xsl:if test="$mode = 'about'">
										<xsl:attribute name="class">nav-item active</xsl:attribute>
									</xsl:if>
									<a class="nav-link"
										href="/archive/objects/context:ooa/methods/sdef:Context/get?mode=about"
										>about</a>
								</li>
								<li class="nav-item">
									<xsl:if test="$mode = 'oathRolls'">
										<xsl:attribute name="class">nav-item active</xsl:attribute>
									</xsl:if>
									<a class="nav-link"
										href="/archive/objects/context:ooa/methods/sdef:Context/get?mode=oathRolls"
										>oath rolls</a>
								</li>
								<li class="nav-item">
									<xsl:if test="$mode = 'advancedSearch'">
										<xsl:attribute name="class">nav-item active</xsl:attribute>
									</xsl:if>
									<a class="nav-link"
										href="/archive/objects/context:ooa/methods/sdef:Context/get?mode=advancedSearch"
										>advanced search</a>
								</li>
								<li class="nav-item">
									<xsl:if test="$mode = 'dataBasket'">
										<xsl:attribute name="class">nav-item active</xsl:attribute>
									</xsl:if>
									<a class="nav-link"
										href="/archive/objects/context:ooa/methods/sdef:Context/get?mode=dataBasket"
											>databasket<span class="badge-pill badge-dark"
											id="daba_length"/></a>
								</li>
								<li class="nav-item">
									<xsl:if test="$mode = 'occupations'">
										<xsl:attribute name="class">nav-item active</xsl:attribute>
									</xsl:if>
									<a class="nav-link"
										href="/query:ooa.occupations"
										>occupations</a>
								</li>
							</ul>
							<form class="form-inline" role="search" method="get"
								action="/query:ooa.search-full" id="searchFullForm">
								<div class="input-group">
									<input name="params" type="text" class="form-control"
										id="searchFullInput" placeholder="Fulltext Search"/>
									<button id="searchFullButton" class="btn btn-outline-light"
										type="submit">
										<span class="oi oi-magnifying-glass"> </span>
										<span class="sr-only">Search</span>
									</button>
								</div>
							</form>
						</div>
						<!-- /.navbar-collapse -->
					</div>
					<!-- /.container -->
				</nav>
				<main class="container">
					<xsl:choose>
						<!-- Home ====================================== -->
						<xsl:when test="$mode = '' and $cid = 'context:ooa'">
							<section class="row" id="home">
								<article class="col-md-6" id="home">
									<div class="card">
										<div class="card-body">
											<xsl:apply-templates
												select="document('/archive/objects/context:ooa/datastreams/HOME/content')//t:TEI"
											/>
										</div>
									</div>
								</article>
							</section>
						</xsl:when>
						<xsl:when test="$mode = 'about'">
							<!-- About ====================================== -->
							<section class="row">
								<article class="col-md-12 about">
									<div class="card">
										<div class="card-body">
											<xsl:apply-templates
												select="document('/archive/objects/context:ooa/datastreams/ABOUT/content')//t:TEI"
											/>
										</div>
									</div>
								</article>
							</section>
						</xsl:when>
						<xsl:when test="$mode = 'advancedSearch'">
							<!-- Advanced Search ====================================== -->
							<section class="row">
								<article class="col-md-12" id="advancedSearch">
									<div class="card">
										<div class="card-body">
											<h3>Advanced Search</h3>
											<!--Advanced Search manual-->
											<div class="alert alert-success" role="alert">
												<button type="button" class="close"
												data-dismiss="alert" aria-label="Close">
												<span aria-hidden="true">x</span>
												</button>
												<!-- manual text -->This search will return a
												<b>maximum of 500 hits</b>. <br/>Be aware that
												searching for <b>occupation</b>, <b>religion</b>
												or <b>parish</b> will only propose and return entries
												literally present in the transcripts. </div>
											<form role="search-ext" method="get"
												action="/query:ooa.search-by" id="searchByForm"
												class="col-6">
												<!--Surname-->
												<div class="form-group">
												<label for="inputName">name</label>
												<input type="text"
												class="form-control form-control-sm"
												placeholder="name" id="inputName"/>
												</div>
												<!--Gender-->
												<div class="form-group">
												<label for="selectGender">gender</label>
												<select class="form-control form-control-sm col-4"
												placeholder="gender" id="selectGender">
												<option/>
												<option>male</option>
												<option>female</option>
												</select>
												</div>
												<!--Occupation-->
												<div class="form-group">
												<label for="inputOccupation">occupation</label>
												<input type="text"
												class="form-control form-control-sm"
												placeholder="occupation" id="inputOccupation"
												list="autocompleteOccupation" autocomplete="off">
												<datalist id="autocompleteOccupation">
												<xsl:call-template name="autocompleteOccupation"/>
												</datalist>
												</input>
												</div>
												<!--religion-->
												<div class="form-group">
												<label for="selectReligion">religion</label>
												<select class="form-control form-control-sm col-4"
												placeholder="religion" id="selectReligion">
												<option/>
												<xsl:call-template name="autocompleteReligion"/>
												</select>
												</div>
												<!--parish-->
												<div class="form-group">
												<label for="inputParish">parish</label>
												<input type="text"
												class="form-control form-control-sm"
												placeholder="parish" id="inputParish"
												list="autocompleteParish">
												<datalist id="autocompleteParish">
												<xsl:call-template name="autocompleteParish"/>
												</datalist>
												</input>
												</div>
												<!--date-->
												<div class="form-group">
												<label for="selectDate">date</label>
												<select class="form-control form-control-sm col-4"
												placeholder="date" id="selectDate">
												<option/>
												<xsl:call-template name="autocompleteDate"/>
												</select>
												</div>
												<div class="input-group input-group-sm">
												<input class="btn btn-secondary btn-sm"
												type="submit" id="submit" value="Search"/>
												</div>
											</form>
										</div>
									</div>
								</article>
							</section>
						</xsl:when>
						<!-- Imprint ====================================== -->
						<xsl:when test="$mode = 'imprint'">
							<section class="row">
								<article class="col-md-12 imprint">
									<div class="card">
										<div class="card-body">
											<xsl:apply-templates
												select="document('/archive/objects/context:ooa/datastreams/IMPRINT/content')//t:TEI"
											/>
										</div>
									</div>
								</article>
							</section>
						</xsl:when>
						<!-- Databasket ====================================== -->
						<xsl:when test="$mode = 'dataBasket'">
							<section class="row">
								<article class="col-md-12" id="dataBasket">
									<div class="card">
										<div class="card-body">
											<h3>Databasket<a href="#" id="clearDatabasket">
												<span class="oi oi-delete" data-toggle="tooltip"
												data-placement="top" title="Delete all entries"/>
												</a>
												<a href="#" id="exportDatabasket"
												download="databasket.csv">
												<span class="oi oi-data-transfer-download"
												data-toggle="tooltip" data-placement="top"
												title="Export to CSV"/>
												</a></h3>
											<!--DataBasket manual-->
											<div class="alert alert-success" role="alert"><button
												type="button" class="close" data-dismiss="alert"
												aria-label="Close">
												<span aria-hidden="true">x</span>
												</button>Entries from both the records themselves as
												well as entries from search results can be stored
												here by clicking the corresponding checkboxes.</div>
											<table class="table table-borderless table-hover">
												<thead>
												<tr>
												<th>entry<span id="entry"
												class="sort oi oi-elevator"/></th>
												<th>date<span id="date"
												class="sort oi oi-elevator"/></th>
												<th>surname<span id="surname"
												class="sort oi oi-elevator"/></th>
												<th>name<span id="name"
												class="sort oi oi-elevator"/></th>
												<th>address<span id="address"
												class="sort oi oi-elevator"/></th>
												<th>parish<span id="parish"
												class="sort oi oi-elevator"/></th>
												<th>status<span id="status"
												class="sort oi oi-elevator"/></th>
												<th>gender<span id="gender"
												class="sort oi oi-elevator"/></th>
												<th>religion<span id="religion"
												class="sort oi oi-elevator"/></th>
												<th>marginalia<span id="marginalia"
												class="sort oi oi-elevator"/></th>
												<th>del.<span id="del" class="sort oi oi-elevator"
												/></th>
												<th>note<span id="note"
												class="sort oi oi-elevator"/></th>
												<th id="cb"><!--Checkbox--></th>
												</tr>
												</thead>
												<tbody/>
											</table>
										</div>
									</div>
								</article>
							</section>
							<script type="text/javascript">
                                $(document).ready(function () {
                                    showDatabasket();
                                });</script>
						</xsl:when>
						
						<xsl:otherwise>
							<xsl:call-template name="content"/>
						</xsl:otherwise>
					</xsl:choose>
				</main>
				<footer class="footer">
					<div class="container">
						<div class="row">
							<div class="col-md-6">
								<h6>Further Informations</h6>
								<p>
									<a href="/archive/objects/context:ooa/methods/sdef:Context/get?mode=imprint">Imprint</a>
									<br/>
									<a href="https://gams.uni-graz.at/archive/objects/context:gams/methods/sdef:Context/get?mode=dataprotection&amp;locale=en" target="_blank">Privacy</a>
								</p>
								<div class="icons">
									<a href="https://gams.uni-graz.at/context:gams" target="_blank">
										<img class="footer_icons"
											src="/templates/img/gamslogo_weiss.gif" height="48"
											title="{$gams}" alt="{$gams}"/>
									</a>
									<a href="https://informationsmodellierung.uni-graz.at/"
										target="_blank">
										<img class="footer_icons" src="/templates/img/ZIM_weiss.png"
											height="48" title="{$zim-acdh}" alt="{$zim-acdh}"/>
									</a>
									<a href="http://creativecommons.org/licenses/by/4.0/"
										target="_blank">
										<img class="footer_icons" src="/templates/img/by.png"
											height="45" title="License" alt="License"/>
									</a>
								</div>
							</div>
							<div class="col-md-6 contact">
								<h6>Contact</h6>
								<p>Prof. Edward Vallance<br/>Centre for Hearth Tax
									Research<br/>School of Humanities and Social Sciences<br/>University of
									Roehampton<br/>London SW15 5PU<br/>
									<a href="mailto:edward.vallance@roehampton.ac.uk"
										>edward.vallance@roehampton.ac.uk</a>
								</p>
							</div>
						</div>
					</div>
				</footer>
				<!-- Search JavaScript ============================================== -->
				<script type="text/javascript" src="{concat($gamsdev, '/ooa/js/search.js')}"><xsl:text>//  </xsl:text></script>
				<!-- DataBasket JavaScript ============================================== -->
				<script type="text/javascript" src="{concat($gamsdev, '/ooa/js/databasket.js')}"><xsl:text>//  </xsl:text></script>
				<script type="text/javascript">
                    //update Databasket Counter
                    count_databasket();
                    $(document).ready(function () {
                        //check checkboxes for entries allready in Databasket
                        $('input:checkbox.cb').each(function () {
                            if (is_in_localStorage(this)) {
                                $(this).attr('checked', true)
                            }
                        });
                        //BS4 Tooltips
                        $('[data-toggle="tooltip"]').tooltip();
                        
                        //scrolldown on entry-links to skip navbar
                        if (window.location.href.indexOf("#") != -1) {
                            window.scrollBy(0, -60);
                        }
                    });
                    //scrolldown on manual URL-change to skip navbar
                    $(window).on('hashchange', function () {
                        window.scrollBy(0, -60);
                    });</script>
			</body>
		</html>
	</xsl:template>
	<xsl:template match="t:teiHeader" priority="-5"/>
	<xsl:template match="t:div" priority="-5">
		<div>
			<xsl:apply-templates/>
		</div>
	</xsl:template>
	<xsl:template match="t:p" priority="-5">
		<p>
			<xsl:apply-templates/>
		</p>
	</xsl:template>
	<xsl:template match="t:head" priority="-5">
		<h3>
			<xsl:apply-templates/>
		</h3>
	</xsl:template>
	<xsl:template match="t:ref" priority="-5">
		<a href="{@target}" target="{@rend}">
			<xsl:apply-templates/>
		</a>
	</xsl:template>
	<xsl:template match="t:bibl" priority="-5">
		<a href="{@corresp}">
			<xsl:apply-templates/>
		</a>
	</xsl:template>
	<xsl:template match="t:code" priority="-5">
		<code>
			<xsl:apply-templates/>
		</code>
	</xsl:template>
	<xsl:template match="t:quote" priority="-5">
		<q>
			<xsl:apply-templates/>
		</q>
	</xsl:template>
	<xsl:template match="t:lb" priority="-5">
		<br/>
	</xsl:template>
	<xsl:template match="t:listBibl" priority="-5">
		<xsl:apply-templates select="t:head"/>
		<ul class="list-group">
			<xsl:apply-templates select="t:bibl" mode="list"/>
		</ul>
	</xsl:template>
	<xsl:template match="t:bibl" mode="list">
		<li class="list-group-item" id="{@xml:id}">
			<xsl:apply-templates/>
		</li>
	</xsl:template>

	<xsl:template name="autocompleteOccupation">
		<xsl:for-each
			select="document(concat('/archive/objects/query:ooa.search-autocomplete/methods/sdef:Query/getXML?params=%241%7C', encode-for-uri('?s ooa:occupation/skos:prefLabel ?option .')))//s:option">
			<option>
				<xsl:value-of select="."/>
			</option>
		</xsl:for-each>
	</xsl:template>

	<xsl:template name="autocompleteReligion">
		<xsl:for-each
			select="document(concat('/archive/objects/query:ooa.search-autocomplete/methods/sdef:Query/getXML?params=%241%7C', encode-for-uri('?s t:faith ?option .')))//s:option">
			<option>
				<xsl:value-of select="."/>
			</option>
		</xsl:for-each>
	</xsl:template>

	<xsl:template name="autocompleteParish">
		<xsl:for-each
			select="document(concat('/archive/objects/query:ooa.search-autocomplete/methods/sdef:Query/getXML?params=%241%7C', encode-for-uri('?s ooa:isLocatedInParish ?option .')))//s:option">
			<option>
				<xsl:value-of select="."/>
			</option>
		</xsl:for-each>
	</xsl:template>

	<xsl:template name="autocompleteDate">
		<xsl:for-each
			select="document(concat('/archive/objects/query:ooa.search-autocomplete/methods/sdef:Query/getXML?params=%241%7C', encode-for-uri('?oath bk:when ?option .')))//s:option">
			<option>
				<xsl:value-of select="."/>
			</option>
		</xsl:for-each>
	</xsl:template>

</xsl:stylesheet>
