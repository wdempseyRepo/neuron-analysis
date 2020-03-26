% Calculating Delta F over F for analyzed timelapse for GCaMP experiments.
% CLEAR AND CLOSE section to remove all old variables and figures

% In a paper from 2008 in Nature Neuroscience, DeltaF over F is defined as 
% the following (Supplementary Methods from: Greenberg, D.S. et al. Nat 
% Neurosci 11, 749-751 (2008).):
% Denote neuron fluorescence for frame i by F(i) (note that each neuron is 
% processed separately). Define baseline fluorescence F0(i) as the mean of 
% the lowest 50% of fluorescence values measured within 10 seconds before 
% or after frame i, and [DeltaF/F0](i) = (F(i) - F0)/F0.
% So, for us, the 10 seconds will be a variable number of frames before and
% after, which we will call 'windowVal'.

clear all; close all;
%% Initialized variables
% Number of "seconds" on either side of a given frame
windowVal = 60;
fontS = 16; % Graph font size
peakThresh = 0.45; % above this value of dF/F, called a true firing event

%% Read Data
% Input column data for intensity within one or several regions of the
% brain
fName = inputdlg('Enter the filename for F/F0 Calculations.','FileName');
fName = fName{1};
% Input number of regions that were analyzed (number of columns)
numCols = inputdlg('Enter how many columns are in the file','NumColumns');
numCols = str2num(numCols{1});
% Input region labels
regionLabels = {};
for i=1:numCols
    regionLabels{i} = inputdlg(['Enter label for region ',...
        num2str(i),' (Order matters)'],'RegionNames');
end
% Input time interval between each frame
timeInt = inputdlg('Enter time between frames (sec)','FrameInterval');
timeInt = str2num(timeInt{1});

% Matrix contains intensity data in numCols columns:
% e.g., for 3 columns: Anterolateral, Medial, Posterior
dataMat = readmatrix(fName);

nFram = inputdlg('Enter how many times the an intervention was used',...
    'Number of Treatments (e.g., Light)');
nFram = str2num(nFram{1});
% Input frame numbers
inputFrams = [];
for i=1:nFram
    dummy = inputdlg(['Enter frame number for exposure',...
        num2str(i),' (Order matters)'],'Frames for Analysis');
    inputFrams(i) = str2num(dummy{1});
end

%% Calculations
% Using windowVal, determine the number of frames to look at before and
% after a given frame to get the F0 for each of those time windows; for
% this, let's use the "ceil" function to make that number the rounded up
% value so that more frames are considered.
windowFrames = ceil(windowVal/timeInt);
% Exclude the first and last windowFrames number of frames, because they
% don't have frames before or after, respectively, to consider for the
% sliding window analysis
dFOverF_mat = repmat(-100,(size(dataMat,1)-2*windowFrames-1),...
    size(dataMat,2));
tpts = zeros(size(dataMat,1)-2*windowFrames-1,1);
tpts(1)=0+windowFrames*timeInt; % Start from 0+windowFrames*timeInt
for i = 1+windowFrames:size(dataMat,1)-windowFrames-1 % number of rows
    counter = i-(windowFrames);
    %Calculate deltaF over F
    %First, sort the windowFrames # of values above and below the ith frame
        dummySortVal = sort([dataMat(i-windowFrames:i-1,:);...
            dataMat(i+1:i+windowFrames,:)],1,'ascend');
    %Second, take the mean of the lowest 50% of values
        dummyF0 = mean(dummySortVal(1:size(dummySortVal)/2,:),1);
    %Calculate deltaF over F
        dFOverF_mat(counter,:) = (dataMat(i,:)-dummyF0)./dummyF0;
        
    %Make a timepoint, starting at tpt 0+windowFrames*timeInt seconds
    if counter > 1
        tpts(counter) = tpts(counter-1)+timeInt;
    end
end
tpts = tpts/60; % Make time points in minutes for plot

