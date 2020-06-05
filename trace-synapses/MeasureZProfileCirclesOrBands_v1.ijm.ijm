//Just trying to measure the mean intensity inside the circles
roiManager("Show All");
// Measure Channel 1 Data
for (i=0; i<roiManager("count"); i++) {
	
	fpath = "/Users/preclude/Desktop/tmp/"; // Please fill this in for your particular needs
	
    roiManager("select", i);
    getSelectionBounds(x, y, width, height);
    run("Plot Z-axis Profile");
    xpoints = newArray ();
    ypoints = newArray ();
    Plot.getValues (xpoints, ypoints);

    run ("Clear Results");
    for (j = 0; j < xpoints.length; j++) {
      setResult ("x", j, xpoints[j]);
      setResult ("y", j, ypoints[j]);
    }
    updateResults ();
    saveAs("Results_"+i, "/Users/preclude/Desktop/tmp/Results_"+i+".csv");
    close();
  }

