<?xml version="1.0" encoding="UTF-8"?>
<!-- XSL-Stylesheet für geocat.ch ( 30.08.16 )-->
<!-- Dieses XSL-Styleshett wurde für die Metadatenverwaltung des Kantons Wallis durch die Fachstelle für Geoinformationen erstellt und gepflegt. -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0" xmlns:gmd="http://www.isotc211.org/2005/gmd" xmlns:gco="http://www.isotc211.org/2005/gco" xmlns:gmx="http://www.isotc211.org/2005/gmx" xmlns:srv="http://www.isotc211.org/2005/srv" xmlns:gml="http://www.opengis.net/gml" xmlns:gts="http://www.isotc211.org/2005/gts" xmlns:che="http://www.geocat.ch/2008/che" xmlns:geonet="http://www.fao.org/geonetwork" xmlns:exslt="http://exslt.org/common" xmlns:xlink="http://www.w3.org/1999/xlink">
	<!-- Load labels. -->
	<xsl:variable name="label" select="/root/schemas/iso19139/labels"/>
	<xsl:variable name="label.che" select="/root/schemas/iso19139.che/labels"/>
	<xsl:variable name="value" select="/root/schemas/iso19139/codelists"/>
	<xsl:variable name="value.che" select="/root/schemas/iso19139.che/codelists"/>
	<xsl:template match="/">
		<!-- Der Slash (/) bedeutet dass das Template für alle Elemente verwendet wird. -->
		<html>
			<head>
				<meta http-equiv="expires" content="0"/>
				<!-- Ist nötig, damit die Attribute des Ausdehungs iframes nicht im cache gespeichert werden -->
				<title>Canton du Valais - Catalogue de métadonnées</title>
			</head>
			<body leftmargin="0" topmargin="0" bgcolor="#ffffff" marginheight="0" marginwidth="0">
				<xsl:apply-templates select="/root/che:CHE_MD_Metadata"/>
			</body>
		</html>
	</xsl:template>
	<!-- Hier wird das Layout Gerüst für Kanton VS, also Banner mit Logo etc. angegeben -->
	<xsl:template match="che:CHE_MD_Metadata">
		<table width="800" border="0" cellpadding="0" cellspacing="0" height="100%">
			<tbody>
				<tr>
					<td height="45" valign="top">
						<table width="800" border="0" cellpadding="0" cellspacing="0" height="45">
							<tbody>
								<tr align="left" valign="top">
									<td width="2"/>
									<td width="133" bgcolor="#ffffff">
										<a href="http://www.vs.ch" target="_blank">
											<img border="0" width="78" height="68">
												<xsl:attribute name="src">https://www.vs.ch/documents/17311/1860458/logoVS78px/f406b530-5ee3-40b0-9c1e-00069d011f89?t=1462889171734</xsl:attribute>
											</img>
										</a>
									</td>
									<td class="cnavunter" width="265" bgcolor="#ffffff">
										<!--<a href="" target="_blank">
											<img border="0">
												<xsl:attribute name="src">LOGO</xsl:attribute>
											</img>
										</a> -->
									</td>
									<td align="right" valign="middle" width="325">
									<a target="_blank">
											<xsl:attribute name="href">
												<xsl:text>https://www.geocat.ch/geonetwork/srv/fre/md.viewer#/full_view/</xsl:text>
												<xsl:value-of select="gmd:fileIdentifier/gco:CharacterString"/>
											</xsl:attribute>
										<img border="0" width="45" height="59" src="https://www.vs.ch/documents/17311/472429/logo_geocat"></img></a>
									</td>
									<td width="75"  valign="middle" align="center">
										<a target="_blank">
											<xsl:attribute name="href">
												<!-- Testumgebung  <xsl:text>https://geocat-int.dev.bgdi.ch/geonetwork/srv/ger/md.format.html?xsl=vs_full_de&amp;uuid=</xsl:text> -->
												<!-- Produktivumgebung --> <xsl:text>https://www.geocat.ch/geonetwork/srv/api/records/</xsl:text>
												<xsl:value-of select="gmd:fileIdentifier/gco:CharacterString"/>
												<xsl:text>/formatters/vs_full_de?language=ger</xsl:text>
											</xsl:attribute>
										de</a>
									</td>
								</tr>
							</tbody>
						</table>
					</td>
				</tr>
				<tr>
					<td height="47" valign="top">
						<table width="800" border="0" cellpadding="0" cellspacing="0" height="47">
							<tbody>
								<tr align="left" valign="top"><br/>
									<td width="800" bgcolor="#E52429" height="46">
										<table width="800" border="0" cellpadding="0" cellspacing="0">
											<tbody>
												<tr>
													<td colspan="2" height="12"/>
												</tr>
												<tr>
													<td width="75" height="26"> </td>
<!-- Das Textende muss je nach Version angepasst werden: Komplett / Einfach -->													
													<td valign="top" height="26" align="left" width="725" style="font-family:Verdana, Arial, Helvetica, sans-serif; font-size: 20px;font-style:normal; font-weight:normal; color:#FFFFFF; text-decoration:none; line-height:26px">Catalogue de métadonnées - Complet</td> 		
												</tr>
											</tbody>
										</table>
									</td>
								</tr>
								<tr>
									<td colspan="3" bgcolor="#ffffff" height="1"/>
								</tr>
							</tbody>
						</table>
					</td>
				</tr>
				<tr>
					<td valign="top">
						<table width="800" border="0" cellpadding="0" cellspacing="0" height="100%">
							<tbody>
								<tr>
									<td width="800" align="left" height="504" valign="top">
										<table class="fliess" width="800" border="0" cellpadding="0" cellspacing="0">
											<tbody>
												<tr>
													<td width="75" valign="top">
													</td>
													<td class="text" width="*" align="left" valign="top">
														<br/>
														<table width="725" border="0" cellpadding="0" cellspacing="0" style="font-family: Verdana, Arial, Helvetica, sans-serif;font-size: 12px; font-style: normal; color: #000000; text-decoration: none; line-height: 17px;">
															<!-- Change border to 1 here -->
															<tbody>
																<tr>
																	<td valign="middle" class="text" height="50">
																		<a target="_blank">
																			<xsl:attribute name="href">
																			<!-- Testumgebung  <xsl:text>https://geocat-int.dev.bgdi.ch/geonetwork/srv/fre/md.format.pdf?xsl=vs_full_fr&amp;uuid=</xsl:text> -->
																			<!-- Produktivumgebung-->  <xsl:text>https://www.geocat.ch/geonetwork/srv/api/records/</xsl:text> 
																			<xsl:value-of select="gmd:fileIdentifier/gco:CharacterString"/>
																			<xsl:text>/formatters/vs_full_fr?width=_100&amp;mdpath=md.format.pdf&amp;output=pdf&amp;approved=true</xsl:text>
																			</xsl:attribute>
																			Imprimer</a>
																	</td>
																	<td align= "right" valign="middle" height="50" style="font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 11px; color: #000000; font-style: normal; text-decoration: none; line-height: 14px;">
																		Présentation:
																		<!-- Die Links müssen je nachdem auf Test- oder Produktionsumgebung angepasst werden -->	
																																				<a target="_self">
																			<xsl:attribute name="href">
																				<!-- Testumgebung  <xsl:text>https://geocat-int.dev.bgdi.ch/geonetwork/srv/fre/md.format.html?xsl=vs_simple_fr&amp;uuid=</xsl:text> -->
																				<!-- Produktivumgebung-->  <xsl:text>https://www.geocat.ch/geonetwork/srv/api/records/</xsl:text> 
																				<xsl:value-of select="gmd:fileIdentifier/gco:CharacterString"/>
																				<xsl:text>/formatters/vs_simple_fr?language=fre</xsl:text>
																			</xsl:attribute>
																		Simple</a>
																		 / 
																		<a target="_self">
																			<xsl:attribute name="href">
																				<!-- Testumgebung  <xsl:text>https://geocat-int.dev.bgdi.ch/geonetwork/srv/fre/md.format.html?xsl=vs_full_fr&amp;uuid=</xsl:text> -->
																				<!-- Produktivumgebung--> <xsl:text>https://www.geocat.ch/geonetwork/srv/api/records/</xsl:text>  
																				<xsl:value-of select="gmd:fileIdentifier/gco:CharacterString"/>
																				<xsl:text>/formatters/vs_full_fr?language=fre</xsl:text>

																			</xsl:attribute>
																		Complète</a>
																	</td>
																</tr>
																<tr>
																	<td colspan="2">
																		<xsl:call-template name="content"/>
																		<!--Verweist auf das Template mit dem Namen content-->
																	</td>
																</tr>
																
															</tbody>
														</table>
													</td>
													<td width="27" align="left" valign="top">
													 </td>
													<td width="30" align="left" valign="top">
													</td>
												</tr>
											</tbody>
										</table>
									</td>
								</tr>
							</tbody>
						</table>
					</td>
				</tr>
			</tbody>
		</table>
	</xsl:template>
	<!-- 	
====================================================== 
	CONTENT 
======================================================
    Inhalt den wir aus der XML Datei herausholen -->
	<xsl:template name="content">
		<table border="0" cellpadding="4" cellspacing="2" style="font-family: Verdana, Arial, Helvetica, sans-serif;font-size: 12px; font-style: normal; color: #000000; text-decoration: none">
<!-- Titel - simple-->		
			<tr>
				<td colspan="2" class="text" bgcolor="#E1E2E3">
					<br/>
					<span style="font-size: 18px;font-weight:bold">
						<!-- hier kann direkt gmd:ident.. angegeben werden ohne // weil im template vorhin schon che:CHE_MD_Metadata selektiert wurde und der pfad nun dort weitergeht. -->
						<!-- <xsl:value-of select="//gmd:title"/> 110209 Vollstaendiger Pfad angegeben-->
						<xsl:value-of select="gmd:identificationInfo/che:CHE_MD_DataIdentification/gmd:citation/gmd:CI_Citation/gmd:title/gmd:PT_FreeText/gmd:textGroup/gmd:LocalisedCharacterString[@locale='#FR']"/>
					</span>
				</td>
			</tr>