peakMat = dFOverF_mat;
peakMat = peakMat.*(peakMat>peakThresh);
% If you want to set the x tick values directly, you must take into
    % consideration that the first windowVal number of seconds is cut out
    % of the plot for the moving average to work easily without if
    % statements or switch statements.
    xTickVals = inputFrams*timeInt/60;
    
% lastTpt is time in minutes when the final frame of the timelapse
    % occurs
    lastTpt = size(dataMat,1)*timeInt/60;
%% Plots
Fig1 = figure,
for i = 1:numCols
    subplot(numCols,1,i)
    plot(tpts,dFOverF_mat(:,i),'LineWidth',1.2)
    set(gca,'linewidth',2)
    g = gca;
    g.XTick = floor(xTickVals);
        hold on
    for j = 1:size(inputFrams,2)
        subplot(numCols,1,i)
        xline(xTickVals(j),...
            'r-.','LineWidth',1)
    end
    
    % Make a green solid line for the end of the timelapse (useful for
    % debugging or if you use a very long sliding window)
    subplot(numCols,1,i)
    xline(lastTpt,'g','LineWidth',3)
    
    %g.YLim = [-0.1,1.5]; % Debug, if the limit is too high
    g.YLim = [-.6,max(max(peakMat))*1.1];
    % From zero to the end of the timelapse, which happens at the same time
    % regardless of how large the sliding window is
    g.XLim = [0,lastTpt+1];
    g.FontSize = fontS;
    g.Title.String = regionLabels{i};
    g.Title.FontSize = fontS+4;
    g.FontWeight='bold';
    g.Box = 'off';
    ylabel(['\Delta','F / F']);
    xlabel('Time (min)');
end
%Fig1.OuterPosition = [140 60 1380 810] % Large version, 3 graphs
%Fig1.OuterPosition = [962 351 313 510] % Good squished version, 3 graphs
%Fig1.OuterPosition = [510 355 814 426] % If you do 3 columns, 1 row graphs
%Fig1.OuterPosition = [118 85 882 793] %for 5 cell data
%Fig1.Position = [397 54 167 437] % Partly squished 5 cell data
Fig1.OuterPosition = [397 54 329 820] % Very squished 5 cell data
Fig1.OuterPosition = [693 182 671 289]; % when there's 1 cell, squished
saveas(Fig1,[fName,'_01_DeltaFOverF.svg']);
saveas(Fig1,[fName,'_01_DeltaFOverF.png']);
%close all;

Fig2 = figure,
for i = 1:numCols
    subplot(numCols,1,i)
    plot(tpts,dataMat(1+windowFrames:size(dataMat,1)-windowFrames-1,i),...
        'LineWidth',1.2)
    set(gca,'linewidth',2)
    g = gca;
    g.XTick = floor(xTickVals);
            hold on
    for j = 1:size(inputFrams,2)
        subplot(numCols,1,i)
        xline(xTickVals(j),...
            'r-.','LineWidth',1.5)
    end
    % Make a green solid line for the end of the timelapse (useful for
    % debugging or if you use a very long sliding window)
    subplot(numCols,1,i)
    xline(lastTpt,'g','LineWidth',3)
    
    g.XLim = [0,lastTpt+1];
    g.Title.String = regionLabels{i};
    g.FontSize = fontS;
    g.FontWeight='bold';
    ylabel(['Intensity (arb.)']);
    xlabel('Time (min)');
end
%Fig2.OuterPosition = [140 60 1380 810]
%Fig2.OuterPosition = [853 276 313 510]
Fig2.OuterPosition = [397 54 139 820] % very squished 5 cell data
Fig2.OuterPosition = [693 182 671 289]; % when there's 1 cell, squished
saveas(Fig2,[fName,'_02_IntensityData.svg']);
saveas(Fig2,[fName,'_02_IntensityData.png']);
%close all;


