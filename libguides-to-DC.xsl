<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:oai_dc="http://www.openarchives.org/OAI/2.0/oai_dc/"
    xmlns:dc="http://purl.org/dc/elements/1.1/"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    exclude-result-prefixes="xs"
    version="2.0">
    
    <!-- convert libguides export to oai_dc -->
    
    <xsl:output method="xml" indent="yes"/>
    
    <xsl:template match="/">
        <xsl:apply-templates/>
    </xsl:template>
    
    <xsl:template match="libguides">
        <xsl:apply-templates select="guides"/>
    </xsl:template>
    
    <xsl:template match="guides">
        <xsl:apply-templates select="guide"/>
    </xsl:template>
    
    <xsl:template match="guide">
        <xsl:choose>
            <xsl:when test="status = 'Published'
                and description != ''
                and url != ''">
                <xsl:call-template name="createDC"/>
            </xsl:when>
        </xsl:choose>
    </xsl:template>
    
    <xsl:template name="createDC">
        <xsl:variable name="vGuideName" select="id"/>
        <xsl:result-document href="output/{concat($vGuideName, '_oai_dc.xml')}">
            <oai_dc:dc xsi:schemaLocation="http://www.openarchives.org/OAI/2.0/oai_dc/ http://www.openarchives.org/OAI/2.0/oai_dc.xsd">
                <xsl:apply-templates select="name, url, description, owner, tags"/>
                <dc:publisher>The University of Tennessee Libraries, Knoxville</dc:publisher>
                <dc:type>text</dc:type>
                <dc:type>interactive</dc:type>
                <dc:format>text/HTML</dc:format>
            </oai_dc:dc>
        </xsl:result-document>
    </xsl:template>
    
    <xsl:template match="name">
        <dc:title><xsl:apply-templates/></dc:title>
    </xsl:template>
    
    <xsl:template match="url">
        <dc:identifier><xsl:apply-templates/></dc:identifier>
    </xsl:template>
    
    <xsl:template match="description">
        <dc:description><xsl:apply-templates/></dc:description>
    </xsl:template>
    
    <xsl:template match="owner">
        <xsl:variable name="vOwnerName" select="concat(first_name, ' ', last_name)"/>
        <dc:creator><xsl:value-of select="$vOwnerName"/></dc:creator>
    </xsl:template>
    
    <!-- creates a duplicated dc:subject vis-a-vie subject to tags -->
    <!--<xsl:template match="subjects">
    <xsl:for-each select="subject">
      <dc:subject><xsl:value-of select="name"/></dc:subject>
    </xsl:for-each>  
  </xsl:template>-->
    
    <xsl:template match="tags">
        <xsl:for-each select="tag">
            <dc:subject>
                <xsl:value-of select="normalize-space(name)"/>
            </dc:subject>
        </xsl:for-each>
    </xsl:template>
</xsl:stylesheet>