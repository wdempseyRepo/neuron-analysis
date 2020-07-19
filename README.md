# neuron-analysis
These are neuron analysis scripts made during my time in the Arnold lab at USC that are currently not affiliated to a particular manuscript.

## Contents

### Scripts

Scripts in the gcamp/ folder. These scripts are used to analyze GCaMP intensity fluctuations over time.

1. DeltaFOverF.m is a Matlab script (tested in Matlab 2019a) that plots mean/median intensity fluctuations over time in a desired region of interest (or multiple regions of interest). The script plots intensity as well as deltaF/F measurements (which smooth the intensity plot and allow for easier understanding of true fluctuations in the data). One must input a .csv with intensity information (e.g., intensity in a given 2D region of interest for a given optical section or for a 3D blob for a given volume) over time (each row in a column is a new timepoint) as well as the time interval per frame.

2. DeltaFOverF.ipynb is a Jupyter notebook (tested using Python 3.7) that generates a large dataframe for intensity and DeltaF/F0 fluctuations over time in a desired region of interest (or multiple regions of interest). This is a translated and updated/upgraded version of the DeltaFOverF.m script that is more versatile.

Scripts in the trace-synapses/ folder. These macros are used to analyze individual images in FIJI.

1. MeasureCirclesOrBands_v1.ijm.ijm and the associated MakeBands_v1.ijm.ijm and MakeCircles_v1.ijm.ijm files are FIJI macros (tested in FIJI version 2.0.0-rc-49/1.51a). These macros allow one to use the "multipoint" tool in FIJI to select the approximate centers of synapses in a given image and then calculate their mean/median intensity ("circles" around the center) versus the local background intensity ("bands" around the center circles). The resulting intensity measurements are only for a single optical section, so if using volume images, one must be aware to try to choose the center of a given synapse (or make multiple circle measurements in the depth dimension in order to characterize the entire synapse).

2. Renaming-csv-list-of-files.ipynb is a script that changes filenames in a particular folder in bulk, usually to add a prefix or suffix to the file. This
is especially useful for renaming files generated from FIJI with the trace-synapses macros so that prefixes (e.g., "Fish-XX_") can be added to each of the
output "Results_X.csv" files so that they can be brought into a single folder to be read by DeltaFOverF.ipynb, for example.

## Help and Contact

Please direct comments to the [project issue tracker](https://github.com/wdempseyRepo/postdoc-scripts/issues) section.

## License

neuron-analysis is made available as open source under the MIT License. See the [LICENSE](https://github.com/wdempseyRepo/neuron-analysis/blob/master/LICENSE) file for more information.