%% Peak plot (just to see things less noisy)
Fig3 = figure,
for i = 1:numCols
    subplot(numCols,1,i)
    plot(tpts,peakMat(:,i))
    set(gca,'linewidth',2)
    g = gca;
        xTickVals = (inputFrams-...
        windowFrames)*timeInt/60;
    g.XTick = floor(xTickVals);
            hold on
    % Make a red dashed line for each intervention
    for j = 1:size(inputFrams,2)
        subplot(numCols,1,i)
        xline(xTickVals(j),...
            'r-.','LineWidth',1.5)
    end
    
    % Make a green solid line for the end of the timelapse (useful for
    % debugging or if you use a very long sliding window)
    subplot(numCols,1,i)
    xline(lastTpt,'g','LineWidth',3)
    
    g.YLim = [-.6,max(max(peakMat))*1.1];
    % From zero to the end of the timelapse, which happens at the same time
    % regardless of how large the sliding window is
    g.XLim = [0,lastTpt+1];
    g.FontSize = fontS;
    g.Title.String = regionLabels{i};
    g.Title.FontSize = fontS+4;
    g.FontWeight='bold';
    g.Box = 'off';
    ylabel(['Peaks']);
    xlabel('Time (min)');
end
%Fig3.OuterPosition = [397 54 139 820] % very squished 5 cell data
Fig3.OuterPosition = [693 182 671 289]; % when there's 1 cell, squished
saveas(Fig3,[fName,'_03_PeaksOnly_DeltaFOverF.svg']);
saveas(Fig3,[fName,'_03_PeaksOnly_DeltaFOverF.png']);

%% Peakmat plot together (just to see things less noisy)
peakMat(peakMat==0) = NaN;
Fig4 = figure,
for i = 1:numCols
    subplot(numCols,1,i)
    hold on
    plot(tpts,peakMat(:,i),'k','LineWidth',3)
    plot(tpts,dFOverF_mat(:,i),'b')
    set(gca,'linewidth',2)
    g = gca;
    g.YLim = [-.6,max(max(peakMat))*1.1];
    g.XLim = [0,ceil(max(tpts))];
        xTickVals = (inputFrams-...
        windowFrames)*timeInt/60;
    g.XTick = floor(xTickVals);
            hold on
    for j = 1:size(inputFrams,2)
        subplot(numCols,1,i)
        xline(xTickVals(j),...
            'r-.','LineWidth',1.5)
    end
    g.FontSize = fontS;
    g.Title.String = regionLabels{i};
    g.Title.FontSize = fontS+4;
    g.FontWeight='bold';
    g.Box = 'off';
    ylabel(['Peaks']);
    xlabel('Time (min)');
end
Fig4.OuterPosition = [397 54 139 820] % very squished 5 cell data
Fig4.OuterPosition = [693 182 671 289]; % when there's 1 cell, squished
saveas(Fig4,[fName,'_04_PeaksWithDeltaFOverF.svg']);
saveas(Fig4,[fName,'_04_PeaksWithDeltaFOverF.png']);
% %% Plot of subset
% % Just looking at the pre and then the second dose
% partial_dFOverF_mat = [dFOverF_mat(1:240,:);dFOverF_mat(1730:end,:)];
%     new_tpts = tpts(1:size(partial_dFOverF_mat,1));
% Fig2 = figure,
% for i = 1:numCols
%     subplot(numCols,1,i)
%     plot(new_tpts,partial_dFOverF_mat(:,i))
%     g = gca;
%     g.YLim = [-.5,2];
%     g.XLim = [0,ceil(max(new_tpts))];
%     g.Title.String = regionLabels{i};
%     ylabel(['\Delta','F / F']);
%     xlabel('Time (min)');
% end
% Fig2.OuterPosition = [140 60 1380 810]
% saveas(Fig2,'NicotineExperimentPlot_JustSecondDose.png')
% close all;