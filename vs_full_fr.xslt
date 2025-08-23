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
            <!-- Si c'est déjà une date au format YYYY-MM-DD (10 caractères) -->
            <xsl:when test="string-length($date) = 10">
                <xsl:value-of select="concat(substring($date,9,2),'.',substring($date,6,2),'.',substring($date,1,4))"/>
            </xsl:when>
            <!-- Si c'est un DateTime (plus de 10 caractères), extraire la partie date -->
            <xsl:when test="string-length($date) > 10">
                <xsl:variable name="dateOnly" select="substring($date,1,10)"/>
                <xsl:value-of select="concat(substring($dateOnly,9,2),'.',substring($dateOnly,6,2),'.',substring($dateOnly,1,4))"/>
            </xsl:when>
        </xsl:choose>
    </xsl:template>    <xsl:template name="getStatus">
        <xsl:param name="statusCode"/>
        <xsl:choose>
            <xsl:when test="$statusCode = 'onGoing'">Mise à jour continue</xsl:when>
            <xsl:when test="$statusCode = 'completed'">Finalisé</xsl:when>
            <xsl:when test="$statusCode = 'underDevelopment'">En cours de création</xsl:when>
            <xsl:when test="$statusCode = 'planned'">Planifié</xsl:when>
            <xsl:when test="$statusCode = 'required'">Création ou mise à jour requise</xsl:when>
            <xsl:when test="$statusCode = 'obsolete'">Obsolète</xsl:when>
            <xsl:when test="$statusCode = 'historicalArchive'">Archivé</xsl:when>
            <xsl:otherwise><xsl:value-of select="$statusCode"/></xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <!-- Langues -->
    <xsl:template name="getLanguageLabel">
        <xsl:param name="languageCode"/>
        <xsl:choose>
            <xsl:when test="$languageCode = 'fre'">Français</xsl:when>
            <xsl:when test="$languageCode = 'ger'">Allemand</xsl:when>
            <xsl:when test="$languageCode = 'ita'">Italien</xsl:when>
            <xsl:when test="$languageCode = 'eng'">Anglais</xsl:when>
            <xsl:when test="$languageCode = 'roh'">Romanche</xsl:when>
            <xsl:otherwise><xsl:value-of select="$languageCode"/></xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <!-- Thématiques -->
    <xsl:template name="getTopicCategoryLabel">
        <xsl:param name="topicCode"/>
        <xsl:choose>
            <xsl:when test="$topicCode = 'imageryBaseMapsEarthCover'">A Cartes de référence, couverture du sol, images aériennes</xsl:when>
            <xsl:when test="$topicCode = 'imageryBaseMapsEarthCover_BaseMaps'">A1 Cartes de référence, modèles du territoire</xsl:when>
            <xsl:when test="$topicCode = 'imageryBaseMapsEarthCover_EarthCover'">A2 Couverture et utilisation du sol</xsl:when>
            <xsl:when test="$topicCode = 'imageryBaseMapsEarthCover_Imagery'">A3 Images aériennes et satellitaires</xsl:when>
            <xsl:when test="$topicCode = 'location'">B Localisation, systèmes de référence</xsl:when>
            <xsl:when test="$topicCode = 'elevation'">C Altimétrie</xsl:when>
            <xsl:when test="$topicCode = 'boundaries'">D Limites politiques et administratives</xsl:when>
            <xsl:when test="$topicCode = 'planningCadastre_Planning'">E1 Développement territorial</xsl:when>
            <xsl:when test="$topicCode = 'planningCadastre_Cadastre'">E2 Cadastre foncier</xsl:when>
            <xsl:when test="$topicCode = 'geoscientificInformation'">F Géologie, sols, dangers naturels</xsl:when>
            <xsl:when test="$topicCode = 'geoscientificInformation_Geology'">F1 Géologie</xsl:when>
            <xsl:when test="$topicCode = 'geoscientificInformation_Soils'">F2 Sols</xsl:when>
            <xsl:when test="$topicCode = 'geoscientificInformation_NaturalHazards'">F3 Dangers naturels</xsl:when>
            <xsl:when test="$topicCode = 'biota'">G Forêt, flore, faune</xsl:when>
            <xsl:when test="$topicCode = 'oceans'">H Océans</xsl:when>
            <xsl:when test="$topicCode = 'inlandWaters'">I Hydrographie</xsl:when>
            <xsl:when test="$topicCode = 'climatologyMeteorologyAtmosphere'">K Atmosphère, climatologie</xsl:when>
            <xsl:when test="$topicCode = 'environment'">L Protection de l'environnement et de la nature</xsl:when>
            <xsl:when test="$topicCode = 'environment_EnvironmentalProtection'">L1 Protection de l'environnement, bruit</xsl:when>
            <xsl:when test="$topicCode = 'environment_NatureProtection'">L2 Protection de la nature et du paysage</xsl:when>
            <xsl:when test="$topicCode = 'society'">M Population, Société, culture</xsl:when>
            <xsl:when test="$topicCode = 'health'">N Santé</xsl:when>
            <xsl:when test="$topicCode = 'structure'">O Edifices, infrastructures, ouvrages</xsl:when>
            <xsl:when test="$topicCode = 'transportation'">P Transport</xsl:when>
            <xsl:when test="$topicCode = 'utilitiesCommunication'">Q Approvisionnement, élimination, communication</xsl:when>
            <xsl:when test="$topicCode = 'utilitiesCommunication_Energy'">Q1 Energie</xsl:when>
            <xsl:when test="$topicCode = 'utilitiesCommunication_Utilities'">Q2 Systèmes des eaux et des déchets</xsl:when>
            <xsl:when test="$topicCode = 'utilitiesCommunication_Communication'">Q3 Communication</xsl:when>
            <xsl:when test="$topicCode = 'intelligenceMilitary'">R Armée, sécurité</xsl:when>
            <xsl:when test="$topicCode = 'farming'">S Agriculture</xsl:when>
            <xsl:when test="$topicCode = 'economy'">T Activités économiques</xsl:when>
            <xsl:otherwise><xsl:value-of select="$topicCode"/></xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <!-- Type de représentation spatiale -->
    <xsl:template name="getSpatialRepresentationTypeLabel">
        <xsl:param name="spatialType"/>
        <xsl:choose>
            <xsl:when test="$spatialType = 'vector'">Vecteur</xsl:when>
            <xsl:when test="$spatialType = 'grid'">Raster</xsl:when>
            <xsl:when test="$spatialType = 'textTable'">Tabulaire</xsl:when>
            <xsl:when test="$spatialType = 'tin'">TIN</xsl:when>
            <xsl:when test="$spatialType = 'stereoModel'">Modèle stéréoscopique</xsl:when>
            <xsl:when test="$spatialType = 'video'">Vidéo</xsl:when>
            <xsl:when test="$spatialType = 'paperMap'">Carte papier</xsl:when>
            <xsl:otherwise><xsl:value-of select="$spatialType"/></xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <!-- Type d'objet géométrique -->
    <xsl:template name="getGeometricObjectTypeLabel">
        <xsl:param name="objectType"/>
        <xsl:choose>
            <xsl:when test="$objectType = 'point'">Point</xsl:when>
            <xsl:when test="$objectType = 'curve'">Ligne</xsl:when>
            <xsl:when test="$objectType = 'surface'">Polygone</xsl:when>
            <xsl:when test="$objectType = 'solid'">Volume</xsl:when>
            <xsl:when test="$objectType = 'complex'">Complexe</xsl:when>
            <xsl:when test="$objectType = 'composite'">Composite</xsl:when>
            <xsl:otherwise><xsl:value-of select="$objectType"/></xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <!-- Résolution spatiale -->
    <xsl:template name="displaySpatialResolution">
        <xsl:param name="spatialTypes"/>
        <xsl:variable name="hasVector" select="$spatialTypes[. = 'vector']"/>
        <xsl:variable name="hasGrid" select="$spatialTypes[. = 'grid']"/>
        
        <!-- Résolution vectorielle (échelle) -->
        <xsl:if test="$hasVector">
            <xsl:variable name="denominator" select=".//gmd:spatialResolution/gmd:MD_Resolution/gmd:equivalentScale/gmd:MD_RepresentativeFraction/gmd:denominator/gco:Integer"/>
            <xsl:if test="$denominator != ''">
                <tr>
                    <td class="label">Dénominateur d'échelle</td>
                    <td>1:<xsl:value-of select="$denominator"/></td>
                </tr>
            </xsl:if>
        </xsl:if>
        
        <!-- Résolution raster (distance) -->
        <xsl:if test="$hasGrid">
            <xsl:variable name="distance" select=".//gmd:spatialResolution/gmd:MD_Resolution/gmd:distance/gco:Distance"/>
            <xsl:variable name="uom" select=".//gmd:spatialResolution/gmd:MD_Resolution/gmd:distance/gco:Distance/@uom"/>
            <xsl:if test="$distance != ''">
                <tr>
                    <td class="label">Résolution</td>
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

    <!-- Template pour formater le texte de législation -->
    <xsl:template name="formatLegislationText">
        <xsl:param name="text"/>
        <xsl:choose>
            <xsl:when test="contains($text, '*')">
                <xsl:variable name="beforeFirst" select="substring-before($text, '*')"/>
                <xsl:variable name="afterFirst" select="substring-after($text, '*')"/>
                
                <!-- Afficher le texte avant le premier * s'il y en a un -->
                <xsl:if test="normalize-space($beforeFirst) != ''">
                    <xsl:value-of select="normalize-space($beforeFirst)"/><br/>
                </xsl:if>
                
                <!-- Traiter le reste récursivement -->
                <xsl:call-template name="formatLegislationTextRecursive">
                    <xsl:with-param name="text" select="$afterFirst"/>
                </xsl:call-template>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="normalize-space($text)"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <!-- Template récursif pour traiter chaque partie après un * -->
    <xsl:template name="formatLegislationTextRecursive">
        <xsl:param name="text"/>
        <xsl:choose>
            <xsl:when test="contains($text, '*')">
                <xsl:variable name="currentPart" select="substring-before($text, '*')"/>
                <xsl:variable name="remaining" select="substring-after($text, '*')"/>
                
                <!-- Afficher la partie courante -->
                <xsl:if test="normalize-space($currentPart) != ''">
                    <xsl:value-of select="normalize-space($currentPart)"/><br/>
                </xsl:if>
                
                <!-- Continuer avec le reste -->
                <xsl:call-template name="formatLegislationTextRecursive">
                    <xsl:with-param name="text" select="$remaining"/>
                </xsl:call-template>
            </xsl:when>
            <xsl:otherwise>
                <!-- Dernière partie -->
                <xsl:if test="normalize-space($text) != ''">
                    <xsl:value-of select="normalize-space($text)"/>
                </xsl:if>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <!-- === Template principal === -->
    <xsl:template match="che:CHE_MD_Metadata">
        <!-- Variables -->
        <xsl:variable name="identifier" select="gmd:fileIdentifier/gco:CharacterString"/>
        <xsl:variable name="urlBase" select="'https://geocat-int.dev.bgdi.ch/geonetwork/srv/api/records/'"/>
        <xsl:variable name="citationTitle" select=".//gmd:citation/gmd:CI_Citation/gmd:title/gmd:PT_FreeText/gmd:textGroup/gmd:LocalisedCharacterString[@locale='#FR']"/>
        <xsl:variable name="abstractFR" select=".//gmd:abstract/gmd:PT_FreeText/gmd:textGroup/gmd:LocalisedCharacterString[@locale='#FR']"/>
        <xsl:variable name="purpose" select=".//gmd:purpose/gmd:PT_FreeText/gmd:textGroup/gmd:LocalisedCharacterString[@locale='#FR']"/>
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
        <xsl:variable name="referenceSystem" select=".//gmd:referenceSystemInfo/gmd:MD_ReferenceSystem/gmd:referenceSystemIdentifier/gmd:RS_Identifier/gmd:code/gmd:PT_FreeText/gmd:textGroup/gmd:LocalisedCharacterString[@locale='#FR']"/>
        <xsl:variable name="referenceSystemCodeSpace" select=".//gmd:referenceSystemInfo/gmd:MD_ReferenceSystem/gmd:referenceSystemIdentifier/gmd:RS_Identifier/gmd:codeSpace/gco:CharacterString"/>
        <xsl:variable name="keywords" select=".//gmd:descriptiveKeywords/gmd:MD_Keywords/gmd:keyword/gmd:PT_FreeText/gmd:textGroup/gmd:LocalisedCharacterString[@locale='#FR']"/>
        <xsl:variable name="lineage" select=".//gmd:LI_Lineage/gmd:statement/gmd:PT_FreeText/gmd:textGroup/gmd:LocalisedCharacterString[@locale='#FR']"/>
        <xsl:variable name="source" select=".//gmd:LI_Source/gmd:description/gmd:PT_FreeText/gmd:textGroup/gmd:LocalisedCharacterString[@locale='#FR']"/>
        <xsl:variable name="useLimitation" select=".//gmd:useLimitation/gmd:PT_FreeText/gmd:textGroup/gmd:LocalisedCharacterString[@locale='#FR']"/>
        <xsl:variable name="otherConstraints" select=".//gmd:otherConstraints/gmd:PT_FreeText/gmd:textGroup/gmd:LocalisedCharacterString[@locale='#FR']"/>
        <xsl:variable name="legislationTitle" select=".//che:legislationInformation/che:CHE_MD_Legislation/che:title/gmd:CI_Citation/gmd:title/gmd:PT_FreeText/gmd:textGroup/gmd:LocalisedCharacterString[@locale='#FR']"/>
        <xsl:variable name="metadataStandardName" select=".//gmd:metadataStandardName/gco:CharacterString"/>
        <xsl:variable name="contact" select=".//che:CHE_MD_DataIdentification/gmd:pointOfContact/che:CHE_CI_ResponsibleParty"/>
        <xsl:variable name="address" select="$contact/gmd:contactInfo/gmd:CI_Contact/gmd:address/che:CHE_CI_Address"/>
        <xsl:variable name="orgName" select="substring-before(.//gmd:citedResponsibleParty/che:CHE_CI_ResponsibleParty/gmd:organisationName/gmd:PT_FreeText/gmd:textGroup/gmd:LocalisedCharacterString[@locale='#FR'], ' - ')"/>
        <xsl:variable name="orgAcronym" select=".//gmd:citedResponsibleParty/che:CHE_CI_ResponsibleParty/che:organisationAcronym/gmd:PT_FreeText/gmd:textGroup/gmd:LocalisedCharacterString[@locale='#FR']"/>

        <html lang="fr">
            <head>
                <meta charset="UTF-8"/>
                <meta name="viewport" content="width=device-width, initial-scale=1"/>
                <title>Canton du Valais - Catalogue de métadonnées</title>
                
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
                    <div class="banner">Catalogue métadonnées - Simple</div>
                </header>

                <main>
                    <nav class="presentation-nav">
                        <a href="{concat($urlBase, $identifier, '/formatters/vs_full_fr?width=_100&amp;mdpath=md.format.pdf&amp;output=pdf&amp;approved=true')}" 
                           target="_blank">🖨️ Imprimer la fiche (PDF)</a>

                        <div>
                            <span>Présentation: </span>
                            <a href="{concat($urlBase, $identifier, '/formatters/vs_simple_fr?language=fre')}">Simple</a>
                            <span>/</span>
                            <a href="{concat($urlBase, $identifier, '/formatters/vs_full_fr?language=fre')}">Complète</a>
                        </div>
                        <div class="language-link">
                            <a href="{concat($urlBase, $identifier, '/formatters/vs_full_de?language=ger')}" 
                                target="_blank">🇩🇪 Version allemande</a>
                        </div>
                    </nav>

                    <article class="content">
                        <xsl:if test="$citationTitle != ''">
                            <h1 class="resource-title"><xsl:value-of select="$citationTitle"/></h1>
                        </xsl:if>
                        
                        <xsl:if test="$thumbnail != ''">
                            <img src="{$thumbnail}" alt="Aperçu de {$citationTitle}"/>
                        </xsl:if>

                        <xsl:if test="$abstractFR != ''">
                            <section>
                                <h2 class="section-title">Résumé de la ressource</h2>
                                <p><xsl:value-of select="$abstractFR"/></p>
                            </section>
                        </xsl:if>

                        <xsl:if test="$purpose != ''">
                            <section>
                                <h2 class="section-title">But</h2>
                                <p><xsl:value-of select="$purpose"/></p>
                            </section>
                        </xsl:if>

                        <section>
                            <h2 class="section-title">Informations sur la mise à jour</h2>
                            <table class="info-table">
                                <tbody>
                                    <xsl:if test="$statusCode != ''">
                                        <tr>
                                            <td class="label">État</td>
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
                                            <td class="label">Langue</td>
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

                                    <xsl:if test="$creationDate != ''">
                                        <tr>
                                            <td class="label">Date de création</td>
                                            <td>
                                                <xsl:call-template name="formatDate">
                                                    <xsl:with-param name="date" select="$creationDate"/>
                                                </xsl:call-template>
                                            </td>
                                        </tr>
                                    </xsl:if>
                                    
                                    <xsl:if test="$revisionDate != ''">
                                        <tr>
                                            <td class="label">Date de révision</td>
                                            <td>
                                                <xsl:call-template name="formatDate">
                                                    <xsl:with-param name="date" select="$revisionDate"/>
                                                </xsl:call-template>
                                            </td>
                                        </tr>
                                    </xsl:if>
                                    <xsl:if test="$basicGeodataID != ''">
                                        <tr>
                                            <td class="label"> Géodonnée de base (fédéral)</td>
                                            <td>
                                                <xsl:value-of select="$basicGeodataID"/>
                                            </td>
                                        </tr>
                                    </xsl:if>
                                </tbody>
                            </table>
                        </section>

                        <section>
                            <h2 class="section-title">Information de l'identification</h2>
                            <table class="info-table">
                                <tbody>
                                    <xsl:if test="$dataSetURI != ''">
                                        <tr>
                                            <td class="label">Désignation de la donnée (URI)</td>
                                            <td>
                                                <a href="{$dataSetURI}" target="_blank">Lien</a>
                                            </td>
                                        </tr>
                                    </xsl:if>
                                    <tr>
                                        <td class="label">Gestionnaire</td>
                                        <td>
                                            <xsl:if test="$orgName != ''">
                                                <strong><xsl:value-of select="$orgName"/></strong><br/>
                                            </xsl:if>
                                            <xsl:if test="$orgAcronym != ''">
                                                <xsl:value-of select="$orgAcronym"/><br/><br/>
                                            </xsl:if>
                                            
                                            <!-- Adresse -->
                                            <xsl:variable name="streetName" select="$address/che:streetName/gco:CharacterString"/>
                                            <xsl:variable name="streetNumber" select="$address/che:streetNumber/gco:CharacterString"/>
                                            <xsl:if test="$streetName != '' or $streetNumber != ''">
                                                <xsl:value-of select="$streetName"/>
                                                <xsl:if test="$streetNumber != ''">
                                                    <xsl:text> </xsl:text><xsl:value-of select="$streetNumber"/>
                                                </xsl:if>
                                                <br/>
                                                
                                                <xsl:variable name="postalCode" select="$address/gmd:postalCode/gco:CharacterString"/>
                                                <xsl:variable name="city" select="$address/gmd:city/gco:CharacterString"/>
                                                <xsl:if test="$postalCode != '' or $city != ''">
                                                    <xsl:value-of select="$postalCode"/>
                                                    <xsl:if test="$city != ''">
                                                        <xsl:text> </xsl:text><xsl:value-of select="$city"/>
                                                    </xsl:if>
                                                    <br/>
                                                </xsl:if>
                                            </xsl:if>
                                            
                                            <!-- Contact -->
                                            <xsl:variable name="phone" select="$contact/gmd:contactInfo/gmd:CI_Contact/gmd:phone/che:CHE_CI_Telephone/gmd:voice/gco:CharacterString"/>
                                            <xsl:if test="$phone != ''">
                                                <div>Tél: <a href="tel:{$phone}"><xsl:value-of select="$phone"/></a></div>
                                            </xsl:if>
                                            
                                            <xsl:variable name="email" select="$address/gmd:electronicMailAddress/gco:CharacterString"/>
                                            <xsl:if test="$email != ''">
                                                <div>Email: <a href="mailto:{$email}"><xsl:value-of select="$email"/></a></div>
                                            </xsl:if>
                                            
                                            <xsl:variable name="website" select="$contact/gmd:contactInfo/gmd:CI_Contact/gmd:onlineResource/gmd:CI_OnlineResource/gmd:linkage/che:PT_FreeURL/che:URLGroup/che:LocalisedURL[@locale='#FR']"/>
                                            <xsl:if test="$website != ''">
                                                <div>Site web: <a href="{$website}" target="_blank"><xsl:value-of select="$website"/></a></div>
                                            </xsl:if>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="label">Thématique</td>
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
                                        <td class="label">Mots-clés</td>
                                        <td>
                                            <xsl:for-each select="$keywords">
                                                <xsl:value-of select="."/>
                                                <xsl:if test="position() != last()"><br/></xsl:if>
                                            </xsl:for-each>
                                        </td>
                                    </tr>
                                    <xsl:if test="$spatialRepresentationTypes">
                                        <tr>
                                            <td class="label">Type de représentation spatiale</td>
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
                                            <td class="label">Objets géométriques</td>
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
                                            <td class="label">Système de référence</td>
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
                            <h2 class="section-title">Informations sur la qualité des données</h2>
                            <table class="info-table">
                                <tbody>
                                    <xsl:if test="$lineage != ''">
                                        <tr>
                                            <td class="label">Généalogie, provenance</td>
                                            <td><xsl:value-of select="$lineage"/></td>
                                        </tr>
                                    </xsl:if>
                                    <xsl:if test="$source != ''">
                                        <tr>
                                            <td class="label">Source</td>
                                            <td><xsl:value-of select="$source"/></td>
                                        </tr>
                                    </xsl:if>
                                </tbody>
                            </table>
                        </section>

                        <!-- Contraintes sur la ressource  -->
                        <section>
                            <h2 class="section-title">Contraintes sur la ressource</h2>
                            <table class="info-table">
                                <tbody>
                                    <xsl:if test="$useLimitation != ''">
                                        <tr>
                                            <td class="label">Limitation d'utilisation</td>
                                            <td><xsl:value-of select="$useLimitation"/></td>
                                        </tr>
                                    </xsl:if>
                                    <xsl:if test="$otherConstraints">
                                        <tr>
                                            <td class="label">Autres contraintes</td>
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
                                <h2 class="section-title">Référence(s) légale(s)</h2>
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
                            <h2 class="section-title">Mise à jour de la ressource</h2>
                        </section>
                        <!-- Catalogue d'objets et modèle  -->
                        <section>
                            <h2 class="section-title">Catalogue d'objets et modèle</h2>
                        </section>
                        <!-- Informations sur la réprésentation  -->
                        <section>
                            <h2 class="section-title">Informations sur la réprésentation</h2>
                        </section>
                        <!-- Informations sur la distribution  -->
                        <section>
                            <h2 class="section-title">Informations sur la distribution</h2>
                        </section>
                        <!-- Métadonnées -->
                        <section>
                            <h2 class="section-title">Métadonnées</h2>
                            <table class="info-table">
                                <tbody>
                                    <xsl:if test="$identifier != ''">
                                        <tr>
                                            <td class="label">Identifiant de la fiche</td>
                                            <td><xsl:value-of select="$identifier"/></td>
                                        </tr>
                                    </xsl:if>
                                    <xsl:if test="$dateStamp != ''">
                                        <tr>
                                            <td class="label">Date de mise à jour</td>
                                            <td>
                                                <xsl:call-template name="formatDate">
                                                    <xsl:with-param name="date" select="$dateStamp"/>
                                                </xsl:call-template>
                                            </td>
                                        </tr>
                                    </xsl:if>
                                    <xsl:if test="$metadataStandardName != ''">
                                        <tr>
                                            <td class="label">Nom du profil de métadonnées</td>
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