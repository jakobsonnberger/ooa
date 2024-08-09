<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs" version="2.0">
    <!--
               1: HISCO_Unit_Nr
               2: HISCO_Unit_Name
               3: HISCO_Unit_group_Nr
               4: HISCO_Unit_group_Name
               5: HISCO_Minor_group_Nr
               6: HISCO_Minor_group_Name
               7: HISCOM_ajor_group_Nr
               8: HISCO_Major_group_Name
               9: OOA_Label
-->
    <xsl:template match="XML">
        <XML>
            <xsl:for-each select="row">
                <entry>
                    <xsl:for-each select="cell[1]">
                        <HISCO_Unit_Nr>
                            <xsl:value-of select="."/>
                        </HISCO_Unit_Nr>
                    </xsl:for-each>
                    <xsl:for-each select="cell[2]">
                        <HISCO_Unit_Name>
                            <xsl:value-of select="."/>
                        </HISCO_Unit_Name>
                    </xsl:for-each>
                    <xsl:for-each select="cell[3]">
                        <HISCO_Unit_group_Nr>
                            <xsl:value-of select="."/>
                        </HISCO_Unit_group_Nr>
                    </xsl:for-each>
                    <xsl:for-each select="cell[4]">
                        <HISCO_Unit_group_Name>
                            <xsl:value-of select="."/>
                        </HISCO_Unit_group_Name>
                    </xsl:for-each>
                    <xsl:for-each select="cell[5]">
                        <HISCO_Minor_group_Nr>
                            <xsl:value-of select="."/>
                        </HISCO_Minor_group_Nr>
                    </xsl:for-each>
                    <xsl:for-each select="cell[6]">
                        <HISCO_Minor_group_Name>
                            <xsl:value-of select="."/>
                        </HISCO_Minor_group_Name>
                    </xsl:for-each>
                    <xsl:for-each select="cell[7]">
                        <HISCO_Major_group_Nr>
                            <xsl:value-of select="."/>
                        </HISCO_Major_group_Nr>
                    </xsl:for-each>
                    <xsl:for-each select="cell[8]">
                        <HISCO_Major_group_Name>
                            <xsl:value-of select="."/>
                        </HISCO_Major_group_Name>
                    </xsl:for-each>
                    <xsl:for-each select="cell[9]">
                        <OOA_Occupation>
                            <xsl:value-of select="."/>
                        </OOA_Occupation>
                    </xsl:for-each>
                </entry>
            </xsl:for-each>
        </XML>
    </xsl:template>
</xsl:stylesheet>
