import logging.config
import os

from fastapi.responses import RedirectResponse
from logiclayer import LogicLayer
from logiclayer_complexity import EconomicComplexityModule
from tesseract_olap import OlapServer
from tesseract_olap.logiclayer import TesseractModule

from server.debug import DebugModule


# PARAMETERS ===================================================================

# These parameters are required and will prevent execution if not set
olap_backend = os.environ["TESSERACT_BACKEND"]

# These parameters are optional
olap_schema  = os.environ.get("TESSERACT_SCHEMA", "/app/server/schema")
olap_cache = os.environ.get("TESSERACT_CACHE", "")
app_debug = os.environ.get("TESSERACT_DEBUG", None)
log_filepath = os.environ.get("TESSERACT_LOGGING_CONFIG", "/app/logging.ini")
commit_hash = os.environ.get("GIT_HASH", "")

app_debug = bool(app_debug)


# LOGGING ======================================================================
# To learn how logging works in python
# - https://docs.python.org/3.7/howto/logging.html
# To learn about best practices and the logging.ini file
# - https://www.datadoghq.com/blog/python-logging-best-practices/
# - https://guicommits.com/how-to-log-in-python-like-a-pro/

logging.config.fileConfig(log_filepath, disable_existing_loggers=False)


# ASGI app =====================================================================
olap = OlapServer(backend=olap_backend, schema=olap_schema)

mod_tsrc = TesseractModule(olap)

mod_cmplx = EconomicComplexityModule(olap)

mod_debug = DebugModule()

layer = LogicLayer(debug=app_debug)

if app_debug:
    layer.add_module("/debug", mod_debug)

layer.add_module("/tesseract", mod_tsrc)
layer.add_module("/complexity", mod_cmplx)
layer.add_static("/ui", "./server/explorer/", html=True)

@layer.route("/", response_class=RedirectResponse, status_code=302)
def route_index():
    return "/ui/"
