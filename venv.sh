#!/bin/sh

python3 -m venv geocat-venv
. geocat-venv/bin/activate
pip install --upgrade pip
pip install flask lxml requests weasyprint
playwright install chromium
