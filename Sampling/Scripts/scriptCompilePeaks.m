% Requires samplingData from scriptCompileCalciumSamples

%% Generating variables
peaksData = cell(numel(samplingData),1);
numberOfSeries = size(samplingData{1}.samples,1);

%% Finding number of peaks detected and mean amplitude for each series
for i = 1:numel(samplingData) % For each sampling rate
    data.nbPeaks = zeros(numberOfSeries,1);
    data.times = cell(numberOfSeries,1);
    data.meanAmplitude = zeros(numberOfSeries,1);
    for j = 1:numberOfSeries % For each series
        [peaks, data.indices{j}] = findpeaks(samplingData{i}.samples(j,:));
        data.meanAmplitude(j) = mean(peaks);
        data.nbPeaks(j) = length(peaks);
    end
    peaksData{i} = data;
    fprintf('%d\n',i);
end

%% Cleaning workspace
clear i j numberOfSeries peaks data
