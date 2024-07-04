//@ts-check
import { DebugView, Explorer, PivotView, TableView } from "@datawheel/tesseract-explorer";
import React, { lazy } from "react";
import { createRoot } from "react-dom/client";
import "normalize.css";

document.querySelector("p#warning")?.remove();
const container = document.getElementById("app");
container && mount(container);

function mount(container) {
  const VizbuilderPanel = lazy(() => import("./vizbuilder")) ;

  const root = createRoot(container);
  root.render(
    <Explorer
      uiLocale={process.env.__UI_LOCALE__}
      dataLocale={process.env.__SERVER_LOCALE__}
      previewLimit={100}
      panels={[
        {key: "table", label: "Data Table", component: TableView},
        {key: "matrix", label: "Pivot Table", component: PivotView},
        {key: "debug", label: "Raw response", component: DebugView},
        {key: "vizbuilder", label: "Vizbuilder", component: VizbuilderPanel}
      ]}
      source={{url: process.env.__SERVER_URL__}}
      withinMantineProvider={true}
      withinReduxProvider={true}
      withPermalink={true}
    />
  );
}
