from flask import Flask, Response, request, send_file
from lxml import etree
import requests
import urllib.parse
import subprocess
import tempfile
import os
import threading
import time

app = Flask(__name__)

@app.route("/geonetwork/srv/api/records/<uuid>/formatters/vs_simple_<lang>")
def transform_xml(uuid, lang):
    if lang not in ["fr", "de"]:
        return Response("Langue non supportée", status=400)
    
    # Récupérer les paramètres
    width = request.args.get('width')
    mdpath = request.args.get('mdpath')
    output = request.args.get('output')
    approved = request.args.get('approved', 'true')
    
    xml_url = f"https://www.geocat.ch/geonetwork/srv/api/records/{uuid}/formatters/xml?approved={approved}"
    xslt_file = f"vs_simple_{lang}.xslt"

    try:
        # Récupérer et transformer le XML
        response = requests.get(xml_url)
        response.raise_for_status()
        xml_content = response.content

        xml_tree = etree.fromstring(xml_content)
        xslt_tree = etree.parse(xslt_file)
        transform = etree.XSLT(xslt_tree)
        result_tree = transform(xml_tree)
        html_content = str(result_tree)

        # Si c'est une demande de PDF
        if output == 'pdf' and mdpath == 'md.format.pdf':
            # Essayer GeoCat d'abord, puis fallback vers local
            try:
                return generate_pdf_via_geocat(html_content, uuid, width)
            except Exception as e:
                print(f"GeoCat PDF failed: {e}, using local generation")
                return generate_pdf_local(html_content, uuid)
        
        return Response(html_content, mimetype="text/html")

    except Exception as e:
        return Response(f"Erreur : {e}", status=500)

def generate_pdf_via_geocat(html_content, uuid, width):
    """Utilise l'API GeoCat pour générer le PDF en envoyant ton HTML"""
    try:
        # URL corrigée
        pdf_api_url = "https://www.geocat.ch/geonetwork/srv/api/tools/pdf/html"
        
        data = {
            'html': html_content,
            'width': width or '_100',
            'filename': f'metadata_{uuid}.pdf'
        }
        
        headers = {
            'Content-Type': 'application/json',
            'Accept': 'application/pdf',
            'User-Agent': 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36',
            'Referer': 'https://www.geocat.ch/',
            'Origin': 'https://www.geocat.ch'
        }
        
        response = requests.post(pdf_api_url, json=data, headers=headers, timeout=30)
        
        if response.status_code == 200:
            return Response(
                response.content,
                mimetype='application/pdf',
                headers={
                    'Content-Disposition': f'attachment; filename=metadata_{uuid}.pdf',
                    'Content-Type': 'application/pdf'
                }
            )
        else:
            raise Exception(f"API GeoCat error: {response.status_code} - {response.text}")
            
    except Exception as e:
        raise Exception(f"Erreur génération PDF via GeoCat: {str(e)}")

def generate_pdf_local(html_content, uuid):
    """Génère le PDF localement avec wkhtmltopdf"""
    html_path = None
    pdf_path = None
    
    try:
        # Créer un fichier HTML temporaire
        with tempfile.NamedTemporaryFile(mode='w', suffix='.html', delete=False, encoding='utf-8') as html_file:
            html_file.write(html_content)
            html_path = html_file.name

        # Créer un fichier PDF temporaire
        with tempfile.NamedTemporaryFile(suffix='.pdf', delete=False) as pdf_file:
            pdf_path = pdf_file.name

        # Commande wkhtmltopdf
        cmd = [
            'wkhtmltopdf',
            '--page-size', 'A4',
            '--margin-top', '1cm',
            '--margin-bottom', '1cm',
            '--margin-left', '1cm', 
            '--margin-right', '1cm',
            '--print-media-type',
            '--enable-local-file-access',
            '--disable-smart-shrinking',
            '--encoding', 'UTF-8',
            '--quiet',
            html_path,
            pdf_path
        ]

        print(f"Commande PDF: {' '.join(cmd)}")
        result = subprocess.run(cmd, check=True, capture_output=True, text=True, timeout=30)
        
        if not os.path.exists(pdf_path) or os.path.getsize(pdf_path) == 0:
            raise Exception("Le fichier PDF n'a pas pu être généré")

        print(f"PDF généré avec succès: {pdf_path}, taille: {os.path.getsize(pdf_path)} bytes")

        return send_file(
            pdf_path, 
            as_attachment=True, 
            download_name=f'metadata_{uuid}.pdf',
            mimetype='application/pdf'
        )

    except FileNotFoundError:
        return Response("wkhtmltopdf n'est pas installé. Installez-le avec: sudo apt-get install wkhtmltopdf", status=500)
    except subprocess.TimeoutExpired:
        return Response("Timeout lors de la génération PDF", status=500)
    except subprocess.CalledProcessError as e:
        return Response(f"Erreur wkhtmltopdf: {e.stderr if e.stderr else e.stdout}", status=500)
    except Exception as e:
        return Response(f"Erreur génération PDF local: {str(e)}", status=500)
    finally:
        # Cleanup avec délai pour permettre le téléchargement
        def cleanup():
            time.sleep(2)
            try:
                if html_path and os.path.exists(html_path):
                    os.unlink(html_path)
                if pdf_path and os.path.exists(pdf_path):
                    os.unlink(pdf_path)
            except:
                pass
        
        threading.Thread(target=cleanup).start()

if __name__ == "__main__":
    app.run(debug=True, host='127.0.0.1', port=5000)