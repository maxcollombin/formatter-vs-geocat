#
## 

1. Create the venv by running the script `venv.sh`
2. Start the server by running `python3 server.py`
3. Access the url http://127.0.0.1:5000/geonetwork/srv/api/records/<record-uuid>/formatters/vs_simple_fr?language=fr



Téléchargement formatter

https://www.geocat.ch/geonetwork/doc/api/index.html#/formatters/getFormatterFileContent

Renseigner le nom du formatter p.ex. vs_full_fr
le schéma: iso19139.che
le nom du fichier view.xsl

Comamande curl (non fonctionnelle)

curl -X GET "https://www.geocat.ch/geonetwork/srv/api/formatters/iso19139.che/<formatter-name>/files/view.xsl" \
  -H  "accept: application/xml" \
  -H  "X-XSRF-TOKEN: <token>" \
  | xmllint --format - > <filename>.xslt


Exemple d'uuid

86e5aa5e-3afd-4506-9fe7-382911d0a64c


https://geocat-int.dev.bgdi.ch/geonetwork/srv/api/records/86e5aa5e-3afd-4506-9fe7-382911d0a64c/formatters/vs_full_fr?width=_100&language=fre&output=xml&approved=true

------------------------
Obtenir les fichiers associés au formatter

https://www.geocat.ch/geonetwork/srv/api/formatters/iso19139.che/vs_full_fr/files

Path https://www.geocat.ch/geonetwork/doc/api/index.html#/formatters/getFormatterFiles

Obtenir le contenu des fichiers

https://www.geocat.ch/geonetwork/srv/api/formatters/iso19139.che/vs_full_fr/files/view.xsl

Path : https://www.geocat.ch/geonetwork/doc/api/index.html#/formatters/getFormatterFileContent


Mise à jour du contenu du formatter:

Path https://www.geocat.ch/geonetwork/doc/api/index.html#/formatters/updateFormatterFile



url pour obtenir le contenu d'un enregistrement au format xml selon le schema iso

https://www.geocat.ch/geonetwork/srv/api/records/49981e65-1b62-4c92-ad4f-5543fabd9803/formatters/xml?approved=true

https://geocat-int.dev.bgdi.ch/geonetwork/srv/api/records/49981e65-1b62-4c92-ad4f-5543fabd9803/formatters/vs_full_fr?width=_100&language=fre&output=xml&approved=true


127.0.0.1:5000/transform/49981e65-1b62-4c92-ad4f-5543fabd9803



sudo apt install xsltproc

utilisation 

xsltproc vs_simple_fr.xslt 49981e65-1b62-4c92-ad4f-5543fabd9803.xml > output.html

Téléchargement des labels

mkdir root/schemas/iso19139
curl https://raw.githubusercontent.com/geonetwork/core-geonetwork/refs/heads/main/schemas/iso19139/src/main/plugin/iso19139/loc/fre/labels.xml -o labels.xml
curl https://raw.githubusercontent.com/geoadmin/geocat/300740f8061c53701ebc8d5e49e6c6d5ffec3b3c/schemas/iso19139/src/main/plugin/iso19139/loc/fre/codelists.xml -o codelists.xml

Tester et continuer avec 1ee33c59-6ed1-4dcb-8d19-ebba9bc92180

Les informations de distribution ne sont pas bonnes.
Tester pour le formatage d'impression


http://127.0.0.1:5000/geonetwork/srv/api/records/1ee33c59-6ed1-4dcb-8d19-ebba9bc92180/formatters/vs_simple_fr?width=_100&mdpath=md.format.pdf&output=pdf&approved=true

http://127.0.0.1:5000/geonetwork/srv/api/records/1ee33c59-6ed1-4dcb-8d19-ebba9bc92180/formatters/vs_simple_fr


Mise en page : responsive (html et pdf)
gestion de langue pour un template unique








https://www.geocat.ch/geonetwork/srv/api/records/1ee33c59-6ed1-4dcb-8d19-ebba9bc92180/formatters/xml?approved=true