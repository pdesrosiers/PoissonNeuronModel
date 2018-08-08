% Requires samplingData from scriptCompileCalciumSamples

peaksData = cell(numel(samplingData),1);
numberOfSeries = size(samplingData{1}.samples,1);

for i = 1:numel(samplingData)
    data.nbPeaks = zeros(numberOfSeries,1);
    data.meanAmplitude = zeros(numberOfSeries,1);
    for j = 1:numberOfSeries
        peaks = findpeaks(samplingData{i}.samples(j,:));
        data.meanAmplitude(j) = mean(peaks);
        data.nbPeaks(j) = length(peaks);
    end
    peaksData{i} = data;
end