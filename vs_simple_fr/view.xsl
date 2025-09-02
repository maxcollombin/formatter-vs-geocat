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
    <!-- Template pour formater les contacts -->
    <xsl:template name="formatContact">
        <xsl:param name="contact"/>
        <xsl:variable name="address" select="$contact/gmd:contactInfo/gmd:CI_Contact/gmd:address/che:CHE_CI_Address"/>
        <xsl:variable name="streetName" select="$address/che:streetName/gco:CharacterString"/>
        <xsl:variable name="streetNumber" select="$address/che:streetNumber/gco:CharacterString"/>
        <xsl:variable name="postalCode" select="$address/gmd:postalCode/gco:CharacterString"/>
        <xsl:variable name="city" select="$address/gmd:city/gco:CharacterString"/>
        <xsl:variable name="phone" select="$contact/gmd:contactInfo/gmd:CI_Contact/gmd:phone/che:CHE_CI_Telephone/gmd:voice/gco:CharacterString"/>
        <xsl:variable name="email" select="$address/gmd:electronicMailAddress/gco:CharacterString"/>
        <xsl:variable name="website" select="$contact/gmd:contactInfo/gmd:CI_Contact/gmd:onlineResource/gmd:CI_OnlineResource/gmd:linkage/che:PT_FreeURL/che:URLGroup/che:LocalisedURL[@locale='#FR']"/>
        <!-- Adresse -->
        <xsl:if test="$streetName != '' or $streetNumber != ''">
            <div>
                <xsl:value-of select="$streetName"/>
                <xsl:if test="$streetNumber != ''"><xsl:text> </xsl:text><xsl:value-of select="$streetNumber"/></xsl:if>
            </div>
        </xsl:if>
        <!-- Code postal et ville -->
        <xsl:if test="$postalCode != '' or $city != ''">
            <div>
                <xsl:value-of select="$postalCode"/>
                <xsl:if test="$city != ''"><xsl:text> </xsl:text><xsl:value-of select="$city"/></xsl:if>
            </div>
        </xsl:if>
        <!-- Téléphone -->
        <xsl:if test="$phone != ''">
            <div>Tél: <a href="tel:{$phone}"><xsl:value-of select="$phone"/></a></div>
        </xsl:if>
        <!-- Email -->
        <xsl:if test="$email != ''">
            <div>Email: <a href="mailto:{$email}"><xsl:value-of select="$email"/></a></div>
        </xsl:if>
        <!-- Site web -->
        <xsl:if test="$website != ''">
            <div>Site web: <a href="{$website}" target="_blank"><xsl:value-of select="$website"/></a></div>
        </xsl:if>
    </xsl:template>
    <!-- Template principal -->
    <xsl:template match="che:CHE_MD_Metadata">
        <!-- Variables -->
        <xsl:variable name="identifier" select="gmd:fileIdentifier/gco:CharacterString"/>
        <xsl:variable name="urlBase" select="'https://geocat-int.dev.bgdi.ch/geonetwork/srv/api/records/'"/>
        <xsl:variable name="citationTitle" select=".//gmd:citation/gmd:CI_Citation/gmd:title/gmd:PT_FreeText/gmd:textGroup/gmd:LocalisedCharacterString[@locale='#FR']"/>
        <xsl:variable name="abstract" select=".//gmd:abstract/gmd:PT_FreeText/gmd:textGroup/gmd:LocalisedCharacterString[@locale='#FR']"/>
        <xsl:variable name="thumbnail" select=".//gmd:graphicOverview/gmd:MD_BrowseGraphic/gmd:fileName/gco:CharacterString"/>
        <xsl:variable name="statusCode" select=".//gmd:status/gmd:MD_ProgressCode/@codeListValue"/>
        <xsl:variable name="creationDate" select=".//gmd:date/gmd:CI_Date[gmd:dateType/gmd:CI_DateTypeCode/@codeListValue='creation']/gmd:date/gco:Date"/>
        <xsl:variable name="revisionDate" select=".//gmd:date/gmd:CI_Date[gmd:dateType/gmd:CI_DateTypeCode/@codeListValue='revision']/gmd:date/gco:Date"/>
        <xsl:variable name="contact" select=".//che:CHE_MD_DataIdentification/gmd:pointOfContact/che:CHE_CI_ResponsibleParty"/>
        <xsl:variable name="address" select="$contact/gmd:contactInfo/gmd:CI_Contact/gmd:address/che:CHE_CI_Address"/>
        <xsl:variable name="orgName" select="substring-before(.//gmd:citedResponsibleParty/che:CHE_CI_ResponsibleParty/gmd:organisationName/gmd:PT_FreeText/gmd:textGroup/gmd:LocalisedCharacterString[@locale='#FR'], ' - ')"/>
        <xsl:variable name="orgAcronym" select=".//gmd:citedResponsibleParty/che:CHE_CI_ResponsibleParty/che:organisationAcronym/gmd:PT_FreeText/gmd:textGroup/gmd:LocalisedCharacterString[@locale='#FR']"/>
        <!-- Contenu HTML -->
        <html lang="fr">
            <head>
                <meta charset="UTF-8"/>
                <meta name="viewport" content="width=device-width, initial-scale=1"/>
                <title>Canton du Valais - Catalogue de métadonnées</title>
                <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet"/>
                <!-- Style VS -->
                <style type="text/css">
                :root { --bs-primary: #D52826; --vs-font-family: "Segoe UI", Roboto, "Helvetica Neue", Arial, sans-serif; }
                /* === Ecran === */
                body { font-family: var(--vs-font-family); font-size: 1rem; line-height: 1.5; }
                h1 { font-size: 2.5rem; line-height: 1.2; }
                h2 { font-size: 1.7rem; }
                h3 { font-size: 1.2rem; }
                p { margin: 1rem 0; }
                a { color: var(--bs-primary); text-decoration: none; }
                a:hover, a:active { color: #b3180d; text-decoration: underline; }
                .btn-custom { background-color: var(--bs-primary); color: #fff; border: none; }
                .btn-custom:hover { background-color: #b3180d; }
                /* Tableaux avec colonnes 50/50 */
                .table-50-50 { table-layout: fixed; }
                .table-50-50 th { width: 50%; }
                .table-50-50 td { width: 50%; }
                /* === Impression === */
                @media print {
                    /* Reset général pour l'impression */
                    * { -webkit-print-color-adjust:exact !important; color-adjust:exact !important; }
                    body, h1, h2, h3, p, table, th, td, img { color:#000 !important; background:#fff !important; }
                    a, a:visited { color:#D52826 !important; text-decoration:underline !important; }
                    .d-print-none, .btn { display:none !important; }
                    
                    /* Typographie */
                    body { font-size:11pt; line-height:1.4; margin:0; padding:0; }
                    h3 { font-size:12pt; font-weight:bold; margin-top:16pt; margin-bottom:8pt; page-break-after:avoid; }
                    
                    /* Header */
                    header h2 { background:#D52826 !important; color:#fff !important; border:none; padding:12pt 8pt; text-align:center; margin-bottom:24pt; font-size:18pt; font-weight:bold; border-radius:4pt; page-break-after:avoid; }
                    
                    /* Conteneurs */
                    .container { max-width:100% !important; margin:0 !important; padding:0 !important; }
                    .card { border:1pt solid #000 !important; box-shadow:none !important; margin-bottom:12pt; margin-top:16pt; page-break-inside:avoid; background:#fff !important; }
                    .card-header { background:#fff !important; color:#000 !important; border:none !important; border-bottom:1pt solid #ddd !important; font-weight:600; text-align:center; page-break-after:avoid; padding:12pt 8pt; }
                    .card-body { padding:16pt 12pt 12pt 12pt !important; background:#fff !important; }
                    
                    /* Sections avec gestion des sauts de page */
                    .table-responsive { overflow:visible !important; page-break-inside:avoid; margin-bottom:16pt; background:#fff !important; border:none !important; }
                    h3 + .table-responsive, h3 + div { page-break-before:avoid; }
                    
                    /* Tableaux */
                    table { border-collapse:collapse !important; width:100% !important; margin-bottom:12pt; page-break-inside:avoid; background:#fff !important; border:1pt solid #ddd !important; }
                    th { white-space:nowrap; background:#f8f9fa !important; color:#000 !important; font-weight:600; width:50%; padding:6pt 8pt !important; border:1pt solid #ddd !important; vertical-align:top; }
                    td { background:#fff !important; color:#000 !important; width:50%; padding:6pt 8pt !important; border:1pt solid #ddd !important; vertical-align:top; word-wrap:break-word; }
                    
                    /* Images */
                    img { max-width:100% !important; height:auto !important; display:block !important; margin:12pt auto !important; border:1pt solid #ddd; page-break-inside:avoid; }
                    
                    /* Contrôles de pagination */
                    p, td, th { orphans:3; widows:3; }
                    .page-break { page-break-before:always; }
                    
                    /* Suppression des bordures parasites */
                    .row, .col-12, .col-md-4 { border:none !important; margin:0 !important; padding:0 !important; }
                }
                </style>
            </head>
            <body class="bg-white">
                <!-- Header -->
                <header class="container py-3">
                    <h2 class="text-center mt-3 mb-0 py-3 rounded" style="background-color:#D52826; color:#fff; font-size: clamp(1.5rem, 4vw, 2.2rem);">
                        Catalogue métadonnées - Simple
                    </h2>
                </header>
                <!-- Navigation -->
                <nav class="container my-3 d-print-none">
                    <div class="row g-2">
                        <div class="col-12 col-md-4 d-flex justify-content-center justify-content-md-start">
                            <a class="btn btn-outline-danger btn-sm" 
                               href="{concat($urlBase, $identifier, '/formatters/vs_simple_fr?width=_100&amp;mdpath=md.format.pdf&amp;output=pdf&amp;approved=true')}" 
                               target="_blank">Imprimer la fiche (PDF)</a>
                        </div>
                        <div class="col-12 col-md-4 text-center">
                            <a class="btn btn-outline-danger btn-sm" href="{concat($urlBase, $identifier, '/formatters/vs_full_fr?language=fre')}">Vue complète</a>
                        </div>
                        <div class="col-12 col-md-4 d-flex justify-content-center justify-content-md-end">
                            <a class="btn btn-outline-danger btn-sm" 
                               href="{concat($urlBase, $identifier, '/formatters/vs_simple_de?language=ger')}" 
                               target="_blank">Version allemande</a>
                        </div>
                    </div>
                </nav>
                <!-- Contenu principal -->
                <main class="container">
                    <article class="card mb-4">
                        <xsl:if test="$citationTitle != ''">
                            <h2 class="card-header text-center bg-white">
                                <xsl:value-of select="$citationTitle"/>
                            </h2>
                        </xsl:if>
                        <div class="card-body">
                            <xsl:if test="$thumbnail != ''">
                                <img src="{$thumbnail}" alt="Aperçu de {$citationTitle}" class="img-fluid mx-auto d-block mb-3"/>
                            </xsl:if>
                            <xsl:if test="$abstract != ''">
                                <h3>Résumé de la ressource</h3>
                                <p><xsl:value-of select="$abstract"/></p>
                            </xsl:if>
                            <h3 class="mt-4">Informations sur la mise à jour</h3>
                            <div class="table-responsive">
                                <table class="table table-bordered table-sm table-striped table-hover align-middle table-50-50">
                                    <tbody>
                                        <xsl:if test="$statusCode != ''">
                                            <tr>
                                                <th scope="row">État</th>
                                                <td>
                                                    <xsl:call-template name="codelist">
                                                        <xsl:with-param name="code" select="$statusCode"/>
                                                        <xsl:with-param name="path">gmd:MD_ProgressCode</xsl:with-param>
                                                    </xsl:call-template>
                                                </td>
                                            </tr>
                                        </xsl:if>
                                        <xsl:if test="$creationDate != ''">
                                            <tr>
                                                <th scope="row">Date de création</th>
                                                <td>
                                                    <xsl:call-template name="formatDate">
                                                        <xsl:with-param name="date" select="$creationDate"/>
                                                    </xsl:call-template>
                                                </td>
                                            </tr>
                                        </xsl:if>
                                        <xsl:if test="$revisionDate != ''">
                                            <tr>
                                                <th scope="row">Date de révision</th>
                                                <td>
                                                    <xsl:call-template name="formatDate">
                                                        <xsl:with-param name="date" select="$revisionDate"/>
                                                    </xsl:call-template>
                                                </td>
                                            </tr>
                                        </xsl:if>
                                        <tr>
                                            <th scope="row">Gestionnaire</th>
                                            <td>
                                                <xsl:if test="$orgName != ''"><xsl:value-of select="$orgName"/><br/></xsl:if>
                                                <xsl:if test="$orgAcronym != ''"><xsl:value-of select="$orgAcronym"/><br/></xsl:if>
                                                <xsl:call-template name="formatContact">
                                                    <xsl:with-param name="contact" select="$contact"/>
                                                </xsl:call-template>
                                            </td>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </article>
                </main>
            </body>
        </html>
    </xsl:template>
</xsl:stylesheet>