<!--Beispielbild - simple-->	
			<tr>
				<td colspan="2" class="text" bgcolor="#ffffff" valign="TOP">
					<!-- Beispielbild das bei uns liegt. Die Adresse des Bildes ist im XML-Document abgespeichert. -->
					<!-- [2] muss zurzeit eingeführt werden, weil aus irgendeinem Grund bereits ein anderes Bild vorab verlinkt ist -->
					<!--<img src="{gmd:identificationInfo/che:CHE_MD_DataIdentification/gmd:graphicOverview[2]/gmd:MD_BrowseGraphic/gmd:fileName/gco:CharacterString}" border="0">
						<xsl:attribute name="alt"><xsl:value-of select="gmd:identificationInfo/che:CHE_MD_DataIdentification/gmd:graphicOverview[2]/gmd:MD_BrowseGraphic/gmd:fileName/gco:CharacterString"/></xsl:attribute>
						<xsl:attribute name="title"><xsl:value-of select="gmd:identificationInfo/che:CHE_MD_DataIdentification/gmd:graphicOverview[2]/gmd:MD_BrowseGraphic/gmd:fileName/gco:CharacterString"/></xsl:attribute>
					</img> -->
					<!-- Beispielbild das via upload bei geocat gespeichert ist. -->
					<!--<img src="http://geocat0i.bgdi.admin.ch/geonetwork/srv/deu/resources.get?access=public&amp;id={geonet:info/id}&amp;fname={gmd:identificationInfo/che:CHE_MD_DataIdentification/gmd:graphicOverview[2]/gmd:MD_BrowseGraphic/gmd:fileName/gco:CharacterString}" border="0"/>-->
						<p align="center">
						<xsl:element name="img">
								<xsl:attribute name="src">
									<!-- <xsl:value-of select="string('resources.get?access=public&amp;id=')" />
									<xsl:value-of select="/root/info/record/id/text()" />
									<xsl:value-of select="string('&amp;fname=')" /> -->
									<xsl:value-of select="gmd:identificationInfo/che:CHE_MD_DataIdentification/gmd:graphicOverview[1]/gmd:MD_BrowseGraphic/gmd:fileName/gco:CharacterString" />
								</xsl:attribute>
								<xsl:attribute name="alt">
									<xsl:value-of select="gmd:identificationInfo/che:CHE_MD_DataIdentification/gmd:citation/gmd:CI_Citation/gmd:title/gmd:PT_FreeText/gmd:textGroup/gmd:LocalisedCharacterString[@locale='#FR']"/>
								</xsl:attribute>
								<xsl:attribute name="title">
									<xsl:value-of select="gmd:identificationInfo/che:CHE_MD_DataIdentification/gmd:citation/gmd:CI_Citation/gmd:title/gmd:PT_FreeText/gmd:textGroup/gmd:LocalisedCharacterString[@locale='#FR']"/>
								</xsl:attribute>
							</xsl:element>
						</p>
				</td>
			</tr>
			
<!-- Kurzbeschreibung - simple-->
			<tr>
				<td colspan="2" class="text" bgcolor="#E1E2E3" valign="TOP">
					<b>
						<xsl:value-of select="string($label/element[@name='gmd:abstract']/label)"/>
					</b>
				</td>
			</tr>
			<tr>
				<td colspan="2" class="text" bgcolor="#ffffff" valign="TOP">
					<xsl:value-of select="gmd:identificationInfo/che:CHE_MD_DataIdentification/gmd:abstract/gmd:PT_FreeText/gmd:textGroup/gmd:LocalisedCharacterString[@locale='#FR']"/>
					<br/><br/>
				</td>
			</tr>
<!-- Zweck - full-->
			<tr>
				<td colspan="2" class="text" bgcolor="#E1E2E3" valign="TOP">
					<b>
						<xsl:value-of select="string($label/element[@name='gmd:purpose']/label)"/>
					</b>
				</td>
			</tr>
			<tr>
				<td colspan="2" class="text" bgcolor="#ffffff" valign="TOP">
					<xsl:value-of select="gmd:identificationInfo/che:CHE_MD_DataIdentification/gmd:purpose/gmd:PT_FreeText/gmd:textGroup/gmd:LocalisedCharacterString[@locale='#FR']"/>
					<br/><br/>
				</td>
			</tr>
<!-- Zusatzinformationen - full-->
			<xsl:if test="contains(gmd:identificationInfo/che:CHE_MD_DataIdentification/gmd:supplementalInformation/gmd:PT_FreeText/gmd:textGroup/gmd:LocalisedCharacterString[@locale='#FR'], 'e')">
		
			<tr>
				<td colspan="2" class="text" bgcolor="#E1E2E3" valign="TOP">
					<b>
						<xsl:value-of select="string($label/element[@name='gmd:supplementalInformation']/label)"/>
					</b>
				</td>
			</tr>
			<tr>
				<td colspan="2" class="text" bgcolor="#ffffff" valign="TOP">
					<xsl:value-of select="gmd:identificationInfo/che:CHE_MD_DataIdentification/gmd:supplementalInformation/gmd:PT_FreeText/gmd:textGroup/gmd:LocalisedCharacterString[@locale='#FR']"/>
					<br/><br/>
				</td>
			</tr>
			</xsl:if>
<!-- Bearbeitungsstatus - extended-->
			<tr>
				<td class="text" width="30%" bgcolor="#E1E2E3" valign="TOP">
					<b>
						<xsl:value-of select="string($label/element[@name='gmd:status']/label)"/>
					</b>
				</td>
				<td bgcolor="#ffffff" valign="TOP">
					<xsl:call-template name="codelist">
						<xsl:with-param name="code" select="gmd:identificationInfo/che:CHE_MD_DataIdentification/gmd:status/gmd:MD_ProgressCode/@codeListValue"/>
						<xsl:with-param name="path" select="string('gmd:MD_ProgressCode')"/>
					</xsl:call-template>
				</td>
			</tr>
<!-- Sprache - full-->
			<tr>
				<td class="text" width="30%" bgcolor="#E1E2E3" valign="TOP">
					<b>
						<!--<xsl:value-of select="string($label/element[@name='gmd:language']/label)"/>-->
						<xsl:text disable-output-escaping="no">Langue</xsl:text>
					</b>
				</td>
				<td bgcolor="#ffffff" valign="TOP">
					<ul type="circle">
						<xsl:for-each select="gmd:identificationInfo/che:CHE_MD_DataIdentification/gmd:language">
							<li>
								<xsl:choose>
									<xsl:when test="gmd:LanguageCode/@codeListValue = 'fre' ">Français</xsl:when>
									<xsl:when test="gmd:LanguageCode/@codeListValue = 'ger' ">Allemand</xsl:when>
									<xsl:when test="gco:CharacterString = 'fre' ">Français</xsl:when>
									<xsl:when test="gco:CharacterString = 'ger' ">Allemand</xsl:when>
									<xsl:otherwise><xsl:value-of select="gco:CharacterString"/></xsl:otherwise>
								</xsl:choose>
							<!--<xsl:value-of select="gco:CharacterString"/>-->
							</li>
						</xsl:for-each>
					</ul>
				</td>
			</tr>
<!-- Datum "Erstellung" - extended-->
<!--			<tr>
				<td width="30%" bgcolor="#E1E2E3" valign="TOP">
					<b>
						<xsl:text disable-output-escaping="no">Datum&#160;</xsl:text>
						<xsl:call-template name="codelist">
						<xsl:with-param name="code" select="gmd:identificationInfo/che:CHE_MD_DataIdentification/gmd:citation/gmd:CI_Citation/gmd:date/gmd:CI_Date/gmd:dateType/gmd:CI_DateTypeCode/@codeListValue"/>
						<xsl:with-param name="path" select="string('gmd:CI_DateTypeCode')"/>
					</xsl:call-template>
					</b>
				</td>
				<td bgcolor="#ffffff" valign="TOP">
					<xsl:value-of select="gmd:identificationInfo/che:CHE_MD_DataIdentification/gmd:citation/gmd:CI_Citation/gmd:date/gmd:CI_Date/gmd:date/gco:Date"/>
				</td>
			</tr>
-->
<!-- Datum "Alle" - extended-->
			<tr>
				<td width="30%" bgcolor="#E1E2E3" valign="TOP">
					<b> 
						<xsl:text disable-output-escaping="no">Date de création</xsl:text>
						<br/>
						<xsl:text disable-output-escaping="no">Date de révision</xsl:text>
					</b>
				</td>
				<td bgcolor="#ffffff" valign="TOP">
				     <ul type="circle"><xsl:for-each select="gmd:identificationInfo/che:CHE_MD_DataIdentification/gmd:citation/gmd:CI_Citation/gmd:date/gmd:CI_Date">	
							<li><xsl:value-of select="gmd:date/gco:Date"/>
							</li>
					</xsl:for-each></ul>				 
				</td>
			</tr>
<!-- Geobasisdaten - extended-->
			<tr>
				<td class="text" width="30%" bgcolor="#E1E2E3" valign="TOP">
					<b>
						<xsl:text disable-output-escaping="no">Géodonnée de base (fédéral)</xsl:text>
					</b>
				</td>
				<td bgcolor="#ffffff" valign="TOP">
					<!--Ne fonctionne pas!!  <xsl:call-template name="codelist">
						<xsl:with-param name="code" select="gmd:identificationInfo/che:MD_DataIdentification/che:basicGeodataIDType/che:basicGeodataIDTypeCode/@codeListValue"/>
						<xsl:with-param name="path" select="string('che:basicGeodataIDTypeCode')"/>
					</xsl:call-template> -->
					<xsl:choose>
						<xsl:when test="gmd:identificationInfo/che:CHE_MD_DataIdentification/che:basicGeodataID/gco:CharacterString">
							<xsl:value-of select="gmd:identificationInfo/che:CHE_MD_DataIdentification/che:basicGeodataID/gco:CharacterString" />
						</xsl:when>
						<xsl:otherwise>
							<xsl:text disable-output-escaping="no">non</xsl:text>
						</xsl:otherwise>
					</xsl:choose>
					<!--<xsl:value-of select="gmd:identificationInfo/che:CHE_MD_DataIdentification/che:basicGeodataID/gco:CharacterString"/>-->
				</td>
			</tr>
