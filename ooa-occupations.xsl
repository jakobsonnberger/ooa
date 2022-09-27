<?xml version="1.0" encoding="UTF-8"?>
<!-- 
    Project: Oath of Allegiance
    Author: Jakob Sonnberger
    Company: ZIM-ACDH (Zentrum für Informationsmodellierung - Austrian Centre for Digital Humanities)
    /////////////////////////////////////////////////////////////////////////////////////////////////
    Stylesheet Occupation Visualisations
 -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:s="http://www.w3.org/2001/sw/DataAccess/rf1/result" version="2.0">
    <xsl:include href="ooa-static.xsl"/>

    <xsl:template name="content">
        <xsl:apply-templates/>
    </xsl:template>

    <!--Basic Site Structure-->
    <xsl:template match="s:sparql">
        <section class="row">
            <script type="text/javascript" src="https://cdn.jsdelivr.net/npm/echarts@4.9.0/dist/echarts.min.js">
            //</script>

            <article class="col-md-12" id="occupations_visualisations">
                <div class="card">
                    <div class="card-body">
                        <h3>Occupations</h3>
                        <xsl:apply-templates/>
                        <div id="visualisation" style="height:800px; margin-top:50px">
                            <xsl:text>  </xsl:text>
                        </div>
                    </div>
                </div>
            </article>
        </section>

    </xsl:template>

    <xsl:template match="s:head"/>

    <!--results-->
    <xsl:template match="s:results">
        <script>window.myString = '[';</script>
        <xsl:for-each-group select="s:result" group-by="s:HISCO_Major_group">
            <!--<script>window.myString += '{"name": "<xsl:value-of select="current-grouping-key()"/>","children":[';</script>-->
            <details>
                <summary style="font-weight:bold; color:#00a06e">
                    <xsl:value-of select="current-grouping-key()"/>
                    <xsl:text>  </xsl:text>

                    <xsl:variable name="queryParam">
                        <xsl:text>skos:broader/skos:broader/skos:broader/skos:broader/skos:prefLabel "</xsl:text>
                        <xsl:value-of select="current-grouping-key()"/>
                        <xsl:text>"</xsl:text>
                    </xsl:variable>

                    <a target="_blank"
                        href='{concat("/query:ooa.byoccupation?params=$1|",encode-for-uri($queryParam))}'>
                        <span class="oi oi-people"/>
                    </a>
                </summary>
                <xsl:for-each-group select="current-group()" group-by="s:HISCO_Minor_group">
                    <!--<script>window.myString += '{"name":"<xsl:value-of select="current-grouping-key()"/>","children":[';</script>-->
                    <details style="margin-left:20px">
                        <summary style="font-weight:bold%">
                            <xsl:value-of select="current-grouping-key()"/>
                            <xsl:text>  </xsl:text>

                            <xsl:variable name="queryParam">
                                <xsl:text>skos:broader/skos:broader/skos:broader/skos:prefLabel "</xsl:text>
                                <xsl:value-of select="current-grouping-key()"/>
                                <xsl:text>"</xsl:text>
                            </xsl:variable>

                            <a target="_blank"
                                href='{concat("/query:ooa.byoccupation?params=$1|",encode-for-uri($queryParam))}'>
                                <span class="oi oi-people"/>
                            </a>
                        </summary>
                        <xsl:for-each-group select="current-group()" group-by="s:HISCO_Unit_group">
                            <!--<script>window.myString += '{"name":"<xsl:value-of select="current-grouping-key()"/>","children":[';</script>-->
                            <details style="margin-left:40px">
                                <summary style="color:#00a06e">
                                    <xsl:value-of select="current-grouping-key()"/>
                                    <xsl:text>  </xsl:text>

                                    <xsl:variable name="queryParam">
                                        <xsl:text>skos:broader/skos:broader/skos:prefLabel "</xsl:text>
                                        <xsl:value-of select="current-grouping-key()"/>
                                        <xsl:text>"</xsl:text>
                                    </xsl:variable>

                                    <a target="_blank"
                                        href='{concat("/query:ooa.byoccupation?params=$1|",encode-for-uri($queryParam))}'>
                                        <span class="oi oi-people"/>
                                    </a>
                                </summary>
                                <ul>
                                    <xsl:for-each-group select="current-group()"
                                        group-by="s:HISCO_Unit">
                                        <!--<script>window.myString += '{"name":"<xsl:value-of select="current-grouping-key()"/>","value":<xsl:value-of select="s:count"/>';</script>-->
                                        <xsl:choose>
                                            <xsl:when test="position() != last()">
                                                <script>window.myString += '},';</script>
                                            </xsl:when>
                                            <xsl:otherwise>
                                                <script>window.myString += '}]';</script>
                                            </xsl:otherwise>
                                        </xsl:choose>
                                        <li>
                                            <xsl:value-of
                                                select="concat(current-grouping-key(), ' (', s:count, ')')"/>
                                            <xsl:text>  </xsl:text>

                                            <xsl:variable name="queryParam">
                                                <xsl:text>skos:broader/skos:prefLabel "</xsl:text>
                                                <xsl:value-of select="current-grouping-key()"/>
                                                <xsl:text>"</xsl:text>
                                            </xsl:variable>

                                            <a target="_blank"
                                                href='{concat("/query:ooa.byoccupation?params=$1|",encode-for-uri($queryParam))}'>
                                                <span class="oi oi-people"/>
                                            </a>
                                        </li>

                                    </xsl:for-each-group>
                                </ul>
                            </details>
                            <!--<xsl:choose>
                                <xsl:when test="position() != last()">
                                    <script>window.myString += '},';</script>
                                </xsl:when>
                                <xsl:otherwise>
                                    <script>window.myString += '}]';</script>
                                </xsl:otherwise>
                            </xsl:choose>-->
                        </xsl:for-each-group>
                        <!--<xsl:choose>
                            <xsl:when test="position() != last()">
                                <script>window.myString += '},';</script>
                            </xsl:when>
                            <xsl:otherwise>
                                <script>window.myString += '}]';</script>
                            </xsl:otherwise>
                        </xsl:choose>-->
                    </details>
                </xsl:for-each-group>
            </details>
            <!--<xsl:choose>
                <xsl:when test="position() != last()">
                    <script>window.myString += '},';</script>
                </xsl:when>
                <xsl:otherwise>
                    <script>window.myString += '}]';</script>
                </xsl:otherwise>
            </xsl:choose>-->
        </xsl:for-each-group>
        <script>
            $(document).ready(function(){
		    //console.log(myString)
            var myChart = echarts.init(document.getElementById('visualisation'));
			var data = [
    {
        "name": "Production and related workers, transport equipment operators and labourers",
        "children": [
            {
                "name": "Spinners, Weavers, Knitters, Dyers and Related Workers",
                "children": [
                    {
                        "name": "Spinners and Winders",
                        "children": [
                            {
                                "name": "Spinner, Thread and Yarn",
                                "value": 505
                            }
                        ]
                    },
                    {
                        "name": "Weavers and Related Workers",
                        "children": [
                            {
                                "name": "Weaver, Specialisation Unknown",
                                "value": 28
                            }
                        ]
                    },
                    {
                        "name": "Spinners, Weavers, Knitters, Dyers and Related Workers Not Elsewhere Classified",
                        "children": [
                            {
                                "name": "Other Spinners, Weavers, Knitters, Dyers and Related Workers",
                                "value": 18
                            }
                        ]
                    },
                    {
                        "name": "Bleachers, Dyers and Textile Product Finishers",
                        "children": [
                            {
                                "name": "Bleacher, Dyer or Textile Product Finisher, Specialisation Unknown",
                                "value": 13
                            },
                            {
                                "name": "Textile Calender Operator",
                                "value": 2
                            },
                            {
                                "name": "Other Bleachers, Dyers and Textile Product Finishers",
                                "value": 1
                            }
                        ]
                    },
                    {
                        "name": "Fibre Preparers",
                        "children": [
                            {
                                "name": "Other Fibre Preparers",
                                "value": 7
                            }
                        ]
                    },
                    {
                        "name": "Knitters",
                        "children": [
                            {
                                "name": "Knitter (Hand-Operated Machine)",
                                "value": 3
                            }
                        ]
                    }
                ]
            },
            {
                "name": "Jewellers and Precious Metal Workers",
                "children": [
                    {
                        "name": "Jewellery and Precious Metal Workers",
                        "children": [
                            {
                                "name": "Goldsmith and Silversmith",
                                "value": 77
                            },
                            {
                                "name": "Jeweller, General",
                                "value": 14
                            },
                            {
                                "name": "Precious Metal Leaf Roller",
                                "value": 4
                            },
                            {
                                "name": "Other Jewellery and Precious Metal Workers",
                                "value": 2
                            },
                            {
                                "name": "Gem Cutter and Polisher",
                                "value": 2
                            }
                        ]
                    }
                ]
            },
            {
                "name": "Cabinetmakers and Related Woodworkers",
                "children": [
                    {
                        "name": "Cabinetmakers and Related Woodworkers Not Elsewhere Classified",
                        "children": [
                            {
                                "name": "Cooper",
                                "value": 66
                            },
                            {
                                "name": "Coach-Body Builder",
                                "value": 5
                            },
                            {
                                "name": "Cartwright",
                                "value": 3
                            },
                            {
                                "name": "Wood Carver",
                                "value": 3
                            },
                            {
                                "name": "Smoking-Pipe Maker",
                                "value": 2
                            },
                            {
                                "name": "Other Cabinetmakers and Related Woodworkers",
                                "value": 1
                            }
                        ]
                    },
                    {
                        "name": "Woodworkers",
                        "children": [
                            {
                                "name": "Wood Turner",
                                "value": 14
                            }
                        ]
                    },
                    {
                        "name": "Cabinetmakers",
                        "children": [
                            {
                                "name": "Cabinetmaker",
                                "value": 10
                            }
                        ]
                    }
                ]
            },
            {
                "name": "Bricklayers, Carpenters and Other Construction Workers",
                "children": [
                    {
                        "name": "Carpenters, Joiners and Parquetry Workers",
                        "children": [
                            {
                                "name": "Construction Joiner",
                                "value": 57
                            },
                            {
                                "name": "Carpenter, General",
                                "value": 35
                            },
                            {
                                "name": "Wood Shipwright",
                                "value": 4
                            }
                        ]
                    },
                    {
                        "name": "Bricklayers, Stonemasons and Tile Setters",
                        "children": [
                            {
                                "name": "Bricklayer (Construction)",
                                "value": 29
                            },
                            {
                                "name": "Bricklayer or Stonemason",
                                "value": 7
                            }
                        ]
                    },
                    {
                        "name": "Glaziers",
                        "children": [
                            {
                                "name": "Other Glaziers",
                                "value": 18
                            }
                        ]
                    },
                    {
                        "name": "Plasterers",
                        "children": [
                            {
                                "name": "Plasterer, General",
                                "value": 17
                            }
                        ]
                    }
                ]
            },
            {
                "name": "Food and Beverage Processors",
                "children": [
                    {
                        "name": "Bakers, Pastry Cooks and Confectionery Makers",
                        "children": [
                            {
                                "name": "Baker, General",
                                "value": 38
                            },
                            {
                                "name": "Confectionery Maker",
                                "value": 15
                            },
                            {
                                "name": "Pastry Maker",
                                "value": 1
                            }
                        ]
                    },
                    {
                        "name": "Butchers and Meat Preparers",
                        "children": [
                            {
                                "name": "Butcher, General",
                                "value": 20
                            }
                        ]
                    },
                    {
                        "name": "Brewers, Wine and Beverage Makers",
                        "children": [
                            {
                                "name": "Brewer, General",
                                "value": 19
                            },
                            {
                                "name": "Wine Worker",
                                "value": 12
                            }
                        ]
                    },
                    {
                        "name": "Tea, Coffee and Cocoa Preparers",
                        "children": [
                            {
                                "name": "Coffee Roaster",
                                "value": 1
                            }
                        ]
                    },
                    {
                        "name": "Sugar Processors and Refiners",
                        "children": [
                            {
                                "name": "Sugar Processor or Refiner, Specialisation Unknown",
                                "value": 1
                            }
                        ]
                    }
                ]
            },
            {
                "name": "Chemical Processors and Related Workers",
                "children": [
                    {
                        "name": "Still and Reactor Operators",
                        "children": [
                            {
                                "name": "Still or Reactor Operator, Specialisation Unknown",
                                "value": 37
                            }
                        ]
                    },
                    {
                        "name": "Chemical Processors and Related Workers Not Elsewhere Classified",
                        "children": [
                            {
                                "name": "Other Chemical Processors and Related Workers",
                                "value": 11
                            }
                        ]
                    }
                ]
            },
            {
                "name": "Tailors, Dressmakers, Sewers, Upholsterers and Related Workers",
                "children": [
                    {
                        "name": "Upholsterers and Related Workers",
                        "children": [
                            {
                                "name": "Upholsterer or Related Worker, Specialisation Unknown",
                                "value": 34
                            }
                        ]
                    },
                    {
                        "name": "Tailors and Dressmakers",
                        "children": [
                            {
                                "name": "Tailor, Specialisation Unknown",
                                "value": 28
                            }
                        ]
                    },
                    {
                        "name": "Pattern Makers and Cutters",
                        "children": [
                            {
                                "name": "Glove Cutter, Leather or other material",
                                "value": 15
                            }
                        ]
                    },
                    {
                        "name": "Milliners and Hat Makers",
                        "children": [
                            {
                                "name": "Milliner, General",
                                "value": 4
                            },
                            {
                                "name": "Hat Maker, General",
                                "value": 1
                            }
                        ]
                    },
                    {
                        "name": "Sewers and Embroiderers",
                        "children": [
                            {
                                "name": "Embroiderer, Hand or Machine",
                                "value": 3
                            }
                        ]
                    },
                    {
                        "name": "Tailors, Dressmakers, Sewers, Upholsterers and Related Workers Not Elsewhere Classified",
                        "children": [
                            {
                                "name": "Other Tailors, Dressmakers, Sewers, Upholsterers and Related Workers",
                                "value": 1
                            }
                        ]
                    }
                ]
            },
            {
                "name": "Material Handling and Related Equipment Operators, Dockers and Freight Handlers",
                "children": [
                    {
                        "name": "Dockers and Freight Handlers",
                        "children": [
                            {
                                "name": "Packer, Hand or Machine",
                                "value": 33
                            },
                            {
                                "name": "Warehouse Porter",
                                "value": 15
                            },
                            {
                                "name": "Docker",
                                "value": 4
                            }
                        ]
                    }
                ]
            },
            {
                "name": "Metal Processors",
                "children": [
                    {
                        "name": "Metal Moulders and Coremakers",
                        "children": [
                            {
                                "name": "Other Metal Moulders and Core Makers",
                                "value": 30
                            }
                        ]
                    },
                    {
                        "name": "Metal Casters",
                        "children": [
                            {
                                "name": "Metal Pourer",
                                "value": 14
                            }
                        ]
                    },
                    {
                        "name": "Metal Drawers and Extruders",
                        "children": [
                            {
                                "name": "Wire Drawer (Hand or Machine)",
                                "value": 7
                            }
                        ]
                    },
                    {
                        "name": "Metal Processors Not Elsewhere Classified",
                        "children": [
                            {
                                "name": "Other Metal Processors",
                                "value": 4
                            }
                        ]
                    }
                ]
            },
            {
                "name": "Machinery Fitters, Machine Assemblers and Precision-Instrument Makers (except Electrical)",
                "children": [
                    {
                        "name": "Watch, Clock and Precision Instrument Makers",
                        "children": [
                            {
                                "name": "Watch and Clock Assembler",
                                "value": 26
                            },
                            {
                                "name": "Watch and Clock Assembler or Repairer",
                                "value": 9
                            },
                            {
                                "name": "Optical Instrument Maker and Repairer",
                                "value": 1
                            },
                            {
                                "name": "Precision Instrument Maker",
                                "value": 1
                            }
                        ]
                    },
                    {
                        "name": "Machinery Fitters, Machine Assemblers and Precision Instrument Makers (except Electrical) Not Elsewhere Classified",
                        "children": [
                            {
                                "name": "Other Machinery Fitters, Machine Assemblers and Precision Instrument Makers (except Electrical)",
                                "value": 1
                            }
                        ]
                    }
                ]
            },
            {
                "name": "Blacksmiths, Toolmakers and Machine-Tool Operators",
                "children": [
                    {
                        "name": "Blacksmiths, Toolmakers and Machine-Tool Operators Not Elsewhere Classified",
                        "children": [
                            {
                                "name": "Cutler",
                                "value": 20
                            },
                            {
                                "name": "Gunsmith",
                                "value": 11
                            },
                            {
                                "name": "Other Blacksmiths, Toolmakers and Machine-Tool Operators Not Elsewhere Classified",
                                "value": 7
                            }
                        ]
                    },
                    {
                        "name": "Blacksmiths, Hammersmiths and Forging-Press Operators",
                        "children": [
                            {
                                "name": "Blacksmith, General",
                                "value": 11
                            }
                        ]
                    }
                ]
            },
            {
                "name": "Production and Related Workers Not Elsewhere Classified",
                "children": [
                    {
                        "name": "Other Production and Related Workers",
                        "children": [
                            {
                                "name": "Candle Maker",
                                "value": 18
                            },
                            {
                                "name": "Other Production and Related Workers Not Elsewhere Classified",
                                "value": 7
                            }
                        ]
                    },
                    {
                        "name": "Basketry Weavers and Brush Makers",
                        "children": [
                            {
                                "name": "Basket Maker",
                                "value": 5
                            },
                            {
                                "name": "Wicker Furniture Maker",
                                "value": 1
                            },
                            {
                                "name": "Brush Maker (Hand)",
                                "value": 1
                            }
                        ]
                    },
                    {
                        "name": "Musical Instrument Makers and Tuners",
                        "children": [
                            {
                                "name": "Musical Instrument Maker or Tuner, Specialisation Unknown",
                                "value": 2
                            },
                            {
                                "name": "Metal Wind Instrument Maker",
                                "value": 1
                            }
                        ]
                    }
                ]
            },
            {
                "name": "Shoemakers and Leather Goods Makers",
                "children": [
                    {
                        "name": "Shoemakers and Shoe Repairers",
                        "children": [
                            {
                                "name": "Shoemaker, General",
                                "value": 17
                            },
                            {
                                "name": "Other Shoemakers and Shoe Repairers",
                                "value": 1
                            }
                        ]
                    },
                    {
                        "name": "Leather Goods Makers",
                        "children": [
                            {
                                "name": "Saddler and Harness Maker",
                                "value": 10
                            },
                            {
                                "name": "Leather Goods Maker, General",
                                "value": 8
                            }
                        ]
                    },
                    {
                        "name": "Shoe Cutters, Lasters, Sewers, and Related Workers",
                        "children": [
                            {
                                "name": "Other Shoe Cutters, Lasters, Sewers and Related Workers",
                                "value": 1
                            }
                        ]
                    }
                ]
            },
            {
                "name": "Transport Equipment Operators",
                "children": [
                    {
                        "name": "Ships\u2019 Deck Ratings, Barge Crews and Boatmen",
                        "children": [
                            {
                                "name": "Seaman, Able or Ordinary",
                                "value": 16
                            },
                            {
                                "name": "Other Ships\u2019 Deck Ratings, Barge Crews and Boatmen",
                                "value": 5
                            }
                        ]
                    },
                    {
                        "name": "Animal and Animal-Drawn Vehicle Drivers",
                        "children": [
                            {
                                "name": "Animal-Drawn Vehicle Driver (Road)",
                                "value": 7
                            }
                        ]
                    },
                    {
                        "name": "Transport Equipment Operators Not Elsewhere Classified",
                        "children": [
                            {
                                "name": "Other Transport Equipment Operators",
                                "value": 1
                            }
                        ]
                    }
                ]
            },
            {
                "name": "Plumbers, Welders, Sheet-Metal, and Structural Metal Preparers and Erectors",
                "children": [
                    {
                        "name": "Plumbers and Pipe Fitters",
                        "children": [
                            {
                                "name": "Plumber, General",
                                "value": 15
                            }
                        ]
                    },
                    {
                        "name": "Sheet-metal Workers",
                        "children": [
                            {
                                "name": "Tinsmith",
                                "value": 6
                            }
                        ]
                    }
                ]
            },
            {
                "name": "Tanners, Fellmongers and Pelt Dressers",
                "children": [
                    {
                        "name": "Tanners and Fellmongers",
                        "children": [
                            {
                                "name": "Leather Currier",
                                "value": 13
                            },
                            {
                                "name": "Hide Flesher and Dehairer (Hand)",
                                "value": 12
                            },
                            {
                                "name": "Tanners or Fellmonger, Specialisation Unknown",
                                "value": 2
                            }
                        ]
                    }
                ]
            },
            {
                "name": "Painters",
                "children": [
                    {
                        "name": "Painters, Construction",
                        "children": [
                            {
                                "name": "Building Painter",
                                "value": 12
                            },
                            {
                                "name": "Other Painters, Construction",
                                "value": 1
                            }
                        ]
                    },
                    {
                        "name": "Painters Not Elsewhere Classified",
                        "children": [
                            {
                                "name": "Brush-Painter (except Construction)",
                                "value": 4
                            }
                        ]
                    }
                ]
            },
            {
                "name": "Printers and Related Workers",
                "children": [
                    {
                        "name": "Compositors and Type-Setters",
                        "children": [
                            {
                                "name": "Printer, General",
                                "value": 3
                            }
                        ]
                    },
                    {
                        "name": "Printing Engravers (except Photo-Engravers)",
                        "children": [
                            {
                                "name": "Other Printing Engravers (except Photo-Engravers)",
                                "value": 3
                            }
                        ]
                    },
                    {
                        "name": "Printers and Related Workers Not Elsewhere Classified",
                        "children": [
                            {
                                "name": "Other Printers and Related Workers",
                                "value": 1
                            },
                            {
                                "name": "Textile Printer",
                                "value": 1
                            }
                        ]
                    },
                    {
                        "name": "Bookbinders and Related Workers",
                        "children": [
                            {
                                "name": "Bookbinder (Hand or Machine)",
                                "value": 1
                            }
                        ]
                    }
                ]
            },
            {
                "name": "Wood Preparation Workers and Paper Makers",
                "children": [
                    {
                        "name": "Sawyers, Plywood Makers and Related Wood-Processing Workers",
                        "children": [
                            {
                                "name": "Sawyer, General",
                                "value": 2
                            },
                            {
                                "name": "Other Sawyer, Plywood Makers and Related Wood-Processing Workers",
                                "value": 1
                            }
                        ]
                    },
                    {
                        "name": "Paper Makers",
                        "children": [
                            {
                                "name": "Other Paper Makers",
                                "value": 1
                            }
                        ]
                    }
                ]
            },
            {
                "name": "Glass Formers, Potters and Related Workers",
                "children": [
                    {
                        "name": "Potters and Related Clay and Abrasive Formers",
                        "children": [
                            {
                                "name": "Potter, General",
                                "value": 1
                            }
                        ]
                    }
                ]
            },
            {
                "name": "Workers Not Elsewhere Classified",
                "children": [
                    {
                        "name": "Workers Not Elsewhere Classified",
                        "children": [
                            {
                                "name": "Labourer",
                                "value": 1
                            }
                        ]
                    }
                ]
            }
        ]
    },
    {
        "name": "Sales workers",
        "children": [
            {
                "name": "Working Proprietors (Wholesale and Retail Trade)",
                "children": [
                    {
                        "name": "Working Proprietors (Wholesale and Retail Trade)",
                        "children": [
                            {
                                "name": "Working Proprietor (Wholesale or Retail Trade)",
                                "value": 310
                            }
                        ]
                    }
                ]
            },
            {
                "name": "Insurance Real Estate, Securities and Business Services Salesmen and Auctioneers",
                "children": [
                    {
                        "name": "Insurance, Real Estate and Securities Salesmen",
                        "children": [
                            {
                                "name": "Stock Broker",
                                "value": 12
                            }
                        ]
                    }
                ]
            },
            {
                "name": "Salesmen, Shop Assistants and Related Workers",
                "children": [
                    {
                        "name": "Salesmen, Shop Assistants and Demonstrators",
                        "children": [
                            {
                                "name": "Salesperson, Wholesale or Retail Trade",
                                "value": 8
                            }
                        ]
                    },
                    {
                        "name": "Street Vendors, Canvassers and News Vendors",
                        "children": [
                            {
                                "name": "Other Street Vendors, Canvassers and News Vendors",
                                "value": 1
                            }
                        ]
                    }
                ]
            },
            {
                "name": "Sales Workers Not Elsewhere Classified",
                "children": [
                    {
                        "name": "Sales Workers Not Elsewhere Classified",
                        "children": [
                            {
                                "name": "Pawnbroker",
                                "value": 1
                            }
                        ]
                    }
                ]
            }
        ]
    },
    {
        "name": "Professional, technical and related workers",
        "children": [
            {
                "name": "Medical, Dental, Veterinary and Related Workers",
                "children": [
                    {
                        "name": "Pharmacists",
                        "children": [
                            {
                                "name": "Pharmacist",
                                "value": 64
                            }
                        ]
                    },
                    {
                        "name": "Medical Doctors",
                        "children": [
                            {
                                "name": "General Surgeon",
                                "value": 31
                            },
                            {
                                "name": "Medical Doctor, Specialisation Unknown",
                                "value": 9
                            },
                            {
                                "name": "General Physician",
                                "value": 2
                            }
                        ]
                    }
                ]
            },
            {
                "name": "Authors, Journalists and Related Writers",
                "children": [
                    {
                        "name": "Authors, Journalists and Related Writers Not Elsewhere Classified",
                        "children": [
                            {
                                "name": "Author, Journalist or Related Writer, Specialisation Unknown",
                                "value": 10
                            }
                        ]
                    }
                ]
            },
            {
                "name": "Sculptors, Painters, Photographers and Related Creative Artists",
                "children": [
                    {
                        "name": "Sculptors, Painters and Related Artists",
                        "children": [
                            {
                                "name": "Painter, Artist",
                                "value": 8
                            }
                        ]
                    }
                ]
            },
            {
                "name": "Jurists",
                "children": [
                    {
                        "name": "Lawyers",
                        "children": [
                            {
                                "name": "Lawyer",
                                "value": 6
                            }
                        ]
                    },
                    {
                        "name": "Notaries",
                        "children": [
                            {
                                "name": "Notary",
                                "value": 5
                            }
                        ]
                    },
                    {
                        "name": "Jurists, Specialization Unknown",
                        "children": [
                            {
                                "name": "Jurist, Specialization Unknown",
                                "value": 2
                            }
                        ]
                    },
                    {
                        "name": "Jurists Not Elsewhere Classified",
                        "children": [
                            {
                                "name": "Jurist (except Lawyer, Judge or Solicitor)",
                                "value": 1
                            }
                        ]
                    }
                ]
            },
            {
                "name": "Physical Scientists and Related Technicians",
                "children": [
                    {
                        "name": "Physicists",
                        "children": [
                            {
                                "name": "Physicist, General",
                                "value": 5
                            }
                        ]
                    }
                ]
            },
            {
                "name": "Teachers",
                "children": [
                    {
                        "name": "Teachers Not Elsewhere Classified",
                        "children": [
                            {
                                "name": "Head Teacher",
                                "value": 3
                            }
                        ]
                    }
                ]
            },
            {
                "name": "Workers in Religion",
                "children": [
                    {
                        "name": "Workers in Religion Not Elsewhere Classified",
                        "children": [
                            {
                                "name": "Other Workers in Religion",
                                "value": 2
                            }
                        ]
                    },
                    {
                        "name": "Ministers of Religion and Related Members of Religious Orders",
                        "children": [
                            {
                                "name": "Minister of Religion",
                                "value": 1
                            }
                        ]
                    }
                ]
            },
            {
                "name": "Statisticians, Mathematicians, Systems Analysts and Related Technicians",
                "children": [
                    {
                        "name": "Mathematicians and Actuaries",
                        "children": [
                            {
                                "name": "Mathematician (Pure Mathematics)",
                                "value": 1
                            }
                        ]
                    }
                ]
            },
            {
                "name": "Composers and Performing Artists",
                "children": [
                    {
                        "name": "Composers, Musicians and Singers",
                        "children": [
                            {
                                "name": "Instrumentalist",
                                "value": 1
                            }
                        ]
                    },
                    {
                        "name": "Composers and Performing Artists, Specialisation Unknown",
                        "children": [
                            {
                                "name": "Composer or Performing Artist, Specialisation Unknown",
                                "value": 1
                            }
                        ]
                    },
                    {
                        "name": "Choreographers and Dancers",
                        "children": [
                            {
                                "name": "Dancer",
                                "value": 1
                            }
                        ]
                    }
                ]
            }
        ]
    },
    {
        "name": "Service Workers",
        "children": [
            {
                "name": "Hairdressers, Barbers, Beauticians and Related Workers",
                "children": [
                    {
                        "name": "Hairdresser, Barbers, Beauticians and Related Workers",
                        "children": [
                            {
                                "name": "Barber Hairdresser",
                                "value": 32
                            }
                        ]
                    }
                ]
            },
            {
                "name": "Maids and Related Housekeeping Service Workers Not Elsewhere Classified",
                "children": [
                    {
                        "name": "Maids and Related Housekeeping Service Workers Not Elsewhere Classified",
                        "children": [
                            {
                                "name": "Domestic servant, general",
                                "value": 25
                            }
                        ]
                    }
                ]
            },
            {
                "name": "Working Proprietors (Catering, Lodging and Leisure Services)",
                "children": [
                    {
                        "name": "Working Proprietors (Catering, Lodging and Leisure Services)",
                        "children": [
                            {
                                "name": "Working Proprietor (Hotel and Restaurant)",
                                "value": 24
                            },
                            {
                                "name": "Working Proprietor (Café, Bar and Snack Bar)",
                                "value": 1
                            }
                        ]
                    }
                ]
            },
            {
                "name": "Cooks, Waiters, Bartenders and Related Workers",
                "children": [
                    {
                        "name": "Cooks",
                        "children": [
                            {
                                "name": "Cook, Specialisation Unknown",
                                "value": 17
                            }
                        ]
                    }
                ]
            },
            {
                "name": "Protective Service Workers",
                "children": [
                    {
                        "name": "Military",
                        "children": [
                            {
                                "name": "Officer",
                                "value": 14
                            }
                        ]
                    }
                ]
            },
            {
                "name": "Launderers, Dry-Cleaners and Pressers",
                "children": [
                    {
                        "name": "Launderers, Dry-Cleaners and Pressers",
                        "children": [
                            {
                                "name": "Laundry Pressing Machine-Operator",
                                "value": 1
                            }
                        ]
                    }
                ]
            }
        ]
    },
    {
        "name": "Clerical and related workers",
        "children": [
            {
                "name": "Clerical and Related Workers, Specialisation Unknown",
                "children": [
                    {
                        "name": "Clerical and Related Workers, Specialisation Unknown",
                        "children": [
                            {
                                "name": "Clerical or Related Worker, Specialisation Unknown",
                                "value": 18
                            }
                        ]
                    }
                ]
            },
            {
                "name": "Mail Distribution Clerks",
                "children": [
                    {
                        "name": "Mail Distribution Clerks",
                        "children": [
                            {
                                "name": "Messenger",
                                "value": 3
                            }
                        ]
                    }
                ]
            },
            {
                "name": "Bookkeepers, Cashiers and Related Workers",
                "children": [
                    {
                        "name": "Bookkeepers and Cashiers",
                        "children": [
                            {
                                "name": "Cashier, Office or Cash Desk",
                                "value": 1
                            },
                            {
                                "name": "Bookkeeper, General",
                                "value": 1
                            }
                        ]
                    }
                ]
            }
        ]
    },
    {
        "name": "Agricultural, animal husbandry and forestry workers, fishermen and hunters",
        "children": [
            {
                "name": "Farmers",
                "children": [
                    {
                        "name": "General Farmers",
                        "children": [
                            {
                                "name": "General Farmer",
                                "value": 15
                            }
                        ]
                    }
                ]
            },
            {
                "name": "Agricultural and Animal Husbandry Workers",
                "children": [
                    {
                        "name": "Nursery Workers and Gardeners",
                        "children": [
                            {
                                "name": "Gardener",
                                "value": 2
                            }
                        ]
                    }
                ]
            },
            {
                "name": "Fishermen, Hunters and Related Workers",
                "children": [
                    {
                        "name": "Fishermen",
                        "children": [
                            {
                                "name": "Fisherman, Deep-Sea or Inland and Coastal Water",
                                "value": 1
                            }
                        ]
                    }
                ]
            }
        ]
    },
    {
        "name": "Administrative and managerial workers",
        "children": [
            {
                "name": "Supervisors, Foremen and Inspectors",
                "children": [
                    {
                        "name": "Housekeeping and Related Service Supervisors",
                        "children": [
                            {
                                "name": "Housekeeper (Private Service, in Hotels, or in Other Institutions)",
                                "value": 1
                            }
                        ]
                    },
                    {
                        "name": "Transport and Communications Supervisors",
                        "children": [
                            {
                                "name": "Other Transport and Communications Supervisors",
                                "value": 1
                            }
                        ]
                    }
                ]
            },
            {
                "name": "Managers",
                "children": [
                    {
                        "name": "Managers (Catering and Lodging Services)",
                        "children": [
                            {
                                "name": "Ships Purser",
                                "value": 1
                            }
                        ]
                    }
                ]
            }
        ]
    }
];
option = {
	title: {
		text: 'OOA Occupations',
		textStyle: {
			fontSize: 14,
			align: 'center'
		},
	},
	visualMap: {
		type: 'continuous',
		min: 0,
		max: 1000,
		inRange: {
			color: ['#2D5F73', '#538EA6', '#F2D1B3', '#F2B8A2', '#F28C8C']
		}
	},
	series: {
		type: 'sunburst',
		data: data,
		highlightPolicy: 'self',
		radius: [20, '90%'],
		label: {
			rotate: 'left'
		},
		downplay: {
			label: {show: false},
		},
		highlight: {
			label: {show: true},
		}
	}
};

myChart.setOption(option);
});
		</script>
    </xsl:template>
</xsl:stylesheet>
