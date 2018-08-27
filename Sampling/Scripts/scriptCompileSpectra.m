% Requires samplingData from scriptCompileCalciumSamples

%% Getting spectra 

spectrumData = cell(101,1);
for i = 1:100
    spectrumData{i}.spectra = powerSpectrum(samplingData{i}.samples, i);
    spectrumData{i}.mean = mean(spectrumData{i}.spectra);
    spectrumData{i}.freq = (0:size(spectrumData{i}.spectra,2)-1)/parameters.totalTime;
    fprintf('%d\n',i);
end
spectrumData{101}.spectra = powerSpectrum(samplingData{101}.samples, 1000);
spectrumData{101}.mean = mean(spectrumData{101}.spectra);
spectrumData{101}.freq = (0:size(spectrumData{101}.spectra,2)-1)/parameters.totalTime;

%% Cleaning workspace
clear i