<!-- OEREB-Kadaster - full-->
			<xsl:for-each select="gmd:identificationInfo/che:CHE_MD_DataIdentification/che:geodataType">
				<xsl:if test="contains(che:MD_geodataTypeCode/@codeListValue, 'oerebRegister')">
					<xsl:choose>
						<xsl:when test="contains(che:MD_geodataTypeCode/@codeListValue, 'oerebRegister')">
							<tr>
								<td class="text" width="30%" bgcolor="#E1E2E3" valign="TOP">
									<b>
									<xsl:text disable-output-escaping="no">Cadastre RDPPF</xsl:text>
									</b>
								</td>
								<td bgcolor="#ffffff" valign="TOP">
									<xsl:text disable-output-escaping="no">Oui</xsl:text>
								</td>
							</tr>
						</xsl:when>
					</xsl:choose>
				</xsl:if>	
			</xsl:for-each>
			<tr>
				<td colspan="2" class="text" valign="TOP">
					<xsl:text disable-output-escaping="no">&#160;</xsl:text>
				</td>
			</tr>
					
<!-- Ausdehung - simple-->
<!--			<tr>
				<td colspan="2" class="text" bgcolor="#E1E2E3" valign="TOP">
					<b>
						<xsl:value-of select="string($label/element[@name='gmd:extent']/label)"/>
					</b>
				</td>
			</tr>
			<tr>
				<td colspan="2" class="text" bgcolor="#ffffff">
					<iframe  frameborder="no" scrolling="no" width="725" height="400" align="center" style="border-width: 0px; border-style: solid; margin:0; padding:0;">
							<xsl:attribute name="src">
								<xsl:text>http://www.stadtplan.bs.ch/geoviewer/index.php?instance=mashup_simple&amp;wgs84=</xsl:text>
								<xsl:value-of select="gmd:identificationInfo/che:CHE_MD_DataIdentification/gmd:extent/gmd:EX_Extent/gmd:geographicElement/gmd:EX_BoundingPolygon/gmd:polygon/gml:MultiSurface/gml:surfaceMember/gml:Polygon/gml:exterior/gml:LinearRing/gml:posList"/>
							</xsl:attribute>
						<p>Ihr Browser erfüllt die notwendigen Mindestanforderungen für diese Appikation nicht.</p>
					</iframe>
					<br/>
				</td>
			</tr>
			<tr>
				<td colspan="2" class="text" valign="TOP">
					<xsl:text disable-output-escaping="no">&#160;</xsl:text>
				</td>
			</tr>-->

<!-- Kontakt für die Ressource (Titel) -->
<!--			<tr>
				<td colspan="2" class="text" bgcolor="#E1E2E3" valign="TOP">
					<b>
						<xsl:value-of select="string($label/element[@name='gmd:pointOfContact']/label)"/>
					</b>
				</td>
			</tr>
			-->
<!-- Adresse Eigentuemer - extended-->
	<!--		<tr>
				<td class="text" width="30%" bgcolor="#E1E2E3" valign="TOP">
					<b>
						<xsl:call-template name="codelist">
							<xsl:with-param name="code" select="gmd:identificationInfo/che:CHE_MD_DataIdentification/gmd:pointOfContact/che:CHE_CI_ResponsibleParty/gmd:role/gmd:CI_RoleCode/@codeListValue"/>
							<xsl:with-param name="path" select="string('gmd:CI_RoleCode')"/>
						</xsl:call-template>
					</b>	
				</td>
				<td bgcolor="#ffffff" valign="TOP">
					<xsl:value-of select="gmd:identificationInfo/che:CHE_MD_DataIdentification/gmd:pointOfContact/che:CHE_CI_ResponsibleParty/gmd:organisationName/gmd:PT_FreeText/gmd:textGroup/gmd:LocalisedCharacterString"/>
					<br/>
					<xsl:value-of select="gmd:identificationInfo/che:CHE_MD_DataIdentification/gmd:pointOfContact/che:CHE_CI_ResponsibleParty/gmd:positionName/gmd:PT_FreeText/gmd:textGroup/gmd:LocalisedCharacterString"/>
					<br/>
					<xsl:value-of select="gmd:identificationInfo/che:CHE_MD_DataIdentification/gmd:pointOfContact/che:CHE_CI_ResponsibleParty/che:individualFirstName/gco:CharacterString"/>
					<br/>
					<xsl:value-of select="gmd:identificationInfo/che:CHE_MD_DataIdentification/gmd:pointOfContact/che:CHE_CI_ResponsibleParty/che:individualLastName/gco:CharacterString"/>
					<br/>
					<xsl:value-of select="gmd:identificationInfo/che:CHE_MD_DataIdentification/gmd:pointOfContact/che:CHE_CI_ResponsibleParty/gmd:contactInfo/gmd:CI_Contact/gmd:address/che:CHE_CI_Address/che:streetName/gco:CharacterString"/>
					<xsl:text disable-output-escaping="no">&#160;</xsl:text>
					<xsl:value-of select="gmd:identificationInfo/che:CHE_MD_DataIdentification/gmd:pointOfContact/che:CHE_CI_ResponsibleParty/gmd:contactInfo/gmd:CI_Contact/gmd:address/che:CHE_CI_Address/che:streetNumber/gco:CharacterString"/>
					<br/>
					<xsl:value-of select="gmd:identificationInfo/che:CHE_MD_DataIdentification/gmd:pointOfContact/che:CHE_CI_ResponsibleParty/gmd:contactInfo/gmd:CI_Contact/gmd:address/che:CHE_CI_Address/che:postBox/gco:CharacterString"/>
					<br/>
					<xsl:value-of select="gmd:identificationInfo/che:CHE_MD_DataIdentification/gmd:pointOfContact/che:CHE_CI_ResponsibleParty/gmd:contactInfo/gmd:CI_Contact/gmd:address/che:CHE_CI_Address/gmd:country/gco:CharacterString"/>
					<xsl:text disable-output-escaping="no">&#160;&#45;&#160;</xsl:text>
					<xsl:value-of select="gmd:identificationInfo/che:CHE_MD_DataIdentification/gmd:pointOfContact/che:CHE_CI_ResponsibleParty/gmd:contactInfo/gmd:CI_Contact/gmd:address/che:CHE_CI_Address/gmd:postalCode/gco:CharacterString"/>
					<xsl:text disable-output-escaping="no">&#160;</xsl:text>
					<xsl:value-of select="gmd:identificationInfo/che:CHE_MD_DataIdentification/gmd:pointOfContact/che:CHE_CI_ResponsibleParty/gmd:contactInfo/gmd:CI_Contact/gmd:address/che:CHE_CI_Address/gmd:city/gco:CharacterString"/>
					<br/>
					<xsl:text disable-output-escaping="no">Tel&#160;</xsl:text>
					<xsl:value-of select="gmd:identificationInfo/che:CHE_MD_DataIdentification/gmd:pointOfContact/che:CHE_CI_ResponsibleParty/gmd:contactInfo/gmd:CI_Contact/gmd:phone/che:CHE_CI_Telephone/gmd:voice/gco:CharacterString"/>
					<br/>
					<xsl:text disable-output-escaping="no">Fax&#160;</xsl:text>
					<xsl:value-of select="gmd:identificationInfo/che:CHE_MD_DataIdentification/gmd:pointOfContact/che:CHE_CI_ResponsibleParty/gmd:contactInfo/gmd:CI_Contact/gmd:phone/che:CHE_CI_Telephone/gmd:facsimile/gco:CharacterString"/>
					<br/>
					<a href="mailto:{gmd:identificationInfo/che:CHE_MD_DataIdentification/gmd:pointOfContact/che:CHE_CI_ResponsibleParty/gmd:contactInfo/gmd:CI_Contact/gmd:address/che:CHE_CI_Address/gmd:electronicMailAddress/gco:CharacterString}">
						<xsl:value-of select="gmd:identificationInfo/che:CHE_MD_DataIdentification/gmd:pointOfContact/che:CHE_CI_ResponsibleParty/gmd:contactInfo/gmd:CI_Contact/gmd:address/che:CHE_CI_Address/gmd:electronicMailAddress/gco:CharacterString"/>
					</a>
					<br/>
					<a href="{gmd:identificationInfo/che:CHE_MD_DataIdentification/gmd:pointOfContact/che:CHE_CI_ResponsibleParty/gmd:contactInfo/gmd:CI_Contact/gmd:onlineResource/gmd:CI_OnlineResource/gmd:linkage/che:PT_FreeURL/che:URLGroup/che:LocalisedURL/text()}" target="_new">
						<xsl:value-of select="gmd:identificationInfo/che:CHE_MD_DataIdentification/gmd:pointOfContact/che:CHE_CI_ResponsibleParty/gmd:contactInfo/gmd:CI_Contact/gmd:onlineResource/gmd:CI_OnlineResource/gmd:linkage/che:PT_FreeURL/che:URLGroup/che:LocalisedURL/text()"/>
					</a>
					<br/>
					<xsl:value-of select="gmd:identificationInfo/che:CHE_MD_DataIdentification/gmd:pointOfContact/che:CHE_CI_ResponsibleParty/gmd:contactInfo/gmd:CI_Contact/gmd:hoursOfService/gco:CharacterString"/>
					<br/><br/>
				</td>
			</tr>
			<tr>
				<td colspan="2" class="text" valign="TOP">
					<xsl:text disable-output-escaping="no">&#160;</xsl:text>
				</td>
			</tr>
-->
<!-- Basisinformation - full-->
			<tr>
				<td colspan="2" class="text" bgcolor="#E1E2E3" valign="TOP">
					<b>
						<xsl:value-of select="string($label/element[@name='gmd:identificationInfo']/label)"/>
					</b>
				</td>
			</tr>
