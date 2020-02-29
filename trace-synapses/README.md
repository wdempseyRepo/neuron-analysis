# Using the scripts 

These are the steps to use each script.

## Contents

### MeasureCirclesOrBands_v1.ijm.ijm

These are FIJI macros for tracing a circle and a band around a given selected synapse (or syanpses) and measuring intensity.

1. In [FIJI](https://fiji.sc) (tested on version 2.0.0-rc-49/1.51a), use the multiple selection tool to select as many synapses as you want
2. Use the “ROI manager” to save these selections (for mac it is command+“t”, but maybe for windows it is control+“t”)?
3. Click the new selection you have made and SAVE it as something meaningful in the folder containing your data
4. Make sure the selection is indeed selected (highlighted in the ROI manager window)
5. Make sure “set measurements” has average (or median) intensity selected
6. Run MakeCircles_v1.ijm.ijm (adjust the radius for your circles, if you wish)
7. Run MeasureCirclesOrBands_v1.ijm.ijm
8. Save the measurements for average (or median) intensity à Synapse intensity
9. “Delete” ROIs with the ROI manager (click “delete” twice)
10. “Open” the selection that you saved in your folder using ROI manager
11. Run MakeBands_v1.ijm.ijm (Make sure the radius is the same as for MakeCircles_v1.ijm.ijm)
12. Run MeasureCirclesOrBands_v1.ijm.ijm
13. Save the measurements for average (or median) intensity à Background intensity
14. Do background correction (either subtract the average or divide by the average) for normalization
