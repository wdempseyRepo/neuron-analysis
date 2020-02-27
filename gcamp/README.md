# Using the scripts 

These are the steps to use each script.

## Contents

### DeltaFOverF.m

1. Download an .lsm file of interest from the "Synapse Mapping/Zebrafish/2020GCaMPExperiments" dropbox folder.
2. Open .lsm file in fiji
3. In the menu bar, go to Plugins->LSM Toolbox->Show LSM Toolbox
4. In the LSM Toolbox window, click "Show Infos" button
5. Click the second button on top of the "General File Information" window (an "i" surrounded by a blue circle). This has the metadata recorded by the user ("LSM Notes"). Typically, it will say whether there were any interventions (e.g., flashes with a light) and what frame they occurred at. Record the frames where interventions occurred in a text file.
6. Close the "LSM Notes" window.
7. Click the fourth button on top of the "General File Information" window (looks like a green plus sign). In the "Image acquisition properties" window, click the "Carl Zeiss" tab under the "LSM File Information" subheader. Record the value in the list called "TimeIntervall" --> This is the number of seconds it takes to acquire a frame (seconds/frame).
8. Close the "Image acquisition properties" window. 
9. Close the "General File information" window.
10. Using the rectangular selection or polygonal selection tool in the toolbar of fiji, draw a selection around an area that you care about (e.g., a neuropil area in the anterolateral pallium, a single cell of interest you'd like to follow, etc.)
11. Press the "t" key to add the region you've selected to the ROI manager.
12. Save the ROI in the "ROI Manager" window by clicking More...->Save.
13. Repeat steps 10-12 for as many regions as you would like.
14. In the ROI manager, click any of the saved regions.
15. In the menu bar, select Image->Stacks->Plot Z-axis Profile. This will print out an average intensity within the selected area for each frame of the movie.
16. Press the "save" button to save the profile as a .csv file.
17. Repeat steps 14-16 for however many selections that you would like.
18. Create a new .xlsx file. Record the file path to this directory. Let's call this "yourFile.xlsx" for simplicity.
19. Open any of the saved .csv files from before. Copy the "Y" column data (just the numbers, not the first row entry, which is just the character "Y") into the first column of "yourFile.xlsx".
20. Repeat step 19 for as many areas as you would like, adding in the data column by column into "yourFile.xlsx" (the second ROI data goes into column 2 of "yourFile.xlsx", the third ROI data goes into column 3 of "yourFile.xlsx", etc).
21. Save the .xlsx file that you made, in the directory that you recorded previously.
22. In Matlab, open "DeltaFOverF.m"
23. To run the first subsection ("CLEAR AND CLOSE"), click within this subsection and then click the button "Run and Advance" in the top toolbar to clear all previous variables and figures.
24. Click the "Run and Advance" button for the second section "Initialize variables".
  - Note: Before running step 24, if you would like, feel free to adjust the initialized variables, in case you want to 
	  1. adjust the sliding window for the deltaF/F calculation ("windowVal", which is in seconds)
	  2. adjust the font size of the graphs ("fontS" which is in pixel font size)
	  3. adjust what you want to consider a true peak for an active cell ("peakThresh", which is in arbitrary units)
25. Click the "Run and Advance" button for the third section "Read Data"
26. A little input dialog window will come up and ask for your input.
27. Input the filename + path for "yourFile.xlsx"
28. Input the number of columns that you added to "yourFile.xlsx" (corresponds to the different regions that you selected in the actual image of interest).
29. After you add in the number of columns, that number of input dialogs will come up so that you can title each column (e.g., Cell 1, Cell 2, Cell 3, etc.). This corresponds to the region of interests that you saved previously in step 12.
30. Type in the time per frame that you recorded before (in seconds per frame) for step 7.
31. Type in the number of interventions that were made, which was recorded in step 5.
32. Type in the frame number for each of the interventions, in order (e.g., if the first intervention was made at frame 100, type "100" and click "Ok"; then, if the second was at frame 150, type "150" and click "Okay).
  - Note that this will make it so a red vertical line appears whenever an intervention takes place
33. Click the "Run and Advance" button for the third section "Calculations"
34. The next three sections are interchangeable and can be clicked depending on what you want to show.
    1. If you just want to show the deltaF/F plot and the original intensity data plot, run the "Plot" subsection
    2. If you want to plot just the "peaks" to see them more clearly without noise, run "Peak Plot" subsection
    3. If you want to see the peaks on top of the deltaF/F plot data in bold black coloring, run the "Peakmat plot together" subsection
35. Save any of the graphs as .fig files if you want to adjust them later or just as .png files.

###
