from flask import Flask, Response
from lxml import etree
import requests

app = Flask(__name__)

@app.route("/geonetwork/srv/api/records/<uuid>/formatters/vs_simple_fr")
def transform_xml(uuid):
    xml_url = f"https://www.geocat.ch/geonetwork/srv/api/records/{uuid}/formatters/xml?approved=true"
    xslt_file = "example.xslt"

    try:
        # Récupérer le fichier XML depuis GeoCat
        response = requests.get(xml_url)
        response.raise_for_status()
        xml_content = response.content

        # Charger le contenu XML
        xml_tree = etree.fromstring(xml_content)

        # Charger le fichier XSLT
        xslt_tree = etree.parse(xslt_file)
        transform = etree.XSLT(xslt_tree)

        # Appliquer la transformation
        result_tree = transform(xml_tree)

        # Retourner le résultat HTML
        return Response(str(result_tree), mimetype="text/html")

    except Exception as e:
        return Response(f"Erreur : {e}", status=500)

if __name__ == "__main__":
    app.run(debug=True)