<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:che="http://www.geocat.ch/2008/che"
    xmlns:gmd="http://www.isotc211.org/2005/gmd"
    xmlns:gco="http://www.isotc211.org/2005/gco">

    <!-- === Templates utilitaires === -->
    <xsl:template name="formatDate">
        <xsl:param name="date"/>
        <xsl:if test="string-length($date) = 10">
            <xsl:value-of select="concat(substring($date,9,2),'.',substring($date,6,2),'.',substring($date,1,4))"/>
        </xsl:if>
    </xsl:template>

    <xsl:template name="getStatus">
        <xsl:param name="statusCode"/>
        <xsl:choose>
            <xsl:when test="$statusCode = 'onGoing'">Kontinuierliche Aktualisierung</xsl:when>
            <xsl:when test="$statusCode = 'completed'">Abgeschlossen</xsl:when>
            <xsl:when test="$statusCode = 'underDevelopment'">In Erstellung</xsl:when>
            <xsl:when test="$statusCode = 'planned'">Planifié</xsl:when>
            <xsl:when test="$statusCode = 'required'">Erforderlich</xsl:when>
            <xsl:when test="$statusCode = 'obsolete'">Veraltet</xsl:when>
            <xsl:when test="$statusCode = 'historicalArchive'">Historisches Archiv</xsl:when>
            <xsl:otherwise><xsl:value-of select="$statusCode"/></xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <!-- === Template principal === -->
    <xsl:template match="che:CHE_MD_Metadata">
        <!-- Variables -->
        <xsl:variable name="identifier" select="gmd:fileIdentifier/gco:CharacterString"/>
        <xsl:variable name="urlBase" select="'https://geocat-int.dev.bgdi.ch/geonetwork/srv/api/records/'"/>
        <xsl:variable name="citationTitle" select=".//gmd:citation/gmd:CI_Citation/gmd:title/gmd:PT_FreeText/gmd:textGroup/gmd:LocalisedCharacterString[@locale='#DE']"/>
        <xsl:variable name="abstractFR" select=".//gmd:abstract/gmd:PT_FreeText/gmd:textGroup/gmd:LocalisedCharacterString[@locale='#DE']"/>
        <xsl:variable name="purpose" select=".//gmd:purpose/gmd:PT_FreeText/gmd:textGroup/gmd:LocalisedCharacterString[@locale='#DE']"/>
        <xsl:variable name="thumbnail" select=".//gmd:graphicOverview/gmd:MD_BrowseGraphic/gmd:fileName/gco:CharacterString"/>
        <xsl:variable name="statusCode" select=".//gmd:status/gmd:MD_ProgressCode/@codeListValue"/>
        <xsl:variable name="creationDate" select=".//gmd:date/gmd:CI_Date[gmd:dateType/gmd:CI_DateTypeCode/@codeListValue='creation']/gmd:date/gco:Date"/>
        <xsl:variable name="revisionDate" select=".//gmd:date/gmd:CI_Date[gmd:dateType/gmd:CI_DateTypeCode/@codeListValue='revision']/gmd:date/gco:Date"/>
        <xsl:variable name="contact" select=".//che:CHE_MD_DataIdentification/gmd:pointOfContact/che:CHE_CI_ResponsibleParty"/>
        <xsl:variable name="address" select="$contact/gmd:contactInfo/gmd:CI_Contact/gmd:address/che:CHE_CI_Address"/>
        <xsl:variable name="orgName" select="substring-before(.//gmd:citedResponsibleParty/che:CHE_CI_ResponsibleParty/gmd:organisationName/gmd:PT_FreeText/gmd:textGroup/gmd:LocalisedCharacterString[@locale='#DE'], ' - ')"/>
        <xsl:variable name="orgAcronym" select=".//gmd:citedResponsibleParty/che:CHE_CI_ResponsibleParty/che:organisationAcronym/gmd:PT_FreeText/gmd:textGroup/gmd:LocalisedCharacterString[@locale='#DE']"/>

        <html lang="fr">
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
                                 alt="Logo Kanton Wallis"/>
                        </a>                        
                        <a href="https://www.geocat.ch/geonetwork/ger/ger/catalog.search#/home" target="_blank">
                            <img src="https://www.vs.ch/documents/17311/472429/logo_geocat" alt="Geocat Logo"/>
                        </a>
                    </div>
                    <div class="banner">Metadatenkatalog - Einfach</div>
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

                        <xsl:if test="$abstractFR != ''">
                            <section>
                                <h2 class="section-title">Kurze Beschreibung</h2>
                                <p><xsl:value-of select="$abstractFR"/></p>
                            </section>
                        </xsl:if>

                        <xsl:if test="$purpose != ''">
                            <section>
                                <h2 class="section-title">Zweck</h2>
                                <p><xsl:value-of select="$purpose"/></p>
                            </section>
                        </xsl:if>

                        <section>
                            <table class="info-table">
                                <tbody>
                                    <xsl:if test="$statusCode != ''">
                                        <tr>
                                            <td class="label">Bearbeitungsstatus</td>
                                            <td>
                                                <xsl:call-template name="getStatus">
                                                    <xsl:with-param name="statusCode" select="$statusCode"/>
                                                </xsl:call-template>
                                            </td>
                                        </tr>
                                    </xsl:if>
                                    
                                    <xsl:if test="$creationDate != ''">
                                        <tr>
                                            <td class="label">Datum Erstellung</td>
                                            <td>
                                                <xsl:call-template name="formatDate">
                                                    <xsl:with-param name="date" select="$creationDate"/>
                                                </xsl:call-template>
                                            </td>
                                        </tr>
                                    </xsl:if>
                                    
                                    <xsl:if test="$revisionDate != ''">
                                        <tr>
                                            <td class="label">Datum Überarbeitung</td>
                                            <td>
                                                <xsl:call-template name="formatDate">
                                                    <xsl:with-param name="date" select="$revisionDate"/>
                                                </xsl:call-template>
                                            </td>
                                        </tr>
                                    </xsl:if>

                                    <tr>
                                        <td class="label">Verwalter</td>
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
                                                <div>Tel: <a href="tel:{$phone}"><xsl:value-of select="$phone"/></a></div>
                                            </xsl:if>
                                            
                                            <xsl:variable name="email" select="$address/gmd:electronicMailAddress/gco:CharacterString"/>
                                            <xsl:if test="$email != ''">
                                                <div>E-Mail: <a href="mailto:{$email}"><xsl:value-of select="$email"/></a></div>
                                            </xsl:if>
                                            
                                            <xsl:variable name="website" select="$contact/gmd:contactInfo/gmd:CI_Contact/gmd:onlineResource/gmd:CI_OnlineResource/gmd:linkage/che:PT_FreeURL/che:URLGroup/che:LocalisedURL[@locale='#DE']"/>
                                            <xsl:if test="$website != ''">
                                                <div>Website: <a href="{$website}" target="_blank"><xsl:value-of select="$website"/></a></div>
                                            </xsl:if>
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                        </section>
                    </article>
                </main>
            </body>
        </html>
    </xsl:template>
</xsl:stylesheet>