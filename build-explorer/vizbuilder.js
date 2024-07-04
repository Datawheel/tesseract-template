import {createVizbuilderView} from "@datawheel/tesseract-vizbuilder";

export default createVizbuilderView({
    chartTypes: ["barchart", "barchartyear", "lineplot", "stacked", "treemap", "geomap", "donut"],
    downloadFormats: ["svg", "png"],
    showConfidenceInt: false
});
