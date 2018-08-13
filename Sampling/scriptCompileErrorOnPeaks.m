% Requires peaksData from scriptCompilePeaks

%% Generating variables
nbPeaksRatio = zeros(numel(peaksData),1);
meanAmpRatio = zeros(numel(peaksData),1);
truePeaks = peaksData{end}.nbPeaks;
trueAmps = peaksData{end}.meanAmplitude;
numberOfSeries = length(peaksData{1}.nbPeaks);

%% Computing number of peaks found and mean amplitudes ratios
for i = 1:numel(peaksData)
    peaksRatios = zeros(numberOfSeries,1);
    ampRatios = zeros(numberOfSeries,1);
    for j = 1:numberOfSeries
        peaksRatios(j) = peaksData{i}.nbPeaks(j)/truePeaks(j);
        ampRatios(j) = peaksData{i}.meanAmplitude(j)/trueAmps(j);
    end
    nbPeaksRatio(i) = mean(peaksRatios);
    meanAmpRatio(i) = mean(ampRatios);
    fprintf('%d\n',i);
end

%% Displaying results
plot(1:100,nbPeaksRatio(1:100),'r')
hold on
plot(1:100,meanAmpRatio(1:100),'b')
title('Fidelity of peaks parameters at different sampling rates')
xlabel('Sampling frequency (Hz)')
ylabel('Percentage')
legend('Peaks found','Mean amplitude of peaks')
ylim([0 1.2])

%% Clearing variables
clear ampRatios peaksRatios trueAmps truePeaks i j numberOfSeries


    