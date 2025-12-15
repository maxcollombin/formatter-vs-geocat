<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:che="http://www.geocat.ch/2008/che"
    xmlns:gmd="http://www.isotc211.org/2005/gmd"
    xmlns:gco="http://www.isotc211.org/2005/gco">
    <xsl:output method="html" indent="yes" encoding="UTF-8"/>
    <!-- Chargement des codelists -->
    <xsl:variable name="value" select="/root/schemas/iso19139/codelists"/>
    <xsl:variable name="value.che" select="/root/schemas/iso19139.che/codelists"/>
    <!-- Point d’entrée -->
    <xsl:template match="/">
        <xsl:apply-templates select="//che:CHE_MD_Metadata"/>
    </xsl:template>
    <!-- Formatage des dates -->
    <xsl:template name="formatDate">
        <xsl:param name="date"/>
        <xsl:if test="string-length($date) = 10">
            <xsl:value-of select="concat(substring($date,9,2),'.',substring($date,6,2),'.',substring($date,1,4))"/>
        </xsl:if>
    </xsl:template>
    <!-- Template codelist -->
    <xsl:template name="codelist">
        <xsl:param name="code"/>
        <xsl:param name="path"/>
        <xsl:value-of select="string($value/codelist[@name= $path]/entry[code = $code]/label)"/>
    </xsl:template>
    <!-- Formattage des contacts -->
    <xsl:template name="formatContact">
        <xsl:param name="contact"/>
        <xsl:variable name="ci" select="$contact/gmd:contactInfo/gmd:CI_Contact"/>
        <xsl:variable name="address" select="$ci/gmd:address/che:CHE_CI_Address"/>
        <xsl:variable name="streetName" select="$address/che:streetName/gco:CharacterString"/>
        <xsl:variable name="streetNumber" select="$address/che:streetNumber/gco:CharacterString"/>
        <xsl:variable name="postalCode" select="$address/gmd:postalCode/gco:CharacterString"/>
        <xsl:variable name="city" select="$address/gmd:city/gco:CharacterString"/>
        <xsl:variable name="phone" select="$ci/gmd:phone/che:CHE_CI_Telephone/gmd:voice/gco:CharacterString"/>
        <xsl:variable name="email" select="$address/gmd:electronicMailAddress/gco:CharacterString"/>
        <xsl:variable name="website" select="$ci/gmd:onlineResource/gmd:CI_OnlineResource/gmd:linkage/che:PT_FreeURL/che:URLGroup/che:LocalisedURL[@locale='#FR']"/>
        <!-- Rue et numéro -->
        <xsl:if test="$streetName or $streetNumber">
            <div><xsl:value-of select="$streetName"/>
                <xsl:if test="$streetNumber"><xsl:text> </xsl:text><xsl:value-of select="$streetNumber"/></xsl:if>
            </div>
        </xsl:if>
        <!-- Code postal et ville -->
        <xsl:if test="$postalCode or $city">
            <div><xsl:value-of select="$postalCode"/>
                <xsl:if test="$city"><xsl:text> </xsl:text><xsl:value-of select="$city"/></xsl:if>
            </div>
        </xsl:if>
        <!-- Téléphone, mail, site web -->
        <xsl:if test="$phone"><div>Tél: <a href="tel:{$phone}"><xsl:value-of select="$phone"/></a></div></xsl:if>
        <xsl:if test="$email"><div>Email: <a href="mailto:{$email}"><xsl:value-of select="$email"/></a></div></xsl:if>
        <xsl:if test="$website"><div>Site web: <a href="{$website}" target="_blank"><xsl:value-of select="$website"/></a></div></xsl:if>
    </xsl:template>
    <!-- Formattage du texte pour les bases légales -->
    <xsl:template name="formatLegislationText">
        <xsl:param name="text"/>
        <xsl:choose>
            <xsl:when test="contains($text, '*')">
                <xsl:variable name="beforeFirst" select="substring-before($text, '*')"/>
                <xsl:variable name="afterFirst" select="substring-after($text, '*')"/>
                
                <xsl:if test="normalize-space($beforeFirst)">
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
                
                <xsl:if test="normalize-space($currentPart)">
                    <xsl:value-of select="normalize-space($currentPart)"/><br/>
                </xsl:if>
                
                <xsl:call-template name="formatLegislationTextRecursive">
                    <xsl:with-param name="text" select="$remaining"/>
                </xsl:call-template>
            </xsl:when>
            <xsl:otherwise>
                <xsl:if test="normalize-space($text)">
                    <xsl:value-of select="normalize-space($text)"/>
                </xsl:if>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <!-- Template pour les thématiques -->
    <!-- Il est nécessaire de les définir ici car les valeurs dans le codelist ne sont pas correctes -->
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
    <!-- Template pour les types de représentation spatiale -->
    <xsl:template name="getSpatialRepresentationTypeLabel">
        <xsl:param name="spatialType"/>
        <xsl:variable name="codelistLabel">
            <xsl:call-template name="codelist">
                <xsl:with-param name="code" select="$spatialType"/>
                <xsl:with-param name="path">gmd:MD_SpatialRepresentationTypeCode</xsl:with-param>
            </xsl:call-template>
        </xsl:variable>
        <xsl:value-of select="$codelistLabel"/>
    </xsl:template>
    <!-- Template pour les types d'objets géométriques -->
    <xsl:template name="getGeometricObjectTypeLabel">
        <xsl:param name="objectType"/>
        <xsl:variable name="codelistLabel">
            <xsl:call-template name="codelist">
                <xsl:with-param name="code" select="$objectType"/>
                <xsl:with-param name="path">gmd:MD_GeometricObjectTypeCode</xsl:with-param>
            </xsl:call-template>
        </xsl:variable>
        <xsl:choose>
            <xsl:when test="normalize-space($codelistLabel)">
            <xsl:value-of select="$codelistLabel"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="$objectType"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <!-- Template optimisé pour afficher la résolution spatiale -->
    <xsl:template name="displaySpatialResolution">
        <xsl:param name="spatialTypes"/>
        
        <!-- Résolution échelle (vecteur/tabulaire) -->
        <xsl:variable name="denominator" select=".//gmd:spatialResolution/gmd:MD_Resolution/gmd:equivalentScale/gmd:MD_RepresentativeFraction/gmd:denominator/gco:Integer"/>
        <xsl:if test="$denominator and ($spatialTypes[. = 'vector'] or $spatialTypes[. = 'textTable'])">
            <tr>
                <th scope="row">Masstabsnenner</th>
                <td>1:<xsl:value-of select="format-number($denominator, '#,###')"/></td>
            </tr>
        </xsl:if>
        <!-- Résolution distance (raster/TIN) -->
        <xsl:variable name="distance" select=".//gmd:spatialResolution/gmd:MD_Resolution/gmd:distance/gco:Distance"/>
        <xsl:variable name="uom" select=".//gmd:spatialResolution/gmd:MD_Resolution/gmd:distance/gco:Distance/@uom"/>
        <xsl:if test="$distance and ($spatialTypes[. = 'grid'] or $spatialTypes[. = 'tin'])">
            <tr>
                <th scope="row">Auflösung</th>
                <td>
                    <xsl:value-of select="$distance"/>
                    <xsl:if test="$uom">
                        <xsl:text> </xsl:text>
                        <xsl:call-template name="formatUnitOfMeasure">
                            <xsl:with-param name="uom" select="$uom"/>
                        </xsl:call-template>
                    </xsl:if>
                </td>
            </tr>
        </xsl:if>
    </xsl:template>
    <!-- Template pour formater les unités de mesure -->
    <xsl:template name="formatUnitOfMeasure">
        <xsl:param name="uom"/>
        <xsl:choose>
            <xsl:when test="$uom = 'mm'">mm</xsl:when>
            <xsl:when test="$uom = 'cm'">cm</xsl:when>
            <xsl:when test="$uom = 'm'">m</xsl:when>
            <xsl:otherwise><xsl:value-of select="$uom"/></xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <!-- Template principal -->
    <xsl:template match="che:CHE_MD_Metadata">
        <!-- Variables -->
        <xsl:variable name="identifier" select="gmd:fileIdentifier/gco:CharacterString"/>
        <xsl:variable name="urlBase" select="'https://geocat.ch/geonetwork/srv/api/records/'"/>
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
        <xsl:variable name="custodianOrgContact" select=".//che:CHE_MD_DataIdentification/gmd:pointOfContact/che:CHE_CI_ResponsibleParty"/>
        <xsl:variable name="distributorOrgContact" select=".//gmd:MD_Distributor/gmd:distributorContact/che:CHE_CI_ResponsibleParty"/>
        <xsl:variable name="custodianOrgAddress" select="$custodianOrgContact/gmd:contactInfo/gmd:CI_Contact/gmd:address/che:CHE_CI_Address"/>
        <xsl:variable name="distributorOrgAddress" select="$distributorOrgContact/gmd:contactInfo/gmd:CI_Contact/gmd:address/che:CHE_CI_Address"/>
        <xsl:variable name="custodianOrgName" select="substring-before(.//gmd:citedResponsibleParty/che:CHE_CI_ResponsibleParty/gmd:organisationName/gmd:PT_FreeText/gmd:textGroup/gmd:LocalisedCharacterString[@locale='#DE'], ' - ')"/>
        <xsl:variable name="distributorOrgName" select="$distributorOrgContact/gmd:organisationName/gmd:PT_FreeText/gmd:textGroup/gmd:LocalisedCharacterString[@locale='#DE']"/>
        <xsl:variable name="custodianOrgAcronym" select=".//gmd:citedResponsibleParty/che:CHE_CI_ResponsibleParty/che:organisationAcronym/gmd:PT_FreeText/gmd:textGroup/gmd:LocalisedCharacterString[@locale='#DE']"/>
        <xsl:variable name="distributorOrgAcronym" select="$distributorOrgContact/che:organisationAcronym/gmd:PT_FreeText/gmd:textGroup/gmd:LocalisedCharacterString[@locale='#DE']"/>
        <xsl:variable name="onlineResources" select=".//gmd:MD_DigitalTransferOptions/gmd:onLine"/>
        <xsl:variable name="metadataStandardName" select=".//gmd:metadataStandardName/gco:CharacterString"/>
        <!-- Contenu HTML -->
        <html lang="de">
            <head>
                <meta charset="UTF-8"/>
                <meta name="viewport" content="width=device-width, initial-scale=1"/>
                <title>Kanton Wallis - Metadatenkatalog</title>
                <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet"/>
                <!-- Style VS -->
                <style type="text/css">
                    /* Variables globales */
                    :root { --bs-primary: #D52826; --vs-font-family: "Segoe UI", Roboto, "Helvetica Neue", Arial, sans-serif; }                    
                    /* Ecran */
                    body { font-family: var(--vs-font-family); font-size:1rem; line-height:1.5; margin:0; padding:0; }
                    h1 { font-size:2.5rem; line-height:1.2; } 
                    h2 { font-size:1.7rem; } 
                    h3 { font-size:1.2rem; } 
                    p { margin:1rem 0; }
                    a { color:var(--bs-primary); text-decoration:none; } 
                    a:hover, a:active { color:#b3180d; text-decoration:underline; }
                    .table-50-50 { table-layout:fixed; } 
                    .table-50-50 th, .table-50-50 td { width:50%; }
                    /* Vignettes */
                    .thumbnail-wrapper { text-align: center; margin-bottom: 1rem; }
                    .thumbnail-wrapper img { max-width: 100%; height: auto; border: 1px solid #ddd; border-radius: 4px; }
                    /* Impression */
                    @media print {
                        * { -webkit-print-color-adjust:exact!important; color-adjust:exact!important; }
                        body, h1, h3, p, table, th, td { color:#000!important; background:#fff!important; }
                        a, a:visited { color:#D52826!important; text-decoration:underline!important; }
                        .d-print-none, .btn { display:none!important; }
                        body { font-size:11pt; line-height:1.4; }
                        h3 { font-size:12pt; font-weight:bold; margin-top:16pt; margin-bottom:8pt; page-break-after:avoid; }
                        header h2 { background:#D52826; color:#fff; border:none; padding:12pt 8pt; text-align:center; margin-bottom:24pt; font-size:18pt; font-weight:bold; border-radius:4pt; page-break-after:avoid; }
                        .container { max-width:100%!important; margin:0!important; padding:0!important; }
                        .card { border:1pt solid #000!important; box-shadow:none!important; margin:16pt 0 12pt 0!important; page-break-inside:avoid; background:#fff!important; }
                        .card-header { background:#fff; color:#000; border:none; border-bottom:1pt solid #ddd!important; font-weight:600; text-align:center; page-break-after:avoid; padding:12pt 8pt; }
                        .card-body { padding:16pt 12pt 12pt 12pt!important; background:#fff!important; }
                        .table-responsive { overflow:visible!important; page-break-inside:avoid; margin-bottom:16pt; background:#fff!important; border:none!important; }
                        table { border-collapse:collapse!important; width:100%!important; margin-bottom:12pt; page-break-inside:avoid; background:#fff!important; border:1pt solid #ddd!important; }
                        th { white-space:nowrap; background:#fff!important; color:#000!important; font-weight:600; padding:6pt 8pt!important; vertical-align:top; border-right:1pt solid #ddd!important; }
                        td { background:#fff!important; color:#000!important; padding:6pt 8pt!important; vertical-align:top; word-wrap:break-word; border:none!important; }
                        tr:nth-child(odd) th, tr:nth-child(odd) td { background:#f8f9fa!important; }
                        .thumbnail-wrapper { text-align: center !important; margin-bottom: 12pt !important; }
                        .thumbnail-wrapper img { display: inline-block !important; max-width: 95% !important; height: auto !important; border: 1pt solid #ddd !important; page-break-inside: avoid !important; border-radius: 0 !important; }
                        p, td, th { orphans:3; widows:3; }
                        .page-break { page-break-before:always; }
                        [class*="col-"], .row, .container, .card, .card-body, .card-header, .col-12, .col-md-4 { border:none!important; box-shadow:none!important; }
                    }
                </style>
            </head>
            <body class="bg-white">
                <!-- Header -->
                <header class="container py-3">
                    <h2 class="text-center mt-3 mb-0 py-3 rounded" style="background-color:#D52826; color:#fff; font-size: clamp(1.5rem, 4vw, 2.2rem);">
                        Metadatenkatalog - Komplett
                    </h2>
                </header>
                <!-- Navigation -->
                <nav class="container my-3 d-print-none">
                    <div class="row g-2">
                        <div class="col-12 col-md-4 d-flex justify-content-center justify-content-md-start">
                            <a class="btn btn-outline-danger btn-sm" 
                               href="{concat($urlBase, $identifier, '/formatters/vs_full_de?width=_100&amp;mdpath=md.format.pdf&amp;output=pdf&amp;approved=true')}" 
                               target="_blank">Datenblatt drucken (PDF)</a>
                        </div>
                        <div class="col-12 col-md-4 text-center">
                            <a class="btn btn-outline-danger btn-sm" href="{concat($urlBase, $identifier, '/formatters/vs_simple_de?language=ger')}">Standardansicht</a>
                        </div>
                        <div class="col-12 col-md-4 d-flex justify-content-center justify-content-md-end">
                            <a class="btn btn-outline-danger btn-sm" 
                               href="{concat($urlBase, $identifier, '/formatters/vs_full_fr?language=fre')}" 
                               target="_blank">Französische Fassung</a>
                        </div>
                    </div>
                </nav>
                <!-- Contenu principal -->
                <main class="container">
                    <article class="card mb-4">
                        <xsl:if test="$citationTitle">
                            <h2 class="card-header text-center bg-white">
                                <xsl:value-of select="$citationTitle"/>
                            </h2>
                        </xsl:if>
                        <div class="card-body">
                            <xsl:if test="$thumbnail">
                                <div class="thumbnail-wrapper">
                                    <img src="{$thumbnail}" alt="Vorschau von {$citationTitle}"/>
                                </div>
                            </xsl:if>
                            <xsl:if test="$abstract">
                                <h3>Kurzbeschreibung</h3>
                                <p><xsl:value-of select="$abstract"/></p>
                            </xsl:if>
                            <xsl:if test="$purpose">
                                <h3>Zweck</h3>
                                <p><xsl:value-of select="$purpose"/></p>
                            </xsl:if>
                            <h3 class="mt-4">Aktualisierungsinformationen</h3>
                            <div class="table-responsive">
                                <table class="table table-bordered table-sm table-striped table-hover align-middle table-50-50">
                                    <tbody>
                                        <xsl:if test="$statusCode">
                                            <tr>
                                                <th scope="row">Bearbeitungsstatus</th>
                                                <td>
                                                    <xsl:call-template name="codelist">
                                                        <xsl:with-param name="code" select="$statusCode"/>
                                                        <xsl:with-param name="path">gmd:MD_ProgressCode</xsl:with-param>
                                                    </xsl:call-template>
                                                </td>
                                            </tr>
                                        </xsl:if>
                                        <xsl:if test="$creationDate">
                                            <tr>
                                                <th scope="row">Datum Erstellung</th>
                                                <td>
                                                    <xsl:call-template name="formatDate">
                                                        <xsl:with-param name="date" select="$creationDate"/>
                                                    </xsl:call-template>
                                                </td>
                                            </tr>
                                        </xsl:if>
                                        <xsl:if test="$revisionDate">
                                            <tr>
                                                <th scope="row">Datum Überarbeitung</th>
                                                <td>
                                                    <xsl:call-template name="formatDate">
                                                        <xsl:with-param name="date" select="$revisionDate"/>
                                                    </xsl:call-template>
                                                </td>
                                            </tr>
                                        </xsl:if>
                                        <xsl:if test="$basicGeodataID">
                                            <tr>
                                                <th scope="row">Geobasisdaten-ID</th>
                                                <td><xsl:value-of select="$basicGeodataID"/></td>
                                            </tr>
                                        </xsl:if>
                                    </tbody>
                                </table>
                                <h3 class="mt-4">Basisinformation</h3>
                                    <div class="table-responsive">
                                        <table class="table table-bordered table-sm table-striped table-hover align-middle table-50-50">
                                            <tbody>
                                                <xsl:if test="$dataSetURI">
                                                    <tr>
                                                        <th scope="row">URI des Datenbestands</th>
                                                        <td><a href="{$dataSetURI}" target="_blank">Link</a></td>
                                                    </tr>
                                                </xsl:if>
                                                <tr>
                                                    <th scope="row">Verwalter</th>
                                                    <td>
                                                        <xsl:if test="$custodianOrgName"><xsl:value-of select="$custodianOrgName"/><br/></xsl:if>
                                                        <xsl:if test="$custodianOrgAcronym"><xsl:value-of select="$custodianOrgAcronym"/><br/></xsl:if>
                                                        <xsl:call-template name="formatContact">
                                                            <xsl:with-param name="contact" select="$custodianOrgContact"/>
                                                        </xsl:call-template>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <th scope="row">Thematik</th>
                                                    <td>
                                                        <xsl:variable name="lastTopic" select="$topicCategories[last()]"/>
                                                        <xsl:call-template name="getTopicCategoryLabel">
                                                            <xsl:with-param name="topicCode" select="$lastTopic/@codeListValue | $lastTopic"/>
                                                        </xsl:call-template>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <th scope="row">Stichwörter</th>
                                                    <td>
                                                        <xsl:for-each select="$keywords">
                                                            <xsl:if test="normalize-space(.)">
                                                                <xsl:value-of select="."/>
                                                                <xsl:if test="position() != last()"><br/></xsl:if>
                                                            </xsl:if>
                                                        </xsl:for-each>
                                                    </td>
                                                </tr>
                                                <xsl:if test="$spatialRepresentationTypes">
                                                    <tr>
                                                        <th scope="row">Räumliche Darstellungsart</th>
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
                                                        <th scope="row">Geometrische Objekte</th>
                                                        <td>
                                                            <xsl:for-each select="$geometricObjects">
                                                                <xsl:variable name="objectType" select="gmd:geometricObjectType/gmd:MD_GeometricObjectTypeCode/@codeListValue"/>
                                                                <xsl:variable name="objectCount" select="gmd:geometricObjectCount/gco:Integer"/>
                                                                
                                                                <xsl:call-template name="getGeometricObjectTypeLabel">
                                                                    <xsl:with-param name="objectType" select="$objectType"/>
                                                                </xsl:call-template>
                                                                
                                                                <xsl:if test="$objectCount">
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
                                                <xsl:if test="$referenceSystem">
                                                    <tr>
                                                        <th scope="row">Referenzsystem</th>
                                                        <td>
                                                            <xsl:value-of select="$referenceSystem"/>
                                                            <xsl:if test="$referenceSystemCodeSpace">
                                                                <xsl:text> (</xsl:text><xsl:value-of select="$referenceSystemCodeSpace"/><xsl:text>)</xsl:text>
                                                            </xsl:if>
                                                        </td>
                                                    </tr>
                                                </xsl:if>
                                            </tbody>
                                        </table>
                                    </div>
                                <xsl:if test="$lineage or $source">
                                    <h3 class="section-title">Datenqualität</h3>
                                    <div class="table-responsive">
                                        <table class="table table-bordered table-sm table-striped table-hover align-middle table-50-50">
                                            <tbody>
                                                <xsl:if test="$lineage">
                                                    <tr>
                                                        <th scope="row">Herkunft</th>
                                                        <td><xsl:value-of select="$lineage"/></td>
                                                    </tr>
                                                </xsl:if>
                                                <xsl:if test="$source">
                                                    <tr>
                                                        <th scope="row">Datenquelle</th>
                                                        <td><xsl:value-of select="$source"/></td>
                                                    </tr>
                                                </xsl:if>
                                            </tbody>
                                        </table>
                                    </div>
                                </xsl:if>
                                <!-- Contraintes sur la ressource  -->
                                <xsl:if test="$useLimitation or $otherConstraints">
                                    <h3 class="mt-4">Ressourceneinschränkungen</h3>
                                        <div class="table-responsive">
                                            <table class="table table-bordered table-sm table-striped table-hover align-middle table-50-50">
                                                <tbody>
                                                    <xsl:if test="$useLimitation">
                                                        <tr>
                                                            <th scope="row">Anwendungseinschränkungen</th>
                                                            <td><xsl:value-of select="$useLimitation"/></td>
                                                        </tr>
                                                    </xsl:if>
                                                    <xsl:if test="$otherConstraints">
                                                        <tr>
                                                            <th scope="row">Andere Einschränkungen</th>
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
                                        </div>
                                </xsl:if>
                                <xsl:if test="$legislationTitle">
                                    <h3 class="mt-4">Rechtsvorschrift(en)</h3>
                                    <div class="table-responsive">
                                        <table class="table table-bordered table-sm table-striped table-hover align-middle table-50-50">
                                            <tbody>
                                                <tr>
                                                    <th scope="row">Liste</th>
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
                                    </div>
                                </xsl:if>
                                <h3 class="mt-4">Pflege der Ressource</h3>
                                <div class="table-responsive">
                                    <table class="table table-bordered table-sm table-striped table-hover align-middle table-50-50">
                                        <tbody>
                                            <xsl:if test="$maintenanceFrequency or $maintenanceNote">
                                                <xsl:if test="$maintenanceFrequency">
                                                    <tr>
                                                        <th scope="row">Überarbeitungsintervall</th>
                                                        <td>
                                                            <xsl:call-template name="codelist">
                                                                <xsl:with-param name="code" select="$maintenanceFrequency"/>
                                                                <xsl:with-param name="path">gmd:MD_MaintenanceFrequencyCode</xsl:with-param>
                                                            </xsl:call-template>
                                                        </td>
                                                    </tr>
                                                </xsl:if>
                                                <xsl:if test="$maintenanceNote">
                                                    <tr>
                                                        <th scope="row">Anmerkung</th>
                                                        <td><xsl:value-of select="$maintenanceNote"/></td>
                                                    </tr>
                                                </xsl:if>
                                            </xsl:if>
                                        </tbody>
                                    </table>
                                </div>
                                <xsl:if test="$catalogueCreationDate and $catalogueTitle and $dataModelURL">
                                    <h3 class="mt-4">Objektkatalog und Datenmodell</h3>
                                    <div class="table-responsive">
                                        <table class="table table-bordered table-sm table-striped table-hover align-middle table-50-50">
                                            <tbody>
                                                <tr>
                                                    <th scope="row">Erstellungsdatum</th>
                                                    <td>
                                                        <xsl:call-template name="formatDate">
                                                            <xsl:with-param name="date" select="$catalogueCreationDate"/>
                                                        </xsl:call-template>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <th scope="row">Titel</th>
                                                    <td>
                                                        <a href="{$dataModelURL}" target="_blank">
                                                            <xsl:value-of select="$catalogueTitle"/>
                                                        </a>
                                                    </td>
                                                </tr>
                                            </tbody>
                                        </table>
                                    </div>
                                </xsl:if>
                                <xsl:if test="$portrayalDate and $portrayalTitle and $portrayalURL">
                                    <h3 class="mt-4">Darstellungskatalog</h3>
                                    <div class="table-responsive">
                                        <table class="table table-bordered table-sm table-striped table-hover align-middle table-50-50">
                                            <tbody>
                                                    <tr>
                                                        <th scope="row">Erstellungsdatum</th>
                                                        <td>
                                                            <xsl:call-template name="formatDate">
                                                                <xsl:with-param name="date" select="$portrayalDate"/>
                                                            </xsl:call-template>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <th scope="row">Link</th>
                                                        <td>
                                                            <a href="{$portrayalURL}" target="_blank">
                                                                <xsl:value-of select="$portrayalTitle"/>
                                                            </a>
                                                        </td>
                                                    </tr>
                                            </tbody>
                                        </table>
                                    </div>
                                </xsl:if>
                                <h3 class="mt-4">Vertriebsinformation</h3>
                                    <div class="table-responsive">
                                        <table class="table table-bordered table-sm table-striped table-hover align-middle table-50-50">
                                            <tbody>
                                                <xsl:for-each select="$onlineResources">
                                                    <!-- Tri personnalisé : priorité par type de service et fournisseur -->
                                                    <xsl:sort select="
                                                        (gmd:CI_OnlineResource/gmd:protocol/gco:CharacterString = 'ESRI:REST') * -6 +
                                                        (starts-with(gmd:CI_OnlineResource/gmd:protocol/gco:CharacterString, 'OGC:')) * -5 +
                                                        (gmd:CI_OnlineResource/gmd:protocol/gco:CharacterString = 'WWW:DOWNLOAD:ZIP' and 
                                                          (contains(gmd:CI_OnlineResource/gmd:name/gmd:PT_FreeText/gmd:textGroup/gmd:LocalisedCharacterString[@locale='#FR'], 'GDB') or 
                                                           contains(gmd:CI_OnlineResource/gmd:name/gmd:PT_FreeText/gmd:textGroup/gmd:LocalisedCharacterString[@locale='#FR'], 'GPKG'))) * -4 +
                                                        (gmd:CI_OnlineResource/gmd:protocol/gco:CharacterString = 'WWW:DOWNLOAD-APP'
                                                          and gmd:CI_OnlineResource/gmd:name/gmd:PT_FreeText/gmd:textGroup/gmd:LocalisedCharacterString[@locale='#FR'] = 'OpenData Valais') * -3 +
                                                        (contains(gmd:CI_OnlineResource/gmd:name/gmd:PT_FreeText/gmd:textGroup/gmd:LocalisedCharacterString[@locale='#FR'], 'geodienste.ch')) * -2 +
                                                        (gmd:CI_OnlineResource/gmd:protocol/gco:CharacterString = 'CHTOPO:specialised-geoportal') * -1
                                                    " data-type="number"/>
                                                    <xsl:sort select="gmd:CI_OnlineResource/gmd:name/gmd:PT_FreeText/gmd:textGroup/gmd:LocalisedCharacterString[@locale='#DE']"/>
                                                    <xsl:variable name="resourceName" select="gmd:CI_OnlineResource/gmd:name/gmd:PT_FreeText/gmd:textGroup/gmd:LocalisedCharacterString[@locale='#DE']"/>
                                                    <xsl:variable name="resourceDescription" select="gmd:CI_OnlineResource/gmd:description/gmd:PT_FreeText/gmd:textGroup/gmd:LocalisedCharacterString[@locale='#DE']"/>
                                                    <xsl:variable name="resourceURL" select="gmd:CI_OnlineResource/gmd:linkage/che:PT_FreeURL/che:URLGroup/che:LocalisedURL[@locale='#DE']"/>
                                                    <xsl:variable name="resourceProtocol" select="gmd:CI_OnlineResource/gmd:protocol/gco:CharacterString"/>                                                    
                                                    <xsl:choose>
                                                        <!-- ESRI:REST -->
                                                        <xsl:when test="$resourceProtocol = 'ESRI:REST'">
                                                            <!-- Aggrégation des différents liens -->
                                                            <xsl:if test="not(preceding-sibling::gmd:onLine[gmd:CI_OnlineResource/gmd:protocol/gco:CharacterString = 'ESRI:REST'])">
                                                                <xsl:variable name="allRestServices" select="../gmd:onLine[gmd:CI_OnlineResource/gmd:protocol/gco:CharacterString = 'ESRI:REST']"/>
                                                                <tr>
                                                                    <th scope="row">ArcGIS REST Services</th>
                                                                    <td>
                                                                        <xsl:for-each select="$allRestServices">
                                                                            <xsl:variable name="serviceURL" select="gmd:CI_OnlineResource/gmd:linkage/che:PT_FreeURL/che:URLGroup/che:LocalisedURL[@locale='#DE']"/>
                                                                            <xsl:variable name="serviceName" select="gmd:CI_OnlineResource/gmd:name/gmd:PT_FreeText/gmd:textGroup/gmd:LocalisedCharacterString[@locale='#DE']"/>
                                                                            <xsl:variable name="serviceDescription" select="gmd:CI_OnlineResource/gmd:description/gmd:PT_FreeText/gmd:textGroup/gmd:LocalisedCharacterString[@locale='#DE']"/>
                                                                            
                                                                            <a href="{$serviceURL}" target="_blank">
                                                                                <xsl:choose>
                                                                                    <xsl:when test="$serviceDescription">
                                                                                        <xsl:value-of select="$serviceDescription"/>
                                                                                    </xsl:when>
                                                                                    <xsl:when test="$serviceName">
                                                                                        <xsl:value-of select="$serviceName"/>
                                                                                    </xsl:when>
                                                                                    <xsl:otherwise>
                                                                                        <xsl:value-of select="$serviceURL"/>
                                                                                    </xsl:otherwise>
                                                                                </xsl:choose>
                                                                            </a>
                                                                            <xsl:if test="position() != last()"><br/></xsl:if>
                                                                        </xsl:for-each>
                                                                    </td>
                                                                </tr>
                                                            </xsl:if>
                                                        </xsl:when>
                                                        <!-- OGC:WFS -->
                                                        <xsl:when test="$resourceProtocol = 'OGC:WFS'">
                                                            <xsl:if test="not(preceding-sibling::gmd:onLine[gmd:CI_OnlineResource/gmd:protocol/gco:CharacterString = 'OGC:WFS' and gmd:CI_OnlineResource/gmd:linkage/che:PT_FreeURL/che:URLGroup/che:LocalisedURL[@locale='#DE'] = $resourceURL])">
                                                                <tr>
                                                                    <th scope="row">OGC Web Feature Service (WFS)</th>
                                                                    <td>
                                                                        <xsl:for-each select="../gmd:onLine[gmd:CI_OnlineResource/gmd:protocol/gco:CharacterString = 'OGC:WFS' and gmd:CI_OnlineResource/gmd:linkage/che:PT_FreeURL/che:URLGroup/che:LocalisedURL[@locale='#DE'] = $resourceURL]">
                                                                            <xsl:variable name="layerDescription" select="gmd:CI_OnlineResource/gmd:description/gmd:PT_FreeText/gmd:textGroup/gmd:LocalisedCharacterString[@locale='#DE']"/>
                                                                            <xsl:if test="position() > 1"><br/></xsl:if>
                                                                            <a href="{$resourceURL}" target="_blank">
                                                                                <xsl:choose>
                                                                                    <xsl:when test="$layerDescription">
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
                                                                    <th scope="row">OGC Web Map Service (WMS)</th>
                                                                    <td>
                                                                        <xsl:for-each select="../gmd:onLine[gmd:CI_OnlineResource/gmd:protocol/gco:CharacterString = 'OGC:WMS' and gmd:CI_OnlineResource/gmd:linkage/che:PT_FreeURL/che:URLGroup/che:LocalisedURL[@locale='#DE'] = $resourceURL]">
                                                                            <xsl:variable name="layerDescription" select="gmd:CI_OnlineResource/gmd:description/gmd:PT_FreeText/gmd:textGroup/gmd:LocalisedCharacterString[@locale='#DE']"/>
                                                                            <xsl:if test="position() > 1"><br/></xsl:if>
                                                                            <a href="{$resourceURL}" target="_blank">
                                                                                <xsl:choose>
                                                                                    <xsl:when test="$layerDescription">
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
                                                        <!-- WWW:DOWNLOAD:ZIP-->
                                                        <xsl:when test="$resourceProtocol = 'WWW:DOWNLOAD:ZIP' and (contains($resourceName, 'GDB') or contains($resourceName, 'GPKG'))">
                                                            <!-- Aggrégation des ressources -->
                                                            <xsl:if test="not(preceding-sibling::gmd:onLine[gmd:CI_OnlineResource/gmd:protocol/gco:CharacterString = 'WWW:DOWNLOAD:ZIP'][contains(gmd:CI_OnlineResource/gmd:name/gmd:PT_FreeText/gmd:textGroup/gmd:LocalisedCharacterString[@locale='#DE'], 'GDB') or contains(gmd:CI_OnlineResource/gmd:name/gmd:PT_FreeText/gmd:textGroup/gmd:LocalisedCharacterString[@locale='#DE'], 'GPKG')])">
                                                                <xsl:variable name="allZipResources" select="../gmd:onLine[gmd:CI_OnlineResource/gmd:protocol/gco:CharacterString = 'WWW:DOWNLOAD:ZIP']"/>
                                                                <tr>
                                                                    <th scope="row">Daten-Download (ZIP)</th>
                                                                    <td>
                                                                        <!-- Liens de téléchargement de la GDB -->
                                                                        <xsl:for-each select="$allZipResources[contains(gmd:CI_OnlineResource/gmd:name/gmd:PT_FreeText/gmd:textGroup/gmd:LocalisedCharacterString[@locale='#DE'], 'GDB')]">
                                                                            <xsl:variable name="url" select="gmd:CI_OnlineResource/gmd:linkage/che:PT_FreeURL/che:URLGroup/che:LocalisedURL[@locale='#DE']"/>
                                                                            <a href="{$url}" target="_blank">ESRI File Geodatabase FileGDB (GDB)</a>
                                                                            <xsl:if test="position() != last()"><br/></xsl:if>
                                                                        </xsl:for-each>                                                                        
                                                                        <!-- Liens de téléchargement du GPKG -->
                                                                        <xsl:for-each select="$allZipResources[contains(gmd:CI_OnlineResource/gmd:name/gmd:PT_FreeText/gmd:textGroup/gmd:LocalisedCharacterString[@locale='#DE'], 'GPKG')]">
                                                                            <xsl:variable name="url" select="gmd:CI_OnlineResource/gmd:linkage/che:PT_FreeURL/che:URLGroup/che:LocalisedURL[@locale='#DE']"/>
                                                                            <xsl:if test="position() = 1 and $allZipResources[contains(gmd:CI_OnlineResource/gmd:name/gmd:PT_FreeText/gmd:textGroup/gmd:LocalisedCharacterString[@locale='#DE'], 'GDB')]"><br/></xsl:if>
                                                                            <a href="{$url}" target="_blank">OGC Geopackage (GPKG)</a>
                                                                            <xsl:if test="position() != last()"><br/></xsl:if>
                                                                        </xsl:for-each>
                                                                    </td>
                                                                </tr>
                                                            </xsl:if>
                                                        </xsl:when>
                                                        <!-- OpenData Valais -->
                                                        <xsl:when test="$resourceProtocol = 'WWW:DOWNLOAD-APP' and $resourceName = 'OpenData Valais'">
                                                            <!-- Aggrégation des différents liens -->
                                                            <xsl:if test="not(preceding-sibling::gmd:onLine[gmd:CI_OnlineResource/gmd:protocol/gco:CharacterString = 'WWW:DOWNLOAD-APP' and gmd:CI_OnlineResource/gmd:name/gmd:PT_FreeText/gmd:textGroup/gmd:LocalisedCharacterString[@locale='#DE'] = 'OpenData Valais'])">
                                                                <xsl:variable name="allOpenDataServices" select="../gmd:onLine[gmd:CI_OnlineResource/gmd:protocol/gco:CharacterString = 'WWW:DOWNLOAD-APP' and gmd:CI_OnlineResource/gmd:name/gmd:PT_FreeText/gmd:textGroup/gmd:LocalisedCharacterString[@locale='#DE'] = 'OpenData Valais']"/>
                                                                <tr>
                                                                    <th scope="row">Download-Service<xsl:if test="count($allOpenDataServices) > 1">s</xsl:if> OpenData Wallis</th>
                                                                    <td>
                                                                        <xsl:for-each select="$allOpenDataServices">
                                                                            <xsl:variable name="serviceURL" select="gmd:CI_OnlineResource/gmd:linkage/che:PT_FreeURL/che:URLGroup/che:LocalisedURL[@locale='#DE']"/>
                                                                            <xsl:variable name="serviceDescription" select="gmd:CI_OnlineResource/gmd:description/gmd:PT_FreeText/gmd:textGroup/gmd:LocalisedCharacterString[@locale='#DE']"/>
                                                                            <a href="{$serviceURL}" target="_blank">Link</a>
                                                                            <xsl:if test="position() != last()"><br/></xsl:if>
                                                                        </xsl:for-each>
                                                                    </td>
                                                                </tr>
                                                            </xsl:if>
                                                        </xsl:when>
                                                        <!-- geodienste.ch -->
                                                       <xsl:when test="contains($resourceName,'geodienste.ch')">
                                                            <tr>
                                                                <th scope="row">Download-Link geodienste.ch</th>
                                                                <td>
                                                                    <a href="{$resourceURL}" target="_blank">
                                                                        <xsl:choose>
                                                                            <xsl:when test="$resourceDescription">
                                                                                <xsl:value-of select="$resourceDescription"/>
                                                                            </xsl:when>
                                                                            <xsl:when test="$resourceName">
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
                                                                <th scope="row">Geoportal des Kantons Wallis</th>
                                                                <td>
                                                                    <a href="{$resourceURL}" target="_blank">Link</a>
                                                                </td>
                                                            </tr>	
                                                        </xsl:when>
                                                    </xsl:choose>
                                                </xsl:for-each>
                                                <!-- Ressource interne -->
                                                <xsl:if test="$internalResource">
                                                    <tr>
                                                        <th scope="row">Interne Ressource</th>
                                                        <td><xsl:value-of select="$internalResource"/></td>
                                                    </tr>
                                                </xsl:if>
                                                <!-- Identifiant interne -->
                                                <xsl:if test="$internalResourceID">
                                                    <tr>
                                                        <th scope="row">Interne Identifikationsnummer</th>
                                                        <td><xsl:value-of select="$internalResourceID"/></td>
                                                    </tr>
                                                </xsl:if>
                                                <tr>
                                                    <th scope="row">Vertrieb</th>
                                                    <td>
                                                        <xsl:if test="$distributorOrgName">
                                                            <xsl:for-each select="tokenize($distributorOrgName, ' - ')">
                                                                <xsl:value-of select="."/><br/>
                                                            </xsl:for-each>
                                                        </xsl:if>
                                                        <xsl:call-template name="formatContact">
                                                            <xsl:with-param name="contact" select="$distributorOrgContact"/>
                                                        </xsl:call-template>
                                                    </td>
                                                </tr>
                                                <!-- Format de la ressource -->
                                                <xsl:if test="$resourceFormats">
                                                    <tr>
                                                        <th scope="row">Ressourcenformat<xsl:if test="count($resourceFormats) > 1">s</xsl:if>e</th>
                                                        <td>
                                                            <xsl:for-each select="$resourceFormats">
                                                                <xsl:variable name="formatName" select="gmd:name/gco:CharacterString"/>
                                                                <xsl:variable name="formatVersion" select="gmd:version/gco:CharacterString"/>
                                                                <xsl:if test="$formatName">
                                                                    <xsl:value-of select="$formatName"/>
                                                                    <xsl:if test="$formatVersion">
                                                                        <xsl:text> (version </xsl:text><xsl:value-of select="$formatVersion"/><xsl:text>)</xsl:text>
                                                                    </xsl:if>
                                                                    <xsl:if test="position() != last()"><br/></xsl:if>
                                                                </xsl:if>
                                                            </xsl:for-each>
                                                        </td>
                                                    </tr>
                                                </xsl:if>
                                            </tbody>
                                        </table>
                                    </div>
                                <h3 class="mt-4">Metadaten</h3>
                                    <div class="table-responsive">
                                        <table class="table table-bordered table-sm table-striped table-hover align-middle table-50-50">
                                            <tbody>
                                                <xsl:if test="$identifier">
                                                    <tr>
                                                        <th scope="row">Metadatensatzidentifikator</th>
                                                        <td><xsl:value-of select="$identifier"/></td>
                                                    </tr>
                                                </xsl:if>
                                                <xsl:if test="$dateStamp">
                                                    <tr>
                                                        <th class="label">Überarbeitungsdatum</th>
                                                        <td>
                                                            <xsl:call-template name="formatDate">
                                                                <xsl:with-param name="date" select="substring($dateStamp,1,10)"/>
                                                            </xsl:call-template>
                                                        </td>
                                                    </tr>
                                                </xsl:if>
                                                <tr>
                                                    <th scope="row">Bezeichnung des Metadatenstandards</th>
                                                    <td><xsl:value-of select="$metadataStandardName"/></td>
                                                </tr>
                                            </tbody>
                                        </table>
                                    </div>
                            </div>
                        </div>
                    </article>
                </main>
            </body>
        </html>
    </xsl:template>
</xsl:stylesheet>