<!-- URI - full-->
			<tr>
				<td class="text" width="30%" bgcolor="#E1E2E3" valign="TOP">
					<b>
						<xsl:value-of select="string($label/element[@name='gmd:dataSetURI']/label)"/>
					</b>
				</td>
				<td bgcolor="#ffffff" valign="TOP">
					<xsl:if test="contains(gmd:dataSetURI/gco:CharacterString, '.')">
						<a href="{gmd:dataSetURI/gco:CharacterString}" target="_new">Lien</a>
					</xsl:if>
					<!--<xsl:choose>
						<xsl:when test="gmd:dataSetURI/gco:CharacterString">
							<a href="{gmd:dataSetURI/gco:CharacterString}" target="_new">Lien</a>
						</xsl:when>
						<xsl:otherwise>
							<xsl:text disable-output-escaping="no"></xsl:text>
						</xsl:otherwise>
					</xsl:choose>-->
				</td>
			</tr>	
			
<!-- Hirarchieebene - full-->
<!--			<tr>
				<td class="text" width="30%" bgcolor="#E1E2E3" valign="TOP">
					<b>
						<xsl:value-of select="string($label/element[@name='gmd:hierarchyLevel']/label)"/>
					</b>
				</td>
				<td bgcolor="#ffffff" valign="TOP">
					<xsl:call-template name="codelist">
						<xsl:with-param name="code" select="gmd:hierarchyLevel/gmd:MD_ScopeCode/@codeListValue"/>
						<xsl:with-param name="path" select="string('gmd:MD_ScopeCode')"/>
					</xsl:call-template>
				</td>
			</tr> -->
			
	<!-- Adresse Autor - full-->
			<tr>
				<td class="text" width="30%" bgcolor="#E1E2E3" valign="TOP">
					<b>
						<xsl:call-template name="codelist">
						<xsl:with-param name="code" select="gmd:identificationInfo/che:CHE_MD_DataIdentification/gmd:citation/gmd:CI_Citation/gmd:citedResponsibleParty/che:CHE_CI_ResponsibleParty/gmd:role/gmd:CI_RoleCode/@codeListValue"/>
						<xsl:with-param name="path" select="string('gmd:CI_RoleCode')"/>
						</xsl:call-template>
					</b>
				</td>
				<td bgcolor="#ffffff" valign="TOP">
					<xsl:if test="contains(gmd:identificationInfo/che:CHE_MD_DataIdentification/gmd:citation/gmd:CI_Citation/gmd:citedResponsibleParty/che:CHE_CI_ResponsibleParty/gmd:organisationName/gmd:PT_FreeText/gmd:textGroup/gmd:LocalisedCharacterString[@locale='#FR'], 'Canton du Valais')">
						<xsl:text disable-output-escaping="no">Canton du Valais</xsl:text>
					</xsl:if>
					<xsl:if test="not(contains(gmd:identificationInfo/che:CHE_MD_DataIdentification/gmd:citation/gmd:CI_Citation/gmd:citedResponsibleParty/che:CHE_CI_ResponsibleParty/gmd:organisationName/gmd:PT_FreeText/gmd:textGroup/gmd:LocalisedCharacterString[@locale='#FR'], 'Canton du Valais'))">
						<xsl:value-of select="gmd:identificationInfo/che:CHE_MD_DataIdentification/gmd:citation/gmd:CI_Citation/gmd:citedResponsibleParty/che:CHE_CI_ResponsibleParty/gmd:organisationName/gmd:PT_FreeText/gmd:textGroup/gmd:LocalisedCharacterString[@locale='#FR']"/>
					</xsl:if>
					<br/>
					<xsl:value-of select="gmd:identificationInfo/che:CHE_MD_DataIdentification/gmd:citation/gmd:CI_Citation/gmd:citedResponsibleParty/che:CHE_CI_ResponsibleParty/che:organisationAcronym/gmd:PT_FreeText/gmd:textGroup/gmd:LocalisedCharacterString[@locale='#FR']"/>
					<br/>
					<xsl:value-of select="gmd:identificationInfo/che:CHE_MD_DataIdentification/gmd:citation/gmd:CI_Citation/gmd:citedResponsibleParty/che:CHE_CI_ResponsibleParty/gmd:positionName/gmd:PT_FreeText/gmd:textGroup/gmd:LocalisedCharacterString[@locale='#FR']"/>
					<br/><br/>
					<xsl:value-of select="gmd:identificationInfo/che:CHE_MD_DataIdentification/gmd:citation/gmd:CI_Citation/gmd:citedResponsibleParty/che:CHE_CI_ResponsibleParty/gmd:contactInfo/gmd:CI_Contact/gmd:address/che:CHE_CI_Address/che:streetName/gco:CharacterString"/>
					<xsl:text disable-output-escaping="no">&#160;</xsl:text>
					<xsl:value-of select="gmd:identificationInfo/che:CHE_MD_DataIdentification/gmd:citation/gmd:CI_Citation/gmd:citedResponsibleParty/che:CHE_CI_ResponsibleParty/gmd:contactInfo/gmd:CI_Contact/gmd:address/che:CHE_CI_Address/che:streetNumber/gco:CharacterString"/>
					<br/>
					<xsl:value-of select="gmd:identificationInfo/che:CHE_MD_DataIdentification/gmd:citation/gmd:CI_Citation/gmd:citedResponsibleParty/che:CHE_CI_ResponsibleParty/gmd:contactInfo/gmd:CI_Contact/gmd:address/che:CHE_CI_Address/gmd:postalCode/gco:CharacterString"/>
					<xsl:text disable-output-escaping="no">&#160;</xsl:text>
					<xsl:value-of select="gmd:identificationInfo/che:CHE_MD_DataIdentification/gmd:citation/gmd:CI_Citation/gmd:citedResponsibleParty/che:CHE_CI_ResponsibleParty/gmd:contactInfo/gmd:CI_Contact/gmd:address/che:CHE_CI_Address/gmd:city/gco:CharacterString"/>
					<br/>
					<xsl:text disable-output-escaping="no">Tél&#160;</xsl:text>
					<xsl:value-of select="gmd:identificationInfo/che:CHE_MD_DataIdentification/gmd:citation/gmd:CI_Citation/gmd:citedResponsibleParty/che:CHE_CI_ResponsibleParty/gmd:contactInfo/gmd:CI_Contact/gmd:phone/che:CHE_CI_Telephone/gmd:voice/gco:CharacterString"/>
					<br/>
					<a href="mailto:{gmd:identificationInfo/che:CHE_MD_DataIdentification/gmd:citation/gmd:CI_Citation/gmd:citedResponsibleParty/che:CHE_CI_ResponsibleParty/gmd:contactInfo/gmd:CI_Contact/gmd:address/che:CHE_CI_Address/gmd:electronicMailAddress/gco:CharacterString}">
						<xsl:value-of select="gmd:identificationInfo/che:CHE_MD_DataIdentification/gmd:citation/gmd:CI_Citation/gmd:citedResponsibleParty/che:CHE_CI_ResponsibleParty/gmd:contactInfo/gmd:CI_Contact/gmd:address/che:CHE_CI_Address/gmd:electronicMailAddress/gco:CharacterString"/>
					</a>
					<br/>
					<a href="{gmd:identificationInfo/che:CHE_MD_DataIdentification/gmd:citation/gmd:CI_Citation/gmd:citedResponsibleParty/che:CHE_CI_ResponsibleParty/gmd:contactInfo/gmd:CI_Contact/gmd:onlineResource/gmd:CI_OnlineResource/gmd:linkage/che:PT_FreeURL/che:URLGroup/che:LocalisedURL[@locale='#FR']}" target="_new">
						<xsl:value-of select="gmd:identificationInfo/che:CHE_MD_DataIdentification/gmd:citation/gmd:CI_Citation/gmd:citedResponsibleParty/che:CHE_CI_ResponsibleParty/gmd:contactInfo/gmd:CI_Contact/gmd:onlineResource/gmd:CI_OnlineResource/gmd:linkage/che:PT_FreeURL/che:URLGroup/che:LocalisedURL[@locale='#FR']"/>
					</a>
					<br/><br/>
				</td>
			</tr>
	<!-- Thematik - full-->
	<!-- Thematik kann nur in English dargestellt werden -> Anfrage bei KOGIS läuft -->
			<tr>
				<td class="text" width="30%" bgcolor="#E1E2E3" valign="TOP">
					<b>
						<xsl:value-of select="string($label/element[@name='gmd:MD_TopicCategoryCode']/label)"/>
					</b>
				</td>
				<td bgcolor="#ffffff" valign="TOP">
					<!--<xsl:value-of select="string($value/codelist[@name='gmd:MD_TopicCategoryCode']/entry[code = 'gmd:identificationInfo/che:CHE_MD_DataIdentification/gmd:topicCategory/gmd:MD_TopicCategoryCode/@codeListValue']/label)"/>
					-->
					<ul type="circle">
						<xsl:for-each select="gmd:identificationInfo/che:CHE_MD_DataIdentification/gmd:topicCategory">
							<xsl:if test="not(gmd:MD_TopicCategoryCode = 'imageryBaseMapsEarthCover' or gmd:MD_TopicCategoryCode = 'planningCadastre' or gmd:MD_TopicCategoryCode = 'geoscientificInformation' or gmd:MD_TopicCategoryCode = 'environment' or gmd:MD_TopicCategoryCode = 'utilitiesCommunication')">
							<li>
								<xsl:choose>
									<xsl:when test="gmd:MD_TopicCategoryCode = 'imageryBaseMapsEarthCover_BaseMaps' ">A1 Cartes de référence, modèles du territoire</xsl:when>
									<xsl:when test="gmd:MD_TopicCategoryCode = 'imageryBaseMapsEarthCover_EarthCover' ">A2 Couverture et utilisation du sol</xsl:when>
									<xsl:when test="gmd:MD_TopicCategoryCode = 'imageryBaseMapsEarthCover_Imagery' ">A3 Images aériennes et satellitaires</xsl:when>
									<xsl:when test="gmd:MD_TopicCategoryCode = 'location' ">B Localisation, systèmes de référence</xsl:when>
									<xsl:when test="gmd:MD_TopicCategoryCode = 'elevation' ">C Altimétrie</xsl:when>
									<xsl:when test="gmd:MD_TopicCategoryCode = 'boundaries' ">D Limites politiques et administratives</xsl:when>
									<xsl:when test="gmd:MD_TopicCategoryCode = 'planningCadastre_Planning' ">E1 Dévéloppement territorial</xsl:when>
									<xsl:when test="gmd:MD_TopicCategoryCode = 'planningCadastre_Cadastre' ">E2 Cadastre foncier</xsl:when>
									<xsl:when test="gmd:MD_TopicCategoryCode = 'geoscientificInformation_Geology' ">F1 Géologie</xsl:when>
									<xsl:when test="gmd:MD_TopicCategoryCode = 'geoscientificInformation_Soils' ">F2 Sols</xsl:when>
									<xsl:when test="gmd:MD_TopicCategoryCode = 'geoscientificInformation_NaturalHazards' ">F3 Dangers naturels</xsl:when>
									<xsl:when test="gmd:MD_TopicCategoryCode = 'biota' ">G Forêt, flore, faune</xsl:when>
									<xsl:when test="gmd:MD_TopicCategoryCode = 'oceans' ">H Océans</xsl:when>
									<xsl:when test="gmd:MD_TopicCategoryCode = 'inlandWaters' ">I Hydrographie</xsl:when>
									<xsl:when test="gmd:MD_TopicCategoryCode = 'climatologyMeteorologyAtmosphere' ">K Atmosphère, climatologie</xsl:when>
									<xsl:when test="gmd:MD_TopicCategoryCode = 'environment_EnvironmentalProtection' ">L1 Protection de l'environnement, bruit</xsl:when>
									<xsl:when test="gmd:MD_TopicCategoryCode = 'environment_NatureProtection' ">L2 Protection de la nature et du paysage</xsl:when>
									<xsl:when test="gmd:MD_TopicCategoryCode = 'society' ">M Population, Société, culture</xsl:when>
									<xsl:when test="gmd:MD_TopicCategoryCode = 'health' ">N Santé</xsl:when>
									<xsl:when test="gmd:MD_TopicCategoryCode = 'structure' ">O Edifices, infrastructures, ouvrages</xsl:when>
									<xsl:when test="gmd:MD_TopicCategoryCode = 'transportation' ">P Transport</xsl:when>
									<xsl:when test="gmd:MD_TopicCategoryCode = 'utilitiesCommunication_Energy' ">Q1 Energie</xsl:when>
									<xsl:when test="gmd:MD_TopicCategoryCode = 'utilitiesCommunication_Utilities' ">Q2 Systèmes des eaux et des déchets</xsl:when>
									<xsl:when test="gmd:MD_TopicCategoryCode = 'utilitiesCommunication_Communication' ">Q3 Communication</xsl:when>
									<xsl:when test="gmd:MD_TopicCategoryCode = 'intelligenceMilitary' ">R Armée, sécurité</xsl:when>
									<xsl:when test="gmd:MD_TopicCategoryCode = 'farming' ">S Agriculture</xsl:when>
									<xsl:when test="gmd:MD_TopicCategoryCode = 'economy' ">T Activités économiques</xsl:when>
									<!--<xsl:otherwise>Sous-thème:</xsl:otherwise> -->
								</xsl:choose>
								<!-- <xsl:value-of select="gmd:MD_TopicCategoryCode"/> -->
							</li>
							</xsl:if>
						</xsl:for-each>
					</ul>
				</td>
				<!--
				<td bgcolor="#ffffff" valign="TOP">
					<xsl:call-template name="codelist">
					  <xsl:with-param name="code" select="gmd:identificationInfo/che:CHE_MD_DataIdentification/gmd:topicCategory/gmd:MD_TopicCategoryCode/@codeListValue"/>
					  <xsl:with-param name="path" select="string('gmd:MD_TopicCategoryCode')"/>
					</xsl:call-template>
				</td>-->
			</tr>
	<!-- Schlüsselwörter - full-->
			<tr>
				<td class="text" width="30%" bgcolor="#E1E2E3" valign="TOP">
					<b>
						<xsl:value-of select="string($label/element[@name='gmd:keyword']/label)"/>
					</b>
				</td>
				<td bgcolor="#ffffff" valign="TOP">
					<ul type="circle">
						<xsl:for-each select="gmd:identificationInfo/che:CHE_MD_DataIdentification/gmd:descriptiveKeywords">
							<xsl:for-each select="gmd:MD_Keywords/gmd:keyword">
									<li><xsl:value-of select="gmd:PT_FreeText/gmd:textGroup/gmd:LocalisedCharacterString[@locale='#FR']"/></li>
								</xsl:for-each>
						</xsl:for-each>
					</ul>
				</td>
			</tr>
	
