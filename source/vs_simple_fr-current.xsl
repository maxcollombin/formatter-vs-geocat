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
												<!-- Testumgebung  <xsl:text>https://geocat-int.dev.bgdi.ch/geonetwork/srv/fre/md.format.html?xsl=vs_simple_fr&amp;uuid=</xsl:text> -->
												<!-- Produktivumgebung-->  <xsl:text>https://www.geocat.ch/geonetwork/srv/api/records/</xsl:text> 
												<xsl:value-of select="gmd:fileIdentifier/gco:CharacterString"/>
												<xsl:text>/formatters/vs_simple_de?language=ger</xsl:text>
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
													<td valign="top" height="26" align="left" width="725" style="font-family:Verdana, Arial, Helvetica, sans-serif; font-size: 20px;font-style:normal; font-weight:normal; color:#FFFFFF; text-decoration:none; line-height:26px">Catalogue métadonnées - Simple</td> 		
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
																<!--<tr>
																	<td colspan="2" class="textl">
																		<b>Details zum ausgewählten digitalen Datensatz</b>
																	</td>
																</tr>-->
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
					</img>-->
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
<!-- Datum "Aktualisierung" - extended-->
<!--			<tr>
				<td width="30%" bgcolor="#E1E2E3" valign="TOP">
					<b>
						<xsl:text disable-output-escaping="no">Aktualisierungsdatum</xsl:text>
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
			<tr>
				<td colspan="2" class="text" valign="TOP">
					<xsl:text disable-output-escaping="no">&#160;</xsl:text>
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
			<tr>
				<td colspan="2" class="text" valign="TOP">
					<xsl:text disable-output-escaping="no">&#160;</xsl:text>
				</td>
			</tr>
<!-- Basisinformation - full-->
			<tr>
				<td colspan="2" class="text" bgcolor="#E1E2E3" valign="TOP">
					<b>
						<xsl:value-of select="string($label/element[@name='gmd:identificationInfo']/label)"/>
					</b>
				</td>
			</tr>
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
