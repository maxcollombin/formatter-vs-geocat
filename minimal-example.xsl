<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:che="http://www.geocat.ch/2008/che"
    xmlns:gmd="http://www.isotc211.org/2005/gmd"
    xmlns:gco="http://www.isotc211.org/2005/gco">
    <!-- Point d’entrée -->
    <xsl:template match="/">
        <xsl:apply-templates select="//che:CHE_MD_Metadata"/>
    </xsl:template>
    <!-- Contenu HTML -->
    <xsl:template match="che:CHE_MD_Metadata">
        <html>
            <head>
                <meta http-equiv="expires" content="0"/>
                <title>Canton du Valais - Catalogue de métadonnées</title>
            </head>
            <body>
                <xsl:variable name="citationTitle"
                    select=".//gmd:citation/gmd:CI_Citation/gmd:title/gmd:PT_FreeText/
                            gmd:textGroup/gmd:LocalisedCharacterString[@locale='#FR']"/>
                <h1>
                    <xsl:value-of select="$citationTitle"/>
                </h1>
            </body>
        </html>
    </xsl:template>
</xsl:stylesheet>
