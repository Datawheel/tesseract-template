import html
import pathlib

import logiclayer as ll
from fastapi.responses import StreamingResponse


class DebugModule(ll.LogicLayerModule):
    def log_generator(self):
        yield "<!DOCTYPE html><html><body>\n<details hidden>"
        with pathlib.Path("/tmp/oec.log").open() as fp:
            for line in fp:
                escaped = html.escape(line.strip())
                if "oec.auth" in line or "tesseract_olap.server" in line:
                    yield f"</details>\n<details><summary>{escaped}</summary>"
                else:
                    yield f"<p>{escaped}</p>"
        yield "</details></body></html>"

    @ll.route("GET", "/logs")
    def route_logs(self):
        return StreamingResponse(self.log_generator())
