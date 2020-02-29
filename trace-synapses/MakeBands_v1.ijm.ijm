//get coordinates from multipoint selection
getSelectionCoordinates(xpoints, ypoints);
//Make sure ROI manager has nothing inside
roiManager("Delete");
//Make circles of a defined radius
rad=4;
for (i=0; i<lengthOf(xpoints);i++){
	makeOval(xpoints[i]-rad,ypoints[i]-rad,2*rad,2*rad);
	run("Make Band...", "band=.00024");
	roiManager("Add");
}