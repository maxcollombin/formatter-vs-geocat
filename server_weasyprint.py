from flask import Flask, Response, request, send_file
from lxml import etree
import requests
import tempfile
import os
import threading
import time
import re

app = Flask(__name__)

def generate_pdf_playwright(html_content, uuid):
    """Génère le PDF avec Playwright (même rendu que GeoCat/navigateur)"""
    try:
        from playwright.sync_api import sync_playwright
        
        with sync_playwright() as p:
            # Utiliser Chromium (même moteur que les navigateurs modernes)
            browser = p.chromium.launch(headless=True)
            page = browser.new_page()

            # Force l’utilisation des styles @media print
            page.emulate_media(media="print")

            # Configurer la page pour l'impression
            page.set_viewport_size({"width": 1200, "height": 800})
            
            # Charger le HTML
            page.set_content(html_content, wait_until="networkidle")
            
            # Attendre que toutes les ressources soient chargées
            page.wait_for_load_state('networkidle')
            
            # Attendre un peu plus pour les polices et images
            page.wait_for_timeout(1000)
            
            # Générer le PDF avec les mêmes paramètres que GeoCat
            pdf_bytes = page.pdf(
                format='A4',
                margin={
                    'top': '1cm',
                    'bottom': '1cm', 
                    'left': '1cm',
                    'right': '1cm'
                },
                print_background=True,  # Important pour les couleurs de fond
                prefer_css_page_size=True,
                display_header_footer=False
            )
            
            browser.close()
            
            # Sauvegarder le PDF
            with tempfile.NamedTemporaryFile(suffix='.pdf', delete=False) as pdf_file:
                pdf_file.write(pdf_bytes)
                pdf_path = pdf_file.name
            
            if not os.path.exists(pdf_path) or os.path.getsize(pdf_path) == 0:
                raise Exception("Le fichier PDF n'a pas pu être généré avec Playwright")

            print(f"PDF généré avec Playwright: {pdf_path}, taille: {os.path.getsize(pdf_path)} bytes")
            
            return send_file(pdf_path, as_attachment=True, download_name=f'metadata_{uuid}.pdf', mimetype='application/pdf')
            
    except ImportError:
        # Fallback vers WeasyPrint si Playwright n'est pas installé
        print("Playwright non disponible, utilisation de WeasyPrint...")
        return generate_pdf_weasyprint(html_content, uuid)
    except Exception as e:
        # Fallback vers WeasyPrint en cas d'erreur
        print(f"Erreur Playwright: {e}, fallback vers WeasyPrint...")
        return generate_pdf_weasyprint(html_content, uuid)
    finally:
        # Cleanup
        def cleanup():
            time.sleep(2)
            try:
                if 'pdf_path' in locals() and os.path.exists(pdf_path):
                    os.unlink(pdf_path)
            except:
                pass
        
        threading.Thread(target=cleanup).start()

def generate_pdf_weasyprint(html_content, uuid):
    """WeasyPrint simplifié - le CSS dans le XSLT gère tout"""
    try:
        import weasyprint
        
        # Modifier le CSS pour que WeasyPrint l'applique correctement
        css_optimized_html = html_content.replace(
            '@media print,',
            '@media all,'
        )
        
        with tempfile.NamedTemporaryFile(suffix='.pdf', delete=False) as pdf_file:
            pdf_path = pdf_file.name

        # Générer avec WeasyPrint - utiliser la variable corrigée
        html_doc = weasyprint.HTML(string=css_optimized_html)
        html_doc.write_pdf(pdf_path)
        
        if not os.path.exists(pdf_path) or os.path.getsize(pdf_path) == 0:
            raise Exception("Le fichier PDF n'a pas pu être généré avec WeasyPrint")

        print(f"PDF généré avec WeasyPrint: {pdf_path}, taille: {os.path.getsize(pdf_path)} bytes")

        return send_file(pdf_path, as_attachment=True, download_name=f'metadata_{uuid}.pdf', mimetype='application/pdf')

    except Exception as e:
        return Response(f"Erreur WeasyPrint: {str(e)}", status=500)
    finally:
        def cleanup():
            time.sleep(2)
            try:
                if 'pdf_path' in locals() and os.path.exists(pdf_path):
                    os.unlink(pdf_path)
            except:
                pass
        threading.Thread(target=cleanup).start()

@app.route("/geonetwork/srv/api/records/<uuid>/formatters/vs_<formatter_type>_<lang>")
def transform_xml(uuid, formatter_type, lang):
    if lang not in ["fr", "de"]:
        return Response("Langue non supportée", status=400)
    if formatter_type not in ["simple","full"]:
        return Response("Type de formatteur non supporté", status=400)
    # Récupérer les paramètres
    width = request.args.get('width')
    mdpath = request.args.get('mdpath')
    output = request.args.get('output')
    approved = request.args.get('approved', 'true')
    debug_html = request.args.get('debug_html')
    
    xml_url = f"https://www.geocat.ch/geonetwork/srv/api/records/{uuid}/formatters/xml?approved={approved}"
    xslt_file = f"vs_{formatter_type}_{lang}.xslt"
    try:
        # Récupérer et transformer le XML
        response = requests.get(xml_url)
        response.raise_for_status()
        xml_content = response.content

        xml_tree = etree.fromstring(xml_content)
        xslt_tree = etree.parse(xslt_file)
        transform = etree.XSLT(xslt_tree)

        # Déterminer le format de sortie et passer le paramètre au XSLT
        is_pdf_request = output == 'pdf' and mdpath == 'md.format.pdf'

        if is_pdf_request:
            # Passer le paramètre 'pdf' au XSLT pour activer les styles PDF
            result_tree = transform(xml_tree, output_format=etree.XSLT.strparam('pdf'))
        else:
            # Mode normal (HTML)
            result_tree = transform(xml_tree, output_format=etree.XSLT.strparam('html'))

        html_content = str(result_tree)

        # Si c'est une demande de PDF
        if is_pdf_request:
            # Mode debug : retourner le HTML au lieu du PDF
            if debug_html:
                return Response(html_content, mimetype="text/html")
            
            # Essayer Playwright d'abord (le plus proche de GeoCat)
            return generate_pdf_playwright(html_content, uuid)

        return Response(html_content, mimetype="text/html")

    except Exception as e:
        return Response(f"Erreur : {e}", status=500)

@app.route("/health", methods=['GET'])
def health_check():
    """Endpoint pour vérifier que le service fonctionne"""
    return {"status": "ok", "service": "Playwright/WeasyPrint PDF Generator"}

if __name__ == "__main__":
    print("Test HTML: http://127.0.0.1:5000/geonetwork/srv/api/records/UUID/formatters/vs_simple_fr")
    print("Test PDF: http://127.0.0.1:5000/geonetwork/srv/api/records/UUID/formatters/vs_simple_fr?width=_100&mdpath=md.format.pdf&output=pdf&approved=true")
    app.run(debug=True, host='127.0.0.1', port=5000)