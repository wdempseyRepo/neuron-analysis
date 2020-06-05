# Using the scripts 

These are the steps to use each script.

## Contents

### MeasureCirclesOrBands_v1.ijm.ijm

These are FIJI macros for tracing a circle and a band around a given selected synapse (or syanpses) and measuring intensity.

If you only have one image file and want to select e.g., synapses from their surrounding dark background to subtract out the background:
1. In [FIJI](https://fiji.sc) (tested on version 2.0.0-rc-49/1.51a), use the multiple selection tool to select as many synapses as you want.
2. Use the “ROI manager” to save these selections (for mac it is command+“t”, but maybe for windows it is control+“t”)?
3. Click the new selection you have made and SAVE it as something meaningful in the folder containing your data.
4. Make sure the selection is indeed selected (highlighted in the ROI manager window).
5. Make sure “set measurements” has average (or median) intensity selected.
6. Run MakeCircles_v1.ijm.ijm (adjust the radius for your circles, if you wish).
7. Run MeasureCirclesOrBands_v1.ijm.ijm
8. Save the measurements for average (or median) intensity -> this is a measure of Synapse intensity.
9. “Delete” ROIs with the ROI manager (click “delete” twice).
10. “Open” the selection that you saved in your folder using ROI manager.
11. Run MakeBands_v1.ijm.ijm (Make sure the radius is the same as for MakeCircles_v1.ijm.ijm).
12. Run MeasureCirclesOrBands_v1.ijm.ijm. 
13. Save the measurements for average (or median) intensity -> this is a measure of Background intensity.
14. Do background correction (either subtract the average or divide by the average) for normalization.

If you have a time series (e.g., fluorescence data from genetically encoded calcium/voltage indicators) and you would like to pull out a z profile of intensity information from a series of cells.
1. In [FIJI](https://fiji.sc) (tested on version 2.0.0-rc-49/1.51a), use the multiple selection tool to select as many cells as you want.
2. Use the “ROI manager” to save these selections (for mac it is command+“t”, but maybe for windows it is control+“t”)?
3. Click the new selection you have made and SAVE it as something meaningful in the folder containing your data.
4. Make sure the selection is indeed selected (highlighted in the ROI manager window).
5. Make sure “set measurements” has average (or median) intensity selected.
6. Make sure the radius sizes in each of the following .ijm.ijm files are consistent.
6. Run MakeCircles_v1.ijm.ijm or MakeBands_v1.ijm.ijm (adjust the radius of the circles or bands, if you wish, but make sure they are consistent with the analysis macro coming next).
7. Change the fpath variable in MeasureZProfileCirclesOrBands_v1.ijm.ijm to reflect the correct path for where you want the data to be exported for that particular time lapse.
8. Run MeasureZProfileCirclesOrBands_v1.ijm.ijm.
9. A set of .csv files will be generated (one for every cell that you select with the multiple selection tool), and they will be generated with titles of the same numerical order as the ROIs themselves. Use these in conjunction with deltaFOverF0.ipynb, or a comparable program that extracts information from intensity traces.