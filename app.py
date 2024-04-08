import logging.config
import os

from logiclayer import LogicLayer
from logiclayer_complexity import EconomicComplexityModule
from tesseract_olap import OlapServer
from tesseract_olap.logiclayer import TesseractModule
from fastapi.responses import HTMLResponse


# PARAMETERS ===================================================================
olap_backend = os.environ["TESSERACT_BACKEND"] # raise KeyError if not set
olap_schema  = os.environ["TESSERACT_SCHEMA"]
app_debug    = os.environ.get("TESSERACT_DEBUG", None)
app_host     = os.environ.get("TESSERACT_HOST", "0.0.0.0")
app_port     = os.environ.get("TESSERACT_PORT", "7777")
log_filepath = os.environ.get("TESSERACT_LOGGING_CONFIG", "logging.ini")
commit_hash  = os.environ.get("GIT_HASH", "")

# LOGGING ======================================================================
# To learn how logging works in python
# - https://docs.python.org/3.7/howto/logging.html
# To learn about best practices and the logging.ini file
# - https://www.datadoghq.com/blog/python-logging-best-practices/
# - https://guicommits.com/how-to-log-in-python-like-a-pro/
logging.config.fileConfig(log_filepath, disable_existing_loggers=False)

def route_index():
    return f"""<!doctype html>
<html lang="en">
<head><meta charset=utf-8><title>Tesseract Python API Playground</title><meta http-equiv="Refresh" content="0; url='/ui/'" /></head>
<body><h1>Tesseract Python API Playground</h1><p><a href="/ui/">DataExplorer</a></p><p style="opacity:0.5">{commit_hash}</p></body>
</html>
"""

# CLI RUNNER ===================================================================
olap = OlapServer(backend=olap_backend, schema=olap_schema)

tsrc = TesseractModule(olap)
cmplx = EconomicComplexityModule(olap)

layer = LogicLayer(debug=bool(app_debug))
layer.add_module("/tesseract", tsrc)
layer.add_module("/complexity", cmplx)
layer.add_static("/ui", "./dataexplorer/", html=True)
layer.add_route("/", route_index, response_class=HTMLResponse)