<!-- Räumliche Darstellung-->
<!--			<tr>
				<td colspan="2" class="text" bgcolor="#E1E2E3" valign="TOP">
					<b>
						<xsl:value-of select="string($label/element[@name='gmd:spatialRepresentationInfo']/label)"/>
					</b>
				</td>
			</tr>-->
	<!-- Räumliche Darstellungsart - full-->
			<tr>
				<td class="text" width="30%" bgcolor="#E1E2E3" valign="TOP">
					<b>
						<xsl:value-of select="string($label/element[@name='gmd:spatialRepresentationType']/label)"/>
					</b>
				</td>
				<td bgcolor="#ffffff" valign="TOP">
					<xsl:call-template name="codelist">
					  <xsl:with-param name="code" select="gmd:identificationInfo/che:CHE_MD_DataIdentification/gmd:spatialRepresentationType/gmd:MD_SpatialRepresentationTypeCode/@codeListValue"/>
					  <xsl:with-param name="path" select="string('gmd:MD_SpatialRepresentationTypeCode')"/>
					</xsl:call-template>
				</td>
			</tr>  
<!-- Anzahl Objekte - full-->
			<tr>
				<td class="text" width="30%" bgcolor="#E1E2E3" valign="TOP">
					<b>
						<xsl:value-of select="string($label/element[@name='gmd:MD_GeometricObjects']/label)"/>
					</b>
				</td>
				<td bgcolor="#ffffff" valign="TOP">
					<ul type="circle">
						<xsl:for-each select="gmd:spatialRepresentationInfo/gmd:MD_VectorSpatialRepresentation/gmd:geometricObjects/gmd:MD_GeometricObjects">
							<li><xsl:call-template name="codelist">
									<xsl:with-param name="code" select="gmd:geometricObjectType/gmd:MD_GeometricObjectTypeCode/@codeListValue"/>
									<xsl:with-param name="path" select="string('gmd:MD_GeometricObjectTypeCode')"/>
								</xsl:call-template><xsl:text disable-output-escaping="no">:&#160;</xsl:text>
								<xsl:value-of select="gmd:geometricObjectCount/gco:Integer"/></li>
						</xsl:for-each>
					</ul>
				</td>
			</tr>
	<!-- Masstabszahl - full-->
			<tr>
				<td class="text" width="30%" bgcolor="#E1E2E3" valign="TOP">
					<b>
						<xsl:value-of select="string($label/element[@name='gmd:denominator']/label)"/><xsl:text disable-output-escaping="no">&#160;&#160;&#160;1:</xsl:text>
					</b>
				</td>
				<td bgcolor="#ffffff" valign="TOP">
					<table border="0" cellpadding="4" cellspacing="2" style="font-family: Verdana, Arial, Helvetica, sans-serif;font-size: 12px; font-style: normal; color: #000000; text-decoration: none">
						<tr><td bgcolor="#ffffff" valign="TOP" width="30%"><xsl:value-of select="gmd:identificationInfo/che:CHE_MD_DataIdentification/gmd:spatialResolution/gmd:MD_Resolution/gmd:equivalentScale/gmd:MD_RepresentativeFraction/gmd:denominator/gco:Integer"/>
							</td>
							<td class="text" width="50%" bgcolor="#E1E2E3" valign="TOP">
							ou pour raster: <b><xsl:value-of select="string($label/element[@name='gmd:distance']/label)"/></b>
							</td>
							<td bgcolor="#ffffff" valign="TOP">
								<xsl:value-of select="gmd:identificationInfo/che:CHE_MD_DataIdentification/gmd:spatialResolution/gmd:MD_Resolution/gmd:distance/gco:Distance"/>
							</td>
						</tr>
					</table>
				</td>
				
			</tr>
	<!-- Referenzsystem - full-->
			<tr>
				<td class="text" width="30%" bgcolor="#E1E2E3" valign="TOP">
					<b>
						<xsl:text disable-output-escaping="no">Système de référence</xsl:text>
					</b>
				</td>
				<td bgcolor="#ffffff" valign="TOP">
					<xsl:value-of select="gmd:referenceSystemInfo/gmd:MD_ReferenceSystem/gmd:referenceSystemIdentifier/gmd:RS_Identifier/gmd:code/gmd:PT_FreeText/gmd:textGroup/gmd:LocalisedCharacterString[@locale='#FR']"/>
					<xsl:text disable-output-escaping="no">&#160;(</xsl:text>
					<xsl:value-of select="gmd:referenceSystemInfo/gmd:MD_ReferenceSystem/gmd:referenceSystemIdentifier/gmd:RS_Identifier/gmd:codeSpace/gco:CharacterString"/>
					<xsl:text disable-output-escaping="no">)</xsl:text>
				</td>
			</tr>
			<tr>
				<td colspan="2" class="text" valign="TOP">
					<xsl:text disable-output-escaping="no">&#160;</xsl:text>
				</td>
			</tr>
<!-- Datenqualität-->
			<tr>
				<td colspan="2" class="text" bgcolor="#E1E2E3" valign="TOP">
					<b>
						<xsl:value-of select="string($label/element[@name='gmd:dataQualityInfo']/label)"/>
					</b>
				</td>
			</tr>
<!-- Erläuterung - full-->
			<tr>
				<td class="text" width="30%" bgcolor="#E1E2E3" valign="TOP">
					<b>
						<xsl:value-of select="string($label/element[@name='gmd:LI_Lineage']/label)"/>
					</b>
				</td>
				<td bgcolor="#ffffff" valign="TOP">
					<xsl:value-of select="gmd:dataQualityInfo/gmd:DQ_DataQuality/gmd:lineage/gmd:LI_Lineage/gmd:statement/gmd:PT_FreeText/gmd:textGroup/gmd:LocalisedCharacterString[@locale='#FR']"/>
				</td>
			</tr>	
