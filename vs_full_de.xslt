<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:che="http://www.geocat.ch/2008/che"
    xmlns:gmd="http://www.isotc211.org/2005/gmd"
    xmlns:gco="http://www.isotc211.org/2005/gco">

    <!-- === Templates utilitaires === -->
    <xsl:template name="formatDate">
        <xsl:param name="date"/>
        <xsl:choose>
            <!-- Date au format YYYY-MM-DD (10 caractères) -->
            <xsl:when test="string-length($date) = 10">
                <xsl:value-of select="concat(substring($date,9,2),'.',substring($date,6,2),'.',substring($date,1,4))"/>
            </xsl:when>
            <!-- DateTime (plus de 10 caractères) -->
            <xsl:when test="string-length($date) > 10">
                <xsl:variable name="dateOnly" select="substring($date,1,10)"/>
                <xsl:value-of select="concat(substring($dateOnly,9,2),'.',substring($dateOnly,6,2),'.',substring($dateOnly,1,4))"/>
            </xsl:when>
        </xsl:choose>
    </xsl:template>    <xsl:template name="getStatus">
        <xsl:param name="statusCode"/>
        <xsl:choose>
            <xsl:when test="$statusCode = 'onGoing'">Kontinuierliche Aktualisierung</xsl:when>
            <xsl:when test="$statusCode = 'completed'">Abgeschlossen</xsl:when>
            <xsl:when test="$statusCode = 'underDevelopment'">In Erstellung</xsl:when>
            <xsl:when test="$statusCode = 'planned'">Geplant</xsl:when>
            <xsl:when test="$statusCode = 'required'">Erforderlich</xsl:when>
            <xsl:when test="$statusCode = 'obsolete'">Veraltet</xsl:when>
            <xsl:when test="$statusCode = 'historicalArchive'">Historisches Archiv</xsl:when>
            <xsl:otherwise><xsl:value-of select="$statusCode"/></xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <!-- Langues -->
    <xsl:template name="getLanguageLabel">
        <xsl:param name="languageCode"/>
        <xsl:choose>
            <xsl:when test="$languageCode = 'fre'">Französisch</xsl:when>
            <xsl:when test="$languageCode = 'ger'">Deutsch</xsl:when>
            <xsl:when test="$languageCode = 'ita'">Italienisch</xsl:when>
            <xsl:when test="$languageCode = 'eng'">Englisch</xsl:when>
            <xsl:when test="$languageCode = 'roh'">Romanisch</xsl:when>
            <xsl:otherwise><xsl:value-of select="$languageCode"/></xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <!-- Thématiques -->
    <xsl:template name="getTopicCategoryLabel">
        <xsl:param name="topicCode"/>
        <xsl:choose>
            <xsl:when test="$topicCode = 'imageryBaseMapsEarthCover'">A Basiskarten, Bodenbedeckung, Bilddaten</xsl:when>
            <xsl:when test="$topicCode = 'imageryBaseMapsEarthCover_BaseMaps'">A1 Basiskarten, Landschaftsmodelle</xsl:when>
            <xsl:when test="$topicCode = 'imageryBaseMapsEarthCover_EarthCover'">A2 Bodenbedeckung, Bodennutzung</xsl:when>
            <xsl:when test="$topicCode = 'imageryBaseMapsEarthCover_Imagery'">A3 Luft-, Satellitenbilder</xsl:when>
            <xsl:when test="$topicCode = 'location'">B Ortsangaben, Referenzsysteme</xsl:when>
            <xsl:when test="$topicCode = 'elevation'">C Höhen</xsl:when>
            <xsl:when test="$topicCode = 'boundaries'">D Politische und administrative Grenzen</xsl:when>
            <xsl:when test="$topicCode = 'planningCadastre'">E Raumplanung, Grundstückskataster</xsl:when>
            <xsl:when test="$topicCode = 'planningCadastre_Planning'">E1 Raumplanung, Raumentwicklung</xsl:when>
            <xsl:when test="$topicCode = 'planningCadastre_Cadastre'">E2 Grundstückskataster</xsl:when>
            <xsl:when test="$topicCode = 'geoscientificInformation'">F Geologie, Böden, naturbedingte Risiken</xsl:when>
            <xsl:when test="$topicCode = 'geoscientificInformation_Geology'">F1 Geologie</xsl:when>
            <xsl:when test="$topicCode = 'geoscientificInformation_Soils'">F2 Böden</xsl:when>
            <xsl:when test="$topicCode = 'geoscientificInformation_NaturalHazards'">F3 Naturbedingte Risiken</xsl:when>
            <xsl:when test="$topicCode = 'biota'">G Wald, Flora, Fauna</xsl:when>
            <xsl:when test="$topicCode = 'oceans'">H Meere</xsl:when>
            <xsl:when test="$topicCode = 'inlandWaters'">I Gewässer</xsl:when>
            <xsl:when test="$topicCode = 'climatologyMeteorologyAtmosphere'">K Atmosphäre, Luft, Klima</xsl:when>
            <xsl:when test="$topicCode = 'environment'">L Umwelt-, Naturschutz</xsl:when>
            <xsl:when test="$topicCode = 'environment_EnvironmentalProtection'">L1 Umweltschutz, Lärm</xsl:when>
            <xsl:when test="$topicCode = 'environment_NatureProtection'">L2 Natur- und Landschaftsschutz</xsl:when>
            <xsl:when test="$topicCode = 'society'">M Bevölkerung, Gesellschaft, Kultur</xsl:when>
            <xsl:when test="$topicCode = 'health'">N Gesundheit</xsl:when>
            <xsl:when test="$topicCode = 'structure'">O Gebäude, Anlagen</xsl:when>
            <xsl:when test="$topicCode = 'transportation'">P Verkehr</xsl:when>
            <xsl:when test="$topicCode = 'utilitiesCommunication'">Q Ver-, Entsorgung, Kommunikation</xsl:when>
            <xsl:when test="$topicCode = 'utilitiesCommunication_Energy'">Q1 Energie</xsl:when>
            <xsl:when test="$topicCode = 'utilitiesCommunication_Utilities'">Q2 Wasser- und Abfallsysteme</xsl:when>
            <xsl:when test="$topicCode = 'utilitiesCommunication_Communication'">Q3 Kommunikation</xsl:when>
            <xsl:when test="$topicCode = 'intelligenceMilitary'">R Militär, Sicherheit</xsl:when>
            <xsl:when test="$topicCode = 'farming'">S Landwirtschaft</xsl:when>
            <xsl:when test="$topicCode = 'economy'">T Wirtschaftliche Aktivitäten</xsl:when>
            <xsl:otherwise><xsl:value-of select="$topicCode"/></xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <!-- Type de représentation spatiale -->
    <xsl:template name="getSpatialRepresentationTypeLabel">
        <xsl:param name="spatialType"/>
        <xsl:choose>
            <xsl:when test="$spatialType = 'vector'">Vektor</xsl:when>
            <xsl:when test="$spatialType = 'grid'">Raster</xsl:when>
            <xsl:when test="$spatialType = 'textTable'">Tabellar</xsl:when>
            <xsl:when test="$spatialType = 'tin'">TIN</xsl:when>
            <xsl:when test="$spatialType = 'stereoModel'">Stereoskopisches Modell</xsl:when>
            <xsl:when test="$spatialType = 'video'">Video</xsl:when>
            <xsl:when test="$spatialType = 'paperMap'">Papierkarte</xsl:when>
            <xsl:otherwise><xsl:value-of select="$spatialType"/></xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <!-- Type d'objet géométrique -->
    <xsl:template name="getGeometricObjectTypeLabel">
        <xsl:param name="objectType"/>
        <xsl:choose>
            <xsl:when test="$objectType = 'point'">Point</xsl:when>
            <xsl:when test="$objectType = 'curve'">Linie</xsl:when>
            <xsl:when test="$objectType = 'surface'">Polygone</xsl:when>
            <xsl:when test="$objectType = 'solid'">Volumen</xsl:when>
            <xsl:when test="$objectType = 'complex'">Komplex</xsl:when>
            <xsl:when test="$objectType = 'composite'">Zusammengesetzt</xsl:when>
            <xsl:otherwise><xsl:value-of select="$objectType"/></xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <!-- Résolution spatiale -->
    <xsl:template name="displaySpatialResolution">
        <xsl:param name="spatialTypes"/>
        <xsl:variable name="hasVector" select="$spatialTypes[. = 'vector']"/>
        <xsl:variable name="hasGrid" select="$spatialTypes[. = 'grid']"/>
        
        <!-- Dénominateur d'échelle (vecteur) -->
        <xsl:if test="$hasVector">
            <xsl:variable name="denominator" select=".//gmd:spatialResolution/gmd:MD_Resolution/gmd:equivalentScale/gmd:MD_RepresentativeFraction/gmd:denominator/gco:Integer"/>
            <xsl:if test="$denominator != ''">
                <tr>
                    <td class="label">Masstabsnenner</td>
                    <td>1:<xsl:value-of select="$denominator"/></td>
                </tr>
            </xsl:if>
        </xsl:if>
        
        <!-- Résolution (raster) -->
        <xsl:if test="$hasGrid">
            <xsl:variable name="distance" select=".//gmd:spatialResolution/gmd:MD_Resolution/gmd:distance/gco:Distance"/>
            <xsl:variable name="uom" select=".//gmd:spatialResolution/gmd:MD_Resolution/gmd:distance/gco:Distance/@uom"/>
            <xsl:if test="$distance != ''">
                <tr>
                    <td class="label">Auflösung</td>
                    <td>
                        <xsl:value-of select="$distance"/>
                        <xsl:if test="$uom != ''">
                            <xsl:text> </xsl:text><xsl:value-of select="$uom"/>
                        </xsl:if>
                    </td>
                </tr>
            </xsl:if>
        </xsl:if>
    </xsl:template>

    <!-- Fréquence de mise à jour -->
    <xsl:template name="getMaintenanceFrequencyLabel">
        <xsl:param name="frequencyCode"/>
        <xsl:choose>
            <xsl:when test="$frequencyCode = 'continual'">Kontinuierlich</xsl:when>
            <xsl:when test="$frequencyCode = 'daily'">Täglich</xsl:when>
            <xsl:when test="$frequencyCode = 'weekly'">Wöchentlich</xsl:when>
            <xsl:when test="$frequencyCode = 'fortnightly'">Zweiwöchentlich</xsl:when>
            <xsl:when test="$frequencyCode = 'monthly'">Monatlich</xsl:when>
            <xsl:when test="$frequencyCode = 'quarterly'">Vierteljährlich</xsl:when>
            <xsl:when test="$frequencyCode = 'biannually'">Halbjährlich</xsl:when>
            <xsl:when test="$frequencyCode = 'annually'">Jährlich</xsl:when>
            <xsl:when test="$frequencyCode = 'asNeeded'">Bei Bedarf</xsl:when>
            <xsl:when test="$frequencyCode = 'irregular'">Unregelmässig</xsl:when>
            <xsl:when test="$frequencyCode = 'notPlanned'">Nicht geplant</xsl:when>
            <xsl:when test="$frequencyCode = 'unknown'">Unbekannt</xsl:when>
            <xsl:otherwise><xsl:value-of select="$frequencyCode"/></xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <!-- Formattage du texte pour les bases légales -->
    <xsl:template name="formatLegislationText">
        <xsl:param name="text"/>
        <xsl:choose>
            <xsl:when test="contains($text, '*')">
                <xsl:variable name="beforeFirst" select="substring-before($text, '*')"/>
                <xsl:variable name="afterFirst" select="substring-after($text, '*')"/>
                
                <xsl:if test="normalize-space($beforeFirst) != ''">
                    <xsl:value-of select="normalize-space($beforeFirst)"/><br/>
                </xsl:if>
                
                <xsl:call-template name="formatLegislationTextRecursive">
                    <xsl:with-param name="text" select="$afterFirst"/>
                </xsl:call-template>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="normalize-space($text)"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <xsl:template name="formatLegislationTextRecursive">
        <xsl:param name="text"/>
        <xsl:choose>
            <xsl:when test="contains($text, '*')">
                <xsl:variable name="currentPart" select="substring-before($text, '*')"/>
                <xsl:variable name="remaining" select="substring-after($text, '*')"/>
                
                <xsl:if test="normalize-space($currentPart) != ''">
                    <xsl:value-of select="normalize-space($currentPart)"/><br/>
                </xsl:if>
                
                <xsl:call-template name="formatLegislationTextRecursive">
                    <xsl:with-param name="text" select="$remaining"/>
                </xsl:call-template>
            </xsl:when>
            <xsl:otherwise>
                <xsl:if test="normalize-space($text) != ''">
                    <xsl:value-of select="normalize-space($text)"/>
                </xsl:if>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <!-- Formattage des organisations hiérarchiques -->
    <xsl:template name="formatHierarchicalOrganization">
        <xsl:param name="orgText"/>
        <xsl:choose>
            <xsl:when test="contains($orgText, ' - ')">
                <xsl:call-template name="formatHierarchicalOrganizationRecursive">
                    <xsl:with-param name="text" select="$orgText"/>
                </xsl:call-template>
            </xsl:when>
            <xsl:otherwise>
                <strong><xsl:value-of select="$orgText"/></strong>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <xsl:template name="formatHierarchicalOrganizationRecursive">
        <xsl:param name="text"/>
        <xsl:param name="level" select="1"/>
        <xsl:choose>
            <xsl:when test="contains($text, ' - ')">
                <xsl:variable name="currentPart" select="substring-before($text, ' - ')"/>
                <xsl:variable name="remaining" select="substring-after($text, ' - ')"/>
                
                <xsl:if test="normalize-space($currentPart) != ''">
                    <xsl:choose>
                        <xsl:when test="$level = 1">
                            <strong><xsl:value-of select="normalize-space($currentPart)"/></strong><br/>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:value-of select="normalize-space($currentPart)"/><br/>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:if>
                
                <xsl:call-template name="formatHierarchicalOrganizationRecursive">
                    <xsl:with-param name="text" select="$remaining"/>
                    <xsl:with-param name="level" select="$level + 1"/>
                </xsl:call-template>
            </xsl:when>
            <xsl:otherwise>
                <xsl:if test="normalize-space($text) != ''">
                    <xsl:value-of select="normalize-space($text)"/>
                </xsl:if>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <!-- Template principal -->
    <xsl:template match="che:CHE_MD_Metadata">
            
        <!-- Définition des variables (xpath) -->
        <xsl:variable name="identifier" select="gmd:fileIdentifier/gco:CharacterString"/>
        <xsl:variable name="urlBase" select="'https://geocat-int.dev.bgdi.ch/geonetwork/srv/api/records/'"/>
        <xsl:variable name="citationTitle" select=".//gmd:citation/gmd:CI_Citation/gmd:title/gmd:PT_FreeText/gmd:textGroup/gmd:LocalisedCharacterString[@locale='#DE']"/>
        <xsl:variable name="abstract" select=".//gmd:abstract/gmd:PT_FreeText/gmd:textGroup/gmd:LocalisedCharacterString[@locale='#DE']"/>
        <xsl:variable name="purpose" select=".//gmd:purpose/gmd:PT_FreeText/gmd:textGroup/gmd:LocalisedCharacterString[@locale='#DE']"/>
        <xsl:variable name="thumbnail" select=".//gmd:graphicOverview/gmd:MD_BrowseGraphic/gmd:fileName/gco:CharacterString"/>
        <xsl:variable name="statusCode" select=".//gmd:status/gmd:MD_ProgressCode/@codeListValue"/>
        <xsl:variable name="creationDate" select=".//gmd:date/gmd:CI_Date[gmd:dateType/gmd:CI_DateTypeCode/@codeListValue='creation']/gmd:date/gco:Date"/>
        <xsl:variable name="revisionDate" select=".//gmd:date/gmd:CI_Date[gmd:dateType/gmd:CI_DateTypeCode/@codeListValue='revision']/gmd:date/gco:Date"/>
        <xsl:variable name="dateStamp" select=".//gmd:dateStamp/gco:Date | .//gmd:dateStamp/gco:DateTime"/>
        <xsl:variable name="basicGeodataID" select=".//che:basicGeodataID/gco:CharacterString"/>
        <xsl:variable name="dataSetURI" select=".//gmd:dataSetURI/gco:CharacterString"/>
        <xsl:variable name="languages" select="gmd:identificationInfo/che:CHE_MD_DataIdentification/gmd:language"/>
        <xsl:variable name="topicCategories" select=".//gmd:topicCategory/gmd:MD_TopicCategoryCode"/>
        <xsl:variable name="spatialRepresentationTypes" select=".//gmd:spatialRepresentationType/gmd:MD_SpatialRepresentationTypeCode/@codeListValue"/>
        <xsl:variable name="geometricObjects" select=".//gmd:geometricObjects/gmd:MD_GeometricObjects"/>
        <xsl:variable name="referenceSystem" select=".//gmd:referenceSystemInfo/gmd:MD_ReferenceSystem/gmd:referenceSystemIdentifier/gmd:RS_Identifier/gmd:code/gmd:PT_FreeText/gmd:textGroup/gmd:LocalisedCharacterString[@locale='#DE']"/>
        <xsl:variable name="referenceSystemCodeSpace" select=".//gmd:referenceSystemInfo/gmd:MD_ReferenceSystem/gmd:referenceSystemIdentifier/gmd:RS_Identifier/gmd:codeSpace/gco:CharacterString"/>
        <xsl:variable name="keywords" select=".//gmd:descriptiveKeywords/gmd:MD_Keywords/gmd:keyword/gmd:PT_FreeText/gmd:textGroup/gmd:LocalisedCharacterString[@locale='#DE']"/>
        <xsl:variable name="lineage" select=".//gmd:LI_Lineage/gmd:statement/gmd:PT_FreeText/gmd:textGroup/gmd:LocalisedCharacterString[@locale='#DE']"/>
        <xsl:variable name="source" select=".//gmd:LI_Source/gmd:description/gmd:PT_FreeText/gmd:textGroup/gmd:LocalisedCharacterString[@locale='#DE']"/>
        <xsl:variable name="useLimitation" select=".//gmd:useLimitation/gmd:PT_FreeText/gmd:textGroup/gmd:LocalisedCharacterString[@locale='#DE']"/>
        <xsl:variable name="otherConstraints" select=".//gmd:otherConstraints/gmd:PT_FreeText/gmd:textGroup/gmd:LocalisedCharacterString[@locale='#DE']"/>
        <xsl:variable name="legislationTitle" select=".//che:legislationInformation/che:CHE_MD_Legislation/che:title/gmd:CI_Citation/gmd:title/gmd:PT_FreeText/gmd:textGroup/gmd:LocalisedCharacterString[@locale='#DE']"/>
        <xsl:variable name="maintenanceFrequency" select=".//gmd:maintenanceAndUpdateFrequency/gmd:MD_MaintenanceFrequencyCode/@codeListValue"/>
        <xsl:variable name="maintenanceNote" select=".//gmd:maintenanceNote/gmd:PT_FreeText/gmd:textGroup/gmd:LocalisedCharacterString[@locale='#DE']"/>
        <xsl:variable name="catalogueCreationDate" select=".//gmd:featureCatalogueCitation/gmd:CI_Citation/gmd:date/gmd:CI_Date/gmd:date/gco:Date"/>
        <xsl:variable name="catalogueTitle" select=".//gmd:featureCatalogueCitation/gmd:CI_Citation/gmd:title/gmd:PT_FreeText/gmd:textGroup/gmd:LocalisedCharacterString[@locale='#DE']"/>
        <xsl:variable name="dataModelURL" select=".//che:dataModel/che:PT_FreeURL/che:URLGroup/che:LocalisedURL[@locale='#DE']"/>
        <xsl:variable name="portrayalTitle" select=".//gmd:portrayalCatalogueInfo/che:CHE_MD_PortrayalCatalogueReference/gmd:portrayalCatalogueCitation/gmd:CI_Citation/gmd:title/gmd:PT_FreeText/gmd:textGroup/gmd:LocalisedCharacterString[@locale='#DE']"/>
        <xsl:variable name="portrayalDate" select=".//gmd:portrayalCatalogueInfo/che:CHE_MD_PortrayalCatalogueReference/gmd:portrayalCatalogueCitation/gmd:CI_Citation/gmd:date/gmd:CI_Date/gmd:date/gco:Date"/>
        <xsl:variable name="portrayalURL" select=".//gmd:portrayalCatalogueInfo/che:CHE_MD_PortrayalCatalogueReference/che:portrayalCatalogueURL/che:PT_FreeURL/che:URLGroup/che:LocalisedURL[@locale='#DE']"/>
        <xsl:variable name="internalResource" select=".//gmd:environmentDescription/gmd:PT_FreeText/gmd:textGroup/gmd:LocalisedCharacterString[@locale='#DE']"/>
        <xsl:variable name="internalResourceID" select=".//gmd:MD_Identifier/gmd:code/gco:CharacterString"/>
        <xsl:variable name="resourceFormats" select=".//gmd:MD_Format"/>
        <xsl:variable name="metadataStandardName" select=".//gmd:metadataStandardName/gco:CharacterString"/>
        <xsl:variable name="custodianOrgContact" select=".//che:CHE_MD_DataIdentification/gmd:pointOfContact/che:CHE_CI_ResponsibleParty"/>
        <xsl:variable name="distributorOrgContact" select=".//gmd:MD_Distributor/gmd:distributorContact/che:CHE_CI_ResponsibleParty"/>
        <xsl:variable name="custodianOrgAddress" select="$custodianOrgContact/gmd:contactInfo/gmd:CI_Contact/gmd:address/che:CHE_CI_Address"/>
        <xsl:variable name="distributorOrgAddress" select="$distributorOrgContact/gmd:contactInfo/gmd:CI_Contact/gmd:address/che:CHE_CI_Address"/>
        <xsl:variable name="custodianOrgName" select="substring-before(.//gmd:citedResponsibleParty/che:CHE_CI_ResponsibleParty/gmd:organisationName/gmd:PT_FreeText/gmd:textGroup/gmd:LocalisedCharacterString[@locale='#DE'], ' - ')"/>
        <xsl:variable name="distributorOrgName" select="$distributorOrgContact/gmd:organisationName/gmd:PT_FreeText/gmd:textGroup/gmd:LocalisedCharacterString[@locale='#DE']"/>
        <xsl:variable name="custodianOrgAcronym" select=".//gmd:citedResponsibleParty/che:CHE_CI_ResponsibleParty/che:organisationAcronym/gmd:PT_FreeText/gmd:textGroup/gmd:LocalisedCharacterString[@locale='#DE']"/>
        <xsl:variable name="distributorOrgAcronym" select="$distributorOrgContact/che:organisationAcronym/gmd:PT_FreeText/gmd:textGroup/gmd:LocalisedCharacterString[@locale='#DE']"/>
        <!-- Ressources en ligne -->
        <!-- Pour les ressources en ligne, il n'est pas possible d'utiliser des variables globales dans la boucle xsl:for-each en XSLT 1.0. -->
        <xsl:variable name="onlineResources" select=".//gmd:MD_DigitalTransferOptions/gmd:onLine"/>

        <html lang="de">
            <head>
                <meta charset="UTF-8"/>
                <meta name="viewport" content="width=device-width, initial-scale=1"/>
                <title>Kanton Wallis - Metadatenkatalog</title>

                <style>
                    /* Base */
                    * { box-sizing: border-box; }
                    body {
                        margin: 0;
                        font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, sans-serif;
                        background: #fff;
                        color: #000;
                        line-height: 1.4;
                        font-size: 16px;
                    }

                    /* Layout */
                    header, main {
                        max-width: 900px;
                        margin: auto;
                        padding: 0 1rem;
                    }

                    /* Header */
                    .header-top {
                        display: flex;
                        justify-content: space-between;
                        align-items: center;
                        padding: 1rem 0;
                    }
                    .header-top img { height: 60px; }

                    /* Banner */
                    .banner {
                        background: #E52429;
                        color: #fff;
                        padding: 0.8rem 1rem;
                        font-size: 1.4rem;
                        text-align: center;
                        border-radius: 4px;
                        margin-bottom: 1rem;
                    }

                    /* Navigation */
                    .presentation-nav {
                        display: flex;
                        justify-content: space-between;
                        align-items: center;
                        margin-bottom: 1rem;
                        padding: 0.5rem;
                        background: #f9f9f9;
                        border-radius: 4px;
                        font-size: 0.9rem;
                    }

                    .language-link {
                        text-align: right;
                        flex-shrink: 0;
                    }

                    /* Contenu */
                    .content {
                        background: #f9f9f9;
                        padding: 1rem;
                        border-radius: 4px;
                    }

                    .resource-title {
                        background: #E1E2E3;
                        padding: 0.5rem 1rem;
                        font-size: 1.5rem;
                        font-weight: bold;
                        margin: 0;
                        text-align: center;
                        border-radius: 4px 4px 0 0;
                    }

                    .section-title {
                        font-size: 1.2rem;
                        font-weight: bold;
                        margin: 1rem 0 0.5rem 0;
                    }

                    /* Images */
                    .content img {
                        display: block;
                        margin: 1rem auto;
                        max-width: 100%;
                        height: auto;
                        border-radius: 4px;
                    }

                    /* Tableau */
                    .info-table {
                        width: 100%;
                        border-collapse: collapse;
                        margin-top: 1rem;
                    }

                    .info-table td {
                        padding: 0.5rem 1rem;
                        vertical-align: top;
                        background: #fff;
                        border: 1px solid #ddd;
                    }

                    .info-table .label {
                        background: #E1E2E3;
                        font-weight: bold;
                        width: 30%;
                        min-width: 120px;
                    }

                    /* Liens */
                    a {
                        color: #E52429;
                        text-decoration: none;
                    }
                    a:hover { text-decoration: underline; }

                    /* Responsive */
                    @media (max-width: 768px) {
                        .header-top { flex-direction: column; gap: 1rem; }
                        .presentation-nav {
                            flex-direction: column;
                            gap: 0.5rem;
                            align-items: center;
                        }
                        .language-link {
                            text-align: center !important;
                        }
                        .info-table, .info-table tbody, .info-table tr, .info-table td { display: block; }
                        .info-table .label { width: 100%; border-bottom: none; }
                        .info-table td:not(.label) { border-top: none; margin-bottom: 0.5rem; }
                    }

                    /* Impression */
                    @media print {
                        @page { size: A4; margin: 1cm; }
                        
                        .presentation-nav { 
                            display: flex !important;
                            background: #f9f9f9 !important;
                            border: 1px solid #ddd !important;
                            margin-bottom: 1rem !important;
                            page-break-inside: avoid !important;
                        }

                        .presentation-nav a {
                            color: #E52429 !important;
                        }

                        .language-link {
                            text-align: right !important;
                        }
                        
                        /* Couleurs pour impression */
                        .banner { background: #E52429 !important; color: #fff !important; }
                        .resource-title, .info-table .label { background: #E1E2E3 !important; }
                        
                        /* Forcer l'impression des couleurs de fond */
                        * { 
                            -webkit-print-color-adjust: exact !important;
                            print-color-adjust: exact !important;
                        }
                        
                        /* Éviter les sauts de page dans les éléments */
                        .info-table, img { page-break-inside: avoid; }
                        .resource-title { page-break-after: avoid; }
                        
                        /* Optimisations typographiques */
                        body { font-family: Arial, sans-serif !important; }
                        a { text-decoration: underline !important; }
                    }
                </style>
            </head>
            
            <body>
                <header>
                    <div class="header-top">
                        <a href="http://www.vs.ch/" target="_blank">
                            <img src="https://www.vs.ch/documents/17311/1860458/logoVS78px/f406b530-5ee3-40b0-9c1e-00069d011f89?t=1462889171734" 
                                 alt="Logo Canton du Valais"/>
                        </a>                        
                        <a href="https://www.geocat.ch/geonetwork/srv/fre/catalog.search#/home" target="_blank">
                            <img src="https://www.vs.ch/documents/17311/472429/logo_geocat" alt="Logo geocat"/>
                        </a>
                    </div>
                    <div class="banner">Metadatenkatalog - Komplett</div>
                </header>

                <main>
                    <nav class="presentation-nav">
                        <a href="{concat($urlBase, $identifier, '/formatters/vs_full_de?width=_100&amp;mdpath=md.format.pdf&amp;output=pdf&amp;approved=true')}" 
                           target="_blank">🖨️ Datenblatt drucken (PDF)</a>

                        <div>
                            <span>Darstellung: </span>
                            <a href="{concat($urlBase, $identifier, '/formatters/vs_simple_de?language=ger')}">Einfach</a>
                            <span>/</span>
                            <a href="{concat($urlBase, $identifier, '/formatters/vs_full_de?language=ger')}">Komplett</a>
                        </div>
                        <div class="language-link">
                            <a href="{concat($urlBase, $identifier, '/formatters/vs_full_fr?language=fre')}" 
                                target="_blank">🇫🇷 Französische Fassung</a>
                        </div>
                    </nav>

                    <article class="content">
                        <xsl:if test="$citationTitle != ''">
                            <h1 class="resource-title"><xsl:value-of select="$citationTitle"/></h1>
                        </xsl:if>
                        
                        <xsl:if test="$thumbnail != ''">
                            <img src="{$thumbnail}" alt="Vorschau von {$citationTitle}"/>
                        </xsl:if>

                        <xsl:if test="$abstract != ''">
                            <section>
                                <h2 class="section-title">Kurzbeschreibung</h2>
                                <p><xsl:value-of select="$abstract"/></p>
                            </section>
                        </xsl:if>

                        <xsl:if test="$purpose != ''">
                            <section>
                                <h2 class="section-title">Zweck</h2>
                                <p><xsl:value-of select="$purpose"/></p>
                            </section>
                        </xsl:if>

                        <!-- Informations sur la mise à jour -->
                        <section>
                            <h2 class="section-title">Aktualisierungsinformationen</h2>
                            <table class="info-table">
                                <tbody>
                                    <xsl:if test="$statusCode != ''">
                                        <tr>
                                            <td class="label"> Bearbeitungsstatus </td>
                                            <td>
                                                <xsl:call-template name="getStatus">
                                                    <xsl:with-param name="statusCode" select="$statusCode"/>
                                                </xsl:call-template>
                                            </td>
                                        </tr>
                                    </xsl:if>
                                    <!-- Langue -->
                                    <xsl:if test="$languages">
                                        <tr>
                                            <td class="label"> Sprache</td>
                                            <td>
                                                <xsl:for-each select="$languages">
                                                    <xsl:call-template name="getLanguageLabel">
                                                        <xsl:with-param name="languageCode" select="gmd:LanguageCode/@codeListValue | gco:CharacterString"/>
                                                    </xsl:call-template>
                                                    <xsl:if test="position() != last()"><br/></xsl:if>
                                                </xsl:for-each>
                                            </td>
                                        </tr>
                                    </xsl:if>
                                    <!-- Date de création -->
                                    <xsl:if test="$creationDate != ''">
                                        <tr>
                                            <td class="label">Datum  Erstellung</td>
                                            <td>
                                                <xsl:call-template name="formatDate">
                                                    <xsl:with-param name="date" select="$creationDate"/>
                                                </xsl:call-template>
                                            </td>
                                        </tr>
                                    </xsl:if>
                                    <!-- Date de révision -->
                                    <xsl:if test="$revisionDate != ''">
                                        <tr>
                                            <td class="label"> Datum  Überarbeitung</td>
                                            <td>
                                                <xsl:call-template name="formatDate">
                                                    <xsl:with-param name="date" select="$revisionDate"/>
                                                </xsl:call-template>
                                            </td>
                                        </tr>
                                    </xsl:if>
                                    <!-- Géodonnée de base -->
                                    <xsl:if test="$basicGeodataID != ''">
                                        <tr>
                                            <td class="label">Geobasisdaten (Bund)</td>
                                            <td>
                                                <xsl:value-of select="$basicGeodataID"/>
                                            </td>
                                        </tr>
                                    </xsl:if>
                                </tbody>
                            </table>
                        </section>

                        <!-- Information de l'identification -->
                        <section>
                            <h2 class="section-title">Basisinformation</h2>
                            <table class="info-table">
                                <tbody>
                                    <xsl:if test="$dataSetURI != ''">
                                        <tr>
                                            <td class="label"> URI des Datenbestands</td>
                                            <td>
                                                <a href="{$dataSetURI}" target="_blank">Link</a>
                                            </td>
                                        </tr>
                                    </xsl:if>
                                    <tr>
                                        <td class="label">Verwalter</td>
                                        <td>
                                            <xsl:if test="$custodianOrgName != ''">
                                                <strong><xsl:value-of select="$custodianOrgName"/></strong><br/>
                                            </xsl:if>
                                            <xsl:if test="$custodianOrgAcronym != ''">
                                                <xsl:value-of select="$custodianOrgAcronym"/><br/>
                                            </xsl:if>
                                            
                                            <!-- Adresse -->
                                            <xsl:variable name="streetName" select="$custodianOrgAddress/che:streetName/gco:CharacterString"/>
                                            <xsl:variable name="streetNumber" select="$custodianOrgAddress/che:streetNumber/gco:CharacterString"/>
                                            <xsl:if test="$streetName != '' or $streetNumber != ''">
                                                <xsl:value-of select="$streetName"/>
                                                <xsl:if test="$streetNumber != ''">
                                                    <xsl:text> </xsl:text><xsl:value-of select="$streetNumber"/>
                                                </xsl:if>
                                                <br/>

                                                <xsl:variable name="postalCode" select="$custodianOrgAddress/gmd:postalCode/gco:CharacterString"/>
                                                <xsl:variable name="city" select="$custodianOrgAddress/gmd:city/gco:CharacterString"/>
                                                <xsl:if test="$postalCode != '' or $city != ''">
                                                    <xsl:value-of select="$postalCode"/>
                                                    <xsl:if test="$city != ''">
                                                        <xsl:text> </xsl:text><xsl:value-of select="$city"/>
                                                    </xsl:if>
                                                    <br/>
                                                </xsl:if>
                                            </xsl:if>
                                            
                                            <!-- Contact -->
                                            <xsl:variable name="phone" select="$custodianOrgContact/gmd:contactInfo/gmd:CI_Contact/gmd:phone/che:CHE_CI_Telephone/gmd:voice/gco:CharacterString"/>
                                            <xsl:if test="$phone != ''">
                                                <div>Tel: <a href="tel:{$phone}"><xsl:value-of select="$phone"/></a></div>
                                            </xsl:if>
                                            
                                            <xsl:variable name="email" select="$custodianOrgAddress/gmd:electronicMailAddress/gco:CharacterString"/>
                                            <xsl:if test="$email != ''">
                                                <div>E-Mail: <a href="mailto:{$email}"><xsl:value-of select="$email"/></a></div>
                                            </xsl:if>
                                            
                                            <xsl:variable name="website" select="$custodianOrgContact/gmd:contactInfo/gmd:CI_Contact/gmd:onlineResource/gmd:CI_OnlineResource/gmd:linkage/che:PT_FreeURL/che:URLGroup/che:LocalisedURL[@locale='#DE']"/>
                                            <xsl:if test="$website != ''">
                                                <div>Website: <a href="{$website}" target="_blank"><xsl:value-of select="$website"/></a></div>
                                            </xsl:if>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="label">Thematik</td>
                                        <td>
                                            <xsl:for-each select="$topicCategories">
                                                <xsl:call-template name="getTopicCategoryLabel">
                                                    <xsl:with-param name="topicCode" select="@codeListValue | ."/>
                                                </xsl:call-template>
                                                <xsl:if test="position() != last()"><br/></xsl:if>
                                            </xsl:for-each>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="label">Schlüsselwörter</td>
                                        <td>
                                            <xsl:for-each select="$keywords">
                                                <xsl:value-of select="."/>
                                                <xsl:if test="position() != last()"><br/></xsl:if>
                                            </xsl:for-each>
                                        </td>
                                    </tr>
                                    <xsl:if test="$spatialRepresentationTypes">
                                        <tr>
                                            <td class="label">Räumliche Darstellungsart</td>
                                            <td>
                                                <xsl:for-each select="$spatialRepresentationTypes">
                                                    <xsl:call-template name="getSpatialRepresentationTypeLabel">
                                                        <xsl:with-param name="spatialType" select="."/>
                                                    </xsl:call-template>
                                                    <xsl:if test="position() != last()"><br/></xsl:if>
                                                </xsl:for-each>
                                            </td>
                                        </tr>
                                    </xsl:if>

                                    <xsl:if test="$geometricObjects">
                                        <tr>
                                            <td class="label">Geometrische Objekte</td>
                                            <td>
                                                <xsl:for-each select="$geometricObjects">
                                                    <xsl:variable name="objectType" select="gmd:geometricObjectType/gmd:MD_GeometricObjectTypeCode/@codeListValue"/>
                                                    <xsl:variable name="objectCount" select="gmd:geometricObjectCount/gco:Integer"/>
                                                    
                                                    <xsl:call-template name="getGeometricObjectTypeLabel">
                                                        <xsl:with-param name="objectType" select="$objectType"/>
                                                    </xsl:call-template>
                                                    
                                                    <xsl:if test="$objectCount != ''">
                                                        <xsl:text> (</xsl:text><xsl:value-of select="$objectCount"/><xsl:text>)</xsl:text>
                                                    </xsl:if>
                                                    
                                                    <xsl:if test="position() != last()"><br/></xsl:if>
                                                </xsl:for-each>
                                            </td>
                                        </tr>
                                    </xsl:if>

                                    <!-- Résolution spatiale selon le type -->
                                    <xsl:call-template name="displaySpatialResolution">
                                        <xsl:with-param name="spatialTypes" select="$spatialRepresentationTypes"/>
                                    </xsl:call-template>

                                    <!-- Système de référence -->
                                    <xsl:if test="$referenceSystem != ''">
                                        <tr>
                                            <td class="label">Referenzsystem</td>
                                            <td>
                                                <xsl:value-of select="$referenceSystem"/>
                                                <xsl:if test="$referenceSystemCodeSpace != ''">
                                                    <xsl:text> (</xsl:text><xsl:value-of select="$referenceSystemCodeSpace"/><xsl:text>)</xsl:text>
                                                </xsl:if>
                                            </td>
                                        </tr>
                                    </xsl:if>
                                </tbody>
                            </table>
                        </section>

                        <!-- Informations sur la qualité des données -->
                        <section>
                            <h2 class="section-title">Datenqualität</h2>
                            <table class="info-table">
                                <tbody>
                                    <xsl:if test="$lineage != ''">
                                        <tr>
                                            <td class="label">Herkunft</td>
                                            <td><xsl:value-of select="$lineage"/></td>
                                        </tr>
                                    </xsl:if>
                                    <xsl:if test="$source != ''">
                                        <tr>
                                            <td class="label">Datenquelle</td>
                                            <td><xsl:value-of select="$source"/></td>
                                        </tr>
                                    </xsl:if>
                                </tbody>
                            </table>
                        </section>

                        <!-- Contraintes sur la ressource  -->
                        <section>
                            <h2 class="section-title">Ressourceneinschränkungen</h2>
                            <table class="info-table">
                                <tbody>
                                    <xsl:if test="$useLimitation != ''">
                                        <tr>
                                            <td class="label">Anwendungseinschränkungen</td>
                                            <td><xsl:value-of select="$useLimitation"/></td>
                                        </tr>
                                    </xsl:if>
                                    <xsl:if test="$otherConstraints">
                                        <tr>
                                            <td class="label">Andere Einschränkungen</td>
                                            <td>
                                                <xsl:for-each select="$otherConstraints">
                                                    <xsl:value-of select="."/>
                                                    <xsl:if test="position() != last()"><br/></xsl:if>
                                                </xsl:for-each>
                                            </td>
                                        </tr>
                                    </xsl:if>
                                </tbody>
                            </table>
                        </section>

                        <!-- Référence(s) légale(s)  -->
                        <xsl:if test="$legislationTitle">
                            <section>
                                <h2 class="section-title">Gesetzgebung</h2>
                                <table class="info-table">
                                    <tbody>
                                        <tr>
                                            <td class="label">Liste</td>
                                            <td>
                                                <xsl:for-each select="$legislationTitle">
                                                    <xsl:variable name="fullText" select="."/>
                                                    <xsl:call-template name="formatLegislationText">
                                                        <xsl:with-param name="text" select="$fullText"/>
                                                    </xsl:call-template>
                                                    <xsl:if test="position() != last()"><br/><br/></xsl:if>
                                                </xsl:for-each>
                                            </td>
                                        </tr>                            
                                    </tbody>
                                </table>
                            </section>
                        </xsl:if>

                        <!-- Mise à jour de la ressource  -->
                        <section>
                            <h2 class="section-title">Pflege der Ressource</h2>
                            <xsl:if test="$maintenanceFrequency != ''">
                                <table class="info-table">
                                    <tbody>
                                        <xsl:if test="$maintenanceFrequency != ''">
                                            <tr>
                                                <td class="label">Überarbeitungsintervall</td>
                                                <td>
                                                    <xsl:call-template name="getMaintenanceFrequencyLabel">
                                                        <xsl:with-param name="frequencyCode" select="$maintenanceFrequency"/>
                                                    </xsl:call-template>
                                                </td>
                                            </tr>
                                        </xsl:if>
                                        <xsl:if test="$maintenanceNote != ''">
                                            <tr>
                                                <td class="label">Anmerkung</td>
                                                <td>
                                                    <xsl:value-of select="$maintenanceNote"/>
                                                </td>
                                            </tr>
                                        </xsl:if>
                                    </tbody>
                                </table>
                            </xsl:if>
                        </section>

                        <!-- Catalogue d'objets et modèle  -->
                        <section>
                            <h2 class="section-title">Objektkatalog und Datenmodell</h2>
                            <xsl:if test="$catalogueCreationDate != '' or ($catalogueTitle != '' and $dataModelURL != '')">
                                <table class="info-table">
                                    <tbody>
                                        <xsl:if test="$catalogueCreationDate != ''">
                                            <tr>
                                                <td class="label">Erstellungsdatum</td>
                                                <td>
                                                    <xsl:call-template name="formatDate">
                                                        <xsl:with-param name="date" select="$catalogueCreationDate"/>
                                                    </xsl:call-template>
                                                </td>
                                            </tr>
                                        </xsl:if>
                                        <xsl:if test="$catalogueTitle != '' and $dataModelURL != ''">
                                            <tr>
                                                <td class="label">Link</td>
                                                <td>
                                                    <a href="{$dataModelURL}" target="_blank">
                                                        <xsl:value-of select="$catalogueTitle"/>
                                                    </a>
                                                </td>
                                            </tr>
                                        </xsl:if>
                                    </tbody>
                                </table>
                            </xsl:if>
                        </section>

                        <!-- Informations sur la représentation  -->
                        <xsl:if test="$portrayalDate != '' or ($portrayalTitle != '' and $portrayalURL != '')">
                            <section>
                                <h2 class="section-title">Darstellungskatalog</h2>
                                <table class="info-table">
                                    <tbody>
                                        <xsl:if test="$portrayalDate != ''">
                                            <tr>
                                                <td class="label">Erstellungsdatum</td>
                                                <td>
                                                    <xsl:call-template name="formatDate">
                                                        <xsl:with-param name="date" select="$portrayalDate"/>
                                                    </xsl:call-template>
                                                </td>
                                            </tr>
                                        </xsl:if>
                                        <xsl:if test="$portrayalTitle != '' and $portrayalURL != ''">
                                            <tr>
                                                <td class="label">Link</td>
                                                <td>
                                                    <a href="{$portrayalURL}" target="_blank">
                                                        <xsl:value-of select="$portrayalTitle"/>
                                                    </a>
                                                </td>
                                            </tr>
                                        </xsl:if>
                                    </tbody>
                                </table>
                            </section>
                        </xsl:if>

                        <!-- Informations sur la distribution  -->
                        <section>
                            <h2 class="section-title">Vertriebsinformation</h2>
                            <xsl:if test="$onlineResources">
                                <table class="info-table">
                                    <tbody>
                                        <xsl:for-each select="$onlineResources">

                                            <!-- Tri personnalisé : priorité par type de service et fournisseur -->
                                            <xsl:sort select="
                                                (gmd:CI_OnlineResource/gmd:protocol/gco:CharacterString = 'ESRI:REST') * -5 +
                                                (starts-with(gmd:CI_OnlineResource/gmd:protocol/gco:CharacterString, 'OGC:')) * -4 +
                                                (gmd:CI_OnlineResource/gmd:protocol/gco:CharacterString = 'WWW:DOWNLOAD-APP'
                                                  and gmd:CI_OnlineResource/gmd:name/gmd:PT_FreeText/gmd:textGroup/gmd:LocalisedCharacterString[@locale='#DE'] = 'OpenData Valais') * -3 +
                                                (contains(gmd:CI_OnlineResource/gmd:name/gmd:PT_FreeText/gmd:textGroup/gmd:LocalisedCharacterString[@locale='#DE'], 'geodienste.ch')) * -2 +
                                                (gmd:CI_OnlineResource/gmd:protocol/gco:CharacterString = 'CHTOPO:specialised-geoportal') * -1
                                            " data-type="number"/>
                                            <xsl:sort select="gmd:CI_OnlineResource/gmd:name/gmd:PT_FreeText/gmd:textGroup/gmd:LocalisedCharacterString[@locale='#DE']"/>
                                            
                                            <!-- Variables (contexte local) -->
                                            <xsl:variable name="resourceName" select="gmd:CI_OnlineResource/gmd:name/gmd:PT_FreeText/gmd:textGroup/gmd:LocalisedCharacterString[@locale='#DE']"/>
                                            <xsl:variable name="resourceDescription" select="gmd:CI_OnlineResource/gmd:description/gmd:PT_FreeText/gmd:textGroup/gmd:LocalisedCharacterString[@locale='#DE']"/>
                                            <xsl:variable name="resourceURL" select="gmd:CI_OnlineResource/gmd:linkage/che:PT_FreeURL/che:URLGroup/che:LocalisedURL[@locale='#DE']"/>
                                            <xsl:variable name="resourceProtocol" select="gmd:CI_OnlineResource/gmd:protocol/gco:CharacterString"/>
                                            
                                            <xsl:choose>

                                                <!-- ESRI:REST -->
                                                <xsl:when test="$resourceProtocol = 'ESRI:REST'">
                                                    <tr>
                                                        <td class="label">ArcGIS REST Services</td>
                                                        <td>
                                                            <a href="{$resourceURL}" target="_blank">
                                                                <xsl:choose>
                                                                    <xsl:when test="$resourceDescription != ''">
                                                                        <xsl:value-of select="$resourceDescription"/>
                                                                    </xsl:when>
                                                                    <xsl:when test="$resourceName != ''">
                                                                        <xsl:value-of select="$resourceName"/>
                                                                    </xsl:when>
                                                                    <xsl:otherwise>
                                                                        <xsl:value-of select="$resourceURL"/>
                                                                    </xsl:otherwise>
                                                                </xsl:choose>
                                                            </a>
                                                        </td>
                                                    </tr>
                                                </xsl:when>

                                                <!-- OGC:WFS -->
                                                <xsl:when test="$resourceProtocol = 'OGC:WFS'">
                                                    <xsl:if test="not(preceding-sibling::gmd:onLine[gmd:CI_OnlineResource/gmd:protocol/gco:CharacterString = 'OGC:WFS' and gmd:CI_OnlineResource/gmd:linkage/che:PT_FreeURL/che:URLGroup/che:LocalisedURL[@locale='#DE'] = $resourceURL])">
                                                        <tr>
                                                            <td class="label">OGC Web Feature Service (WFS)</td>
                                                            <td>
                                                                <xsl:for-each select="../gmd:onLine[gmd:CI_OnlineResource/gmd:protocol/gco:CharacterString = 'OGC:WFS' and gmd:CI_OnlineResource/gmd:linkage/che:PT_FreeURL/che:URLGroup/che:LocalisedURL[@locale='#DE'] = $resourceURL]">
                                                                    <xsl:variable name="layerDescription" select="gmd:CI_OnlineResource/gmd:description/gmd:PT_FreeText/gmd:textGroup/gmd:LocalisedCharacterString[@locale='#DE']"/>
                                                                    <xsl:if test="position() > 1"><br/></xsl:if>
                                                                    <a href="{$resourceURL}" target="_blank">
                                                                        <xsl:choose>
                                                                            <xsl:when test="$layerDescription != ''">
                                                                                <xsl:value-of select="$layerDescription"/>
                                                                            </xsl:when>
                                                                            <xsl:otherwise>Layer <xsl:value-of select="position()"/></xsl:otherwise>
                                                                        </xsl:choose>
                                                                    </a>
                                                                </xsl:for-each>
                                                            </td>
                                                        </tr>
                                                    </xsl:if>
                                                </xsl:when>

                                                <!-- OGC:WMS -->
                                                <xsl:when test="$resourceProtocol = 'OGC:WMS'">
                                                    <xsl:if test="not(preceding-sibling::gmd:onLine[gmd:CI_OnlineResource/gmd:protocol/gco:CharacterString = 'OGC:WMS' and gmd:CI_OnlineResource/gmd:linkage/che:PT_FreeURL/che:URLGroup/che:LocalisedURL[@locale='#DE'] = $resourceURL])">
                                                        <tr>
                                                            <td class="label">OGC Web Map Service (WMS)</td>
                                                            <td>
                                                                <xsl:for-each select="../gmd:onLine[gmd:CI_OnlineResource/gmd:protocol/gco:CharacterString = 'OGC:WMS' and gmd:CI_OnlineResource/gmd:linkage/che:PT_FreeURL/che:URLGroup/che:LocalisedURL[@locale='#DE'] = $resourceURL]">
                                                                    <xsl:variable name="layerDescription" select="gmd:CI_OnlineResource/gmd:description/gmd:PT_FreeText/gmd:textGroup/gmd:LocalisedCharacterString[@locale='#DE']"/>
                                                                    <xsl:if test="position() > 1"><br/></xsl:if>
                                                                    <a href="{$resourceURL}" target="_blank">
                                                                        <xsl:choose>
                                                                            <xsl:when test="$layerDescription != ''">
                                                                                <xsl:value-of select="$layerDescription"/>
                                                                            </xsl:when>
                                                                            <xsl:otherwise>Layer <xsl:value-of select="position()"/></xsl:otherwise>
                                                                        </xsl:choose>
                                                                    </a>
                                                                </xsl:for-each>
                                                            </td>
                                                        </tr>
                                                    </xsl:if>
                                                </xsl:when>

                                                <!-- Open Data Valais -->
                                                <xsl:when test="$resourceProtocol = 'WWW:DOWNLOAD-APP' and $resourceName = 'OpenData Valais'">
                                                    <tr>
                                                        <td class="label">Download-Service OpenData Wallis</td>
                                                        <td>
                                                            <a href="{$resourceURL}" target="_blank">Link</a>
                                                        </td>
                                                    </tr>
                                                </xsl:when>

                                                <!-- geodienste.ch -->
                                               <xsl:when test="contains($resourceName,'geodienste.ch')">
                                                    <tr>
                                                        <td class="label">Download-Link geodienste.ch</td>
                                                        <td>
                                                            <a href="{$resourceURL}" target="_blank">
                                                                <xsl:choose>
                                                                    <xsl:when test="$resourceDescription != ''">
                                                                        <xsl:value-of select="$resourceDescription"/>
                                                                    </xsl:when>
                                                                    <xsl:when test="$resourceName != ''">
                                                                        <xsl:value-of select="$resourceName"/>
                                                                    </xsl:when>
                                                                    <xsl:otherwise>
                                                                        <xsl:value-of select="$resourceURL"/>
                                                                    </xsl:otherwise>
                                                                </xsl:choose>
                                                            </a>
                                                        </td>
                                                    </tr>
                                                </xsl:when>

                                                <!-- Géoportail du Canton du Valais -->
                                                <xsl:when test="$resourceProtocol = 'CHTOPO:specialised-geoportal'">
                                                    <tr>
                                                        <td class="label">Geoportal des Kantons Wallis</td>
                                                        <td>
                                                            <a href="{$resourceURL}" target="_blank">Link</a>
                                                        </td>
                                                    </tr>	
                                                </xsl:when>

                                            </xsl:choose>
                                        </xsl:for-each>

                                    <!-- Ressource interne -->
                                    <xsl:if test="$internalResource != ''">
                                        <tr>
                                            <td class="label">Interne Ressource</td>
                                            <td><xsl:value-of select="$internalResource"/></td>
                                        </tr>
                                    </xsl:if>

                                    <!-- Identifiant interne -->
                                    <xsl:if test="$internalResourceID != ''">
                                        <tr>
                                            <td class="label">Interne Referenz</td>
                                            <td><xsl:value-of select="$internalResourceID"/></td>
                                        </tr>
                                    </xsl:if>

                                    <!-- Distributeur   -->
                                    <tr>
                                        <td class="label">Vertrieb</td>
                                        <td>
                                            <xsl:if test="$distributorOrgName != ''">
                                                <xsl:call-template name="formatHierarchicalOrganization">
                                                    <xsl:with-param name="orgText" select="$distributorOrgName"/>
                                                </xsl:call-template>
                                                <br/>
                                            </xsl:if>
                                                                                        
                                            <!-- Adresse -->
                                            <xsl:variable name="streetName" select="$distributorOrgAddress/che:streetName/gco:CharacterString"/>
                                            <xsl:variable name="streetNumber" select="$distributorOrgAddress/che:streetNumber/gco:CharacterString"/>
                                            <xsl:if test="$streetName != '' or $streetNumber != ''">
                                                <xsl:value-of select="$streetName"/>
                                                <xsl:if test="$streetNumber != ''">
                                                    <xsl:text> </xsl:text><xsl:value-of select="$streetNumber"/>
                                                </xsl:if>
                                                <br/>
                                                
                                                <xsl:variable name="postalCode" select="$distributorOrgAddress/gmd:postalCode/gco:CharacterString"/>
                                                <xsl:variable name="city" select="$distributorOrgAddress/gmd:city/gco:CharacterString"/>
                                                <xsl:if test="$postalCode != '' or $city != ''">
                                                    <xsl:value-of select="$postalCode"/>
                                                    <xsl:if test="$city != ''">
                                                        <xsl:text> </xsl:text><xsl:value-of select="$city"/>
                                                    </xsl:if>
                                                    <br/>
                                                </xsl:if>
                                            </xsl:if>
                                            
                                            <!-- Contact -->
                                            <xsl:variable name="phone" select="$distributorOrgContact/gmd:contactInfo/gmd:CI_Contact/gmd:phone/che:CHE_CI_Telephone/gmd:voice/gco:CharacterString"/>
                                            <xsl:if test="$phone != ''">
                                                <div>Tel: <a href="tel:{$phone}"><xsl:value-of select="$phone"/></a></div>
                                            </xsl:if>
                                            
                                            <xsl:variable name="email" select="$distributorOrgAddress/gmd:electronicMailAddress/gco:CharacterString"/>
                                            <xsl:if test="$email != ''">
                                                <div>E-Mail: <a href="mailto:{$email}"><xsl:value-of select="$email"/></a></div>
                                            </xsl:if>
                                            
                                            <xsl:variable name="website" select="$distributorOrgContact/gmd:contactInfo/gmd:CI_Contact/gmd:onlineResource/gmd:CI_OnlineResource/gmd:linkage/che:PT_FreeURL/che:URLGroup/che:LocalisedURL[@locale='#DE']"/>
                                            <xsl:if test="$website != ''">
                                                <div>Website: <a href="{$website}" target="_blank"><xsl:value-of select="$website"/></a></div>
                                            </xsl:if>
                                        </td>
                                    </tr>

                                    <!-- Format de la ressource -->
                                    <xsl:if test="$resourceFormats">
                                        <tr>
                                            <td class="label">Ressourcenformat<xsl:if test="count($resourceFormats) > 1">e</xsl:if></td>

                                            <td>
                                                <xsl:for-each select="$resourceFormats">
                                                    <xsl:variable name="formatName" select="gmd:name/gco:CharacterString"/>
                                                    <xsl:variable name="formatVersion" select="gmd:version/gco:CharacterString"/>
                                                    
                                                    <xsl:if test="$formatName != ''">
                                                        <xsl:value-of select="$formatName"/>
                                                        <xsl:if test="$formatVersion != ''">
                                                            <xsl:text> (Version </xsl:text><xsl:value-of select="$formatVersion"/><xsl:text>)</xsl:text>
                                                        </xsl:if>
                                                        <xsl:if test="position() != last()"><br/></xsl:if>
                                                    </xsl:if>
                                                </xsl:for-each>
                                            </td>
                                        </tr>
                                    </xsl:if>

                                    </tbody>
                                </table>
                            </xsl:if>
                        </section>

                        <!-- Métadonnées -->
                        <section>
                            <h2 class="section-title">Metadaten</h2>
                            <table class="info-table">
                                <tbody>
                                    <xsl:if test="$identifier != ''">
                                        <tr>
                                            <td class="label"> Metadatensatzidentifikator</td>
                                            <td><xsl:value-of select="$identifier"/></td>
                                        </tr>
                                    </xsl:if>
                                    <xsl:if test="$dateStamp != ''">
                                        <tr>
                                            <td class="label">Überarbeitungsdatum</td>
                                            <td>
                                                <xsl:call-template name="formatDate">
                                                    <xsl:with-param name="date" select="$dateStamp"/>
                                                </xsl:call-template>
                                            </td>
                                        </tr>
                                    </xsl:if>
                                    <xsl:if test="$metadataStandardName != ''">
                                        <tr>
                                            <td class="label">Bezeichnung des Metadatenstandards</td>
                                            <td><xsl:value-of select="$metadataStandardName"/></td>
                                        </tr>
                                    </xsl:if>
                                </tbody>
                            </table>
                        </section>

                    </article>
                </main>
            </body>
        </html>
    </xsl:template>
</xsl:stylesheet>