# GeoNetwork Formatter Demo
## Setup and Usage

1. Create the virtual environment by running the script `venv.sh`
2. Start the server by running `python3 server.py` or `python3 server_weasyprint.py`(for testing the [pdf output](http://127.0.0.1:5000/geonetwork/srv/api/records/<record-uuid>/formatters/vs_simple_fr?width=_100&mdpath=md.format.pdf&output=pdf&approved=true))
3. Access the formatter at: [http://127.0.0.1:5000/geonetwork/srv/api/records/<record-uuid>/formatters/vs_simple_fr?language=fr](http://127.0.0.1:5000/geonetwork/srv/api/records/<record-uuid>/formatters/vs_simple_fr?language=fr)

## Notes
- Replace `<record-uuid>` with the actual UUID of your metadata record