<!-- Datenquelle - full-->
			<tr>
				<td class="text" width="30%" bgcolor="#E1E2E3" valign="TOP">
					<b>
						<xsl:value-of select="string($label/element[@name='gmd:LI_Source']/label)"/>
					</b>
				</td>
				<td bgcolor="#ffffff" valign="TOP">
					<xsl:value-of select="gmd:dataQualityInfo/gmd:DQ_DataQuality/gmd:lineage/gmd:LI_Lineage/gmd:source/gmd:LI_Source/gmd:description/gmd:PT_FreeText/gmd:textGroup/gmd:LocalisedCharacterString[@locale='#FR']"/>
				</td>
			</tr>
<!-- Système de coordonnées source - full-->
			<xsl:if test="contains(gmd:dataQualityInfo/gmd:DQ_DataQuality/gmd:lineage/gmd:LI_Lineage/gmd:source/gmd:LI_Source/gmd:sourceReferenceSystem/gmd:MD_ReferenceSystem/gmd:referenceSystemIdentifier/gmd:RS_Identifier/gmd:code/gmd:PT_FreeText/gmd:textGroup/gmd:LocalisedCharacterString[@locale='#FR'], 'CH')">
				<tr>
					<td class="text" width="30%" bgcolor="#E1E2E3" valign="TOP">
						<b>
							<xsl:text disable-output-escaping="no">Système de référence source</xsl:text>
						</b>
					</td>
					<td bgcolor="#ffffff" valign="TOP">
						<xsl:value-of select="gmd:dataQualityInfo/gmd:DQ_DataQuality/gmd:lineage/gmd:LI_Lineage/gmd:source/gmd:LI_Source/gmd:sourceReferenceSystem/gmd:MD_ReferenceSystem/gmd:referenceSystemIdentifier/gmd:RS_Identifier/gmd:code/gmd:PT_FreeText/gmd:textGroup/gmd:LocalisedCharacterString[@locale='#FR']"/>
					</td>
				</tr>		
			</xsl:if>			
			<tr>
				<td colspan="2" class="text" valign="TOP">
					<xsl:text disable-output-escaping="no">&#160;</xsl:text>
				</td>
			</tr>
<!-- Einschränkungen - full-->
			<tr>
				<td colspan="2" class="text" bgcolor="#E1E2E3" valign="TOP">
					<b>
						<xsl:value-of select="string($label/element[@name='gmd:resourceConstraints']/label)"/>
					</b>
				</td>
			</tr>
<!-- Ressourceneinschränkungen - full-->
			<tr>
				<td class="text" width="30%" bgcolor="#E1E2E3" valign="TOP">
					<b>
						<xsl:value-of select="string($label/element[@name='gmd:useLimitation']/label)"/>
					</b>
				</td>
				<td bgcolor="#ffffff" valign="TOP">
					<xsl:value-of select="gmd:identificationInfo/che:CHE_MD_DataIdentification/gmd:resourceConstraints/gmd:MD_Constraints/gmd:useLimitation/gmd:PT_FreeText/gmd:textGroup/gmd:LocalisedCharacterString[@locale='#FR']"/>	
				</td>
			</tr>
	<!-- Rechtliche Einschränkungen - full-->
			<tr>
				<td class="text" width="30%" bgcolor="#E1E2E3" valign="TOP">
					<b>
						<xsl:value-of select="string($label/element[@name='gmd:otherConstraints']/label)"/>
					</b>
				</td>
				<td bgcolor="#ffffff" valign="TOP">
					<ul type="circle">
						<xsl:for-each select="gmd:identificationInfo/che:CHE_MD_DataIdentification/gmd:resourceConstraints/che:CHE_MD_LegalConstraints/gmd:otherConstraints">
							<li><xsl:value-of select="gmd:PT_FreeText/gmd:textGroup/gmd:LocalisedCharacterString[@locale='#FR']"/></li>
						</xsl:for-each>
					</ul>
				</td>
			</tr>
						<tr>
				<td colspan="2" class="text" valign="TOP">
					<xsl:text disable-output-escaping="no">&#160;</xsl:text>
				</td>
			</tr>
<!-- Gesetzgebung-->
			<tr>
				<td colspan="2" class="text" bgcolor="#E1E2E3" valign="TOP">
					<b>
						<xsl:text disable-output-escaping="no">Référence(s) légale(s)</xsl:text>
					</b>
				</td>
			</tr>
<!-- Title-->
			<tr>
				<td class="text" width="30%" bgcolor="#E1E2E3" valign="TOP">
					<b>
						<xsl:text disable-output-escaping="no">Liste</xsl:text>
					</b>
				</td>
				<td bgcolor="#ffffff" valign="TOP">
					<xsl:value-of select="che:legislationInformation/che:CHE_MD_Legislation/che:title/gmd:CI_Citation/gmd:title/gmd:PT_FreeText/gmd:textGroup/gmd:LocalisedCharacterString[@locale='#FR']"/>
				</td>
			</tr>
			<tr>
				<td colspan="2" class="text" valign="TOP">
					<xsl:text disable-output-escaping="no">&#160;</xsl:text>
				</td>
			</tr>
<!-- Überarbeitung-->
			<tr>
				<td colspan="2" class="text" bgcolor="#E1E2E3" valign="TOP">
					<b>
						<xsl:value-of select="string($label/element[@name='gmd:resourceMaintenance']/label)"/>
					</b>
				</td>
			</tr>
	<!-- Überarbeitungsinterval - full-->
			<tr>
				<td class="text" width="30%" bgcolor="#E1E2E3" valign="TOP">
					<b>
						<xsl:value-of select="string($label/element[@name='gmd:maintenanceAndUpdateFrequency']/label)"/>
					</b>
				</td>
				<td bgcolor="#ffffff" valign="TOP">
					<xsl:call-template name="codelist">
						<xsl:with-param name="code" select="gmd:identificationInfo/che:CHE_MD_DataIdentification/gmd:resourceMaintenance/che:CHE_MD_MaintenanceInformation/gmd:maintenanceAndUpdateFrequency/gmd:MD_MaintenanceFrequencyCode/@codeListValue"/>
						<xsl:with-param name="path" select="string('gmd:MD_MaintenanceFrequencyCode')"/>
					</xsl:call-template>
				</td>
			</tr>
	<!-- Überarbeitungsbemerkung - full-->
			<tr>
				<td class="text" width="30%" bgcolor="#E1E2E3" valign="TOP">
					<b>
						<xsl:value-of select="string($label/element[@name='gmd:maintenanceNote']/label)"/>
					</b>
				</td>
				<td bgcolor="#ffffff" valign="TOP">
					<xsl:value-of select="gmd:identificationInfo/che:CHE_MD_DataIdentification/gmd:resourceMaintenance/che:CHE_MD_MaintenanceInformation/gmd:maintenanceNote/gmd:PT_FreeText/gmd:textGroup/gmd:LocalisedCharacterString[@locale='#FR']"/>
				</td>
			</tr>
			<tr>
				<td colspan="2" class="text" valign="TOP">
					<xsl:text disable-output-escaping="no">&#160;</xsl:text>
				</td>
			</tr>			
<!-- Objektkatalog-->
			<tr>
				<td colspan="2" class="text" bgcolor="#E1E2E3" valign="TOP">
					<b>
						<!--<xsl:value-of select="string($label/element[@name='gmd:featureCatalogueCitation']/label)"/>-->
						<xsl:text disable-output-escaping="no">Catalogue d'objets et modèle</xsl:text>
					</b>
				</td>
			</tr>
<!-- Objektkatalog und Model - Datum und Link-->
			<xsl:for-each select="gmd:contentInfo/che:CHE_MD_FeatureCatalogueDescription">
			<tr>
				<td class="text" width="30%" bgcolor="#E1E2E3" valign="TOP">
					<b>
						<xsl:text disable-output-escaping="no">Date de création</xsl:text>
					</b>
				</td>
				<td bgcolor="#ffffff" valign="TOP">
					<xsl:value-of select="gmd:featureCatalogueCitation/gmd:CI_Citation/gmd:date/gmd:CI_Date/gmd:date/gco:Date"/>
				</td>
			</tr>
			<tr>
				<td class="text" width="30%" bgcolor="#E1E2E3" valign="TOP">
					<b>
						<xsl:text disable-output-escaping="no">Lien</xsl:text>
					</b>
				</td>
				<td bgcolor="#ffffff" valign="TOP">
					<a href="{che:dataModel/che:PT_FreeURL/che:URLGroup/che:LocalisedURL[@locale='#FR']/text()}" target="_new">
						<xsl:value-of select="gmd:featureCatalogueCitation/gmd:CI_Citation/gmd:title/gmd:PT_FreeText/gmd:textGroup/gmd:LocalisedCharacterString[@locale='#FR']"/>
					</a>
				</td>
			</tr>
			</xsl:for-each>	
			<tr>
				<td colspan="2" class="text" valign="TOP">
					<xsl:text disable-output-escaping="no">&#160;</xsl:text>
				</td>
			</tr>
            		
<!-- Darstellungskatalog-->
			<tr>
				<td colspan="2" class="text" bgcolor="#E1E2E3" valign="TOP">
					<b>
						<xsl:value-of select="string($label/element[@name='gmd:portrayalCatalogueInfo']/label)"/>
					</b>
				</td>
			</tr>
<!-- Darstellungskatalog - Datum und Link-->
			<xsl:if test="contains(gmd:portrayalCatalogueInfo/che:CHE_MD_PortrayalCatalogueReference/gmd:portrayalCatalogueCitation/gmd:CI_Citation/gmd:title/gmd:PT_FreeText/gmd:textGroup/gmd:LocalisedCharacterString[@locale='#FR'], 'e')">
			<tr>
				<td class="text" width="30%" bgcolor="#E1E2E3" valign="TOP">
					<b>
						<xsl:text disable-output-escaping="no">Date de création</xsl:text>
					</b>
				</td>
				<td bgcolor="#ffffff" valign="TOP">
					<xsl:value-of select="gmd:portrayalCatalogueInfo/che:CHE_MD_PortrayalCatalogueReference/gmd:portrayalCatalogueCitation/gmd:CI_Citation/gmd:date/gmd:CI_Date/gmd:date/gco:Date"/>
				</td>
			</tr>
			<tr>
				<td class="text" width="30%" bgcolor="#E1E2E3" valign="TOP">
					<b>
						<xsl:text disable-output-escaping="no">Lien</xsl:text>
					</b>
				</td>
				<td bgcolor="#ffffff" valign="TOP">
					<a href="{gmd:portrayalCatalogueInfo/che:CHE_MD_PortrayalCatalogueReference/che:portrayalCatalogueURL/che:PT_FreeURL/che:URLGroup/che:LocalisedURL[@locale='#FR']/text()}" target="_new">
						<xsl:value-of select="gmd:portrayalCatalogueInfo/che:CHE_MD_PortrayalCatalogueReference/gmd:portrayalCatalogueCitation/gmd:CI_Citation/gmd:title/gmd:PT_FreeText/gmd:textGroup/gmd:LocalisedCharacterString[@locale='#FR']"/>
					</a>
				</td>
			</tr>
			</xsl:if>
			<tr>
				<td colspan="2" class="text" valign="TOP">
					<xsl:text disable-output-escaping="no">&#160;</xsl:text>
				</td>
			</tr>
