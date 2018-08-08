function powerSpectra = powerSpectrum(timeSeries, samplingFrequency)
    
    spectra = fft(timeSeries, size(timeSeries,2), 2);
    powerSpectra = spectra.*conj(spectra)/(samplingFrequency^2);
    
end

