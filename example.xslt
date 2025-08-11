<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:che="http://www.geocat.ch/2008/che"
    xmlns:gmd="http://www.isotc211.org/2005/gmd"
    xmlns:gco="http://www.isotc211.org/2005/gco">

    <!-- === RESSOURCES EXTERNES === -->
    <xsl:variable name="label" select="document('root/schemas/iso19139/labels.xml')"/>
    <xsl:variable name="codelists" select="document('root/schemas/iso19139/codelists.xml')"/>

    <!-- === FONCTIONS UTILITAIRES === -->
    <xsl:template name="formatDate">
        <xsl:param name="date"/>
        <xsl:value-of select="concat(substring($date,9,2),'.',substring($date,6,2),'.',substring($date,1,4))"/>
    </xsl:template>

    <xsl:template name="label">
        <xsl:param name="elementName"/>
        <xsl:param name="elementId" select="''"/>
        <xsl:choose>
            <xsl:when test="$elementId != ''">
                <xsl:value-of select="($label//element[@name=$elementName and @id=$elementId]/label)[1]"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="($label//element[@name=$elementName]/label)[1]"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <!-- === TEMPLATE PRINCIPAL === -->
    <xsl:template match="che:CHE_MD_Metadata">

        <!-- === VARIABLES === -->
        <!-- Identifiants et URLs -->
        <xsl:variable name="identifier" select="gmd:fileIdentifier/gco:CharacterString"/>
        <xsl:variable name="urlBase" select="'https://www.geocat.ch/geonetwork/srv/api/records/'"/>
        <xsl:variable name="urlSimple" select="concat($urlBase, $identifier, '/formatters/vs_simple_fr?language=fre')"/>
        <xsl:variable name="urlFull" select="concat($urlBase, $identifier, '/formatters/vs_full_fr?language=fre')"/>
        <xsl:variable name="urlPDF" select="concat($urlBase, $identifier, '/formatters/vs_simple_fr?width=_100&amp;mdpath=md.format.pdf&amp;output=pdf&amp;approved=true')"/>

        <!-- Métadonnées de base -->
        <xsl:variable name="citationTitle" select=".//gmd:citation/gmd:CI_Citation/gmd:title/gmd:PT_FreeText/gmd:textGroup/gmd:LocalisedCharacterString[@locale='#FR']"/>
        <xsl:variable name="abstractFR" select=".//gmd:abstract/gmd:PT_FreeText/gmd:textGroup/gmd:LocalisedCharacterString[@locale='#FR']"/>
        <xsl:variable name="thumbnail" select=".//gmd:graphicOverview/gmd:MD_BrowseGraphic/gmd:fileName/gco:CharacterString"/>

        <!-- Statut -->
        <xsl:variable name="statusCode" select=".//gmd:status/gmd:MD_ProgressCode/@codeListValue"/>
        <xsl:variable name="statusLabel" select="$codelists//codelist[@name='gmd:MD_ProgressCode']/entry[code=$statusCode]/label"/>

        <!-- Dates -->
        <xsl:variable name="creationDate" select=".//gmd:date/gmd:CI_Date[gmd:dateType/gmd:CI_DateTypeCode/@codeListValue='creation']/gmd:date/gco:Date"/>
        <xsl:variable name="creationLabel" select="$codelists//codelist[@name='gmd:CI_DateTypeCode']/entry[code='creation']/label"/>
        <xsl:variable name="revisionDate" select=".//gmd:date/gmd:CI_Date[gmd:dateType/gmd:CI_DateTypeCode/@codeListValue='revision']/gmd:date/gco:Date"/>
        <xsl:variable name="revisionLabel" select="$codelists//codelist[@name='gmd:CI_DateTypeCode']/entry[code='revision']/label"/>

        <!-- Contact -->
        <xsl:variable name="custodian" select="$codelists//codelist[@name='gmd:CI_RoleCode']/entry[code='custodian']/label"/>
        <xsl:variable name="orgName" select="substring-before(.//gmd:organisationName/gmd:PT_FreeText/gmd:textGroup/gmd:LocalisedCharacterString[@locale='#FR'], ' - ')"/>
        <xsl:variable name="orgAcronym" select=".//gmd:citedResponsibleParty/che:CHE_CI_ResponsibleParty/che:organisationAcronym/gmd:PT_FreeText/gmd:textGroup/gmd:LocalisedCharacterString[@locale='#FR']"/>
        <xsl:variable name="streetName" select=".//che:CHE_MD_DataIdentification/gmd:pointOfContact/che:CHE_CI_ResponsibleParty/gmd:contactInfo/gmd:CI_Contact/gmd:address/che:CHE_CI_Address/che:streetName/gco:CharacterString"/>
        <xsl:variable name="streetNumber" select=".//che:CHE_MD_DataIdentification/gmd:pointOfContact/che:CHE_CI_ResponsibleParty/gmd:contactInfo/gmd:CI_Contact/gmd:address/che:CHE_CI_Address/che:streetNumber/gco:CharacterString"/>
        <xsl:variable name="postalCode" select=".//che:CHE_MD_DataIdentification/gmd:pointOfContact/che:CHE_CI_ResponsibleParty/gmd:contactInfo/gmd:CI_Contact/gmd:address/che:CHE_CI_Address/gmd:postalCode/gco:CharacterString"/>
        <xsl:variable name="city" select=".//che:CHE_MD_DataIdentification/gmd:pointOfContact/che:CHE_CI_ResponsibleParty/gmd:contactInfo/gmd:CI_Contact/gmd:address/che:CHE_CI_Address/gmd:city/gco:CharacterString"/>
        <xsl:variable name="phone" select=".//che:CHE_MD_DataIdentification/gmd:pointOfContact/che:CHE_CI_ResponsibleParty/gmd:contactInfo/gmd:CI_Contact/gmd:phone/che:CHE_CI_Telephone/gmd:voice/gco:CharacterString"/>
        <xsl:variable name="website" select=".//che:CHE_MD_DataIdentification/gmd:pointOfContact/che:CHE_CI_ResponsibleParty/gmd:contactInfo/gmd:CI_Contact/gmd:onlineResource/gmd:CI_OnlineResource/gmd:linkage/gmd:URL"/>
        <xsl:variable name="email" select=".//che:CHE_MD_DataIdentification/gmd:pointOfContact/che:CHE_CI_ResponsibleParty/gmd:contactInfo/gmd:CI_Contact/gmd:address/che:CHE_CI_Address/gmd:electronicMailAddress/gco:CharacterString"/>

        <!-- === HTML === -->
        <html>
            <head>
                <title>Canton du Valais - Catalogue de métadonnées</title>
                <!-- <link rel="stylesheet" href="style.css"/> -->
            </head>
            <body>
                <header class="header">
                    <div class="logo">
                        <a href="http://www.vs.ch" target="_blank">
                            <img src="https://www.vs.ch/documents/17311/1860458/logoVS78px/f406b530-5ee3-40b0-9c1e-00069d011f89?t=1462889171734" alt="Logo VS"/>
                        </a>
                        <a href="https://www.geocat.ch/geonetwork/srv/fre/md.viewer#/full_view/{$identifier}" target="_blank">
                            <img src="https://www.vs.ch/documents/17311/472429/logo_geocat" alt="Logo GeoCat"/>
                        </a>
                    </div>
                    <h1>Catalogue métadonnées - Simple</h1>
                </header>

                <nav class="nav-links">
                    <a href="{$urlPDF}" target="_blank">Imprimer</a>
                    <span>Présentation :</span>
                    <a href="{$urlSimple}" target="_self">Simple</a> /
                    <a href="{$urlFull}" target="_self">Complète</a>
                </nav>

                <section class="metadata-title">
                    <h2><xsl:value-of select="$citationTitle"/></h2>
                </section>

                <section class="metadata-thumbnail">
                    <img src="{$thumbnail}" alt="Aperçu graphique"/>
                </section>

                <section class="metadata-abstract">
                    <h3>
                        <xsl:call-template name="label">
                            <xsl:with-param name="elementName" select="'gmd:abstract'"/>
                        </xsl:call-template>
                    </h3>
                    <p><xsl:value-of select="$abstractFR"/></p>
                </section>

                <section class="metadata-status">
                    <h3>
                        <xsl:call-template name="label">
                            <xsl:with-param name="elementName" select="'gmd:status'"/>
                        </xsl:call-template>
                    </h3>
                    <p><xsl:value-of select="string($statusLabel | $statusCode)"/></p>
                </section>

                <section class="metadata-dates">
                    <xsl:if test="$creationDate">
                        <p>
                            <xsl:value-of select="$creationLabel"/>:
                            <xsl:text> </xsl:text>
                            <xsl:call-template name="formatDate">
                                <xsl:with-param name="date" select="$creationDate"/>
                            </xsl:call-template>
                        </p>
                    </xsl:if>
                    <xsl:if test="$revisionDate">
                        <p>
                            <xsl:value-of select="$revisionLabel"/>:
                            <xsl:text> </xsl:text>
                            <xsl:call-template name="formatDate">
                                <xsl:with-param name="date" select="$revisionDate"/>
                            </xsl:call-template>
                        </p>
                    </xsl:if>
                </section>

                <section class="metadata-contact">
                    <h3>
                        <xsl:call-template name="label">
                            <xsl:with-param name="elementName" select="'gmd:identificationInfo'"/>
                        </xsl:call-template>
                    </h3>
                    <p class="contact-role"><xsl:value-of select="$custodian"/></p>
                    <p class="contact-aconym"><xsl:value-of select="$orgAcronym"/></p>
                    <p class="contact-address">
                        <xsl:value-of select="$streetName"/>
                        <xsl:text> </xsl:text>
                        <xsl:value-of select="$streetNumber"/><br/>
                        <xsl:value-of select="$postalCode"/>
                        <xsl:text> </xsl:text>
                        <xsl:value-of select="$city"/>
                    </p>
                    <p class="contact-phone"><xsl:value-of select="$phone"/></p>
                    <p class="contact-website">
                        <a href="{$website}"><xsl:value-of select="$website"/></a>
                    </p>
                    <p class="contact-email">
                        <a href="mailto:{$email}"><xsl:value-of select="$email"/></a>
                    </p>
                </section>
            </body>
        </html>
    </xsl:template>
</xsl:stylesheet>