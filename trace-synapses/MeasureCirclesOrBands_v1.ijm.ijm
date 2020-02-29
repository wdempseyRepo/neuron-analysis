//Just trying to measure the mean intensity inside the circles
roiManager("Show All");
// Measure Channel 1 Data
for (i=0; i<roiManager("count"); i++) {
    roiManager("select", i);
    getSelectionBounds(x, y, width, height);
    roiManager("Measure");
  }