<!-- Vertrieb-->
			<tr>
				<td colspan="2" class="text" bgcolor="#E1E2E3" valign="TOP">
					<b>
						<xsl:value-of select="string($label/element[@name='gmd:distributionInfo']/label)"/>
					</b>
				</td>
			</tr>
	<!-- Online Ressource (Internet and OpenData)- full-->		
			<xsl:for-each select="gmd:distributionInfo/gmd:MD_Distribution/gmd:transferOptions/gmd:MD_DigitalTransferOptions/gmd:onLine">
							<xsl:sort select="gmd:CI_OnlineResource/gmd:name/gmd:PT_FreeText/gmd:textGroup/gmd:LocalisedCharacterString[@locale='#FR']"/>
							<xsl:choose>
									<xsl:when test="contains(gmd:CI_OnlineResource/gmd:name/gmd:PT_FreeText/gmd:textGroup/gmd:LocalisedCharacterString[@locale='#FR'],'Géoportail')">
										<tr>
											<td class="text" width="30%" bgcolor="#E1E2E3" valign="TOP">
												<b>
												<!--<xsl:value-of select="string($label/element[@name='gmd:CI_OnlineResource']/label)"/>-->
												<xsl:text disable-output-escaping="no">Géoportal&#160;(Internet)</xsl:text>
												</b>
											</td>
											<td bgcolor="#ffffff" valign="TOP">
												<a href="{gmd:CI_OnlineResource/gmd:linkage/che:PT_FreeURL/che:URLGroup/che:LocalisedURL[@locale='#FR']}" target="_new">
												<xsl:value-of select="gmd:CI_OnlineResource/gmd:linkage/che:PT_FreeURL/che:URLGroup/che:LocalisedURL[@locale='#FR']"/>
												</a>
											</td>
										</tr>	
									</xsl:when>
									<xsl:when test="contains(gmd:CI_OnlineResource/gmd:name/gmd:PT_FreeText/gmd:textGroup/gmd:LocalisedCharacterString[@locale='#FR'],'OpenData')">
										<tr>
											<td class="text" width="30%" bgcolor="#E1E2E3" valign="TOP">
												<b>
												<xsl:text disable-output-escaping="no">OpenData Valais</xsl:text>
												</b>
											</td>
											<td colspan="2" class="text" bgcolor="#ffffff" valign="TOP">
												<a href="{gmd:CI_OnlineResource/gmd:linkage/che:PT_FreeURL/che:URLGroup/che:LocalisedURL[@locale='#FR']}" target="_new">
												<xsl:text disable-output-escaping="no">Lien</xsl:text>
												</a>
											</td>
										</tr>
									</xsl:when>
									<xsl:when test="contains(gmd:CI_OnlineResource/gmd:name/gmd:PT_FreeText/gmd:textGroup/gmd:LocalisedCharacterString[@locale='#FR'],'Landing Page')">
										
									</xsl:when>
									<xsl:when test="contains(gmd:CI_OnlineResource/gmd:description/gmd:PT_FreeText/gmd:textGroup/gmd:LocalisedCharacterString[@locale='#FR'],'(Interlis)')">
										
									</xsl:when>
									<xsl:when test="contains(gmd:CI_OnlineResource/gmd:name/gmd:PT_FreeText/gmd:textGroup/gmd:LocalisedCharacterString[@locale='#FR'],'Download')">
										
									</xsl:when>
									<xsl:otherwise>
										<tr>
											<td class="text" width="30%" bgcolor="#E1E2E3" valign="TOP">
												<b>
												<xsl:text disable-output-escaping="no">Autres liens</xsl:text>
												</b>
											</td>
											<td bgcolor="#ffffff" valign="TOP">
												<a href="{gmd:CI_OnlineResource/gmd:linkage/che:PT_FreeURL/che:URLGroup/che:LocalisedURL[@locale='#FR']}" target="_new">
												<xsl:value-of select="gmd:CI_OnlineResource/gmd:linkage/che:PT_FreeURL/che:URLGroup/che:LocalisedURL[@locale='#FR']"/>
												</a>
											</td>
										</tr>
									</xsl:otherwise>
								</xsl:choose>
			</xsl:for-each>
	<!-- Online Ressource (intern)- full-->
			<tr>
				<td class="text" width="30%" bgcolor="#E1E2E3" valign="TOP">
					<b>
						<xsl:text disable-output-escaping="no">Ressource&#160;(interne)</xsl:text>
					</b>
				</td>
				<td bgcolor="#ffffff" valign="TOP">
					<xsl:value-of select="gmd:identificationInfo/che:CHE_MD_DataIdentification/gmd:environmentDescription/gmd:PT_FreeText/gmd:textGroup/gmd:LocalisedCharacterString[@locale='#FR']"/>
				</td>
			</tr>
<!-- Code (intern)- full-->
			<tr>
				<td class="text" width="30%" bgcolor="#E1E2E3" valign="TOP">
					<b>
						<xsl:text disable-output-escaping="no">Identificateur&#160;(interne)</xsl:text>
					</b>
				</td>
				<td bgcolor="#ffffff" valign="TOP">
					<xsl:value-of select="gmd:identificationInfo/che:CHE_MD_DataIdentification/gmd:citation/gmd:CI_Citation/gmd:identifier/gmd:MD_Identifier/gmd:code/gco:CharacterString"/>
				</td>
			</tr>
	<!-- Adresse Vertrieb - full-->
			<tr>
				<td class="text" width="30%" bgcolor="#E1E2E3" valign="TOP">
					<b>
						<xsl:call-template name="codelist">
						<xsl:with-param name="code" select="gmd:distributionInfo/gmd:MD_Distribution/gmd:distributor/gmd:MD_Distributor/gmd:distributorContact/che:CHE_CI_ResponsibleParty/gmd:role/gmd:CI_RoleCode/@codeListValue"/>
						<xsl:with-param name="path" select="string('gmd:CI_RoleCode')"/>
						</xsl:call-template>
					</b>
				</td>
				<td bgcolor="#ffffff" valign="TOP">
					<xsl:text disable-output-escaping="no">Canton du Valais</xsl:text>
					<br/>
					<xsl:value-of select="gmd:distributionInfo/gmd:MD_Distribution/gmd:distributor/gmd:MD_Distributor/gmd:distributorContact/che:CHE_CI_ResponsibleParty/che:organisationAcronym/gmd:PT_FreeText/gmd:textGroup/gmd:LocalisedCharacterString[@locale='#FR']"/>
					<br/>
					<xsl:value-of select="gmd:distributionInfo/gmd:MD_Distribution/gmd:distributor/gmd:MD_Distributor/gmd:distributorContact/che:CHE_CI_ResponsibleParty/gmd:positionName/gmd:PT_FreeText/gmd:textGroup/gmd:LocalisedCharacterString[@locale='#FR']"/>
					<br/><br/>
					<xsl:value-of select="gmd:distributionInfo/gmd:MD_Distribution/gmd:distributor/gmd:MD_Distributor/gmd:distributorContact/che:CHE_CI_ResponsibleParty/gmd:contactInfo/gmd:CI_Contact/gmd:address/che:CHE_CI_Address/che:streetName/gco:CharacterString"/>
					<xsl:text disable-output-escaping="no">&#160;</xsl:text>
					<xsl:value-of select="gmd:distributionInfo/gmd:MD_Distribution/gmd:distributor/gmd:MD_Distributor/gmd:distributorContact/che:CHE_CI_ResponsibleParty/gmd:contactInfo/gmd:CI_Contact/gmd:address/che:CHE_CI_Address/che:streetNumber/gco:CharacterString"/>
					<br/>
					<xsl:value-of select="gmd:distributionInfo/gmd:MD_Distribution/gmd:distributor/gmd:MD_Distributor/gmd:distributorContact/che:CHE_CI_ResponsibleParty/gmd:contactInfo/gmd:CI_Contact/gmd:address/che:CHE_CI_Address/gmd:postalCode/gco:CharacterString"/>
					<xsl:text disable-output-escaping="no">&#160;</xsl:text>
					<xsl:value-of select="gmd:distributionInfo/gmd:MD_Distribution/gmd:distributor/gmd:MD_Distributor/gmd:distributorContact/che:CHE_CI_ResponsibleParty/gmd:contactInfo/gmd:CI_Contact/gmd:address/che:CHE_CI_Address/gmd:city/gco:CharacterString"/>
					<br/>
					<xsl:text disable-output-escaping="no">Tél&#160;</xsl:text>
					<xsl:value-of select="gmd:distributionInfo/gmd:MD_Distribution/gmd:distributor/gmd:MD_Distributor/gmd:distributorContact/che:CHE_CI_ResponsibleParty/gmd:contactInfo/gmd:CI_Contact/gmd:phone/che:CHE_CI_Telephone/gmd:voice/gco:CharacterString"/>
					<br/>
					<a href="mailto:{gmd:distributionInfo/gmd:MD_Distribution/gmd:distributor/gmd:MD_Distributor/gmd:distributorContact/che:CHE_CI_ResponsibleParty/gmd:contactInfo/gmd:CI_Contact/gmd:address/che:CHE_CI_Address/gmd:electronicMailAddress/gco:CharacterString}">
						<xsl:value-of select="gmd:distributionInfo/gmd:MD_Distribution/gmd:distributor/gmd:MD_Distributor/gmd:distributorContact/che:CHE_CI_ResponsibleParty/gmd:contactInfo/gmd:CI_Contact/gmd:address/che:CHE_CI_Address/gmd:electronicMailAddress/gco:CharacterString"/>
					</a>
					<br/>
					<a href="{gmd:distributionInfo/gmd:MD_Distribution/gmd:distributor/gmd:MD_Distributor/gmd:distributorContact/che:CHE_CI_ResponsibleParty/gmd:contactInfo/gmd:CI_Contact/gmd:onlineResource/gmd:CI_OnlineResource/gmd:linkage/che:PT_FreeURL/che:URLGroup/che:LocalisedURL}" target="_new">
						<xsl:value-of select="gmd:distributionInfo/gmd:MD_Distribution/gmd:distributor/gmd:MD_Distributor/gmd:distributorContact/che:CHE_CI_ResponsibleParty/gmd:contactInfo/gmd:CI_Contact/gmd:onlineResource/gmd:CI_OnlineResource/gmd:linkage/che:PT_FreeURL/che:URLGroup/che:LocalisedURL"/>
					</a>
					<br/><br/>
				</td>
			</tr>
	<!-- Abgabeformat - full-->
			<tr>
				<td class="text" width="30%" bgcolor="#E1E2E3" valign="TOP">
					<b>
						<xsl:value-of select="string($label/element[@name='gmd:distributionFormat']/label)"/>
					</b>
				</td>
				<td bgcolor="#ffffff" valign="TOP">
					<ul type="circle">
						<xsl:for-each select="gmd:distributionInfo/gmd:MD_Distribution/gmd:distributionFormat">
							<li><xsl:value-of select="gmd:MD_Format/gmd:name/gco:CharacterString"/><xsl:text disable-output-escaping="no">&#160;</xsl:text><xsl:value-of select="gmd:MD_Format/gmd:version/gco:CharacterString"/></li>
						</xsl:for-each>
					</ul>
				</td>
			</tr>	
			<tr>
				<td colspan="2" class="text" valign="TOP">
					<xsl:text disable-output-escaping="no">&#160;</xsl:text>
				</td>
			</tr>
