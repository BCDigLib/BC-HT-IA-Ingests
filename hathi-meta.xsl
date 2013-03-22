<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    version="1.0">
  <xsl:output method="text"/>
    
    <xsl:template match="/records">
        <xsl:apply-templates select="metadata"/>
        
        
    </xsl:template>
    
    <xsl:template match="metadata">
        <xsl:value-of select="call_number"/><xsl:text>BCL01|</xsl:text>
        <xsl:value-of select="identifier"/><xsl:text>|</xsl:text>
        <xsl:value-of select="identifier-ark"/><xsl:text>|</xsl:text>
        <xsl:value-of select="identifier-access"/><xsl:text>|</xsl:text>
        <xsl:value-of select="volume"/><xsl:text>|</xsl:text>
        <xsl:value-of select="title"/><xsl:text>&#10;</xsl:text>
    </xsl:template>
    
</xsl:stylesheet>