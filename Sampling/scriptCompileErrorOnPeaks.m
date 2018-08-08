% Requires peaksData from scriptCompilePeaks

errorPeaksData = cell(numel(peaksData),1);
trueNbPeaks = peaksData{end}.nbPeaks;
trueAmplitudes = peaksData{end}.meanAmplitude;
numberOfSeries = length(peaksData{1}.nbPeaks);

for i = 1:numel(peaksData)
    