<!-- Metadaten - full-->
			<tr>
				<td colspan="2" class="text" bgcolor="#E1E2E3" valign="TOP">
					<b>
						<xsl:text disable-output-escaping="no">Métadonnées</xsl:text>
					</b>
				</td>
			</tr>
	<!-- Metadatensatzidentifikator - full-->
			<tr>
				<td class="text" width="30%" bgcolor="#E1E2E3" valign="TOP">
					<b>
						<xsl:value-of select="string($label/element[@name='gmd:fileIdentifier']/label)"/>
					</b>
				</td>
				<td bgcolor="#ffffff" valign="TOP">
					<xsl:value-of select="gmd:fileIdentifier/gco:CharacterString"/>
				</td>
			</tr>
	<!-- Datum - full-->
			<tr>
				<td class="text" width="30%" bgcolor="#E1E2E3" valign="TOP">
					<b>
						<xsl:value-of select="string($label/element[@name='gmd:dateStamp']/label)"/>
					</b>
				</td>
				<td bgcolor="#ffffff" valign="TOP">
					<xsl:value-of select="gmd:dateStamp/gco:DateTime"/>

				</td>
			</tr>
	<!-- Bezeichnung des Metadatenstandards - full-->
			<tr>
				<td class="text" width="30%" bgcolor="#E1E2E3" valign="TOP">
					<b>
						<xsl:value-of select="string($label/element[@name='gmd:metadataStandardName']/label)"/>
					</b>
				</td>
				<td bgcolor="#ffffff" valign="TOP">
					<xsl:value-of select="gmd:metadataStandardName/gco:CharacterString"/>


				</td>
			</tr>
	<!-- Hirarchieebene - full-->
<!--			<tr>
				<td class="text" width="30%" bgcolor="#E1E2E3" valign="TOP">
					<b>
						<xsl:value-of select="string($label/element[@name='gmd:hierarchyLevel']/label)"/>
					</b>
				</td>
				<td bgcolor="#ffffff" valign="TOP">
					<xsl:call-template name="codelist">
						<xsl:with-param name="code" select="gmd:hierarchyLevel/gmd:MD_ScopeCode/@codeListValue"/>
						<xsl:with-param name="path" select="string('gmd:MD_ScopeCode')"/>
					</xsl:call-template>
				</td>
			</tr> -->
	<!-- Adresse Metadaten - full-->
<!--			<tr>
				<td class="text" width="30%" bgcolor="#E1E2E3" valign="TOP">
					<b>
						<xsl:call-template name="codelist">
						<xsl:with-param name="code" select="gmd:contact/che:CHE_CI_ResponsibleParty/gmd:role/gmd:CI_RoleCode/@codeListValue"/>
						<xsl:with-param name="path" select="string('gmd:CI_RoleCode')"/>
						</xsl:call-template>
					</b>
				</td>
				<td bgcolor="#ffffff" valign="TOP">
					<xsl:value-of select="gmd:contact/che:CHE_CI_ResponsibleParty/gmd:organisationName/gmd:PT_FreeText/gmd:textGroup/gmd:LocalisedCharacterString"/>
					<br/>
					<xsl:value-of select="gmd:contact/che:CHE_CI_ResponsibleParty/gmd:positionName/gmd:PT_FreeText/gmd:textGroup/gmd:LocalisedCharacterString"/>
					<br/>
					<xsl:value-of select="gmd:contact/che:CHE_CI_ResponsibleParty/che:individualFirstName/gco:CharacterString"/>
					<br/>
					<xsl:value-of select="gmd:contact/che:CHE_CI_ResponsibleParty/che:individualLastName/gco:CharacterString"/>
					<br/>
					<xsl:value-of select="gmd:contact/che:CHE_CI_ResponsibleParty/gmd:contactInfo/gmd:CI_Contact/gmd:address/che:CHE_CI_Address/che:streetName/gco:CharacterString"/>
					<xsl:text disable-output-escaping="no">&#160;</xsl:text>
					<xsl:value-of select="gmd:contact/che:CHE_CI_ResponsibleParty/gmd:contactInfo/gmd:CI_Contact/gmd:address/che:CHE_CI_Address/che:streetNumber/gco:CharacterString"/>
					<br/>
					<xsl:value-of select="gmd:contact/che:CHE_CI_ResponsibleParty/gmd:contactInfo/gmd:CI_Contact/gmd:address/che:CHE_CI_Address/che:postBox/gco:CharacterString"/>
					<br/>
					<xsl:value-of select="gmd:contact/che:CHE_CI_ResponsibleParty/gmd:contactInfo/gmd:CI_Contact/gmd:address/che:CHE_CI_Address/gmd:country/gco:CharacterString"/>
					<xsl:text disable-output-escaping="no">&#160;&#45;&#160;</xsl:text>
					<xsl:value-of select="gmd:contact/che:CHE_CI_ResponsibleParty/gmd:contactInfo/gmd:CI_Contact/gmd:address/che:CHE_CI_Address/gmd:postalCode/gco:CharacterString"/>
					<xsl:text disable-output-escaping="no">&#160;</xsl:text>
					<xsl:value-of select="gmd:contact/che:CHE_CI_ResponsibleParty/gmd:contactInfo/gmd:CI_Contact/gmd:address/che:CHE_CI_Address/gmd:city/gco:CharacterString"/>
					<br/>
					<xsl:text disable-output-escaping="no">Tel&#160;</xsl:text>
					<xsl:value-of select="gmd:contact/che:CHE_CI_ResponsibleParty/gmd:contactInfo/gmd:CI_Contact/gmd:phone/che:CHE_CI_Telephone/gmd:voice/gco:CharacterString"/>
					<br/>
					<xsl:text disable-output-escaping="no">Fax&#160;</xsl:text>
					<xsl:value-of select="gmd:contact/che:CHE_CI_ResponsibleParty/gmd:contactInfo/gmd:CI_Contact/gmd:phone/che:CHE_CI_Telephone/gmd:facsimile/gco:CharacterString"/>
					<br/>
					<a href="mailto:{gmd:contact/che:CHE_CI_ResponsibleParty/gmd:contactInfo/gmd:CI_Contact/gmd:address/che:CHE_CI_Address/gmd:electronicMailAddress/gco:CharacterString}">
						<xsl:value-of select="gmd:contact/che:CHE_CI_ResponsibleParty/gmd:contactInfo/gmd:CI_Contact/gmd:address/che:CHE_CI_Address/gmd:electronicMailAddress/gco:CharacterString"/>
					</a>
					<br/>
					<a href="{gmd:contact/che:CHE_CI_ResponsibleParty/gmd:contactInfo/gmd:CI_Contact/gmd:onlineResource/gmd:CI_OnlineResource/gmd:linkage/che:PT_FreeURL/che:URLGroup/che:LocalisedURL/text()}" target="_new">
						<xsl:value-of select="gmd:contact/che:CHE_CI_ResponsibleParty/gmd:contactInfo/gmd:CI_Contact/gmd:onlineResource/gmd:CI_OnlineResource/gmd:linkage/che:PT_FreeURL/che:URLGroup/che:LocalisedURL/text()"/>
					</a>
					<br/>
					<xsl:value-of select="gmd:contact/che:CHE_CI_ResponsibleParty/gmd:contactInfo/gmd:CI_Contact/gmd:hoursOfService/gco:CharacterString"/>
					<br/><br/>
				</td>
			</tr> -->
			<tr>
				<td colspan="2" class="text" valign="TOP">
					<xsl:text disable-output-escaping="no">&#160;</xsl:text>
				</td>
			</tr>
		</table>
	</xsl:template>
<!-- Der codelist Wert (label) wird ausgewählt wenn der Eintrag code gleich dem codeListValue vom xml ist -->
	<xsl:template name="codelist">
		<xsl:param name="code"/>
		<xsl:param name="path"/>
		<xsl:value-of select="string($value/codelist[@name= $path]/entry[code = $code]/label)"/>
	</xsl:template>
</xsl:stylesheet>